Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB235C449
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhDLKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhDLKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:44:38 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB86C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w10so9048728pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aK68x+At4MGL6Gp4oOcXkofX3goWjEGh1fkkQH9ZBPk=;
        b=Q93B1RXjm2AuT5o48BAguqnNgVw+uHuSd6eXJ9ucN5bxdNe5BvxH8s/Qug4GLJYb1C
         k+Z/49Dt1BMQAUSp+KA7bm0CZc7nAB6wn9ogdZwCT+Jg/S06aRstk97Ql33T6/FzwEFA
         cz43u9KFfiVQRf7wKJ9wi+DNyb5j/TrZYrERwWGjCAqBy9sUGm7ErR1t6CRY3D/YNEMS
         JHtrF+c12P+ZW8BkbNkTfM7qrQybpSjHAyOH2/YpDJlsPosE8TM6rv+zrWDPcZ+LC8eq
         IDMkKWLyJPwDCYlDFZfSB7AdGt4+HqKypyeI1lT3EaQyTI3B6jwMUjLHjdA7T/0l60b/
         d0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aK68x+At4MGL6Gp4oOcXkofX3goWjEGh1fkkQH9ZBPk=;
        b=rczf/M4YlY+5ZoKBIIMeW6HfDjP3Sm5M/6JO503jKtSxbgi+eUTwqzO1nedLjhQyJM
         rVqpJXkPikIL4mMfXftXvKuLSRaq7+v6RZxw6c+HG4ynOxGUC9SpoSMHHOc++N77fpCC
         clUAEKXsKLbBjVMJci+2I97hwzdoRWcs7uKW6GwIUwlvBqETkjNqt0rMaRJ5u9Isb14I
         iw4YLrC6qdcpetL8hz+5+0UTg4AOCb3nWrSaUNelbmljZ3zRKivOIVGWIq5WAe0U4Im2
         XzfHGrovG+phl27bUlP0ODSpKHLmfslDTuHQCTpKX0tyXSLRnDgIstvKNW7lgC7DCRDZ
         M7KQ==
X-Gm-Message-State: AOAM531WlcXK2lBZXCSPUUDIECShHDPbq2FXLKXF/98PZa5d4vc/XVim
        8kh05FvwZQbL9mAteQdBvI4=
X-Google-Smtp-Source: ABdhPJwMtchSnhBqNaov0Ggf9tQE/rWlUWFfGygCKo7paj0Z/6iJoO7WobE/959rZvQfqxgW3EexKA==
X-Received: by 2002:a63:7e02:: with SMTP id z2mr25523575pgc.404.1618224259724;
        Mon, 12 Apr 2021 03:44:19 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id gg22sm10685553pjb.20.2021.04.12.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:44:19 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:14:09 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@susu.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 1/2] staging: vc04_services: remove trailing whitespace
Message-ID: <5a54a06bae846f1f037165c0c7ba7ffe5a55a4a8.1618223171.git.mitaliborkar810@gmail.com>
References: <cover.1618223171.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618223171.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed trailing whitespace to adhere to linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v1:- No changes.

 drivers/staging/vc04_services/interface/TODO | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 0bcb8f158afc..adb28f46ba67 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -27,8 +27,8 @@ unused.
 3) Make driver more portable
 
 Building this driver with arm/multi_v7_defconfig or arm64/defconfig
-leads to data corruption during the following command: 
-  
+leads to data corruption during the following command:
+
   vchiq_test -f 1
 
 This should be fixed.
-- 
2.30.2

