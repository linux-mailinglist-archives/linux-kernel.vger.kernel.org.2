Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E535FB29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353199AbhDNSyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhDNSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB60C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g9so4838087wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02rH8j18HI7w3K9ctpKHrAP8l+m0QtMpOV2ueTMO9Eo=;
        b=PNLAVNgKlqDa+IkQ0Xh6wo7O2niLrB3epUfcWgqebVSZ7pIsG23rkRPXunXDQqJv11
         u5Rn59l5X7nNNDbYvBkD0QK08DEtYfFQJ4hDaqvXStRy3u8vXZsSSwA5hQGoryY/wb5y
         WvyTQHQ2IjdgYMWae9ZJv6MiW6hN6TsfnRab0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02rH8j18HI7w3K9ctpKHrAP8l+m0QtMpOV2ueTMO9Eo=;
        b=A1HfGKtJBxj/kTNs6ox/pXFR2sL4STVDiJT/d5QbZ2oTAYKHYLYHB6eu0ZmmHQHknK
         +yVlWkMJBhuAt7M5QX9Hwgplp0BHl3TDhaljObowKMUVBmpiIQ8CMkOpit+mjV31H3+0
         PLZI53q60nvZ0NKrsIADH2FBogPSm1TX45U45IEqrDRv1HOoWptHw934wfSKMhI8OZjQ
         8d3DZYK1OPQjOtOr3ULOv4DLnIgLH1g6TygrB0ABriljEtXX0crNqD86Z6TE8E/V443z
         QKXqlPoW6Fgh9WTNYK+L0oeb+dCNRZ1nv154Hz8XKsP6GMXsAEqDky2u2aModLMh0DJT
         wScQ==
X-Gm-Message-State: AOAM5323PPBro6pNNWupameNecJMZpLSu7OtSA1LLvxTk/owhOWazCKG
        mgpO8yF4McOn65AVSmatg4oKNw==
X-Google-Smtp-Source: ABdhPJzI7TyA6dZ+LCdCfsNVJgfSmPUxRVdqX73Gb02fMydkTRCypZ2D0I0FUjR+4YK8xWT2mO6vYA==
X-Received: by 2002:adf:e809:: with SMTP id o9mr32618426wrm.25.1618426458128;
        Wed, 14 Apr 2021 11:54:18 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:17 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 3/6] bpf: Add a bpf_snprintf helper
Date:   Wed, 14 Apr 2021 20:54:03 +0200
Message-Id: <20210414185406.917890-4-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation takes inspiration from the existing bpf_trace_printk
helper but there are a few differences:

To allow for a large number of format-specifiers, parameters are
provided in an array, like in bpf_seq_printf.

Because the output string takes two arguments and the array of
parameters also takes two arguments, the format string needs to fit in
one argument. Thankfully, ARG_PTR_TO_CONST_STR is guaranteed to point to
a zero-terminated read-only map so we don't need a format string length
arg.

Because the format-string is known at verification time, we also do
a first pass of format string validation in the verifier logic. This
makes debugging easier.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 28 +++++++++++++++++++
 kernel/bpf/helpers.c           | 50 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 41 ++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++
 6 files changed, 150 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c160526fc8bf..f8a45f109e96 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1953,6 +1953,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
+extern const struct bpf_func_proto bpf_snprintf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index df164a44bb41..ec6d85a81744 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4708,6 +4708,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **str** buffer of size **str_size**
+ *		based on a format string stored in a read-only map pointed by
+ *		**fmt**.
+ *
+ *		Each format specifier in **fmt** corresponds to one u64 element
+ *		in the **data** array. For strings and pointers where pointees
+ *		are accessed, only the pointer values are stored in the *data*
+ *		array. The *data_len* is the size of *data* in bytes.
+ *
+ *		Formats **%s** and **%p{i,I}{4,6}** require to read kernel
+ *		memory. Reading kernel memory may fail due to either invalid
+ *		address or valid address but requiring a major memory fault. If
+ *		reading kernel memory fails, the string for **%s** will be an
+ *		empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
+ *		Not returning error to bpf program is consistent with what
+ *		**bpf_trace_printk**\ () does for now.
+ *
+ *	Return
+ *		The strictly positive length of the formatted string, including
+ *		the trailing zero character. If the return value is greater than
+ *		**str_size**, **str** contains a truncated string, guaranteed to
+ *		be zero-terminated except when **str_size** is 0.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4875,6 +4902,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ff427f5b3358..9a58518d72dc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -923,6 +923,54 @@ int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	return err;
 }
 
