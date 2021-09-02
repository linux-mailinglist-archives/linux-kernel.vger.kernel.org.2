Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42C3FEC31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhIBKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbhIBKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:34:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A77C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0zoWaVGLtmeSAK/KJjDblWNoAIDreuyP4e8WrgtSims=; b=e1e5R2LJ28MhomQ0RlcPdwJ3Hz
        rwl75R3NAJfVDotsxhzeH0kPDGddq2G+HYUp2NIf1CvrI9c0TmYihKP3hwcHC0Eyx/3SmnHlZupIX
        q9iUqFpvwmlN1RqLuZ5OKYPd/Izqhe3/OuJRa0B67jH9z1Rl72wWdkfbPHaIcenhK398jSHD/rglx
        S+rFXPw/Vki40Ftslm/E3o7qdmJ54Y7Hvb2cpPAUT2iMQwhYy4SthlBJ8n4qDxo332frMLBmGFtQw
        v6B8HrY5o1K24bp/uOWtd8mT9KNBCd8Yn0+oxT3flSo1SIGTmHQufqFnI/TLm4bCopNEE/bgksP7r
        gxsA++EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLk2C-0006Pl-Vc; Thu, 02 Sep 2021 10:33:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9FB63001C0;
        Thu,  2 Sep 2021 12:33:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A070D285E1143; Thu,  2 Sep 2021 12:33:30 +0200 (CEST)
Date:   Thu, 2 Sep 2021 12:33:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 22/24] x86/entry: Implement and use do_paranoid_entry()
 and paranoid_exit()
Message-ID: <YTCoenvIaHjLQmAC@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-23-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-23-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:23AM +0800, Lai Jiangshan wrote:

> +	call	do_paranoid_entry
>  	ret

That's normally spelled like:

	jmp do_paranoid_entry

But the same comment as for error_entry but more; pretty much all that's
left in asm is things like:


	call paranoid_entry;

	# setup args
	call \cfunc

	call paranoid_exit

which seems like prime material to also pull into C to avoid the
back-and-forth thing. In fact, why can't you call paranoid_entry/exit
from \cfunc itself? The IDT macros should be able to help.

