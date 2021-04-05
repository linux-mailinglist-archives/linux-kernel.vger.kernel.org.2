Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E725F354197
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhDELgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhDELgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:36:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BCC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 04:35:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so10669952wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+de4bA16tFNApc6KdSUL7+Dp8lUiHF1huxsLEUsK9F4=;
        b=d2AaZ2XVp368bf6/eSoHTVhHsAqTTpvO8u2K0EtMrYoHrXOWkIeofBrlB3h95iHdDN
         LDXb1nxGf/ZmWKFBEWehu/UQi9sYQGjC3fR747gNbkuv7GVH7lpCXfr6VLgUieVmJlrx
         sE9EwIOKP8qyIyxehZdko9juThNsI6/tYWT6z6U94zj3ijzIMHeQeiP5CwSVGIBAkU17
         OUzb1ptQL2e69V5XngUoVK05ZJLz0NXByaUGykTnz+pQgIxtUtHk9t3AzJX37CiUl1e4
         tOQ7+1FE0qVgkgAnWNNnPK/nHsQDsWgJu/nnND3BwIdhrmOe5QvQyuQj3J7psbKaAx6F
         yhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+de4bA16tFNApc6KdSUL7+Dp8lUiHF1huxsLEUsK9F4=;
        b=HvvQP+0I/gFvh31qyz+RO2fvwaxXsfg0ZlBlmdAr7FX6sf6Wl+WNPN4DH7fnQcaM5a
         tt3zH4XdlFdH6zQSfDl7NrmPHUWRtMjIMgulXcQYISMrUNSgSGYGkO7Zy5ooQp/Sr4aT
         uRBgojOQyI58hZvDm/sMPQmUiGjDZ1IIUboEao+wllgS2AYRophMDehE3+nHGZT3ued9
         /eWkNx8R65aPPWRYPfJIy1LVXcxGsy7aXDBdg+2TDiYlXfgXfYs88CUxeNqlhZCo9b2s
         rl4yvVy+zNu9h76bT7VxndDUTPWqQNqFczgMewAkpy2Dwzj3mREEHrDUPrdirdk8p2hw
         Qcnw==
X-Gm-Message-State: AOAM531BZpsxt3ZzxOuFRrecxqCzhMa5coP4nPQ05aUs7Jr7uiHrpsmY
        DdeOC4oIIRi72GCo83yimsWG4w==
X-Google-Smtp-Source: ABdhPJzbtmOLyrxyBDXU+xSuOLy3nR0O2iDyPnivaun+pPt9LEq2QED6euUZRhQ506E/iiNAxAVwBA==
X-Received: by 2002:a05:6000:191:: with SMTP id p17mr29348547wrx.154.1617622558353;
        Mon, 05 Apr 2021 04:35:58 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m5sm12681107wrx.83.2021.04.05.04.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:35:57 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: tun: set tun->dev->addr_len during TUNSETLINK processing
Date:   Mon,  5 Apr 2021 12:35:55 +0100
Message-Id: <20210405113555.9419-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing type with TUNSETLINK ioctl command, set tun->dev->addr_len
to match the appropriate type, using new tun_get_addr_len utility function
which returns appropriate address length for given type. Fixes a
KMSAN-found uninit-value bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=0766d38c656abeace60621896d705743aeefed51

Reported-by: syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/net/tun.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 978ac0981d16..56c26339ee3b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -69,6 +69,14 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/mutex.h>
+#include <linux/ieee802154.h>
+#include <linux/if_ltalk.h>
+#include <uapi/linux/if_fddi.h>
+#include <uapi/linux/if_hippi.h>
+#include <uapi/linux/if_fc.h>
+#include <net/ax25.h>
+#include <net/rose.h>
+#include <net/6lowpan.h>
 
 #include <linux/uaccess.h>
 #include <linux/proc_fs.h>
@@ -2925,6 +2933,45 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
 	return __tun_set_ebpf(tun, prog_p, prog);
 }
 
+/* Return correct value for tun->dev->addr_len based on tun->dev->type. */
+static inline unsigned char tun_get_addr_len(unsigned short type)
+{
+	switch (type) {
+	case ARPHRD_IP6GRE:
+	case ARPHRD_TUNNEL6:
+		return sizeof(struct in6_addr);
+	case ARPHRD_IPGRE:
+	case ARPHRD_TUNNEL:
+	case ARPHRD_SIT:
+		return 4;
+	case ARPHRD_ETHER:
+		return ETH_ALEN;
+	case ARPHRD_IEEE802154:
+	case ARPHRD_IEEE802154_MONITOR:
+		return IEEE802154_EXTENDED_ADDR_LEN;
+	case ARPHRD_PHONET_PIPE:
+	case ARPHRD_PPP:
+	case ARPHRD_NONE:
+		return 0;
+	case ARPHRD_6LOWPAN:
+		return EUI64_ADDR_LEN;
+	case ARPHRD_FDDI:
+		return FDDI_K_ALEN;
+	case ARPHRD_HIPPI:
+		return HIPPI_ALEN;
+	case ARPHRD_IEEE802:
+		return FC_ALEN;
+	case ARPHRD_ROSE:
+		return ROSE_ADDR_LEN;
+	case ARPHRD_NETROM:
+		return AX25_ADDR_LEN;
+	case ARPHRD_LOCALTLK:
+		return LTALK_ALEN;
+	default:
+		return 0;
+	}
+}
+
 static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg, int ifreq_len)
 {
@@ -3088,6 +3135,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 				break;
 			}
 			tun->dev->type = (int) arg;
+			tun->dev->addr_len = tun_get_addr_len(tun->dev->type);
 			netif_info(tun, drv, tun->dev, "linktype set to %d\n",
 				   tun->dev->type);
 			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
-- 
2.30.2

