Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C63D4408
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhGXACF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhGXACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:02:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA10C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:42:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp1so4835459lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdiEdCl11tN9UAOLZ3FMPR4kw5S1nl4qVLPulRI8atM=;
        b=UE+/OmZhAo/f3kfvcwa7Xvp9Uk/AQe6Mv3C05Lixni9UORysKj8vQ8mUDoOObrngIT
         AeP40zUy0GWnKPofO0DOzmbQBy2oJG706+XnbUyymNBwwCZ9UrxjWTrLWT7uy33Dt4Ml
         NQdedpeiBR1ooEy99KxEoAAGKnZ+exanG9p9ZqroOnl6TKrJGaZBB7+dYg6A2/V2eJ8I
         GF97XNxHnq1/LPQTFmTU/26TisYCZippyUUUbIv5Rha88NeZ2PzPleYGv2+eWwOj5Yt5
         wOTc3WH71tOR0qrg/eMRi1GdHM6gsOHhTjSGt7P3fcjpTvD7iV0LHOEb4ZCB0svJ5Lq9
         FN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdiEdCl11tN9UAOLZ3FMPR4kw5S1nl4qVLPulRI8atM=;
        b=rKiXHAA9jaSs2v4xL1z3YQkEz529cTQMFBVdasWdVXXGR9PFB5/rov3ORdRG2D7K0w
         MJFTcGU47QzyB/LZytSG4iaNob8fr/BSKs4SjOWtHctvyP91gJ0U5cz2IHgFP21NupDu
         VxWIYeK0zs2wCdYadkWxvTwdl4uHkhv91d/LTD89HvajMk0mYsd290hn7KgkwI6/sWm8
         Xq27CiSZ+P1Wk3PreRB5tPg2Li+L5ujh0QQXjRqhQLLeIU7Xm7hxGgrO8jEHpnz3MQOy
         GBbo5hw6RcNCoTT1VbxP1OPEmVayLxuWi3kNtZWoBtB1hPG29F3E+Wxg0vpyvNdpuIVJ
         GNFA==
X-Gm-Message-State: AOAM530zfa7TXYSB59X2cm5W0tyRsNmZnaIz7ZEem8CMBYVUVp6qqvn+
        EPECLysfoR/s/PpR/Co9SgMAlv50avN6V604bQO2oA==
X-Google-Smtp-Source: ABdhPJzf/lwbgTN9xu9k+Xm9g4eU8Q2voKV2VZHFHJDDDBNhSbVRm9DCfLop4Ntp66yzKIeepPxcduJgGfXwn89HbIc=
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr4752289lfi.174.1627087354944;
 Fri, 23 Jul 2021 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210724004043.2075819-1-rajatja@google.com>
In-Reply-To: <20210724004043.2075819-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 23 Jul 2021 17:41:58 -0700
Message-ID: <CACK8Z6GsNi9FVUdqdfj0vUFj0mJtMQ_pm4aPH8d3ozsa5Zswhg@mail.gmail.com>
Subject: Re: [PATCH v2] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixing the typo in the email ID for Greg).

On Fri, Jul 23, 2021 at 5:40 PM Rajat Jain <rajatja@google.com> wrote:
>
> For security, we would like to monitor and track when the thunderbolt
> devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> "authorized" attribute changes). Currently the userspace gets a udev
> change notification when there is a change, but the state may have
> changed (again) by the time we look at the authorized attribute in
> sysfs. So an authorization event may go unnoticed. Thus make it easier
> by informing the actual change (new value of authorized attribute) in
> the udev change notification.
>
> The change is included as a key value "authorized=<val>" where <val>
> is the new value of sysfs attribute "authorized", and is described at
> Documentation/ABI/testing/sysfs-bus-thunderbolt under
> /sys/bus/thunderbolt/devices/.../authorized
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/thunderbolt/switch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 83b1ef3d5d03..382128dfbdee 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
>  static int disapprove_switch(struct device *dev, void *not_used)
>  {
>         struct tb_switch *sw;
> +       char *envp[] = { "AUTHORIZED=0", NULL };
>
>         sw = tb_to_switch(dev);
>         if (sw && sw->authorized) {
> @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
>                         return ret;
>
>                 sw->authorized = 0;
> -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
>         }
>
>         return 0;
> @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
>  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
>  {
>         int ret = -EINVAL;
> +       char envp_string[13];
> +       char *envp[] = { envp_string, NULL };
>
>         if (!mutex_trylock(&sw->tb->lock))
>                 return restart_syscall();
> @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
>         if (!ret) {
>                 sw->authorized = val;
>                 /* Notify status change to the userspace */
> -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> +               sprintf(envp_string, "AUTHORIZED=%u", sw->authorized);
> +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
>         }
>
>  unlock:
> --
> 2.32.0.432.gabb21c7263-goog
>
