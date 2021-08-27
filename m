Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0683F969A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbhH0JCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbhH0JCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:02:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:01:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c4so3520097plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dR85NjlBnsEfD4ItpoEv8i4dv3AbkGejzFu1tFYkWZM=;
        b=J0RJbkPgWN2y0sUFHQIu0EyRwxEwsZMdtTxXejGs9Q0/ynW6rMw5jRcBbaaSOFSUhX
         WWSRZ1+vxknq7KgJSGJIphrr2T/jT3GrypuosJfJ6PLVH6bs+C9GHMyEHV+Gw0R9hvS2
         zjNJNYcvyMf0Zy6tD8bNGsqIF88ErOSFNBGYFc77ZdTAk5umG+lh/l2m6NoJbtch4wlz
         vuFGRdMXaC78lwb6Z4vJl0cfpzCswnChbcdtFiQ/5kejB2HXTcwoZgrJhz1u1Hv+bZld
         elXGRp/LmxbhLFNQDnsATzQlzMrHHh3k2mOLsz1gfmYSIqr0Gc/+gu6gvimx65c/gYKh
         mYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dR85NjlBnsEfD4ItpoEv8i4dv3AbkGejzFu1tFYkWZM=;
        b=qJ9T4xNBVR0l00SHMl3omieoHN3acUyA/VkuvFjVd6h7LSF/pRcNZIhN7lRRBvq5xm
         /in2o9Q+6Q2ze2saEWtljUfJO5s9lqyGubT8AY9dmMujYPXtXqpxyhHvwLf0IUIE6t5w
         8XqdjS+XfrKGDUAudYSHdJkRvoJwDFegOKE7PimIZtHWrXih1jtRESnYTtkSWICfGuKk
         5r88FAahoLTPlB3Vp++9YUSjeDARp9cDHz69Tp+i4J+pXK3AUhNHEZqb1p5OTC6LCspG
         M++7rgs7UwI+EK/UUvR58ijeTJCtb6wjmy7P+tzhlafzFsXosenkZxnZdkYn0GkjjJsC
         zZTg==
X-Gm-Message-State: AOAM532gjPzTocAYO0Vv9V7h32SRg9zY/JqxUvaDnSkleR2rlrm4yVig
        V1F21bxHK1ZzKK+VNsn+JFA=
X-Google-Smtp-Source: ABdhPJwZOaui///0gBVP98tgaliKgTTWNx5a1vfq/JHjXXr2m8DqZdTuTPFiqj+w0BnNRy75K8TB1g==
X-Received: by 2002:a17:902:6acb:b0:132:1ce7:c829 with SMTP id i11-20020a1709026acb00b001321ce7c829mr7601592plt.68.1630054876860;
        Fri, 27 Aug 2021 02:01:16 -0700 (PDT)
Received: from localhost.localdomain ([112.17.247.23])
        by smtp.gmail.com with ESMTPSA id v7sm5478604pjk.37.2021.08.27.02.01.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 02:01:16 -0700 (PDT)
From:   Wenlong Zhang <yixiaonn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Wenlong Zhang <yixiaonn@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()
Date:   Fri, 27 Aug 2021 17:00:27 +0800
Message-Id: <20210827090027.23158-1-yixiaonn@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <YSfjtZsISLH6cktF@kroah.com>
References: <YSfjtZsISLH6cktF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
fixed up the staging driver rtl8188eu by adding another check
to prevent writing beyond the end of the ->ssid[] array.

Resolve this by properly fixing up the rtl8723bs driver's version of
rtw_wx_set_scan()

Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 902ac8169948..6fc1020cea11 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1351,9 +1351,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 					sec_len = *(pos++); len -= 1;
 
-					if (sec_len > 0 && sec_len <= len) {
+					if (sec_len > 0 && sec_len <= len && sec_len <= 32) {
 						ssid[ssid_index].SsidLength = sec_len;
-						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
+						memcpy(ssid[ssid_index].Ssid, pos, sec_len);
 						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
 						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
 						ssid_index++;
-- 
2.15.0

