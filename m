Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0052A38D5B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhEVLyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhEVLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:54:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FFC061574;
        Sat, 22 May 2021 04:52:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8351315pjx.1;
        Sat, 22 May 2021 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=52w1nKRxofCzX5SRZgG/obCfCwe0ck/dt1IKXt95vIk=;
        b=GsZe8mzZSi1aOKcxTzn+4sh/ULmoYyjEiO4ljmi9YBfDQXX8bAWPiIEph73rmrwFvP
         /tAnFPyeC2srYXifqO33574v+5tY+HzS3PuE8w3gzRHjJbuVZWmOuMhWfOQ8ud3O/Yal
         PWISbI7/1gjluDMBmIcc6mekZE5R+EmqXUSer3xljY/FCVM2POCJqo3sxq+wmUSzvn6/
         5v5q4PxtEinL7s0+qexx7ecqqVjy7N4hQSyDYGHXqoehbgAEGKCmBgoM5UZ4tJ5vhVO5
         jEVicYI9tGJHdBP2HejSnFUJzJOs7ku1Zm36DBtyuaTiH5O7H4Mu+6bxzKB94nGBmGPn
         pX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=52w1nKRxofCzX5SRZgG/obCfCwe0ck/dt1IKXt95vIk=;
        b=YDSuo+E9We6J9Q3DNdZh4Tr60iFAnznd/1/mPSmxWlNQD0L3Gwth/iFDioED7yLUli
         fMFJWy245cs9+/8n9pGtgkL2Zzow25WGaKgpJEaESdAIlmjWQovtzaQOiGofPve4Uu5r
         zSG4E/06PRu9Q7jro8406wBaWzVBmMiij6VLhRv9EEugZ/lrBEqDNIQNcOy6Z1ekN9En
         3kN4d6Rf3nHM5skY8H+T9Le+kNDku7tKbKoctoNVB7D6R6wHyy5WnViHVNUv9nALeJg5
         g2RyEyaQNjzFJENipZAQ+sX8pb6EqQE+lnxesaZR35l4T0nR0uNuJVfI6s6PHXgWyZYN
         Z5Tg==
X-Gm-Message-State: AOAM532veKb3gyakIpBZeWsimJ53TXjyyjfQYWHZtXsv9DqhH5ihr5SO
        dbX0rDzFsNEMZZuLYx9YKrMxTr1J7MHkkQ==
X-Google-Smtp-Source: ABdhPJxFFfyGvd2lXag1q0u/oQOUE4PevFZVDv7hrOReZ7HC14fXNlE6iwwnRYb+Gz/21eoF3LSnAw==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr15594611pjb.94.1621684359571;
        Sat, 22 May 2021 04:52:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:d9c2:4477:9177:8c76])
        by smtp.googlemail.com with ESMTPSA id n6sm7144007pgm.79.2021.05.22.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:52:39 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     balbi@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: udc: fix kernel-doc syntax in file headers
Date:   Sat, 22 May 2021 17:22:27 +0530
Message-Id: <20210522115227.9977-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for drivers/usb/gadget/udc/trace files follows this syntax, but
the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc.
For e.g., running scripts/kernel-doc -none drivers/usb/gadget/udc/trace.h
emits:
warning: expecting prototype for udc.c(). Prototype was for TRACE_SYSTEM() instead

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 drivers/usb/gadget/udc/trace.c | 2 +-
 drivers/usb/gadget/udc/trace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/trace.c b/drivers/usb/gadget/udc/trace.c
index 7430624c0bd7..19e837de2a20 100644
--- a/drivers/usb/gadget/udc/trace.c
+++ b/drivers/usb/gadget/udc/trace.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * trace.c - USB Gadget Framework Trace Support
  *
  * Copyright (C) 2016 Intel Corporation
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 2d1f68b5ea76..98584f6b6c66 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * udc.c - Core UDC Framework
  *
  * Copyright (C) 2016 Intel Corporation
-- 
2.17.1

