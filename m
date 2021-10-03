Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427FA420196
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhJCMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhJCMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:43:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED75C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 05:41:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj4so54531140edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2g3wCjrQJwm/CSjIKNKd0yY90ZK7/cLED9XkJWaRp1c=;
        b=j95gM+HRNu0aEJzoptqdVVcVYV3Qvfd9VcrWfl+9rPymzFY4BSItt+E0Xqeg18GXz4
         dWbZFVn/b+JeaTDbOPEbjOR0UL41Ao5vD283sRCAYvfXG4pEirZoI8mkXg72uODtsI7p
         /LgAopFGq6WlcpYDszuD9W/2Y4yVwM1aWWqUItRmoGGMtOUK5CiHmeag3u/VZJR7md3T
         1zKnXEnQR7XB15w1DBeiA8YGCKhZffjmXCYD0ywa+fm+iE+QL8SQJXkC+KR4D07sWvnA
         te/WRwtyAMtJXbtSfGgOnZJwjodJOdNREVW1VASKn/Waatzyq9rHWty2favZOkTc9ohD
         egYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2g3wCjrQJwm/CSjIKNKd0yY90ZK7/cLED9XkJWaRp1c=;
        b=muJVqEzoPj+wmCh+UllnL8HKRR56e38MEHrZUoGmndjb4kni9xFzI9GavDouU3rem6
         LF/GiMEYw7cXBzKSa17AFJnomtDYBX3zpD9Vf880msrwZRt7lXZpZAVWpolmF9I+GR7p
         w0x5FVqnAVoj8mGdkQnAvoGgW5hAx7Lug4miBSA0Uf+lwRXp/1gu4dd4KBr/Q4m08sCG
         J+elFk99jNCKLdlDl8NcU8eUrh+nwq+7xM4XQdp5pLEvfNSfMFidhXnEL1gLVAFPeEdL
         1qpYmae2Nj74gqlK1Adhqr7FS42B6A7eggD5TVvCLCy81wESUaRWuJ1Sz7C+h5IA/mB2
         D/Hw==
X-Gm-Message-State: AOAM533Hfeu5y+VJFPArRhAyfERg70sTqSk3bYf2hMY086AlhMFhaIuo
        11P8mY2utT6dd9Pl+aFFZfqmoLvJ4A==
X-Google-Smtp-Source: ABdhPJycFX1SgIR840y6bmKIeI2Qw7GyBot3vfHpo6EsHFrdOo9rfq3OT/2rQ0Jtfv+ElaKfG965xA==
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr10520335ejc.412.1633264905670;
        Sun, 03 Oct 2021 05:41:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.147])
        by smtp.gmail.com with ESMTPSA id k19sm2591675ejg.13.2021.10.03.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:41:45 -0700 (PDT)
Date:   Sun, 3 Oct 2021 15:41:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rf@opensource.cirrus.com
Subject: [PATCH] lib: uninline simple_strntoull() as well
Message-ID: <YVmlB9yY4lvbNKYt@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Codegen become bloated again after simple_strntoull() introduction

	add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-224 (-224)
	Function                                     old     new   delta
	simple_strtoul                                 5       2      -3
	simple_strtol                                 23      20      -3
	simple_strtoull                              119      15    -104
	simple_strtoll                               155      41    -114

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/vsprintf.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,8 +53,7 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
-static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
-					   char **endp, unsigned int base)
+static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
 {
 	const char *cp;
 	unsigned long long result = 0ULL;
