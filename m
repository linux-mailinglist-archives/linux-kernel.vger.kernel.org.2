Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32F34060B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhCRMsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhCRMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:48:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D51C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:48:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m7so1353079pgj.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BofJtNQBNJ4TAm9k9nJlHtcjZFAjqPhR3+0IjCViRGw=;
        b=s8bOBbSrPBOMGD0lno8oDiDRlBcWxaTtvNB/ZuKophFtB2a9PbjOBOkWdlt7QTGXSG
         sYzly2DL9vAaQk55tSfL5WL5t40ZFN+ufb/wmBrgkdW7++twPejbsjNFfw3AkULJRDZe
         Rh4Y131oP24y4EK2LS1FOZED4vJ1kpUC/P6L6NIqK8xjdC2DYY6WGMsx6F3L+F8y0Wwq
         xtChmxtAHoCQ8k/wnZHIGMN2jAKgA1yLmC8sP6WWlemrQmscHhYaXE6v1vCJrNtjTvvT
         WlRbovQwsYt9P0v40+LL7stOp1qJgu74dvNYH7Md4yDsFDQ4TV8ujDK+pc2QPQvgRA70
         aWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BofJtNQBNJ4TAm9k9nJlHtcjZFAjqPhR3+0IjCViRGw=;
        b=qCvthSCQulj43ClkHR4nyxBdQCljGhYmu5i6GV/rcon6IBpu6l5KY2OdZWXoZ+tJu8
         zd25ooj9oqtM0Ydgxux5bQoCE1LIFEJhaIyYHhE0oPysOlF8x8Um8v6W/AjNqBvuQ3yp
         iVKccIe8lUW7+GOZYWsENg7WzS5Vfu1C+cdH9CgljOkJRFaQrB5kBXSePEu5EVC1EaTY
         Be16+dtZuAXhPaF4VZodVwrxzrUoxKl1oRy/Mcp7UtIDMSWdgUMdczJWMYbTcL1G5Y3Z
         xvH+M4JPjZMUL7WMqohYbUzpayLYbJhO3FuaSLp41MO0ljZ3TrIvD0LHe3tdKKKs70uf
         M+yg==
X-Gm-Message-State: AOAM5334cP/Tl/UIhxtvTMjwqJc9s9a4yKhxnHJ5024kUTFfQ7lJq2uw
        3JyTpOsVcA93gpWCnjtnD2M01mPb1bWTZRb1WFg=
X-Google-Smtp-Source: ABdhPJwFt95ZxZN7+6Qgkq7BjOLV+PPnNMeS0VmcuNwfFis8sqmOBM4QMXhk9okMRvo7CneCMcDa8AUSsHgJ1cWQZ1E=
X-Received: by 2002:a05:6a00:1596:b029:200:c2c9:95e7 with SMTP id
 u22-20020a056a001596b0290200c2c995e7mr3969922pfk.73.1616071694084; Thu, 18
 Mar 2021 05:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210318073921.13093-1-a.fatoum@pengutronix.de>
In-Reply-To: <20210318073921.13093-1-a.fatoum@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Mar 2021 14:47:58 +0200
Message-ID: <CAHp75VcFy1=p6x0nj6wC-tK5ph6Puvx++8aVALLC0WTrkoN8AA@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: clear deferred probe reason on probe retry
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>, stable@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 9:39 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> When retrying a deferred probe, any old defer reason string should be
> discarded. Otherwise, if probe is deferred again at a different spot,

probe -> the probe

> but without setting a message, a now incorrect probe reason will remain.

a now incorrect -> now the incorrect

> This was observed with the i.MX I2C driver, which ultimately failed
> to probe due to lack of the GPIO driver. The probe defer for GPIO
> doesn't record a message, but a previous probe defer to clock_get did.
> This had the effect that /sys/kernel/debug/devices_deferred listed
> a misleading probe deferral reason.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: stable@kernel.org
> Fixes: d090b70ede02 ("driver core: add deferring probe reason to devices_deferred property")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/base/dd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..e2cf3b29123e 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -97,6 +97,9 @@ static void deferred_probe_work_func(struct work_struct *work)
>
>                 get_device(dev);
>
> +               kfree(dev->p->deferred_probe_reason);
> +               dev->p->deferred_probe_reason = NULL;
> +
>                 /*
>                  * Drop the mutex while probing each device; the probe path may
>                  * manipulate the deferred list
> --
> 2.29.2
>


-- 
With Best Regards,
Andy Shevchenko
