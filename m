Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8114344BEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKJKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKJKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:33:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA45C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k4so2582684plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BL/ijtIxlYFTdIaPRxg1NuofUxGQzYinoPWGFB9zPEs=;
        b=oon4kKhSj7merVzvPBZvRplsjLDFbY6jj7MxoEEpCv5XCaxgftMX9iQSg2wZgT5bmh
         5GSs8rWijTpI31ovFFuakG9K9AAZdhQBKS1mhPi76SPrvNr+SNCoiyCWyIrU8CSCh2YC
         ip9t6JVaopp4KmCDK4b/pAWLlCqzs36IVlHxjuyGxtMmNzUws9ccTj38yd3EviK+6dsE
         puAwS46GaQ5dzqgphAdiIf/mlSnqbrFXyBbKZmcpXOuiVC8ectlztG/GN6cOGvUCHqdV
         qmXeEnMckfRwc1Fhe/svZO5BHI75kgDk/5rOCHY+BuwjUvYMBL6gOCfLMi3NO1r31Dc9
         k4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BL/ijtIxlYFTdIaPRxg1NuofUxGQzYinoPWGFB9zPEs=;
        b=C8jLb272sRm9QlsB8oLVkQzwE/G9tdER+ejHrrRbhrmmqkG6AIinsCaYKvo9MIUDcZ
         A4Li6aZEAemdOskZLw+jQjaN3O/POiEqw4CMl1qtTY9Ee+TbQNKA9ziYzdSA1/SqSbez
         hd9h8P4zBGzw4wfF9/GjdyQTtqgefgZT9txUNUKtVuS/h9s1PDP6WPQK0++Xnuwh4qX9
         6Ae3wGo/Ui9hedmCZHzpHI6dCBZVe1Nedhr8/Oxrl9J8Cz/dGyXgP7c8ieHdk5O486VJ
         Yr8tC3Xt4p3UxWa/1r7beGaB1zMqxthnfS90xHqccK8M4vQvest7xmU5d9KYWsPD1m+r
         Bb4A==
X-Gm-Message-State: AOAM532MLE86wnwUJU8dzaSqeheKxEtGbtZ7qzf+rz4jH4hcJxslaiOo
        4nROaMwYeud5P5ny4+vuQW74eI3AN5QWTEMyeivhTg==
X-Google-Smtp-Source: ABdhPJwVgFxj/vjgnycu/+1rEWt9aVPNT6j63gpsvXFnkemxO+5cDmd7zOvOIUlgeIO++x6gV0UCGw/o6pLmfakrEQs=
X-Received: by 2002:a17:902:7289:b0:142:805f:e2c with SMTP id
 d9-20020a170902728900b00142805f0e2cmr14242448pll.42.1636540227601; Wed, 10
 Nov 2021 02:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20211109125030.26299-1-yunfei.dong@mediatek.com> <20211109125030.26299-6-yunfei.dong@mediatek.com>
In-Reply-To: <20211109125030.26299-6-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 10 Nov 2021 18:30:15 +0800
Message-ID: <CA+Px+wWiFDB9rqOzsTjjXAyKF9+AfEmC4ZrnYQTCi7ePuCUGXg@mail.gmail.com>
Subject: Re: [PATCH v9, 05/19] media: mtk-vcodec: Support MT8192
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 08:50:16PM +0800, Yunfei Dong wrote:
> Adds MT8192's compatible "mediatek,mt8192-vcodec-dec".

The patch adds a new compatible string.  A separate dt-bindings patch is needed.
