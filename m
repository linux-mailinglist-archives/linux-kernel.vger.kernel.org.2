Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD70430BBE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBBKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhBBKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:15:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA07C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:14:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so19831557wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S29qSBxrRMWdoh+uQ0z7xwZGgDdoQsP6bzHB4znO2RQ=;
        b=FOL+mQvxrnrE+2uwaih76cLeFlqKFQeumFQMbn7OQMAIpM3QuVMQbzQWvkXiuNztiU
         y88Fy/y32mILOuYt7wWj/C1cxaz5IxDEkFwRCNP1MWHgQJPqznb5h6i+wags+9DM4eku
         GfhWrhMLbwsnckJdPE1cjf0Fz2e7HQekW1N9ibs/9l5P8htQ+N+9qq0O8DFYqFfjzX+c
         KjwQkTwPz7YqHvii6xM2IYGYLtrFFWmyxlO7g2p4ASRNeb2LuIIY8b8n5ursKJkqtdJK
         iaprLMD4R7i3QzlQcFSuoesvVEd5irADknwJfcm81DsNs+mAmUNkflHqBCX9vMkrI8es
         NvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S29qSBxrRMWdoh+uQ0z7xwZGgDdoQsP6bzHB4znO2RQ=;
        b=jIzhjFpe/ks+8quqMgRaGHIbsVmMAoX3+NHfSGdOMsPwYkJ31d1pH+JjHOq+M72onf
         VD+Ho0GtGZrwqXdUxVDS/ma9k7gNJ4HXxeQrvqZaZJS/I+jFGvM4duZw1HzEHM1hUo1+
         urXTaarC5Jf7gzIypaazSbqL/uS4EJdDfPWB8fwVrn2fpVmM1mVuQ1YGZ5h9WESQhGom
         y6iHtI+8IFtcEQK7J52NhvYYC0aZZNkS2xkXDze1blnnhscU8S3G5LHLCS/TPZ8GTq65
         tuMJjbtTDsKlUnRTsGtNTr+2qWwYd5eCeCIHjelMC4Cgr+AhkPJa+s8RNBnt8Q5Ufjn6
         fqOw==
X-Gm-Message-State: AOAM533jwGDxN7d76/751wEqH7HZOm2c+UaUaoFDvSw/m8stCRhNSXNH
        voaV5YwaCAvYFOa8KcERZIdjDg==
X-Google-Smtp-Source: ABdhPJyfWn6FsrHijyrJnW/tBTAvhlBZmX+sr4R/GNDwBS+eRgzTj9Ktrdkd2gpILs6BDmypHzVeRw==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr22258466wrm.231.1612260897588;
        Tue, 02 Feb 2021 02:14:57 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id m22sm31890793wrh.66.2021.02.02.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:14:57 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:14:51 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 11/26] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
Message-ID: <YBkmGzL10q43pT8i@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-12-qperret@google.com>
 <20210201190620.GJ15632@willie-the-truck>
 <YBkiEPOYBGqfncwH@google.com>
 <20210202100028.GA16657@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202100028.GA16657@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Feb 2021 at 10:00:29 (+0000), Will Deacon wrote:
> On Tue, Feb 02, 2021 at 09:57:36AM +0000, Quentin Perret wrote:
> > On Monday 01 Feb 2021 at 19:06:20 (+0000), Will Deacon wrote:
> > > On Fri, Jan 08, 2021 at 12:15:09PM +0000, Quentin Perret wrote:
> > > > In order to use the kernel list library at EL2, introduce stubs for the
> > > > CONFIG_DEBUG_LIST out-of-lines calls.
> > > > 
> > > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > > ---
> > > >  arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
> > > >  arch/arm64/kvm/hyp/nvhe/stub.c   | 22 ++++++++++++++++++++++
> > > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
> > > > 
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > > > index 1fc0684a7678..33bd381d8f73 100644
> > > > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > > > @@ -10,7 +10,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
> > > >  lib-objs := $(addprefix ../../../lib/, $(lib-objs))
> > > >  
> > > >  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> > > > -	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
> > > > +	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
> > > >  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
> > > >  	 ../fpsimd.o ../hyp-entry.o ../exception.o
> > > >  obj-y += $(lib-objs)
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
> > > > new file mode 100644
> > > > index 000000000000..c0aa6bbfd79d
> > > > --- /dev/null
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/stub.c
> > > > @@ -0,0 +1,22 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Stubs for out-of-line function calls caused by re-using kernel
> > > > + * infrastructure at EL2.
> > > > + *
> > > > + * Copyright (C) 2020 - Google LLC
> > > > + */
> > > > +
> > > > +#include <linux/list.h>
> > > > +
> > > > +#ifdef CONFIG_DEBUG_LIST
> > > > +bool __list_add_valid(struct list_head *new, struct list_head *prev,
> > > > +		      struct list_head *next)
> > > > +{
> > > > +		return true;
> > > > +}
> > > > +
> > > > +bool __list_del_entry_valid(struct list_head *entry)
> > > > +{
> > > > +		return true;
> > > > +}
> > > > +#endif
> > > 
> > > Can we get away with defining our own CHECK_DATA_CORRUPTION macro instead?
> > 
> > Yes I think eventually it'd be nice to get there, but that has other
> > implications (e.g. how do you report something in dmesg from EL2?) so
> > perhaps we can keep that a separate series?
> 
> We wouldn't necessarily have to report anything, but having the return value
> of these functions be based off the generic checks would be great if we can
> do it (i.e. we'd avoid corrupting the list).

Ah, I see what you mean. Happy to have a go a it, there are a few other
small things that make that it a bit annoying e.g. CHECK_DATA_CORRUPTION
is unconditionally defined in bug.h, and I'll need to stub EXPORT_SYMBOL
as well, which may both require changing core files, but maybe that's
fine. And if that is too painful I think it would make sense to keep
this a separate and self-contained series which would be a nice
incremental improvement over the simple approach I have here :)

Cheers,
Quentin
