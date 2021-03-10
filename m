Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798493333BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCJDQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCJDQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:16:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:16:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so6691882pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=g849COPJpVQXUSUGkGGzyJ03IUihWlADowoP4ZsZZjo=;
        b=XTgAcImCQEDi9o/6iMJ0uuQkXXZGO5pQkzSgLuyefIRa81qt5C89nLzwpZbgFfGQZW
         3LrvsJcvAyyJZ6mAPOKECVW7uj9N4sMH2Hg4oY1FLF40gWk3ibpTlJkjTDu/kPyKJT9n
         CyYjtd0XAYDwkSQ8QTPPjcFYoctA+bakCv1EmYzjFkoOMtzb9nnawc9PvdokiaGkaoOR
         iATAnLFTX/+CPYQMuITrwwApMi57g1lYG4vjCxTC27egQTpWe2fZ5CIdnInUT729gNby
         p8LoBRM14Fnm3ai06RHwRe3RBPDXjLDSrXLXvYMNeGiLP/NyQILd0HXiVDf7w8MtfJc/
         59Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=g849COPJpVQXUSUGkGGzyJ03IUihWlADowoP4ZsZZjo=;
        b=D/Q4PZ3w/wn/tZVEu7YblK0TbpinNh7R4a6YNm3IFwg7mzrDWqHPOeBIpbxJ/rzvD9
         PLpWupq8YY3zEtMxmDj0nWaEqrDrkevZ4EyEqne6R0ufPa2iQstqBRKQBgh4wCI2ypQW
         1Vpnlnp+y1poi1ZGjV9wjKps57Tb3Kf4YgX8sW+tR6GW166rEWFXdFKXZh/Car5sFBGg
         5gAZptD6Pq0q5tNRP/ygxfnqHLuL6mo/bPXckT8gACUXx3mL5r4FEe3P57RaQKIv95a/
         tR6hKLjjigCIatfnCICiw1es56t/5w/bsLarWdpcAeQP2s3PoZGy3fPV9yUIUJ90X3cq
         AoeQ==
X-Gm-Message-State: AOAM532q8Z1iATFCLGn19WTF/JxJkby3Lt7zlzJtJ0W1aaTl77sDOIvK
        wxz6gUNdPtPX8mg241bbOvDbeg==
X-Google-Smtp-Source: ABdhPJzrGSSjx1UUPNqyEE3R9KG5SsHStFXW4PWc7T2nYdCEDKinfnS5OwydQtCU9RfN38Cn/AdiUw==
X-Received: by 2002:a17:902:b210:b029:e6:5f:62e with SMTP id t16-20020a170902b210b02900e6005f062emr1187005plr.48.1615346205858;
        Tue, 09 Mar 2021 19:16:45 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g12sm1556605pfh.153.2021.03.09.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:16:45 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:16:45 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 19:15:36 PST (-0800)
Subject:     Re: [PATCH v2] riscv: Return -EFAULT if copy_{to,from}_user() failed in signal.c
In-Reply-To: <1615017149-24843-1-git-send-email-yangtiezhu@loongson.cn>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yangtiezhu@loongson.cn
Message-ID: <mhng-33c9663e-90b5-48a8-b089-54f16f6b494a@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021 23:52:29 PST (-0800), yangtiezhu@loongson.cn wrote:
> copy_{to,from}_user() returns the amount left to copy, it should return
> -EFAULT error code if copy {to,from} user failed, just like the return
> value is an error code when {put,get}_user() failed, this is to make the
> return value consistent, no function change.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/riscv/kernel/signal.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 65942b3..c76d877 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -39,7 +39,7 @@ static long restore_fp_state(struct pt_regs *regs,
>
>  	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
>  	if (unlikely(err))
> -		return err;
> +		return -EFAULT;
>
>  	fstate_restore(current, regs);
>
> @@ -67,7 +67,7 @@ static long save_fp_state(struct pt_regs *regs,
>  	fstate_save(current, regs);
>  	err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
>  	if (unlikely(err))
> -		return err;
> +		return -EFAULT;
>
>  	/* We support no other extension state at this time. */
>  	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
> @@ -87,8 +87,12 @@ static long restore_sigcontext(struct pt_regs *regs,
>  	struct sigcontext __user *sc)
>  {
>  	long err;
> +
>  	/* sc_regs is structured the same as the start of pt_regs */
>  	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
> +	if (unlikely(err))
> +		return -EFAULT;
> +
>  	/* Restore the floating-point state. */
>  	if (has_fpu)
>  		err |= restore_fp_state(regs, &sc->sc_fpregs);
> @@ -140,8 +144,12 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>  {
>  	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
>  	long err;
> +
>  	/* sc_regs is structured the same as the start of pt_regs */
>  	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
> +	if (unlikely(err))
> +		return -EFAULT;
> +
>  	/* Save the floating-point state. */
>  	if (has_fpu)
>  		err |= save_fp_state(regs, &sc->sc_fpregs);

I don't really see any benefit to this way of doing it over what's there: these 
are only used within this file, and the caller is just doing this return 
conversion already.  If anything I find the current code easier to understand, 
as error juggling is always one of the trickier things to get right and I 
always find it easier to reason about code that's just passing through errors.

If you have some new user of this code where it makes more sense to do it this 
way then I'd be happy to take a look, but this as it stands doesn't really look 
better.
