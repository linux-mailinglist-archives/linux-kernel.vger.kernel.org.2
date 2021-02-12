Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9031A36C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBLRSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBLRS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:18:29 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39475C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:49 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c63so62028qkd.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sjPAwZpJiXhVxPtqxJm1Bx7G/I0f+vTY0LWrgQk7G2I=;
        b=g3huwr6+g/6FsVqIDMedrn8bjBzf8pj6YfTVmbGdO7JhQSy0R8covi3Izgp1Iy0kox
         DmcIEmwDj1eUH7KuXT6jBzuJH6NY8ivSB5DX5bVAETA+tt8oltHPXJOuxHcOFo9ufxZQ
         6I6V1r7T3KGBTMSHPrVr191+mwC4dGH17RKNxAaCXNLq9ITjFj0fRZWyYeSR3vZr2KJ4
         xfpiDn5ZofqY5gSGf0noY03X3DHtUe325m1Jcb5Wu6dP6GnKw4uetZwy/qAgM5vLzfay
         VhiEjM9obmtiPYK+sjqz8s3as0aEtrvBM5spWlG/oG5iXrDM2ThLNvaPLPqMmaYC340V
         1+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sjPAwZpJiXhVxPtqxJm1Bx7G/I0f+vTY0LWrgQk7G2I=;
        b=KfDBUJw+WrubT3j8hj3/ZJfpuq+81XvLPSS6CLKxHlxqRiR7Lk3HRsXHcAqXs0kMxE
         xzhZD7dHeHrR9tiVbzyjXjIRzyHyVzMFsJJH/+LU5JS40/kfMD5M+2OHgZbldYJSZVwt
         LtoOZ4xF7BSKpyAek6vQxq9YqY847DRO1vUM9WmVhYtojRZSeSZrbFxZ4f9Fr8cFnw/y
         0NBCK4wJAe/RjshJ7WtamUZmLLWw90WJwPlYmOvo6Z3HZKoWSCORaE2WAcPkt2iUEfGI
         X4rzuHSG/i8iDoyml/kVBVeo/7eBus9IXMQS4mVxifU+37ewBiV9YySihdl2ixIsIds0
         TTYg==
X-Gm-Message-State: AOAM532GUFpyCXiBJgMatxXVlEjuvHm5zBKnZ1dA2sO1t74JBBeMpY9H
        se1/P7Zz8ys/7DyHonbxqFELEMhmqo8tAY7Q
X-Google-Smtp-Source: ABdhPJyGJ3sBff4mi2DYHh44YgltfadJO7nyFWnopPUNKiOBLSyvAVSxbhbI2wpsLppIbmTI+tDPpxD3cxXEiKiT
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:19dd:6137:bedc:2fae])
 (user=andreyknvl job=sendgmr) by 2002:ad4:54ad:: with SMTP id
 r13mr3510435qvy.48.1613150268429; Fri, 12 Feb 2021 09:17:48 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:17:39 +0100
In-Reply-To: <7f9771d97b34d396bfdc4e288ad93486bb865a06.1613150186.git.andreyknvl@google.com>
Message-Id: <c1ce89a7aae0e2d6852249c280b1eb59aeac30c0.1613150186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <7f9771d97b34d396bfdc4e288ad93486bb865a06.1613150186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 3/3] MAINTAINERS: add Andrey Konovalov to KASAN reviewers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my personal email address to KASAN reviewers list.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b3d374c858d..e9fccfb27e2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9561,6 +9561,7 @@ F:	drivers/hwmon/k8temp.c
 KASAN
 M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 R:	Alexander Potapenko <glider@google.com>
+R:	Andrey Konovalov <andreyknvl@gmail.com>
 R:	Dmitry Vyukov <dvyukov@google.com>
 L:	kasan-dev@googlegroups.com
 S:	Maintained
-- 
2.30.0.478.g8a0d178c01-goog

