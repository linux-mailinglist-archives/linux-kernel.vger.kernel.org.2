Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16138FF34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEYKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhEYKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:32:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924FC061354
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:30:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 129-20020a2501870000b0290526b90a2992so2039811ybb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fyjIrLzYntEHHLrRAIzBQQt2AEsBdUtB3IMjcBPkQ9g=;
        b=wVCX+TVKyjcdWoHrgXmlUhvQjo0GsS23RxJFN3W7YopCvFYw+sNNupJhJUTJ4ywtmm
         +A5hfK8rWRR/tr6bN9P4Z6HXEPV4VwkiSSswqR5hCN2NvWq929j35Qo4IaQuOK6/j7sG
         aifd280V1o6FMYsAVx9Wo8WxjNHb9JTjszEBnBaXTY9IOsJcPoOwJvdr6sFLyeQQzC+y
         jLQ51zJFG22G+hfmf6PWIAphcxiGP4yazuadFOp0brNlcPycsjq1VfkUuS3x3gN2aUJw
         rm5Ul7aCruDj0bnPM9bshN+sKnBDS/ZBkfXyxacxiFveoVK+ZI1rPX9BAfNUBxjUp71s
         Xtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fyjIrLzYntEHHLrRAIzBQQt2AEsBdUtB3IMjcBPkQ9g=;
        b=GUqVIXV/vwMvlp3toTIYSdlejdpgmUo0EpUj17s1LX4mVXEf24DO4weSPlIRd9mQns
         iUrDuwgMdUBxG21keFqgaIc4tjiMeKxijf7BQX5wgNZxTBjv2QNTbEb1alYHdidRq6zK
         qJ0nSEmwmD1CI6xpnLVc5IfQILd3rwStMK/1i/vPyqCM+Ia+MmDWk9lEEFpDTrHeGyaA
         1vsRD6QeGOjTu6gv2mJA6TwGkNu5pAY+xEoMR+OaHYlpc1FCG/lTg4nRiF9PpjwpddjX
         cfU/FeqpjhUnOfTHOFsZcoITpPIDDaJTh949xUt77A4OPz6o80YkxNImjAJSfEQhlCMl
         jn+Q==
X-Gm-Message-State: AOAM531vqMb1zDecVUMUGAFv7huQOygBK3yK2Ry0pfopx+rryEvY0LaE
        aBpvLXCIRnp8HPerzGFfKMk7s1chqNs9
X-Google-Smtp-Source: ABdhPJw6OPs/uVtSZcBHz2FT9mMKID2FZjmYHAS3+H7DjT1NQh+6pBz5N57c06RrZ5Z9R23LI2a6wH+Ktal4
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a25:cb01:: with SMTP id
 b1mr1683727ybg.236.1621938611056; Tue, 25 May 2021 03:30:11 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:34 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.5.I8353f22ae68a7e5ed9aaa44a692dec6d11bcb43a@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 05/12] Bluetooth: use inclusive language in L2CAP
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "central" and "peripheral".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/l2cap_sock.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3c4f550e5a8b..1f5ed6b163af 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -89,7 +89,7 @@ struct l2cap_conninfo {
 };
 
 #define L2CAP_LM	0x03
-#define L2CAP_LM_MASTER		0x0001
+#define L2CAP_LM_CENTRAL	0x0001
 #define L2CAP_LM_AUTH		0x0002
 #define L2CAP_LM_ENCRYPT	0x0004
 #define L2CAP_LM_TRUSTED	0x0008
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c99d65ef13b1..9080d001a03a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -503,7 +503,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		}
 
 		if (test_bit(FLAG_ROLE_SWITCH, &chan->flags))
-			opt |= L2CAP_LM_MASTER;
+			opt |= L2CAP_LM_CENTRAL;
 
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			opt |= L2CAP_LM_RELIABLE;
@@ -807,7 +807,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		if (opt & L2CAP_LM_SECURE)
 			chan->sec_level = BT_SECURITY_HIGH;
 
-		if (opt & L2CAP_LM_MASTER)
+		if (opt & L2CAP_LM_CENTRAL)
 			set_bit(FLAG_ROLE_SWITCH, &chan->flags);
 		else
 			clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
-- 
2.31.1.818.g46aad6cb9e-goog

