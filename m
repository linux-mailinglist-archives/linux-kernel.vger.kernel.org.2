Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148593AF201
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFURda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhFURd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:33:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99FC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t17so11310790lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qc7XMJSCEk0yw0FDTagps7kkRL+MmOfndFLGM8KO6hA=;
        b=bSRZALZ2YuEMo00vAXwANz3eqvyOTtEzGN39+ZqNKh4HVWmIbeY5zpeLUYpXimODlL
         UOdba/ohNovpdlP2Gi8cToziF+jWG/7h6PDAsPWPhUZ3Yh4PPlevZ1htkJ27hmrXqqf3
         egWIfzWeuug4Vj0gdt3Kcvkhz3VlJjuW5SapnzhTN3oX98S+cIwEhjGvaq4VySKmwW+n
         UHDA9fQdVOTbGcwvpXnc+vzE0Yhf3JN5vascvnqiua7siO7pCElIRnINY0joOgsSZz7j
         4du54n2gMzal2UcQZq5ECECUhq2B9qRmITTDQqKViXttXn73lrKbgn6LqVfc+cR8AeUq
         iNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qc7XMJSCEk0yw0FDTagps7kkRL+MmOfndFLGM8KO6hA=;
        b=SboE8WAPCvfgdvh1hNCVlr/F2onHNC8zO4T1LtH8IXLdsb1tf5MrZkerL/MPtSzsOT
         8TxhNEx6f+fD0SMwxmGeNA5BtPiKBC5CKZ4QKLIYUVuOGcEATcxvs0nnvzW75IP9yKq7
         /UnaHuMr2Hn3c5ohbvDNNbH4VpveQwlJiIM3OSGPjvkldCo7G9LMXcuN6EfQb6HmhUTE
         kbQUhkJbhsDHZ4RZ4SGqN3O9OmEccCUhl/zwXtY//gHwX+WhYX1w6zFXXED3gCpKzqx4
         zs4Jk7t3jPgAz0DLbrMZQf/CYwS3g+4zVZmMYYFk5dN62d1xDFpWjQInmOBCmi++Df0O
         9U9Q==
X-Gm-Message-State: AOAM533zEIU/HnMSUX8Pq8P9S8fxim5ir3ucA2Jbu+O0YU6pguM+vnuj
        pMSBTKYNWfgTBJcfSZrCd2gYl3Fzgiu6HA==
X-Google-Smtp-Source: ABdhPJxB08aNU1e3BQjbGaxHU2kJwPo/Sl5zRiBE+PXfnI5WOmB/eoR22Q27TpE4iT6xhTIb/lOIAQ==
X-Received: by 2002:a05:6512:31cc:: with SMTP id j12mr15292327lfe.158.1624296672013;
        Mon, 21 Jun 2021 10:31:12 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u11sm1926380lfs.257.2021.06.21.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:31:11 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v3 1/6] Documentation: ACPI: DSD: describe additional MAC configuration
Date:   Mon, 21 Jun 2021 19:30:23 +0200
Message-Id: <20210621173028.3541424-2-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621173028.3541424-1-mw@semihalf.com>
References: <20210621173028.3541424-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document additional MAC configuration modes which can be processed
by the existing fwnode_ phylink helpers:

* "managed" standard ACPI _DSD property [1]
* "fixed-link" data-only subnode linked in the _DSD package via
  generic mechanism of the hierarchical data extension [2]

[1] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
[2] https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 Documentation/firmware-guide/acpi/dsd/phy.rst | 59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/dsd/phy.rst b/Documentation/firmware-guide/acpi/dsd/phy.rst
index 0d49bad2ea9c..680ad179e5f9 100644
--- a/Documentation/firmware-guide/acpi/dsd/phy.rst
+++ b/Documentation/firmware-guide/acpi/dsd/phy.rst
@@ -50,6 +50,21 @@ phy-mode
 The "phy-mode" _DSD property is used to describe the connection to
 the PHY. The valid values for "phy-mode" are defined in [4].
 
+managed
+-------
+Optional property, which specifies the PHY management type.
+The valid values for "managed" are defined in [4].
+
+fixed-link
+----------
+The "fixed-link" is described by a data-only subnode of the
+MAC port, which is linked in the _DSD package via
+hierarchical data extension (UUID dbb8e3e6-5886-4ba6-8795-1319f52a966b
+in accordance with [5] "_DSD Implementation Guide" document).
+The subnode should comprise a required property ("speed") and
+possibly the optional ones - complete list of parameters and
+their values are specified in [4].
+
 The following ASL example illustrates the usage of these properties.
 
 DSDT entry for MDIO node
@@ -128,6 +143,48 @@ phy-mode and phy-handle are used as explained earlier.
 	  })
 	}
 
+MAC node example where "managed" property is specified.
+-------------------------------------------------------
+
+.. code-block:: none
+
+	Scope(\_SB.PP21.ETH0)
+	{
+	  Name (_DSD, Package () {
+	     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		 Package () {
+		     Package () {"phy-mode", "sgmii"},
+		     Package () {"managed", "in-band-status"}
+		 }
+	   })
+	}
+
+MAC node example with a "fixed-link" subnode.
+---------------------------------------------
+
+.. code-block:: none
+
+	Scope(\_SB.PP21.ETH1)
+	{
+	  Name (_DSD, Package () {
+	    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		 Package () {
+		     Package () {"phy-mode", "sgmii"},
+		 },
+	    ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		 Package () {
+		     Package () {"fixed-link", "LNK0"}
+		 }
+	  })
+	  Name (LNK0, Package(){ // Data-only subnode of port
+	    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		 Package () {
+		     Package () {"speed", 1000},
+		     Package () {"full-duplex", 1}
+		 }
+	  })
+	}
+
 References
 ==========
 
@@ -138,3 +195,5 @@ References
 [3] Documentation/firmware-guide/acpi/DSD-properties-rules.rst
 
 [4] Documentation/devicetree/bindings/net/ethernet-controller.yaml
+
+[5] https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
-- 
2.29.0

