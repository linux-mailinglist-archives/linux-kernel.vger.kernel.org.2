Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE11D40FEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhIQRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:53:16 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44286
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242902AbhIQRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:53:13 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2B0B402DB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631901110;
        bh=XL+qDC8QutxbDamfZzlmocvfMVRa4rk6KJUDa0xLVTk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kIO9IB5ZanopXdTgFXUTbDgSBL2DMKb9sGZzCbYQ0yOfx1Fgmi/w5KEqzOD9y9ls0
         3lnWn3MEVVzI+rzxVpzNd3FL8WEmoADqyWLCQE5XlwKQleE/N7FA7I4nsw0/KuvpzV
         Tfd3TdkkXUQEfTmKQ8TWnnpoa5fKD0cCylYl8rk+J0sG1l72zW2hV4CtmRJPrVNVES
         9F+naLEG3SdQZcHOOghKEEbsAgAYklHWcCiJMCEEnnDkPdVAmlWIfLM6UEljVw31rq
         8MuldyxfHv9p5O46tCbe8oJJPHxR3o26Wj5zjU67dIAK+OvWjMUu3aQ6yFA7vNzrSl
         85IgVHW0wfSEQ==
Received: by mail-ed1-f69.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso8848642ede.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XL+qDC8QutxbDamfZzlmocvfMVRa4rk6KJUDa0xLVTk=;
        b=zfBsNOYCybgEJPz6+I1voCclEfodbZDhzLjRj2IWMk+IclnjrdPMWBPJJvZ7au69mJ
         Mtw20xbdfQnoB2jt0aPmoPS+a4JVTnGZwxsYA2/P/MWIopih7KGVrePlEtqr7zt6Jb7E
         59LuBCUfTHWnn05NoRYPm8WBp+ZdLjavTlGaCW5+PFz1VQmsnW0JbxUtG8Wo81757JwQ
         91xyi6qkzpCIGwqI+G10SS8FYgT7qS1qdfRBxY4tdRxdqyS4LhMT3NK5rWG7s+7z5vOh
         +n0hiHJE6q+3Xssx4TQJPKS4S2WUgGyDeLEz3lVJcI1vAeS84UX8K4ICArPaBTU4GZBL
         AgQQ==
X-Gm-Message-State: AOAM532+cPD8SbmcKFKNsNLgxvJdnYDyQhP6vVwz6Fr7i6enUrJhq3gd
        raK2A0o3Mve2UnSXP8rjDHbwFn4CTugOPjQ0dHvoUuGFVlZUwNY+UfiunpH2aYSksMDiycNvbJs
        71+N3b4OKKZp6dars9DVqjxEu23gzTdNZ3dGc+4dyWA==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr14212779ejc.20.1631901110126;
        Fri, 17 Sep 2021 10:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiBqKd7lQL4Mbz9u5aHsSslkQWyMUiD657MnLRkC0FSktYOb2f/xv6iKKNdBylREGwFbkM2w==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr14212759ejc.20.1631901109984;
        Fri, 17 Sep 2021 10:51:49 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l11sm2951345edv.67.2021.09.17.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:51:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 1/2] soc: export soc_device_to_device symbol
Date:   Fri, 17 Sep 2021 19:51:33 +0200
Message-Id: <20210917175134.252882-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
References: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case if soc-bus drivers are modules soc_device_to_device() has to be
exported.  Since it is trivial, export it as non-GPL.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/base/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 0af5363a582c..ac8db303daa1 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
 {
 	return &soc_dev->dev;
 }
+EXPORT_SYMBOL(soc_device_to_device);
 
 static umode_t soc_attribute_mode(struct kobject *kobj,
 				struct attribute *attr,
-- 
2.30.2

