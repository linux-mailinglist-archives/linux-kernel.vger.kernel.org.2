Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB23443C7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbhJ0Kgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhJ0Kge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:36:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C40FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g7so2223750wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suhKpwwWq8DRUbg6cUq+Xf8wBoWhzVH4F87UvqYAAsA=;
        b=d+bp4mhHCrPuGIsJAGL3iqjN+o+cKlzHqY/+rB8JJQ6OEoshd7znMOk2j3OELF919E
         gAhyb3x/Z5KdMKTJ+kw8T85lbKeBxsqzNFhJpJyUb0xTcg3QV2+sQTAaA13EM8p1xfXR
         cEQXDJdS1HoSw7u6I/wEqdYucFl002uOQC5SGPK29ZLil+DH+0hmgH1hUL2DTxznlptM
         6W5KeStUjpyyhykIHCiRUwCy8lgsKZ6/MAqz/0F8gMnf9aezn9NcuhA4KA946t7f4WRZ
         GO/uklGjZKFhON+QPlFiXJMdK0g16xB4oJM/JMqP+db5n/srwuA8mzCTOV24sD3aWvCn
         AvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suhKpwwWq8DRUbg6cUq+Xf8wBoWhzVH4F87UvqYAAsA=;
        b=U8h6BPXkmSSaWd2qnlA12iT+Pg8NRvWt8LbpSLkhfSwnUrkMY9GVehrpx89t6NajnW
         VwFxSwRM2DSzIBaqjoJ97bHTwCusQt+gWMcpObam/sJo9P5lsU7jJqJ14J7GjR54rXXY
         9o2ubNazGmp4F1Wq22ZdiOSat1KyKBnekvXjwXyp3oFLTL63Ea3ifhWajVbLKjD1tudD
         +opGuHmJ6LeqcuQWno3R7LRc0iDpdE8F9N1iAfSNqtTlSjxEwBcBnFgBDvPNAuCUbgMk
         ykG0UvB7rWXsQuummtViNQi5nO9OdTZwJmuSF+8JiGfQQo+Atp3KjKg3BgohYJ5hJ58g
         reQg==
X-Gm-Message-State: AOAM530zvITEqHI9mAm6Q5abZ6Ka4YblWZum/Tgp7Eisg0fbs0BPX8xA
        KytbSlMkFZSPZFP8WucHFuU=
X-Google-Smtp-Source: ABdhPJywEnxN/byVU79Z5DRkcYBOay9IyzcC15oTzCWHo11wk9mjnOAvYqJZmX/K4W6f7ayWFNAbPQ==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr27049944wrz.54.1635330847643;
        Wed, 27 Oct 2021 03:34:07 -0700 (PDT)
Received: from authentaworks.lxd (ip5f5be9ad.dynamic.kabel-deutschland.de. [95.91.233.173])
        by smtp.gmail.com with ESMTPSA id j10sm7140198wrx.94.2021.10.27.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:34:07 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 0/4] enabling Advanced protection and security features
Date:   Wed, 27 Oct 2021 10:33:48 +0000
Message-Id: <20211027103352.8879-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Standard protection features in SPI NOR flashes are legacy and offer a
simple way to protect the memory array against accidental or unwanted
modification of its content.

These patches enable the support for advanced sector protection which
protects memory from accidentally corrupting code and data stored, and
it also prevents malicious attacks that could intentionally modify the
code or data stored in the memory.

Micron Flashes offer some of the advanced protection methods using
volatile lock bits, non-volatile lock bits, global freeze bits, and
password.

Shivamurthy Shastri (4):
  mtd: spi-nor: micron-st: add advanced protection and security features
  mtd: spi-nor: add advanced protection and security features support
  mtd: add advanced protection and security ioctls
  mtd: spi-nor: micron-st: add mt25qu128abb and mt25ql128abb

 drivers/mtd/mtdchar.c            | 145 ++++++++++++++++++
 drivers/mtd/spi-nor/Makefile     |   2 +-
 drivers/mtd/spi-nor/advprotsec.c | 209 ++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c       |   2 +
 drivers/mtd/spi-nor/core.h       |  20 +++
 drivers/mtd/spi-nor/micron-st.c  | 245 +++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h          |  19 +++
 include/uapi/mtd/mtd-abi.h       |  11 ++
 8 files changed, 652 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/spi-nor/advprotsec.c

-- 
2.25.1

