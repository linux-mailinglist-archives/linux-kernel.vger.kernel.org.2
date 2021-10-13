Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426F542CD52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJMWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJMWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:09:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B336C061764
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s17so1403233ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgrOWt+0UrbnyJPirrWJadmN6VqoyYnxqhzi5f8pBSs=;
        b=YkWx1+lveQyhUFhb4Hepn3OaxjB5skEXMrWGFP8d3+OuqtCpGUW8zdLcLDuwGoybi/
         b7Y9F1ZhyrZTGNWA+5R6d8XhViyge5htaS3ktbxwACnmS3ckxYvNmdVoARi/rAOCvsKw
         ApDWIYh8gFXQSc8FBNElKYAIzzQ/dsN1GJQZo9fKVhVcM0exSsQheLSP7NGKjtXzxhyn
         S8auZt8B9C2dGwNAekcwn7DS2ahusszu6r30B9f/XiSH/F81/9zCbawZpHdH6K3QHlgH
         7TnHO32XyiO8Azva9AWFO8EwFKVd2cFm5JUX+OTBXFIIuJaH0eMk3Ycl/XDT/kQbUjAR
         EZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgrOWt+0UrbnyJPirrWJadmN6VqoyYnxqhzi5f8pBSs=;
        b=LdeYhMIYjBqN8xL2Yg81yq9pC84Eq+OGjCKVE1lvseIHAUaJSC4lUdKQxtU+ot8sXt
         BnrLoIraI9OB2U6BJSYpVm1stH8YXga5E58UD/4aorvgqVluPlgR69bSrv9RznXFhUeb
         tOl6e+vKNgW0FIc4gtuV2yBdnJ3nThoUtCy/R2z+XP8J9WedxRUKVybcNbPGKdn8LhkA
         4+t+B9883RMYGf3vVvgeHxvNQXCkw08+YeL2KpyVz1s977bSzVGlefTkgwO7e65xB1Zc
         jVuf4Q4i1Fl3/KhRNFBsnG4POHJ4C0TFdNYMt73NLwuZyqfAMGNMenmsLTQ9dQBiFoGt
         g95Q==
X-Gm-Message-State: AOAM5324TSRXZRX7hiHTTDWH5qBa7Wbuj+VX3pj/HiLm9/09Xam6IPo8
        Mrjl0Dx9Nd7ARrr0Nkz1+h41PoWz3Xo=
X-Google-Smtp-Source: ABdhPJyeyr5MS8pMXTeu7JyRSDlpvqBUDGAH8IFxsLns9EL5JiFyMW78RCa4qLRBN+CovaJwUUFt7g==
X-Received: by 2002:a02:cb94:: with SMTP id u20mr1391033jap.134.1634162857411;
        Wed, 13 Oct 2021 15:07:37 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i15sm324633ilb.30.2021.10.13.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:07:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/3] dyndbg: vpr-info on remove-module complete, not starting
Date:   Wed, 13 Oct 2021 16:07:25 -0600
Message-Id: <20211013220726.1280565-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013220726.1280565-1-jim.cromie@gmail.com>
References: <20211013220726.1280565-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On qemu --smp 3 runs, remove-module can get called 3 times.
So don't print on entry; instead print "removed" after entry is
found and removed, so just once.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9dd8efb5a756..bc1ac55ac328 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1028,8 +1028,6 @@ int ddebug_remove_module(const char *mod_name)
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
 
-	v2pr_info("removing module \"%s\"\n", mod_name);
-
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
@@ -1039,6 +1037,8 @@ int ddebug_remove_module(const char *mod_name)
 		}
 	}
 	mutex_unlock(&ddebug_lock);
+	if (!ret)
+		v2pr_info("removed module \"%s\"\n", mod_name);
 	return ret;
 }
 
-- 
2.31.1

