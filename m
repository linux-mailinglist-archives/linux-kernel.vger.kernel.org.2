Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1B354373
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhDEP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhDEP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:29:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3ABC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 08:29:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d10so10420635ils.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd9OzSMlCehKGcZL/iMnRfIpVLKcWrqMxSKE53yLOE4=;
        b=L9zmJategCEBK4GCaOWGftMb7KWEY/q2Fs1KzBmVyL2SsShx5IEXvQPGJbGXhfz+vZ
         /VlhcaWT08ru5UVMda+luKoVPRqwVY3Os5rC0TFM8Aoa5ISR28zF7mkkuXnulFo29ADD
         FlMTJNQieLH3Y6oLcdMJzxQorr0BeOOf14A3v28Pbo4RFqzYf3FE7vki+6jy6WUF0iPy
         F62NS6RUqWNhvEqk+n6aRorCK0Bra9M+eEB6qtUAne58iwSTE+1Zy2BuVC+1GgajE2ig
         j2I+5jfqeSNoT3x052esbHNU4cPVB/fHSm5gp1FeMpqbXxbWg5m9+tmRlxNGJPqlf1ow
         oGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd9OzSMlCehKGcZL/iMnRfIpVLKcWrqMxSKE53yLOE4=;
        b=gxfiG5Otw8dDB7e75TsDBn7+Rgk8XjSbiJlkDWDdh4ptWVGmosvKZrlaJpJ//Zs+3t
         qvK1omFXT1AFLei6leotXLHYXIE0RDtymwzj4TJgCQq8UYpMk/mivPpanu03Mp71mEiw
         BDF426s4cn/h8CzJDdyBm+CIQqPMTHzj2nTff/5VHCm5qJfAcpdma/YVZpYwbSm8Gu7V
         NinJqOhwVMVy7g4ypiolXrWnfprwjgj0JfhdVFqqS0PsQsXzN+JUQX3vDDRvc10wtzJ/
         xVHCzhv62/shdJtXsgd7V06vcGLYt2kyQ3fCYPEMS4TxoobBh4+P9TQnxfVxlJZiGuid
         tfdw==
X-Gm-Message-State: AOAM5311biqWYeYM/eYs/G7gWM/j2otY+V751pKnNIBhEuJrh4Kq1hAL
        wtwkLvGJynwCfO2ay5XT0AgnJHsEg1SG
X-Google-Smtp-Source: ABdhPJw9+lT1tYJ3D+2NkeZPzKRwHID7z8tB0e8FQMpLiGQS7ytRRhla+ZF6wRnHxFhks7F6Whz+RA==
X-Received: by 2002:a92:d70c:: with SMTP id m12mr20768410iln.216.1617636581325;
        Mon, 05 Apr 2021 08:29:41 -0700 (PDT)
Received: from mallard.lan (a95-94-147-174.cpe.netcabo.pt. [95.94.147.174])
        by smtp.gmail.com with ESMTPSA id l1sm10930554ilv.34.2021.04.05.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 08:29:40 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] ubifs: default to zstd compression
Date:   Mon,  5 Apr 2021 16:29:35 +0100
Message-Id: <20210405152935.148129-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to lzo and zlib, zstd is the best all-around performer, both in terms
of speed and compression ratio. Set it as the default, if available.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 fs/ubifs/sb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index c160f718c288..e7693b94e5b5 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -53,6 +53,9 @@
 
 static int get_default_compressor(struct ubifs_info *c)
 {
+	if (ubifs_compr_present(c, UBIFS_COMPR_ZSTD))
+		return UBIFS_COMPR_ZSTD;
+
 	if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
 		return UBIFS_COMPR_LZO;
 
-- 
2.31.1

