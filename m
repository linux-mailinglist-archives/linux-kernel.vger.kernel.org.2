Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A771428E31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhJKNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:41:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42240
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235602AbhJKNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:15 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F04313F31E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959555;
        bh=tIWsei9VtLBv9/Mx8g5CaNZvn00Tm6hK0YRULa+amvI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KwqJl/vUIC1mQM/AKpaSxS6OWhGw2lIMBy5l2BkvFH8wOVYKNAp0QNns0IANJSuIK
         xPwad4y0pCLWlmG3WpdaW/+pxQChiufzSd+jQlFTbhzuYWhhWwuzAKXpnPxDys6rJA
         3B2ncn2vZsMiZmM8G3RTPbdD2xMZmQOR/vQzs/E7hBbeVT4tmdlEPqYnSU/zkKjPFw
         kMnNpvCws5DmzgO093uRDGpg7sRgcUYZrVXY6MjHUCOxv7HjhXl8VmZFYtEgUGQ23+
         DtArbIycDDxfW4fUB5ziqXLh/8jPdgxxQ7tCatyVlL2tXbT9yJMZRj0rJAP/TppZ0M
         06dznc/3lIopw==
Received: by mail-lf1-f72.google.com with SMTP id x33-20020a0565123fa100b003fcfd99073dso12823167lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIWsei9VtLBv9/Mx8g5CaNZvn00Tm6hK0YRULa+amvI=;
        b=fyDQd/j67DfNYztluJePPOl13NhtoyM7O7tvd/xIGMs4Y9ee/9X6LLrsRRd5oghx+f
         ktN/cMhnR77ezewozc8D+FcIpaTO+Mp39/h5BcQbVmvZWZTkQ4+uyPYLVe4WywBJOLzD
         ca3Ds0/sVrlAVXPUSNnP/Uu+7LizWjvnzU+zPUHa6gmnqDQxPC5INnBDU0HZh92EhNKc
         mJXClmViMsydNdtmVPOBdazImlW0SrZxbOCUr17TlHbRbCtJn1MTF5j6ExhtDYC/imoF
         8tbbNwGfW3JqvxjzcBTuRv4s29QTtp0IeLB9VrKFlW2OulMSqTOUuzfpDaTuxNleYCcT
         pfuA==
X-Gm-Message-State: AOAM531+3CbwLaEEOy20XOjfs5BcPnspXQ+qFucJGVOmH5K19cj3CBwb
        0n1T835eHqN5kuISbgcgQlGX7asKx0nNZNXTkV8Ja8J8tVqe8vFa3sSIR0S5KRxs/cJ8pGn/JQX
        4FtSTidzFSePlI6YzC2SJAqce/HybFQQxSQRkLKYORw==
X-Received: by 2002:a2e:9aca:: with SMTP id p10mr7366373ljj.2.1633959554372;
        Mon, 11 Oct 2021 06:39:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzijV8Dsmu1SXjyWeKKz8IEYUPu1ARW5pZYtMPBGBW0/V8SedfqGjcmq4Og0JRM9nXpPz4tug==
X-Received: by 2002:a2e:9aca:: with SMTP id p10mr7366352ljj.2.1633959554204;
        Mon, 11 Oct 2021 06:39:14 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 0/7] nfc: minor printk cleanup
Date:   Mon, 11 Oct 2021 15:38:28 +0200
Message-Id: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Changes since v2:
1. Correct SPDX license in patch 2/7 (as Joe pointed out).

Changes since v1:
1. Remove unused variable in pn533 (reported by kbuild).

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  nfc: drop unneeded debug prints
  nfc: nci: replace GPLv2 boilerplate with SPDX
  nfc: s3fwrn5: simplify dereferencing pointer to struct device
  nfc: st-nci: drop unneeded debug prints
  nfc: st21nfca: drop unneeded debug prints
  nfc: trf7970a: drop unneeded debug prints
  nfc: microread: drop unneeded debug prints

 drivers/nfc/microread/i2c.c    |  4 ----
 drivers/nfc/microread/mei.c    |  2 --
 drivers/nfc/s3fwrn5/firmware.c | 29 +++++++++++------------------
 drivers/nfc/s3fwrn5/nci.c      | 18 +++++++-----------
 drivers/nfc/st-nci/i2c.c       |  4 ----
 drivers/nfc/st-nci/ndlc.c      |  4 ----
 drivers/nfc/st-nci/se.c        |  6 ------
 drivers/nfc/st-nci/spi.c       |  4 ----
 drivers/nfc/st21nfca/i2c.c     |  4 ----
 drivers/nfc/st21nfca/se.c      |  4 ----
 drivers/nfc/trf7970a.c         |  8 --------
 net/nfc/hci/command.c          | 16 ----------------
 net/nfc/hci/llc_shdlc.c        | 12 ------------
 net/nfc/llcp_commands.c        |  8 --------
 net/nfc/llcp_core.c            |  5 +----
 net/nfc/nci/core.c             |  4 ----
 net/nfc/nci/hci.c              |  4 ----
 net/nfc/nci/ntf.c              |  9 ---------
 net/nfc/nci/uart.c             | 16 ++--------------
 19 files changed, 21 insertions(+), 140 deletions(-)

-- 
2.30.2

