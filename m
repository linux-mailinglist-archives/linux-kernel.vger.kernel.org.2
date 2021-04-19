Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ACD3648B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhDSREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhDSREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC94611F0;
        Mon, 19 Apr 2021 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618851817;
        bh=4TN6AWyr8Mp46QNWs/wmku8VNsRtmirE+GdcjIHkR+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5iC93qFlmAZ+sfA95daecqActJGO2ozsNHyY3IJbUSE9VUjPcNhZw6InR0xXApNB
         z/hWndKm0MErsMRDcflV9k8FT2PnEh+NMJhrqEKfKAQLP4qg1VBFSbhUo0TR/QRd0S
         h5SXsFHKUuRjupDSP07DaAPsKEpHXOP5ldXHvraa4szt99jQ50m62NXw7xJxGr/4En
         WgzNgAcP2zdzj7Sb+JIWtJM6jnJ2gxkyabJ3xJ2gJ+Xum7RCk9O8d2DrWeVQa1op+J
         M7BXBL0vpVX13HcbczijCva5/aRG748Xorw+gdOQIgWUdbSXvIfA5iYjpr9eQwAJzE
         peoNKfRhDiEvg==
Date:   Mon, 19 Apr 2021 18:03:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>, yj.chiang@mediatek.com
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
Message-ID: <20210419170331.GB31045@willie-the-truck>
References: <20210330080615.21938-1-lecopzer.chen@mediatek.com>
 <20210330083218.22285-1-lecopzer.chen@mediatek.com>
 <CAFA6WYMqLMEG2s7OdNweQKkP0K2LZ575B1BVw-zfsg7_KBSM5Q@mail.gmail.com>
 <CAFA6WYPXu8biPPim5EoQ1pi+w3APKm65tzfOvH4OSORZdJ6+8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPXu8biPPim5EoQ1pi+w3APKm65tzfOvH4OSORZdJ6+8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 05:31:13PM +0530, Sumit Garg wrote:
> On Tue, 30 Mar 2021 at 18:00, Sumit Garg <sumit.garg@linaro.org> wrote:
> > On Tue, 30 Mar 2021 at 14:07, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> > > > > On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > >
> > > > > > With the recent feature added to enable perf events to use pseudo NMIs
> > > > > > as interrupts on platforms which support GICv3 or later, its now been
> > > > > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > > > > platforms. So enable corresponding support.
> > > > > >
> > > > > > One thing to note here is that normally lockup detector is initialized
> > > > > > just after the early initcalls but PMU on arm64 comes up much later as
> > > > > > device_initcall(). So we need to re-initialize lockup detection once
> > > > > > PMU has been initialized.
> > > > > >
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v5:
> > > > > > - Fix lockup_detector_init() invocation to be rather invoked from CPU
> > > > > >   binded context as it makes heavy use of per-cpu variables and shouldn't
> > > > > >   be invoked from preemptible context.
> > > > > >
> > > > >
> > > > > Do you have any further comments on this?
> > > > >
> 
> Since there aren't any further comments, can you re-pick this feature for 5.13?

I'd still like Mark's Ack on this, as the approach you have taken doesn't
really sit with what he was suggesting.

I also don't understand how all the CPUs get initialised with your patch,
since the PMU driver will be initialised after SMP is up and running.

Will
