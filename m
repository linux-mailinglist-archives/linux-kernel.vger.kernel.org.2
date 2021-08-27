Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892073F9938
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhH0Mwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0Mwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:52:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA513C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:51:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m26so5633527pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImX+lEaSLVHqZqeaBkJ+uFMURgXjdXd4Hy04paLGmRQ=;
        b=lWvXxEcl+wUBeQvpAN5BDFR3ErqdZX7RBoyb9HtmqOJQAwLFGY99pPmPPhT/OfP+Ac
         4onIfbzZVheFnzp8S+breGr7p0VQmR2ZJsMYBhHW7BdNQxTfZqND9ffiCfM01hdrQdrM
         mgctm/7iX4NBeQXCiKCpbAiX2cgHPpnmCkazhafECMZCek8mXcV7IrcF2yCerK3A1JMj
         jfsj6WS6ZoDfa9FhqdK9ByIkwycSSACzgMfIO9o5P8uq9D1Q2zFNENsj4F9Z6XJvkbRv
         lxp4g9kv+tzMxPeR4fBDgiDRDbDXil8NAdU14tq8SjafJTuvoz+x5/JLP78/8btREUKi
         kcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImX+lEaSLVHqZqeaBkJ+uFMURgXjdXd4Hy04paLGmRQ=;
        b=a0buZTc2/kKRgV53Tsga7E50zQKMC9fjNJ+zk7Dovmonuv+UrGxvK5I5OlVARYdMO+
         +dP1bMpawNng7IK1aQSjHdjVR2eO4hOo17ONqtxv8/ZlENg0DsVOGMA+Fs3sTY1NCI9z
         kvgqCiGRC03MWmw12EgrbhxFs1diMTP3scMYPWRX2xbQ09YV+fz8no8NKkjl2OmV1JE8
         tq8wGVLPWDqw3AkpU0bapfYDBMh6QsFZ1US/vUfKJMruM0qVkdStAz7nrsaEjrkFjviH
         UbOohx9c/uW3ciBL4LpFvE12vdRJBlbddCED9kDNuImJGyJCHQPA58jcwyTxt9R54sfN
         aRlA==
X-Gm-Message-State: AOAM530pSefIa7+Idn3qhutmuKsWOM4XFTd0Km5ar5cWcf8dwXfJfQ2Q
        MWqK6yjt/sA28A0oW/2LtaA=
X-Google-Smtp-Source: ABdhPJyGbOM6XZ9I6eRr5sx+i8vS4BGkS6+oR72LHvZ7bMs2tmSEOH8TnG4FELGLnhtDIvWleEAXOA==
X-Received: by 2002:a65:6883:: with SMTP id e3mr7852361pgt.90.1630068706346;
        Fri, 27 Aug 2021 05:51:46 -0700 (PDT)
Received: from localhost.localdomain ([112.17.247.23])
        by smtp.gmail.com with ESMTPSA id n3sm6236982pfo.101.2021.08.27.05.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 05:51:45 -0700 (PDT)
From:   Wenlong Zhang <yixiaonn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Wenlong Zhang <yixiaonn@gmail.com>
Subject: [PATCH v3] staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()
Date:   Fri, 27 Aug 2021 20:50:59 +0800
Message-Id: <20210827125059.26694-1-yixiaonn@gmail.com>
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
v3:
- Added the changelogs for this patch.
v2: 
- Fixed the description of this patch.
  Thanks Greg KH for the review and guidance
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

