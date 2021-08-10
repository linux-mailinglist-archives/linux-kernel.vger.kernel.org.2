Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF53D8029
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhG0VAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhG0U7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD7C06136D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:59:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so6659026pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDdnY+YZl5Kj4vlDFYwtmRw0qFCH7bvuzf5iZ5S7r+8=;
        b=Ky1aXIwN1k41XNVRUwHMb6gd8jWZQFtJbLhgYFrZRI/tEfjurJ/VltSyM8tcEHx7PU
         0hed7yoPtFdsfCcNmpZtry+48YfXQD9RicNrcpeyhhFCOPPT1fCJV/zFbOiKnPbf/PYX
         Cl3z+nnp3Cgm7D+0MY0+hinI4DYe7xo2z+8ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDdnY+YZl5Kj4vlDFYwtmRw0qFCH7bvuzf5iZ5S7r+8=;
        b=KTWkxTNjxMtS5VO8+k45orkiPaHS2/i/L+FXdefQwGzE63MudpN21zUHECqX2ncr7w
         3fRS1dkEsxVcVHjyK9tPxYdOkO1tKE8lRoInfmopY4T0TJsmoZKN4P4y7eD17K1qYlul
         a9e7G4TjJjTxxDY9f62wrsvI9RM+eBX5JIblXIfu5ASjFN/cTXKQZz6AYLLvFtbFUvHo
         l0AhKNHTPxTEA6pLs5m88EQmdFaVqCNAkz02rTUzyjwAHDDPjJjpwRVtXjwD8YA77f5E
         RA0SakN4szlLPjzGD+VuPq019ohpdydrjhp0ifzTQtMcjCXfFfkZN9qBv5ZfEUfAEiA2
         JawA==
X-Gm-Message-State: AOAM530No0qa9jJvPux9lzbWXPxHjaRbplrnePM6avBCIYy8yJRUHrnx
        g7rPweWRwOhxJ2jD/6jFlrydNA==
X-Google-Smtp-Source: ABdhPJzSgpKelqVCgUS+uWdh9X6zo2G6UcQ1toddE+js+YzGJwbaJ49IIj997nZ3+Sx8eXpefD//mQ==
X-Received: by 2002:a17:90b:4016:: with SMTP id ie22mr20891551pjb.68.1627419551082;
        Tue, 27 Jul 2021 13:59:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w23sm4741144pfc.60.2021.07.27.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 12/64] mwl8k: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:03 -0700
Message-Id: <20210727205855.411487-13-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; h=from:subject; bh=oMSi3M1NOKgRYRJy6VWRMVEHsL86zQNiB3Lk1k+Xi3A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOCT3IlQZfHOrT/8AVoJNmOyRzR+nRudQyIVPi9 N+VgYJGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzggAKCRCJcvTf3G3AJvUtD/ 0VbZh1+apSqCt8UVVwcwz2SVJuqIVyUnd519aTLQ4I0CWMg8ghFTFnOrvuarCaRIX9zFlryZ3tW+jX TMbwvZJ2ASxTPhSxhEfUL3QjPZrscW1XTamKCXRYrFlctVtUxvJxBanAbD684+pmZo0R/nRcYbYP4L IaH2t5hZmvXcLZRQNyAWwGbdKj5zwyQ23qv/nPVNIDcAqdEm3B1gePnEkp/AsshevL2Rz+m/fA/waN DoEtXkNfhfzWoBpKH83gEDokctcvbaP61CQNZaHqbrHd42zmm2Oc/L/stpbIFWa1W2nh9aTJnw2eN4 2nGcQV7d5s0ULa0BhMCoAn0It3bg3KRnOhK037W8DLo8xFDdcqrxT2qzTKD2J5OaeXZHiNPwPbqUFX h/rZBBfQpN75s58FT+3GvmfMf0Y3Hv3frdpG1OXwpfoLVNK+i9yfiGVN69Ddw4Vdy4v/ae2+T+RY3I BVx0+IUN5Kq5oxAJN8czvd3TMtxtYody0FwrPyZ7k/WqBEg6tfrvE6hNlpKZnEjPkmVUZchWsXtBld c8xMtYaeMn/Q+ACu7/A1Y37jNDWcrPB3t/Vt7rmllooif7lGJWBfAoYlw+trqmygT+AGb1sFup/d90 nRs6XYpT6hUE8tDXo21HFYgvJz1bZdvxgX5sz4WXpYQlhqmDB5NJxHOXSm8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct mwl8k_cmd_set_key around members
key_material, tkip_tx_mic_key, and tkip_rx_mic_key so they can be
referenced together. This will allow memcpy() and sizeof() to more easily
reason about sizes, improve readability, and avoid future warnings about
writing beyond the end of key_material.

"pahole" shows no size nor member offset changes to struct
mwl8k_cmd_set_key. "objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/mwl8k.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 3bf6571f4149..a29277d5f9da 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -4225,9 +4225,11 @@ struct mwl8k_cmd_set_key {
 	__le32 key_info;
 	__le32 key_id;
 	__le16 key_len;
-	__u8 key_material[MAX_ENCR_KEY_LENGTH];
-	__u8 tkip_tx_mic_key[MIC_KEY_LENGTH];
-	__u8 tkip_rx_mic_key[MIC_KEY_LENGTH];
+	struct {
+			__u8 key_material[MAX_ENCR_KEY_LENGTH];
+			__u8 tkip_tx_mic_key[MIC_KEY_LENGTH];
+			__u8 tkip_rx_mic_key[MIC_KEY_LENGTH];
+	} tkip;
 	__le16 tkip_rsc_low;
 	__le32 tkip_rsc_high;
 	__le16 tkip_tsc_low;
@@ -4375,7 +4377,7 @@ static int mwl8k_cmd_encryption_set_key(struct ieee80211_hw *hw,
 		goto done;
 	}
 
-	memcpy(cmd->key_material, key->key, keymlen);
+	memcpy(&cmd->tkip, key->key, keymlen);
 	cmd->action = cpu_to_le32(action);
 
 	rc = mwl8k_post_pervif_cmd(hw, vif, &cmd->header);
-- 
2.30.2

