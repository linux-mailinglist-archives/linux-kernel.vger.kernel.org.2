Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B09373690
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEEIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232040AbhEEIph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:45:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 886BE611AE;
        Wed,  5 May 2021 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620204281;
        bh=z440MLLOO4SJA+ueCYGzYqDld3Rl/TPdNEGP6iE8Utw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8jcZziBFNTcFefF+TkDwjbao3SKwIkgiLelPlbex6qxJ0e7EX6Tct8B8NV5oIWRg
         bD5Ji/KrDk4q3AiWeSVTGYnKCoUlj/0VKXrerhcb2iPtcMELM2kCK3y/M8tBPsECXN
         QZP4Px8WqxrfVnIcm6m877//NZCw0r2XSTAzp8GuZB21B/lV87X1qOqonU4gaGEXUF
         2eaScP6o+Jfv9BuqiCU/WsxueRNZOmpvbiT6V7L3u2iR9yCpRtfU8LsTwguT+wAkvk
         qIyb0WIOV0JlsGDzAmqWvVimnpVjf0qLYPAEc+q/mO2Q8O2O1i/Sf8GRQDF9fyxmSg
         p7TgJigcRnVVw==
Date:   Wed, 5 May 2021 10:44:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
Message-ID: <20210505104434.7d7838f0@coco.lan>
In-Reply-To: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
References: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Em Thu, 29 Apr 2021 19:43:43 +0200
Julia Lawall <Julia.Lawall@inria.fr> escreveu:

> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_put_noidle call.  The patch
> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First of all, thanks for doing that! It sounds a lot better to have
a script doing the check than newbies trying to address it manually,
as there are several aspects to be considered on such replacement.

> 
> ---
> v5: print a message with the new function name, as suggested by Markus Elfring
> v4: s/pm_runtime_resume_and_get/pm_runtime_put_noidle/ as noted by John Hovold
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword
> 
>  scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> new file mode 100644
> index 000000000000..3387cb606f9b
> --- /dev/null
> +++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use pm_runtime_resume_and_get.
> +/// pm_runtime_get_sync keeps a reference count on failure,
> +/// which can lead to leaks.  pm_runtime_resume_and_get
> +/// drops the reference count in the failure case.
> +/// This rule addresses the cases where the reference count
> +/// is unlikely to be needed in the failure case.
> +///
> +// Confidence: High

Long story short, I got a corner case where the script is doing
the wrong thing.

---

A detailed explanation follows:

As you know, I'm doing some manual work to address issues related
to pm_runtime_get() on media.

There, I found a corner case: There is a functional difference
between:

	ret = pm_runtime_get_sync(&client->dev);
        if (ret < 0) {
                pm_runtime_put_noidle(&client->dev);
		return ret;
	}

and:
	ret = pm_runtime_resume_and_get(&client->dev);
        if (ret < 0)
		return ret;

On success, pm_runtime_get_sync() can return either 0 or 1.
When 1 is returned, it means that the driver was already resumed.

pm_runtime_resume_and_get(), on the other hand, don't have the same
behavior. On success, it always return zero.

IMO, this is actually a good thing, as it helps to address a common
mistake:

	ret = pm_runtime_get_sync(&client->dev);
	/*
	 * or, even worse: 
	 * ret = some_function_that_calls_pm_runtime_get_sync(); 
	 */

        if (ret) {
                pm_runtime_put_noidle(&client->dev);
		return ret;
	}

FYI, Dan pointed one media driver to me those days with the above
issue at the imx334 driver, which I'm fixing on my patch series. 

-

Anyway, after revisiting my patches, I found several cases that were 
doing things like:

	int ret;

	ret = pm_runtime_get_sync(dev);
	pm_runtime_put_noidle(dev);		/* Or without it, on drivers with unbalanced get/put */

	return ret > 0 ? 0 : ret;

Which can be replaced by just:

	return pm_runtime_resume_and_get(&ctx->gsc_dev->pdev->dev);

Yet, I found a single corner case on media where a driver is actually 
using the positive return: the ccs-core camera sensor driver.

There, the driver checks the past state of RPM. If the
device was indeed suspended, the driver restores the hardware
controls (on V4L2, a control is something like brightness, 
contrast, etc) to the last used value set.

This is the right thing to be done there, as setting values
to such hardware can be a slow operation, as it is done via I2C.

So, this particular driver checks if the RPM returned 0 or 1,
in order to check the previous RPM state before get.

In this particular case, replacing:
	pm_runtime_get_sync()
with
	pm_runtime_resume_and_get()

Will make part of the code unreachable. 

While it won't break this specific driver, It could have
cause troubles if the logic there were different.

In any case, I tested the coccinelle script, and it produces
this change:

 static int ccs_pm_get_init(struct ccs_sensor *sensor)
 {
        struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
        int rval;
 
-       rval = pm_runtime_get_sync(&client->dev);
-       if (rval < 0) {
-               pm_runtime_put_noidle(&client->dev);
+       rval = pm_runtime_resume_and_get(&client->dev);
+       if (rval < 0)
 
                return rval;
-       } else if (!rval) {
+       else if (!rval) {
                rval = v4l2_ctrl_handler_setup(&sensor->pixel_array->
                                               ctrl_handler);
                if (rval)
                        return rval;
 
                return v4l2_ctrl_handler_setup(&sensor->src->ctrl_handler);
        }
 
        return 0;

which will make v4l2_ctrl_handler_setup() to always being called,
even if the device was already resumed.

Thanks,
Mauro
