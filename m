Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D401305E59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhA0Ocb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhA0ObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:31:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F4BC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:30:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5c00182d512fee937b6e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5c00:182d:512f:ee93:7b6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EED0F1EC0472;
        Wed, 27 Jan 2021 15:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611757831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5G8ReFENXtBrmXhSJg2W7hD4LjvA0msd1dZRn8y6tqg=;
        b=atFyTl5fy88iKuI/2uTJ9be1SerQyh9GfgvW7ASafO9NtJM8Bz22zzCBCb7zssKiti3YDd
        j1/Md230+W3+ANrXhOnpq2/toqD60lcCoNY5cEXVgULWnEPMg34ayF55wU2uoSvkT0PI38
        QoSYH8PvOyurJ9ip8QuA9OL5UrUjabs=
Date:   Wed, 27 Jan 2021 15:30:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com
Subject: Re: [PATCH] x86/msr: Filter msr write by X86_IOC_WRMSR_REGS ioctl
Message-ID: <20210127143025.GD17424@zn.tnic>
References: <20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:24:56PM +0900, Misono Tomohiro wrote:
> commit a7e1f67ed29f ("x86/msr: Filter MSR writes") introduces a
> module parameter to disable writing to msr device file (and add_taint()
> upon writing). As msr register can be written by X86_IOC_WRMSR_REGS
> ioctl too, they should be applied to the ioctl as well.

Blergh, I missed that. :-\

> Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
> Hello,
> 
> I just noticed this when I read the code.
> I'm not sure if anyone uses ioctl interface now, but I tested this
> by resetting IA32_MPERF by X86_IOC_WRMSR_REGS ioctl.

Yeah, I'm sure once this hits people's kernels, someone will complain.

In any case, good catch, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
