Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70DF43E848
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJ1SZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1SZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:25:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31042C061570;
        Thu, 28 Oct 2021 11:23:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso10256646wmc.1;
        Thu, 28 Oct 2021 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nx0iv12nPNq0xv+S+M126wstpTLUx3VwSBHCsj93iwU=;
        b=cVVai5T37au/0HZs46NwbzUiwpmDhAsc4UV7lhcyc2TMuY5+nvx02GsReblQ9aSdn5
         Z2QL3q3xHmZ9zca4ABAQKolfzf4RdxXxvWKjR39melidS/pbYv0mRqRQVaeeiAfGVW14
         acJe6L7nKdIQ68gF4iKumOv6x1S4fLw670xXm5pH9CQe1zTNwUABs1AFkGB6coiUhFx5
         CVuAYtIaA0ZcqvdNQfqFXeG8ZZ82d0b6s/Tj5MxLf94B+DGwDSc8k5NZu12WaqTi8wu+
         NZr+JKkN+Ro1C/xbkj9LzEP5r1f0feHCLr5FiSR+3583J78+OUwu0xzWQ9U8y/1brQwL
         XcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nx0iv12nPNq0xv+S+M126wstpTLUx3VwSBHCsj93iwU=;
        b=qgCnZqgUasVgddDTT4VLCXCccR+WY5/Qg0X46QOasI8OX7QuR37uPp0VEE62gFyodW
         EIfTmSJQ8e8SD159UXXJlmgeQnNfMAtHxAwhRrow0kl+1qt7mXOi2R1q8JJjueuAHHwd
         ILUYXHIKzSh1xQDFQksYuO9j+JL3SS6Mdx2xdQXiJWTq9ZnmoJ/7O9PO9SCqpA3fUAah
         I5vNHk0fOdhZ0HGo32fTHLf/fTtkH8sb1EROGoNysgRCbv1zuiaMXPAr8tQDMZORao2G
         6WIWn/UjE576uo6ySLgNiOkiq/Mi7WVK8OVGeYOzI3DfEmrSQ9rLD4tfmKAUr4tItKx2
         OL7A==
X-Gm-Message-State: AOAM531rn2zIV58vEIT1XoH52+usYVh7wFBv1lmfgplCeADNRlUZlGV9
        uLxiUG1TASMOcA==
X-Google-Smtp-Source: ABdhPJxQu8KerruMFTRcXfH32iZjyHSKgYfHc9rjZ6iGqPxrd/AxbQIu6PCk7Lz5hdYUD2pPq9AlOQ==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr14416613wmi.145.1635445401540;
        Thu, 28 Oct 2021 11:23:21 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 9sm6604158wmi.46.2021.10.28.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:23:21 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] speakup: Fix typo in documentation "boo" -> "boot"
Date:   Thu, 28 Oct 2021 19:23:19 +0100
Message-Id: <20211028182319.613315-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in the speakup documentation. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 Documentation/admin-guide/spkguide.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.txt
index 977ab3f5a0a8..1265c1eab31c 100644
--- a/Documentation/admin-guide/spkguide.txt
+++ b/Documentation/admin-guide/spkguide.txt
@@ -543,7 +543,7 @@ As mentioned earlier, Speakup can either be completely compiled into the
 kernel, with the exception of the help module, or it can be compiled as
 a series of modules.   When compiled as modules, Speakup will only be
 able to speak some of the bootup messages if your system administrator
-has configured the system to load the modules at boo time. The modules
+has configured the system to load the modules at boot time. The modules
 can  be loaded after the file systems have been checked and mounted, or
 from an initrd.  There is a third possibility.  Speakup can be compiled
 with some components built into the kernel, and others as modules.  As
-- 
2.32.0

