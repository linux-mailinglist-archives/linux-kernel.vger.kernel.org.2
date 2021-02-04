Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC45830F639
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhBDP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhBDPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:22:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118B3C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:21:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c4so3931236wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vA/eQ2S58koKaVheuxAPbUo6pEs5SmDGNUESF9JP+0A=;
        b=VYti8uRm2dyw6UwX8aXW2oV2DL1UgHJ4rEUzb5RzcktTeGTufd/d6F/gqYPL+qhzzB
         RbultCZ8rdkXrfv4yvMuSztOX25uVckOuykH+d7JKM2/E0RpttgrVpR7SmHbJbdaeBJ1
         j7qGj70tVfcriTnXNOaSQrt+1q1Qrvnt6P8UBoZsGxK8S4ub/SJ7y8Mo39VuSUfceYnA
         k6jIo7seCmvdOutxrRx0GGY9pwUF3U2ToL1Yfyfl2WWbZ3lSuBhls/u4duYxDl2al/Kt
         hgubF2KfhfiQEVHRSCSUHhDHkP4mE/UguAVhkpWdzOLG1kicazqjfQPDUNSyqYIRBZ+c
         cHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vA/eQ2S58koKaVheuxAPbUo6pEs5SmDGNUESF9JP+0A=;
        b=GfNOfN06KYqjleTapQ2aVeV94VYk/SLmhaUXJ4fTnWbWBvvYOYQ9bQLoirZuHusxQi
         dROO7wu5o++pa9dFbPpz6LYakH3CJyF30+N3r9AGB3Um8+qO2jhT9kpdCL4ejzXVd7HM
         bAP4MsS0n6masFlEKiGgIA9AG3rEP+f/kqgyPjueh37dP+dCm4mrIYH6iLKaJ5+4w8pb
         l38wz3lp3pHHF4ulU3Wt6V33UF1JfkborTmgwTRXbqLl4gq7O+FW8jrlPg1XI755g+N0
         Eoq6BxPZNzcz4+DFckCjtBC3jJZ84ttjqFrF2xiFy7ZYzIbe6b8Q9jMIGDWYAjzc6Dm/
         qMRQ==
X-Gm-Message-State: AOAM531f9Dvv7P+hIUdOmQvD9FjgLvYfi6U3hcHWr8Z6S0TalLfZ5fzm
        s5cr7/EfnrINMHSuZWNcIQsJdg==
X-Google-Smtp-Source: ABdhPJy0TbSsLuS/p2WzRPai8cnyw5jXXrUIeWK7iACJ/7tWSzo8KmbSSE4PPpWjajdKad9sJhaTuA==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr10448625wrn.382.1612452086502;
        Thu, 04 Feb 2021 07:21:26 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id c18sm19955797wmk.0.2021.02.04.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:21:25 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:21:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204152124.GO2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
 <20210204134606.GH2789116@dell>
 <20210204150904.GD4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204150904.GD4288@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 01:46:06PM +0000, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Mark Brown wrote:
> 
> > > The usual pattern here is that the MFD patches get merged and then I
> > > pull a shared branch in for any dependencies - at this point the series
> > > is now on the backlog of serieses where I'm waiting for the MFD to sort
> > > itself out before I really look at it again.
> 
> > I tend to push patches awaiting Acks to the back of the queue.
> 
> > Stalemate.
> 
> I'm only going to ack things if I expect to see them applied via another
> tree, that's generally what an ack means from a maintainer.  Especially
> with ASoC where we keep on having subsystem wide changes quite often I'm
> not likely to do that for things like new drivers unless it's very clear
> what the timelines are.
> 
> It would be enormously helpful to get the bits of the core MFDs that
> create dependencies committed while the rest of the series is still in
> process, as well as allowing things to be applied it also helps with
> knowing if the dependencies are stable.

The default point-of-view is; if a patch was submitted as part of a
set, it's likely that it makes the most sense to merge it as a set.

Very often sets will have inter-dependencies (usually headers) which
would otherwise require the base patches to be applied (perhaps the
MFD core and the headers) in one release, followed by the accompanying
child device changes during a subsequent release.  This doesn't scale
well and puts the contributor in an unfair position.

This is how we usually work together.  Why is ASoC so different?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
