Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5131E47B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBRDWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhBRDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:22:41 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8FFC061788
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:54 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f17so474262qth.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOfFYMnuatxitiwGTdhM0Y2gSuDfhn112bMEUZiZo+4=;
        b=AF0r68QjMjeqFKnAwjPiU2wDu3u/0Y/1IMh1z+JiEgziHgReaqTy/eRQO9NkvYiRX6
         vvQqg3LTLSVtc0QKIS+QIiGE14VnH0fpbXTIRpzdhCg8cYtjf89lFRIlOl+oyCCgfD1K
         ztM4KeMNXN8JwHPSvMhV/8jdaWpSqKV6pBMv9cL2/QrSWQGMM7Ij6jba9gBEwu967KBG
         HESGBbTP1hM1PvGYcDkrxa7stgLwq2FyRXsB8lTvximVwKW52qhEfQvphyiUTK7fSN5X
         zSnr/dY2VDzl2Nb/VjnwXYmIdM5hxdcCSxwCt45ewYJ1giUFgqmxlAbToazuan8xOwNo
         PtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOfFYMnuatxitiwGTdhM0Y2gSuDfhn112bMEUZiZo+4=;
        b=gOEXhr0kUGOCXr+hI2CMC5vrvC2YcHjt3wNmOxdv3IpiewhSiI12Q/4RuBMrRQsqal
         ZoGrT0MNE6uHrDAKn8duILapZd9+CYz9GYcEEiDX6RKq2hOAF9hDc4S0HH4VRC67WIIe
         n5l3s36iXs5nkxCnrDpEKIW/nUfsbYi95IZiMZ1XLfMcsxs86gXlN1L37cyjVAUMmePu
         EHT9el3271FNahr43FoMP3MJsojJ9/NJDDEzekUdTzY7WndJkkSI9unWYbiwQEYtyCZ3
         HlpZUmHdjgD8A2P9EmJA4Tho6XgMGtiNk1xGFEiiO/RJcCXPKS+YXumg58psIVryA6z3
         IjZg==
X-Gm-Message-State: AOAM533Z79qr8t/uX8lRJcqjA6e7jm2SZUhljff8Wc0q2vwXUM3nYI3o
        ZnoGETh3s8UB+zmas0xG5/aCHg==
X-Google-Smtp-Source: ABdhPJwSMM9CqBRAOxpFEQHBSu7SAr6rYBCu4RfKDA1eQENDfnS2fYBzT+X7WSXo1yIjAdLkcaBdzA==
X-Received: by 2002:ac8:498e:: with SMTP id f14mr2513292qtq.286.1613618514120;
        Wed, 17 Feb 2021 19:21:54 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id b24sm2578996qtt.44.2021.02.17.19.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:21:53 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] fastrpc: fix dmabuf arguments
Date:   Wed, 17 Feb 2021 22:20:52 -0500
Message-Id: <20210218032055.28247-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmabuf arguments are completely broken, these patches make it possible
to actually use dmabuf arguments (in particular, the second patch).

Jonathan Marek (3):
  fastrpc: always use fl->lock and remove fl->mutex
  fastrpc: move fl->maps list removal into fastrpc_free_map
  fastrpc: remove redundant fastrpc_map_create() call

 drivers/misc/fastrpc.c | 48 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

-- 
2.26.1

