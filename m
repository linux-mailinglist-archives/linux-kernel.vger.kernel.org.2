Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357863A05CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhFHV0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234314AbhFHV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp596HvsXKCpAwusArsHwfjreuet0FT2ap8ASM9VttM=;
        b=ACF1Kgaq4XsrGOjOAk9OU6cy19uBz3wd4ibpuFNM9cogfAFAuYGyCyKoGg2Tki9rHDO0I0
        WnNgAbnVidiA6j5SenGDHMMH9l7JZyV+/7EyEqDaBGu+OUSNanTRz65SRaud//lvzVAGVL
        vKMaVl4C6cSD+xbBsp+SF3zD8THClZs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-_VkFdhQ9OKOTe6k_V5rwWQ-1; Tue, 08 Jun 2021 17:24:13 -0400
X-MC-Unique: _VkFdhQ9OKOTe6k_V5rwWQ-1
Received: by mail-ot1-f72.google.com with SMTP id t13-20020a0568301e2db02903db6adef049so10150968otr.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wp596HvsXKCpAwusArsHwfjreuet0FT2ap8ASM9VttM=;
        b=RlxaFG8UP8TD7sPfsqxztdpd1RxAAcUlny/XD4Tk8iQAM3c2rjm1C2p+sTA7hNWwoh
         4Gsy0PgGVoW8CDS+38emxJ/1bUtVYcV7c3tCkawd1VWJcytnaRWbH3EICJ9I3R2Lo6VR
         M/RE0FxBE2tAADmciQzeK0YVKMODi9wILFdume0v+WJvFnz3d/nt+OScldsad62C6hLB
         Qn1KKmnJv/rBnkk2Y/UQ+DC09dZrgiXBG90ER9H6ddPGPXJP7M3G61mRAxpQf2K5O0vK
         rTz10IdrYbtaS9jfPhyOURCTvl2Z2W6WGdxZbC2r1Hcvtpn0ABcJ85NtYp1n0DZbhzig
         ZReA==
X-Gm-Message-State: AOAM533jD2LK89DuX1cUaFbgN0wi6KYZftjKnUgvMB5MgKY2su8IkmiS
        q95MXL89sM7ukn7+1k/A+EMZuGHhBRKv85NrxzmL5RfIWlWt6BsRddR67UeCVW4Cbdn7T2rP2MU
        NzqwUqVsl8bw4LhJWMO8xxlsK
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr12732173otr.62.1623187451510;
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLOwO0hiMF+KA6dMHmw2cY7cTlxB9WKoQb/W2MRs5OG0rKOt4HtiG8bWLvQUw/6wISGO0yyQ==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr12732164otr.62.1623187451344;
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
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
Subject: [PATCH 04/11] crypto: marvell: cesa: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:43 -0700
Message-Id: <20210608212350.3029742-6-trix@redhat.com>
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
 drivers/crypto/marvell/cesa/cesa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index c1007f2ba79c8..d215a6bed6bc7 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -66,7 +66,7 @@
 #define CESA_SA_ST_ACT_1			BIT(1)
 
 /*
- * CESA_SA_FPGA_INT_STATUS looks like a FPGA leftover and is documented only
+ * CESA_SA_FPGA_INT_STATUS looks like an FPGA leftover and is documented only
  * in Errata 4.12. It looks like that it was part of an IRQ-controller in FPGA
  * and someone forgot to remove  it while switching to the core and moving to
  * CESA_SA_INT_STATUS.
-- 
2.26.3

