Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B274241B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhJFPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhJFPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:48:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90140C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:46:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so10160639wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGegrEJzYp+DaIApOozyrKxduLq4/GVLP985+gb2bIw=;
        b=pO2Q8nafmltLEmupWA5c6YTYg0akQgeHVmeuLBonH8fqyNrXiNZL/yKxq6lUH8nfBL
         De8QBrVBVAwqDO+RmntuQR6GR8fyOMx730Oc7UbbTAX/9JlMYYKOs7MVvgwtC7+LlYLG
         uapj8dgGrstBb8k4ACHXy3CIuHUscSoSnx+tZGIx7+xwzgY7gpHTs7nkmQNSbwe0+g58
         RTpJw5xUf8Fn94j8NDcY4eu+aloHM4nR7b8kYpW0whjRYAcF7oEAlf6FkOb8WyQGJwWS
         BpzwSNRrB8LbG0+bCEpRrFcnNaCKJEasnuTZig71WDmwRWEBW1wngIJuuGuaoz01iPVk
         ABYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGegrEJzYp+DaIApOozyrKxduLq4/GVLP985+gb2bIw=;
        b=l+bX/uaeLpRgPEZ4v0KUSl0ZNM5p3vl3NEreFi7kv7kWjQurDH3YlFNsqWnsr2+0oF
         9HFqI4Ssnb7KhRP2o9ovLqS1P5quWfVe/BrxWHVZ909jr2q/r+5RYQ8M7PNb+7xtwRAM
         dIr8WmJWZcTSWOg0VNG85cPxFcKOSx2nOWdSepI2VNpdXxlVcKmupzWTNnRKBAfp//zs
         p0Ll4Jb9VyA/Mo3GgJZo6pBGOIrjPx7ZZXckitiI4PDjzcxBMK+KjLCLGXtjJoYX4VSj
         KrYZOVwc6CEt5kJe+3SIUI1ofLmzQ8ZuhW3gs/PERK2IbK8qjT7z/M2C1sG9ocdSUj+t
         Vqqw==
X-Gm-Message-State: AOAM532M5EeQ6dk07Vi5kZSb/G9ckyXcF0qeqKBq1QzkQsncuayVgihm
        GDfiNME4y0t0WKf1V1etMvw=
X-Google-Smtp-Source: ABdhPJxKaAVl6GMqZ4mjSZTwXLq+KlYi6YHvI3uWIrqnLkGeo17HjfQFxg/qs7w1DvQdSSjHgFId+A==
X-Received: by 2002:a05:600c:3ba5:: with SMTP id n37mr10454818wms.46.1633535182109;
        Wed, 06 Oct 2021 08:46:22 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id o15sm5498825wmc.21.2021.10.06.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:46:21 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in rtrs/rnbd
Date:   Wed,  6 Oct 2021 17:46:17 +0200
Message-Id: <20211006154619.134812-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated words:
- "as as the"
- "the the name"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-rnbd-client | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 0b5997ab3365..e6cdc851952c 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -128,6 +128,6 @@ Description:	For each device mapped on the client a new symbolic link is created
 		The <device_id> of each device is created as follows:

 		- If the 'device_path' provided during mapping contains slashes ("/"),
-		  they are replaced by exclamation mark ("!") and used as as the
+		  they are replaced by exclamation mark ("!") and used as the
 		  <device_id>. Otherwise, the <device_id> will be the same as the
 		  "device_path" provided.
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.

 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.

 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
--
2.25.1

