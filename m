Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D713C33A100
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhCMUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCMUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:25:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC2C061762
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d8so13471051plg.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=v3vY56f73yYRGQoRVyLC2J2MmOEbfpTBn19IMuyaMzo=;
        b=SJ7HYzHQCXlKPz+g8XwP5a0yua+xQW9XsyNmzipwqSxpAbDHfEbpRJ1+jIGuOcUOeo
         mUETiOW1dfn83yqEQU2aMuC5vTA0lP+RPnKi7cmwpALUPixtqFe4Ur5OPyPQ25obMudi
         c2Nj4k76ShAU49a2tnTVrkcsDoBT2ojyUMW7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=v3vY56f73yYRGQoRVyLC2J2MmOEbfpTBn19IMuyaMzo=;
        b=UN/As1W5DtnmDzaW3v5IawD56h2TTVmZcILaBNYq6B43doDVTrhxqZhnRqjCItcB+T
         pi66QkwSPFfHPll/AujkSkQVQazplDVjbhOmwbanXuTSU8+4toT0o+ENNWD91neSTUvV
         NxK7ljGSOfUoy+fTAvJF0olKJ1jfyB3aIfwRApXukNaPvVIvFO3rEPjZd+kKRP7gfbyr
         50X002f4WNKILHrJE4i1etA4qTz2BpCd411Jxu+rl9qWWAqO4gDsLJ2eILAgVrQrB2xO
         y4WHM41HCbWzyaSel/dEtzGRbANW3IRrVS+LXoYhBqQ41iRWQ6/vZZGYk1P1VveRnPQb
         Ntig==
X-Gm-Message-State: AOAM532PVXSmRdRujJBAM1PhbeEUz/GF/5lMYhcTFFfESICHy7C57bn8
        8lnJmcznZQHNpI7mtCzsSR2EDA==
X-Google-Smtp-Source: ABdhPJxOEsz/IKrr+VJDO0X6BLSVsEVwP/TcZ4L1UImrAp4MkFWx0aA6BSz/7QwfpnU3izA99mZ4hA==
X-Received: by 2002:a17:90a:fa0b:: with SMTP id cm11mr5266895pjb.140.1615667114263;
        Sat, 13 Mar 2021 12:25:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e859:c7d5:7d7b:5ed8])
        by smtp.gmail.com with ESMTPSA id 138sm9167366pfv.192.2021.03.13.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 12:25:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210304155144.2.Id492ddb6e2cdd05eb94474b93654b04b270c9bbe@changeid>
References: <20210304155144.1.Ic9c04f960190faad5290738b2a35d73661862735@changeid> <20210304155144.2.Id492ddb6e2cdd05eb94474b93654b04b270c9bbe@changeid>
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi86: Move code in prep for EDID read fix
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Sat, 13 Mar 2021 12:25:12 -0800
Message-ID: <161566711226.1478170.16782631593370115752@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-04 15:52:00)
> This patch is _only_ code motion to prepare for the patch
> ("drm/bridge: ti-sn65dsi86: Properly get the EDID, but only if
> refclk") and make it easier to understand.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
