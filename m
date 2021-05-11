Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE6379EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEKEof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhEKEoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:44:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C470C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:43:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n84so10351200wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9XpXxYtaOMpWOUjJ4wuUSOsoeZftgUi9oWw6L6+6PY=;
        b=i8N263f+uXxe91WLuxJx5RvGTcU+LOlIZILGfgaQzBDs6R/OaZ26o9Jduve+32BvM0
         SBW5jvdKVYeAZmZN2gJYZTbusqcxDTTC15Lpii1SMDeN7urjfzM0n4B6AIEXRELudkAm
         ONRljjTtiItJ/VZma2gKCNrnXZ4b4XK0kHPXfxOYFa5/HwbafB07Xt0fVqX7vfPtpn9d
         fMPog8BUQcwL0WZCqE/LfaVSMRv8ythODRvoqifUAjufxR7YfIiFvybGHoR/pVpoGsAj
         zjKpR1k5AeoLdOJ3xV/+lVo6WQMDN+ca4vpe7dLYnfXjH5BFwWj+7ZyGtcbGLngURzZD
         Vi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9XpXxYtaOMpWOUjJ4wuUSOsoeZftgUi9oWw6L6+6PY=;
        b=L6Sdwv9cmtg5ULgpc+dr51zq4PJvAPj8a4nhJd6tiggNVC4jr8ayLO26NefgCw2s53
         9W4hdkrpBvUcPnsVfsZRmUTPM8jLXyxIthknbqRJA/sKesdeikYXjZJP1q68fxuHWF/9
         /LrlWMpKejg8o372uH0wirgyqzpOxeWqqgocmlnWaMzdtyfQxeNPuw4+CS5vsUnlb4rq
         cyuFf3mJTWGTbhotwG9zqNUyMLT+HVOg5DJyKczw1Z3uFvwrNKvzJa9UX7rK8DlL7CUm
         D7KyUTpXUhVKiPF+HGcjj/rsXP1xZ1bA8mag9jgvh653muF/ncgwy85hirRUKBXYlRHa
         mi5w==
X-Gm-Message-State: AOAM531yLHsBA+mnhxx9iWxGa6FBfGDfUfTdIT0uRWFqhZvJBuSxq7gq
        qFCd+Kb0cubFU1GW+Hhs4qglCg==
X-Google-Smtp-Source: ABdhPJyQk9PXGY/kEfZFu3FcsyaZ0+l7hvZVvgX/jf5mBiF4QiF5aERcUZgxITkN4JxfM3z5J6nLRg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr3023530wmh.102.1620708202793;
        Mon, 10 May 2021 21:43:22 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
        by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:43:22 -0700 (PDT)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com
Subject: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on the host
Date:   Tue, 11 May 2021 07:42:51 +0300
Message-Id: <20210511044253.469034-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511044253.469034-1-yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large UDP packet provided by the guest with GSO type set to
VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
packets according to the gso_size field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/virtio_net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b465f8f3e554..4ecf9a1ca912 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			ip_proto = IPPROTO_UDP;
 			thlen = sizeof(struct udphdr);
 			break;
+		case VIRTIO_NET_HDR_GSO_UDP_L4:
+			gso_type = SKB_GSO_UDP_L4;
+			ip_proto = IPPROTO_UDP;
+			thlen = sizeof(struct udphdr);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.26.3

