Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF337A8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEKOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:16:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhEKOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:15:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620742488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nE/xF6QQ6jy94Wje4Pn+qtr6n9UALuR/dYQUtBqieqc=;
        b=JmA4cUivwLl2pXz6tgkRIMdw+s0eK1DrJM77NK1wELBhpUwvy+4PpFU1Arx5sdJnBbUEdL
        hWiKDwJLUlAs+fNV5hSnnd8amECGXvyFSnpisE2pV1r2Bk6v/cEeqfRZhV/2eNm9f91CD1
        4NXHPmWeffxbh+ng4TwE291xCTivpZqRUL1o2a6jTcjXsxfwGAk+Bwe6bRYfuIAfdQuHPd
        9MtELQL416tbFdpH5ow664QrPBxo35jLXq1HgIGHPzIq7llyRNC5QAF/9h5IYAqPoFlxcX
        FVNQ4UgdXCmzOjwc/8x2XwUsyKGMgjbLQEtpTarCebhLXgDADFpin9uweZV/nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620742488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nE/xF6QQ6jy94Wje4Pn+qtr6n9UALuR/dYQUtBqieqc=;
        b=6Uk50/dhz52RlccDbVG6qKDjQCsUFpeDVQAcRulQqoaeLAJ9JqfBw59FVqKKBbN4zr/uMg
        ZMPDK6tuLuP8UfAw==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin \(Intel\)" <hpa@zytor.com>
Subject: Re: [PATCH 3/6] x86/idt: remove address argument to idt_invalidate()
In-Reply-To: <20210511005531.1065536-4-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com> <20210511005531.1065536-4-hpa@zytor.com>
Date:   Tue, 11 May 2021 16:14:47 +0200
Message-ID: <87o8dhfjc8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 17:55, H. Peter Anvin wrote:
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 64b00b0d7fe8..6ba90f47d8c3 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -232,8 +232,8 @@ void machine_kexec(struct kimage *image)
>  	 * The gdt & idt are now invalid.
>  	 * If you want to load them you must set up your own idt & gdt.
>  	 */
> -	idt_invalidate(phys_to_virt(0));
> -	set_gdt(phys_to_virt(0), 0);
> +	idt_invalidate();
> +	set_gdt(0, 0);

  (NULL, 0)

first argument it a pointer...
  
