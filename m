Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143A3692BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhDWNKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhDWNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:09:59 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id er3so15179413qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdI9uhr9cXjOGYy3VuVnSo/ChCyBPax2jvsgTzvHJJM=;
        b=S56Gsdoj+TBt+0uxtHszJUBYLq47SbW6rNDinRUU38WmjdczhRYTyN3QX/MhMXzth3
         yF/CNjHvocrIMwHsekthhsfJrUiV44QNc8Pmao0K9hvHbLvG/CupsT+sx89U2xJJcCou
         hHKvFfvDkwolHivERa+qRTYppWW+mFOoUbGHEX8qZPHlzHaakEhGVHNn2wKlWvDQUB0n
         lW7BWmE3WKIa6BNHk7YZtbVPgJAD9AK8ul0Eg5zsAUnI/+6JJamWt2YnqKZjdV1/qU5n
         /rdLdNdvCf0ZABHwKeeR1rWQ3L0BwabouGeb68VcY8G/xSSWM9zlnnG2cATo2imjt/Kc
         8hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdI9uhr9cXjOGYy3VuVnSo/ChCyBPax2jvsgTzvHJJM=;
        b=B1gnnbc2ZJOHJQae4o7klnu97YwVCjh3gjOD0213g3rOyDfY01/WPBcDZ7JXNHKoNj
         ZD8ScHNpXMJYiftnjfiRXJuFi+UBrueQgxgGkEx82PyULXNbZRZBYP8uJaQREk+BM1Ya
         g3+axAkn7RrA3J+SxNIchnIXEmTN7cfOOaNT9A5cxnRUYXSEzKqo/JyGFnEf+fryLyLH
         LFpMLwk8/thpWMXgoxcYtRBXwRsrGHfgJqSt75zGbpnONgajkYyoThLEKUUnP1y6e31M
         PGRA0hILflZrQIncCe1uPFX9/3R7UIILzF2b9l6mWO69T+ENTEHw3SBzBDjUvbwScBco
         Secw==
X-Gm-Message-State: AOAM531wkn1E9B9xM3jHFxDyrUDvnsmwx1C34keGRqSb2BGepe/yTeOR
        YHthmssSs9UROaCjcY/m048=
X-Google-Smtp-Source: ABdhPJxMTNFZcTTN/aV2y65v2q4Nlke0RojmguY2Nn3QQibYlkWTavF+PpK9/nbSSdAo0LWBkpjSlA==
X-Received: by 2002:a05:6214:246a:: with SMTP id im10mr4261824qvb.7.1619183360009;
        Fri, 23 Apr 2021 06:09:20 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id a4sm4142613qta.19.2021.04.23.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:09:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 1/3] Removed the oprofiled version option
Date:   Fri, 23 Apr 2021 18:32:59 +0530
Message-Id: <c98fa38b74bdd8ab16d35862895dac5f5a535f94.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the oprofiled version option

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/ver_linux | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index a92acc703f9b..1a8ee4ff0e32 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -47,7 +47,6 @@ BEGIN {
 	printversion("Net-tools", version("ifconfig --version"))
 	printversion("Kbd", version("loadkeys -V"))
 	printversion("Console-tools", version("loadkeys -V"))
-	printversion("Oprofile", version("oprofiled --version"))
 	printversion("Sh-utils", version("expr --v"))
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
--
2.26.3

