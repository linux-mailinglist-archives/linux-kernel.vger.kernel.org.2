Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92C3B498E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFYUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhFYUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=C4xRghxzE13EJ0cSapJpfYW5rL01DQTdPI5fxg+ThN6kHDCbBuIl1ncQuTEHAT0Luc3x2J
        L6YdZsqelnlWp0koIbs29998Ai3x5wktxKP+WGkUfOayXh7nuQPyu8FHscAB0zuXvH88/T
        VK0ZAjOKmo8n65QKXzMsCYaO6Py/wkg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-hvt810_uOOSXm3Bo4qG79w-1; Fri, 25 Jun 2021 15:59:05 -0400
X-MC-Unique: hvt810_uOOSXm3Bo4qG79w-1
Received: by mail-oi1-f198.google.com with SMTP id n144-20020acad6960000b029023d8bff0429so2782904oig.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=bhfN8yKw2SP5aEYppf95hJthTASlZsXPgErpzfrPIYnu6fiqeCnGv7CEhQhmUwU/YB
         +BX17WCo8dLzcbCK7/l2Hl6hpd0mtSq7lZTLY9RoYf2titB3zux+iMMRlz/tSUcR38LS
         zeZIXRJbkVWGlWn8ke8VzaITQc4srkvzed4UanjO5+mCOamUHHfjFP4XlmIMKUqvvfAC
         AwzrFWO4qFx+DE+cs4Noc513LyugaY4dWRlOv1/NeuY55PM1472M2Uhta2vMHNBcS5Hu
         eiL+U/mTv8ZSM92QjQHPlzD6rbUprTVNQ1l3Itibz4EYgfqK+abSuddqMrp7iD3KiNpF
         4i3w==
X-Gm-Message-State: AOAM532zR3xS8laoB8G8CAhSLV0YTllxuM7OxDIUVvnAukzrFiP8MGsZ
        Waa/enyqjVkY/IAFTMaA7YujdZJVxGJdR9e3qQeeuG3DiN4qJ9g6tPhaJSaCSanN9ugvZqv1DgT
        H4z5TJDv9IHZfmkSBJ7BZbpcw
X-Received: by 2002:a9d:1444:: with SMTP id h62mr11278371oth.166.1624651144411;
        Fri, 25 Jun 2021 12:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeem8EOmmmn5y8CPZeFaRc3c9s14pMP/nstObriZEyihVaSXAzzok2ediru14hgoYsiKudHA==
X-Received: by 2002:a9d:1444:: with SMTP id h62mr11278356oth.166.1624651144276;
        Fri, 25 Jun 2021 12:59:04 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:03 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 2/4] fpga: add FPGA_MGR_REIMAGE flag
Date:   Fri, 25 Jun 2021 12:58:47 -0700
Message-Id: <20210625195849.837976-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 53f9402d6aa17..0791e22b07f88 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to an FPGA image
-- 
2.26.3

