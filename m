Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020173570FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353872AbhDGPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353975AbhDGPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:49:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B344C061756;
        Wed,  7 Apr 2021 08:49:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso1441023wmq.4;
        Wed, 07 Apr 2021 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtGi8iltWobRpz30xFsiNPJJuKogqzEN6z4UYJQBbAc=;
        b=WI/J/iMZQQO51ZTZWAZniyQkKpoIu7fudcqEK0ybIQbt8Dtxo9Rq//NkZZN0Ib3+yR
         iN5jLBkqg7XtNa1BRMXi8SjyRvv/GjzVY5yy4D8c+xO7ItejABLw3hEHGMeOvrwjFt0n
         DbIw43u0SQ/D4Csj4dytpchvmOZbASgj3N5nuspr2HojH29Y9iJhUC7ONGnXlv9xakaH
         eAVvioL1lOcUbB5fbrX+IKnv7ughY/+sKsCdfEQUsLU1oTJWMla0lhWE1/h+XeRRLhYK
         D3MBvh2hQfBp/+foISZEtmL9kyk7+KEwmzWoDShFDi8F/IqFe0//kgOnEjUDbFLTm3C5
         mGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtGi8iltWobRpz30xFsiNPJJuKogqzEN6z4UYJQBbAc=;
        b=Vl+z1NhcUpM3wHPAmRDYC3tEvCtDwiMwdAxizgNjE0odM01lAh3gf5xK28GKCy/jNL
         Rtc1yoFg41E/ynEZpju5lYrq1BZ7jKydAGM1K+WK45No0p1+uulFa2pGRZZl/RMrmK0c
         hsdaZ1qBj7zxnHWU0TkSueNI8nqRNwYmucUNT231+0IQ65sQLihPJhO/JWh46mJgF2hv
         NwDEsdtYymhxI3cy7hKoKolm9efSLv0EvuNzMZtL9lTttLLj/sQupzqgLOyS/qP4jMv/
         Yt+i2qykO0ym+TsvUjgl5kCECSIAYlcFHcflEsoWLOoCllvi+YKv96rkoABdfGUNUSZX
         099A==
X-Gm-Message-State: AOAM5313QZRD4w3ZE2W6vJdjgcWGoD2ikxeZMHIMMpO+EPmfMXgJEOdq
        H3ol4RY1gYMw7Csk0XeUSqCiVAMc253xdrvwUn+9/77JHzQ=
X-Google-Smtp-Source: ABdhPJysDp1zr7PSxUM6TDUtGCff00+3vR2+ew2MYnugHBRTus+ZsVM+QsE78dfDTWZIvaeZCem3Jt3Cl+t/37B7YHg=
X-Received: by 2002:a1c:f701:: with SMTP id v1mr3757648wmh.69.1617810579052;
 Wed, 07 Apr 2021 08:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-10-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-10-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:49:13 -0400
Message-ID: <CAE2upjQFnAkKVWWZmOt4u=rTEb5QjP7j+-ZgfOXkMA663THDDw@mail.gmail.com>
Subject: Re: [PATCH 9/9] platform/x86: intel_pmc_core: Add support for Alder
 Lake PCH-P
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Rajenesh Bhardwaj <irenic.rajneesh@gmail.com>

On Wed, Mar 31, 2021 at 11:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Alder PCH-P is based on Tiger Lake PCH.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 9168062c927e..88d582df829f 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1440,6 +1440,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,        &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &icl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &tgl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &tgl_reg_map),
>         {}
>  };
>
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
