Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9A4554DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbhKRGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbhKRGmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:42:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09588C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:39:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so4370407plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMI94b/yAujS84g8LGbPIlO0F6a4sIjHraHl0xC9qbA=;
        b=RXZYLWj+1PEiNsO61vCWFGwgPlLIfFJ/upevq6+bkOm+yNbUGWjZVdGe8mFaTU0sRM
         4y768qWlDzmvJhLSqREaYUui+WYrgxAaAtWKOHZHxm400qFBLt3jQiJhyDM0cRj2xJkn
         T2BjmVR5eDgKUOgoyvHFP/0MhvHy/inHT2HKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMI94b/yAujS84g8LGbPIlO0F6a4sIjHraHl0xC9qbA=;
        b=Qg6lvX+fVOoKBscptrLYqCY24WjjJ4V0gf+b7CZGlhQToNcSzLcbD63+eJqfNtHXA2
         r8avejMPv6iAaYfd/4/lB2iWEIfGtJO8Vds96vewzqWS5qVZbmJIH6xDBaQRvHvUlpgX
         7PkiN+oOA9QchVkP7l4bxuihBNU1QgO/+jqhkvGUsEgUnAJAqznN1b5GNR0YQmY3VVUr
         /UxQkm6xTrL34fcYT5WoVdXxJgwTkmg7ncqwsV3G5nLPPgozH0q0vcsp+SyPdb+JXrl9
         bwjGkK4ZIIrQWWu5MJBImxo/Zf0JvIdNjoq9uKZHaJO6GfjVtksSc0WC1k4R6OOFPZuv
         gkeg==
X-Gm-Message-State: AOAM530C+YC0TRT+DjAIpU4qc1lUfsUrIaRFDwTHn+x1XeqME75vHCpL
        pJPGQF3u4VQ0/TSrqIS+RtEmpxm+J5I3/40FM2VKZw==
X-Google-Smtp-Source: ABdhPJxaTW+u+s1H+E8ZH+9vokchEDm3K3lC/3RDIg6F87zyZurnpOQ1SBHlrNPn0pFuECkb0RNA1ePDFrAYegdbiOg=
X-Received: by 2002:a17:903:185:b0:141:f5f3:dae with SMTP id
 z5-20020a170903018500b00141f5f30daemr63792446plg.56.1637217585625; Wed, 17
 Nov 2021 22:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20211103234018.4009771-1-briannorris@chromium.org>
 <20211103164002.2.Ie6c485320b35b89fd49e15a73f0a68e3bb49eef9@changeid>
 <CAKMK7uHGNrgqjQh3DX4gChpNt+xhB_39sVrhdA3BFqnoW-ue2w@mail.gmail.com> <CA+ASDXPtWsZRTUmrGQKY2Sc-yaeg=e47QpkYWA=KpN5iYGafjQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPtWsZRTUmrGQKY2Sc-yaeg=e47QpkYWA=KpN5iYGafjQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 18 Nov 2021 07:39:34 +0100
Message-ID: <CAKMK7uHS0vhZDk4d4MyBr1fJGitosmPXB21pJq6992nRCBnkoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/self_refresh: Disable self-refresh on input events
To:     Brian Norris <briannorris@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        linux-rockchip@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 8:37 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Nov 17, 2021 at 11:12 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > Can you pls resend with dri-devel on cc? scripts/get_maintainers.pl
> > should pick this up, you have all the maintainers but not the list.
>
> Oops, I don't know how that happened. I guess I sometimes have to trim
> get_maintainer output, since it likes to hoover up a bunch of
> barely-relevant previous committers. I must have been too aggressive.
>
> I'll plan on sending v2 to dri-devel, but let me know (privately if
> you'd like) if you'd prefer a pure RESEND of v1.

Nah just for next version is fine, assuming you include all the
context in in-patch changelog and all that so new readers can catch
up.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
