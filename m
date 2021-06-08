Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E583A05D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhFHV0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234366AbhFHV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gIQrxNh8rCNXWF5A+cmW2C8HVpKFKLZxYRvN1nK0FM=;
        b=Z5zdTwMIEzkafksXfKGo9itBDH9dsrnj3OuYFGhmPMMfBbb/jS8CE2FSWORh9Y0Mbxro5s
        Ao803AEZyEIYHnpzQaHfma2k5APTrL22smOTorJU8jkzvhK0h6I3cb7OlHda0TBCqzjfgO
        wv8V7g9+kr1Lk33nZig3XXSpg2vMsTI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-C6uEJ2dlOZKr8JHktS4Stw-1; Tue, 08 Jun 2021 17:24:14 -0400
X-MC-Unique: C6uEJ2dlOZKr8JHktS4Stw-1
Received: by mail-oo1-f69.google.com with SMTP id r130-20020a4a37880000b029024987ad471cso6927096oor.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gIQrxNh8rCNXWF5A+cmW2C8HVpKFKLZxYRvN1nK0FM=;
        b=AE64N87ca1sbzzsEAYLu/K8HdVmKS/hl0XjvinD5wRxoXFONIPVF1O4LO8Rcu+JP2r
         b8Y9lor8qYlMHZ1rmdaK09Aoly1dNTSyyBXGaCs43JM5TZ3SD/4N3HlfIQ+nowiiUs5S
         xTmBQpqXjsLT70apS4nt5EqFgDmZo4swFMgFMglyeEvSnHrDftg/qNwRbZTYBzklVhSn
         ISbDgsK56PCtjAGxD0Q+Rk5TOWhOgqubdHQtNbRvYwC14Aq8Vi+fX5y+fIKCYuYxIYcs
         XTuto/7qoVuK0dkuFWPZ+wD4oW2H2fwtcm+mfAkJlFDCWSyJU7QMl0+77oUvO5skjsoS
         7Zeg==
X-Gm-Message-State: AOAM532fSFWlGfkCtyHNMD3qZe6MHXhGpR04Dd/mKMCZnmCOj9KRg4VF
        X3MzKRVAa4XvUmNqo2AwGyyJ4J/OIkSI8qsNGRGFqK8mkqlDh8gZxYNp2kLR31HsXverOFtHomC
        IeW49x/KiPNwjpZoJWBSWJCiS
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr4182071oic.123.1623187453959;
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXsoUQfchNBKnL8EdmQmEAp/5gAc1hlFks6ooIHfYu2jxHqDv442A3KNzBoqbETAUPGj1thg==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr4182055oic.123.1623187453793;
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 05/11] fpga: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:44 -0700
Message-Id: <20210608212350.3029742-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc7..8cd454ee20c0c 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -7,7 +7,7 @@ menuconfig FPGA
 	tristate "FPGA Configuration Framework"
 	help
 	  Say Y here if you want support for configuring FPGAs from the
-	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
+	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
 	  manager drivers.
 
 if FPGA
@@ -134,7 +134,7 @@ config FPGA_REGION
 	tristate "FPGA Region"
 	depends on FPGA_BRIDGE
 	help
-	  FPGA Region common code.  A FPGA Region controls a FPGA Manager
+	  FPGA Region common code.  An FPGA Region controls an FPGA Manager
 	  and the FPGA Bridges associated with either a reconfigurable
 	  region of an FPGA or a whole FPGA.
 
-- 
2.26.3

