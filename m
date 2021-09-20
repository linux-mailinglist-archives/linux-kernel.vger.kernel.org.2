Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0B4111E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhITJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhITJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:29:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09509C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:27:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m21-20020a17090a859500b00197688449c4so12229383pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkK83KoahY30COqnHPfu5NhmXo2Lmr5a3aIm9VHLcOE=;
        b=daSOJbuZKfdabxXRP7RitCR98YqhVhU/7MIA6S7yHXx9yTkUt9SNuGTki+mR83qSab
         r8Gd0n5LLChV3G2xoTrE/Xxp7DNcvtDdGSuJSZMpkk5C7TTk4LfeldllgKQw1y8sJBrz
         G/F+1w+q62fVM0ZI2YHOmlbI1mSttQ8FNpLjFoJQyWOZH2gA1YfZhu6yGQEaM649PWiC
         dPOuB75qvnqg1Ol4+9H/pWlT+bVOwKhgmC3LadTuo0RqXs3FWwFL65f4sf1U2kArWRRu
         EhMZ588oVC8Ugfrez/fA9bpSYaRgSQLEEvaWU0Pyy9FTPKqg9xfiUAAI45ZyRvzlC4j5
         Ua6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkK83KoahY30COqnHPfu5NhmXo2Lmr5a3aIm9VHLcOE=;
        b=ZiQ+TKziemgW6diGx6LB2GGPwwdnanyXZIJfKRIbRnBzd3C4V5lXYBvw3DzHBZi4BQ
         C0FEMduWZvEN429B6mPeKk/wLUgnH1wlvqMJW0c6Sq2g44ePRAuE+wFrHu8Li11cEFa5
         OsJDL5fagmtYH8/9u4ujj+QrBYMBwMoissoJLefVEewmMEsBKGcS+e132A9KDpkP/vcz
         K+fbt/qiUwgDrqbpqjdqS/6w5WFYezdH3PCMWiSL0aMNnD7mpc9sOsXg1yX9u7Hb+0q1
         R3IDpYfi2Azi1mMSfRnW1zLhjr78McuTQxDBjBe9bOoyLkUGyjUYGJeEWws8ZdrNoBy8
         yEdg==
X-Gm-Message-State: AOAM532W4gXEBwyG/JQX2nQ6+fNXSlGXy0nJL72Z/ahdRbDtn6sEweoL
        pchznoNFDEUsKeJpAltcsHjrt3Bgp5w1v55godz89NJJtdYprQ==
X-Google-Smtp-Source: ABdhPJy0CPwEY1Ze6w0dvv1rQvLAPIfSuDz1pmlBDkF4xo460yt13swCiLs4CtvAGWB1+2bvoSa/PzdYXHIOLRUwgKE=
X-Received: by 2002:a17:90a:5e03:: with SMTP id w3mr28216977pjf.152.1632130068379;
 Mon, 20 Sep 2021 02:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210918140420.231346-1-knaerzche@gmail.com>
In-Reply-To: <20210918140420.231346-1-knaerzche@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 20 Sep 2021 11:27:37 +0200
Message-ID: <CAG3jFytjvApk5SOtWQ8RZ=-LCQQncQiHMK-RWbMMY04anLiaFw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: it66121: Fix return value it66121_probe
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alex,

Thanks for submitting this.

Applied to drm-misc-next.
