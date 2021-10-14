Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC442E346
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhJNVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJNVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:31:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:29:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so22777787wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVpe9rApQQrR9b2ZqtV3aUoS43eA6WT0EgrwShVwj6o=;
        b=f9IMNPKV4pY6KmPaIXeLQg4CptWreqaHYll9EjtWovouBZSNkkUP7nfm3S379UZH23
         pJUq3QmQ+NgCQJXr7t7uce7ZcgZdjriDwlMB3CmLAE2Nv28e+icZqi0OeNVJhd/K+Sg7
         9rWkUYlwGEAoZxQZqlcoAZGCjyT33iySJ1CVVGMfPuLA6Oucg+NBlMyKgCSDNgslvO7l
         /FPXXf7AQbDerfmqNQW5+bF3Nq6apGzpM90rbz78QR+wuFmwpXZXNub6QlSdvjlbRZPZ
         yNl/6BTJetRp0FVa52sre+1u4/vmpMwVdPu51OYQhAbDBRh43HMU2zcqJGZPosf+HvTd
         Ukrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVpe9rApQQrR9b2ZqtV3aUoS43eA6WT0EgrwShVwj6o=;
        b=gPq3MyiL84nlUGXhJqxqsApZMb0KtjYqWCvQABTB58qhVIkjwJMByyGaoQLz3a/X30
         JLhMc6Y/iKMP75ahH/gTwX+My6FJ0II4ZpCfw1EYXDL1GLUT6Ky2jI9gBGtg4RGSB1mh
         rgEpBFT8kNyYVxQoYhtLqnnW2DH8KR5PhCWvc7bkHXpsC6jilzUTvQdCUa+MGbiawPUt
         8/X1xCT27nFTSHhbrH0vIx8Y2tVYthSZ5W05148e7MryzZMt6S447QddjeDwMxM/gx1v
         j7K3fT5jO5Lcpl2j2nViO9+5wHfSEy01rfJ4lGabBlLsJWDAmogWWtAdWtGkEtguvk0b
         o+/g==
X-Gm-Message-State: AOAM5309YkuZ9u4jAihWbOY9YAOKSDBoRnjvL1383M8BUyisJpmiIv79
        QGNnE3sPMGbb7opcmUl3u+yAVPJttUFRuw==
X-Google-Smtp-Source: ABdhPJxnlsPixMoe7wOuqoh4hIRzFb87NFLeGvCq2PZjgvj4t8boVWFrmw9EI85ieDSZO0dnZjxREA==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr9712889wrs.179.1634246970133;
        Thu, 14 Oct 2021 14:29:30 -0700 (PDT)
Received: from bismarck.berto.se (p54ac5892.dip0.t-ipconnect.de. [84.172.88.146])
        by smtp.googlemail.com with ESMTPSA id p7sm2380927wrm.61.2021.10.14.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 14:29:29 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] =?UTF-8?q?mailmap:=20Fix=20text=20encoding=20for=20Niklas?= =?UTF-8?q?=20S=C3=B6derlund?=
Date:   Thu, 14 Oct 2021 23:29:06 +0200
Message-Id: <20211014212906.2331293-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a commits that mess up the encoding of 'ö' in Söderlund, add a
correct entry to .mailmap.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
Hi Geert,

Would it be OK for you to pick this fix thru your tree?

Kind regards,
Niklas Söderlund
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 6e849110cb4e3ad6..1c89a44862696a5d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -276,6 +276,7 @@ Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
 Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.com>
+Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
-- 
2.33.0

