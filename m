Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64641393262
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhE0PZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237074AbhE0PZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622129043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1kCrvAGNk5x+9ZoqSebLak4g0PU0sL2l99GoIBSvwDw=;
        b=MCT8H1y7KyRtD4PA7PRtFkbQCXUgJhC7FyjfYQmIY2ssEnCRtuyUOf5yZKhiyVwOdNSXqz
        JHDstiLkKvmEfUQxZXddUYEX1PVBbWFLlovaonm15WMNsjtT/GsNANXWbElcPRKr7XX2Mu
        Mb3TJMX5JV7nLpnybEEpyO7Qod7xn1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Oma7yM0kN_eyTg9Lx6nGUg-1; Thu, 27 May 2021 11:24:02 -0400
X-MC-Unique: Oma7yM0kN_eyTg9Lx6nGUg-1
Received: by mail-wr1-f69.google.com with SMTP id p11-20020adfc38b0000b0290111f48b8adfso84437wrf.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kCrvAGNk5x+9ZoqSebLak4g0PU0sL2l99GoIBSvwDw=;
        b=AumDuXB0+AQlDtbVUQZyiUlDRgRjQoPKfCEcEhEAeRwXJohOgWch/GSEllQMw23PE4
         pVSg3+w5sF2aJOpr8FlZvAsjs8at+QaXolPWRJEXMJ9qazCWtQ/3O+mo0ZVBzT8ofgL3
         58EtinXSRJkeDajvjCxnOiNdzOzh9ussjsMt4HXqhnpLSfSk0NFpaGB0+ORUPPYtbQWS
         XGgQckZCzuE+wSx/ON7OwbBoMWmgw/1h43wPZPTwJvlrEAlNYsBkTw4EFXqsgU1+qgiq
         E8b8UGJv50ZDzNJLB8d8wviCIyzd/2/pHNABPHdMYgg/BrAZGTFXx8fLILj5BJeKAcrr
         A5pg==
X-Gm-Message-State: AOAM533zrp436cKeHDhyh7ooFYTxebvDwo1PGk0QnwLAZ11tQMGQFiO6
        VO2h5EU5glrxSh0b1lz5JOQaDOMkhPUUyBnsOpIoBt7ICpMHUSG7qaZO213adUBWpFw5HJ4Triq
        unwhGIsFzGQeEjycorEvLzaIrR9jUNf81WeUEieOk/7or2PExOKz8D4xkRbQAw2A/8vBsZ5NUbc
        Q=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4246487wmj.84.1622129040509;
        Thu, 27 May 2021 08:24:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztaJymgHwJOsX1iIFw99a7GlGot9wAyRTZgOLuVZfzZW5nP4EfgoQ88bQesUBm7rDx0IdFNw==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4246461wmj.84.1622129040240;
        Thu, 27 May 2021 08:24:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s5sm3551714wrw.95.2021.05.27.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:23:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Date:   Thu, 27 May 2021 17:23:52 +0200
Message-Id: <20210527152352.3835076-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
registered via OF. This means that this module won't auto-load if a DT has
for example has a node with a compatible "infineon,slb9670" string.

In that case kmod will expect a "MODALIAS=of:N*T*Cinfineon,slb9670" uevent
but instead will get a "MODALIAS=spi:slb9670", which is not present in the
kernel module aliases:

$ modinfo drivers/char/tpm/tpm_tis_spi.ko | grep alias
alias:          of:N*T*Cgoogle,cr50C*
alias:          of:N*T*Cgoogle,cr50
alias:          of:N*T*Ctcg,tpm_tis-spiC*
alias:          of:N*T*Ctcg,tpm_tis-spi
alias:          of:N*T*Cinfineon,slb9670C*
alias:          of:N*T*Cinfineon,slb9670
alias:          of:N*T*Cst,st33htpm-spiC*
alias:          of:N*T*Cst,st33htpm-spi
alias:          spi:cr50
alias:          spi:tpm_tis_spi
alias:          acpi*:SMO0768:*

To workaround this issue, add in the SPI device ID table all the entries
that are present in the OF device ID table.

Reported-by: Alexander Wellbrock <a.wellbrock@mailbox.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/char/tpm/tpm_tis_spi_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3856f6ebcb3..de4209003a4 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -260,6 +260,8 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
 }
 
 static const struct spi_device_id tpm_tis_spi_id[] = {
+	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
+	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
 	{ "cr50", (unsigned long)cr50_spi_probe },
 	{}
-- 
2.31.1

