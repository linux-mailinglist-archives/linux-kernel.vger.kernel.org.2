Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BB4241D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhJFPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJFPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:52:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B61C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:50:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j8so10206314wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCqWG1MwEY4yYdxCME2ROilZdOUtSzSai+WEWHRm8RA=;
        b=iyOXjM9wDFuHQIxXuNqOlfREgSV+GdfhpvqkcFFQNasGiu3rb2rsiI6pZ40Pww/7XK
         wgB9Nwpw6buIM/WrCAKMYBFWcxsGK8UyuFl/PMvnDjdCa39XntP6WmGODP82KXGJK9AI
         ljp6sffETP1wamXxobYs6U+227xf2fbEFCj5Ez4kkbBboUpgiZ0aEb6qoORmJyYJ5/p3
         vpD1YidCEEG0cS55gvZ3caIfCaOhiv3lpNzJBADnzYh+UT+xarud8xxmAnU3XbGtRTAm
         8Ar1Aro75dVvvuGkxqZxq+taMIb2USsI5kaHRhAiijCkTxsCDXkf8wblKgKyjKFqxfug
         SEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCqWG1MwEY4yYdxCME2ROilZdOUtSzSai+WEWHRm8RA=;
        b=OPZiFyEonDvT4j+QB/kCeXehxCCPdYkGWcgr9TNKGZwMyL4wZBNelyR/NU8nq8siCJ
         mx6Xe+FTehOc0B9RCG/SX7uO7qOu2LZP9Vb9yBHoojcPhX5BqANSiL0C2AXG2ugyTxv3
         5QEEqtpQ//L3PNpGhtmAT4b8mKoljj1b3Q3Naqr5C04HHIR7xKlR9W4inxQOAK5VcZ8D
         rihQh1PfxTsmzPpZ+1ZxlNecwtJi0xJNTzNwWxuOEuuqJikvGR+36F+t1CvC9kP31yJX
         o9Il85OpLMCvj7LyJQujMnUqPT3nXH69IC9ndVwdZLrDSvgCU1x10q+05TURfRa/HiJR
         Mizg==
X-Gm-Message-State: AOAM531jQxm8PTBzAWoV9svC1qpkiP+e3LURRHmqcs1FRHb8/68CTvQC
        /NoGUmmJ1j0eDmf8ots+R7eqkEyLt1AIZQ==
X-Google-Smtp-Source: ABdhPJzaKAqSTjDB3cmj0NV4WVtEgdbmLFCvNqTtMjsXHjNRIICaxYehx8hx0gelq+H9vx1C4gMt7g==
X-Received: by 2002:a5d:4601:: with SMTP id t1mr29024727wrq.298.1633535420022;
        Wed, 06 Oct 2021 08:50:20 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id q16sm4355868wrw.23.2021.10.06.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:50:19 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in testing/sysfs-class-cxl
Date:   Wed,  6 Oct 2021 17:50:17 +0200
Message-Id: <20211006155017.135592-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated words: "the the lowest" and "this this kernel"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 3c77677e0ca7..594fda254130 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -103,8 +103,8 @@ What:           /sys/class/cxl/<afu>/api_version_compatible
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
-                Decimal value of the the lowest version of the userspace API
-                this this kernel supports.
+                Decimal value of the lowest version of the userspace API
+                this kernel supports.
 Users:		https://github.com/ibm-capi/libcxl


--
2.25.1

