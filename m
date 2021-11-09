Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20A44B523
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbhKIWKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhKIWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:10:21 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D51C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:07:35 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g184so373037pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PiAUxlIouGkMo4Hs45dNAcVnUrnIKf4M+gHTrcC9v4=;
        b=DgYJaW6jmN5TST4LN4xIAZNXf5sFjJ1as35Z3ybmp0V0iAKyiqVBVjdoQ5Kns6JVF2
         CsLkhJ7nqUtKmIyHdZqpHVHdrpEtHGaUwf6ruOdIEHYeKaE9LJIno6A/W/hm33c1lBUw
         /uOJHNAEml0H+cQkG+ha8SVa9Uam8gnHtV/hoVeTRvKwaszUUOkiWs/WtYcospTux1jj
         L2pwQFS/0317d2LCn48WJuOoP35btjLCWf/BnClBqcRIaJ72JnEgwF2M391T8985VaSi
         +iwxDn/ArtA3jXngDbOsEGGz/YuIq2dmcr6cqXrTIcMlkcLrtLb1vW0WwMWww5aSmpw6
         sY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PiAUxlIouGkMo4Hs45dNAcVnUrnIKf4M+gHTrcC9v4=;
        b=D7Ga0sxrAh7MHu9Rus16KLfGiZdCsrY5O9Svg3+Yro5PoQ+YSCPgIOdyznJ142h+OG
         8Xya3T7QboVdNGNZwnA/ZiJGXNWZ5YUOmY+hrpEtRWD0bOH64Mpt/XLzwv/Owvuj10+i
         4N9+kcjmI+g5UqS/XtsqOCd3ff2qteBfxG9XYarVtsHg2XRk4xW0KsOkfJq6zBEGvGN2
         B2tKMtjJ+l72Mhofe3vxNjiy3fQnHle5XZA4BZsG2F/j2Wa9YlYJt0aYh7+ig4RDeMZA
         EyTvc6haVfP2Nbxr0w54H0AQ1Pd777yAGrrMVJOyT3GQH01gJsF0fLh77uikrawyJQBq
         nD/Q==
X-Gm-Message-State: AOAM532Oi0HpEKo97Sm5p6zDPEc6P/BT3EYrG2a+e7RttZEyghKC5PPE
        jRwDmVxrAjFlhFVaTVBs0WY=
X-Google-Smtp-Source: ABdhPJwP5A70GNm1oVsMRJh2regGdMHfrA0iA20ZU4rguRCuJlK6kfyr44Y+DzClTdGoovm131YgkA==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr8490634pgj.355.1636495654497;
        Tue, 09 Nov 2021 14:07:34 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:458e:ac7b:f0d6:7ef4])
        by smtp.gmail.com with ESMTPSA id y130sm14494685pfg.202.2021.11.09.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:07:34 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 1/2] auxdisplay: charlcd: fixing coding style issue
Date:   Tue,  9 Nov 2021 19:07:31 -0300
Message-Id: <20211109220732.7973-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109220732.7973-1-sampaio.ime@gmail.com>
References: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
 <20211109220732.7973-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing 'int' from 'unsigned long int' declaration, which is unnecessary.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/auxdisplay/charlcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 304accde365c..cca3b600c0ba 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -37,7 +37,7 @@ struct charlcd_priv {
 	bool must_clear;
 
 	/* contains the LCD config state */
-	unsigned long int flags;
+	unsigned long flags;
 
 	/* Current escape sequence and it's length or -1 if outside */
 	struct {
-- 
2.33.1

