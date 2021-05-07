Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7102376751
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhEGO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhEGO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:58:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A777C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 07:57:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so10550912edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz08TtZQHN8WysDf1KSSv+J846ggMOVj0kzY1pDn55Y=;
        b=mevx2O5womNc6xFIEoqxVhmtxLhxKExcqHGouY3g4xlRa9Uz+e16jEau8C2tB07iEv
         Z50S/FXyPhQM76QElomJRreMwiozfL5ad6pkIjk+ll6pGw2xXrS2JAmjXY0/53BDkBoU
         Db9S3af17hp9zHcT5GroAXRG5YmFKfICZN/AcwUahxHvLQWLgSfa7MNj0MbhDWpmrGQs
         jU+H6WBUA/mvnTkB07AMea3TmW/8j5n9jkoEfiVroxHk1kfwAiyWu1RRuCtH34D+fnkO
         riVFuD+I0fg00s1KAAkVymZiHA5brIMVB7v9IuJ2nqhcLDEFIFkLz6y5JThHunskwrUx
         FYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dz08TtZQHN8WysDf1KSSv+J846ggMOVj0kzY1pDn55Y=;
        b=IibZ5bRie6BO89KlVoHOzppcHY09qa/OiVjcDke6NPB3Bmz966Xe+7+iM0kEUFfucg
         Qh/s/hJabyApcxHDFLzzzM4p2WpmXZPCGnsALqcqRqOMPRSJlzWjZTv32zEKNE1rgxHD
         h5MP3Iw6QuD70cdK9ReETDS3y2bABx6l/N6fkZmOUDWCWXkHuiD3NjU9FoWRjM760Puq
         DGBapbsUwjnQZKjiHZXyvpDBjFfAp32+DmrDI19K029eBx1sKFmsv5I8itR9PO6qbB2h
         IoGIRARkoOgndtLPR4P9HFcGKAZWbXIM4unAzHww/z5WvQFHJLjJw0J42P6sDGhtQCJJ
         fyWg==
X-Gm-Message-State: AOAM531toagm1lw8iyNL8Rr6naKopeCsFl1tmSQB5CRVU0rIQntg8HQR
        oq+5jBo6/E6KCEc/Ry+j5Y7Q8Y+ZTFHTvA==
X-Google-Smtp-Source: ABdhPJyjUSVgdPFic/P8Et5E9RwW1l1qkvgy2QTFo4YpaB/kfDIXpAjAt064eXJjGY0LpZQutU0pmQ==
X-Received: by 2002:a05:6402:416:: with SMTP id q22mr11927096edv.204.1620399427010;
        Fri, 07 May 2021 07:57:07 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id h4sm3325354edv.97.2021.05.07.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:57:06 -0700 (PDT)
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
Subject: Re: [v3,4/5] drm/connector: Add a helper to attach the colorspace property
Date:   Fri, 07 May 2021 16:57:04 +0200
Message-ID: <2190160.Z2YBaczauS@jernej-laptop>
In-Reply-To: <20210430094451.2145002-4-maxime@cerno.tech>
References: <20210430094451.2145002-4-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne petek, 30. april 2021 ob 11:44:50 CEST je Maxime Ripard napisal(a):
> The intel driver uses the same logic to attach the Colorspace property
> in multiple places and we'll need it in vc4 too. Let's move that common
> code in a helper.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
> 
> Changes from v2:
>   - Rebased on current drm-misc-next
> 
> Changes from v1:
>   - New patch
> ---

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


