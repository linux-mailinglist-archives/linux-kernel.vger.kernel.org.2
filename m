Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA39372FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhEDSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232289AbhEDSbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AA9EAF79;
        Tue,  4 May 2021 18:30:12 +0000 (UTC)
Date:   Tue, 4 May 2021 20:30:09 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: ERROR: modpost: "drm_display_mode_to_videomode"
 [drivers/gpu/drm/bridge/lontium-lt8912b.ko] undefined!
Message-ID: <20210504183009.GV6564@kitsune.suse.cz>
References: <e4r4g4R-yjH.A.CJE.0pVkgB@appolonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4r4g4R-yjH.A.CJE.0pVkgB@appolonius>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get errors about missing symbol in the lontium-lt8912b module.

Is the problem self-evident or do you need the config as well?

I don't need the driver for anything, it was just auto-enabled because
it's new and the change has not been reviewed.

Thanks

Michal
> 
> Last output:
>   WRAP    arch/powerpc/boot/zImage.maple
>   WRAP    arch/powerpc/boot/zImage.pseries
> make[2]: *** Deleting file 'modules-only.symvers'
>   MODPOST modules-only.symvers
> ERROR: modpost: "drm_display_mode_to_videomode" [drivers/gpu/drm/bridge/lontium-lt8912b.ko] undefined!
> make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symvers] Error 1
> make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-vanilla-5.12.0.13670.g5e321ded302d/linux-5.12-13670-g5e321ded302d/Makefile:1770: modules] Error 2
> make: *** [../Makefile:215: __sub-make] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.q1oSIp (%build)
