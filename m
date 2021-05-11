Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D39379EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhEKEoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhEKEob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:44:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78735C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:43:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso446119wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pOfhSU30/+74TWykEgYzzcECzknBZN+gG9Fp9jV4LM=;
        b=nh8fG27gkiOXB9Nd6Ql5AKT5b4yZ4SDOzi0e2MCZrznnSTBwvbi3UvjCMFYtvSaa5e
         T5aL7BE9xtRQRhLITeB3qJFmGhMcI2W79nl6PLA8YvU4Mhhm1zyShXvMLKwy62DHATZL
         deNH+G75y8mvkk3t3ZPupo6Mop+VgxQ1XhVfVkLLJ6lonX3bRpoevXYxsuFmxrfwQWNC
         9V/KziU2Eu967HWhLsQJq/0+fpFxuiw3xvw7fZo5uiMybxBVxXT2SxRxDVKSGKstA2jh
         OhohXmo5shuPLwlqD7ikkEvUQiQjGWXdUEAqvLWNSoHSAYPK/hzkqwIiwmg4gmZFxMaq
         pF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pOfhSU30/+74TWykEgYzzcECzknBZN+gG9Fp9jV4LM=;
        b=SfcT9dTO5iyc3WTMDHlMfc7LgV5+rNEAi9utvDF3C5aEY1H5eNzpYrs32o88ncQaHq
         A0ITNZ0QWoxUXchRMhox+b1CX/VMsQFeEt7iKbx5MY5i4cwzKZSv/A7Jpo63YaFj4cW2
         wyf3oGXjwRUswz+18Sc+AGy+JfaskB7J+vpSMjd3YeF8eVi+lAPFMick/yF4ivZ6u1Ek
         UuepGfUcugfxEyJWky8HqmhJeKngEEC46UprdMO6XDops55iCkObydg8rZ7agKslQN/V
         3BhAVJx8fwuFOs940IromtknilQl50utTEzNHe245nSVue0oAIjrDG/PB4+pBzM6Vq2Y
         priw==
X-Gm-Message-State: AOAM532xNirCvjG7K8N/pfC0GjBD4GmF5qqzBwDJ3axkcL2Hm5D5VruW
        1kCnAKph+fCYl15G8LbK0kEnNw==
X-Google-Smtp-Source: ABdhPJxz2fUN2Ek72KoGClY3cxAT8P1LdAZMCqfO5EoKr2QEdfTvTaJ0vok4Mb2bs3QB8c0H7KV+3A==
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr2960343wmc.81.1620708204150;
        Mon, 10 May 2021 21:43:24 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
        by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:43:23 -0700 (PDT)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com
Subject: [PATCH 3/4] tun: define feature bit for USO support
Date:   Tue, 11 May 2021 07:42:52 +0300
Message-Id: <20210511044253.469034-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511044253.469034-1-yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User mode software can probe this bit to check whether the
USO feature is supported by TUN/TAP device.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/if_tun.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..24f246920dd5 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -88,6 +88,7 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO	0x20	/* I can handle USO packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.26.3

