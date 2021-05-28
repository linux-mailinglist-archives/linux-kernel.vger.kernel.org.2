Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9473946B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhE1Rzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhE1Rzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:55:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3350C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:54:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so4960733pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANKlONzWohdov+6WuLPhtLq95Lmabba/pjDXictlH4k=;
        b=mByhbx9uR7qw3+5csFqtiBmrny5PUErxiaumYIELRBs8Ijs/xcNtiUowTW2QHmGhSS
         cI906VAtactPrTU8A5fjRUAOM3qGcxGnnCAZif3JnDahkLLSXlaD6hYXARYKqVrgOcdj
         leokyJOXneOJp2VKYjLGXrQaxUHzBF7YT+bGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANKlONzWohdov+6WuLPhtLq95Lmabba/pjDXictlH4k=;
        b=XHsY+/HHGaXUQjldXC0bQaIGD/siVdDv/ZI2aPIKieuEJxY0ItITCpe0z/9JQft0sb
         inq0q5PORudTlL0L2mhfH2wNXP+bEP+Ve/2JaZ5GINp5vs64Ea7OrLeaPrDvXIDxemRk
         6l95xGieJKF703hZhhPBcPQtSDZXjTNcSztQJtXz2sNXfKHpoTnYRLV8DzYy6rlxCrKO
         kyFJCemTnW1wrFdDuBFpW0eyKNyLKkEIFr7fREyYuqzqeXJlJnORfGg+pAZg24/kzruH
         KiNiU0M3T3tMtnhlBbrIy834ttybX9rSvpxWTX8ov6LCXFH0N/6yeDx7/4dmHn/SEGIH
         w75w==
X-Gm-Message-State: AOAM5328G4A2OO6qrpyDsaJL2nGvmAfUrVpsbUePM337YJfzGqt2H7h0
        okoQtpXK4cPtVSRozZFH/LCFUw==
X-Google-Smtp-Source: ABdhPJxV6f94zLFz54LqBFWRmHCGWw+arAdFtXMyPPRV1EjRN1cZPZzO5qd5b8pWXki+rqrAZBOCqA==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr5626405pjq.173.1622224446120;
        Fri, 28 May 2021 10:54:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm3292699pfb.114.2021.05.28.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:54:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Tsai <martin.tsai@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Avoid HDCP over-read and corruption
Date:   Fri, 28 May 2021 10:53:54 -0700
Message-Id: <20210528175354.790719-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; g=4cf2a0636c89416b735d9eedea1837894110975d; i=GPlLtkYl4Vl/u1+SgJBiTZwrwkUA3g5q8nhHlBK0VMY=; m=/B+IjR5hEpc1KZKXt3rRQHZHXjtNP00Y56rODzGI5ak=; p=3dO8lx4rI19NbM9CeLbNSicq/6IC+kqbqEuhiYMdAzI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCxLjIACgkQiXL039xtwCa1kA//VV0 eUIrl0DGPwzFYYACM0z9ElR4Sni6kHJQADmYI0oV5GXqxqVYMpTOwMjuLPhiZb5RDObC+tyj9MgKv GYhx8bIT2X7tztY4aHUpJ0HfPt+sjSzOMvgkLb0F7SOpSxgYp4AJ+aMRp5NUYpcTAZnOKN4k3J1/h ojMvo9Y3WX7DIw00WJC6CkgAdNxYretO1gpNmTRnW89KAHaQEpdn9LECYebozdVB122FFCH0qBnre 5g5wbM2tAH8O3n4alGiQyEbJa16AdWazV8DBYP5YvrDc4dQnMtM1UXXE9K4ZuZPBokx93Av+jfJX6 N6xrqXcuspSluMjJxe89+6CwyIqrhVWpEFmjtPaPVVDamEYmIYIX4TwahDu93x5Dvb2mP7tSMsRkx wmjZw/rRcxlkeBYHJKekTmYsZepdREXApoxWTAtbHU4eoQkU7nfUwo3Nl1s7SaKHVQcLSGCAZPGUW I95pVsNvURFGjSoSoH7rKGZnENTPIRnNadOpwYwigFku5mSKE+P5jflW2UzmUxPIHPH/4ABZ1GVLS KqooaDCaBF2czw5/41fq3U/e9Pf+lhbxe+IbHd8+lf9iQC7AHePUogh5hWgrALi8JUqKBX/Nz8wDn j2v2QxS+8Q+4Hp0egW8y3Sl12DkukVrhY5EDXYZKy0KgS7HgBmJCE9Z1qF1OpDoc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of reading the desired 5 bytes of the actual target field,
the code was reading 8. This could result in a corrupted value if the
trailing 3 bytes were non-zero, so instead use an appropriately sized
and zero-initialized bounce buffer, and read only 5 bytes before casting
to u64.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 2cbd931363bd..6d26d9c63ab2 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -29,8 +29,10 @@ static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 {
 	uint64_t n = 0;
 	uint8_t count = 0;
+	u8 bksv[sizeof(n)] = { };
 
-	memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(uint64_t));
+	memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
+	n = *(uint64_t *)bksv;
 
 	while (n) {
 		count++;
-- 
2.25.1

