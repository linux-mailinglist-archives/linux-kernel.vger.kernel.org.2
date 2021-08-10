Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E553E7C51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhHJPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbhHJPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:31:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166FC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k4so13345536wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSV6aUx7/dD6h1JgFwyMJboejnqkbCFx02QSUeZTdlY=;
        b=Jw7fJ8pBV2vGpKCPg2qJfUFnn5ES4NZB+hxrNI3TInlX7cfPUpSuuZ979a4ah5bnJ7
         FVwJiQ5NQSz32B/3cgR856pZvUfiJ6QdB9ke405DVjXgGpZM31XkpX8DcU2LFGg4B5rF
         F6zSrrFJvaJ0tTLqpepX2IWrSDyzDg5g7jIb2o9trvbp1iXUqvWxg82QbHomgZkDlcAC
         k6sLSkzwvPLB3uRvEWRweDV5V1hNvjokEcJHiq6QhGJfrWiTV5iADZBuSK+FESIzhOqU
         hzAE4v9VOAgfKovfL5Qwt4GBm52+6a0U+ZQ/4yCWuOx2d9nlrX4Q5+XbkV/3JHDXAlqB
         J2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSV6aUx7/dD6h1JgFwyMJboejnqkbCFx02QSUeZTdlY=;
        b=hNQFgj+K0mkKd9/GDgYamKbuf6wBbP2xhD4rorhhv6YKXJ3FE3XU4VLFjuEbj5lB7G
         ZnzPQ8icvMbxYFERdisYhH0fk1Bz7lAFZIuSg3IR27PM3c7uK1vZegaZxWaSFZv7m+5z
         yWrUk65sDvaf7+RLhlHQ3TYcp6zqAZYbHgcIihUfO62kD23nKPPNxNI8mrWky+QUhA6L
         OGzSj01XYd9fr7w4vhieIAnVzbsFmALL6b/BercR/PG39Pm1owvxCSHEjmy54N3Xp1F/
         gsrOSflCcF2ymST2J1cO2mC5BvSAEyfwZkmEwgaYuPlPB7o9JDjFt+0HilwZCWXtZsBa
         wsyA==
X-Gm-Message-State: AOAM530dNl+B9rKJtAq4bbOzaxSIR3OueRwNthkyhMWYpq7FnEODiN1G
        VnNTS/gVIfIA0B1G7xvrkOUh6A==
X-Google-Smtp-Source: ABdhPJwZP2ER64NnEe8Hig32io6bVJ1ErxOvN+eGG18ENcl2Bs9LocGrfE6rXqAin0ZdXysS6j1MRA==
X-Received: by 2002:a05:600c:2302:: with SMTP id 2mr5240879wmo.169.1628609454591;
        Tue, 10 Aug 2021 08:30:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j1sm3002354wmo.4.2021.08.10.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:30:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] nvmem: patches (set 2) for 5.15
Date:   Tue, 10 Aug 2021 16:30:34 +0100
Message-Id: <20210810153036.1494-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem (set 2) patches for 5.15 which includes
- new nintendo-otp nvmem provider driver along with its bindings.

Can you please queue them up for 5.15.

thanks for you help,
srini

Emmanuel Gil Peyrot (2):
  dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
  nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP

 .../bindings/nvmem/nintendo-otp.yaml          |  44 +++++++
 drivers/nvmem/Kconfig                         |  11 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/nintendo-otp.c                  | 124 ++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
 create mode 100644 drivers/nvmem/nintendo-otp.c

-- 
2.21.0

