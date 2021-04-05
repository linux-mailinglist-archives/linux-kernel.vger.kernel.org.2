Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65E353A64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 02:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhDEAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhDEAnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 20:43:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3934C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 17:42:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ha17so5236377pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 17:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IroJdoAcq5zAI1honZ3ThwMkWQDS5Bqq0q4OifWOrBY=;
        b=i3C6WhOMU0EGF4ZLXdWYwphURgSehOFih2BYREbGOAokXJ7mN1DWHHZcFPF3r3lAZU
         zekilOVO0OAJ/QLe/J1Q/dLt0NqTBP8TxHNnDvo4ECHR9o1QCvRwkFwt/DGH6taUAchR
         ModzHy0esq9zd2fKxkn/lD7HhWA6zfnk/xgt+Y9piYPpkJkA5fQcj4Utz+gM1MztnT0v
         uiqfpOaJoReWJ91Q+7RJWbhs/3vyObiVvGEccB8zkM54rtOCS3a3Z1hUEQyNIGHQuzqm
         h2FPvaLt5rJl47YRSqAcO724h10Ns+UA0p8hb8vDhft8U8DcuX60ZICALDosO6Wsn2EI
         W21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IroJdoAcq5zAI1honZ3ThwMkWQDS5Bqq0q4OifWOrBY=;
        b=FtVjzKWqJ1dMD/q68la04/86/DvJmNBY5sf0zi64vi8hqio6OiDx3V34nK9xyXW9KE
         F+2+OcQPjwb1ZP+IrvKseIMmFlf6ONJe+Rk9amRKVsswbi/DHN2sIGfiPQdewroGxn/I
         zG3JKFyBn8iwm9o/4745FZdo3Kdj23AyCelkmJK9V1u4uLAklCaqyadPVspPXZMi/rl2
         qI3ow/AZkTYZsggo7gYbrBIoN11diZ90/dxwvmsjlr3thpHdZErn8qXM8Mw+s/S14wGk
         mdGXUGKYNKeuyumNr9my2BCriehnZY6o2HiUNxxaG+F0azbqMISXN+sqofjcMLuu4QhC
         KYjA==
X-Gm-Message-State: AOAM530PExgWI4BzKImLC16RAQfdD1lb/L+1WVBfLk3c4jPiPwP82FID
        z7mydDBJ019ugqtTf0Dj9lw=
X-Google-Smtp-Source: ABdhPJwNpsGO0DHC2BtRNKlK9V+ctRoirx70WYVOQGZUY22wzasZXkjbc84kRaSHg7nHtSBl2Oyyvw==
X-Received: by 2002:a17:902:ec06:b029:e8:e57f:680 with SMTP id l6-20020a170902ec06b02900e8e57f0680mr6438673pld.8.1617583362893;
        Sun, 04 Apr 2021 17:42:42 -0700 (PDT)
Received: from kali ([2409:4042:4d84:a21:5e54:ca6d:ddda:81d3])
        by smtp.gmail.com with ESMTPSA id q19sm13364813pgv.38.2021.04.04.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 17:42:42 -0700 (PDT)
Date:   Mon, 5 Apr 2021 06:11:43 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     manish@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, mitaliborkar810@gmail.com
Subject: [PATCH] staging: qlge: remove else after break
Message-ID: <YGpcx9MZuZJFy0Z/@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-staging@lists,linux-kernel@vger.kernel.org
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

