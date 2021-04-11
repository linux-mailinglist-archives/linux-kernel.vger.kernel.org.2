Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44E335B6CD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhDKTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbhDKTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 15:46:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b26so2640704pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ok7lysEHXRexS0y6XA+d9qp+BmlU7q6Xo4kMGxuikak=;
        b=lBJKRMJsZ6pfpN5zQnZutcwGBALnLihAJTTbHsEPrQa+VKOY5tO/XXmcFQXC4o2mSc
         ts0Z5jN3QK6VCje8DAc9B26ELAlZAgYyj6Fd+QQiS2yM/gYfDrjJpje84C80MtCanTPl
         8jtB7K+sW1UbPXgpmVik2h7134jhlsIuesIcosQ5rq9GK93+BjPGHpDyaCA3ON7/qOSr
         j9xg6rCsoiXcuLtqmr751dcNY6o/efoJzELbHTa5wD8hC+MBl9BAz+Sl0942+8cl1lSG
         nBZu0XcUAlaN+6ZjvBhNzPUphnMzceDIlp2QG60A/zdPNK9lcUycDVl3BbPHQE58Cbma
         8inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ok7lysEHXRexS0y6XA+d9qp+BmlU7q6Xo4kMGxuikak=;
        b=IuzxHFiLvLNxHnxcYQwNjk3iCa8Yj+cpTkTDag5GAXlVrcDov3cugpSJZDi+CjG+ni
         9+EYSY/0sor3J50N5BSl4sMIsHyAhiet/SnvKDcUO85xZOyCBqRXHMqQLURY+8amZ7Hn
         yzOPROJNGMtbK/9E+4E/aPlkDYaiOOqaPVXxZF2aXabZYzX4+9ZNGzoWq1CIRXFwXSHV
         kI3ALCaMEYsQKuLgOiP7KopOrt6TXknG2rTFutn/yWbsht+4AMqBXWWHJLogJ8A0FIAK
         TEQ+GAZkGPwqPktpDFRZVSJXPuAqXjYECvoOfDDGLg89rlnCU4iyRS6/OhHC7rRR/25C
         /Z+Q==
X-Gm-Message-State: AOAM532beGQbDbsNCdeyE/A9on68gR5w2r22tHfi6b0qA+sn3TFGoJQr
        jKXP1aLWCc+emFpu3MTalH4=
X-Google-Smtp-Source: ABdhPJweiyFwOG7gqAVbeHFG5P16keb51c476iu3giGqmmPae+i1xEIJtGEV8zf0DjMeuNn8SJLUig==
X-Received: by 2002:a63:338e:: with SMTP id z136mr23349875pgz.115.1618170376210;
        Sun, 11 Apr 2021 12:46:16 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id 22sm8563328pjl.31.2021.04.11.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:46:15 -0700 (PDT)
Date:   Mon, 12 Apr 2021 01:16:08 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 1/2] staging: vc04_services: remove trailing whitespace
Message-ID: <5a54a06bae846f1f037165c0c7ba7ffe5a55a4a8.1618169920.git.mitaliborkar810@gmail.com>
References: <cover.1618169920.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618169920.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed trailing whitespace to adhere to linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/vc04_services/interface/TODO | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 0bcb8f158afc..adb28f46ba67 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -27,8 +27,8 @@ unused.
 3) Make driver more portable
 
 Building this driver with arm/multi_v7_defconfig or arm64/defconfig
-leads to data corruption during the following command: 
-  
+leads to data corruption during the following command:
+
   vchiq_test -f 1
 
 This should be fixed.
-- 
2.30.2

