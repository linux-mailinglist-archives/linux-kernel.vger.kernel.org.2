Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D587A3A6F20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhFNTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:35:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35354 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbhFNTfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:35:16 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssKe-00008w-PY
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 19:33:12 +0000
Received: by mail-ed1-f69.google.com with SMTP id v8-20020a0564023488b0290393873961f6so13445034edc.17
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfJlofv21SpGZDidrB7CsJ8MDr7P7vCKWMcgZ/+7/iM=;
        b=Bh+PaEtGuLwmq2IbHXrsgG7P8ZSwGjVM9yBUHfLFZ90SgdxEbtEWMjOQ7YHtkKkbSU
         pMexYTiHaZWkUYMVMf14+5VuulbzFQyQde6PsaRK4pLNeEeXmgUlfKytPnX3MlcMil9Q
         jocdCiZ7Iqc2BuxF3+aK4ojrgTVhJDnvzY31e6Ul3HrSA4KN4ublkfqiz1QJFWH2Kw89
         gJ+XFSsUTIeeGkqnbV2E4yxyq1+/ELlHIdHPDiAgyQyLj0/oaO5db6IUSc1pT7fUPFR/
         euS1ORqVV14JFhzkrvMi0pdjot4nAYevNRjlXNziOttxhCygkhAF++cOqwjfq4icz3bt
         xDzg==
X-Gm-Message-State: AOAM531sT6+qiGX+uIGQIMpW9LHsyiWLAP59G2VhEdTgypQiYtdPjVbb
        LfMH68OQ45iuORrrEU+zPJsKiQwmYseFrGn6rcvpaKrM2bcIGp10iMzeW9f/C7TlcJXJLcYB3BW
        8kdd2rVpdWK91f862Ifbua0XtkDb2aZJPGg93IN9nJw==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr19246393edt.194.1623699192599;
        Mon, 14 Jun 2021 12:33:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUwBAD6ChY0/D6TIhrxmWKERXF7uVQl6lBAKO7NbZ1+r6uaIe7co3RLS1phU3lsvHL6vuvqA==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr19246378edt.194.1623699192513;
        Mon, 14 Jun 2021 12:33:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gw7sm8029291ejb.5.2021.06.14.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:33:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 0/2] ARM/arm64: Samsung pull for v5.14, second set
Date:   Mon, 14 Jun 2021 21:33:07 +0200
Message-Id: <20210614193309.20248-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

For arm64 DTS I have only one patch so sending as is. Second pull request is
for defconfig changes.

Best regards,
Krzysztof

