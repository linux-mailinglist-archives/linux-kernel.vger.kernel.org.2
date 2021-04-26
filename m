Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042BC36BBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhDZWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhDZWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:50:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A73C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:49:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n138so90863886lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BE86LlYERkvmJYiNsABDYrzjneuUz4RD7Cva79mNvHA=;
        b=NB4jvfYRsIkA2OokO4HAv0Lj2VfrQZ1kNpneGGhegGrBlMenhZ0fQTpMan4C3MTD6J
         B7Aq5ZLlPjb/F0bR6fR7CUHQw4bQpxZxDMjOUF7MqJzZr+U1S1OllUDlBxIIeL1Eof9J
         ik2PB75A5bZMfpU6fOzm3bcLkLyyzzeQ8TmUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BE86LlYERkvmJYiNsABDYrzjneuUz4RD7Cva79mNvHA=;
        b=VamAzvRj7+ceKdXlFIOoWWLFAdjmSJUGdVuze0A6YyjY3AO4dAeE0WMQjaeyeZep3r
         DD4R7jAhJDEukuvXmjgVCEP4YMkUl0XLonKyh3e0VSgH41SBzK6fixhHp/USQI+Y1ESj
         49tyDlW4P8/iURQr6saaCH3FNO95rWGJmi2+vX3MKDhv+9PrnB4u9UhWhZ6VLiDC09st
         NjrYsIfgdiAvxn1H/IFHDwWYHBC8eVYrgajoaXM8TWCPgliEsGHQK/74Eo2e89j+lX1T
         J24krYDASMbqLTDmLImR0gPOIxLB9qFevJYF4T//tfDzJ3Y88rwEMSacgOEXRMLthVR6
         NuSg==
X-Gm-Message-State: AOAM532irJ1JlFdseZjobyzhH6prK2OhmU/PumbugpAVj7NrcL/pTVgg
        DJ4U17xLwE9tjCqdF7aJrpjhtYqghg1Sg0pt
X-Google-Smtp-Source: ABdhPJzIQsaei8Azb3in6Q2Fs5VO8QcG4nCpKbo4RjyaJ+3SKt2nJGYUy0D1SJrnflGKNXjvR0blUQ==
X-Received: by 2002:a05:6512:48b:: with SMTP id v11mr14036904lfq.48.1619477391217;
        Mon, 26 Apr 2021 15:49:51 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id r21sm145754ljm.47.2021.04.26.15.49.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 15:49:50 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x19so60358620lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:49:50 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr13960789lfu.201.1619477390616;
 Mon, 26 Apr 2021 15:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
 <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org> <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
 <151b7e41-a415-e780-eb90-6ca16c113066@skogtun.org>
In-Reply-To: <151b7e41-a415-e780-eb90-6ca16c113066@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 15:49:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjBEkOdj=C2HxjFu0zaKT46Yw52t7PyCCYFRaFdu57Sw@mail.gmail.com>
Message-ID: <CAHk-=wjjBEkOdj=C2HxjFu0zaKT46Yw52t7PyCCYFRaFdu57Sw@mail.gmail.com>
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 3:18 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> Photos of the screen with lockdep enabled.

Ok, so this is certainly not all of it, but the rest must have
scrolled off even the hw scroll buffer. But you've caught at least one
interesting  backtrace:

cfg80211_destroy_iface_wk() takes wiphy_lock
 -> cfg80211_destroy_ifaces()
  ->ieee80211_del_iface
    ->ieeee80211_if_remove
      ->cfg80211_unregister_wdev
        ->unregister_netdevice_queue
          ->dev_close_many
            ->__dev_close_many
              ->raw_notifier_call_chain
                ->cfg80211_netdev_notifier_call

and that wants the rtnl lock. Which it won't get, because something
else is holding on to it.

At a guess, there is some other sequence that takes the rtnl lock, and
then takes the wiphy_lock inside of it, and we have a ABBA deadlock.

<insert-shocked-pikachu face>

I _hate_ that stupid rtnl lock. It's come up before. Several times.
It's probably the most broken lock in the kernel.

             Linus
