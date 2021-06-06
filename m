Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA339D22B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFFXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:13:09 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:35828 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhFFXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:13:07 -0400
Received: by mail-pj1-f53.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4219746pjb.0;
        Sun, 06 Jun 2021 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZECU1hyLVhQ0N+f9XI70I4J7ouuREDQIplmH8m1W4O0=;
        b=haUJDGuQWHq5YmEUB2WfHb9icntfo7knpg7VbBQgYzUQKCiIXG3U7JBU7GzOReMSjV
         8BiM4CwMjLNCUUqW4JqMCI8dsLY4xZOryphC4vuG9cVLq211jMMGlJaSQv++eI/GhhJN
         z4aKXwxrGJymSwLJMk9cTx1ONXB1cRBgdcYOoG+2jsClE0kzenu4bDpjQ39sBjgMam4S
         4sPyKAIKengDEjKJ2ZCLRk0+bM2eif83iz2MeYG8xTdwwaTY5/gyAXWY83CL3mzOU7UZ
         2cToJvNap5us8E9uHLzt6LaJosGP5rxRXQudZ3ZALIZBszqGiJhWKCaygLQKJDLS4XX2
         L9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZECU1hyLVhQ0N+f9XI70I4J7ouuREDQIplmH8m1W4O0=;
        b=j/9liXCESHFKw6svwdzAqJo/XmD36VDVv5AYQERKVobikI1vnETs1hIdK6p8js6RK4
         xmzMo4/fS9ls+UEjTo11k/zP4wj/1tMA1KnJjy07/dR/K3p13x0bM0+FCOvIvCf5CjAc
         +OK4YUWXWeUpKlQpLBRZ+c30HE8Nm+7AZa5KwdX8I/fGpTfCHqoFc254qgATZYEFP/BN
         lOjZu83iB5L5Z6QYy7WJJ0SMUSTnOAsCcdUjaGruYx+GsdcDRfbjTCXDSPQiTGK/5aBF
         jZO2QyEg3WCQPZOp0r+ZqlCOM8HfZSrMe4XQVLVe0HEu/lTy0es0MFP9WkY8xqfgNnKc
         ySiA==
X-Gm-Message-State: AOAM532Jx9FR04jehtZAqVNcos+vkLVAUdOcppNnU7WZKzQXG00iYCkA
        IzxRsK9Pim2+RIlIhmwLfpE=
X-Google-Smtp-Source: ABdhPJzkD/YoZsDgMrwOfbOPHQUVN6m5e4E4JOzyke2xiAjlFiNdNIpHpKp85iONY4AZRLDxhNkk+w==
X-Received: by 2002:a17:902:b218:b029:f4:4b88:a44a with SMTP id t24-20020a170902b218b02900f44b88a44amr15379885plr.52.1623021001446;
        Sun, 06 Jun 2021 16:10:01 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f15sm6775672pgg.23.2021.06.06.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 16:10:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 3/3] 9p: doc: add v9fsroot description
Date:   Mon,  7 Jun 2021 07:09:22 +0800
Message-Id: <20210606230922.77268-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606230922.77268-1-changbin.du@gmail.com>
References: <20210606230922.77268-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documentation is modified from cifs/cifsroot.rst.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/filesystems/v9fs/index.rst    |  1 +
 Documentation/filesystems/v9fs/v9fsroot.rst | 52 +++++++++++++++++++++
 MAINTAINERS                                 |  1 +
 3 files changed, 54 insertions(+)
 create mode 100644 Documentation/filesystems/v9fs/v9fsroot.rst

diff --git a/Documentation/filesystems/v9fs/index.rst b/Documentation/filesystems/v9fs/index.rst
index a1e45b89e2a2..65e1ceb04c9c 100644
--- a/Documentation/filesystems/v9fs/index.rst
+++ b/Documentation/filesystems/v9fs/index.rst
@@ -9,3 +9,4 @@ v9fs
    :numbered:
 
    9p
+   v9fsroot
diff --git a/Documentation/filesystems/v9fs/v9fsroot.rst b/Documentation/filesystems/v9fs/v9fsroot.rst
new file mode 100644
index 000000000000..ce6b3c85e301
--- /dev/null
+++ b/Documentation/filesystems/v9fs/v9fsroot.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+Mounting root file system via v9fs (9p.ko)
+==========================================
+
+:Author: Changbin Du <changbin.du@gmail.com>
+
+The CONFIG_9P_FS_ROOT option enables experimental root file system
+support for v9fs.
+
+It introduces a new kernel command-line option called 'v9fsroot='
+which will tell the kernel to mount the root file system by
+utilizing the 9p protocol.
+
+
+Kernel command line
+===================
+
+::
+
+    root=/dev/v9fs
+
+This is just a virtual device that basically tells the kernel to mount
+the root file system via 9p protocol.
+
+::
+
+    v9fsroot=<path>[,options]
+
+Enables the kernel to mount the root file system via 9p specified in this
+option.
+
+path
+	Could be a remote file server, Plan 9 From User Space applications
+	or mount tag of virtio transport.
+
+options
+	Optional mount options.
+
+Examples
+========
+Test it under QEMU on a kernel built with CONFIG_9P_FS_ROOT and
+CONFIG_IP_PNP options enabled::
+
+    # qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
+    -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
+    -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
+    -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"
+
+The above example mounts v9fs with tag 'r' as rootfs in qemu guest via
+virtio transport.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3da44eef1471..dfcee6dfe182 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -243,6 +243,7 @@ F:	net/9p/
 R:	Changbin Du <changbin.du@gmail.com>
 S:	Supported
 F:	fs/9p/v9fsroot.c
+F:	Documentation/filesystems/v9fs/v9fsroot.rst
 
 A8293 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.30.2

