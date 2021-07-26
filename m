Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D23D551A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhGZHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhGZHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B2C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so4717394wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CoiKk7rjio2RKU+s3ML+lKUiUQc1wLkK/GH5VGg1QY=;
        b=c9CVGx9R/uCP+dtbA4o3A8K4gqhmdIWCcfv/W0+jiGY0wrz1i+wOhT2dVGYtitY1vN
         R+8yGxVHqMm1hp8RiRwvxXNbFKnhTgmIsynkLs+AiE81vP5jQ+R7zGp74Tb2CI4lU1DW
         HBFykmIGnqVq9XCGQockQWegrG+I5Srsg+3TQ2aDeLmKTsZk1bT1P6bL1KbP2Vq7IR70
         b7IdVAuLvRSvhzhu6Y0YjxNwAxL0/uLY45UlHDx11mAeXpCAxG0jPErfdLUMOlhuJmym
         2gDaGtgksrUV3ca5t2Pf5+AhtB1PrD12SEqOvP7wrY3iLru1t9WxTOfCAANmvp9Z9hDO
         wMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CoiKk7rjio2RKU+s3ML+lKUiUQc1wLkK/GH5VGg1QY=;
        b=tSaJSL5aBE/+f/MSv0YCuD+p0ajEK31L9nNz4V1cLLq1KjKl1Zget8dopL5i4FnUxQ
         T3I5SzXcpe7Jf7WopLiPGI77hj3mOTtCkY5ZiGDL0TQFBARUCWMMkZKsVHgHb18er1Mp
         5NJD6xXpJLhsMkZvOKMTEFQ+o64L8hibV5VG8PJNXeFjyDHDQeLjsi8YPZDSxbfQXaoi
         zamU2FUK8wCjS80GENeuO4ZqsabJFLS3a4ffKvcMUPh0IdtBMN+CvUjVom6fLiagIbCF
         n/gXJslI5MEzk2kQnlrBwBldWTYsKwegx1d80+eJLxBYrdzGJjHTpxQuYy1CSeI8vDrF
         7POg==
X-Gm-Message-State: AOAM533GSXFRgavqRO5YbvcmGdWN4dM9sGJMctlNjm4kmQ1TfTiMBdjb
        gH1ZAxO3VRdRHmU+KrS4HrSJnQ==
X-Google-Smtp-Source: ABdhPJw1KBlFH9Kv9XOSPT+ukLibgvYWWjL0nL1sHy6Lkc8xHILZFAWqyqy8ybzbNqYxjrCCf+mnlw==
X-Received: by 2002:a05:600c:3391:: with SMTP id o17mr13962613wmp.187.1627287167675;
        Mon, 26 Jul 2021 01:12:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id c15sm646762wrx.70.2021.07.26.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:12:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, art@khadas.com,
        jbrunet@baylibre.com, devicetree@vger.kernel.org,
        khilman@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, nick@khadas.com,
        linux-kernel@vger.kernel.org, gouwa@khadas.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: meson: improve gxl-s905x-khadas-vim wifi
Date:   Mon, 26 Jul 2021 10:12:36 +0200
Message-Id: <162728713307.14205.16768883213869535162.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622044334.769791-1-art@khadas.com>
References: <20210622044334.769791-1-art@khadas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Jun 2021 12:43:33 +0800, Artem Lapkin wrote:
> Improve gxl-s905x-khadas-vim wifi performance
> * change freq from 60Mhz to 100Mhz
> 
> 100Mhz works well same as in meson-khadas-vim3.dtsi

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/2] arm64: dts: meson: improve gxl-s905x-khadas-vim wifi
      https://git.kernel.org/amlogic/c/6b197abe56feeafe9c516dca1b3ca3742200adba
[2/2] arm64: dts: meson: improve gxm-khadas-vim2 wifi
      https://git.kernel.org/amlogic/c/4b5260032ec691b11a9185f7f38f5761e67fab48

-- 
Neil
