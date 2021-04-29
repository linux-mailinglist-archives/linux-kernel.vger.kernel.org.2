Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F29136E48C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 07:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhD2Fjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 01:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhD2Fjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 01:39:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD68C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:38:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q2so13386555pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0Fjyxa3VjYs7L2SaF4c21Xyd6XQR36EON1e4dfm2lM=;
        b=sfXwBcUg3Z2ZbJjxQ3NKxkWaQpHVtN2jErdKXkVr3yoBxIWwVTM+fb9va6YLO9uEMv
         JJ8tl2uO0nDst4encQEfYutEZLqckj8YAF1aInwyu1hNvHBpOax9hWrG03zMLeoxYX1z
         TdObhvqb1GMAFq7vovb5FzMWycokwg4HnNKLlBPfSmTa+yju9WIhkUXfePzsV65VKLv9
         JLzMBmvcouS9Zm9pWEwNcxJvBT9OphoxS6kDGIxCfNEGtHaZ3MS5cEocLz9egKxjhaF1
         coIulgaNMTnFCs5Wacx8BMzZvrMpwF/CFyx+ca2AQC6NWfK6AnJOmx4s4TI2wLSQSjST
         VhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0Fjyxa3VjYs7L2SaF4c21Xyd6XQR36EON1e4dfm2lM=;
        b=RdHzvKSa53r6VDUYQt7xLbaeW6u/WcAA9xlck+WzSn+l6iilujKBACtdWBud8bebVr
         stl75ICssR2YQgCWCm5p1ajwn+Juo4ElggFjcd5iVG0TNPL0qKlk5LY5wjSQRGVqdBso
         oa15PncKyS8Gf6OXkIkjwkh24rk/JCUl+5Anwfa1Y9Ic5CWWT1S8OCWd07brK76eWjE6
         fde0dDBTTFtsB9cng4r6Ezh1h7u29Tp9h0cxm1dZlJY7PtY2h/b4KdYjQrrd2zQ8NkA2
         GxYTIGCgSVOdYT10E/8t9wnS+n5+gDdMSG7+TFREtbdi1hNLs/ZjtaTRnUbCK3wlLSQw
         +RTQ==
X-Gm-Message-State: AOAM531wsdcNgV/XLlgW1lZjTk3ETWJsItYh4XguEKdpWdGEvuVZL5M7
        cvDHjh1KCE/bCRDx9V1Qw7cntFQ5z6MhQkNOOa7tSmULK1PODg==
X-Google-Smtp-Source: ABdhPJwDVx41PCb28xhqw1htYjqO6zNddiBP0OIE1n7uaNqqs76PuLoX6iub3XyS2p152mbCCIyluiqmDakosjI8NRw=
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id
 z17-20020aa791d10000b02901fe2a0273b9mr31617888pfa.2.1619674735206; Wed, 28
 Apr 2021 22:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210428160349.158774-1-rsaripal@amd.com> <20210428160349.158774-2-rsaripal@amd.com>
In-Reply-To: <20210428160349.158774-2-rsaripal@amd.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Wed, 28 Apr 2021 22:38:39 -0700
Message-ID: <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +       if (!strcmp(str, "off")) {
> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

My previous suggestion about updating MSR_IA32_SPEC_CTRL meant
something like:

    rdmsrl(MSR_IA32_SPEC_CTRL, current);
    wrmsrl(MSR_IA32_SPEC_CTRL, current | SPEC_CTRL_PSFD);

And this is to keep the behavior of code below check_bugs().
(Or do you intentionally change it due to some reason ?)
BTW, x86_spec_ctrl_base, which is updated in psf_cmdline(),
would be overwritten by check_bugs() anyway as follows.
---
void __init check_bugs(void)
{
        <...>
        /*
         * Read the SPEC_CTRL MSR to account for reserved bits which may
         * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
         * init code as it is not enumerated and depends on the family.
         */
        if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
                rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
        <...>
---

> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);

Does X86_FEATURE_PSFD need to be cleared for the 'off' case ?
Do you want to remove "psfd" from /proc/cpuinfo
when PSFD is enabled ? (not when PSFD is disabled ?)


Thanks,
Reiji
