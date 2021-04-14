Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283B735FB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbhDNSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347067AbhDNSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AFFC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so17126443wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjSOcIkP7HU+hJW32cJVC9xveabWEBu3Za92UjOPz1s=;
        b=TbxKe2CMhG9WzPgb938VDOExBc+tsVltYu8edsWpAFbg6m3v0z3SFcZVPBGqNCAELO
         BRsF8TKhz7nhlUwJJM4+nfp5b+IepVHA5R3Cw6Iu2kort+PvrS5RAWnt3joc2QFasw3k
         YlV/2RXH9RCcpld9OYl/M3w8k+ryq+AkT5SD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjSOcIkP7HU+hJW32cJVC9xveabWEBu3Za92UjOPz1s=;
        b=qs++/SbhJLaqenD8knGOKMWmQN2gxGtMOGXiKqdi8c/3itLh0czcYtfu3DxaqZLwn2
         jEtCVxMGqc4o9jLSO0idOTBnmM0E4BiVB4PBfcpSHQiN9DzHPvxOns0MYlzbbGixAT4X
         dj1ewvv0kcoE0xb2suxBE1YmU9MKBKgN9Ke//TvGDe1V9HkAn4fel1WI22l0MewX9dO+
         vzrJJDPInpwNNhLkDhVuoYL9k1clikVb75EGZvoKeYzX7nuPWLYZodb0xcO7knIJOzET
         7iqHbjK5GDfU1XnBt2P4DTMd6PrTgTVrDAp3u/yvdOzPe3utbDidPe3qLBjpYT8/HcRH
         ymDA==
X-Gm-Message-State: AOAM530KYxYa75MGhFZzQ/U2yPIHrE4/CHuUq0FWqrDDPekPQXguZXxa
        8knMssbU8qz4n7Jq0asnWEW+QQ==
X-Google-Smtp-Source: ABdhPJwGQvldUX7Vj4jq3AenVbQeEctmDCdmow8m/KVL5lo6noedXfxcLlCEs486Vl03GpFGUa5u4Q==
X-Received: by 2002:adf:e901:: with SMTP id f1mr12404249wrm.44.1618426457275;
        Wed, 14 Apr 2021 11:54:17 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:16 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
Date:   Wed, 14 Apr 2021 20:54:02 +0200
Message-Id: <20210414185406.917890-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This type provides the guarantee that an argument is going to be a const
pointer to somewhere in a read-only map value. It also checks that this
pointer is followed by a zero character before the end of the map value.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77d1d8c65b81..c160526fc8bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -309,6 +309,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
 	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
+	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	__BPF_ARG_TYPE_MAX,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 852541a435ef..5f46dd6f3383 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
+static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
+	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		err = check_ptr_alignment(env, reg, 0, size, true);
+	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
+		struct bpf_map *map = reg->map_ptr;
+		int map_off;
+		u64 map_addr;
+		char *str_ptr;
+
+		if (reg->type != PTR_TO_MAP_VALUE || !map ||
+		    !bpf_map_is_rdonly(map)) {
+			verbose(env, "R%d does not point to a readonly map'\n", regno);
+			return -EACCES;
+		}
+
+		if (!tnum_is_const(reg->var_off)) {
+			verbose(env, "R%d is not a constant address'\n", regno);
+			return -EACCES;
+		}
+
+		if (!map->ops->map_direct_value_addr) {
+			verbose(env, "no direct value access support for this map type\n");
+			return -EACCES;
+		}
+
+		err = check_map_access(env, regno, reg->off,
+				       map->value_size - reg->off, false);
+		if (err)
+			return err;
+
+		map_off = reg->off + reg->var_off.value;
+		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
+		if (err) {
+			verbose(env, "direct value access on string failed\n");
+			return err;
+		}
+
+		str_ptr = (char *)(long)(map_addr);
+		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
+			verbose(env, "string is not zero-terminated\n");
+			return -EINVAL;
+		}
 	}
 
 	return err;
-- 
2.31.1.295.g9ea45b61b8-goog

