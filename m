Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC88238CE19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhEUTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEUTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:23:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:22:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d78so14751922pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPitddRtg4/TXAC9F1uqaZjw01XMepc1KCiYJ28+nDk=;
        b=ezJ8H9SUYXgH1GqKIcsPsudxq6Mot+Y+nNDPRMNovXmkJw2dhvXGuaagsK6KQMmcKX
         itZAdKrG8taKmzNFyf14KliztyuFJPwVrPNFJ+QcZlD1V6fQwF0mtNIkPFn9voyJtNo2
         bldvnZNko7OMgToPmvzC3QD10o3RzlkJtD0VML7KSIU4WEkKZXLs6RtUgSuRtydAufbo
         vcX/aXld3wlxeMVy0preZBOP9km+6qpihr1KJRmwn10+69R5QnIMZfa+3VEH2CnKg8az
         9l1II+cvdEzT90cEt+7V+WrpAsCXww8f/p4+JurcMfZhvunUSF9Hkw8gK6zNANVCINu2
         +Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPitddRtg4/TXAC9F1uqaZjw01XMepc1KCiYJ28+nDk=;
        b=g+YN5O5G2hg/Gzrb8HgtgqZTm84WtTvX+Oi/BBLKoSrvSC7+kuVIJGolVfOM7tRWze
         9SYS3Nbwy3tMQ0m2zkXaYrU9bYKwLxn0jQxAxluzjoeDQN0kQplpmT7gF0xRHpRFHqo5
         ni0kcDl+YXu6secCcFEZFn+aAj9/GTMmhDijq9oPTznJgAohzfOxLDPM5YGQMjTLye+F
         o2RFS1JsQ4v03cd6n6OaUkA4BEki312nj8KhXWoe5gCUpAx5+4BYSJrYuFRan+NWrm2Y
         RZMKEAQKf99YeUG1EJVa1OxeCuDY6tQJVy30gunGmUt8v0SbbNxMXhK4Pibc2Yh7Trmy
         zwpg==
X-Gm-Message-State: AOAM530uLd+sCWnoLsmmknbh4z0wfflgSxVD6HCVVBhMETtFDaIgoyRP
        BaCJrsLK26E2vBqQJYHB7SoC+niwO9b4bCatgJnRQQ==
X-Google-Smtp-Source: ABdhPJyX5PWO/h7plHMPPKsl6NclubUVV3LC5h40BWnkvE+LAwFsiOA1pCdLxmYfSy/gbpx/RuMB/HgNauWu7CBTzd8=
X-Received: by 2002:a63:521a:: with SMTP id g26mr240971pgb.279.1621624951373;
 Fri, 21 May 2021 12:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4fc32900-412d-fa10-520e-afa6caade33e@intel.com> <81c0f447-44b8-c2b6-ce41-a39ec0a1832b@linux.intel.com>
In-Reply-To: <81c0f447-44b8-c2b6-ce41-a39ec0a1832b@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 May 2021 12:22:21 -0700
Message-ID: <CAPcyv4i5a7ERZ8n=_Ucffx1cLru7C08xz3cB6X0iG+4yLTUYQQ@mail.gmail.com>
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:45 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/18/2021 8:11 AM, Dave Hansen wrote:
> > On 5/17/21 5:09 PM, Kuppuswamy Sathyanarayanan wrote:
> >> After TDGETVEINFO #VE could happen in theory (e.g. through an NMI),
> >> although we don't expect it to happen because we don't expect NMIs to
> >> trigger #VEs. Another case where they could happen is if the #VE
> >> exception panics, but in this case there are no guarantees on anything
> >> anyways.
> > This implies: "we do not expect any NMI to do MMIO".  Is that true?  Why?
>
> Only drivers that are not supported in TDX anyways could do it (mainly
> watchdog drivers)

What about apei_{read,write}() for ACPI error handling? Those are
called in NMI to do MMIO accesses. It's not just watchdog drivers.