+#define MAX_SNPRINTF_VARARGS		12
+
+BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
+	   const void *, data, u32, data_len)
+{
+	enum bpf_printf_mod_type mod[MAX_SNPRINTF_VARARGS];
+	u64 args[MAX_SNPRINTF_VARARGS];
+	int err, num_args;
+
+	if (data_len % 8 || data_len > MAX_SNPRINTF_VARARGS * 8 ||
+	    (data_len && !data))
+		return -EINVAL;
+	num_args = data_len / 8;
+
+	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
+	 * can safely give an unbounded size.
+	 */
+	err = bpf_printf_prepare(fmt, UINT_MAX, data, args, mod, num_args);
+	if (err < 0)
+		return err;
+
+	/* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
+	 * all of them to snprintf().
+	 */
+	err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
+		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
+		BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
+		BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
+		BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
+		BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
+		BPF_CAST_FMT_ARG(11, args, mod));
+
+	bpf_printf_cleanup();
+
+	return err + 1;
+}
+
+const struct bpf_func_proto bpf_snprintf_proto = {
+	.func		= bpf_snprintf,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_PTR_TO_CONST_STR,
+	.arg4_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
@@ -1011,6 +1059,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_probe_read_kernel_str_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f46dd6f3383..994ef36c5f60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5918,6 +5918,41 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
 
+static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
+	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
+	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	int err, fmt_map_off, num_args;
+	u64 fmt_addr;
+	char *fmt;
+
+	/* data must be an array of u64 */
+	if (data_len_reg->var_off.value % 8)
+		return -EINVAL;
+	num_args = data_len_reg->var_off.value / 8;
+
+	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
+	 * and map_direct_value_addr is set.
+	 */
+	fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
+	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
+						  fmt_map_off);
+	if (err)
+		return err;
+	fmt = (char *)(long)fmt_addr + fmt_map_off;
+
+	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
+	 * can focus on validating the format specifiers.
+	 */
+	err = bpf_printf_prepare(fmt, UINT_MAX, NULL, NULL, NULL, num_args);
+	if (err < 0)
+		verbose(env, "Invalid format string\n");
+
+	return err;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -6032,6 +6067,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 	}
 
+	if (func_id == BPF_FUNC_snprintf) {
+		err = check_bpf_snprintf_call(env, regs);
+		if (err < 0)
+			return err;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a13f8644b357..2a8bcdc927c7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1076,6 +1076,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index df164a44bb41..ec6d85a81744 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4708,6 +4708,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **str** buffer of size **str_size**
+ *		based on a format string stored in a read-only map pointed by
+ *		**fmt**.
+ *
+ *		Each format specifier in **fmt** corresponds to one u64 element
+ *		in the **data** array. For strings and pointers where pointees
+ *		are accessed, only the pointer values are stored in the *data*
+ *		array. The *data_len* is the size of *data* in bytes.
+ *
+ *		Formats **%s** and **%p{i,I}{4,6}** require to read kernel
+ *		memory. Reading kernel memory may fail due to either invalid
+ *		address or valid address but requiring a major memory fault. If
+ *		reading kernel memory fails, the string for **%s** will be an
+ *		empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
+ *		Not returning error to bpf program is consistent with what
+ *		**bpf_trace_printk**\ () does for now.
+ *
+ *	Return
+ *		The strictly positive length of the formatted string, including
+ *		the trailing zero character. If the return value is greater than
+ *		**str_size**, **str** contains a truncated string, guaranteed to
+ *		be zero-terminated except when **str_size** is 0.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4875,6 +4902,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.31.1.295.g9ea45b61b8-goog

