Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94745413AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhIUTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:31:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42626 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhIUTbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:31:18 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSlSZ-0004Qy-Ih; Tue, 21 Sep 2021 21:29:43 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, hjc@rock-chips.com,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        geert+renesas@glider.be, airlied@linux.ie,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, daniel@ffwll.ch
Subject: Re: [PATCH v2] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
Date:   Tue, 21 Sep 2021 21:29:41 +0200
Message-ID: <2662894.r5Zzv63rEP@diego>
In-Reply-To: <mhng-4c5264da-5502-4947-b32d-e9008a79ee90@palmerdabbelt-glaptop>
References: <mhng-4c5264da-5502-4947-b32d-e9008a79ee90@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 21. September 2021, 17:04:10 CEST schrieb Palmer Dabbelt:
> On Tue, 21 Sep 2021 02:12:17 PDT (-0700), heiko@sntech.de wrote:
> > On Fri, 10 Sep 2021 20:43:18 -0700, Palmer Dabbelt wrote:
> >> cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
> >> unused function warning is triggered undner !PM_SLEEP.  This marks the
> >> function as possibly unused, to avoid triggering compiler warnings.
> >
> > Applied, thanks!
> >
> > [1/1] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
> >       commit: f7c57a4566115657c16fd6603b6ef8a21bae5194
> 
> I'm not quite sure where that lives, but is it applied on top of 
> something or is it merged from the tag?  Like I said a bit below this in 
> the original patch, this has started to break the build for me and I'd 
> like to pull it in as soon as possible.

The patch now lives here:
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=f7c57a4566115657c16fd6603b6ef8a21bae5194

This is the drm-misc tree, with the patch living in the drm-misc-fixes
branch, which targets the current rc-kernels.

drm-misc-* moves into the core drm tree and from there on to Linus.


Hope that helps
Heiko



