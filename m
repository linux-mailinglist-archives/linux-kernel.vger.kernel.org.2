Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B723827D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhEQJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbhEQJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8916CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so5190011pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAKd3OyxEh4mmO9GevrCZrnnlUerGwgW0JYf7aDqyQk=;
        b=v4jA397KTd916nncp6Q0kwrGC2kR5Mp5y+smC9h63YpQjbp+wrFV2mC6mTmwVCqL2S
         fCsFGdPEnyRO/6pwm/sWGXo9NtftFfstgcjx3GeRPNXtTpIqOi964C/+ZzX7E6OHaTR6
         CoeY+cWt/0zw8nIXcueTdzkLZLoOGMlop4RuFjzeDWBTOY0Uft/VWxkfw5yNisDmB1Yt
         kuhghximqBr85BuqYYu3eJGoVT1OMG2Jwsrm2jwL9jCAqUddI+pv6xQiafZ4p21UIrsW
         DvPn9lGRNN+zf93361Q1Vuw6aX8InIt2tTBSIvYoRQ7vSoIAXJii3ZOHKVCAdk2DxUwS
         yt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAKd3OyxEh4mmO9GevrCZrnnlUerGwgW0JYf7aDqyQk=;
        b=eH1mDYac4u9SdyHg2WytivfQhGNoZg5sgbvMa0+Tz8W0VK18pargkOpNQp1Y6tQeQJ
         ObdGyQzVywds4vLgFbvBvJd19iaF3CzMbqsieQkZjxh0fxEzR0fdL1nmzZGY3Bv/MuEO
         dzZP3oG6d9HTf7q4sE2cPurcEt8H6AcY7RoIJKKSQDhDCLVoLsDrTG5Jqz3Z+RX9m7cX
         3S/iD7crteYB3azS3+p1kOWrfqN43PpZilN8ZynR1VbtSdoKSQqKRogZoOws7B86CzPN
         qkbu85X9GcrKkZmqQcqiwq602WBk3x9XTbUCc0k052+Cmg7o5ohyA1p9EmoePnSkpclt
         HJYw==
X-Gm-Message-State: AOAM530nyyYwcGrT9OL3ZpXbYRUs7RWoWY690EtlHOt31ROAk1ERks68
        bB+XxmRdpHCiNJsrKFJ5qi/w
X-Google-Smtp-Source: ABdhPJwfDGapWBBdxdvM0VhVkVPWBSyK8Lo/GUWhfAsrHRQkO/RqhVBx5pz48JLUiE+QysPoGT2TpA==
X-Received: by 2002:a17:902:7c0f:b029:ec:f5e2:4442 with SMTP id x15-20020a1709027c0fb02900ecf5e24442mr59572696pll.81.1621242556107;
        Mon, 17 May 2021 02:09:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x23sm14665889pje.52.2021.05.17.02.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:15 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/17] crypto: virtio - Remove unused used length
Date:   Mon, 17 May 2021 17:08:23 +0800
Message-Id: <20210517090836.533-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used in some cases. Let's drop it
and pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 583c0b535d13..818fe31ace38 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -118,7 +118,6 @@ static int virtio_crypto_alg_skcipher_init_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
-	unsigned int tmp;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
@@ -176,7 +175,7 @@ static int virtio_crypto_alg_skcipher_init_session(
 	 * Trapping into the hypervisor, so the request should be
 	 * handled immediately.
 	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, NULL) &&
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
@@ -206,7 +205,6 @@ static int virtio_crypto_alg_skcipher_close_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, status_sg, *sgs[2];
-	unsigned int tmp;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
@@ -245,7 +243,7 @@ static int virtio_crypto_alg_skcipher_close_session(
 	}
 	virtqueue_kick(vcrypto->ctrl_vq);
 
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, NULL) &&
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-- 
2.11.0

