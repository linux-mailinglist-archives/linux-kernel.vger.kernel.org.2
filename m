Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17B343B94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCVITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCVITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:19:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5d8ySi9+qVcosRwVuTXdEkEUS72LcFWk9oyOxmmFZU=; b=rd2Yu/jGisNM8KLxURd6fmmZNb
        +AfSN64qo4k/36IlEOGdmsMTKqk4liXVjFOesN/gc6Bwji7WS4hGCu/JDttr4OFVVfeqKYdHxDu2A
        3QJhRa5vxzOQf+qtSn0M9jyk00ScBmTou3y/o1iBa33yWivxbOGe8xNGFkjd7p29nwj9KSTd4TTPy
        zRsFhVm0tndDxAxdt9mJ+g/e+U2TWExM29K+VBzEEwT5P672u75fdIldXoRUlzF4rR1NkgDlS+FH/
        5GgV3DbsBzsNzDsbJGU6eHvrIRTaaJ9r6KuKh+QMjGR1W8m3CoAXhJw0PUen9+oa1YPBvVSU+qusy
        hH7MsU2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFl8-008CLk-2X; Mon, 22 Mar 2021 08:18:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E86630377D;
        Mon, 22 Mar 2021 09:17:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 485D42CE3912F; Mon, 22 Mar 2021 09:17:57 +0100 (CET)
Date:   Mon, 22 Mar 2021 09:17:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] x86/alternatives: Optimize optimize_nops()
Message-ID: <YFhStWee0OrxBn5F@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.520075106@infradead.org>
 <20210321120647.GB14446@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321120647.GB14446@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 01:06:47PM +0100, Borislav Petkov wrote:

> I think I've made this simpler; pasting the whole function and not the
> diff because former is easier to read:

You've make it only replace a single stream of NOPs. Which is probably
fine, but... :-)

So mine, while a little more complicated, will replace any number of NOP
streams in any location. Saves having to worry about if we missed some
stupid corner case somewhere.

Anyway, I think I got it slightly wrong.. How's this one?

---

static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
{
	int nops = 0, i = 0;
	bool done = false;
	struct insn insn;
	u8 *nop = NULL;

	do {
		if (insn_decode_kernel(&insn, &instr[i]))
			return;

		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
			nops++;
		else if (nops)
			nop = &instr[i - nops];

		if (i + insn.length >= a->instrlen) {
			nop = &instr[i - nops];
			done = true;
		}

		if (nop) {
			unsigned long flags;

			local_irq_save(flags);
			add_nops(nop, nops);
			local_irq_restore(flags);

			DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
				   instr, (int)(unsigned long)(nop-instr), nops);

			nops = 0;
			nop = NULL;
		}

		i += insn.length;

	} while (!done);

	WARN_ON_ONCE(nop);
}
