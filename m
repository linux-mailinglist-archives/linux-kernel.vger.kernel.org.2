Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172DC3D40B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhGWSpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:45:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C8C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:26:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id da26so3078840edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ueAuxf/lNyOdA4+vlk737MiUjhl/bLNv0CuGyEc4Nc=;
        b=mkcnRNu9lAzOTk7nx1T9FtAkop2ntjLzNqVzqavUncUaaWaAAIBOZ4w46oiU1TelsL
         DzolxOZp2oKOl2ZakRdJHQBN0c7ejEzfGqwzbqcoBR00EoMZ8EtapD4KrY3qLHc+XDb2
         wTIZ6TOI8fNzbTGCTjoQJ1Ij6N1PsjAXVHMZF3EbiQ8cetduTTOfTjqzKMmJeWCnpwY+
         UsJbt9hKnH+jJ6IfaLkA3KRf74IDNUIjlnNPjyigvHvQdHwnasP94PVwbQuCF8VK7YcN
         mh9uv+UZGJrMzYT6WaFPX6VpLmbUqSHDiBlMK1nG8dGkzctbKgaNrrqAZG4chPDhHESE
         Ovyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ueAuxf/lNyOdA4+vlk737MiUjhl/bLNv0CuGyEc4Nc=;
        b=g6+KGBYmPBddmasi1/D2q7ZU+B0WJYE0HCdFEzfQJdrXhRiJXgdlGk2sGEE63oxxF5
         aO6GgjnTKDkhLZB3Q86UpJn8xdFuhItChA3xiEgfewt6fF9b5yiMTrzBql30d8OmxBq5
         NX0/3CjkWEMkVt4h9aKi1OJIzdbrahH1K76OFDJuXj038r0lk0dHVZ06zQ5SBtv2M9at
         m807LqeLFTGEfOuGcj0b2PXtxt2ERO04/p27kU6bsMsUonao50XYWLQLQSQ3tU3x2+F5
         d77jCTc/PFZi+aUUbhWw3RvqxxmuqynxRTvpuuYUd66mCuXs8b06WGaLmEsPuoUpbMSr
         GQ6Q==
X-Gm-Message-State: AOAM532BcPFyYe+nUhp8jFdC4WLTLWLMsnfKeZobYV1/UqbZy6XIh6k0
        VL4m9EcRB2UzuTpTvqxbaVNuL0IGVVU=
X-Google-Smtp-Source: ABdhPJz/6fhKV5eLCepBP2fEQOuL5nmz+UwpzccIToMKBlbEc9cyeqB8eRt6mwF/pfHkTDA5pYok3g==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr7343547edv.262.1627068384510;
        Fri, 23 Jul 2021 12:26:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id v24sm14621129eds.44.2021.07.23.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:26:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 0/2] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Fri, 23 Jul 2021 21:26:18 +0200
Message-Id: <20210723192620.10669-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel API crc32_le() in place of the custom getcrc32(). Remove no
more used functions and variables after the changes made by patch 1/2.

Fabio M. De Francesco (2):
  staging: rtl8188eu: Replace a custom function with crc32_le()
  staging: rtl8188eu: Remove no more used functions and variables

 drivers/staging/rtl8188eu/core/rtw_security.c | 81 +++++--------------
 1 file changed, 19 insertions(+), 62 deletions(-)

-- 
2.32.0

