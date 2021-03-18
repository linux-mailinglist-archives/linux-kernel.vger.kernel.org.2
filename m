Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1870F341085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCRWxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 18:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 18:53:43 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:53:43 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id n16so19743023wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BC4eKKHmjRG1vvkwoWx4lTz/Ck4s3C7vVw0d++/wo/w=;
        b=INOSNYb2fPdiAR3Z0OBUsmUuPxWe++VX87XUQBracu9E4R4qth+oaNb8lpGVYRQfZE
         12L/mAvrbYBUpXAP50LIu0lpalp/MXdafluEduV8QrUu2FoEb9NerZu9ex7DF1oZu1gD
         5xvUB6kzd02F9CZDNV8ZAaM27FUcC1uV8BVFVHCCRCFZENWQBBDGGGsuWpydEu9D9NDX
         f2cShSfgXkAf0T7MP5Rzv5u9Gx/jkxKAnG/ePadQGQusMe/imOjcIqn+/3MxegmZRN7e
         bK19WT/ynyk68FwX9jopQdgaJyPY8XdZKoOY3M4VfsJ5KsboLlA+i4M02+W/s2s1BRIa
         PdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BC4eKKHmjRG1vvkwoWx4lTz/Ck4s3C7vVw0d++/wo/w=;
        b=Gosw0JkDsXtAFcyXpNhkfSBR6DJRxEmCQrxkEUDsVKVY04CyN+4GlF4DoLQoz22GTn
         gyHBmwTre9+PXp8I9KGNw2vXnwe98Ywf2PRcN9iW5CVcVqMsBfoZu80/a+wDLF0eqy44
         ncLofuByHqFRtPMAV9vWR/w/+UCiSfxnn6YojoKYlvDSWAkP1eTJ7IAKRLwQ6DYqFY/u
         gNUES3LwNRIeTQ36OUFjH+SMarPLqs+1xxGAbsPwO/RFYaX2+XQEyptnJ0cT8U656lTx
         I15ypWLwX10HgNdsFdpAp4kD/w5qo2gxlVB9XzyxdZvdWjOHlTEStSbDhXF2+HuInPn0
         uLaQ==
X-Gm-Message-State: AOAM5324KwbwIG1q1Wmu4cW7ID9mf5jgoInGxEAq+hOhQcfO0DF2rDeS
        dpfM0v8ksHtLxRfKEKFylB2rJM4bZAvorjiW
X-Google-Smtp-Source: ABdhPJwlt7kaPDvpMeR19EnqW8y3CoDgQz1J7Ta/E1Df0qrUSi07Th5d8xY+3+BYC5CNL6PvkxvCPknPYcklN1JG
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:e058:931d:40d8:84df])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1160756wmi.1.1616108021300; Thu, 18 Mar 2021 15:53:41 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:53:36 +0100
Message-Id: <ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] mailmap: update Andrey Konovalov's email address
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my personal email, the @google.com one will stop functioning soon.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 85b93cdefc87..11219fa3b62b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,7 @@ Andrew Morton <akpm@linux-foundation.org>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
 Andrew Vasquez <andrew.vasquez@qlogic.com>
+Andrey Konovalov <andreyknvl@gmail.com> <andreyknvl@google.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andy Adamson <andros@citi.umich.edu>
-- 
2.31.0.rc2.261.g7f71774620-goog

