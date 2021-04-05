Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D2B3547EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhDEU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhDEU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:59:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:59:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n8so12851726oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=rnZ/+SCFR6smzC4OOQsVNnFSMdYRMfjOaDE11Bdi33k=;
        b=f1Y8RbPFc+agJhL3l2y37ACRHnZwWB8QD6d9sWjlu50E0ckwkK85rN181aWfrPNZKC
         rU8wy2bhuXT01eVE/8IH9u1sKtNfHATWr87gFiJVQuLPE4iaYpF2xTkky4+wTlkOxOHz
         POuYW4MRPX41JnoppCydFlM8SzadagpVXX1Z1Qc9COuYKz/l5D5kqhRcIwSHSUdO+pIZ
         5+ddBKGLiZX4qvGiA4kAdDXAw990M0bY9BWQBgyRkSiSTGI4PfAgKrzkvyXYOvUwDI7C
         o7D+tmKuNGbU4SqrudwQJK00S/uAZvAtxY5xzPpXwXNJgnGM9elmNbl33ZJgwZ1UhOUz
         AKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=rnZ/+SCFR6smzC4OOQsVNnFSMdYRMfjOaDE11Bdi33k=;
        b=QhWNzcihB9a7BpVsuzeO21oGFNcMuFRvzzc0AlWFCMKEt6CoGD811ceuydHOpEkSqQ
         LDISHEfGqy//e9hbQV5widvCo1AFeDBwLIUbMtPBUQxJFQnxCiY+Fo5M4/RW9eXaCJkp
         hrLKj7MKilLf+wjWztZC2dpWVvZAYXR6s28FlxmboFKNsNRCHt0Cu/noc7DnJfCp8CvC
         f5CUwvpo2JUQk58S+jFlZYuHqD9nXdqISoy90UzCXhN7VP+vQyxkjoSmPCEDbd9Ou5sv
         moyudoohAT60U0oFRzWfUKrKa14X9Do2wXPvLhAwybxfcF3zuAyzcKgqUZrozkXWHCUJ
         bagw==
X-Gm-Message-State: AOAM532bVnldp2IA89TWeT/STuMEM5xgyguNQFwve7z6jPALnMj1URHS
        PhnmQJWVX3rW7W8AfDbR9JJyR3KJdmHOJA==
X-Google-Smtp-Source: ABdhPJw8XqvnE9iO/gZdxZ9J2iI8wd1L9o2jLq4BGDzHyU05O4EyAdGiO7cJBiVHE1tbtx7sE9Y8mg==
X-Received: by 2002:aca:af43:: with SMTP id y64mr763978oie.46.1617656348908;
        Mon, 05 Apr 2021 13:59:08 -0700 (PDT)
Received: from fedora ([2806:2f0:7000:86b1:c1bc:6875:f962:d652])
        by smtp.gmail.com with ESMTPSA id l26sm4225235otd.21.2021.04.05.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:59:08 -0700 (PDT)
Date:   Mon, 5 Apr 2021 15:59:06 -0500
From:   David Villasana =?iso-8859-1?Q?Jim=E9nez?= 
        <davidvillasana14@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: kpc2000: pcie.h: Remove extra blank line
Message-ID: <YGt6GhZHqB62Y038@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found by checkpatch.pl

Signed-off-by: David Villasana Jiménez <davidvillasana14@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/pcie.h b/drivers/staging/kpc2000/kpc2000/pcie.h
index cb815c30faa4..f1fc91b4c704 100644
--- a/drivers/staging/kpc2000/kpc2000/pcie.h
+++ b/drivers/staging/kpc2000/kpc2000/pcie.h
@@ -6,7 +6,6 @@
 #include "../kpc.h"
 #include "dma_common_defs.h"
 
-
 /*      System Register Map (BAR 1, Start Addr 0)
  *
  *  BAR Size:
-- 
2.30.2

