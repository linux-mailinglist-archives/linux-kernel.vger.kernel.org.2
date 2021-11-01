Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97531441DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhKAQCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKAQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:02:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21FC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:00:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y20so6000706pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=511cDB4kjcE6bGhGi5t+CjoXKqM9/xDCH785zltyM00=;
        b=EwsJE5vULSX8wZ0e2C5h9Vj3wM3xEJpQgj0Rdw6dRUtebKelZKwtUzg/Dmp/rt+8z3
         Nv3ZHA3PkxaFMutJ7OPFxf8Kr0pAV/SI8k5AWYsoZXDvqSHMRojBx1g3/+NDhQDDwWb5
         Dwl1X0AwHBdpoJ9JnWPxWOzfxE/+Uw6UzfiYxMwpeCjFZsmcQLfzkjFa8lizzXHYFjp5
         BJSIdge2GywokJch9AugbtlzVok+KV6C5w/jCcVp7cK8rHQuqxJD+FsnjWgjaOH4j07N
         O25nGL4chWdSXT/ry1GNhXjN9d+sWqWT0f5rpYijYm0o4DqbvbwskSzuAvcrKQQOJste
         K8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=511cDB4kjcE6bGhGi5t+CjoXKqM9/xDCH785zltyM00=;
        b=njaKwzvT7cgGK7jpAsX+mHbr73bIGb9f7oH1XwKVhaynacRWIwgkz8q3wN/TU8MDc2
         fw7IpFuvPtF7/mC6+Pgd2ZidNzRkXn2jjI5LtENmdlefDd5pcPSZFvGutH58Noeqz9LQ
         ELpZd+7HXXyUeVoZeTtK2lOP/KeMmozxsrAWd89sYMqXZ9pPrwy3aqMG9W+pV2Kaz/6h
         oipZ7yvqmp9fCqZi+dJk0XmSjDAU93zHieBPQThAGXI7OMNKHDOUtNRSWWtByhjEdh7A
         yptMRtPMdwzrH3lWlvAJr64aNFOCFQQCTzoXQyyAWW/Tl2I9aaUz+VWbqTuBUdgPWvq8
         ESxQ==
X-Gm-Message-State: AOAM531E6ehLWNQ/RkbYoW8KYPbcqbJRylHG0MYEMBr6tS45U79Rz3pR
        zKto6j3vi1Y2xYf+3nh057M=
X-Google-Smtp-Source: ABdhPJwvZKMf5iJdHX/WQC6zfq3emJe6qWs247HQU+UQXEzULhN2Uw/7v8cJcMVqGVTC8LUCqsXoTQ==
X-Received: by 2002:a63:b145:: with SMTP id g5mr22405621pgp.355.1635782402025;
        Mon, 01 Nov 2021 09:00:02 -0700 (PDT)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id h11sm13097112pfc.131.2021.11.01.08.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Nov 2021 09:00:01 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:59:53 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     masahiroy@kernel.org, ripxorip@gmail.com,
        gregkh@linuxfoundation.org, matthieu.baerts@tessares.net,
        mpe@ellerman.id.au
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tags: add a space regex to DECLARE_BITMAP
Message-ID: <20211101155948.GA10424@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "make tags", it prompts a warning:

    ctags: Warning: drivers/pci/controller/pcie-apple.c:150:
    null expansion of name pattern "\1"

The reason is that there is an indentation beside arguments of
DECLARE_BITMAP, but it can parsed normally by gtags. It's also
allowed in C.

So fix this regex temporarily, and wait for better solutions
applied to other regexs.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b24bfaec6290..7e5f19391f20 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -186,7 +186,7 @@ regex_c=(
 	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DECLARE_\(RWSEM\|COMPLETION\)(\([[:alnum:]_]\+\)/\2/v/'
-	'/\<DECLARE_BITMAP(\([[:alnum:]_]*\)/\1/v/'
+	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
 	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD(\([[:alnum:]_]*\)/\3/v/'
 	'/\(^\|\s\)RADIX_TREE(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_PER_CPU([^,]*, *\([[:alnum:]_]*\)/\1/v/'
-- 
2.17.1

