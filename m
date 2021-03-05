Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1932F0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCERSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhCERR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:17:56 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF2C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:17:56 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id x10so2675247qkm.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4GojBV1azni2+AJjaknXBA1yM5ht5Ee/paoV+0Jysc=;
        b=M0LYqmDE0f+k4CUl7h5kgKc2Bs3DxjiAZKPIu835Qg7BKBWjgS/7Ca9oaBZuvYrbUH
         JExpaQ9R/gYjZ9rry38yaxypuQp1tb0tSYWOZmRDwSAqdF8OBDMvxl/YzZ5qwecorMw4
         /D0TTo/FMSJMqkD4ej6+Zic0kJPLcifQWH6NKm1976jhq/e0nKLrCKsZSxXg2+kXZvWX
         a468quJoLTOP6xg2Lyd2C1sxpKzk8jOSgCv+x+7Ix3++rM5DWa4l77LjgpLylszNzr5Q
         ZXygsHdBJOeLUglNr1m4DFoRf+CKjsnoOPD/rHXY9PC7mJqw1GklNfpXFfgKr1s8Bqu6
         VePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4GojBV1azni2+AJjaknXBA1yM5ht5Ee/paoV+0Jysc=;
        b=nlpdPDcHslgGHWfrNBDOOafld6yfV5mpJCM4GNlVrO4gGLWoY1UjQFDx0DV/1aevMc
         EzgLrDtfIFt0WC3lI7THOwH6fRUP6DKRNkJsmffXIuZkcO0T/WJWue2tbJuPORy5ns3x
         CfrBQlqdq62E8WJj2qFVnGvirKFXfygLYqi9gVIDqCxGtIDu0dEpicEGfUEM6jH2+bg8
         mmUtL9uUOSePiCGk+YZWvngNudMsnrNVpjWUvjcNIlR5yCxbQXJ5KPdxIsEf/9qZ+zks
         BHZD4bXUs3BoeLFp6kreapjAyFmT8di0EyFhKt+NP9BeHMh34KcSpErV7aLvovkO+k4v
         WHbw==
X-Gm-Message-State: AOAM533AP8yd5NZmzIZ3KRVuYygR49+YIdF7imi6pBw/kB04ThlT2ANZ
        5f5DUKCkQRWO4Z33wdhtg1POxrQKRc9jhQ==
X-Google-Smtp-Source: ABdhPJwT+EvlaLHk/joeZCd9rd6+eK6gkosD4VeDV7qYVLIjMr9FbyEeKgEzpebYCwvaNIezXYOssA==
X-Received: by 2002:a05:620a:1323:: with SMTP id p3mr9884313qkj.175.1614964675731;
        Fri, 05 Mar 2021 09:17:55 -0800 (PST)
Received: from darkstar.example.net ([2804:d45:9905:9600:c57:100:d8b8:6ad3])
        by smtp.gmail.com with ESMTPSA id e15sm2289357qti.79.2021.03.05.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:17:55 -0800 (PST)
From:   Davidson Francis <davidsondfgl@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Davidson Francis <davidsondfgl@gmail.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccicheck: Fix chain mode in coccicheck
Date:   Fri,  5 Mar 2021 14:15:58 -0300
Message-Id: <20210305171558.6192-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Coccinelle documentation (Documentation/dev-tools/
coccinelle.rst), chain mode should try patch, report, context, and org
modes until one of them succeed.

It turns out that currently, the 'run_cmd_parmap' function, by failing
to run $SPATCH, rather than returning an error code, kills the execution
of the script by executing the exit command, rather than returning the
error code.

This way, when running coccicheck in chain mode, as in:
    $ make coccicheck MODE=chain

the first .cocci file that does not support one of the virtual rules
stops the execution of the makefile, rather than trying the remaining
rules as specified in the documentation.

Therefore, modify the coccicheck script to return the error code,
rather than terminating the script.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 65fee63aeadb..15711bd43395 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -153,7 +153,7 @@ run_cmd_parmap() {
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $err
+		return $err
 	fi
 }
 
-- 
2.29.1

