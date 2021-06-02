Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1A397E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBCIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhFBCIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:08:06 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B64C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 19:06:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1100466otc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCCJ1eFEGcaWx0tMGwZOzk/m+ZOCXhNzKCETdM0irhY=;
        b=P+CxivsSP2vTyBnLPSJf2UT7S3Vq3UDgbdZmYKTVt14drvzbGjdJeG/9pIdzwmMPV7
         J4v6+F13KjldLM5urdVgSSxpyJDvEL7iV4cS3KmurqhIR6Y6EOJPTSS6NFIYqCz7S6g2
         nC1Wy0ESwhQmb5uAu2anv8IhUfEeQoJuCETATK/PUf9gd4Ti8/sgsbwEvCezk0dvcPXU
         jTNEtJbLQwOmLEGTPDOFB0QEGtcWY5ZnebZwEIMYmB4Uesq1t3O/aDSVAW9lIbkNw7QH
         ZtvsrBEPqPH6HGeXFY1fRr9afwdBSeqCEIu00WQifkpbReliFlcejkEjNC4HnIAnxSxL
         nhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCCJ1eFEGcaWx0tMGwZOzk/m+ZOCXhNzKCETdM0irhY=;
        b=HL55VRLEZjh1qsNAcOcmBUaS8/9Q0tqDjf4nvP/wppbJeEnAgdJILX8mReaMnQiCXd
         HDE47X5zWVK6uH/2O2uiz6dU4X7bhSwUbsY1Ki8aRUEb0YEzHSM/5LUNTX6tfyIiqBhO
         IT2QFkcxEcoBKhDEjtVpaIgDdxRpjr/NxaGcA/IOmL8KFTCxDtPSFf6T3N2hPQeduz5J
         ETHV6hD+iHFoY2gCD/Dkw71k+TZdKS9hUKVpO1T6L6YurvK92A2rd4Ps9hipR23GBWxd
         cNlQfLloKycpSDAkMZJSUvnXAHQk3RCuH9rGFD3tz0dA4QZ56AhZRI7eepZ7PbCnpmk4
         D6uA==
X-Gm-Message-State: AOAM53110wgUt53fBy7skLzKu/hPF5NxXcl+W3hZtXjR3vTnBc8cArKd
        17Vurri5e1Be+5g1UKTJrIxDW7oYZuuxes3iesI=
X-Google-Smtp-Source: ABdhPJz9MyOW+RXyLkak9SmZ4RILzHZIG7xsOaJMyO8H2AOdhEnucej98ktDPPWNnUOAAovWO4h+zDrg9kApmmuFeec=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr24131409oti.23.1622599582693;
 Tue, 01 Jun 2021 19:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210528175354.790719-1-keescook@chromium.org>
In-Reply-To: <20210528175354.790719-1-keescook@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Jun 2021 22:06:11 -0400
Message-ID: <CADnq5_PsvOqBW4-WDvR7BqaZgq3R8vYRPz2=c+87Dokk-zWz_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid HDCP over-read and corruption
To:     Kees Cook <keescook@chromium.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Martin Tsai <martin.tsai@amd.com>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 1:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> Instead of reading the desired 5 bytes of the actual target field,
> the code was reading 8. This could result in a corrupted value if the
> trailing 3 bytes were non-zero, so instead use an appropriately sized
> and zero-initialized bounce buffer, and read only 5 bytes before casting
> to u64.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> index 2cbd931363bd..6d26d9c63ab2 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> @@ -29,8 +29,10 @@ static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>  {
>         uint64_t n = 0;
>         uint8_t count = 0;
> +       u8 bksv[sizeof(n)] = { };
>
> -       memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(uint64_t));
> +       memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
> +       n = *(uint64_t *)bksv;
>
>         while (n) {
>                 count++;
> --
> 2.25.1
>
