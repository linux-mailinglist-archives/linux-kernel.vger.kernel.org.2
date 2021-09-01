Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233DB3FDFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbhIAQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbhIAQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:27:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D3C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:26:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x16so241913pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hgzfNBuOob+Yb8is4RvbG2NjJQshRPX38LxF/VGR73E=;
        b=hjGYmhkuWY9p0ENYWEopNp140TH9B5FMjY+n0w1oIusD4RUD6oAN4ZGD9T70Ydog6K
         LCzTHkyO3acV7GZVFbLtiZH9tmsb7525x9O4jNMvDjhC1R69qUApcmnq1GSebE/mI5hf
         8ZcZtaTs5+YtgJV6LJEpzib2qdydXqRz9VJFqX5IYHeGg/1gZ/dWsTi5Vg1gJnxi09r0
         zEAWHdkS9nzdWrxpfMr8y+nUKKzSEGyQhWcNVrVbs1wm+XddtrzLfcbr0T1pKmayKir0
         yth24sErPewPwQY9bE83MOgofDgqG5lnuhBbdohiEXxke21i8Tkr54wZ/eS4OVcyn0d5
         P7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgzfNBuOob+Yb8is4RvbG2NjJQshRPX38LxF/VGR73E=;
        b=q4MJd1VER93P7RBdPGZ4kyy6EIEMoFFOfqS/qrWemHIKB8WGRZSjfVqmNjnzsbjVZK
         2r+Iz4qXNOhB1oVraD9I5OBJJn7wI10mJBoRrIhBHl/eN5SVE96FMbnkuEsoDFWCf8kr
         QuDW72gafmpJsHaL/oVC+TYF1VDYnmrn9fYJtxez0lO5DgUL9GTgQT92e6GNMOlwsRMA
         9lGKeh7AzAxwKxkt3aleg/kN5zZM4tiSMIHdc+DpH23CywJedU+egJdRJcrZZxP5hUJ/
         4DWJvy7s6HiA9mcqU/79GS+r+wdEjcQiIhLag3Z87K3ztsSXiM6DiqCGm6+epOyH0Swq
         XpzQ==
X-Gm-Message-State: AOAM531BGtEZSBkFBKmxr/zSxk5tHISldODtzYYEB2WUZEuEO13JXMWp
        RwE4dy0RpHGvYxu+4oa/RUYJbA==
X-Google-Smtp-Source: ABdhPJz5cBWCm0fYq4ILWr+KSkCBVR7O+qKkiAsM27jiXTZ1ZujWlaT3uSrgc+RwyVmamJK0SlND2w==
X-Received: by 2002:aa7:9f5e:0:b0:409:dbf2:88de with SMTP id h30-20020aa79f5e000000b00409dbf288demr341340pfr.14.1630513586842;
        Wed, 01 Sep 2021 09:26:26 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s31sm26564pfw.23.2021.09.01.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:26:24 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:26:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: [PATCH 0/2] Add Coresight support for RB5 board
Message-ID: <20210901162621.GA1035558@p14s>
References: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
 <CANLsYkxw9nXb=vsWhf8=Sf6Bnm23doTaYOS7WChxOGhudt23-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxw9nXb=vsWhf8=Sf6Bnm23doTaYOS7WChxOGhudt23-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Mon, Aug 23, 2021 at 08:41:36AM -0600, Mathieu Poirier wrote:
> Hi Tao,
> 
> On Thu, 19 Aug 2021 at 03:29, Tao Zhang <quic_taozha@quicinc.com> wrote:
> >
> > This series adds Coresight support for SM8250 Soc on RB5 board.
> > It is composed of two elements.
> > a) Add ETM PID for Kryo-5XX.
> > b) Add coresight support to DTS for RB5.
> >
> > This series applies to coresight/next
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >
> > Tao Zhang (2):
> >   coresight: etm4x: Add ETM PID for Kryo-5XX
> >   arm64: dts: qcom: sm8250: Add Coresight support
> >
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 442 +++++++++++++++++-
> >  .../coresight/coresight-etm4x-core.c          |   1 +
> >  2 files changed, 439 insertions(+), 4 deletions(-)
> >
> 
> I have added your work to my patchset queue.  On the other hand I have
> a lot of patches to review these days and as such won't be able to
> look at it for 4 to 5 weeks.
> 

I see that Suzuki has already provided comments on your work.  As such I will
remove this patchset from my queue.

> Thanks,
> Mathieu
> 
> > --
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >
