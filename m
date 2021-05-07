Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20D376754
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhEGO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhEGO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:59:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B8FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 07:58:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so10573641edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJHBifJjuAiUBB1fcY/7U2kOYy2ASja8+o2PqKZoRWE=;
        b=XNEPPEBhgMHMMsT4kse0qA8u5ggbNQ9EE3NN4Lfs+z6ha71Hchom0V+YsQgDt3374B
         UhX9hZXqoUY1i+Jmd3ueYBBXaJSi9jQMQonYfGwYp6ED3fCShZobGpP6aljtWvs9vbe2
         /7L1fJjh56JN1EbxZY01WGSjDx5pLk0cvVsbGiWkKpgDaV4fMQSuJ2cEI2g0MGwD15sM
         QZ99gEFOcCd9ypUYjXH4aJGHfKaomx0lni4YIi19FpQOvS3n9p6TV66hPzoSSzBBbA2Y
         7fJkLl8Qi9nlhU+iJLDveOHDabm38b4F0KGc0VGjVVrXANFmRZe4U6j/c07reOFgJ6Hy
         Y6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJHBifJjuAiUBB1fcY/7U2kOYy2ASja8+o2PqKZoRWE=;
        b=ARrqVX36EaX5unf6AGMYQ7XSeDluKuDMRMf35o5AuMH2mX4vVZcc9IW7J8B1k+HzNx
         r5DRlM+6Z3EQcNBDKhrl2jtMTtSJ4JwUoGkCDG/E2OKETKy6tCU2LMYs1+q+Qcj09myG
         Ldg//+8qtn5r8Rw7nO0FVMZdEbx3sbnCDHp8I+hhi6NYhHqqf9OcCxaKlJP7xgpiaVnd
         6mUrSMDpSyZhNHQ8l401icPaj6v0e9Jq51lWA0bGM01t1sEtO5fqiHLKSTTRyZlkb2hc
         1n4T6UWDY4AY1vEWXZw7NsnJAw7V953x47HBrleVZPc15Ac4+ERv7aXE7BLkdNmhNy8U
         Ywcg==
X-Gm-Message-State: AOAM533dt5TaB65lH7fo2ccR7OUnQfEUPjQipOLEtSTtZ0iW7nw8z1Sa
        j0GHacFqflouQTjIu4y7BnQ=
X-Google-Smtp-Source: ABdhPJwKTBoHHEGsXmBsKTt/zAlEpVBQULdCoEKocsz8PQ3XbcWNFsWC2MfypygtKruT+f+OYBtAdQ==
X-Received: by 2002:a05:6402:798:: with SMTP id d24mr11757288edy.275.1620399520090;
        Fri, 07 May 2021 07:58:40 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id cf10sm4308872edb.21.2021.05.07.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:58:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        amd-gfx@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dom Cobley <dom@raspberrypi.com>, linux-kernel@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [v3,5/5] drm/vc4: hdmi: Signal the proper colorimetry info in the infoframe
Date:   Fri, 07 May 2021 16:58:38 +0200
Message-ID: <3819038.KMkRtCgjlg@jernej-laptop>
In-Reply-To: <20210430094451.2145002-5-maxime@cerno.tech>
References: <20210430094451.2145002-5-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne petek, 30. april 2021 ob 11:44:51 CEST je Maxime Ripard napisal(a):
> Our driver while supporting HDR didn't send the proper colorimetry info
> in the AVI infoframe.
> 
> Let's add the property needed so that the userspace can let us know what
> the colorspace is supposed to be.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
> 
> Changes from v2:
>   - Rebased on current drm-misc-next
> 
> Changes from v1:
>   - New patch

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


