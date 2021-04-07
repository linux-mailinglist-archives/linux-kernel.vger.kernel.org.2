Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3294356042
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhDGAY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:24:58 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33522 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbhDGAY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:24:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4FFQBl6hJsz9vCC1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wD7cK2PYysIM for <linux-kernel@vger.kernel.org>;
        Tue,  6 Apr 2021 19:24:47 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4FFQBl51Btz9vCBq
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:24:47 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4FFQBl51Btz9vCBq
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4FFQBl51Btz9vCBq
Received: by mail-io1-f72.google.com with SMTP id a1so14094862iow.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCJcxMq9XZ++9qNavNyMD/aAoy0l305S7aiP1i3rmqg=;
        b=mb2tJAXU29fdFTkxo7nqslpfvc0HvmFoXGjkGRtJnPe1+AIgtWfzE9payVst0jmkgX
         O+0zJKAN0XUgyUbXSGZMX782GZNrXRenDyhV172TH0C1tX5oiytfgwnx7AaDxzgg0SSr
         Ice1JG1vM0e6U46szVk6XUt8fPdETgeCCF8DjT21SccvBO7ADxrGhDu4ND+EWAz30k0o
         r8G6kh5cMHVgAac+6/kLxSO+gLSvNoivr6/YaIZ+qNyfPawFuCv1rOPnSwTZlY3PWYUn
         z5LGV+ukBHuQ3U4t4pLbKJj+qczPPnW7zE8xJOtbCV91NxVjJvxQb4RxGReDAMfiHpGp
         H5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCJcxMq9XZ++9qNavNyMD/aAoy0l305S7aiP1i3rmqg=;
        b=FPP9R4fDE/9Ea81T8fRVlfnK2Tj5LGzhheq4DjyHBjKWIrNJOvkBFoTWI9ctWoUQnG
         qXHFDqpBRcIyAKrKlZSD1UWA5T/8W3Qafesm/BS/XikwksW+6uFTrMOG5jfXULkcgS2M
         OkFTR/wnaxS6gEvk1ViEePpSV7s/0Xyxq5Dns7ENnAeEZePoWF3JZNYyyp3/hKgChtuD
         spa18me/wMEcJz/6cbY2JIUR9B9ZZMO0xEr4TqUQVlwMbqp1nqyFh3vV6h6be6yfEDcB
         0szKZdPYfqGJG7AxkCPhKNkqheJI96RgM8JTWVNWtxFnJ8ftnv7TR1OludhCjMZbkINp
         JIAw==
X-Gm-Message-State: AOAM530oWZyLtW1p0WW0QF0dcUP8ZOygDrzYMCvejyfRDFA8BOSQUT7x
        eyPXvPwmWouF55oVa2pv2ugThwm6m8/TnX99IRb8lWRvaKH1jArpvVNpzq+jVF3kiTV4yyA1obR
        vjct7HpzC3skEiaadfhnfoOxN0A9c
X-Received: by 2002:a05:6e02:15c7:: with SMTP id q7mr693318ilu.228.1617755087378;
        Tue, 06 Apr 2021 17:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGRsolhynPcwdmdikCWxWk9mcbSGu+Qg83CUnO520JGA9T6/ph1a5RkcqsyebjW9+7sR0qcw==
X-Received: by 2002:a05:6e02:15c7:: with SMTP id q7mr693303ilu.228.1617755087216;
        Tue, 06 Apr 2021 17:24:47 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id r7sm9530767ilj.72.2021.04.06.17.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 17:24:46 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: be2iscsi: Reset the address passed in beiscsi_iface_create_default
Date:   Tue,  6 Apr 2021 19:24:45 -0500
Message-Id: <20210407002445.2209330-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if_info is a local variable that is passed to beiscsi_if_get_info. In
case of failure, the variable is free'd but not reset to NULL. The patch
avoids security issue by passing NULL to if_info.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/be2iscsi/be_iscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index a13c203ef7a9..1ff9d2a2a876 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -274,11 +274,13 @@ void beiscsi_iface_create_default(struct beiscsi_hba *phba)
 	if (!beiscsi_if_get_info(phba, BEISCSI_IP_TYPE_V4, &if_info)) {
 		beiscsi_iface_create_ipv4(phba);
 		kfree(if_info);
+		if_info = NULL;
 	}
 
 	if (!beiscsi_if_get_info(phba, BEISCSI_IP_TYPE_V6, &if_info)) {
 		beiscsi_iface_create_ipv6(phba);
 		kfree(if_info);
+		if_info = NULL;
 	}
 }
 
-- 
2.25.1

