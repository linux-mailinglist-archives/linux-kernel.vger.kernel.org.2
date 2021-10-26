Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0743B41F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhJZOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhJZObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0664C061745;
        Tue, 26 Oct 2021 07:29:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m22so16278599wrb.0;
        Tue, 26 Oct 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOzsbHSrEGJ/91GOiyaAv0m8TeuLHY5obAaUp0SAq/0=;
        b=qvJar5yHiaOheWa5zSI+K6kFwhJ1h35i5NpEylgcluNswIwHn6GgLSyrJEbbE8tRvS
         RqJcFBy3jHQT8BTt5fKtPB6EMLkX1rCAO5RRHodGgKsfNk1u9dYos6UbF5VdRMXsBRwY
         rW9UDblnlnTmNRmYeJNlgNsmkq9ZK84gM7YFcZR46/WnWoGOG39JBf9YotNbRhMBWF3G
         apEr7TwyG4PTMhhTIU1D/KkhoiwXNKhJ0EWnTQbD61S87TUiddS8w9HrdxB4x0DVIeXq
         gmZf38U/ZxrcPAJjl1TaomTf3q9M+VvNjDxKUSOCUtzZigL0+mD14i7ZO9oL1HP9xJv3
         cj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOzsbHSrEGJ/91GOiyaAv0m8TeuLHY5obAaUp0SAq/0=;
        b=CwGLhk2mDFLtcf7XuduJOmMhtsROVoIr0K1X8rzRMnafqTMok1woqdO0azkf7DBG05
         VqvvwdSL23wkATFAJVD7Aae5YfKQsEmqsodwDhOYMVXAh6tenbjCagurtdY/DOCBzRm/
         CnPCxsdJF6OngO+SrOB/M83H9pZYkTQbnvZZUfa//1fAHSOffBBR0FHuzpzD7BkDdfa7
         vpN9eVK2sDqxkjKQE1HfNWHqa8YXnxseFDAo4egu+iwoRqvnV7nhZilwbVe95/2Qy7SV
         iLwQloPBFaKXMGj/KBcGSjObLFM5mGzeMoqhYOY0CQLnav//AhL0FOzmfyr5yjkJI/6f
         OLbw==
X-Gm-Message-State: AOAM531KXSB4ZfNEuk5xO+avEl6gUCWyq+saBwONcnSeZGAxeuVgzozJ
        jainWasPdPjCMS6Rx49GKGw=
X-Google-Smtp-Source: ABdhPJz2HXV6zTsbgxXcA8/KX4tJqtgL6TrAsPZ1dRcl4omzDFcDrLKDJBMJuQrDYMVYs6GsfO8VOA==
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr5257704wru.18.1635258564547;
        Tue, 26 Oct 2021 07:29:24 -0700 (PDT)
Received: from localhost.localdomain (i5C74E3E5.versanet.de. [92.116.227.229])
        by smtp.gmail.com with ESMTPSA id f18sm18745717wrg.3.2021.10.26.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:29:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 2/4] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
Date:   Tue, 26 Oct 2021 16:19:00 +0200
Message-Id: <20211026141902.4865-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
References: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB
gpio hub on Hikey960") refers to the non-existing file
./Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml, but this
commit's patch series does not add any related devicetree binding in misc.

So, just drop this file reference in HIKEY960 ONBOARD USB GPIO HUB DRIVER.

Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1df6f98055bf..e7d85dda8736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8566,7 +8566,6 @@ M:	John Stultz <john.stultz@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
-F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
-- 
2.26.2

