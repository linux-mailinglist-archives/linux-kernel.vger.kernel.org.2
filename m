Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DD40B6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhINSZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhINSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631643838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tQ+w8rAWfrqtUReBf3svsx7cUQH+Y32dBT7DCvHOI6A=;
        b=D81u/hWMgEW++u+n9QKgX0pjWYEW/de23b2eq96OZB+LT5f3tZAbDZcT2tBGPMjsGkTSJg
        NLofKksaWaIIbzQB4WSDiaHV83wlNH9GTiDlvQJb78bzArEVme0jKFAaOzmXyOJQ8NWXs9
        Dh14Kqrc1nVqIObTqZ1vgBb92RRLuKU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-g8ifbCeaPruKoV8wy1epvQ-1; Tue, 14 Sep 2021 14:23:57 -0400
X-MC-Unique: g8ifbCeaPruKoV8wy1epvQ-1
Received: by mail-qv1-f71.google.com with SMTP id r18-20020a056214069200b0037a291a6081so476610qvz.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQ+w8rAWfrqtUReBf3svsx7cUQH+Y32dBT7DCvHOI6A=;
        b=3jHgN26RGhkQLp0qjcK8AZRoc3P1be4XEyLnmtbmhV1mphxo/MjMeuxiA8ER+E5SZK
         hAPBqkhvhTKG6/nmXt50/8Ban0HdSzWLDXSVgFb7/PqAuWFivG2r1pUiz65LZSh7+Vpy
         Y9D0l7NXfAYFazcaZ90yy77IptvTL0UIlRx2dqnwHJFmPjB3sDHybkVPOYQCUlMxaTGO
         Y2LOhaheM8hyLip0BhC0ZDy08rW/2jvLS2vdrzPHb4Kpsb5or6TR9838PDU/oQQ3GtXb
         yqT5uyfK5gS2O3QWGo7sje/ff1RkeGbG+3exW1imzwuUNDDFdeiF1FYACMRiXtsx4hVh
         TO4g==
X-Gm-Message-State: AOAM533K5T/+K4+4xow3YNtCiATGs4YCvCmuT9uckcbLQ/DAiiBrfzaZ
        +QgHXvJMg+AfD+0UV2rJP7NYUH57ZBFhX6nIdcwULFjy2gpzPKtQy3yqKI5k993Z7ObqPiFQZJl
        L7TSK+W3pSj/5mJ2jpDOkZCcF
X-Received: by 2002:a37:6354:: with SMTP id x81mr6469693qkb.330.1631643836319;
        Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkRJTWnJTvpzK6RAFdSwPBJywRxNugcI5zXXYwbUK0aD5GUgQLaVKIxwDkQgC2wMrhXMD0bw==
X-Received: by 2002:a37:6354:: with SMTP id x81mr6469680qkb.330.1631643836128;
        Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r23sm6546468qtp.60.2021.09.14.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:23:55 -0700 (PDT)
From:   trix@redhat.com
To:     mfd@kernel.org, hao.wu@intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Date:   Tue, 14 Sep 2021 11:23:33 -0700
Message-Id: <20210914182333.3903389-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

I am the maintainer of the fpga/ subsystem for both the kernel and
userspace for Red Hat.  I have been an active reviewer and contributor
on for public fpga/ subsystem for the last year.  I would like to
help out more.

Since I am paid to do this work, change the status to Supported.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa4edf100b83..0443d7ab826659 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
-R:	Tom Rix <trix@redhat.com>
+M:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
-S:	Maintained
+S:	Supported
 W:	http://www.rocketboards.org
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
-- 
2.26.3

