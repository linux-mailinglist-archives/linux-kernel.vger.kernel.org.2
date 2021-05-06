Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0683753BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhEFMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:21:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F1C061574;
        Thu,  6 May 2021 05:20:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t4so3295671plc.6;
        Thu, 06 May 2021 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LulMt2AX6VSvSL+kvUAMyg5m7exs1nDV1kdCnAZEKBM=;
        b=JNWqwWuPeySXhlL1jCocu88stukh5d/CaAxpheuDXoMkx61i24UJFQBKM47AGc7qKI
         CJxeKt5b7QzoAMVs5zDbQrZNrXrqtxwr10AZXrZakGSjqdbD5Pjgu+9t+GFAtg8ClRWP
         gvbDdYjKP95yErpOsIjUVC6j20ndxT438M4MEIiDKl00FeSV+XolrYVaUR36z3ZG2Vs+
         yL31Po9nNn8cbUBUDJmTRDzH8r7eIJ3V2FzjlvaMXvnfdNMgL9tXZ0FzI1eSpCbs19dZ
         esyvJ3hP1dUymtQOZ+DInR+3veH0/Y9nZ5ocsGAErE7BSk3ul6vALLWw8/1+g308n+2a
         ye+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LulMt2AX6VSvSL+kvUAMyg5m7exs1nDV1kdCnAZEKBM=;
        b=WBU/ROdU286e8zKQiLVrwrQDqZOncZPq3TMuuk3TMAPCuRoCLW2kJh4C3FcBkw3pmE
         9KDXMEnISe+tryetIqR7ZAlxIdXb5IKzwJleHJ/1BTcEgUzFm6L6HdnbHHUYuTd8nddE
         Cl0XeFyipSNktTm5Ipc0rt1NKBZCKM2Frf2KhMhhtDY9FavGTAPTMjmk3hod6alMZ6QM
         OKb2fumXJq710eAQesEM5kX69kgToj8uJdtiPlANkVv9K50vS9PHR+k1QPlrlGm2ATmn
         nO3t3ssogXw0FiTN6S+Oyl6iSsbTYmtzdAp7sPKVjUxpeF9YBWUO56rOWGSCj6rpzw4S
         YeaA==
X-Gm-Message-State: AOAM532aAbshv10g1ioybt0vjfkyWMV0ViMLx0RiHpo6kSjEOZD1zJ93
        LW/bRKQaNFYm8kcxccpccFRsokILgQy0EeUHPEo=
X-Google-Smtp-Source: ABdhPJzpFmTJgr+RciAsMyrWc64o7qB4IVbyvENuxcITdwqKqdLoheGuZ9HOBTcsjhKp5k2RWIkKIQ==
X-Received: by 2002:a17:902:a40e:b029:e9:7253:8198 with SMTP id p14-20020a170902a40eb02900e972538198mr4453763plq.82.1620303631415;
        Thu, 06 May 2021 05:20:31 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id k20sm2140298pfa.34.2021.05.06.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 05:20:31 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] docs: usb: function: Modify path name
Date:   Thu,  6 May 2021 20:20:20 +0800
Message-Id: <20210506122020.7117-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original path does not exists, so changed to
"Documentation/ABI/testing/configfs-usb-gadget"

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 Documentation/usb/gadget_configfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/usb/gadget_configfs.rst b/Documentation/usb/gadget_configfs.rst
index 158e48dab586..e4566ffb223f 100644
--- a/Documentation/usb/gadget_configfs.rst
+++ b/Documentation/usb/gadget_configfs.rst
@@ -140,7 +140,7 @@ is an arbitrary string allowed in a filesystem, e.g.::
 Each function provides its specific set of attributes, with either read-only
 or read-write access. Where applicable they need to be written to as
 appropriate.
-Please refer to Documentation/ABI/*/configfs-usb-gadget* for more information.
+Please refer to Documentation/ABI/testing/configfs-usb-gadget for more information.
 
 4. Associating the functions with their configurations
 ------------------------------------------------------
-- 
2.25.1

