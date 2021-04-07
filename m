Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D4356DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbhDGNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbhDGNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F414C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 12so3573774wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/ENy3CBjvmg/J8qPrFD4l+ic8WZcpLDX80h6j6fkBs=;
        b=u+XZvMa07etK42qOniMbGWyHbMzfRhh+HHQM71X3IyxvmQWpDrGi8wMKtcrIEb+Ekq
         c5USHX1VQW6QE5p7jZe5dUCnaO32k/IWeETp5wRm4dVOsUrmCBr6Af9lp05p5zhEj7a0
         K7AGGs0sIRqiaD+YwsiSCsURIjLOZzB/8hTce7mY2tAOUlCWJ1pD95wosdgOENekZjB9
         uMOYNt1pQynJct5Nh7Us6/v4dzs9/ihkdPIOmVECqonBPDHq4w/viw+3SqBNJO/PrY1E
         vH8wP8VnNGo00PPrPe2wge1KvEvZ9py4xhR/TN+l6yoUw9M9SXpIzmlOiAQHQIsYohE5
         SAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/ENy3CBjvmg/J8qPrFD4l+ic8WZcpLDX80h6j6fkBs=;
        b=FMz+D9Tg4MvGUxjL/9uXhv0j2Rpki8CIXim7iQnjYEBpIIf9Qd4oqsyDmY70+yTKRi
         F0W6Gzr4ljN4ITI6FCARQdbtPUOOdh+LVVYDEPmBR3uWQyIr02Ev7K7VpR9lxyCSQ3Dp
         SQCKHRRUghZCGWst3tV4qbjsZH3wzWRaylJmcb3BR5gzdmujHxzdlsbOjctho0yaS6lD
         rUHAH4ukeT5+tPQz5ggWipSkYJI0bP6HB8czDegJFUEZvwMKlcTklHLwuz7vTKvDqEVY
         /QMbLNJTgkh+dfIx2ARWB4tBuErNka/kuBRcsxfjG+TJXUYqGvI/7cFFIj3pPhIXDDpX
         1Zkw==
X-Gm-Message-State: AOAM530rHWpsbiU2uQL3OXAo/amWUTzg+vbjgj8cKdrDCHWW7W8WozQo
        91CsG3p4FjBtaNxWjuyPNF66Ln1gb2ylog==
X-Google-Smtp-Source: ABdhPJzXSPBnS0nsniUN9R2afkN9pF1DEIOiWOT8atGlrgJQok8AjRy2431IwjURjACOb3rMnbd/Eg==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr4558682wrv.95.1617803399064;
        Wed, 07 Apr 2021 06:49:59 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id z1sm10477874wrt.8.2021.04.07.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:49:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/19] staging: rtl8723bs: remove DBG_871CX log unmatched by cocci
Date:   Wed,  7 Apr 2021 15:49:27 +0200
Message-Id: <740bf0eeef550de36e772bdf7d051499627773e5.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a DBG_871X log untouched by cocci, maybe due
to the presence of a trailing \, for it is inside a
macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index e3dce1b2e553..b26da309f54d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -701,7 +701,6 @@ void sa_query_timer_hdl(struct timer_list *t);
 	} while (0)
 #define set_sa_query_timer(mlmeext, ms) \
 	do { \
-		DBG_871X("%s set_sa_query_timer(%p, %d)\n", __func__, (mlmeext), (ms)); \
 		_set_timer(&(mlmeext)->sa_query_timer, (ms)); \
 	} while (0)
 
-- 
2.20.1

