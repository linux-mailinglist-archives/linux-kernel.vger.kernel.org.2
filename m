Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224DA34AC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCZQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhCZQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:31:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975BBC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:31:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 32so5000122pgm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=29huvHEo465EjEKfoTt3gNluQWbNTeA+c8M37XDmxzk=;
        b=GgsPbXb3/hzDDl8E4Odxa4Byrh3RVGZwGmrEZXMupG6a4IHhN4KHJsETBTnd9fcKFm
         H4HvXqWg2TSPcoEgOe8pjZj11tXpm2UNYicGQ2pnBSiFMXVx9VeQQlFyknn28dmRd28Z
         ai06yviE5BNZhMoMoASZKg9//Un8JK+FC8z9p3qW8r930Nu4sznOYbDcoWM4Z6EXFkj0
         25+jdxpvzpQjOOEyK4MlLc8qn5z0bBwLfU9Zm6VmPBtIaUWSLp9MEePNk7jOcJe5VNeT
         /P1VnzoboENSseFhZhE5yvj6SVeqmcp+miWQqPE6NSiAGh8J0IjHhRQLetSx2BhUCNBQ
         eEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=29huvHEo465EjEKfoTt3gNluQWbNTeA+c8M37XDmxzk=;
        b=W8iEvWTG2xGtSJmLMLAZFqU65VxT8nU9o2sqN9KkDR6yZzFW1mRwDSYW5sPf8Oji7/
         ltuNsQqXy9quqfWSM3lav28JrX2Uw/MLMo7CcyiGi7K0FJ7MZfMX95tP+fT/NECbwpvv
         2BexY0XTkcY4mG2ST1QZmino6hmn64GVHAmrEBmMV3NIKu7IkqUSc1VDJ/81JSeTc+Dc
         Broh2pM1eGGGV8FOXIle/RaDaxYFFVw5wm3KZjV3xIwtktvbJf2CALm40R7/wYmriJxw
         NceqoW9cb59/ByAJaIX6KvObWobUdnlLpR6wHh5IZp+CZY3Ooa1mszhwPk8YsCRCeKWI
         HC9w==
X-Gm-Message-State: AOAM532uxYUGqbBLsiPhXL7NJOC66Acd+HukldCGrEojDH9ZY49ag3SZ
        sk8hqeVVFodpXeY4JQUvOW0ztg==
X-Google-Smtp-Source: ABdhPJzV2mwjkwpklaEXxEIspenNY0PM9et+7QsU9xhTqcbNl8ISd4RHOpZHZMidiRnb5q1omGMqsg==
X-Received: by 2002:a63:7a07:: with SMTP id v7mr12788014pgc.26.1616776306089;
        Fri, 26 Mar 2021 09:31:46 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b10sm9439387pgm.76.2021.03.26.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:31:41 -0700 (PDT)
Date:   Fri, 26 Mar 2021 10:31:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 05/19] arm64: Add support for trace synchronization
 barrier
Message-ID: <20210326163139.GB2009902@xps15>
References: <20210323182142.GA16080@arm.com>
 <7675ab71-c2ff-91e0-5728-fcb216ac1e0d@arm.com>
 <875z1gk6fo.wl-maz@kernel.org>
 <1b5e5bb2-b89f-fa35-0a8b-8c5476cb9ff6@arm.com>
 <871rc4jzn0.wl-maz@kernel.org>
 <17e57b01-840b-dbeb-c09f-1c04becb8749@arm.com>
 <87tup0ikf0.wl-maz@kernel.org>
 <59aec851-e980-0a6d-8ba5-56a35fa5a7a9@arm.com>
 <20210324171934.GB3709@arm.com>
 <877dlwsb54.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dlwsb54.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:40:39PM +0000, Marc Zyngier wrote:
> On Wed, 24 Mar 2021 17:19:36 +0000,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Wed, Mar 24, 2021 at 05:06:58PM +0000, Suzuki K Poulose wrote:
> > > On 24/03/2021 16:30, Marc Zyngier wrote:
> > > >
> > > > OK, so we definitely do need these patches, don't we? Both? Just one?
> > > > Please have a look at kvmarm/fixes and tell me what I must keep.
> > > 
> > > Both of them are fixes.
> > > 
> > > commit "KVM: arm64: Disable guest access to trace filter controls"
> > >  - This fixes guest fiddling with the trace filter control as described
> > > above.
> > > 
> > > commit "KVM: arm64: Hide system instruction access to Trace registers"
> > >  - Fixes the Hypervisor to advertise what it doesn't support. i.e
> > >    stop advertising trace system instruction access to a guest.
> > >    Otherwise a guest which trusts the ID registers
> > >    (ID_AA64DFR0_EL1.TRACEVER == 1) can crash while trying to access the
> > >    trace register as we trap the accesses (CPTR_EL2.TTA == 1). On Linux,
> > >    the ETM drivers need a DT explicitly advertising the support. So,
> > >    this is not immediately impacted. And this fix goes a long way back
> > >    in the history, when the CPTR_EL2.TTA was added.
> > > 
> > > Now, the reason for asking you to hold on is the way this could create
> > > conflicts in merging the rest of the series.
> > 
> > The way we normally work around this is to either rebase your series on
> > top of -rc5 when the fixes go in or, if you want an earlier -rc base,
> > Marc can put them on a stable branch somewhere that you can use.
> 
> Here's what I've done:
> 
> - the two patches are now on a branch[1] based off -rc3 which I
>   officially declare stable. Feel free to rebase your series on top.
> 
> - the KVM fixes branch now embeds this branch (yes, I've rebased it --
>   we'll hopefully survive the outrage).

We don't have a choice to rebase.   I will rebased CS next on [1] and
apply this set on top of it.  Hopefully the KVM fixes will have made it to GKH's
char-misc tree by the time I send him the patches for the next merge window.
Otherwise we'll have to merge patches twice as Catalin mentioned.  We can deal
with that if/when we get there.

Thanks,
Mathieu

> 
> Thanks,
> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/log/?h=trace-fixes-5.12
> 
> -- 
> Without deviation from the norm, progress is not possible.
