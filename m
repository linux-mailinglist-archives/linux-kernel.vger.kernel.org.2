Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10DA378DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbhEJMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbhEJLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:32:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3AC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:31:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h7so8993436plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DEr92TvElNvZVVwVBlsQXXoLkEg1JG5K3b9rpvwFvvA=;
        b=C2letRqlZ0atjYe3hWGu+e9vEWQ/lTVGq7e/qswos0srnGnsNcRvb1bvB+ivmTiwfC
         CDDoSnwzm1ZAE4yHs6sCS84t8xCvLpAwuaGzxsW/JmwONoMLt7/saZWqNd3nvnneLuOs
         j0nweoXuskRg+HHBf6wX+YHs4w0S7Rqk6pdFqcH7yEaXFC1fy60U5yZ4e6vFl8UYhzv/
         yMZ/U07pC/9IZcI2ZdRncNQLtiGKbwLKbtP/mwNvy6A1wLW1Cwbp6SQlgiG4+umjzeuk
         LCPz2q6CXJRzl+eSP1lJmx5qPoIYr3dSf7xvABy5CmXYbnDxCc7byr9+PStWmZ1BGibJ
         0QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEr92TvElNvZVVwVBlsQXXoLkEg1JG5K3b9rpvwFvvA=;
        b=S/Js7ZgJ/4yBR2BHmiE0jS4HSfyStdLozJmrIk/o31ZKrBR4Y+/EySbA44cFZagbbF
         ewqiWZjpqRvUxDUXvf8MhrNtJgvZNdEjQoWNKUSeaiB2QBMZlP0Ws9jPleXn0K3Xtb8l
         oALDx2wTmlyQ5+NWiBaWEEftmX4tRr1XeUMydUkm7NdF8Hex7p3BVyF1Dgw8tbqd3R9Y
         4eAivUOatiUf/GSnbrZR6CFVnp/9+o8e/MPxJBeDZTH74NDf8LGWu/r4Nz96KvKD6o5s
         h7KU3MrGf0bc2KM9DA5TkQbI7+gKxyf65Z8V+KBkvSuctJIsxLHtSfcdjpkC+wKAH2mM
         HsNw==
X-Gm-Message-State: AOAM532Y37sZa/QogiCXsdFpT+/nwnMmNAk02BxGgSjSzaBguPNu/t2o
        /54motgH5llBCR1jWlJ9wpk=
X-Google-Smtp-Source: ABdhPJzYnn5Z1dKTAQNappRr/V5T1nb82BZzhzvdcRFxmpT2JVxf5za4BAdBG+Rc+B087RSmsHFPEw==
X-Received: by 2002:a17:902:be02:b029:e6:bb0d:6c1e with SMTP id r2-20020a170902be02b02900e6bb0d6c1emr23553793pls.77.1620646270881;
        Mon, 10 May 2021 04:31:10 -0700 (PDT)
Received: from ojas ([122.177.206.92])
        by smtp.gmail.com with ESMTPSA id 3sm10347744pff.132.2021.05.10.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:31:10 -0700 (PDT)
Date:   Mon, 10 May 2021 17:01:01 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, ojaswin98@gmail.com,
        gregkh@linuxfoundation.org, atulgopinathan@gmail.com,
        yashsri421@gmail.com
Subject: [PATCH 1/3] staging: rtl8192e: Avoid multiple line dereference
Message-ID: <435b60bd8874f8105b4af6e7eb9ee5bdbfe3112f.1620642396.git.ojaswin98@gmail.com>
References: <cover.1620642396.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620642396.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid multiple line dereference to make the code more readable, as
suggested by checkpatch.pl

This patch fixes the following checkpatch.pl warning:

- WARNING: Avoid multiple line dereference
    prefer 'priv->rtllib->swcamtable[4].key_buf[0]'
  FILE: ./rtl8192e/rtl8192e/rtl_cam.c:189

- WARNING: Avoid multiple line dereference
    prefer 'priv->rtllib->swcamtable[4].key_buf[0]'
  FILE: ./rtl8192e/rtl8192e/rtl_cam.c:195

- WARNING: Avoid multiple line dereference
    prefer 'priv->rtllib->swcamtable[4].key_buf[0]'
  FILE: ./rtl8192e/rtl8192e/rtl_cam.c:204

- WARNING: Avoid multiple line dereference
    prefer 'priv->rtllib->swcamtable[4].key_buf[0]'
  FILE: ./rtl8192e/rtl8192e/rtl_cam.c:209

- WARNING: Avoid multiple line dereference
    prefer 'info_element->data[info_element->len]'
  FILE: ./rtl8192e/rtllib_rx.c:2287

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
These changes cause some of the lines to cross 80 characters however I
believe that they improve the readability and provide a good trade off.
Would love to hear your thoughts and suggestions on this.

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 12 ++++--------
 drivers/staging/rtl8192e/rtllib_rx.c        |  3 +--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index c8506517cc8d..f75a12543781 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -185,14 +185,12 @@ void rtl92e_cam_restore(struct net_device *dev)
 			rtl92e_set_key(dev, 4, 0,
 				       priv->rtllib->pairwise_key_type,
 				       (u8 *)dev->dev_addr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].
-				       key_buf[0]));
+				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 		} else {
 			rtl92e_set_key(dev, 4, 0,
 				       priv->rtllib->pairwise_key_type,
 				       MacAddr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].
-				       key_buf[0]));
+				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 		}
 
 	} else if (priv->rtllib->pairwise_key_type == KEY_TYPE_CCMP) {
@@ -200,13 +198,11 @@ void rtl92e_cam_restore(struct net_device *dev)
 			rtl92e_set_key(dev, 4, 0,
 				       priv->rtllib->pairwise_key_type,
 				       (u8 *)dev->dev_addr, 0,
-				       (u32 *)(&priv->rtllib->swcamtable[4].
-				       key_buf[0]));
+				       (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 		} else {
 			rtl92e_set_key(dev, 4, 0,
 				       priv->rtllib->pairwise_key_type, MacAddr,
-				       0, (u32 *)(&priv->rtllib->swcamtable[4].
-				       key_buf[0]));
+				       0, (u32 *)(&priv->rtllib->swcamtable[4].key_buf[0]));
 			}
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 15bbb63ca130..16931a4fae5d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2283,8 +2283,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 
 		length -= sizeof(*info_element) + info_element->len;
 		info_element =
-		    (struct rtllib_info_element *)&info_element->
-		    data[info_element->len];
+		    (struct rtllib_info_element *)&info_element->data[info_element->len];
 	}
 
 	if (!network->atheros_cap_exist && !network->broadcom_cap_exist &&
-- 
2.25.1

