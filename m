Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687A6418657
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 06:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhIZEmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 00:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhIZEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 00:42:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BDC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:41:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i25so60301018lfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=pOY96EtaoM9msm8YQqdPfoCt6i9QDkb7BUEuFgXTEYk=;
        b=kO6cSsLeCmsY374nITEGtxbS6eN2IlrgpL+H17Yjvw0+71uQyyG9zqi/RKaWI4EJgA
         kr0JSBz49LwOYZjwmW4rasPs0zILSaTUqMnm92WFKpadFI0YmmDgXALFSM+tvsDtzheA
         WCh+jPV90rHsORJHL/km/9cp23BBSLhJfiM2tRknzpmk1HfzgciQez+EsVSEvorVs6/B
         WoX0cDIuaohrrqLk+QUacRD4tPdyhTlLm6d0Q4AFs+sxzW97p7cscDr/2CXhREKVyG+G
         SN4ezMxYVqmTc3LmL92zlcr2WHG7KDv5J9Il0xsejn34jtgRFokJHjopzoxrHMBaKmBy
         Q6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=pOY96EtaoM9msm8YQqdPfoCt6i9QDkb7BUEuFgXTEYk=;
        b=SuLcAAgNksUHTCWs9X19FOcGAAR2Hz5p/tPrPFcf+vm15U/GvjdXUf+vei6HlvpF6z
         fcGOCC+qjxdCKasna9/NIJBuCPBc92k+0d7th8EuTsxotc0hU2H4HYTDnbIAwpRnbWpg
         qNx0baX/BaG84kQs1WCJlvlSpWVL1Da1yXsG8e8aqfgv9mr8MfiX/a9P4WGqtIG9ryu5
         SN99W1J00ESs+lrwVu5q/PyNj+SSH8IPh6G9UEEmxmRt3Cay2IlLgKTzAEjVtgcgMrnN
         p0vzTKz6dMFA0UIU/4DptRbyJxTaCcog1waKhIc9Gy561RJX+XFd/VXbdOkFTv6Oondq
         NRTQ==
X-Gm-Message-State: AOAM531j4r40MlFVArLnFPlBDa1DWImSUuBF6ikb9K0aSnwCvr/1CB33
        V1qwwnjxqoJyI8mNkxZNH19K0Of+2il3oQ==
X-Google-Smtp-Source: ABdhPJxQuEFEutBNMAzx9PTip3IdXHtEBvL6MyNNWmRisTZNWK9RgiFR2hqluxyO+a/RAAnNMVYIeg==
X-Received: by 2002:a05:6512:32c5:: with SMTP id f5mr18539755lfg.234.1632631259227;
        Sat, 25 Sep 2021 21:40:59 -0700 (PDT)
Received: from dj3ntoo (54.sub-72-106-71.myvzw.com. [72.106.71.54])
        by smtp.gmail.com with ESMTPSA id e18sm604333lfs.187.2021.09.25.21.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 21:40:58 -0700 (PDT)
Date:   Sat, 25 Sep 2021 23:42:48 -0500
From:   Oskari Pirhonen <xxc3ncoredxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty/sysrq: More intuitive Shift handling
Message-ID: <YU/6SCmUr9qGkqBu@dj3ntoo>
Mail-Followup-To: Oskari Pirhonen <xxc3ncoredxx@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Alt-SysRq-Shift-<key> behave like Alt-Shift-SysRq-<key>.

Signed-off-by: Oskari Pirhonen <xxc3ncoredxx@gmail.com>
---
 drivers/tty/sysrq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c911196ac893..4d3dbe62daf8 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -843,6 +843,8 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 			sysrq->shift = KEY_RESERVED;
 		else if (value != 2)
 			sysrq->shift = code;
+		if (sysrq->active)
+			sysrq->shift_use = sysrq->shift;
 		break;
 
 	case KEY_SYSRQ:
-- 
2.32.0

