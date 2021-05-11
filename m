Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DE37AB02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEKPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhEKPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:45:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:44:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g24so11892453pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STE8B4j8SbHhwlGC6TE3w1gH4IW+1g44hACZcaS9+D8=;
        b=DgPJ1K086M6ddcDdMSmKwRTAIlbhZQ4PfNTOsPfiJ3Eyl/huT3/h5djnVO+oe4Zkhu
         RLnZ0Hoo2q9s77jYzcAdVMc574o3wgxVKvaOYgyheNZ2PUCNnHQw0cczbdK/fd7+4jFV
         CI+GZv62TsmTdiIM8dZ/2vSCseFrih4FRkmVaHS2hxbosADFIlx36Hg3hW7gkNWk2C5W
         JsBHBB+WJ+k2TkLLHEXpOlaRu3vEEttZBjE6O1jgv65jznh3rh5TbdDevzcKRvue38nv
         MdpGntE+ArjVOmEX49XaXII9ASFbwDuo5dT8fDUhonst5vzHPcRlS8v7j1xW91+R0n4d
         YWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STE8B4j8SbHhwlGC6TE3w1gH4IW+1g44hACZcaS9+D8=;
        b=h/5Br6TAcfAJ+YeDlY/iipSa2ZGpw2h2NTKWExbc3fVYc9F7DZDgqKp73e0CLH6px1
         jMLhI7KmV3s0ARPCjkz45ztoiv8vevNLj8KOI6x+OJCUrC0IITDmTUQqFgGr17m1lVPC
         oN0/AFTyTXCLI/4b+o2SOwW64bdrUMiWaAZexHzVbxf2zsXeRBo8OdU2k7ElP6omRJyW
         e6cROWjT3+wCRZbnurGoLVSbTYF5irrkWkkogwTbFuJX37rXFUmer/OqSSyqrVLX2XCZ
         bgblTG/B7D+sDADSfcQ1xDwWb+f8zYHmjUnLdhW7aZ+MYfUo9Cgj6CjzxLdQry2eLB8J
         IJmw==
X-Gm-Message-State: AOAM531mxatgdNuyVGhgpnF9CH3c0uZ8eSLUKV0b322RiGUKdZkLS1f7
        dswm7gD8YdlEhIZdBjtu5zQ=
X-Google-Smtp-Source: ABdhPJyhWDFDGi4qGq93L/w8BS0ZLIxCjl9ElQ8/QY3SIXi679OWdaGb8jW21ihnf+i08OluVgko4Q==
X-Received: by 2002:a17:902:c106:b029:ee:9d6f:8861 with SMTP id 6-20020a170902c106b02900ee9d6f8861mr30275406pli.85.1620747862498;
        Tue, 11 May 2021 08:44:22 -0700 (PDT)
Received: from novachrono.domain.name ([223.235.208.114])
        by smtp.gmail.com with ESMTPSA id c23sm14250403pgj.50.2021.05.11.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:44:22 -0700 (PDT)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     akpm@linux-foundation.org, terrelln@fb.com, hsiangkao@redhat.com,
        joe@perches.com
Cc:     linux-kernel@vger.kernel.org, Rajat Asthana <thisisrast7@gmail.com>
Subject: [PATCH] lz4_decompress: declare LZ4_decompress_safe_withPrefix64k static
Date:   Tue, 11 May 2021 21:13:45 +0530
Message-Id: <20210511154345.610569-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare LZ4_decompress_safe_withPrefix64k as static to fix sparse
warning:

> warning: symbol 'LZ4_decompress_safe_withPrefix64k' was not declared.
> Should it be static?

Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
---
 lib/lz4/lz4_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 8a7724a6ce2f..926f4823d5ea 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -481,7 +481,7 @@ int LZ4_decompress_fast(const char *source, char *dest, int originalSize)
 
 /* ===== Instantiate a few more decoding cases, used more than once. ===== */
 
-int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
+static int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
 				      int compressedSize, int maxOutputSize)
 {
 	return LZ4_decompress_generic(source, dest,
-- 
2.31.1

