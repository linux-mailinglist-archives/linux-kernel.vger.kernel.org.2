Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8654233F3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhCQOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCQOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:47:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D72C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:47:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso3525117wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+NAwyApKGr9OeZM13UJcb083CY8RcBRmmL5kmNSORk4=;
        b=nxH0ZK/Z7SqIpebv2BlNzbvBvCRL5tEEruzMTQdpRepI5rsoy3EZLK4EEJC1LcX9fX
         sZHM/Q8lK2uJl//w+rXeQthlNb61MBnMXN+zTp3nVHigR4jyXmNOpaYn1UZU/71AiA3r
         v9ekQg3b1cv3QMlWeD+X3BlwdAHitT4uZAQtmtPYGdS9FEWzy9arlQ4fD01OFvaj/LXh
         spWFU8d78nqCj04AcACb3fE1uwwa0MLw3TYG8DZpJtf5IZkwn9yxoH/faccSN+wTUWf4
         2RDQfbmbFAKdXhc/jkyDlWHxa02Mv3hAk5WA1xczlUSB/2fqQrovbN795fJIbS1Y3Pjv
         wZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NAwyApKGr9OeZM13UJcb083CY8RcBRmmL5kmNSORk4=;
        b=YDyzJu5uoAGwQbylR5mwQHuJtaMyfbmXj/WeD1t6yZCBBAdQTRXts6pOtTr7jWmmin
         pa1y6nbQCvDPW7wkgxaTZq0tf7RyRfK3IhVTvMt58MMnjP44sG0Tsl5dzXkygB1j8C5W
         dwkXg3m5Sd7IpTs0mCpO1ymyTvfRfM0M8B8Iw/tC8fCnVgDfolJSkUOI8YWPjTQV+ntG
         6NuVW0dF/IsBf0NmvT9HLPwsoEJh1z3QYTrYLm6a+heHhkfGb5H5zkLmitCaN63ftRI9
         uoLXzYiDOK5ou8ARnsrGHD2ysF7iD3SLmlBglVfgGe60k9N3z2ZiLWPmd0/Q1TexTe4o
         5v/A==
X-Gm-Message-State: AOAM533P1DDuuAvnE1uy7x1r1k2iI9LHHF++tizJ/gfjMHJxkzsKKOIA
        H3SD9Mplg9J3kykWDuYxzyPiAA==
X-Google-Smtp-Source: ABdhPJx6AfATlLEiTNGqh1ucC7Hd3kT3uV12yFJvjNGYlQxmEPb67BtfUEuJl/OZaTdbQtSNc86AuA==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr4102199wmk.30.1615992448272;
        Wed, 17 Mar 2021 07:47:28 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id j30sm28608530wrj.62.2021.03.17.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 07:47:27 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:47:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com
Subject: Re: [PATCH 1/2] KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB Stage-2
 flag
Message-ID: <YFIWff9f+fESjIM2@google.com>
References: <20210315143536.214621-34-qperret@google.com>
 <20210317141714.383046-1-qperret@google.com>
 <20210317141714.383046-2-qperret@google.com>
 <87a6r1j10k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6r1j10k.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 Mar 2021 at 14:41:31 (+0000), Marc Zyngier wrote:
> Hi Quentin,
> 
> On Wed, 17 Mar 2021 14:17:13 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > In order to further configure stage-2 page-tables, pass flags to the
> > init function using a new enum.
> > 
> > The first of these flags allows to disable FWB even if the hardware
> > supports it as we will need to do so for the host stage-2.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > 
> > ---
> > 
> > One question is, do we want to use stage2_has_fwb() everywhere, including
> > guest-specific paths (e.g. kvm_arch_prepare_memory_region(), ...) ?
> > 
> > That'd make this patch more intrusive, but would make the whole codebase
> > work with FWB enabled on a guest by guest basis. I don't see us use that
> > anytime soon (other than maybe debug of some sort?) but it'd be good to
> > have an agreement.
> 
> I'm not sure how useful that would be. We fought long and hard to get
> FWB, and I can't see a good reason to disable it for guests unless the
> HW was buggy (but in which case that'd be for everyone). I'd rather
> keep the changes small for now (this whole series is invasive
> enough!).

OK, that works for me.

> As for this patch, I only have a few cosmetic comments:

Happy with the suggestions, I'll fold that in v6.

Cheers,
Quentin
