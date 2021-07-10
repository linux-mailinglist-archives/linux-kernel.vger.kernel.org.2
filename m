Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5550D3C3702
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhGJWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 18:11:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4ECC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 15:08:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w13so8566282wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=o8XLWvLfLieNELF1M0DS0d6X+htDnd1bnaWzmXo8vbg=;
        b=I+wR7SgJHOmOJRpJZ8EZDAGde+mW7Sv8Gs19PaFlqzTvnbowhU7mXM35hoMRlj3mec
         cl3+Bj663jqtz8EXw9+uT1gR94cY3uyvQlip0r7faBFuARSmIxhjiYc+SJUFmPuUyM4O
         mFzdkLuzG6Fbio/J4Xm1fMZhTerRN4TVlJQNxZ3AzoJmiuYjR5g72mbRlkvwpahlHWm0
         IG2n2F243ORPZkHUaAuIocAvz7KzgoR2rzVntWpvdDBGht8uFM3JyUnyhZ1tPiQuo8yp
         7LxF1MrLas//Y7iSu/HIQxE8WxDZncB0J7Ie7q4tCVsdnGyORxZPS09nozDMuSZjXdC/
         3BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=o8XLWvLfLieNELF1M0DS0d6X+htDnd1bnaWzmXo8vbg=;
        b=KXG+JPXFCQsLyTcizCqqZlGSZxb68OogRo3ue7a+yyBhtTSBhxBeW3dYu3SWKZdi/X
         CcKZxMDxWwnCif3mj/4miqYezT0/5N2eJoJ6U+WCc59aUToEcyGkjgAxcbNhqpvkz8F5
         ymDylQdGRYR0LcB2lF9cpmhUJtuipMqQMIgJ5qq1qy+QSDcWVUBdU8iKE4b0OcwC7CtW
         OOFirb24So/zJ1Pbd26Y5nmuypWDml0CEVc/V2IASBpp526nvpFfUw3VNJGii3d1tVaa
         vs7wr4RVuhd1gXNmD8mTKtX0j2B+Hna7RVYScW9D0h0Qz8mEmPnbP+TE+tguNGtWXLkH
         DFFg==
X-Gm-Message-State: AOAM532m2Bsp9kSY//zZsI9F5aLo/TLEdHyXGprXrMsf2WnNaqDVMPcG
        mNFzGbPaZ3UJhHMPr459siJ+FkMo+K9I/IUK
X-Google-Smtp-Source: ABdhPJxq7oGqGgccr5nDua4JzQjAWDF8kGwQbSNjmZkJrDi8QKA0NHu/CFxDtMPdOuTJ+lcDLL6k8A==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr47451939wmp.165.1625954898932;
        Sat, 10 Jul 2021 15:08:18 -0700 (PDT)
Received: from alexlaptop ([102.182.144.99])
        by smtp.gmail.com with ESMTPSA id q19sm15244987wmq.38.2021.07.10.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 15:08:18 -0700 (PDT)
Date:   Sun, 11 Jul 2021 00:08:15 +0200
From:   Alexander Greyling <alexandergreyling5@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fix alignment
Message-ID: <20210710220815.GA1654486@alexlaptop>
Mail-Followup-To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl issue:

CHECK: Alignment should match open parenthesis.

Signed-off-by: Alexander Greyling <alexandergreyling5@gmail.com>
---
 drivers/staging/rtl8712/osdep_service.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index e939c4a954b3..d33ddffb7ad9 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -46,7 +46,7 @@ struct	__queue	{
 	} while (0)
 
 static inline u32 end_of_queue_search(struct list_head *head,
-		struct list_head *plist)
+				      struct list_head *plist)
 {
 	return (head == plist);
 }
-- 
2.25.1

