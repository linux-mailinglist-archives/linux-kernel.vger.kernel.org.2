Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A37408587
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhIMHpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhIMHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:45:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC81AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:44:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 9so12906020edx.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsUPD2aQ6KskTShRBgvWOAzAZZRbHuwoC4E0wgxFpbM=;
        b=ShKeBeYpI29nTz2skjKW6jlYy5FmIP2axzdMqB880N2t9zwls5YhdmZPADfKoAm2rk
         2c9BKAyPDKDH146xpYy/D9h8hdgVgLReOtfWrs8lZTSSzef7Vb3UKawEeagOn5g8NGqE
         6KYg6bAxCmBKVvs/KovQCLx8Ao92LokLzOHpoZWhQDBAkShXZLKgvVmEYil8HKCo4GnF
         QJKY2dsd8NdCB30Mh3HxNMM08XBrcNl5Kcri2sgi74K+mpLGj8JBbVw/G48RdK3BB+8X
         rWUtSvPZUlqO5HpWN40EUC9+/1h3hvkfMQHha0ioD6w2SHK3rgglvEO7BBZib6mtmV1A
         IJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsUPD2aQ6KskTShRBgvWOAzAZZRbHuwoC4E0wgxFpbM=;
        b=DLOaIeasd/hLcrAAcSbA/ASnMyeR1cokMETMJmmgvrqst1PXy5wDyyJU7iqcXY7Nsl
         +FxfWZFgEwKg+2Pme2PC44CtEHrUGYPmNZfivU0uiemEAuijKKAt0C8hG4lRfjLddCJP
         v58Cxb7ho+Js/GLQGKz8Gx9+7A0Anvbz7JDinjUvUv9nDGOA9kUKAHW+xDlsEOxA4ph9
         P9hKhjxa8Ed0RXuCA0WEIDPWFd8hwmFoabOsH8j1RLL/ssCxBNGRPdow9jaxw2u0GEaT
         wnZnm+U1gmHzf8sahzYX/MG75yn3Rc+vzmjaQD49DZdAkYnOEC6yQWJ0ldUgdOhDH9gd
         xq5Q==
X-Gm-Message-State: AOAM531GoeIejS1c77eCMdtOOvV0klYUzjQ6DtwKX3Mm7N4jGOMPMD0j
        XgH+/DUG/hO4r5WbcmQ7oUq8hQ==
X-Google-Smtp-Source: ABdhPJyrvCAQ37PtfCLNc+t7oamLP6EmStT6aXFN3UhAOhGxL8/D8dFcVJKShybnHLXUKcDeID+mXQ==
X-Received: by 2002:aa7:df8d:: with SMTP id b13mr11793713edy.393.1631519060310;
        Mon, 13 Sep 2021 00:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:9ebe:26f1:5acc:c894])
        by smtp.gmail.com with ESMTPSA id y13sm1543856ejl.125.2021.09.13.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:44:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] soc: amlogic: canvas: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 13 Sep 2021 09:44:20 +0200
Message-Id: <163151904951.817859.10640218800664816407.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908071544.603-1-caihuoqing@baidu.com>
References: <20210908071544.603-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 8 Sep 2021 15:15:42 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/drivers)

[1/2] soc: amlogic: canvas: Make use of the helper function devm_platform_ioremap_resource()
      https://git.kernel.org/amlogic/c/97a4a24087ce354ce0318449e6bd9e660f5c573b
[2/2] soc: amlogic: meson-clk-measure: Make use of the helper function devm_platform_ioremap_resource()
      https://git.kernel.org/amlogic/c/d54dbe9f0ec05935e10d6a38d81e54e2ec8b8a68

-- 
Neil
