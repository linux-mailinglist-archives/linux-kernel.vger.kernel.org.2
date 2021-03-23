Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C403460E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCWOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhCWOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:02:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:02:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so26781391lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ku+levvVxBeqKSuHI7QAU6DJ1TT9V2yW8FV3fTDnwwo=;
        b=Y4sDWZnWLFkjeVLPKdcxZ9yafDLWRrvFZTzPiEKg8gxPfH70ZCk6lCglyy8tJqxPpm
         AU4lNcx4+faeYBwKzIlFF4T6qnIGRbykR42u3VFqxtPO6JWxnNVvInx9PdC3LF06Ts+6
         DKLmuVRW3PKiaxdZjTm3r+/OS+peiAm9T0HuWfdibI8MUHClff3qHkYl3gLpx35sgFUV
         AugfY7kpJMUBLhaJrR0nfZ24txNcRqwFz2+Tu948DmtkSPGT3zsHP0iaQlibIA+4VTm7
         VMWQTj+XtpOKOy7fsBkZYAsUp9saldvz1XzJaer6qj266b4DYlaqDf0unUa+0cftwsFy
         wCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ku+levvVxBeqKSuHI7QAU6DJ1TT9V2yW8FV3fTDnwwo=;
        b=HzXCazIs7IPnp9iTpDqluWEWqtm4JAgWER3X/lFAs+ulucIgZAqBaeR+lVDfAcE4HC
         l8zetdHw7LGqCbbLZnEf9dfg1u3hYo2B56K05oenGcjB1o4/wjDe8/6p/WIFaZqnk+mk
         N4/roDed/nYpPpYmx7TvaDgSF6r8KYcoBxKdvJacxebwN8EfppiLTpyC0qjAIyAu6W+C
         ovE31VYrMhWd2aY5IW45vbnZAk+I9PpLaABAacK84YWz9j1GE8PUYc00MKOR/vv4ujN+
         kqje4MpBPr79jcjEtAY0xWep5F5xbGd0GNktBXpn073x9o973wswmCvXSgJxf5LXiWi+
         VHtw==
X-Gm-Message-State: AOAM532uG1pSkh6OMbNVvU9eKL9t7+iAVZZ8dgNLYHC8NYq5LhVZuN0u
        k/XdQmYJbfBFKE8ew8jeK6Wta7/Ko3GsECL1Y1I=
X-Google-Smtp-Source: ABdhPJysRw/CzY1wTwDNpPh0ik6UsRhl1MsyNfGxru2rIW2RG1tLkFLSGaeMeUgUm0BNDEhNCX9AVH9Ht53tDcclgd8=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr2564356lfu.443.1616508143271;
 Tue, 23 Mar 2021 07:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210323130550.2289487-1-arnd@kernel.org>
In-Reply-To: <20210323130550.2289487-1-arnd@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Mar 2021 11:02:12 -0300
Message-ID: <CAOMZO5AUJ=OjBwB=GA4Y0dy+oheHyzK3eVq+YCgT4HKEaQJhNw@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: fix out of bounds array access warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Joe Perches <joe@perches.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Mar 23, 2021 at 10:05 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_OF is disabled, building with 'make W=1' produces warnings
> about out of bounds array access:
>
> drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_set_clock.constprop':
> drivers/gpu/drm/imx/imx-ldb.c:186:8: error: array subscript -22 is below array bounds of 'struct clk *[4]' [-Werror=array-bounds]

What about making the driver depend on OF instead (like it is done in
DRM_IMX_HDMI) ?

--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -27,7 +27,7 @@ config DRM_IMX_TVE

 config DRM_IMX_LDB
        tristate "Support for LVDS displays"
-       depends on DRM_IMX && MFD_SYSCON
+       depends on DRM_IMX && MFD_SYSCON && OF
        depends on COMMON_CLK
        select DRM_PANEL
        help
