Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D218419F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhI0T71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhI0T70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:59:26 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0BC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:57:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s69so27027430oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ONQHO/Bzi5LFkOtwJS2vhWiuGqb/wIXJtxU1fHbPl8=;
        b=Wb7xiO1cI0MfWuS+695CXwjxtBdtVtrQvJDK9SFDz1vxh7CK3HOiUog8QJXp6qtWBL
         EL1KbLzoz+pYkbwOA24q0ibT8HzvO7QIIcPl35X9CIzWQzBHd2SS/aJR089sVLOfem9+
         i2BXO4Fe4jZMytYXFF4Gv74oA+ImkhvoOKDMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ONQHO/Bzi5LFkOtwJS2vhWiuGqb/wIXJtxU1fHbPl8=;
        b=SOEEoFMLGHrKoqItd2TH6Wc+MxUfpeSoaF0SQiagVX66gjvLILgtJWmIF6hzUGQWEf
         14sKxSEqRR77/nBzDnK1bzQ3vawouJt9SGQH9yfrkklr3R7sZnBGSHv83VSkrXWRIh56
         4asHjA0fS0W5JNzcUCGK4Kmg+n+2SXXU5MJd3TEEkGRI0WujXJUmQSYYLg/fgtzDwjqp
         IjFqoYdq8CLYs7CjvYE9GRTU0tCYHCtVHEk+CCdOPpIy1vLJLtVXsQ7+yS3NuXKDWdyZ
         TDcE9RPl3g32ReQOKoARzlcP2OWeecaZHbq8WJpHB+E8YIgmRM/+794f7YLegryrGb9g
         psxg==
X-Gm-Message-State: AOAM531KueI/P/6VwZbx2GgO9fmQh/8a9tei5CmxZQbh+H+zMgibo5sv
        3/NtrVGumHj0a2/bFWA+YxnrYtUyEQyYVQ==
X-Google-Smtp-Source: ABdhPJxOm0G30HnGLSO8qGBvyWshvoDafAy7Gss7KAn5RJe1ujwErEKQWdySdziSLw5P3xmbC6P9qg==
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr697938oib.39.1632772665787;
        Mon, 27 Sep 2021 12:57:45 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id 21sm4169567oix.1.2021.09.27.12.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 12:57:45 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id v10so27025777oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:57:44 -0700 (PDT)
X-Received: by 2002:a54:4393:: with SMTP id u19mr659705oiv.77.1632772664480;
 Mon, 27 Sep 2021 12:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210927175944.3381314-1-briannorris@chromium.org>
 <20210927105928.v2.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid> <CAMcCCgS_r17Lj_qPX9TdH3=7D_tiXu9OzL=dDNS+9MZyOUv-+Q@mail.gmail.com>
In-Reply-To: <CAMcCCgS_r17Lj_qPX9TdH3=7D_tiXu9OzL=dDNS+9MZyOUv-+Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 27 Sep 2021 12:57:33 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMyaWfg07UEcbN_N4WBK=PzVO+SnwZ=VnjL2hJDWvOxDw@mail.gmail.com>
Message-ID: <CA+ASDXMyaWfg07UEcbN_N4WBK=PzVO+SnwZ=VnjL2hJDWvOxDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/rockchip: dsi: Hold pm-runtime across bind/unbind
To:     Tom Hebb <tommyhebb@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        aleksandr.o.makarov@gmail.com, stable <stable@vger.kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:18 PM Tom Hebb <tommyhebb@gmail.com> wrote:
> Reviewed-by: Thomas Hebb <tommyhebb@gmail.com>

Thanks!

> Thank you for catching this, and sorry that my original fix broke things.
> There had actually been a report of this breakage from my patch, but I
> missed that email until it had already been merged and then didn't have
> time to follow up on it. Totally my bad.

No worries. It was a 1 step forward, 1 step backward kind of a thing
anyway -- things were broken in many cases before your patch too (with
very similar-looking symptoms) -- so the net result is still good,
having both issues fixed.

I'm not sure how that ideally should have been handled [1], but it's
totally fair to not have time to follow up on everything. At the
worst, we could have reverted things; but again, I'm pretty sure
things were broken just as well without your fix, just with a
different root cause.

Regards,
Brian

[1] Don't accept (or, revert?) your bugfix until what may or may not
have been a regression is fixed? I'm not sure.
