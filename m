Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0843BA43F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGBTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhGBTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:12:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0BC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:10:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g10so1431971wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pmanh/l4RYPiMz9vtWN5vGxol6i2zbYeNRxTf6wlNo0=;
        b=h8lOkcy0Z6seVHPg996JrP6IqrpLp4pAriwUYYdNa41UYfO45lrwbhOoZ80NJRfQM6
         B2vXzas48bRn8XDOJMDNXxWs982fIRZvkU+9UArz0OnA/Qmp0ZhZsgRGgeYql9soQlaV
         BC8yeinu9wCkIMe04pvuj0eWLTY/yxagfdqUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Pmanh/l4RYPiMz9vtWN5vGxol6i2zbYeNRxTf6wlNo0=;
        b=b2T+zPek1/VsIvSx2lmwqt/tL9uiX/k0ujCbjYGfxiWQXtCzUmtXlFST/geZeub1ZM
         owSoiiFZ7TtMZn3gLm+fiz+hhuedGE7yanCTgh8Qq0RG7YQLnMJ8L0TyWayXvWQHdY+S
         npZ2C3KTKkzlLHT3YblYJLULuGNzbI1wed/PxThsiVgbhfcTABxBnH3bwDPJt8OgTn8v
         RyLioXmOZg8YNERdMwTpMLFLeAltOqpVF/FceGCUSGq+3UhjG0mQTlcxK5PVY2bI4N2P
         1BqZm/9D4GHS+iM71BtPlR3Nx99TetlE3KoIXcxy16q97apQACnf0w2Ox7i9dTV7GRdj
         3zwg==
X-Gm-Message-State: AOAM5320VayXMbLoy9xes4yeTE8ItL7VPaRhjxz8+KV4AxqcMby+uXyr
        FazDA5tXrkaEEBjsokPluQGLuw==
X-Google-Smtp-Source: ABdhPJy5BNnqGN0Fwpl5zTTbBdeJYST9zgAK6VB4zEBH02UqccbbJZ0NAQLXspAuKwm4Ob8x7p3meQ==
X-Received: by 2002:a05:600c:4f09:: with SMTP id l9mr1368996wmq.114.1625253021638;
        Fri, 02 Jul 2021 12:10:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d24sm9110479wmb.42.2021.07.02.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:10:20 -0700 (PDT)
Date:   Fri, 2 Jul 2021 21:10:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zack Rusin <zackr@vmware.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roland Scheidegger <sroland@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH -next] drm: vmwgfx: add header file for ttm_range_manager
Message-ID: <YN9km1dVs5Z1YDXJ@phenom.ffwll.local>
Mail-Followup-To: Zack Rusin <zackr@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roland Scheidegger <sroland@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20210630203252.32471-1-rdunlap@infradead.org>
 <8CB463FC-BF27-48CD-8843-975AE600DE35@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8CB463FC-BF27-48CD-8843-975AE600DE35@vmware.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 08:36:29PM +0000, Zack Rusin wrote:
> 
> 
> > On Jun 30, 2021, at 16:32, Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > Add a header file for ttm_range_manager function prototypes to
> > eliminate build errors:
> > 
> > ../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_init’:
> > ../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:678:8: error: implicit declaration of function ‘ttm_range_man_init’; did you mean ‘ttm_tt_mgr_init’? [-Werror=implicit-function-declaration]
> >  ret = ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
> > ../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_fini’:
> > ../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:690:2: error: implicit declaration of function ‘ttm_range_man_fini’; did you mean ‘ttm_pool_mgr_fini’? [-Werror=implicit-function-declaration]
> >  ttm_range_man_fini(&dev_priv->bdev, TTM_PL_VRAM);
> > 
> > Fixes: 9c3006a4cc1b ("drm/ttm: remove available_caching")
> > Fixes: a343160235f5 ("drm/vmwgfx/ttm: fix the non-THP cleanup path.")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > Cc: Roland Scheidegger <sroland@vmware.com>
> > Cc: Zack Rusin <zackr@vmware.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Christian König <christian.koenig@amd.com>
> 
> Thank you. That change has been part of drm-misc for a few weeks now:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=352a81b71ea0a3ce8f929aa60afe369d738a0c6a
> I think it should be part of the next merge of drm-misc to linux-next. If not I’ll port it to drm-misc-fixes.

It should probably be in drm-misc-next-fixes. drm-misc-next is for 5.15.
drm-misc-fixes was for 5.14 and will only reopen after -rc1.

See  https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
