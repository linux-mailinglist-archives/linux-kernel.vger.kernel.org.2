Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4C380DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhENQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:06:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:05:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c14so7884112ybr.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruPIv5USkCaSWpI3KLjEGN3su//M9Dbj/pp0Ulewoeo=;
        b=hrC3OaLFof3dbIeCSGPx1mOxNkwfEM2WnlZfN3Vh62gx0OaxAYnLFiM7YZTHOhN4tO
         +DFlZLZCbuZ/ljjLpLKbfgjv0+G5svoodsP775HAmRXBsO9bu561YLzUZgxi7lCZDv1Y
         QEl3Ut0bN/uw5Egu64HAUkqkjl8tLYnYkrp8T3SADPTkXjlff18S15zW4MjX4kjPjxhZ
         Szf2YHMk0YvKcgAW/YcDo/Vp4HheoMQgGB0nKpY0y3CAcBsML+CwzaijgQ5BRi+Qn5/0
         Oa3o8fyL3eL35V6hKaH+7uMNKkxboYBUufaBYFlWsJVMztqRMrSbeZ+/E6ZecPJdPYoT
         Zxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruPIv5USkCaSWpI3KLjEGN3su//M9Dbj/pp0Ulewoeo=;
        b=Q7IH7HsTTXg3cR50hNKbnuKcButibLAZVi8Kpsd/sc4NBDuhhcRien/kFGJHQL3IrI
         jkwQcPrTPiQ8UnQE8VtWdibqzrVbG8ouyuntsq7ln2bSC0fCd47oZK388IIYUoSnv3+O
         qjtpCQpQHiXbBEDRGr24UiodFbYIjOIA5jY8gkaGPAPAmosjbsvkHCTJoEZJBATFidDb
         iK9XIV2i9704zSl8gyT7wyYF/bhSZg/i0Gz4PwoGE85efZjbqL7sKXITeHix3GK3CiF6
         gf1YQ36443ae7YGnLrJjuanAG5P0oNUZ5pAWSGrE6B+99E09ZkJH7XRxz8HuXn4PqG4l
         OtRQ==
X-Gm-Message-State: AOAM532sGlF+XhvJeqAVBY8xj98lsTL3F0x4BE7Ybn9ejiAp1TTN+4Fc
        rZpgUNi3GbqEOJPo0xSRVX4AT7A1SNqG+psayfZ37fqQVvY=
X-Google-Smtp-Source: ABdhPJy23t01h7nSUhXeRd3peV2TYlZKS1EzHGCcQNNUrqO7VoL5QjOMGORh3pojSptJbQnXsptyZFebGVbPw70Q3Ug=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr6774751yba.228.1621008299043;
 Fri, 14 May 2021 09:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <11761395.O9o76ZdvQC@kreacher> <4326215.LvFx2qVVIh@kreacher>
In-Reply-To: <4326215.LvFx2qVVIh@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 14 May 2021 09:04:23 -0700
Message-ID: <CAGETcx87y-tpSaKRpugons1RZaPC-rdvdueUPuNFJHWDDyrNwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers: base: Reduce device link removal code duplication
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 5:12 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reduce device link removal code duplication between the cases when
> SRCU is enabled and when it is disabled by moving the only differing
> piece of it (which is the removal of the link from the consumer and
> supplier lists) into a separate wrapper function (defined differently
> for each of the cases in question).
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c |   31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -198,6 +198,12 @@ static void device_link_synchronize_remo
>  {
>         synchronize_srcu(&device_links_srcu);
>  }
> +
> +static void device_link_remove_from_lists(struct device_link *link)
> +{
> +       list_del_rcu(&link->s_node);
> +       list_del_rcu(&link->c_node);
> +}
>  #else /* !CONFIG_SRCU */
>  static DECLARE_RWSEM(device_links_lock);
>
> @@ -232,6 +238,12 @@ int device_links_read_lock_held(void)
>  static inline void device_link_synchronize_removal(void)
>  {
>  }
> +
> +static void device_link_remove_from_lists(struct device_link *link)
> +{
> +       list_del(&link->s_node);
> +       list_del(&link->c_node);
> +}
>  #endif /* !CONFIG_SRCU */
>
>  static bool device_is_ancestor(struct device *dev, struct device *target)
> @@ -854,7 +866,6 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(device_link_add);
>
> -#ifdef CONFIG_SRCU
>  static void __device_link_del(struct kref *kref)
>  {
>         struct device_link *link = container_of(kref, struct device_link, kref);
> @@ -864,25 +875,9 @@ static void __device_link_del(struct kre
>
>         pm_runtime_drop_link(link);
>
> -       list_del_rcu(&link->s_node);
> -       list_del_rcu(&link->c_node);
> +       device_link_remove_from_lists(link);

Remind me again why we can't do the synchronize_srcu() here (I'm not
too familiar with the SRCU API semantics)? Is it because
synchronize_srcu() can take indefinitely long? I just vaguely remember
it does some checks during CPUs going idle (which can be a long time
later) but I'm not sure if that's the earliest you can synchronize. If
it's not indefinitely long and we just need to wait for other SRCU
critical sections to exit, maybe we can just synchronize here and make
the code a lot simpler?

This function is anyway called in a sleepable context.


-Saravana

>         device_unregister(&link->link_dev);
>  }
> -#else /* !CONFIG_SRCU */
> -static void __device_link_del(struct kref *kref)
> -{
> -       struct device_link *link = container_of(kref, struct device_link, kref);
> -
> -       dev_info(link->consumer, "Dropping the link to %s\n",
> -                dev_name(link->supplier));
> -
> -       pm_runtime_drop_link(link);
> -
> -       list_del(&link->s_node);
> -       list_del(&link->c_node);
> -       device_unregister(&link->link_dev);
> -}
> -#endif /* !CONFIG_SRCU */
>
>  static void device_link_put_kref(struct device_link *link)
>  {
>
>
>
