Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E863436898D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbhDVX5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbhDVX5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:57:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:56:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j5so45539537wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8D036QsY7GYftxsKacpjO/XIVUD2k3lhmMGNnQd+Y8=;
        b=Zd+26HtHAfUOl0+VDy8myB272bVaiz8OT9hUu5v/BdFLFKv6N4JMB5Rv5++sfEiVH7
         8xSpk13d5brnnhuEnagpj6i5XgNkkHOljRMepUfwVdtTn5M/KycVrAYLk1o4407Yl6uA
         WyHSiQctLmO3WEVPW4Jr3ybIFjczXIYMLdIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8D036QsY7GYftxsKacpjO/XIVUD2k3lhmMGNnQd+Y8=;
        b=idBaxq8u0sVioCk0sYXOZ/QnfUzyu7tmbg/CidqIKGlnYFK7j5kHmJrhIqJvpMhPAJ
         WUaqDcToK2KqXdGDxp/rcjqREb7cFW6Ex9VpGtYu0ryu9lpijOzfbCbz91sQdK5O7Q7l
         VByO/N4o5HJPckn2h4el79S85hWdWbUA1zw/GJl+uLzEY+PPfANfG9qJ0esGBK9AzITA
         0ToXHa4MJwLdh0aThgMb/USVUeFypROl8mBfSNvgCbdg10KQRxRIyKzqm1Thn66x5YYH
         BAIIMim9fRTs5HNSUpcrtreSi0vAZinLCCwyq7ZzsstFYd45RmlMfcbdOftNayXM4nKk
         zCPw==
X-Gm-Message-State: AOAM533XTS0VmwAJqGiXRWaNho23PSdzh0ePiY8n5VNO1JxjQpCk8i++
        ZBU3cvh00QkFhgAno3R27FuN/A==
X-Google-Smtp-Source: ABdhPJzziVEk9OApC/D9HoHdo3L17beTvpGWyrUsvI1Z+SHRjsdYxzQhFOeIc0aZ8yaywZWy0ZHNWQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr956444wrs.330.1619135787133;
        Thu, 22 Apr 2021 16:56:27 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id t20sm8201149wmi.35.2021.04.22.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:56:26 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 2/2] bpf: Remove unnecessary map checks for ARG_PTR_TO_CONST_STR
Date:   Fri, 23 Apr 2021 01:55:43 +0200
Message-Id: <20210422235543.4007694-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210422235543.4007694-1-revest@chromium.org>
References: <20210422235543.4007694-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg->type is enforced by check_reg_type() and map should never be NULL
(it would already have been dereferenced anyway) so these checks are
unnecessary.

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 59799a9b014a..2579f6fbb5c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5075,8 +5075,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		u64 map_addr;
 		char *str_ptr;
 
-		if (reg->type != PTR_TO_MAP_VALUE || !map ||
-		    !bpf_map_is_rdonly(map)) {
+		if (!bpf_map_is_rdonly(map)) {
 			verbose(env, "R%d does not point to a readonly map'\n", regno);
 			return -EACCES;
 		}
-- 
2.31.1.498.g6c1eba8ee3d-goog

