Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075A134C2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC2FQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhC2FQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F0C061574;
        Sun, 28 Mar 2021 22:16:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f12so8576642qtq.4;
        Sun, 28 Mar 2021 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0V7C1T9wNQmTU6i5HIXBF5gA9OtBRPctbZANANjFuT4=;
        b=DSVtt547zwKQ0vfocNWsj9CnGzbGhQmAOHfy4mD3S0WucmO1u8zdeO2UWpJ9vrc3xF
         P9efShKAc3vYGeTLh+54G2O4yWBXKMm+tILz6RZktD9YbqQGqZzUL/klItSRIrWAHOly
         ZRZ81xbcRbdXpqgYAnjd8PnY1OaaktPZ7613t3+eTsE8u332NH309XDOlqllcgutpos9
         Oq2/9TTsVX342VaLDTu1p1MqKR6MVafjMeVMQzbvRJzApSwyuIK/SjfslOEVfPLJPyQJ
         SFr807luiWgZu3fZw/b5zPXhIlQABLnT4WeI8X6i8clN7Q9XExCxPfKa1bAjfhGGGQDo
         rQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0V7C1T9wNQmTU6i5HIXBF5gA9OtBRPctbZANANjFuT4=;
        b=mlB9IFH/ftxLpdATnNLeccq3D73uGquhcWGMK25cxQx7WyAtG2XJUIh6b+2wFQcDMM
         8FeCk3G5E6vC1tBsg/AnJCGP28/V+i8VxYY+zmjxsgdt4jaf3ZL4fteFDSjESgamKok8
         AaOsFXl34VDt0sAWImTpF9vMppvP55002Ldjlo4QXCoR+lBH8KJWqHTCqYIWWnzMnq6W
         uaMjVoP482Gku7OnIJeRfkC3DKT9B/ZuoSLJDFt/+PukWiJhalpdWk4CGWWILiLjXNll
         T4je/0eZBrrRzvupSGx0d36m7jAcufoAgnyI2mULxnhvSYv56DWxGnIqgHqO8RL5VpXv
         m2vg==
X-Gm-Message-State: AOAM533pXqSw+RqkiGvUTUOhGbXmaPs8aEC+CClrtzNmGbUVNR+Kqdqx
        Y8W4a5VtK+ieTB7iXRNjKNQ=
X-Google-Smtp-Source: ABdhPJx/8PKrdDMLVejl0xPcfgBYMTWCgq/jsH7aKmtzElL9byReR2YGcYCRGCzo3Mp3KFRUYjwnFA==
X-Received: by 2002:ac8:44a6:: with SMTP id a6mr21757871qto.269.1616994965960;
        Sun, 28 Mar 2021 22:16:05 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:05 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/23] v4l: hist-v4l2.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:48 +0530
Message-Id: <6a3c604c9818b80ec269379a8cc2a45153cd28e4.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/directon/director/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/userspace-api/media/v4l/hist-v4l2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/hist-v4l2.rst b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
index 28a2750d5c8c..7061496126ad 100644
--- a/Documentation/userspace-api/media/v4l/hist-v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
@@ -47,7 +47,7 @@ Codec API was released.
 1998-11-08: Many minor changes. Most symbols have been renamed. Some
 material changes to struct v4l2_capability.

-1998-11-12: The read/write directon of some ioctls was misdefined.
+1998-11-12: The read/write director of some ioctls was misdefined.

 1998-11-14: ``V4L2_PIX_FMT_RGB24`` changed to ``V4L2_PIX_FMT_BGR24``,
 and ``V4L2_PIX_FMT_RGB32`` changed to ``V4L2_PIX_FMT_BGR32``. Audio
--
2.26.3

