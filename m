Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E079455991
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbhKRLH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbhKRLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:07:51 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6113C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:04:51 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w22so7401435ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+OXoIK3t7peLdw2gwunVMuyzrq5S0a00LmxOTqnm6I=;
        b=j7uWdTmJ3HhtC+wtdiUVXKCJFw1byqr94rWeuej1JU5Iys1SiJQqzrg3LCywODo/0O
         /sJRMhN1f088TBcwEAOIjnbOqoraa1OI9AAIyTpwYCXb0daDrZ0sVyEB1vu0LAjovPoT
         lO4EpdJQ9CRAs4evfKr8PZ8Ph7sA+XroqNfSC4nYQ4xRJdT1X0e23ao6BsFkMWCFyZ7q
         TckCLrfJLqQgBKZjCIIe1kKrwBYvpmxFsdod8l2RqCXPFTpYdDQLjIRXRdokfgWFarq/
         lzwL18yMZzDcKs+Efpm6WaWNhuau88Rpmkp5YDK4E5z1rxJtSK34b6BpXCaNV9gjo45z
         kXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+OXoIK3t7peLdw2gwunVMuyzrq5S0a00LmxOTqnm6I=;
        b=1d+6h/zqlx5nKDU0O/+rARoqM65zIgP4riOek137ghmIQV+7qwvobh9Feai11QPkh0
         x637y9IKSy8ZTQB5bUsJb3lpg8WDk9NlF0MLPlHT7FTa+bPueccz3Qs2zmVTapwhBGI+
         GsOs3IcuYFLp4bh8Ar3fOaoRvLaUiWFdXApLD0TUyZ/DHZ3BgQviNU79u52+IKcEVweZ
         zwyBYINJCELah9mDKVlMOnyCtuU8WLd4h2L7XZn2zjBA03Xx7XjnhdOU9Uk5Wvueltnh
         s1RNnm36sAbtzG1Nee8pkVxNOcYTb0y9GrCfI/LevyNlOAFuKMcT2CooLcul191uGEcT
         /BQQ==
X-Gm-Message-State: AOAM530/lB6VMeJrBUNP/VAnf/CbGnLz/PH+0812AijYiB0XxKcqeFuT
        D9T3L0UXk17lHBdVqGygI0BcnHn+sNOOavuB6Ks=
X-Google-Smtp-Source: ABdhPJwby4D5qOGXm3gGuzTAlXGUvyk27xVPr//4OlagiMrpYx7i1rLTYitcts9sSlz8I5Km30n7B2/a3PoD3ON3m3I=
X-Received: by 2002:a6b:e60e:: with SMTP id g14mr16172499ioh.28.1637233491378;
 Thu, 18 Nov 2021 03:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20211110115736.3776-1-jiangshanlai@gmail.com> <20211110115736.3776-47-jiangshanlai@gmail.com>
 <f4aaf005-8b72-9b68-87bc-8019f0199f0d@oracle.com>
In-Reply-To: <f4aaf005-8b72-9b68-87bc-8019f0199f0d@oracle.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 18 Nov 2021 19:04:40 +0800
Message-ID: <CAJhGHyDEHLvZToLPUcykWWQG4BMkR2ttytBLFOBit8_16jGM4w@mail.gmail.com>
Subject: Re: [PATCH V5 46/50] x86/sev: Use C entry code
To:     Liam Merwick <liam.merwick@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 5:31 PM Liam Merwick <liam.merwick@oracle.com> wrote:
>
> On 10/11/2021 11:57, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
> > use the function directly in entry_64.S.
> >
>
> A drive-by comment as I was looking for SEV commits...
>
> Typo in definition names, ETNRY -> ENTRY, (which impacts most patches
> between 38-48) would likely cause confusion in the future.
>

Wow, what a study mistake.

Thanks
Lai
