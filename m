Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17031D147
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBPT5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBPT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:57:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D6C061574;
        Tue, 16 Feb 2021 11:56:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id do6so8119456ejc.3;
        Tue, 16 Feb 2021 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmrtnPXCD3lM2n5tvEfT5pQqzuGL0Fcvb04FWPJXdvM=;
        b=TrYyuXNG326Lf9T0XKT3xldpL3tZ5ZK8+oe2VK6wSswubBHEervTdnV0JxTGjAoBd4
         /V19izDbiTeAay61Fd94z92echr1vTjCKWLju3RFKWwsdI+CGAeYhr8LF1eAhmbpGppk
         lW4J/WE/Tqp27fC86jNlKFHtNBR1yGdM4Lu3cVKqbS/VSDefDAMpS7CgD5Q/Gei99nMt
         4+G3zpyk/N9Xvk0RBoJnVSDQ/YlOwg8XYoKk55OE0L8eCZ1BrFuOjzANDRrlayKGafgf
         oTHCxr4H/fwv/9fkXaRQRVPFWYOu3i8KH/RL1S3uHxI6m8VkwqiBe8zsEQXhYoRTwsYw
         HFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmrtnPXCD3lM2n5tvEfT5pQqzuGL0Fcvb04FWPJXdvM=;
        b=sdjvczTTaGmfUKDSfpkrz91yaYkUVWOnBUq7iAWAp3K32Tp69NNaPvl1zYnqDQYchD
         yUlW01ltcSefnmd9Jw4acui34znZEeQlcyo3AayS/wEeQAmggCmFN0wOv2T+/d3FT5++
         wRRmlWSa/TllvkPcevfFnCZo0zVzs6bVIZ7sSMdjCZ0i+I5eBoZU+g9RcOTV+I5SDUAK
         Hobb2JYFJOGVakIzmT2Okusnhd0UPsraNrezW8RjRGozDaerUJV+FgLAAoj2bIxBQmhL
         uTTFTH4hLe4WSDNmLlrGRK2wY8ktVFIags1YsjBD6nuM0kP8CCyvaaiKqJznrmn3OYH2
         L4SA==
X-Gm-Message-State: AOAM5327aiM6ELMMf4FO7JeuJflNsCWbDawcTmagD2kl5sBe14Mm/Biy
        9OvtWEuBGGA71PBc4/a595g=
X-Google-Smtp-Source: ABdhPJzuUW25BARHUvkOTFcexOuBecvymIGNIzWJWeiJ0BjTaZDQQRKmGMvpqd17j/DPPFaByuX54w==
X-Received: by 2002:a17:906:2652:: with SMTP id i18mr1946178ejc.213.1613505384494;
        Tue, 16 Feb 2021 11:56:24 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id rh22sm963332ejb.105.2021.02.16.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:56:23 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Implement nvmem support for mtd
Date:   Tue, 16 Feb 2021 20:56:08 +0100
Message-Id: <20210216195618.27959-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtd support for the nvmem api has been stalled from 2018 with a patch
half pushed hoping that a scheme is found for the mtd name later. This
patchset try to address this.

The solution is simple.
New partitions scheme should always have the partitions {} structure and 
declare subnodes as partitions is deprecated and should not be used anymore.
Fixed-partitions parser is changed to parse direct subnode as partitions
only if the appropriate compatible is used. This change make possible
the use of nvmem-partitions compatible and the entire partition node can
be parsed by the nvmem of framework.
The current code register the partition to the nvmem framework every time
but skip actually of_node parting. The new nvmem-partitions compatible is
used to enable of_node parsing on the desired partitions.


Ansuel Smith (3):
  mtd: partitions: ofpart: skip subnodes parse with compatible
  mtd: core: add nvmem-partitions compatible to parse mtd as nvmem cells
  dt-bindings: mtd: Document use of nvmem-partitions compatible

 .../mtd/partitions/nvmem-partitions.yaml      | 105 ++++++++++++++++++
 drivers/mtd/mtdcore.c                         |   2 +-
 drivers/mtd/parsers/ofpart.c                  |   5 +
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml

-- 
2.30.0

