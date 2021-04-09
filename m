Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE8359B83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhDIKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhDIKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3585AC0613AC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so7714354ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkNYgYU1YHKm0Z1UO5d8nPKM2/cFIDGkUiKsAmSRBPY=;
        b=TV0jDUjCAXJbookaohbCurQF9VNP01/WzG8EccM2hVtczfDwv6/ukoDBMFsWx0KryF
         ajApL7I2yEzMYEQQ2I5w2T41cDRKbMqY/fBUknMJc5uEmm8kdAFrtKUcaTwdqRCQfXAM
         6SppRFElfkfPRi7JcyDU4WIN0gy1XU8N7WtlPFbXgNhI46I/PvYYZsNNOy9IyWlvHKcT
         ko+amq1hpPpjsvVcfH5dqF1EH8xx7+uQD+jovIbXLeBGrjMgcNj+Z5dKPPImzWk/RbQo
         8qxvC4gQ27CEgmmsumxrTo3iyJWIws1yQU/uuHSgDq1Q92qlqe5tAM7lbdXe+X22Cz+x
         mvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkNYgYU1YHKm0Z1UO5d8nPKM2/cFIDGkUiKsAmSRBPY=;
        b=twA1ZOiD55aZVHsxQafJuZEeZor9k0qUn6r8iqK/UJl8lMCcc3Pmnnb/sRRiwPiQQV
         xLprZcLeKqL335CEafQx9eJNojbfA1S5BbaXzxOjjE9IgQBlm1kiIAKx9N6e3Oe7DNT1
         KAXfI1L5mkL4tT390krNhuh6VFoufM+b1MRk2LkXxpkZhd1umv0SRvU1M0/w3hiU81Po
         9zHqvstCGbuuT6wtJfc5gln2u9xAdSUDLQnYRohGPcj1ptDD6qfo4rBqW+dgTHBIJdTm
         McnGERJZvC0ZcxPU6jAbga4PaxG7wVeUHEHKLk46RLk01arS1irfZ2yKZ/PFvwv436vz
         vvAw==
X-Gm-Message-State: AOAM530iq2bkKzM+hrgs1w4CmdJiTHIqvw/3D+UBj+tu/kzml7V3myjl
        sNgJWPDzopT2aFdJZnQpZ4dvGdCetfM=
X-Google-Smtp-Source: ABdhPJy0z2z0G+TjWtsbFGQ5lvpYowidNQ14fpUwQaDnwsB3KcMV/lyXUfmcHNHNtkAzUOT3HFwilg==
X-Received: by 2002:a17:906:2e8f:: with SMTP id o15mr14995995eji.171.1617962514008;
        Fri, 09 Apr 2021 03:01:54 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id g11sm1136531edw.37.2021.04.09.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 04/11] staging: rtl8723bs: remove unused variables and code block left unused in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:32 +0200
Message-Id: <0e950e74565b573a98b851092cc2078045d5ac3d.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following kernel test robot warnings:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:
In function ‘rtw_dbg_port’:
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2548:33:
warning: variable ‘preorder_ctrl’ set but
	not used [-Wunused-but-set-variable]
       struct recv_reorder_ctrl *preorder_ctrl;
                                 ^~~~~~~~~~~~~

remove also unnecessary conditional code block.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 9735522f9cc8..d70e2d5d51e7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2543,14 +2543,6 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x05:
 					psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
-					if (psta) {
-						int i;
-						struct recv_reorder_ctrl *preorder_ctrl;
-
-						for (i = 0; i < 16; i++)
-							preorder_ctrl = &psta->recvreorder_ctrl[i];
-
-					}
 					break;
 				case 0x06:
 					{
-- 
2.20.1

