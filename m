Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157BE30C31D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBBPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhBBPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:07:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E99C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:05:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i5so1071711edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNPuLWbMOPJhBKW5/O3dFI43s3JosphBljhuMVPMAJI=;
        b=YO5JffeoAjC9HQlC6/6NpLQ4XGUy9IrmZEE+M1Wpu+Z/AtRU4EDZOSuGFhor9j3ldF
         f6bg7DPqpjzUEBJIgG4jhbPsn07qCgo7322CSz8ozEWNxgurPBWjTGZnbNTo/GA80Ldb
         c/9miLkPNQp8Rj1U1XlZ7A1qjbYMTDzGfsPpEkXT4HJ+aaoHlwLWQtTyOnAjHdJm7L/c
         no9huoFvG30XWGX3TbLr3eWlZiG/2nt3MRM8BHvZBUY1n6UZ9Hco+RH3ITDk1rPOsbm4
         pLGsIwP3KooZ0QxEDsWRHWcACtPE1qJiyI9Xscwb0+J2lDFa4LYqyH9/77tgq+J05TDg
         /TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNPuLWbMOPJhBKW5/O3dFI43s3JosphBljhuMVPMAJI=;
        b=QGmbPi5Sni8a/B9dns2/soZ+mKLUD+bG21Cbv1NDWjckVqwWPfKKE7EqHZLjggUh1b
         r2vRPqn7wOhNUjOUBoNawusQ/hOR9Ws3iS41SLl7SUwHihi/1himRyahMkYHJAdh+Ina
         TpkOHPC/dilozylLaLi2h07A3BQSCmhpu5k/kXEg3pw5+JxPQIToAOzQQRu0dxTrQCH1
         rsAsSBEZ3dfdxIDpzHDESQxJTaNmIlJLAvuDqbOOWOGadsZg/Awfn2UwbavpJh1DuK0I
         GgQtkHWwmfORp7k5UlO53F3bE7OrPoiYEkmV0TmXErYLDcPK9QaKe2Ww3vLQmfHAh9ey
         RQJQ==
X-Gm-Message-State: AOAM533QI/rxGew/QjNklgkBqy/AbenSMtAWN2TDTIMXkIo/qyXk/Cqn
        BgLVQp3QA/J5tkiSTZH2xkWStfHYsTCkDelz+CpCaw==
X-Google-Smtp-Source: ABdhPJzPe8UR7cYiiXBEjQ2bELHWrWvEDyAypfU7vun7gk98Rh6dVxCDqYuae8Yr6FpQ1r9V4lwH6QbKZ1Pt22/dEM4=
X-Received: by 2002:aa7:cd0a:: with SMTP id b10mr1818394edw.153.1612278339686;
 Tue, 02 Feb 2021 07:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20210201150306.54099-1-pasha.tatashin@soleen.com>
 <20210201150306.54099-2-pasha.tatashin@soleen.com> <20210202084243.GA3558964@infradead.org>
In-Reply-To: <20210202084243.GA3558964@infradead.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 2 Feb 2021 10:05:03 -0500
Message-ID: <CA+CK2bDvUof-h-Y5QVDTQyBKavkYi9pVOtUmoKn64MReUdMwoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: hibernate: add __force attribute to gfp_t casting
To:     Christoph Hellwig <hch@infradead.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 3:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 01, 2021 at 10:03:06AM -0500, Pavel Tatashin wrote:
> > Two new warnings are reported by sparse:
> >
> > "sparse warnings: (new ones prefixed by >>)"
> > >> arch/arm64/kernel/hibernate.c:181:39: sparse: sparse: cast to
> >    restricted gfp_t
> > >> arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
> >    restricted gfp_t
> >
> > gfp_t has __bitwise type attribute and requires __force added to casting
> > in order to avoid these warnings.
> >
> > Fixes: 50f53fb72181 ("arm64: trans_pgd: make trans_pgd_map_page generic")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> What about just passing the gfp_t value by reference which would be much
> cleaner?


Hi Christoph,

Thank you for your suggestions. Passing by reference is OK. I am not
sure it would be much cleaner because for GFP_ATOMIC we would need to
declare another variable on stack before trans_info.

Pasha
