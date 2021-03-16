Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499E033CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhCPFsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbhCPFr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B95C06174A;
        Mon, 15 Mar 2021 22:47:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 30so11866416ple.4;
        Mon, 15 Mar 2021 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3/U/Yb1SLna28GWjktpEK9Fb8kh/iQdWdzqQ1VGy34=;
        b=gDYcK6E5+LvYgfaCxLPBh8gVGOBRGaoux1QSNWjCEgDDJXwe/lVyh2ntdEP0Xu+WPl
         FzFhZkbVeBZZQcYzjGVLxS5dfy8bNr2qCtkVguPcEz+2Egto08vGQGzGVvOdkcZdoLUj
         /UbEAZ/qyY2McKaN9csemDJkWi4c7jDqUjRp0hUzQc4mF5/S2Eu5cGC4Swn1Ypz1ASPY
         SUTOQowNB51UMY4r+dfU8zDFH5rUQYiBmFkz01oH4Snd4YgI1D7ia0eO/0nOWF7TB1E1
         /4Ydezb4v7c45aDkeeHS+Em8Yc6176wmnMXvqNQO7tfoA/H9TkpTTDxSzWh1TlQsRRaE
         s3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3/U/Yb1SLna28GWjktpEK9Fb8kh/iQdWdzqQ1VGy34=;
        b=dz/n+h99eVwoabb+UgNYSBaKj2mlTd/31n8+UzUv90IIeXlkqgGqWwoxCQps/6CF3I
         hEtkbfmNw3SF9M3yE8eJepTYTFSIGtUuSFyZtGpKqnqyu5FxpC9zDzvten+4X7Hvep7D
         UeIH8wlosq24K0QMjFmzJKDkQMIfs/iOpSukTkUJQIsI2bY7HccZk43fpbDTneUVClmF
         PQU6k6QTSvTj5c6nr1soVoIaU1CE97dnzmwR+QIufdfVFf3rIwR033UnrgV+Em5uLa3k
         XenzzD2/rjFkMbuVnLWHU2hmIKnxgOahQqvMwkPWgbJDe9sKYS1pDK6dddR1zyghd8c3
         OLng==
X-Gm-Message-State: AOAM531A+p2mPp144kaJRRg8Qth1Hp2jQKeRop+/BGDMvXTzX1D9E0ZP
        gLwESOTYDB2YkRmJO0YWT74=
X-Google-Smtp-Source: ABdhPJzU13UGOkrM2KkXXaDSn4FGRq7tvMg717B+HuTE+GSiLNrsMs2+r7N7bKoPtWCygu5bZUxgLQ==
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr3104938pjr.228.1615873678635;
        Mon, 15 Mar 2021 22:47:58 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:58 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 09/12] docs: path-lookup: no get_link()
Date:   Tue, 16 Mar 2021 13:47:24 +0800
Message-Id: <20210316054727.25655-10-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no get_link() anymore. we have step_into() and pick_link().

walk_component() will call step_into(), in turn call pick_link,
and return symlink name.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 8ab95dd9046e..0d41c61f7e4f 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1103,12 +1103,10 @@ doesn't need to notice.  Getting this ``name`` variable on and off the
 stack is very straightforward; pushing and popping the references is
 a little more complex.
 
-When a symlink is found, ``walk_component()`` returns the value ``1``
-(``0`` is returned for any other sort of success, and a negative number
-is, as usual, an error indicator).  This causes ``get_link()`` to be
-called; it then gets the link from the filesystem.  Providing that
-operation is successful, the old path ``name`` is placed on the stack,
-and the new value is used as the ``name`` for a while.  When the end of
+When a symlink is found, ``walk_component()`` calls ``pick_link()``,
+it then gets the link from the filesystem returning new path ``name``.
+Providing that operation is successful, the old path ``name`` is placed on the
+stack, and the new value is used as the ``name`` for a while.  When the end of
 the path is found (i.e. ``*name`` is ``'\0'``) the old ``name`` is restored
 off the stack and path walking continues.
 
-- 
2.30.2

