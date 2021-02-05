Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC13310605
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBEHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBEHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:44:17 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BA5C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:43:35 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w124so6576789oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNYDAPwmA+T5j4N+W3YFNQofLY2Q0zVUyzfw2M1AxTo=;
        b=Q2BMWEdoyt5JsbluyrH16Kus+GEbCbjKP3WuVs802CW2/HihCB0uwOlViUTXQZVNzN
         s3C5hiSYAbZbqg2E1nAfEi1FEx/D3kJAfILhJrcc3hXV0lOOxgta/C2apinoAKf+KxWJ
         t/6+UVZ99B4akfS6vHKWYKnPDVAkubUnzpf6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNYDAPwmA+T5j4N+W3YFNQofLY2Q0zVUyzfw2M1AxTo=;
        b=LngnZd/lOL8KfNGN2i+7BG/yWTHzpBPUweV0uRhoOdiAT75Jul+AbDuX6OzuUhYfMA
         iYS7aO7uRy9ULlNZZ/beg+OpYvBkyMgzVMTLWq6LA4XQ4M87fvsgelSdBXy7tzkQ4n8K
         1m5LBDEiXEspaoUKlPe0Apmam/RuNVshAi03gllKM7tAKy9CVVzBVDfF9XuU1N12NDbG
         5ygqCED5Nr4OB9+F1HOaJP8LA7TLezYxPrEXbqGK29MLh7FFCJXKaXGvpXHBLTkeTD43
         PIJMAOq1kGPeEfqVsTdvxwPWcB8JWFv9pNjvmePjgKJI3/bKgjljuXCCcHQFxb5r1syy
         mfmg==
X-Gm-Message-State: AOAM530pjPUg+YUVXyjn4YNQYrIO2Hmn5LIflTNJIJqsVOaHPgGtGMa4
        s3R4xiWrdTyD+f8ufF1ZTYtAgawY7nplj4J6tGWfU4xW5fmCIA==
X-Google-Smtp-Source: ABdhPJzDeNovUCPUxkRfFTLU3DtLUexLktQWZivHRJ6NvIconAVJrQwO2Lte5w/rWcaQKnjtutQjcyt/8/gUQCEuDy4=
X-Received: by 2002:aca:1906:: with SMTP id l6mr2274756oii.101.1612511015117;
 Thu, 04 Feb 2021 23:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20210204184519.2809313-1-daniel.vetter@ffwll.ch> <YBys6Io1ZbZdzWmj@kernel.org>
In-Reply-To: <YBys6Io1ZbZdzWmj@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Feb 2021 08:43:24 +0100
Message-ID: <CAKMK7uFM=ZW_+D32OGfirwY83ZkUKQpiA-3zGx9KAe1UKjW0XQ@mail.gmail.com>
Subject: Re: [PATCH] x86/sgx: Drop racy follow_pfn check
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@suse.de>, linux-sgx@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:26 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Feb 04, 2021 at 07:45:19PM +0100, Daniel Vetter wrote:
> > References: https://lore.kernel.org/dri-devel/20201127164131.2244124-1-daniel.vetter@ffwll.ch/
>
> What is the difference between this and "Link:" anyway?

Afaik References: is for other reading (bug reports, discussions,
other patch series), Link: is for patch submission itself (which I
think some subsystem do an entire chain of, on each revision). My
scripts aren't good enough that they add the Link: before submitting,
I add them when I apply patches (since most patches I get don't have
them anyway).

btw since the final patch to remove follow_pfn won't be ready for 5.12
merge window (kvm and vfio have some work to do) I think it's best if
you just queue this up in your tree?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
