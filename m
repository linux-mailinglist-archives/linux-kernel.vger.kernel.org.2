Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F86375C13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEFUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:02:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C14C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 13:01:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id zg3so10107772ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xcSDKJPl8yVWmYkatqD6oRhplFv7T5bCCK0jErkQLSE=;
        b=nx340VYLaEb+cobw5tYbTxosxXv2CKm7oSVLoMAMZ06nUA2+iwJ93mMyoHYtpBeh+z
         XCw4gMELnoLyOCPgRMH9JzZ+V/ZKZA48Xuppda8xDYKPoA8298rGH38oaTwmUuaAZLxK
         CEore154VaTgf1a+Eh9RaUqNeLT3jIZgbdK46NMLm3eH1LwYm7SQVUuR0Xh9hRdjtb8m
         zLarziFIzeu4pHEGWRhsecNJNejP23iXy3kCIaOZOLrpPxang1NafPd7aKpuBlx060c4
         4r0uz8JqEyJT7XFoRFdooWeWN2z+nRwHNFPNKGimLAuQRDivlIaUdY5PBIfbTxaWWvxp
         TVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xcSDKJPl8yVWmYkatqD6oRhplFv7T5bCCK0jErkQLSE=;
        b=bbWJqhEvnXy40UlQ0J7RUNu+kvd54ZIOElLMgMI2oxFBTBDKKBrvl079e8lY8TuEQv
         rMnOZrDzwI+e6HjJeZNmCQiJawwwKOFvSgxBEB/dV0LZiaS38wYTuyAcAAJzETwYihro
         pGuWICoUC1+c2OIi+su5NbgvrLXLisEQjg8D1rBsozuadfHfnJ4T5SDT+cV+b46iSly2
         7p/Pz41pZ2Mkqeg+RmHv8xAaCBFjtu7wwL4mGqKu28XxlvuzETbSpE7IfET/YyWGXOg6
         er5LCfzEFFsyu6xCmckRN5pjW2rFBImK+yRC3Ogq9zrpZk9iSdV/lpYCMZks1beaKLgd
         FspQ==
X-Gm-Message-State: AOAM530QqNpBn69iwSUY5hsMDn57Ri4EEEGG4+yjiv+mBInfdsy5uVFk
        JmE+e7szJQaChlFBw65NU2IvywUOSg==
X-Google-Smtp-Source: ABdhPJzN7tylTZ2eeCQsSfRXEhf3znK4CDJzknCnVDCuK87Q5SRqWAh+IFnVfvDG2Ek2Mywx112ETw==
X-Received: by 2002:a17:906:747:: with SMTP id z7mr6394560ejb.252.1620331267055;
        Thu, 06 May 2021 13:01:07 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.96])
        by smtp.gmail.com with ESMTPSA id cw6sm1968737ejb.32.2021.05.06.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:01:06 -0700 (PDT)
Date:   Thu, 6 May 2021 23:01:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     bcrl@kvack.org, akpm@linux-foundation.org
Cc:     linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aio: add missing dcache flush
Message-ID: <YJRLAPfYuNaCWq6T@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ring page is mapped by kernel and updated so dcache must be flushed.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	Not tested but the usage looks fishy.

 fs/aio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -653,6 +653,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 					ring = kmap_atomic(ctx->ring_pages[0]);
 					ring->id = ctx->id;
 					kunmap_atomic(ring);
+					flush_dcache_page(ctx->ring_pages[0]);
 					return 0;
 				}
 
