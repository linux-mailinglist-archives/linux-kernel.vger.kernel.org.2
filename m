Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE0382927
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhEQKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbhEQJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:55 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1G-0002SZ-Rh
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:38 +0000
Received: by mail-ed1-f69.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so3631703edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBjcovMcJ4H/KV7YFF8hsif22PyqV7UihiYg3q7oL80=;
        b=Qj3efIepSuJ1ieNY0a0JQjTCxLe5MJXMVIxl0INgcSc6ehMjHNACPprsBg6QWwP6AK
         Ff5ptUSzpe+MPHGHEmKm0teWz8HacArW0jWAlsTFaMLbYbUM0OWECeDjLbIjnRLe1xwV
         UrFb3ACDG/M5uzo+GeDVHTqfdkA9DVTS6zkZHsmsINNFWswHD35a2+Ia8ntxsP3eE60o
         v82gZ2tElW0rLUhiItthxbPMljqgYItF3vellJrFVEQlCsxe2tl1fzDosphJ+bJJBESt
         DVapt8u2GeIGo0ZhMkIDJgE3yaSQ8F6OrJ6X4QTOpTF99iAIciMDOpf+/650WzCgt9so
         NW4g==
X-Gm-Message-State: AOAM530w3hasULeGEPCh7X+n5c9ieN33ZGZspyblZNfJ/CiYCluX5O6C
        vybMbCOnHcPY5wvZyxHIetSfdnvOCCHh15dNgDUyEqGeqt8JvNE7Ezh7WQhrKY613jg6jrqjGgc
        WTwaNnnigtiJp+TpNrnV8k3HoLJ8iMTwS4Zl5Q0f3YQ==
X-Received: by 2002:a05:6402:19a7:: with SMTP id o7mr31417027edz.22.1621245517954;
        Mon, 17 May 2021 02:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjVbKinq9KaD/Ql0BY02wWm1LkfUNxBYm6cyHlXXoI2sY6X6qpn5L7XW1kPA7eTqkRs9uxQg==
X-Received: by 2002:a05:6402:19a7:: with SMTP id o7mr31416982edz.22.1621245517486;
        Mon, 17 May 2021 02:58:37 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i8sm8803648ejj.68.2021.05.17.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] scsi: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:35 +0200
Message-Id: <20210517095835.81733-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/scsi -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/scsi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 3d114be5b662..c5612896cdb9 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -311,7 +311,7 @@ source "drivers/scsi/cxlflash/Kconfig"
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
 	depends on SGI_HAS_WD93 && SCSI
-  	help
+	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
 
-- 
2.27.0

