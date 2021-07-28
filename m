Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4563D90D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhG1Omn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:42:43 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42818
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236711AbhG1Oml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:42:41 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 16DF1402FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627483359;
        bh=HAie+4ObP5wDsqMY5KGCgt4d7K8iKvd4Bvw66slM+7o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EJ1ngy8+YbC3nMzKPdN+X4aZs1bkJNRgVeiOtwtBOTZX/dT5w8ohRuwbvzx1gjlWB
         jQPgBPlXwcoToE0jonF1ALcfZciu30YV7thA36215FgV9bi2BZBEc+zXKutKyBA1sE
         8up1q21O3eof05/vuseQLgITXtnYt6c1ghS6wUlIPt3CHi/ZpVE6B+GDk0HEQLGyyr
         Kgw525b8mXFR7AQqxhzSU04woY92ZIwBMS5Y7qJ5cJmx8jDJgaBKrSC1UEsRhzQKba
         AIOzOenw9FCKzBwP9s31U+aoetzBCx+PZTqC/skv/oq8A097EaowOzNczNUEA7gVsR
         zWWaIF6QZPScw==
Received: by mail-ed1-f70.google.com with SMTP id d6-20020a50f6860000b02903bc068b7717so1360688edn.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAie+4ObP5wDsqMY5KGCgt4d7K8iKvd4Bvw66slM+7o=;
        b=jzc2+9zFFCv4E3GO9/4LznvRMAk25YEIXgO9/AOEuvGMV6yyIVAJPGVgaOym+/kede
         Wt9J+iSrC6kQK7o60uT3igFOkZ51K1Tn7u/m7dfCQqCFlNrylon1ZdtstfYY8jltMHjS
         YnsR50nxUhEiXWDIv7ihEnA8aSsF/ae7phZwDysiQWF/o4GK3EFMLueMjUI3iJEUSO0B
         ipob8HH4f4f+afgf4LZtquCXPwRVVVeQ6LFU2QdgAHNuTd+EA/8TZNwQRn5xWA4/9+iM
         sWR+O/Nj9zTSln+eFnU67bVKwLAsKPVNn3TNEA1mLgRtVN4ilBGbBMORga6iGpg0L3cI
         AeyA==
X-Gm-Message-State: AOAM532yfnAQUGcX4VCfuql3fK9Yk9kJ3x3rLzSaa/bsjXAZBaNEql62
        JXbsQIX7dhtCtiwYAf15BHwfYwqryaS3zPAkCQ3kkkh1A1aOL4b8gDNPXA78B39yc1fpzsv54n/
        n6SxS2YcJVDCUmZdXxR4D1h/Xbfj/aOvpjyUfmMA/wA==
X-Received: by 2002:a17:906:c836:: with SMTP id dd22mr16340505ejb.3.1627483358786;
        Wed, 28 Jul 2021 07:42:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxteeSA3oSAeRNij5f1M2M78dulmjLVEORBllzGQQO9MQOzz6cXVa/fw6iRYfYcKNgfnOcF3g==
X-Received: by 2002:a17:906:c836:: with SMTP id dd22mr16340483ejb.3.1627483358609;
        Wed, 28 Jul 2021 07:42:38 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id d19sm2683676eds.54.2021.07.28.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:42:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] of: unify of_count_phandle_with_args() arguments with !CONFIG_OF
Date:   Wed, 28 Jul 2021 16:42:27 +0200
Message-Id: <20210728144229.323611-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728144229.323611-1-krzysztof.kozlowski@canonical.com>
References: <20210728144229.323611-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the declaration of of_count_phandle_with_args() between enabled
and disabled OF by making constifying pointed device_node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 0e786b60bd5d..6f1c41f109bb 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -896,7 +896,7 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_count_phandle_with_args(struct device_node *np,
+static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)
 {
-- 
2.27.0

