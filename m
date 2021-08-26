Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0F3F8F14
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbhHZTrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhHZTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:47:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5629C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:46:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v126-20020a254884000000b005991fd2f912so4147702yba.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DtVfB4PW2V3DweZCFf7FYikSWXiEgJqwXsDfUyooD1g=;
        b=vXf2flB4ERZVpYjK0ccWsm1yUxMMZKcnwCV9+Zdw14JWkLR4/XAQNH8HuBFdtBlcca
         vGxBtMD+T4TjanPwzafrH0eUMZ/kqVBm29XlykzJCYa43kdHJiPVSxmvq4jxJqGE9g5R
         rxoF3O/7u/nGBD0h9RhYBlzhOGAs+Imc3WkY4uiLJz4EQrHo6LllEO3D3Z7ZnldY5+uH
         18pDjveCZsn8AJimuTgeIM7kgKDx/0hV73Yg0XIi2eQuseDpXnhJISHV0tg3SIuD6z+u
         ESi8ZVeIG9cm59YUTwA4ggjXmxOcj+AuCHIGFbEwBW5x9CGzfhYhggV6SyPFTT/k0gql
         cRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DtVfB4PW2V3DweZCFf7FYikSWXiEgJqwXsDfUyooD1g=;
        b=DdkgJ9on4MPUy2IO15CHDwn9GzSZ+w+zIMgKyVNgH4keQmzRBca82BjffLc+LkPyg6
         /QGIvD5szboICVW3jg0CbDtIVWqMbhRFuMyfMs861d4Y7J2hSA3sIm2oZRjV4NBijmXf
         uzuCnNDupcwbtr2IpvRp6gIGuj4ny96yhtKI+2rVrI6aVmw728YaUv0Nj9S7olMMuP/o
         uzvaa2H7rJLqBrw/mZan1PL1T9KCd+c3KSa4Dayq9ZM4LoyGM6R9kFaPEcWijIL9XOcd
         xWE4m3dkiBvGQmveuaoxhhzTiLBhG7N1Od1E+yCAi6xfU6M9MPW+vdKQcu7aJk3xZfJt
         pgQA==
X-Gm-Message-State: AOAM530zIA5JPzFdOviIp0rmtFct2qOxvIc8OcrKylRj43yxX6jTG5nk
        iZzLhFQr9LdpXAD4cK37RwAocSA=
X-Google-Smtp-Source: ABdhPJx9ol3ordEj6PPzAnx7l+OotOHE0DxgD3PH9pSnwiz7wEOMOYF8qDynnbF2EjfEBxrF+6OicA4=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:beb:3e71:94d0:cf9])
 (user=pcc job=sendgmr) by 2002:a25:bb12:: with SMTP id z18mr491034ybg.492.1630007171948;
 Thu, 26 Aug 2021 12:46:11 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:46:01 -0700
Message-Id: <20210826194601.3509717-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2] net: don't unconditionally copy_from_user a struct ifreq
 for socket ioctls
From:   Peter Collingbourne <pcc@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common implementation of isatty(3) involves calling a ioctl passing
a dummy struct argument and checking whether the syscall failed --
bionic and glibc use TCGETS (passing a struct termios), and musl uses
TIOCGWINSZ (passing a struct winsize). If the FD is a socket, we will
copy sizeof(struct ifreq) bytes of data from the argument and return
-EFAULT if that fails. The result is that the isatty implementations
may return a non-POSIX-compliant value in errno in the case where part
of the dummy struct argument is inaccessible, as both struct termios
and struct winsize are smaller than struct ifreq (at least on arm64).

Although there is usually enough stack space following the argument
on the stack that this did not present a practical problem up to now,
with MTE stack instrumentation it's more likely for the copy to fail,
as the memory following the struct may have a different tag.

Fix the problem by adding an early check for whether the ioctl is a
valid socket ioctl, and return -ENOTTY if it isn't.

Fixes: 44c02a2c3dc5 ("dev_ioctl(): move copyin/copyout to callers")
Link: https://linux-review.googlesource.com/id/I869da6cf6daabc3e4b7b82ac979683ba05e27d4d
Signed-off-by: Peter Collingbourne <pcc@google.com>
Cc: <stable@vger.kernel.org> # 4.19
---
v2:
- simplify check by using _IOC_TYPE()
- move function inline into header

 include/linux/netdevice.h | 4 ++++
 net/socket.c              | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eaf5bb008aa9..d65ce093e5a7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4012,6 +4012,10 @@ int netdev_rx_handler_register(struct net_device *dev,
 void netdev_rx_handler_unregister(struct net_device *dev);
 
 bool dev_valid_name(const char *name);
+static inline bool is_socket_ioctl_cmd(unsigned int cmd)
+{
+	return _IOC_TYPE(cmd) == SOCK_IOC_TYPE;
+}
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		bool *need_copyout);
 int dev_ifconf(struct net *net, struct ifconf *, int);
diff --git a/net/socket.c b/net/socket.c
index 0b2dad3bdf7f..8808b3617dac 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1109,7 +1109,7 @@ static long sock_do_ioctl(struct net *net, struct socket *sock,
 		rtnl_unlock();
 		if (!err && copy_to_user(argp, &ifc, sizeof(struct ifconf)))
 			err = -EFAULT;
-	} else {
+	} else if (is_socket_ioctl_cmd(cmd)) {
 		struct ifreq ifr;
 		bool need_copyout;
 		if (copy_from_user(&ifr, argp, sizeof(struct ifreq)))
@@ -1118,6 +1118,8 @@ static long sock_do_ioctl(struct net *net, struct socket *sock,
 		if (!err && need_copyout)
 			if (copy_to_user(argp, &ifr, sizeof(struct ifreq)))
 				return -EFAULT;
+	} else {
+		err = -ENOTTY;
 	}
 	return err;
 }
@@ -3306,6 +3308,8 @@ static int compat_ifr_data_ioctl(struct net *net, unsigned int cmd,
 	struct ifreq ifreq;
 	u32 data32;
 
+	if (!is_socket_ioctl_cmd(cmd))
+		return -ENOTTY;
 	if (copy_from_user(ifreq.ifr_name, u_ifreq32->ifr_name, IFNAMSIZ))
 		return -EFAULT;
 	if (get_user(data32, &u_ifreq32->ifr_data))
-- 
2.33.0.259.gc128427fd7-goog

