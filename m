Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5C370169
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhD3Tnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3Tnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:43:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:43:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j189so3093191pgd.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTsNm6Ls4TUy5ckEe/aB3j0eDGPr1MXObQaGCGMAocE=;
        b=lN9muvcXbwSPl+TaH5GLQ8oX4P5CO9Mgkx/U/wX+rBit/3d0X0MZXNioHL1hv7ig3W
         WBUnkBSV5C8yd1doS7DQBWx+4W3zAoELx7I1SgLraW/Zqk7jMmbbA5ETtEUoC6a+pv/o
         itLUPlp46SU3JbUv3swZNM2/ULMZb9+ncnlakg+yAvPRj1NCRWfFOE3L66tVd0SBx2/e
         pxuKAtRJ1pY1LaG3/w+HbdP2AOcyUU9Ex6wGi/OOxhSfmzAldG1DXecnRZnu/UHPhwhg
         N5i4ZIBhGGNMRfB0LVwQeMY6tM6JpLjzy/NjEs8kMABtO/h1XzUTFTgDR1MW/wo47Ytf
         5rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTsNm6Ls4TUy5ckEe/aB3j0eDGPr1MXObQaGCGMAocE=;
        b=LXCMAwRtki3rkKe2WPLOmBc8q68vB7xHFeAL6eSVl2e2rANKKWoC4LWcJtOXka6tsY
         2+5+z3KnTLG37wuQKzBonHhcouyOuEKvJYAYyN14OuPipdys3ehmdXM5/y8ELsEOKu5e
         kW/IzVWMv4Awz6iCPHroR6CVE6gYjX85Xjy+mQDCYerOm/no8spIr2MOBiAGr3p0wIf6
         SFHuAEoG6YU+eSdVQTheLQC+0/M65u0YHlutUsTvtKE6zik/lxcd7OeYF3is5SxxG7Qm
         nPndpPtF0dxfUNtAlRK2VNEoGQo+mhZBlHFafxYiREhqqyNEdEuVt8LznsUyJGeUXpVa
         5+0g==
X-Gm-Message-State: AOAM5307ETrrJKF55xdMKuj7k+WmcIjPaE8QTHzhZK9gyYSnK3t44POd
        JrZG16rncStT8PvyG6xdKM7EUgDP/RD2enlP0J9E7V/kvJVipIri
X-Google-Smtp-Source: ABdhPJxNM+CocJtBk1fxCsWHqK0IQip/tJ5KmZIYqj3Nd01BifyBBkKw4peHw8Y37id6AI0Ic/qE4abGfr4hTQXoALc=
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id
 z17-20020aa791d10000b02901fe2a0273b9mr6637574pfa.2.1619811782689; Fri, 30 Apr
 2021 12:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210430131733.192414-1-rsaripal@amd.com> <20210430131733.192414-2-rsaripal@amd.com>
In-Reply-To: <20210430131733.192414-2-rsaripal@amd.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Fri, 30 Apr 2021 12:42:46 -0700
Message-ID: <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int __init psf_cmdline(char *str)
> +{
> +       u64 tmp = 0;
> +
> +       if (!boot_cpu_has(X86_FEATURE_PSFD))
> +               return 0;
> +
> +       if (!str)
> +               return -EINVAL;
> +
> +       if (!strcmp(str, "off")) {
> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
> +               rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> +               tmp |= SPEC_CTRL_PSFD;
> +               x86_spec_ctrl_base |= tmp;
> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +       }
> +
> +       return 0;
> +}


Shouldn't X86_FEATURE_MSR_SPEC_CTRL always be set if the CPU has
X86_FEATURE_PSFD even if the new kernel parameter is not used ?
(e.g. set X86_FEATURE_MSR_SPEC_CTRL in init_speculation_control()
and have psf_cmdline() do the rest)

Considering KVM/virtualization for a CPU that has X86_FEATURE_PSFD
but no other existing feature with MSR_IA32_SPEC_CTRL, if a host
doesn't enable PSFD with the new parameter, the host doesn't have
X86_FEATURE_MSR_SPEC_CTRL.  Then, it would be a problem if its
guests want to use PSFD looking at x86_virt_spec_ctrl().
(I'm not sure how you will change your previous KVM patch though)

Thanks,
Reiji
