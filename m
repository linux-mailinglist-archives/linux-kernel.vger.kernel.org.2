Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98A43D2110
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGVI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhGVI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:58:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A6C061757;
        Thu, 22 Jul 2021 02:38:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n11so3811614plc.2;
        Thu, 22 Jul 2021 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuMbiBM7YxAW87DH+qAJXu3APZbrJ75lW5QQXZfYU58=;
        b=ajsfwRT77Z9EbNaVAyA9I8jZs3BGroEX6WOi0qane/rs14eli9dewk2pAfpz8+X5HS
         MtTAhJ3j3UMZtcKTjtMbrdMlDq4vi4gEFeAr5GGCf9oj0s0nsIySOKsw5sJ3uLrmZe2X
         fWnADyjgnxDkNTOKTTe6JJwAQ4tWVdd45f7bdxhe0j6LEklVk+8g+6nC4mUvoV8VH42A
         Jm5q1MDUiggF8dXIMqceZCBG1atwLlxTwjXsXQO+OIGu2HE/LYCygEdiC9ujPfhBfNMk
         xMAvjfxjs1ABEdRKz1lCug4NiQhmW7udUIUERo8jaeNy+VN4p5Fukn+ygkd9UkRwLJV5
         DvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuMbiBM7YxAW87DH+qAJXu3APZbrJ75lW5QQXZfYU58=;
        b=sIN920SrEtUo770T4MAwEGtM5AeGUdp6kgmbFef/IMoS67FIRGfNoO0WsPJy2gGlSw
         VZLQlIkTJsVzFjxUT/b5Wyx/9qd8ycDlVkgKMmj15YC8fkUze4MwH22cYgitxJy2XUSH
         Iwx9jsPtvmRVqo8eZlUANIiDfHT+SZp9UAql17nSZ8+XD7Pw52xe5aJMzibZwKHWx8JJ
         HHfYPI6FIfIuyN+3EQ4tDilrZcW6AnFch29RaSHgXOkusS5vqtCGiyOZsQ7lKomGX2r7
         kSaYRrc6Z67b1OQ4KxMof4Vc0jb7ITsxWyOvPW0EMsBPH87K6FtfoZl+BReW7MjXJ8a5
         4w4Q==
X-Gm-Message-State: AOAM532Da/d2mP/hbv3nr+nysCHNBgKNZLT7NHMVvKQ93jPvto1Kr3vg
        yZEghl19RzkTVRdplvBKtQvtjJLXi8DzJeu+Reo=
X-Google-Smtp-Source: ABdhPJyzhzXA/hG7Rr1mBzyRkHYgREWpgxUI1OzzB5MR3T7ZAB+Szt3xEBP3jbpwYoMfsgxa8AtdYgJHpcudOKg+mKE=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr40486739pgm.74.1626946735354;
 Thu, 22 Jul 2021 02:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
 <20210716133448.24890-2-andriy.shevchenko@linux.intel.com> <9117e5212a3b743ca541918ec2b701c159ac752c.camel@nxp.com>
In-Reply-To: <9117e5212a3b743ca541918ec2b701c159ac752c.camel@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jul 2021 12:38:15 +0300
Message-ID: <CAHp75Vdm8nO-zT0vyKcB1hOXkR7_2RY-2P_fnkjV5BCc+uoqXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] clk: fractional-divider: Introduce NO_PRESCALER flag
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:33 PM Liu Ying <victor.liu@nxp.com> wrote:
> On Fri, 2021-07-16 at 16:34 +0300, Andy Shevchenko wrote:
> > The newly introduced flag, when set, makes the flow to skip
> > the assumption that the caller will use an additional 2^scale
> > prescaler to get the desired clock rate.
>
> As I mentioned in v1 comment, it seems to be good to decouple the
> prescaler knowledge from this common fractional divider clk driver.
> This way, we'll make it simpler and easier to maintain. Also, then, the
> NO_PRESCALER flag is not needed at all.  However, it seems that two
> Intel drivers which use the frational divider drivers will be affected
> and rate negotiation logics need to be implemented for them.  Please
> consider if it's doable or not.

The current driver works for the certain hardware without this change.
If you think it's better, submit a proposal we will discuss.

> If we ultimately keep the prescaler knowledge here, please consider to
> add the NO_PRESCALER flag for i.MX7ulp as it hasn't the prescaler IIUC.

You mean there is a code which is currently using this driver w/o
taking into account this prescaller flavour? Can you, please, point
out, I'll definitely update it. Thanks for the catch!

-- 
With Best Regards,
Andy Shevchenko
