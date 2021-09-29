Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE33941CCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbhI2Trk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbhI2Tri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:47:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A403C06161C;
        Wed, 29 Sep 2021 12:45:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m3so15155247lfu.2;
        Wed, 29 Sep 2021 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jw4ZRW3ctdo5FxQCX2AL0tjYqO94oYLsTMDqJb1BIM=;
        b=GUXGpD+Kgbrf51cGzaLT7nAik7Xle0udM7FNC048Xg2svSZ5DuNjE6DSTvyJ94apyJ
         o7N2ef9Kuz+UjvNqkUvm3YP4mqjY3mvFFL/aEHxh+eFjyW9dzIbYt0xn39r9pQjxSKY9
         Hq919SDEEZkMRwRXq5RDLGQD4njnC+ZnxgqwJHzrbCKIKc+ZEa/+HwjlzWKozsiI5QSV
         YGrYhVSu4pmFZc9TQukWzmWW7+nsILvCZGrmrSe8hRTXntmJgvLK17KxXZ9wUvTY1bKj
         ZgWEGSVCxxacoJ8beGIJ8qItejqNnpyeIWBJ66jz2rK2V78th2Qs1T2i3vpizHEeBG7Z
         ytsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jw4ZRW3ctdo5FxQCX2AL0tjYqO94oYLsTMDqJb1BIM=;
        b=7p+NDMAygHU8399cI9hAdNttvv4+iQzdvy5d7kap4GRj2PNxdpqk+oYehxfisuD8lc
         lM0nFM24L2k6FYfoBkTOlgpMZbKYmw6k3C4z8PnbSBf3vHEaptvBK40BvQSUDS8R5L3M
         W5Y6xkzCXyKvDV99t/s9lfEOcuBJWwBQyeUrFmcOtAY+hY/tg+b4wUYAsvCg+wO+RtK9
         bh38gyilBVaG8jq0NZ8eQR5I6lVzhx6VH0WNvYc3xQr7Qlo2tHgT99ysC3ML9NyVAfMV
         txPTeeubEjMiZv5E89eils2EXdjKrweYi4BTBMuusxgvPMjVIlkFwSj/SaipXZQL+ecx
         iX1w==
X-Gm-Message-State: AOAM53328/d3JJFBY1sA7mSlg72XERLr0mEUz5sgJnE70FzvhuqoSAI4
        s2a6pA3RYRTdrFfyHt3ExRrNFyICGtj54A==
X-Google-Smtp-Source: ABdhPJw0iXqTgig+CAb+nMux4k/IGOk4KbPcZRIjGDk0zQ1niY8nKJlDzXnj9ebWcZ19JbxlfiT9Jg==
X-Received: by 2002:a2e:b7c8:: with SMTP id p8mr1856198ljo.154.1632944754694;
        Wed, 29 Sep 2021 12:45:54 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id v27sm104607lfp.0.2021.09.29.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:45:54 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Junlin Yang <yangjunlin@yulong.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH V2 2/2] usb: cdc-wdm: Constify static struct wwan_port_ops
Date:   Wed, 29 Sep 2021 21:45:47 +0200
Message-Id: <20210929194547.46954-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929194547.46954-1-rikard.falkeborn@gmail.com>
References: <20210929194547.46954-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of wdm_wwan_port_ops is to pass its address to
wwan_create_port() which takes a pointer to const wwan_port_ops as
argument. Make it const to allow the compiler to put it in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes:
V1->V2: No changes

 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index fdf79bcf7eb0..7f2c83f299d3 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -911,7 +911,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	return rv;
 }
 
-static struct wwan_port_ops wdm_wwan_port_ops = {
+static const struct wwan_port_ops wdm_wwan_port_ops = {
 	.start = wdm_wwan_port_start,
 	.stop = wdm_wwan_port_stop,
 	.tx = wdm_wwan_port_tx,
-- 
2.33.0

