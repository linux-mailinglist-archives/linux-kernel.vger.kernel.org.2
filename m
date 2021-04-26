Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C209636BA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbhDZTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbhDZTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:52:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:51:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so9074035lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMzvlHcDZyhFhuFU4LQVJZGANy7uL1sDW1lbqH0JzZs=;
        b=N2Fr6hWobaYu03YnQPm2YLWVZI7Bx2LGRe8vIt/dwM5N8Rlkyh/l4kBKX+wWWmmFGT
         XyzIWofq/mFKqqtpyemWJR2+gwWrBSJkxj7tKycN6O2wqW6MdVxAY5xDxvGVLMr/LRLb
         1T3DIji8d+PN7Pj0RGGQINRTQFeshpbcg8RI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMzvlHcDZyhFhuFU4LQVJZGANy7uL1sDW1lbqH0JzZs=;
        b=Qg8h+/OxyQdj/nJrbvSEqcCEFZhSCyqOQdPpwKM4BptEm0YI6WTDm419d317uW/2Y2
         wJEAEfRZfquYQM+JCsFgJoq1JYbOQzKDEEHDFFEp2CyjsK1LE+5iKsmPembvGh5iBodg
         SpqTbUJqxIfn89JMkkcOjkQwhpiiFDSzAhm07y+0o+dBudUUfeEuy2BHm3nKiH6S/Vzl
         P/v5aHvyXdATrI4oihGE7mj4gM1PWeO+1x80cBPWCJRhoqsxZCxqGq5WgBx7w1JzdU2q
         r7ZpdTtah3BffGAe9Va8L3Iky3Cu/ngGpDctCmR0zI9MRHVegvqtXBWCpRYxSeYRQtdx
         ORZg==
X-Gm-Message-State: AOAM532pwFHfj54l0O3EGXa7T86jgIE44v2ecWpKuW46DX3Xr9XW1+c5
        9o7e9I+FJ73g4g+CClQW0ntQV2sVJAYNxvVd
X-Google-Smtp-Source: ABdhPJyNTs3p6+g+OfXPwJ1IglZWBUI/5k4nNb6Xps0LOSF7oWtAOf2HfeRaDHJCNKPlO602qb49gw==
X-Received: by 2002:a19:ee0b:: with SMTP id g11mr14144784lfb.455.1619466704168;
        Mon, 26 Apr 2021 12:51:44 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q187sm106314ljq.7.2021.04.26.12.51.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:51:43 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o16so65534257ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:51:43 -0700 (PDT)
X-Received: by 2002:a2e:954a:: with SMTP id t10mr13455344ljh.411.1619466703312;
 Mon, 26 Apr 2021 12:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
 <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org> <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
 <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com> <2cafd6d0c6378b36644d04fe263a53a866354574.camel@sipsolutions.net>
In-Reply-To: <2cafd6d0c6378b36644d04fe263a53a866354574.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 12:51:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwByiEUuO-NN=xHb4sxwCmP=tjB_vUHEebj8+-JGu8zg@mail.gmail.com>
Message-ID: <CAHk-=wiwByiEUuO-NN=xHb4sxwCmP=tjB_vUHEebj8+-JGu8zg@mail.gmail.com>
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:46 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Right. Maybe if it's modules, could try to remove them rather than
> reboot?

Yes, doing an 'rmmod ath9k'  (or whatever that module is called)
sounds like a good idea, it might trigger the same lockup.

In fact, that might be the reason Harald sees this - maybe Void Linux
tries to unload modules before rebooting, and other distros don't?

Unloading modules doesn't tend to get a lot of testing, it's a fairly
unusual operation (and not one that is guaranteed to be safe - yes we
do basic module refcounting, but it's very basic indeed, not full).

               Linus
