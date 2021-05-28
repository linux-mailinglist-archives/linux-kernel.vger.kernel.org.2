Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECE393C20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhE1D4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhE1D4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:56:42 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6021C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:55:07 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2316357otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=th3cMW/uHqfkYc4UAOg+68J71gkXcehibaZ/5iZlr+s=;
        b=xBfmnwAvVEUMVB/IoBr91C77WEN0JHUM8/mdBFp5ZizTxDt+Mv6uWo0VjT8fzACfEs
         XtVuTNhwb2YaLBZtFccc8jGKJpTcQTO9mkadStybxRRlDqbufgp88Gxc6KQtYWHhzve9
         QGkAvnIzkVk2BSpKrf6De3UXb0a+5GPd3oLxRfWkdljlXF2sD1OL1siIApk7/v14MJw+
         K6MSgJu8dghGFKRzzBKk/RyTYm6kZcYp6cqH1bfk1HjSaDJjlQE5kgKkyFLxnW5/tlP5
         EU1CcbTS04Q5shgEuch0xXhwTzHmmwSTW9hPvpgEz7GUSYPa2Gj8jcgkUxDPOA7nMejn
         6FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=th3cMW/uHqfkYc4UAOg+68J71gkXcehibaZ/5iZlr+s=;
        b=op9jK+KeULPIeMtD0ymfXacEunFSid1QzFLbCUUASsSTkK6cN7Ns/Q/ZxMyk8q3vA8
         Lq5IuVZUs5B2DAYfU9PIwPoMy6J4jIVAb0YJ4MPENJWfy3b5TGYbjVwufRG+A/sP9XQt
         16ezDihxzwlcPTQTBBFHytl5xkcakEGddi4e2A4YpmeAja+6IGVTP0ZW811qNdz3+juW
         QXBLMVvD/JOGOvW2oKoqQwaPeoCkoZBejO0d0dhsgrU8SksYbhy3jO+vSBzjoGar0tN0
         9aQuMB9RgOnnxxWlNt7DEWvm/0s70wx7oB9k8mSUXqzUf7RnYU66Xn1W1d4Hpk6m9nmQ
         AF9A==
X-Gm-Message-State: AOAM533yI5T6FrqNHJGj/XpxTLOw9NCJZaD6m/AFIlqg+75PPtv25rk9
        ZHWPHJ7klKKloiiL+CDW0QSBiQ==
X-Google-Smtp-Source: ABdhPJyDjy4sDP0bdooOXQLn6eUpfZaVIiDaLEexdnEGytBrx8jC2j+YdBBJpdpi5+1rOt/08jbEgw==
X-Received: by 2002:a05:6830:20ce:: with SMTP id z14mr5570554otq.87.1622174107241;
        Thu, 27 May 2021 20:55:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z15sm922202otp.20.2021.05.27.20.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 20:55:06 -0700 (PDT)
Date:   Thu, 27 May 2021 22:55:05 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: use freezable workqueue for crash
 notifications
Message-ID: <YLBpmdZoGDXNz64y@builder.lan>
References: <20210519234418.1196387-1-elder@linaro.org>
 <20210519234418.1196387-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519234418.1196387-2-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 May 18:44 CDT 2021, Alex Elder wrote:

> When a remoteproc has crashed, rproc_report_crash() is called to
> handle whatever recovery is desired.  This can happen at almost any
> time, often triggered by an interrupt, though it can also be
> initiated by a write to debugfs file remoteproc/remoteproc*/crash.
> 
> When a crash is reported, the crash handler worker is scheduled to
> run (rproc_crash_handler_work()).  One thing that worker does is
> call rproc_trigger_recovery(), which calls rproc_stop().  That calls
> the ->stop method for any remoteproc subdevices before making the
> remote processor go offline.
> 
> The Q6V5 modem remoteproc driver implements an SSR subdevice that
> notifies registered drivers when the modem changes operational state
> (prepare, started, stop/crash, unprepared).  The IPA driver
> registers to receive these notifications.
> 
> With that as context, I'll now describe the problem.
> 
> There was a situation in which buggy modem firmware led to a modem
> crash very soon after system (AP) resume had begun.  The crash caused
> a remoteproc SSR crash notification to be sent to the IPA driver.
> The problem was that, although system resume had begun, it had not
> yet completed, and the IPA driver was still in a suspended state.
> 
> This scenario could happen to any driver that registers for these
> SSR notifications, because they are delivered without knowledge of
> the (suspend) state of registered recipient drivers.
> 
> This patch offers a simple fix for this, by having the crash
> handling worker function run on the system freezable workqueue.
> This workqueue does not operate if user space is frozen (for
> suspend).  As a result, the SSR subdevice only delivers its
> crash notification when the system is fully operational (i.e.,
> neither suspended nor in suspend/resume transition).
> 

This makes sense to me; both that it ensures that we spend our resources
on the actual system resume and that it avoids surprises from this
happening while the system still is in a funky state...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But it would be nice to get some input from other users of the
framework.

Regards,
Bjorn

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 39cf44cb08035..6bedf2d2af239 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2724,8 +2724,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -	/* create a new task to handle the error */
> -	schedule_work(&rproc->crash_handler);
> +	/* Have a worker handle the error; ensure system is not suspended */
> +	queue_work(system_freezable_wq, &rproc->crash_handler);
>  }
>  EXPORT_SYMBOL(rproc_report_crash);
>  
> -- 
> 2.27.0
> 
