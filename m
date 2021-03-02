Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32232A387
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382195AbhCBJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbhCBIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:51:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D784C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4SCikIfD/29RCRTUjYHynaGafKtXhxlHkdSWy0tWr90=; b=xmNLO+ZygpMQs5Z1Lahdg2/BaI
        bjz7F3jnZlU47eiR5tIv2mVWAKjG45GjTzCodzGod3TctZVFtvV5trXcavMDCy65Qy5Vv4yAwqqrY
        wCadQFRHZGxTCsj2EYcpiNO+MBb9r1T4A/ucHtRsZYneC1t6XyeIT4X+iyo2cSsBjd/cP9xqwr/O0
        ry1Q8MSkA1JBjQBLRjZCxhUlcuzBNk/KLEQERSrqF8HRExYPqENO6yxMBLOwkNgjgA9yQAcXccK43
        +dAI3RASrEowIrFHjOptlf4+olj+FT5lbwBAQlPjvcat/sWxOv/s6qhaqAEQeK1BpmzKLELthF6qf
        94Fngm+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lH0YD-0003MA-Sr; Tue, 02 Mar 2021 08:38:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96A1930797C;
        Tue,  2 Mar 2021 09:38:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75E332BBC85AF; Tue,  2 Mar 2021 09:38:37 +0100 (CET)
Date:   Tue, 2 Mar 2021 09:38:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for
 single-step
Message-ID: <YD35jaqebjDoyeb6@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
 <161460769556.430263.12936080446789384938.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161460769556.430263.12936080446789384938.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:08:15PM +0900, Masami Hiramatsu wrote:

> +	default:
> +		if ((opcode & 0xf0) == 0x70) {
> +			/* 1 byte conditional jump */
> +			p->ainsn.emulate_op = kprobe_emulate_jcc;
> +			p->ainsn.jcc.type = opcode & 0xf;
> +			p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> +		}
>  	}

Would it make sense to write that as:

	case 0x70 ... 0x7f:
		/* 1 byte conditional jump */
		p->ainsn.emulate_op = kprobe_emulate_jcc;
		p->ainsn.jcc.type = opcode & 0xf;
		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
		break;

instead? Preferably right before the 0x0f case :-)

