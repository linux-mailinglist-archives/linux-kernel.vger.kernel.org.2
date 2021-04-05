Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9B353A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDEAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhDEACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 20:02:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F88C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 17:02:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so5206794pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:mime-version:content-disposition;
        bh=wCxcfmyN+uyu2EuDS2MM3DeNALMCF932/5FQyU6Gi3E=;
        b=pW1LFy3z+aGibN9XcvUaCpLdBNrk7Z5AQjCvKHmlFvMBayizkOw/+QGI86OSrHVQvf
         IoQXZjXmHiSrHdPUChgBU7FZ2melVICdLW5bLgkANGlvnqRGbs4RzgPoHH16ZQaM63Il
         FsD4QOV2q4PZzWzyikp4DYe/jzyJ0JsktZPyPspmr7tE1RmrU1I3FCmeW5eQbHPjK0Lg
         zcNi4MLXxOZe4f2UazQQLSTyyteKnJPhdwlNFRYDxzoBYo08Cz5M4eHBmz1430jZbOWy
         LzIaBQiHvXrbQ25LmePYrN8vUJDC3wuMXorRqhm0n1z96IGO2TT0XkBjbTppSMKqAuKn
         nF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition;
        bh=wCxcfmyN+uyu2EuDS2MM3DeNALMCF932/5FQyU6Gi3E=;
        b=qxTbp97POv+uK5mOZ+Rb6GPg5Tx+auQ8kRs+Cpc2PZwx70sAf2bDv0t3ap6tOqAFrs
         Aml+2tZ0G0ng9EuFM3h13NLpq27zCdFLfRHk25YmBxQHhJRA5OYRy25rVTJc8Zqzvrm5
         BdYBgsQBNCwTFW6do9gInV3H0Ij0VG0+xERe9EmYrFay9D66+vH6ZKXSgponGx94i3lc
         Za+4PGLAMIiwk8KIHI8U55udOkN7BYugXQgn1PK31qy+CoipdgBS3L8XXTgyBRZGOa9U
         DnYXtrrMeD/Z+yddF963+T656I+wW9MRNLfNEgVfiLk99bx+8TgpAD7W4Zrudzz2q1C+
         THjg==
X-Gm-Message-State: AOAM532a6dAzVQpOdbaYJk9DGIgBWYMdk01Ge3egHBqAbCpPGKu1IB30
        HcRM+ReH9xYeepoSI5f2+WDQF6nBbF0XYQ==
X-Google-Smtp-Source: ABdhPJxpPazXdKfvMEld3hWN/kGBTCn2ZuS94vfE3AVfI/3g+TS9JM/zSr1c9/sCgTSxL04DPYy1lg==
X-Received: by 2002:a17:902:7612:b029:e5:f0dd:8667 with SMTP id k18-20020a1709027612b02900e5f0dd8667mr21654982pll.59.1617580936970;
        Sun, 04 Apr 2021 17:02:16 -0700 (PDT)
Received: from kali ([2409:4042:4d84:a21:5e54:ca6d:ddda:81d3])
        by smtp.gmail.com with ESMTPSA id 195sm13571179pge.7.2021.04.04.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 17:02:16 -0700 (PDT)
Date:   Mon, 5 Apr 2021 05:31:17 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     manish@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <YGpTTbWENcr1EejC@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

outreachy-kernel@googlegroups.com, mitaliborkar810@gmail.com 
Bcc: 
Subject: [PATCH] staging: qlge:remove else after break
Reply-To: 

Fixed Warning:- else is not needed after break
break terminates the loop if encountered. else is unnecessary and
increases indenatation

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/qlge/qlge_mpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 2630ebf50341..3a49f187203b 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -935,13 +935,11 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
 			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
 			status = 0;
 			break;
-		} else {
-			netif_err(qdev, drv, qdev->ndev,
+		}	netif_err(qdev, drv, qdev->ndev,
 				  "IDC: Invalid State 0x%.04x.\n",
 				  mbcp->mbox_out[0]);
 			status = -EIO;
 			break;
-		}
 	}
 
 	return status;
-- 
2.30.2

