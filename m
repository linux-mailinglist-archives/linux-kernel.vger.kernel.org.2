Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9203FFF34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbhICLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349210AbhICLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:30:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A09C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 04:29:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s29so4080912pfw.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=HRRm11PW2tSjb//jpKWX3u2mNCNcOlRKCzRXhk/TlquHduSiDOTEZIvKN2acn66rgA
         fhYTJ4p8w1oVeB3VnV8hQTWLt5LAawMBC29eQsqEnt3MjhJdc1o/ZShH1j0BB9ZxgNrA
         r2GK9VN2h3lbKMsDEbPL3v2DzRGhjfFOWlnHdgJnkrotKV4jxZlsQOOIY7+n6E8/gyUW
         V/rB051ZLSTMDnZWUJklgXII2zJ3gDgb6hN54bfPPC5WvCSDdr7XLOJS0DgpIHmC5zGB
         rTrq3Nzr+YDiPfjEZia/eET3LPd5MBJNYrwJNhSexNdUtWfS1ua65Gh0t3LDW3gRU3u7
         E8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N33O/jKwx1/k7vQIGoBJU3vb76C/gdsxbsKwqC4sYls=;
        b=iRlFNrGY+cq1zjlfm2RZUevXCQVMFXUhzo+ww8jTFwSvqUAKz7hhJzfn2RsPHuDcGm
         FJQZL52u85sxfNEyIYypdFjmTQ+9dYY78BmhmGmUwMuGZhkaddCegn/peeOJIPlqIr2B
         5LjqZWQVtJSLMdZKloslCyCPkioiJ020HO2SITsokHkNEn878nkclStzvJpTsSzDgo2A
         jdnR6Eqe9il0ykGjIb7q0TqBoByXM+wgJEPTDJqV3fyFLdhnJITd/a3gJFERcSsUVP09
         2KM/d3gxk3MEXMU6wE3rs3Hs303gxZrpTub6sYx5LTDulLAVcDUpgKchFt7YSeiBfo+g
         S+2w==
X-Gm-Message-State: AOAM530Lo4gUIDCOZMttbbMAPDIdwUgI5+pXsJHGyUrSPxN2JGwRnMLm
        AHptJFB1kfVu6Tvk+YSyXF4=
X-Google-Smtp-Source: ABdhPJwN8aEf1rw4yFGnT4ZMpL8wQZqH7HU3xTQw+BKrmLbpsGel6laqznTEhE7TonsGfM+fjrzXhA==
X-Received: by 2002:a63:6d89:: with SMTP id i131mr3183316pgc.235.1630668563539;
        Fri, 03 Sep 2021 04:29:23 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j14sm5023847pjg.29.2021.09.03.04.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 04:29:23 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pstore: Modify kconfig to align text
Date:   Fri,  3 Sep 2021 19:27:42 +0800
Message-Id: <1630668462-24527-3-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630668462-24527-1-git-send-email-zhenguo6858@gmail.com>
References: <1630668462-24527-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

Modify kconfig help for text consistency

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 288ed3c..008ce38 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -4,15 +4,15 @@ config PSTORE
 	select CRYPTO if PSTORE_COMPRESS
 	default n
 	help
-	   This option enables generic access to platform level
-	   persistent storage via "pstore" filesystem that can
-	   be mounted as /dev/pstore.  Only useful if you have
-	   a platform level driver that registers with pstore to
-	   provide the data, so you probably should just go say "Y"
-	   (or "M") to a platform specific persistent store driver
-	   (e.g. ACPI_APEI on X86) which will select this for you.
-	   If you don't have a platform persistent store driver,
-	   say N.
+	  This option enables generic access to platform level
+	  persistent storage via "pstore" filesystem that can
+	  be mounted as /dev/pstore.  Only useful if you have
+	  a platform level driver that registers with pstore to
+	  provide the data, so you probably should just go say "Y"
+	  (or "M") to a platform specific persistent store driver
+	  (e.g. ACPI_APEI on X86) which will select this for you.
+	  If you don't have a platform persistent store driver,
+	  say N.
 
 config PSTORE_DEFAULT_KMSG_BYTES
 	int "Default kernel log storage space" if EXPERT
-- 
1.9.1

