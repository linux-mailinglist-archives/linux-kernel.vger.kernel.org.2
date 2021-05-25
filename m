Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F36390937
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhEYSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhEYSvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:51:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:49:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n2so33401051wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QkZuR7WGEuc/OzubNh72ZEQ82K0LmWtrpj9zYCT1cB4=;
        b=hOMHfP4eRkuIEdX1wdyVbulI461lQ3NrjReMlCzBUFuxp7Hz6yO1nK8iDlDVcuCLkK
         RICw/Jb8bz7IfYFoGABo/3r7fmA11cbq1Xp40v8wX2B0mOmCO4PJm1afbH8IKPMwznCv
         qfd4Dl4uy/NEZHkbeBA9wqDnfhBPfA81gVyXTt2kxkKdcNKZTccSd4RJAzxKBbx30SLL
         /f6VpPWGcD9PVWxwyAUzOlB7jyVktH4pBx46ti71nYvTPvza48Xm7ySLnGSQ9o72Yaks
         CxsWrx+vz2IUFg1QzyqKOVuFFv2R7z+vjCuS+FMRux5shgefXjAWD/LEhsDBTRWmNmtP
         Ihkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QkZuR7WGEuc/OzubNh72ZEQ82K0LmWtrpj9zYCT1cB4=;
        b=prRc6EHEE9+agUbh2RfpR9L8wBXfG+ZGPmFUDuI8ZBg1AwjVbIF7uY6PY8IOgsnCnB
         rDsiRjw+A39FL5xaB4Z3F4IxGprpybcblY08Z4PISgqHvKIzauf8qu7TsXIdIYUqjfrt
         tgFOB2PtbBubREyiTDN5anikBkYNWxPBqgCdU/s/uov3Kg0FBku2CUo00/LfzA3WYs9A
         WMxtvosLrpWpSYgcVQLpooaeuq5bVhdV3ZswNtX28X2ImuK254ygTXtwSHVPFtDL4/rG
         MEEENLV8TYARkFUkLGpCyWS3NTuJaEB4IXjHogKC0ehvyoQrHkSsHm62fcOH/6CsUVnL
         5syQ==
X-Gm-Message-State: AOAM530RYQydYq8TpWZel+3doWEU3sIg9siGR1O7cBNYBHIte7Lt9WUY
        T9JoE2DpZhFcWBQFWyF58w==
X-Google-Smtp-Source: ABdhPJzzwSw2UigDpRQJl2/5RgIu6+ockx8pYdBu3zVjn8uRJYIhXWrHbajoUviO7x6h2tOoALOZ7A==
X-Received: by 2002:adf:a4c4:: with SMTP id h4mr28728203wrb.330.1621968589648;
        Tue, 25 May 2021 11:49:49 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.96])
        by smtp.gmail.com with ESMTPSA id d3sm16959690wrs.41.2021.05.25.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:49:49 -0700 (PDT)
Date:   Tue, 25 May 2021 21:49:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] exec: remove checks in __register_bimfmt()
Message-ID: <YK1Gy1qXaLAR+tPl@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete NULL check, all callers pass valid pointer.

Delete ->load_binary check -- failure to provide hook in a custom module
will be very noticeable at the very first execve call.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/exec.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -84,9 +84,6 @@ static DEFINE_RWLOCK(binfmt_lock);
 
 void __register_binfmt(struct linux_binfmt * fmt, int insert)
 {
-	BUG_ON(!fmt);
-	if (WARN_ON(!fmt->load_binary))
-		return;
 	write_lock(&binfmt_lock);
 	insert ? list_add(&fmt->lh, &formats) :
 		 list_add_tail(&fmt->lh, &formats);
