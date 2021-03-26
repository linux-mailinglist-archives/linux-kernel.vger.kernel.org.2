Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4D34A0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCZFCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCZFB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:01:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E1C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:01:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so333522ply.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=84A8v+XeV5JjctAqo2hL1ne0vjBbAMn02SlN4sIUtTI=;
        b=RgHOBF+khBCvUpDv9fwxSzb9KhH8POkjfc/UCYrp4IQf49XQ9hK92rGBNl5Fco8QuH
         Gw4HE4kDRGbE9czDNQUCOZDCJrPs3Xz2qcWoCVjqmWA3OAElRqxwgbvlaO/OQ214Y0m8
         wICOPF9sFTDw+gVYYR7iays4Y2eRKsZZIAIH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=84A8v+XeV5JjctAqo2hL1ne0vjBbAMn02SlN4sIUtTI=;
        b=JfK6RlPa5bWlatEIiSsPxEJsNSHS3R1BkAltSHvbBNT/sKoUU6XHdjZebifRLBkWGk
         NAOS2+1y+/b+lgMisKPCOjnlP2339cFFaqUus3lE1n5kXy3bYHSucBhq4/0XD7NWbzAA
         N5kEcG1i0xHERbzgDeLcijWJV9hOK/An/jhb/NNJ+ZprK7S4bKO5hHbDrEGAdSD9w0dM
         nkxDyTgdFBItsFgeT0imAbxJv60vC5ABRjXusw0xj7e3fCkTKS5kI8HBXnUkkQ7315fY
         68JlJ39FKWaF4c7lqBb23Kk8ASz8DA1zOXStk/BxLlBrDvvrJJPM/j6XSxrJNA52gKfs
         34Aw==
X-Gm-Message-State: AOAM5335M2Udt8faHWISRoOhVvWJWR5tsyxsGQEJFJUe61KQg+QUOodK
        CLFE/hzMQwgdm2x1cBRIhxbm5wh6hhoqog==
X-Google-Smtp-Source: ABdhPJxIVQm36PfYBh29vXueHwbAY8gonhNwJLySxx9EckNwgFwv0t1rXFzDGRxhnNmQXO0nxP5YkQ==
X-Received: by 2002:a17:902:8b86:b029:e5:bef6:56b0 with SMTP id ay6-20020a1709028b86b02900e5bef656b0mr13263219plb.76.1616734918120;
        Thu, 25 Mar 2021 22:01:58 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id mm12sm6933345pjb.49.2021.03.25.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:01:57 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     YueHaibing <yuehaibing@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/smp: Remove unused inline functions
In-Reply-To: <20210324140752.11320-1-yuehaibing@huawei.com>
References: <20210324140752.11320-1-yuehaibing@huawei.com>
Date:   Fri, 26 Mar 2021 16:01:53 +1100
Message-ID: <877dlu8q4e.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> commit 441c19c8a290 ("powerpc/kvm/book3s_hv: Rework the secondary inhibit code")
> left behind this, so can remove it.
>

Interesting: that commit removed some instances of
(un)inhibit_secondary_onlining, but it seems to have missed the ones for
the uni-processor case, which your patch removes. This seems like a good
change.

Checkpatch does have one small complaint about your commit message:

| WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
| #6: 
| commit 441c19c8a290 ("powerpc/kvm/book3s_hv: Rework the secondary inhibit code")

I don't think this warrants another revision, I think leaving the commit
name on one line makes sense.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/include/asm/smp.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index 7a13bc20f0a0..ad7129a19e8f 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -189,8 +189,6 @@ extern void __cpu_die(unsigned int cpu);
>  #define hard_smp_processor_id()		get_hard_smp_processor_id(0)
>  #define smp_setup_cpu_maps()
>  #define thread_group_shares_l2  0
> -static inline void inhibit_secondary_onlining(void) {}
> -static inline void uninhibit_secondary_onlining(void) {}
>  static inline const struct cpumask *cpu_sibling_mask(int cpu)
>  {
>  	return cpumask_of(cpu);
> -- 
> 2.17.1
