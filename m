Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDC4215CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhJDSBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhJDSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:01:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC532C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:59:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fe4009c23c25c98857304.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e400:9c23:c25c:9885:7304])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D40A1EC03D2;
        Mon,  4 Oct 2021 19:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633370353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5dNpEpVxWH+dZNt1heGtFPdGvyQ1SCAzoPgNuJ+/fEk=;
        b=QRXWGih6h4N8X7JVMuZQx9TL6O3xLFvw/nN5yV4IdF2KvuxAGk+A93mSt+NypHraVEwhJ2
        XzloIIbjIB4ZCr2RFkU3i9t0jkgPBX3ItNAuZfqBfDD4eBU5HfPC1TVTN1WObVXsgmIkKW
        48vHv9ELjLA58RjizYWsDJyzV5XVpxY=
Date:   Mon, 4 Oct 2021 19:59:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ser Olmy <ser.olmy@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <YVtA67jImg3KlBTw@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 05:47:37PM +0000, Ser Olmy wrote:
> Booting any 5.14 kernel on certain Celeron-based 32-bit machines results in a panic:
> 
> [   22.546247] Run /init as init process
> [   22.610556] init[1] bad frame in sigreturn frame:(ptrval) ip:b7d46be6 sp:bff3af30 orax:ffffffff in libc-2.33.so[b7c94000+156000]
> [   22.749531] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   22.750240] CPU: 0 PID: 1 Comm: init Not tainted 5.14.9 #1
> [   22.750240] Hardware name: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.06 12/06/2001
> [   22.750240] Call Trace:
> [   22.750240]  ? dump_stack_lvl+0x32/0x41
> [   22.750240]  ? dump_stack+0xa/0xc
> [   22.750240]  ? panic+0xa2/0x23f
> [   22.750240]  ? do_exit.cold+0x94/0x94
> [   22.750240]  ? do_group_exit+0x2a/0x80
> [   22.750240]  ? get_signal+0x142/0x7a0
> [   22.750240]  ? arch_do_signal_or_restart+0xb1/0x570
> [   22.750240]  ? force_sig_info_to_task+0x65/0xf0
> [   22.750240]  ? vprintk_emit+0x150/0x190
> [   22.750240]  ? exit_to_user_mode_prepare+0x145/0x1e0
> [   22.750240]  ? syscall_exit_to_user_mode+0x18/0x40
> [   22.750240]  ? do_int80_syscall_32+0x3d/0x80
> [   22.750240]  ? entry_INT80_32+0xf0/0xf0
> 
> I've bisected it to this commit:
> 
> 6f9866a166cd1ad3ebb2dcdb3874aa8fee8dea2f [x86/fpu/signal: Let xrstor handle the features to init]

I'm assuming your CPU cannot do 64-bit mode?

Can you send .config, /proc/cpuinfo and full dmesg pls?

Privately is fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
