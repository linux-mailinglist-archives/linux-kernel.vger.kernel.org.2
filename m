Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63562396A00
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhEaXPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhEaXPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 19:15:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33757C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 16:13:56 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j75so13660535oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfoWOw2lhqOWrpi1h7rk1py0R+xMzghqPnvRIcLt89A=;
        b=CKEC6RqlJ+yjZ43/8ooy8Fc1GSqSVu0EizUXmZF88PzAf0cvnBKyS6I2+H46Z6PH6b
         2DguJsVXTej7G6AqxkagLPwZZ0RRqJcNJBs3dgg7QK8EbTHb0H5yS0ARSiKUSpavl/Ju
         I1r/Vql1l+WzSfaAH4L+vOc+xZxJWn+Csyr/u1q/R13+yiPSChHlZj1vmZkr4W7WmfIT
         08vKUtTnSQgtWoPqxtqfJIWpHmduZGHk/mxQy8TyUStvWGzk/o5wduCL1obgosca0qJu
         +ZZF+JJjt1DhHYSpqFI4zJ2Kj7CNQqOHf6fDWW9XnmxC6P99H2Zet5HlhfSr0Z0X23cZ
         pcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JfoWOw2lhqOWrpi1h7rk1py0R+xMzghqPnvRIcLt89A=;
        b=QZ58piyplig3mL5u7bYpoNDtr0vWESRHJy581nqe9kus8D2fa+P/C8aBgHVyOSPWEp
         DezipOgcll9Q/JHyQky5Z3n+SV2f/0A6B8azLBAeJCrjkEgvv4/Z0NDIcsoc0UUtEtjZ
         AhjXrUeRnQxkR7zSqTWXVVKcY/+iymwlcKKi6SuXTIcBhhBSxkOqiZWQVBNmf/lnlD02
         4NvD2c46OdCrmbfZkr/vVafKDK2Tjyc1vjFzO2beNATqOZ9VrKFYCeiSqZ4xki2LyYFR
         2vkmYZyVbQ2IUTFYsxGJgiEASkrVasby+oQGNJpYy5NyW1Ayki4p5ETukN1Mh39iqffq
         24iw==
X-Gm-Message-State: AOAM530+o3tIgbmysFzC2CrNC+aLlEf4j1WLDq37TZiDjRLe11H3O0yn
        BxUoI2uvGWEBUbpB7XELjg7AwA==
X-Google-Smtp-Source: ABdhPJyamSr9qFbejRPIKOvh8De+WjtyRfJnkg92MQ5j0Ow+3tlvlq9v8Y5uPsJi8T2gtvRNzQJ+ZA==
X-Received: by 2002:aca:c488:: with SMTP id u130mr15635140oif.0.1622502835354;
        Mon, 31 May 2021 16:13:55 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c19sm3101878oiw.7.2021.05.31.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 16:13:54 -0700 (PDT)
Date:   Mon, 31 May 2021 18:13:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: use freezable workqueue for crash
 notifications
Message-ID: <YLVtsPNCr6dk9X0h@yoga>
References: <20210519234418.1196387-1-elder@linaro.org>
 <20210519234418.1196387-2-elder@linaro.org>
 <YLBpmdZoGDXNz64y@builder.lan>
 <20210531172153.GA1718330@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531172153.GA1718330@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31 May 12:21 CDT 2021, Mathieu Poirier wrote:

> On Thu, May 27, 2021 at 10:55:05PM -0500, Bjorn Andersson wrote:
> > On Wed 19 May 18:44 CDT 2021, Alex Elder wrote:
> > 
> > > When a remoteproc has crashed, rproc_report_crash() is called to
> > > handle whatever recovery is desired.  This can happen at almost any
> > > time, often triggered by an interrupt, though it can also be
> > > initiated by a write to debugfs file remoteproc/remoteproc*/crash.
> > > 
> > > When a crash is reported, the crash handler worker is scheduled to
> > > run (rproc_crash_handler_work()).  One thing that worker does is
> > > call rproc_trigger_recovery(), which calls rproc_stop().  That calls
> > > the ->stop method for any remoteproc subdevices before making the
> > > remote processor go offline.
> > > 
> > > The Q6V5 modem remoteproc driver implements an SSR subdevice that
> > > notifies registered drivers when the modem changes operational state
> > > (prepare, started, stop/crash, unprepared).  The IPA driver
> > > registers to receive these notifications.
> > > 
> > > With that as context, I'll now describe the problem.
> > > 
> > > There was a situation in which buggy modem firmware led to a modem
> > > crash very soon after system (AP) resume had begun.  The crash caused
> > > a remoteproc SSR crash notification to be sent to the IPA driver.
> > > The problem was that, although system resume had begun, it had not
> > > yet completed, and the IPA driver was still in a suspended state.
> 
> This is a very tight race condition - I agree with you that it is next to
> impossible to test.
> 

I certainly appreciate to see the upstream kernel be put through the
level of product testing necessary to find issues like this.

> > > 
> > > This scenario could happen to any driver that registers for these
> > > SSR notifications, because they are delivered without knowledge of
> > > the (suspend) state of registered recipient drivers.
> > > 
> > > This patch offers a simple fix for this, by having the crash
> > > handling worker function run on the system freezable workqueue.
> > > This workqueue does not operate if user space is frozen (for
> > > suspend).  As a result, the SSR subdevice only delivers its
> > > crash notification when the system is fully operational (i.e.,
> > > neither suspended nor in suspend/resume transition).
> > > 
> 
> I think the real fix for this problem should be in the platform driver where
> the remoteproc interrupt would be masked while suspending and re-enabled again
> when resuming.  The runtime PM API would work just fine for that...  But doing
> so wouldn't guarantee that other drivers, i.e IPA, would be operational.  Unless
> of one is a child of the other or using a bus like mechanic, and getting
> to that point will introduce a lot more churn than what this patch does. 
> 

Disabling the related interrupt(s) would mean that if the modem
remoteproc firmware crashes while Linux is suspended we would not know
about this until the next time Linux resumes. The expected outcome of
this would be that until something else happens to wake up Linux you
won't get any notifications from the network (i.e. no phone calls, text
messages or incoming notifications)

Regards,
Bjorn
