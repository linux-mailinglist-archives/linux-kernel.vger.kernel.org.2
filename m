Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24315337250
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhCKMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhCKMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:19:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E917C061574;
        Thu, 11 Mar 2021 04:19:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w18so2430519edc.0;
        Thu, 11 Mar 2021 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=fgeawZzrBbCGdcAcelur+0SABygA5M29pxOKik9PqPGuRJeYG3++RrM99cKN5ZnBCY
         8DUtgcoZKtjVyhYq51WBmsH2MM6T88TtXF7uE/eLQtQZ8zZoBw4dhlbRcFN6BtbufYD2
         YOXx7v+TJ3oHBCfX3rlbT6cboH9c6o+zbPztZPAOx6mXp1sd9lcIckkncy7PN23JlPnh
         QCkca64+f1dHVVeVDhFK7asr7p00Oqz7EZjcl6HF9N9tznb6zLLajtcdwtXICybDYvoR
         Bq/X6AvxvApOldH7ABXtX1EjPHdgkozhlDYqBWQM9gVxSDj5FSHIlLQgWOuqS6QcqsgX
         E4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=IOAdaiz8+fLcn5lkF2ecetk9/N7z+CHxgU4VnM4jUsR/hGQIp9uQyvtPkY0sJL1JAO
         396SqKkRSlgPgtLVnft8EtXmcEDro9NEqzVdHuRyVCEEw1hwq93evg7GgqF28mkRQ4pR
         fuWNgfY11PN0IYCcR1ZJICEzdZx0u/kwmChV6bEvxRacRLHtjzHDvWGbCc2l1NYH6oMQ
         Bh1lCy+jnnWanjX5sPUh4ohTxgvE5vsjQFObvNduFfETfjH4kqZHCylN+9zxwn+xiI73
         RkMqeWS+JXFVEZpKT85Dmk9XAWbUtRHvb10mDYn3n1crWNKmfu3FPEa5GTz+1eCr4f1B
         ZnCg==
X-Gm-Message-State: AOAM5333LNbpArYFquMW7dBV2XXuI+0BIHvHAYdWWRHTvtoyxugIQcjb
        k8vSLWKEtzbWR2psT2lYeTk=
X-Google-Smtp-Source: ABdhPJy/LAguhBAHOubln+kVzUm2XTYYb3+YQBi4JS/9M4gqAYnf0B1QXYHEUFxzxcAIn5nHuVYfrA==
X-Received: by 2002:a50:f113:: with SMTP id w19mr8114112edl.226.1615465198235;
        Thu, 11 Mar 2021 04:19:58 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id c7sm1273748edk.50.2021.03.11.04.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:19:57 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] devicetree: nvmem: nvmem: drop $nodename restriction
Date:   Thu, 11 Mar 2021 06:12:49 +0100
Message-Id: <20210311051309.16789-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311051309.16789-1-ansuelsmth@gmail.com>
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop $nodename restriction as now mtd partition can also be used as
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 7481a9e48f19..b8dc3d2b6e92 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -20,9 +20,6 @@ description: |
   storage device.
 
 properties:
-  $nodename:
-    pattern: "^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$"
-
   "#address-cells":
     const: 1
 
-- 
2.30.0

