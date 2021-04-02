Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE01352DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhDBQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:45:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BADAC0613E6;
        Fri,  2 Apr 2021 09:45:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2626397wmj.1;
        Fri, 02 Apr 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8UGoag2wt4wWWzMwusfzReLhK9suY4Fy+sblmWs2mA=;
        b=Qj1DzwLTldJRGUWwUEPiwXYKh4yJGAOqwUu6/vpgJvIedycS6jrSE6mhQY3Dh3OtQs
         8vM9oK67AqhhrMDFnRYmRQbRzLeF4sD8hGfKUexgeUNzO6tCsZt7DWrQ3UZAQB0HB2Yq
         lrUiBZlH7c0Pn7OhEICmsE7AhyMFnNqIvnjb65zGbTsZv1LlJdqiAyeURweZ9IGLO62M
         XjhVOAlKdOMHvl+aUtEIREen0JxV9Y2DuBQFJ60MGuWAH3sawsdQybUBPPwZlQ8mrAPb
         Sq7mxkvS3XJC6VoDNYcShCDe5S9BE8waAm8JgoN2PgQOtfEJiJLX5fLh++alJXEXv2Yi
         wydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8UGoag2wt4wWWzMwusfzReLhK9suY4Fy+sblmWs2mA=;
        b=NEl0Nx1DQry32CrB5f9PjkDDlI8kjDbuE583tAoEvTEZnBVF7xx123BAoHu/TWvrk5
         obQG3hjjid3RVfSiaZ+BZ2+YfzIjWUTGRUD7uiUJnxzGHX2wZsWuM4P83djcrPupYwnr
         nWBOECFmIwUzBbuALGlzWZtiw39wrZBW80e8mJ3E2+n/NuMcRZiKANUaXOFolfKrXJAw
         vvYmS4wiRN2RsuE7CpgfczqNlYv6yQIrxCxDo6LmKOxYgAVqfSZFUxOdRJbcDb8RbjJ6
         cgK3omAvfqq2Mu887GRQuHldel4ppuh6CtbQhkb2IBlNQDfSH6px7zYk1pKKUjKSC+lo
         2pMQ==
X-Gm-Message-State: AOAM5321XKpF1mzNoKJ8HuokMxTrBaMLBdZlFDGSuirHzX9j9jBxGd4h
        9xYIRU6a8ian+UBbJQcp9qQ=
X-Google-Smtp-Source: ABdhPJwgNRs/B8eWfF3VlfDm06tMzP6TqnrEdfaeb99s3NESnpY+8VZxILinM8zLvN1ykSnfQ70rtQ==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr13066104wmc.13.1617381912823;
        Fri, 02 Apr 2021 09:45:12 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700dc0d270f04d57395.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:dc0d:270f:4d5:7395])
        by smtp.gmail.com with ESMTPSA id y10sm15027627wrl.19.2021.04.02.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 09:45:12 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        peng.fan@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 0/2] Add imx8m power domain driver
Date:   Fri,  2 Apr 2021 18:45:04 +0200
Message-Id: <20210402164506.520121-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch et aims to add the support of the i.MX 8 Power Domain driver.
Some devices (like usbotg2) can't work without this patch as their
attached power domain are down.

The original drivr was taken from le imx kernel and aapted to fit with
the actual mainline (minor fixes).

Thanks,

Adrien Grassein (2):
  dt-bindings: power: Add documentation for imx8m power domain driver
  soc: imx: add Power Domain driver for i.MX8M(M|N|P)

 .../bindings/power/fsl,imx-power-domain.yaml  |  89 +++++++
 MAINTAINERS                                   |  10 +
 drivers/soc/imx/Kconfig                       |   7 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx8m_pm_domains.c            | 233 ++++++++++++++++++
 include/dt-bindings/power/imx8mm-power.h      |  21 ++
 include/dt-bindings/power/imx8mn-power.h      |  15 ++
 include/dt-bindings/power/imx8mp-power.h      |  28 +++
 include/soc/imx/imx_sip.h                     |  12 +
 9 files changed, 416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
 create mode 100644 drivers/soc/imx/imx8m_pm_domains.c
 create mode 100644 include/dt-bindings/power/imx8mm-power.h
 create mode 100644 include/dt-bindings/power/imx8mn-power.h
 create mode 100644 include/dt-bindings/power/imx8mp-power.h
 create mode 100644 include/soc/imx/imx_sip.h

-- 
2.25.1

