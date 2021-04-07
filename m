Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBB3565DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhDGH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDGH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:57:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE984C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:57:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so866335pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GyqCSJDTppuuFfpUrZ7k/G3TcyInJOqMzJqN1ipUF+4=;
        b=Yhg7XiEVh0NLRIwQs0dPjoCJ9Iy1xihWOS5sk8ACN3rBpTryEIcQXRwx5FHhnVulW4
         mqzX4gVlA2Ax6zuMF9nG1ySEKzZ1vpBApmJOuNYlNWOEcdIrXhjkWIb6rncZZYwuJsl2
         Xqpqhmw/EMERxT3b9NHEKZjwZ7gdptQuiuWIj7QlxIejY5/YaeWthEh13s06y9oxEPey
         WWmly4Ve9FF2vM3VS/GyKmy/bVMRRwKTqXZRdRKukjxzqkCyByPLVjsrsBwo7xDdF06W
         3TEpP33LFKm87imAyUmDjcixr4MpwMe/haJ9g8aKHaX5wnxALB2/HwUgETEZ1riTVP5X
         yuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GyqCSJDTppuuFfpUrZ7k/G3TcyInJOqMzJqN1ipUF+4=;
        b=iDYglKmMsz94pUukUzO3qOyKn6Ez7ulVQ653xGS7rp3dspzllSRbOFy/A+sIIAKskh
         dc4yKhB7xYQQH+gHvEcc54AkFXUp9dbYCvfOPcsSzehWXi7LFLAjJlzjm+S73cf3b3OK
         /hngKfIHk3vv1K1PZHHpqDfL9PcUF3ZfvtlTLXeI/jB5PNR8XaSeq9t2MP/CEfUo6+pC
         fIbymYfeTxt8AiNAemP8gyaPmsu3eCYK29M+TlyLc1D48zFUtZAq2fLnVr+avTiRbKb1
         32j8+i4wsl0jKDF5/gB59J3Emg1nuJBQlzDIw5ob9vYaSLycTUuRUZf8lNAVKieOx2Jq
         TGrQ==
X-Gm-Message-State: AOAM532BUF/nSZa3zCe75bKy08D+ct/8hl2K5b0CCKeCOQQGGP4zJsWD
        5L67gunAGk84KnKDFk/2GpA=
X-Google-Smtp-Source: ABdhPJzOzelL7Q+K9uwVWCl7hVeBXE5KWlzZ2ypOPk5NUzEBggssb7Ct4A8LMJSQDXhUbJ6b3h9ZXw==
X-Received: by 2002:a17:90b:142:: with SMTP id em2mr2109427pjb.59.1617782254060;
        Wed, 07 Apr 2021 00:57:34 -0700 (PDT)
Received: from kali ([152.57.146.48])
        by smtp.gmail.com with ESMTPSA id n23sm4335230pgl.49.2021.04.07.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:57:33 -0700 (PDT)
From:   Mitali Borkar <mitaliborkar810@gmail.com>
X-Google-Original-From: Mitali Borkar <mitaliborkar810@example.com>
Date:   Wed, 7 Apr 2021 13:27:29 +0530
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8712: fix avoid CamelCase in xmit_osdep.h
Message-ID: <YG1l6QIKRMjqgPiD@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Check:Avoid CamelCase by renaming SetFilter to set_filter
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@example.com>
---
 drivers/staging/rtl8712/xmit_osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl8712/xmit_osdep.h
index b76021b568f8..7ad2ac6f5ff0 100644
--- a/drivers/staging/rtl8712/xmit_osdep.h
+++ b/drivers/staging/rtl8712/xmit_osdep.h
@@ -35,7 +35,7 @@ struct xmit_frame;
 struct xmit_buf;
 
 int r8712_xmit_entry(_pkt *pkt, struct  net_device *pnetdev);
-void r8712_SetFilter(struct work_struct *work);
+void r8712_set_filter(struct work_struct *work);
 int r8712_xmit_resource_alloc(struct _adapter *padapter,
 			      struct xmit_buf *pxmitbuf);
 void r8712_xmit_resource_free(struct _adapter *padapter,
-- 
2.30.2

