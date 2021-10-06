Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5C423991
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhJFITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbhJFITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:19:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E7BC061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:17:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m22so6290661wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wB5d45hEZgCS8nUqh0LAV78NiFyfDUuN0cP1eNzA80=;
        b=0qTl0YxZH/PurBcNGxfEdfTQovDp73AFaNSk+gowxYmrCRlyWZ2LUtwiubES+cyR9i
         /8ukLhpO7Px1N2M+x+eZvIviNHGDNz2xLlVY9PJRzDQfimQNU/M3UtpWl+Wux9KzOjCz
         UGACAadPLpQO7J8dnx3DCKqdvsT6MOp5iVWwMqw6PsWzNDO0bbEKVgDijZiDewjA7UB+
         HVdKSW14IVxobP/JojOmW6QsHJgO9HqIXIDJKD3tBJaIg7JUliYWa9wg5cYu/97sW+wV
         l3NBqcLc28Gxp3aI0+iMjf+uAR8lY6hmthQPGxe/SZtVOwtNi6qE87qTlmGxBXDxkwxH
         ehyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1wB5d45hEZgCS8nUqh0LAV78NiFyfDUuN0cP1eNzA80=;
        b=Ym40U9VPWkmgZJyCEP47N5SydRG5npliu/SdArD/x7E6vj+WnB3+c+9x/xOX3P4OAP
         +EYs0oYpYFxrj2y7q9GLmOAchvEsrVwQ6C9ylwGW5cRakMnkIj9PsQt+G+hchYJ0YMCk
         QuHXUeRzzS9JGZ3PdN9DcdweoVYPdYv6u895z1CXnMT74yxREVdhM6Oj1q2FC3sgmxlF
         O5IsoVr8OH22zMaSK94rVOwbLT4V/Boulb8m6vEnVBav66gSRXJLcxNWV9ngoUAOV0Ig
         dRT+mtzv4j2yopEi/IJ3VK1JtNLpeaVqtwO1fmqAuLlGZaD3xnKghydnDKBufewQr4X7
         zT9Q==
X-Gm-Message-State: AOAM531PLD9y0TqZRFFzOi9klC6r+zXXi0J5owfKRI2aAVvpdGjkvcqX
        Pqa40+53yl0R+I3ufTyNpHh3aA==
X-Google-Smtp-Source: ABdhPJzkoAuNsY3jeNMCa16QPGhdCvf7i034q/yhJmaxeWozjuYlTUadRYjNSZaSIOaWNjSPynmk6w==
X-Received: by 2002:adf:bc03:: with SMTP id s3mr27607106wrg.37.1633508228639;
        Wed, 06 Oct 2021 01:17:08 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:287f:efbb:492d:f66b? ([2001:861:44c0:66c0:287f:efbb:492d:f66b])
        by smtp.gmail.com with ESMTPSA id u2sm19593614wrr.35.2021.10.06.01.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 01:17:07 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] drm/omap: Add virtual-planes support
To:     tomba@kernel.org
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20210923070701.145377-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <5e60b305-dda2-ab9a-0954-f2d2b441667e@baylibre.com>
Date:   Wed, 6 Oct 2021 10:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923070701.145377-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/09/2021 09:06, Neil Armstrong wrote:
> This patchset is the follow-up the v4 patchset from Benoit Parrot at [1].
> 
> This patch series adds virtual-plane support to omapdrm driver to allow the use
> of display wider than 2048 pixels.
> 
> In order to do so we introduce the concept of hw_overlay which can then be
> dynamically allocated to a plane. When the requested output width exceed what
> be supported by one overlay a second is then allocated if possible to handle
> display wider then 2048.
> 
> This series replaces an earlier series which was DT based and using statically
> allocated resources. 
> 
> This implementation is inspired from the work done in msm/disp/mdp5
> driver.

Gentle ping, who is supposed reviewing those patches ?

Thanks,
Neil

> 
> Changes since v4 at [1]:
> - rebased on v5.15-rc2
> - adapted to drm_atomic_get_new/old_plane_state()
> - tested on Beagle-x15
> - checked for non-regression on Beagle-x15
> - removed unused "state" variable in omap_global_state
> 
> [1] https://lore.kernel.org/all/20181012201703.29065-1-bparrot@ti.com/
> 
> Benoit Parrot (8):
>   drm/omap: Add ability to check if requested plane modes can be
>     supported
>   drm/omap: Add ovl checking funcs to dispc_ops
>   drm/omap: introduce omap_hw_overlay
>   drm/omap: omap_plane: subclass drm_plane_state
>   drm/omap: Add global state as a private atomic object
>   drm/omap: dynamically assign hw overlays to planes
>   drm/omap: add plane_atomic_print_state support
>   drm/omap: Add a 'right overlay' to plane state
> 
>  drivers/gpu/drm/omapdrm/Makefile       |   1 +
>  drivers/gpu/drm/omapdrm/dss/dispc.c    |  31 +-
>  drivers/gpu/drm/omapdrm/dss/dss.h      |   5 +
>  drivers/gpu/drm/omapdrm/omap_drv.c     | 189 ++++++++++++-
>  drivers/gpu/drm/omapdrm/omap_drv.h     |  28 ++
>  drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++-
>  drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
>  drivers/gpu/drm/omapdrm/omap_overlay.c | 254 +++++++++++++++++
>  drivers/gpu/drm/omapdrm/omap_overlay.h |  41 +++
>  drivers/gpu/drm/omapdrm/omap_plane.c   | 375 +++++++++++++++++++++----
>  drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
>  11 files changed, 903 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
>  create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h
> 

