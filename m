Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3136EF09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhD2RjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbhD2RjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:39:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B328C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:38:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso8465350qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WpMEHPbds2Rhg3l6Bk0VFJZGn5ipo4apAqnWrKsE5c4=;
        b=UkLmhq21G9yc49Z2YWhYMcMJfpH4lMjNSOHTQ3p6SDiJI/yS+IxzvfHobHXQ9br85T
         Jx8T8/MJykCPgA5QYmKHmrktKQX5DECpwYJmhbyB4D/31LwoujpBkp3s2DTHPeC7Zm4Y
         OvW059QSWPjthG0jxddJIB7lpZi4iUxdDngi8UNzJGiis4K6Ww4tUvxB9nIi2PvUFeEv
         W4ufOBaZD8a7ysZbTWIb6mKx4fqMAyyZcPxPbo1090QhGw6l+ZtO2llLVUsVDNqmZKic
         9eL3NcNaU3I+SXFwxdQae/89tC6dowvLsyvDRgDmh5vAGSwzSHyQZsihkws/P3g+s15K
         FLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WpMEHPbds2Rhg3l6Bk0VFJZGn5ipo4apAqnWrKsE5c4=;
        b=SC+tZwiO6ELUIba2VbqD6lMAYABtzEnLARmnCc4FjqJrj5eKANelJPdpfsmiLjpPmF
         IoA7JqZMkNXvDUCoK7mVt+KwqM+XrdfuQjuLIwyBjYwC8y2jLoPpymYIogxlMWzlhhUh
         xjfQn/T1SbjO4pl0oOLBJ0mIAsigvi/WyTlA3xsxFI2F7bDp1TzpZQGQPKDO4OpdSrSW
         QgeKBv75BH3n5wgt/jyMOlszP7AnMZsx5BmjbAPMI96IPPyCXyflV4vIdZhiCM/MSqSY
         2c1gKILUGDya7Z3kG3xnAPqjnICfu9TIGjEE0QqBXlHPhhB6QNP6sERATIYZhabo6kVG
         zOpw==
X-Gm-Message-State: AOAM531OV+ARFfQYFM6Sd/IXNjcPUTNt9dJOPqY0GeYMCuv3sHf7HdMG
        d/N+S466Nn52Gg1rFGUijf7nQ0pXe3kv
X-Google-Smtp-Source: ABdhPJxTYICujkQPtJYJVsHuxV271Yk6KHakyDkdvkOIG4LlOoxWUwhIKhNzSjNgwQJLcqyM0F7JA9WNzcZJ
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:b87a:317b:6a3:155c])
 (user=yudiliu job=sendgmr) by 2002:a05:6214:2b0:: with SMTP id
 m16mr957921qvv.4.1619717897610; Thu, 29 Apr 2021 10:38:17 -0700 (PDT)
Date:   Thu, 29 Apr 2021 10:38:12 -0700
Message-Id: <20210429103751.v1.1.Ic231ad3cfa66df90373578777cf7cdc7f0e8f2ae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v1] Bluetooth: Add a new MGMT error code for 0x3E HCI error
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to enable us to retry the pairing in the user space if this
failure is encountered

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v1:
- Initial change

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a03c62b1dc2f..78b94577a7d8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -45,6 +45,7 @@
 #define MGMT_STATUS_RFKILLED		0x12
 #define MGMT_STATUS_ALREADY_PAIRED	0x13
 #define MGMT_STATUS_PERMISSION_DENIED	0x14
+#define MGMT_STATUS_CONNECT_NOT_ESTD	0x15
 
 struct mgmt_hdr {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b44e19c69c44..9e44c04d4212 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -271,7 +271,7 @@ static const u8 mgmt_status_table[] = {
 	MGMT_STATUS_INVALID_PARAMS,	/* Unsuitable Connection Interval */
 	MGMT_STATUS_TIMEOUT,		/* Directed Advertising Timeout */
 	MGMT_STATUS_AUTH_FAILED,	/* Terminated Due to MIC Failure */
-	MGMT_STATUS_CONNECT_FAILED,	/* Connection Establishment Failed */
+	MGMT_STATUS_CONNECT_NOT_ESTD,	/* Connection Establishment Failed */
 	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
 };
 
-- 
2.31.1.527.g47e6f16901-goog

