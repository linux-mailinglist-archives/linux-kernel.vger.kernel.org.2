Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07570394D87
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhE2RaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2RaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 13:30:17 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC62C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 10:28:39 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y76so7681905oia.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Txcs3YFeNzDYzsA0ZUuZlG173cR4LBqYU6F9se91ggs=;
        b=G1++HgI3pg8aBznFUEW90kXhdIBCXi3zuCYkLZicztE6TKWHHtxqpvry0IEQBwtM4J
         XUYOx2Rc1i4otsZ+ufVfpjGuPyeGnOrDQOJBUg8I54QnXQGx7G1y5X2MSHce9Gqb88Qo
         aPuhIdZQDi7cjbwOMaZ9I9ItpE/QGwI6icG5Ij6ZYm9pOQ+iOjk/Cxj6285rd5hrBNVc
         7358OFDso7sLOUYMq79e+ko5vBf5yMyEql1geGFgBZv9HjlZ3ee6Pad1t+hpC8G+ekBz
         jOAvtHYkS/IdyFPewuc8hBuEWM/6vJGl3cd4aM9P6eF6H/2/+gFG7Ii+3HhuGqaaz0g0
         hvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Txcs3YFeNzDYzsA0ZUuZlG173cR4LBqYU6F9se91ggs=;
        b=ozShU56soHj8jARA5S8KeApNlHa4DTdYehx78hanxhAc8zw71jQxS/JwJDFBzk0ePo
         8n5AnojD3DxrJHtoaYOnYNXkfmYejbzWDoDkDnUuWS+Y64L4sPxuNFCEHvmh8w+LFmyx
         3bI1b5JF4Jkkeko0Q1/JvvEbnP35n1XR7W+BpW3G+fDAUTvbI36NTrCxZIzjq484cSPp
         7qO81qToO6bU+npBszF5SHTBvwwgppeNzsoHNb1BM20gYVjinlOxgomNYHegzzlm2f7D
         s6FP+TBwEldD7nZYAdDUPJpRKuO6xp0LTs9vloSYMi22qoNbSAsPl03rGRdqbt+/6uRR
         F+aA==
X-Gm-Message-State: AOAM533AAkCET7cmi9oS+LAj88bmENrOUuKyAF4a+m4QbUeF/nm/6gg8
        sZJHgqTtvJowYJjDcFaKSEEaXw==
X-Google-Smtp-Source: ABdhPJw8/M8F9TTOk0ZDz2cTfiTgAOr7vepXeqL2wntJ0xEhrxRb7nYqG4Fe7Fk2rblOJ3sJZflJ5w==
X-Received: by 2002:a05:6808:1496:: with SMTP id e22mr10141363oiw.78.1622309318970;
        Sat, 29 May 2021 10:28:38 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w198sm1776651oie.26.2021.05.29.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:28:38 -0700 (PDT)
Date:   Sat, 29 May 2021 12:28:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alex Elder <elder@linaro.org>, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: use freezable workqueue for crash
 notifications
Message-ID: <YLJ5xJ/xu/W+7xSB@yoga>
References: <20210519234418.1196387-1-elder@linaro.org>
 <20210519234418.1196387-2-elder@linaro.org>
 <YLBpmdZoGDXNz64y@builder.lan>
 <20210529024847.5164-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529024847.5164-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28 May 21:48 CDT 2021, Hillf Danton wrote:

> On Fri, 28 May 2021 09:09:12 -0600 Mathieu Poirier wrote:
> >On Thu, May 27, 2021 at 10:55:05PM -0500, Bjorn Andersson wrote:
> >> On Wed 19 May 18:44 CDT 2021, Alex Elder wrote:
> >> 
> >> > When a remoteproc has crashed, rproc_report_crash() is called to
> >> > handle whatever recovery is desired.  This can happen at almost any
> >> > time, often triggered by an interrupt, though it can also be
> >> > initiated by a write to debugfs file remoteproc/remoteproc*/crash.
> >> > 
> >> > When a crash is reported, the crash handler worker is scheduled to
> >> > run (rproc_crash_handler_work()).  One thing that worker does is
> >> > call rproc_trigger_recovery(), which calls rproc_stop().  That calls
> >> > the ->stop method for any remoteproc subdevices before making the
> >> > remote processor go offline.
> >> > 
> >> > The Q6V5 modem remoteproc driver implements an SSR subdevice that
> >> > notifies registered drivers when the modem changes operational state
> >> > (prepare, started, stop/crash, unprepared).  The IPA driver
> >> > registers to receive these notifications.
> >> > 
> >> > With that as context, I'll now describe the problem.
> >> > 
> >> > There was a situation in which buggy modem firmware led to a modem
> >> > crash very soon after system (AP) resume had begun.  The crash caused
> >> > a remoteproc SSR crash notification to be sent to the IPA driver.
> >> > The problem was that, although system resume had begun, it had not
> >> > yet completed, and the IPA driver was still in a suspended state.
> >> > 
> >> > This scenario could happen to any driver that registers for these
> >> > SSR notifications, because they are delivered without knowledge of
> >> > the (suspend) state of registered recipient drivers.
> >> > 
> >> > This patch offers a simple fix for this, by having the crash
> >> > handling worker function run on the system freezable workqueue.
> >> > This workqueue does not operate if user space is frozen (for
> >> > suspend).  As a result, the SSR subdevice only delivers its
> >> > crash notification when the system is fully operational (i.e.,
> >> > neither suspended nor in suspend/resume transition).
> >> > 
> >> 
> >> This makes sense to me; both that it ensures that we spend our resources
> >> on the actual system resume and that it avoids surprises from this
> >> happening while the system still is in a funky state...
> >> 
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> 
> >> But it would be nice to get some input from other users of the
> >> framework.
> >> 
> >
> >This patch is in my review queue - I should be able to get to it by the end of
> >next week.
> 
> A minute...
> 
> >> Regards,
> >> Bjorn
> >> 
> >> > Signed-off-by: Alex Elder <elder@linaro.org>
> >> > ---
> >> >  drivers/remoteproc/remoteproc_core.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> > 
> >> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >> > index 39cf44cb08035..6bedf2d2af239 100644
> >> > --- a/drivers/remoteproc/remoteproc_core.c
> >> > +++ b/drivers/remoteproc/remoteproc_core.c
> >> > @@ -2724,8 +2724,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
> >> >  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
> >> >  		rproc->name, rproc_crash_to_string(type));
> >> >  
> >> > -	/* create a new task to handle the error */
> >> > -	schedule_work(&rproc->crash_handler);
> >> > +	/* Have a worker handle the error; ensure system is not suspended */
> >> > +	queue_work(system_freezable_wq, &rproc->crash_handler);
> >> >  }
> >> >  EXPORT_SYMBOL(rproc_report_crash);
> 
> Given 1) system_freezable_wq is bound 2) the mutex_lock(&rproc->lock) in
> rproc_crash_handler_work() requires an unbound wq, the system_unbound_wq is
> the right candidate if no more wq is allocated under the rproc directory.
> 

Can you please explain why the mutex_lock() "requires" the context
executing it to be "unbound"? The lock is there to protect against
concurrent modifications of the state coming from e.g. sysfs.

Also, we're currently scheduling the work on the system_wq, which afaict
isn't UNBOUND either. I do suspect that your suggestion of moving the
work to an UNBOUND queue would improve concurrency in the event of
multiple remote processors triggering rproc_report_crash() from the same
CPU.

If this is the case I'd be happy to take the proposed patch and then
separately create a new unbound, freezable, queue in remoteproc (to
ensure we can bisect any potential issues).

Regards,
Bjorn
