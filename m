Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A14287D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhJKHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:41:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57464
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234549AbhJKHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:48 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88E1D4001A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937986;
        bh=dKNe0YR2W1YWBul8nQdZBdCYA7T0luSH8qAs9JTPkS4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=CzrZmbDM+TpkvH/nimhaK+Jyy34RvrMDiu8ZRPZQJK54kLnLsBOPJqv2eusfpGBOJ
         jOLZL5MpEIeOd7wAnG6eVtZmwX+b6IyuB4k84Nz34r9Rp1ecz0l9tf0aIt18ReVHs7
         cUgTLn8QAKwp6b6cltL4D/kvGFR6TdybtR5UVnMHNPQn8+PRZKjSrkIhj1RLsxPiI5
         PG27CYrDT0T1LPs5E1soeklxV+mhlTeAiUc1wo1f6jjcxfWIrXKrDECfosmMdV49Ly
         S63Ul11H2othsh+QUpcbL0t96uQqcrQaM0O3ciwgfyMrK/vOM/flInv331MWy9r8rk
         ZybPwez+KYnBQ==
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso15052575edf.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKNe0YR2W1YWBul8nQdZBdCYA7T0luSH8qAs9JTPkS4=;
        b=n4V7Ui/utIu2FyS8W1/JRT6juwONbFJ02hjxZa/fpbmX2K7K5q/a9rvPp+mweGh0aW
         HbpFsQ0H2Yjux7Ui+JHbU6uHWwPqH3ABjq98eU/5EECsOhvIWLerkyZo6qq0Aj6yt+hv
         87+padm7MJmkp1g+bLc21W+pTjyM4LIQhZW7rGnwkiLBpw3MmvdhGjt96wIExA1f6RWL
         XZanqsdFGJDV7H/yZjBgkBU5GrVZZns3tk4S3X1twA0itIpoYA3pBESLnzWavFB7gvaB
         xd6Me2F8lzsoJnersisn7aPR38uEglGSeyr/n1vi9IhSNkdYjMuXYsUWGU3lHJ8jxWu1
         l+eQ==
X-Gm-Message-State: AOAM530TBbecSBC3aa+YGziA1Mr33nryLfTw4maPTXbBOPvoVwBqiTH0
        4bJIGOzV3UQacymfSphilU+tW7pC25rfp/NnyKfoRgRppcMQhremoU0OcaUk3c8uElsv3OCznDr
        CVr9maMI1zjA1WOzWV8lx32cdqOhTZEnD4ZolGNDeUQ==
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr27593659edz.283.1633937983838;
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4TGueCUqr8nipt9y1eUTDZZZuo1QIc9IRv4KZo7UB7TGDm48xnJ0Nl+i+OLa1EhAIjhllxw==
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr27593641edz.283.1633937983622;
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/8] nfc: dt-bindings: convert to dt-schema
Date:   Mon, 11 Oct 2021 09:39:26 +0200
Message-Id: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Drop clock-frequency from I2C devices.
2. Update commit msg.
3. Add patch 2/8: NXP PN547 binding.

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  dt-bindings: nfc: nxp,nci: convert to dtschema
  dt-bindings: nfc: nxp,nci: document NXP PN547 binding
  dt-bindings: nfc: nxp,pn532: convert to dtschema
  dt-bindings: nfc: st,st21nfca: convert to dtschema
  dt-bindings: nfc: st,st95hf: convert to dtschema
  dt-bindings: nfc: st,nci: convert to dtschema
  dt-bindings: nfc: ti,trf7970a: convert to dtschema
  dt-bindings: nfc: marvell,nci: convert to dtschema

 .../bindings/net/nfc/marvell,nci.yaml         | 170 ++++++++++++++++++
 .../devicetree/bindings/net/nfc/nfcmrvl.txt   |  84 ---------
 .../devicetree/bindings/net/nfc/nxp,nci.yaml  |  61 +++++++
 .../bindings/net/nfc/nxp,pn532.yaml           |  65 +++++++
 .../devicetree/bindings/net/nfc/nxp-nci.txt   |  33 ----
 .../devicetree/bindings/net/nfc/pn532.txt     |  46 -----
 .../bindings/net/nfc/st,st-nci.yaml           | 106 +++++++++++
 .../bindings/net/nfc/st,st21nfca.yaml         |  64 +++++++
 .../bindings/net/nfc/st,st95hf.yaml           |  57 ++++++
 .../bindings/net/nfc/st-nci-i2c.txt           |  38 ----
 .../bindings/net/nfc/st-nci-spi.txt           |  36 ----
 .../devicetree/bindings/net/nfc/st21nfca.txt  |  37 ----
 .../devicetree/bindings/net/nfc/st95hf.txt    |  45 -----
 .../bindings/net/nfc/ti,trf7970a.yaml         |  98 ++++++++++
 .../devicetree/bindings/net/nfc/trf7970a.txt  |  43 -----
 MAINTAINERS                                   |   3 +-
 16 files changed, 623 insertions(+), 363 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn532.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st21nfca.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st95hf.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/trf7970a.txt

-- 
2.30.2

