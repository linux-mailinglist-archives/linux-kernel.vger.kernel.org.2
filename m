Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF88E376D9C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEHABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhEHABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:01:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A3C061574;
        Fri,  7 May 2021 17:00:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i14so8507553pgk.5;
        Fri, 07 May 2021 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJj97jkvQvwH6GYyD+oH0hFSOaDbSE3kGZhZ3gTOaVQ=;
        b=P43Oy7ADdjz4gKlFHryvy+Rc6INiDXFKSgCRsY0iP4iXCWfVDOvaGfsRpiN1gBQ7WJ
         VTCJS7yFmXvEcYLLoyebbFl1FD59YAdckR3ZztgZv8UcavQ7Rk8eWwBOEA4+SsrxzmZI
         SohKSMvO9vdocxGKP3noQ7+iCGhc3sILdsdVYGars2gqDquaK8CGuGugXTzkhetJKpdu
         XdhzaFALETIew8B1nNODJfrgo2YfBdWJO5Ac8Co23DiZ+v2KFLancpfTruZPAaiVIWOY
         aNgNzWjzrHEESLoQ+GCTUTCg4aVa+h2kGH01rLrUDLSlU17SWEB/0NUyaz9iCZHlTB1H
         LuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJj97jkvQvwH6GYyD+oH0hFSOaDbSE3kGZhZ3gTOaVQ=;
        b=kCyAf98NmCPQ4yIGDYmSTtPiH5jXA5g2mRT9U8crrHWi7fsHSC+ZXO7gOBWkOFPzoN
         5aMHhREv286EztPsXDQTG7z7uCCyeJeUolN6zn9ochH1wWbgkapj8z9PNExdCFAsm6G+
         +OxCuEzL6gsuFlMk+P5tZ5ufOYLkyHMzBuNAS4RCYUOeuJ60He2JypOekhTrYaPmCU/3
         vTsvwdaYt5Woye5cgW2KfrZ7N57IwCEyFS9MWB8FRpw/WYriUHT+jZQ0jNjzmqXsrsLp
         DZkyKomHw9j5X2A1Do/cuh2nudXUrPLg4DUCshK1cSiQ1pThbXJNJdr1pPgyOzCUiy7f
         8ciw==
X-Gm-Message-State: AOAM532tS+Uq9Ea+ZW6XpSk3eApxVa7zwH5U+VBVnhTbQEoaJjFzOF4M
        uPg+VeMHZuCMurwWfsnn7aY=
X-Google-Smtp-Source: ABdhPJzMYCdvdJw/UR15P6oE1JRGjf2gHcMpVb+lQ+cJfrbRMLnSB6PJJ53fipovNahHip2ZZQwy7A==
X-Received: by 2002:a62:25c4:0:b029:276:a40:5729 with SMTP id l187-20020a6225c40000b02902760a405729mr12980832pfl.80.1620432000944;
        Fri, 07 May 2021 17:00:00 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id g18sm5700449pfb.178.2021.05.07.16.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:00:00 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 3/3] 9p: doc: add v9fsroot description
Date:   Sat,  8 May 2021 07:58:42 +0800
Message-Id: <20210507235842.16796-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507235842.16796-1-changbin.du@gmail.com>
References: <20210507235842.16796-1-changbin.du@gmail.com>
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
index 2d22e2af4d10..8c585d387f61 100644
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

