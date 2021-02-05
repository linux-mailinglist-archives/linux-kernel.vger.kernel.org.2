Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD8310F37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhBEQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhBEQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:11:51 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED9C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:53:33 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y4so7520864ybk.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yyoc99buBNFjurCaW/whYy79AAlTl7S/tHuz1PuZ6rI=;
        b=RNlI3uvyWjwmLWgBHaS/45B4svMCSXu4HfvBQ26eWi6til6I2ADoIArRShwLABIfe9
         2BRgu7DTI+5PaZvPUF/EqYWUNTXESJHlSuFCFSTflAIV60LFWtIy2p2jXpsWqpVhxV+h
         Osp0HOf5ThOwmbo0m7NI2Vsv8JurXipUKhWm1KHHEM04uBTYR1Ct3N50gETk/wTcg0/n
         BOh7WlWX7N6rUf8bvO7CIuX+LyODJrF+/liuF7ZgOkKNEYUy3zS50s1BKfgaOwK4KL+1
         YQVIqZk4aK51xwyy7ZSmwyaYEbQTZEoQipgBJUnnKUuXJnnr0nd2QfwvJHuqYalgWUep
         BLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yyoc99buBNFjurCaW/whYy79AAlTl7S/tHuz1PuZ6rI=;
        b=PhIGDjlKBzMJyg35p5UfaPxbGSP6hpxUvCOWvqxIIfUlAEMgBmo9QcqGNTqdiPUO4O
         GZljXzBj8RyvzqA1oimgkVfcXeGlOA9r1TTHzWOXw1bzFdJtd7xQ+1s3lCrnlOQAmIFJ
         LU5zxNMSTDV4avDkKfqMUGKVVZY5i0A/A5SoTVg9tkFWcDnlSI1jspew+GQEST3P2Msg
         TdKkFs3kQYRE16xhw1TBb6SurQrd60MRbymwQ1OZYz/WDIxMCPvrG0DSXbFuJmWFJylZ
         SLoPWy7sm7H6otk8LElO4mr/y9nrr9jXAH8PF5Wlq/oQ9y7nVDXlviP3YDImsFDPcUsO
         i0Gw==
X-Gm-Message-State: AOAM532hUsVpJxdYARMAq+WWpLqyTUFA8fpu5Q/9UmZQ2AazQUzUPaxE
        No0VehJUlKdLWQ/phejgaMGCGbBipNNf2nzeO89hQQ==
X-Google-Smtp-Source: ABdhPJzftNh20E3+EK/eG+FkgVSmglKB8o6Y4ZKgI2ZSqeTfztNt0NB42LbGHh+yn517i+/7VYgeumlK4RjjphHSGOo=
X-Received: by 2002:a25:af0b:: with SMTP id a11mr1751981ybh.228.1612547612559;
 Fri, 05 Feb 2021 09:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20210205140649.733510103@linuxfoundation.org> <20210205140650.022247260@linuxfoundation.org>
In-Reply-To: <20210205140650.022247260@linuxfoundation.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 5 Feb 2021 09:52:56 -0800
Message-ID: <CAGETcx8q4WmpF1mT8uLHYQXnioDKFi0PL1wUuVOtCyCnvyvKhg@mail.gmail.com>
Subject: Re: [PATCH 4.14 07/15] driver core: Extend device_is_dependent()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> commit 3d1cf435e201d1fd63e4346b141881aed086effd upstream
>
> If the device passed as the target (second argument) to
> device_is_dependent() is not completely registered (that is, it has
> been initialized, but not added yet), but the parent pointer of it
> is set, it may be missing from the list of the parent's children
> and device_for_each_child() called by device_is_dependent() cannot
> be relied on to catch that dependency.
>
> For this reason, modify device_is_dependent() to check the ancestors
> of the target device by following its parent pointer in addition to
> the device_for_each_child() walk.
>
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://lore.kernel.org/r/17705994.d592GUb2YH@kreacher
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/core.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -96,6 +96,16 @@ void device_links_read_unlock(int not_us
>  }
>  #endif /* !CONFIG_SRCU */
>
> +static bool device_is_ancestor(struct device *dev, struct device *target)
> +{
> +       while (target->parent) {
> +               target = target->parent;
> +               if (dev == target)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * device_is_dependent - Check if one device depends on another one
>   * @dev: Device to check dependencies for.
> @@ -109,7 +119,12 @@ static int device_is_dependent(struct de
>         struct device_link *link;
>         int ret;
>
> -       if (dev == target)
> +       /*
> +        * The "ancestors" check is needed to catch the case when the target
> +        * device has not been completely initialized yet and it is still
> +        * missing from the list of children of its parent device.
> +        */
> +       if (dev == target || device_is_ancestor(dev, target))
>                 return 1;
>
>         ret = device_for_each_child(dev, target, device_is_dependent);
>
>

I think 4.14 device links API is so busted it's not worth patching
this. It's not a memory leak or any kind of security issue.

Stephan, are you seeing this issue in 4.14 or even care about it?

-Saravana
