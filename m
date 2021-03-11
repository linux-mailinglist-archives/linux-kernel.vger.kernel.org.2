Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDE8337A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCKREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhCKRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:03:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD039C061574;
        Thu, 11 Mar 2021 09:03:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bf3so3867751edb.6;
        Thu, 11 Mar 2021 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=dRoK/5Y9w7PG6auT6ZudfCM6FOG7DpqSmflGRRG4DKuffxACMDeG1P5mfGHpBl/SmO
         rkGL2d3HCT5kFv0KaZp5pCxoeGZbLyWifomOXRKzZrcQrMtbTz4FbhV74xbFdAPknJAW
         oGyVyrW0/zNg5bENsUQ/Tnl2DMzf9xJvXQfIiFC3MXBskpU8/MGx05dX5/2e3u+6KC3U
         GNXBjKaGpLr6PCfXgs9h94ie2OTL7TApL6IEDcEgiK28rp9DDJQ+JZwLCq52lhvTxUXh
         V5dz7YAh4hoPPGBvDkVPrVETr8zbZnBsKgiJ8WaQWsKEJXFtaXXoAoUKIBdOJ2kCPpWn
         ZodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=bYiyBsICduxFZBSbGQIpTyQ/nSRDi7RwKlmqcBW+NkOX/b9LaVONP50i3wGCAp+NtL
         HatB3GAWnzA9ygLDIzokjLkbQzPwjTpLjiJGxbhxni/efYBpO6zSQ9PETDcKU7jQIJmS
         ItgZHZXH7s2Jkov6n8U7ZWmRqB5UCHONsVsvoPQt3aHyKLenyQMGQp7WINLA8/KkHHOl
         JztdhfdYpD8TMFHGgfSOawPkZO5wjWflQ1RqVJN6ZIR2dA3A8fMP/LrhCKw6b8fryca4
         Cwq3sV2YyKp/dOTKAFYbZV2wYzuN4+vMaLGxe0R1FzCOVD4SPJhF0MRYrLg5vpPnF1Cd
         cyIg==
X-Gm-Message-State: AOAM532nCH2qkVM44tc1cM7zP2N9kccjnnG8XHz2exi+2rwpB+woPz1o
        vNEwC/GX7dMnIpjL0/joJfY=
X-Google-Smtp-Source: ABdhPJzWjm/dVhAPjRJToEBbtc/5CZdeISlWchLsH+0sJdKagZmW8JyR4LY5IR8mK2hdQKi5DcKMSQ==
X-Received: by 2002:a05:6402:704:: with SMTP id w4mr9933440edx.175.1615482225554;
        Thu, 11 Mar 2021 09:03:45 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id b4sm1627205edh.40.2021.03.11.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:03:45 -0800 (PST)
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
Subject: [PATCH v6 2/3] devicetree: nvmem: nvmem: drop $nodename restriction
Date:   Thu, 11 Mar 2021 10:56:59 +0100
Message-Id: <20210311095715.17048-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311095715.17048-1-ansuelsmth@gmail.com>
References: <20210311095715.17048-1-ansuelsmth@gmail.com>
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

