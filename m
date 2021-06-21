Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF23AEC38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhFUPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFUPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id he7so29420386ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCNAaafNj+4vIYMCE6BaU8BQ51vMFCgrIkuTeCkG8XQ=;
        b=d0yKttHj1+xWLz+gt8ga7xWlBPI9lQZ8See64Se9W1MX7AaFpgndPL8aFz4SZk9o0q
         daBm0osE4hkxfWYcYukvAzlItpAQmJ/BkRQXwqSLDjTD7AKKUhGUMxgYtRXoVLjlpqjR
         wRbQnoq/OLHA2Ir6pIkKwevzxuD4wBHEGWzC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCNAaafNj+4vIYMCE6BaU8BQ51vMFCgrIkuTeCkG8XQ=;
        b=H00FQxDWNULbjPJbzdtPIIGMLnb1WK7RRzodazFr/0ta1WXU9Id0dFRoLArQM5Cdjp
         HwBPtIINBAwJcdGFptZwFrxdTv56SM6ecE+Pab5o+LmMrqXN2JKw7SLR0ztUlV4qO2PV
         Wti3jG+KZNMIMKffnnZOoehnu+Vc0lVVTBXWwe9nY45962n5japzQr/BBUT/RvgNh9C8
         02xyBqRygMAq/tJC7DBCpPKEt9YwXaZ+EU9ngy6Xrs+N5y0iASiSlxU+7UhQ84gl8rQt
         JjDPkX4IsIsOkl3XUf5hGHw6QA+InuGBRir56EFKJqgyAOgR9I/TJq1kdsky1IEFIYZp
         Ss9Q==
X-Gm-Message-State: AOAM532DBsWeKqmYY4K58usimUutSy6r7mEgs3gaCbS7e2CPBt0fPWwa
        TuenmNHVIrEbtYV812mQ2jF/lg==
X-Google-Smtp-Source: ABdhPJxLQENI+f0AiVfMHFBW/wQIifzZ78MC7T+dMTAOZjVorKPvwYKpZUenrjA0yLEDZr5kf4k2zw==
X-Received: by 2002:a17:907:3faa:: with SMTP id hr42mr8003974ejc.129.1624289011355;
        Mon, 21 Jun 2021 08:23:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id q20sm5021079ejb.71.2021.06.21.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:23:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-mtd@lists.infradead.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC 0/3] mtd: spi-nor: dealing with reused JEDEC id c22016
Date:   Mon, 21 Jun 2021 17:23:17 +0200
Message-Id: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use the Macronix chip mx25l3233f in a number of
products.

Unfortunately, it has the same JEDEC id as another chip which is
already listed in macronix_parts[]. Since that other one does not
support SFDP, and its data sheet warns against issuing commands not
explicitly listed, we can't just do RDSFDP anyway and decide that it's
an mx25l3205d when the chip returns garbage.

For lack of better alternative, start allowing multiple entries with
the same JEDEC id in the parts tables. That allows a correctly written
device tree to specify the right chip, without being overruled by the
"JEDEC knows better" heuristic, while being backwards-compatible (as
long as new chips with recycled ids get added after the existing
ones).

While a step forward, this isn't quite a complete solution for our case:

Some of our platforms are based on LS1021A, thus using the
spi-fsl-qspi driver. Back in the 4.19 kernel, when the driver was
fsl-quadspi, we couldn't get the flash recognized unless we
monkey-patch-replaced the mx25l3205d entry with the mx25l3233f one
(i.e. added the SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ bits) - we'd
fail in spi_nor_select_read() because
shared_hwcaps&SNOR_HWCAPS_READ_MASK would be empty. In contrast, with
current master, the chip works with or without the third patch in this
series, i.e. whether it is detected as a mx25l3205d or mx25l3233f. But
the read performance is ~3 times worse than in our patched 4.19 - I
haven't quite figured out why quad read doesn't seem to be used or
work.


Rasmus Villemoes (3):
  mtd: spi-nor: core: create helper to compare JEDEC id to struct
    flash_info
  mtd: spi-nor: core: compare JEDEC bytes to already found flash_info
  mtd: spi-nor: macronix: add entry for mx25l3233f

 drivers/mtd/spi-nor/core.c     | 18 +++++++++++++-----
 drivers/mtd/spi-nor/macronix.c |  3 +++
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.31.1

