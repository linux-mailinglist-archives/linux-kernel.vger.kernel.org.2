Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA83DEF60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhHCNxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhHCNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:52:56 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B025C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:45 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so1215515oop.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sh8EwqvxOWxGZOdC5fvUNGCU6dCl0p7mGnkUn/YxZeY=;
        b=m/r5s/szqxw6SCRYaWDag5t2X660bcrNqMj33l6sKfFgdTAuJAv4tsuTibQySpkjAg
         Ps4XjSqBh5Bn7YYouKheVs0Qsy+bbdoDQUE95xmDdCqliMDtrBKBe+9UdzUYvybGq2Ah
         1hzBxTktcuOfRR3Psi01QRSJ7C06w5gB0SbE3kGhoOe8DXh3IXIxxPW94ECf/BFLpa4M
         jExN6LP9GVus2vQt/v5crQiB4Dv6O3V9f/lwd7TcgwNqhcSo0dTDnYZriQQtGfFZiDxY
         SZzcwMAHTIoJsYp4+iCLqcK+2sVNBSzbLeQUfpvyQpC0nEqGOC7T4MGF0SqxOTiKgCTM
         H+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Sh8EwqvxOWxGZOdC5fvUNGCU6dCl0p7mGnkUn/YxZeY=;
        b=MkX8J64QlNudP6NyKmpl0kuec00YBsZ29wBe9N+oIoXSfH6nnnSAVcCV7tyWCYkbhS
         ka/Ef8zbA4LarlAuR29JpqENcnCHlrMuHpThCzwQ2SFh7ViUP7tEvr6lEMVqVdm12w0X
         y38gxAx5Jx9Zkq3OzwJajMcoSqIkH7NXVAIToMcqaA0I9CdYN4iQDmMAYzmyXbrmzMij
         hiOukpUcJZ+CzYnq5JraiZUiZdJCW2N1m562jGM2CoQ0CFq4whrPp8XjfZiNahZ0ZogV
         pL2DKM10AV72Z/KA4PLE9zLcB7rRa2t6rWxW5gz1nHYl0cU5YEXry5i9Dup13VxnCYK+
         icag==
X-Gm-Message-State: AOAM531UCSW+ZWFor3952RzzZlLJQPeXcarxSp7jYq2w9rr4nYJDjt4a
        OWfv7K3RNzjsmkRSyrbUT7g=
X-Google-Smtp-Source: ABdhPJweL2r8HxEVsOB0GM/YDpH4Xj/FIXBDwfNHdvYfzIwpMrl3zmx7WurcnUfcmDjXlKVt+ad+FQ==
X-Received: by 2002:a4a:d2c9:: with SMTP id j9mr14453772oos.88.1627998764630;
        Tue, 03 Aug 2021 06:52:44 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:44 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 07/10] staging: r8188eu: Remove rtw_division64()
Date:   Tue,  3 Aug 2021 08:52:20 -0500
Message-Id: <20210803135223.12543-8-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wrapper is never used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index c92284811827..6203e3c219ca 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -345,7 +345,6 @@ void rtw_free_netdev(struct net_device *netdev);
 #define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)),(sig), 1)
 
 u64 rtw_modular64(u64 x, u64 y);
-u64 rtw_division64(u64 x, u64 y);
 
 /* Macros for handling unaligned memory accesses */
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index e6904d2e0358..c05b7589e9b4 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -288,12 +288,6 @@ u64 rtw_modular64(u64 x, u64 y)
 	return do_div(x, y);
 }
 
-u64 rtw_division64(u64 x, u64 y)
-{
-	do_div(x, y);
-	return x;
-}
-
 void rtw_buf_free(u8 **buf, u32 *buf_len)
 {
 	*buf_len = 0;
-- 
2.32.0

