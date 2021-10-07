Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07D1424AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhJGAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:14 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:40227 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhJGAMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:01 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id F2E326E4;
        Wed,  6 Oct 2021 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565408;
        bh=ER5WeqZHv4e5QUzYa734QUR0PoxbR0U3SjMD2lEHAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keZbSDNA1mMasatHDQtMaMkueuv/Wl/NrVxagKzSv9B2w8npcfZGhAiaoF/dNtDER
         98B2ey8BNFF1lhoTJc0FXByC7wJz63gmpbx1r9/VHzznuwcPdM8OV/l3krJd2TqiSp
         u1ld/Adc8PuzQ9G8CgUPBkNOwKQCzWRQxjBbcbGQ=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] sysfs: add growable flag to struct bin_attribute
Date:   Wed,  6 Oct 2021 17:09:47 -0700
Message-Id: <20211007000954.30621-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, sysfs_kf_bin_write() unconditionally disallowed writing
past the existing size of the file.  In order to support mutable
device-tree status properties (which are bin_attributes), we need to
be able to write a longer value over a shorter existing one
(e.g. writing "reserved\n" over "okay\0").  bin_attributes that
require this can now set the growable flag to disable that checking
and allow arbitrary amounts of data to be written at arbitrary
offsets.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 fs/sysfs/file.c       | 2 +-
 include/linux/sysfs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index b2b85be95adf..156df003ea8f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -147,7 +147,7 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
 	struct kobject *kobj = of->kn->parent->priv;
 	loff_t size = file_inode(of->file)->i_size;
 
-	if (size) {
+	if (!battr->growable && size) {
 		if (size <= pos)
 			return -EFBIG;
 		count = min_t(ssize_t, count, size - pos);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 49de5189cf88..f8a56094c6c9 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -175,6 +175,7 @@ struct address_space;
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
+	bool			growable:1;
 	void			*private;
 	struct address_space *(*f_mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
-- 
2.33.0

