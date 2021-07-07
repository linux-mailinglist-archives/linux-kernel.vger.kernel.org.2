Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F93BE8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhGGNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:41:31 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37469 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGGNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:41:30 -0400
Received: by mail-lf1-f42.google.com with SMTP id v14so4143561lfb.4;
        Wed, 07 Jul 2021 06:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4S8I98bLxqg+GjeaFpLigB/Lq2+9QYYwA040PUj2usI=;
        b=pAjSKBNghfdkVSLh+8+U1FRI7jfBWm1j45wJH4JnAo1uSsnap03SCEKvBueL7SUhy+
         vLwngEIyMKKJwIrViCbsRGikLt5roBvVfTaFSSQ7Exq29moVaM9cGk+rXu1uk57b9BGn
         mt9bb8vnuEg2up797fPfjuWvDHtaL9MTsCDuI5nDs18MQuDr8GKArCoNSa6k5ST/u1ei
         tAkQy1PHrE4XhbIWUJf/j69cCEp0ujNrJ+rdmBCBLL+t7jgUffiCsWIXGPpCFHPeSdaH
         rVU0qQT4GlsX/F9eocqySWLO1ft6fstiCKMnoNbDdr2THpklxTiFFVYc0z0NwM2NOzY7
         xeqQ==
X-Gm-Message-State: AOAM532CMFSGDGs0tuffx4F2ZCKSHigw83LBLmtZs68HO86XOGQtgi/v
        fKhO8QgB+nyya2R/lIou3w3z/KCN9/TYX3fC
X-Google-Smtp-Source: ABdhPJzkT2a/Pzlfo5yI7/TUymanDqvjKQwU4jEfInzewFg1beVgLuJwPtdHpDdsUHufnFbx5rY/xA==
X-Received: by 2002:a19:4959:: with SMTP id l25mr18563931lfj.225.1625665128274;
        Wed, 07 Jul 2021 06:38:48 -0700 (PDT)
Received: from localhost (88-112-11-80.elisa-laajakaista.fi. [88.112.11.80])
        by smtp.gmail.com with ESMTPSA id w17sm1704114lft.285.2021.07.07.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:38:47 -0700 (PDT)
From:   Hannu Hartikainen <hannu@hrtk.in>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Hannu Hartikainen <hannu@hrtk.in>
Subject: [PATCH] docs: submitting-patches: clarify the role of LKML
Date:   Wed,  7 Jul 2021 16:36:35 +0300
Message-Id: <20210707133634.286840-1-hannu@hrtk.in>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation previously stated that LKML should be used as *last
resort*. However, scripts/get_maintainer.pl always suggests it and in a
discussion about changing that[0] it turned out that LKML should in fact
receive all patches.

Update documentation to make it clear that all patches should be sent to
LKML by default, in addition to any subsystem-specific lists.

[0]: https://lore.kernel.org/lkml/19a701a8d5837088aa7d8ba594c228c0e040e747.camel@perches.com/

Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
---
 Documentation/process/submitting-patches.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 0852bcf73630..8ad6b93f91e6 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -216,11 +216,11 @@ cannot find a maintainer for the subsystem you are working on, Andrew
 Morton (akpm@linux-foundation.org) serves as a maintainer of last resort.
 
 You should also normally choose at least one mailing list to receive a copy
-of your patch set.  linux-kernel@vger.kernel.org functions as a list of
-last resort, but the volume on that list has caused a number of developers
-to tune it out.  Look in the MAINTAINERS file for a subsystem-specific
-list; your patch will probably get more attention there.  Please do not
-spam unrelated lists, though.
+of your patch set.  linux-kernel@vger.kernel.org should be used by default
+for all patches, but the volume on that list has caused a number of
+developers to tune it out.  Look in the MAINTAINERS file for a
+subsystem-specific list; your patch will probably get more attention there.
+Please do not spam unrelated lists, though.
 
 Many kernel-related lists are hosted on vger.kernel.org; you can find a
 list of them at http://vger.kernel.org/vger-lists.html.  There are
-- 
2.32.0

