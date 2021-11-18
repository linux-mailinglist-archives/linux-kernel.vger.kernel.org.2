Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B04455477
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 06:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhKRF6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKRF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:57:59 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03547C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:55:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id o14so4306387plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOAzmattOkvcfruVl5Z67av2Rvch+fLPuFTukNGwe3A=;
        b=o8h2sWYLd5XWa+md7lQ/hE89BFxTwwUy4XtrHQu9S0JIDZGO8ox3+0eJbDE04t1IVI
         QfGKFkKmdZf33E1TfOUEvlI1zqG3UEkM6Az6oMMJvLP7hbpHQ0tP6owlxHjzYt6SuXbD
         nSUe71E8Ju++ko9hxCNARkyZhSyf6qCV17RGI70zGHMmPXR9H1EApZCGjeecZbgjLoh8
         lssQ/sVQgHVde0xAD3zZiGN4bjLbEIlv5cTYMnMoJ703XVPoBh6eTu+OgctxMnsIJRtp
         wH0p1+OyiuB1CmqRxlzDR/MiIZh6EfsyY00chfU1D5cT1M+mTRRpEdVj7ona4+VTilrZ
         Nc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOAzmattOkvcfruVl5Z67av2Rvch+fLPuFTukNGwe3A=;
        b=z3S0kPmBBvTQZCZXmjNhIZ874nP4xIYcEFp+MKJUGol9lazkpLrDpbqf/63ldu9FVi
         GWKCExYKxh/d69u4ADR/E/+mOqAZ8p6KtWzs1h9gDt4QMg7//M1aXJ06Yd4LEAJ8g/dS
         gU2qTJUlPlUvRmh9V/8T4p+rYX+CyY0KSEPVuAl88fanvMKjOgCmiHGgYgDBPIfWDL5v
         9JoChJBhF51oQ+SLeqjhztc80aQsyvDJtDmVjkeYsQpT5EN9GZB/a+RtT/VXrQem+tHu
         gHhK77PTqt++26exI0x6J6acYh/PKAr7DuY6ef6pcVApUgiFmYvaOxExXEphk1wVm1RB
         LVCw==
X-Gm-Message-State: AOAM533avmSgPOtQ9QA7hl2mSibgkfXS8+XvrTxyY/MGUEcndGMaEESI
        ORy+1apEIB/bEjTOBx9k+sGOOA==
X-Google-Smtp-Source: ABdhPJwUFsDmgl5qVC3k86jpjBVIz7wwm8wMnpc/baXerv1B56NwCz9bhbQbqVjLau27J/nIr7NuBg==
X-Received: by 2002:a17:90b:615:: with SMTP id gb21mr7493988pjb.10.1637214899232;
        Wed, 17 Nov 2021 21:54:59 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:8f8:11d:a96a:74d2])
        by smtp.gmail.com with ESMTPSA id n1sm1504736pfj.193.2021.11.17.21.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 21:54:58 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:54:55 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, fshao@chromium.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Subject: Re: Fix drm suspend and resume issue
Message-ID: <YZXqrxinyBZkBgfq@google.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:41:55PM +0800, jason-jh.lin wrote:
> Subject: [PATCH 0/3] Fix drm suspend and resume issue

You have 2 Subjects.  The first one takes precedence.
