Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D167A322F45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhBWRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhBWRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:00:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C113AC061574;
        Tue, 23 Feb 2021 09:00:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r3so11664295wro.9;
        Tue, 23 Feb 2021 09:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bHxJbGGMg4bpkPPC0MVwy/8SdWcCzKGFE0BjdeCfsFk=;
        b=rfg5BFdhWqJJGUlYelzfK4mQXfJx7Ucc6RBlQwGq6vj20queZto9hoiUbL9sjaOfdI
         +Qa+JKODsurj6l9GqPDxwPjZZOghg4Qa4VgBpN6WyVA5UsDCCDoMes2xuP3xwTeTlRjO
         NwK9wZnrd/5rgmE7mWjT2O+/m30Tpqf13QK+695l8GserXVXL9kUi8310rX0Rh4dYB7E
         PchrCXDThlLLpCzOZ06zmQ5awRSC+AoJeCWPDfzdPNJ0aVuj9TiWOfgpKPTotFZB+x6I
         w4jAn4Dm9E9qa1Ad7b9/Jsnw/QCDZMS5hnCnxn2zGoKlZlU2LNbB3ufkPUFnLSx6D9xG
         YQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHxJbGGMg4bpkPPC0MVwy/8SdWcCzKGFE0BjdeCfsFk=;
        b=fgI3vJPNNZe5nyx/5pmoXZUbicjf37hgjndgE3Rpdh8KRiLr12id9LPXBPvVOf9QMy
         fZmAu5NIMswQ3nVPdeIx8Dmv8/VxBzF4IQxc6pvX3yX2z1oE0ULSp+H+W4VjsoN3MB4g
         Go9ZRCwbkKeWJanNukQmzSGScKHTxv5viZI345HE6t2VRMY3YyyzlHlQZbCFkJv/mOET
         qiJSbaprd4wXLlgE45FR3mpWasbY7DBdghM/Ve7a0NJMJO9WjK27eTT5A82QSiDvh5kf
         1zuDYUdlLNKQYfykiAhFhnMbUmtCPnBdBTRCs/WFLBDdDiOlLfejx25v+zm4tp9AacbD
         Li1w==
X-Gm-Message-State: AOAM532qu1+CAHZBPqWCjbYd21p4mCivOrzbAVB9xFVj+ZUbka1FK5W8
        j1AQQ7aPHxwJ0Z40hz+01O8=
X-Google-Smtp-Source: ABdhPJyl4LvTuTmd+Bga4R2F3tipDMc3+bF9vBE9GHD2R6bgcqja9FshDYWySXtHA+PZXQJJ4wCjxw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr27442023wrv.143.1614099610462;
        Tue, 23 Feb 2021 09:00:10 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u12sm3057190wmq.38.2021.02.23.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:00:09 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwrng: bcm2835: add reset support
Date:   Tue, 23 Feb 2021 18:00:04 +0100
Message-Id: <20210223170006.29558-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222194510.14004-1-noltari@gmail.com>
References: <20210222194510.14004-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may need to perform a reset before using the RNG, such as the
BCM6368.

v3: make resets required if brcm,bcm6368-rng.
v2: document reset support.

Álvaro Fernández Rojas (2):
  dt-bindings: rng: bcm2835: document reset support
  hwrng: bcm2835: add reset support

 .../devicetree/bindings/rng/brcm,bcm2835.yaml   | 17 +++++++++++++++++
 drivers/char/hw_random/bcm2835-rng.c            | 10 ++++++++++
 2 files changed, 27 insertions(+)

-- 
2.20.1

