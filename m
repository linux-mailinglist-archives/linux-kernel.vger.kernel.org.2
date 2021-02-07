Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B6312266
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBGIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBGIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:07:55 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351FC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 00:07:15 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h21so5601035qvb.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2gKGkQopJ4JJQXMRMVCDiaVLnXNqh0h0cinzuuxgt4=;
        b=OPOEBpVPeJnCON5/hFRA/HZ7HMGDM6fCD23CQiZNpmAQZeLLvJzmIr4Ov3ZfNoHLa5
         9XybqyW6eWtqwuAm0s+LELHC9VCrPpgoOmJxg4GBr+nP8nWmhnxGkimIoz1HZmKnBbYq
         5ISBg/BsjPcTs2Pkg4acnzzg/u1CERmnqLSqm/AzW/1Bgz5kGGN3BJFjS9/YXoQevq6p
         uQAWpVG2PCfDRwgq2O21GGVA7CCfS+P9tNDPzzQd6M6Lp/z6i0ruGbh+Oh2yhn1GHpgF
         2YGM8T0QGjyeSj9nfePSArFGBLyO7MdBf+mLtHN/7f7f7sOAoYF+wvJlGKPrdtSBbV1V
         UHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2gKGkQopJ4JJQXMRMVCDiaVLnXNqh0h0cinzuuxgt4=;
        b=I2GpBsFrVXMf4Sn/nHz9DQhw1bjeruS4maPhO+lhdm/q6psiSaNF8Kslu7SOlo4RMj
         M6M9UDiIYc2h2K3QWptk/+8KelRkdR98+DRMF/eQlY59B4qyjqSWOOLLRuyKXQuLfgT5
         kLZbhWZPWCDvCTZRkeBVWC3pFGH6i8qFlw38RiKeNCeImq/4Z4cKrrUm5RMO6jnahUJR
         zedjKV/q5BN4TXZeI8olA+j4b+QZgZTkowRuWfIDlNv7ADWY20pWt+1fiSf25Pym2Kb3
         6MjlXSCPk182rZ2supHQaBWFchLDEYMmEZobnQGE2ZU+rKogtBHnlmPRYAHeg7Pcz5LB
         tY/g==
X-Gm-Message-State: AOAM532jHu/AXMPVcraqyFhy7T+EKlzn5XeaFTSpA1ZGmfCgjA73rNwL
        WyGaccD2yLqCvd66g/yAIXR65R1kfGvd5uX3j6Kv4g==
X-Google-Smtp-Source: ABdhPJy+E/MGv84/XSuHfXV6VbDqVpYdQ2hOSgy/NNxQ4rJfrV5CT/D7TrmeXWCqpSoMe7tTH4U4wEOogb1WSAcUFkg=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr11601869qva.18.1612685233631;
 Sun, 07 Feb 2021 00:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <20210205151631.43511-11-kirill.shutemov@linux.intel.com> <CAMe9rOrhPNs7WZa7DquEQf_YN4XyeDZC5u3XC7MBDija3ic3+Q@mail.gmail.com>
In-Reply-To: <CAMe9rOrhPNs7WZa7DquEQf_YN4XyeDZC5u3XC7MBDija3ic3+Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Feb 2021 09:07:02 +0100
Message-ID: <CACT4Y+b3jpjnWeDeUmn8TZ6KvQCu3riip0R07JjNwiOjsRYy6w@mail.gmail.com>
Subject: Re: [RFC 9/9] x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        GCC Development <gcc@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:43 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 7:16 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Provide prctl() interface to enabled LAM for user addresses. Depending
> > how many tag bits requested it may result in enabling LAM_U57 or
> > LAM_U48.
>
> I prefer the alternate kernel interface based on CET arch_prctl interface which
> is implemented in glibc on users/intel/lam/master branch:
>
> https://gitlab.com/x86-glibc/glibc/-/tree/users/intel/lam/master
>
> and in GCC on users/intel/lam/master branch:
>
> https://gitlab.com/x86-gcc/gcc/-/tree/users/intel/lam/master

Hi Kirill, H.J.,

I don't have strong preference for PR_SET/GET_TAGGED_ADDR_CTRL vs
ARCH_X86_FEATURE_1_ENABLE itself, but tying LAM to ELF and
GNU_PROPERTY in the second option looks strange. LAM can be used
outside of ELF/GNU, right?
