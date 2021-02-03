Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0D30DCF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhBCOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhBCOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:35:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E8C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:34:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so17674088qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWuH29xE8SOUo98mUrgsH6VcL5/wyoDU03Pu/NvAnWA=;
        b=bEnjW75NBZJsfsbK/QeMxsL/h5//ALzM8iLH6o7y1kgZ//MgIy/bxe625zwSzpged7
         YEAlA8aKY50wFnYIY1vEOVzYVnNc4oTWS7yE1DeUr718d3zw83X+fvBfYFlg22p2MsIJ
         wV7ER3ieH34v/emmKTNU4pJcOCy+2Aexd52Upy0OMkYSDv8BzlomhXZuNFOK85au5Yw5
         Rd857rPHxN1DTK7qcAHl2jPP99zkr8m8R++ftxCMrw/O2m+FX9P+cThHL8f3HOECbpGB
         sDmUHdTfJdXSQ0KkDCHuyn0ycrS3v+rhHL24XnY5xa6bicvz7wL8qqHSUpOERV3Xohgn
         P05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWuH29xE8SOUo98mUrgsH6VcL5/wyoDU03Pu/NvAnWA=;
        b=gux9gMJLxPBTpo623pKpFZBMYw5tWYIJDR7T4+O47gwsDq1MRFLgoedXzgvSieHGq/
         /2LUpErOFbAiTxLmFcPcB4dZ/o7+sIMU4Hq+N6n+rEuj8q7AWfdqmGBXxfluJWxreEas
         ibDBvNmWkJSrus/HFezB/Q2Llv0dqMORM0UwHjyXBL+0BfNWCJaTqxC5JZ9Ycy60UhqP
         Yo7Pea6OCBN8PrAZ42RRTcfNmZdFh7AR7+7+Dc1Zm0N6C4In6g2kVU8OEDZMxWmcM5eY
         X5imNGtd5aSifP5aw27P/2LipHdLUr5N1goMYIbh88Dgp4QQXLouvdDtseuQ8HruKAUT
         WQqg==
X-Gm-Message-State: AOAM533oEZ4cCxyyU+yEOYsHPheEdo3FcnWxVMe1j9J2bYkNdE04oLnA
        xn89tZRS/lTKO6lSRmxKLTM=
X-Google-Smtp-Source: ABdhPJzHQzKrUeHB1RzvSQ31vCtaq1jj7XUXAhmxfbiRq8gcTkgazAGty1kkdkPfCUWmlTClO9d5Bg==
X-Received: by 2002:ac8:67ca:: with SMTP id r10mr2669139qtp.267.1612362886426;
        Wed, 03 Feb 2021 06:34:46 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id 11sm1841130qkm.25.2021.02.03.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:34:44 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools: bootconfig:  Fix a spelling messge to message in echo statement
Date:   Wed,  3 Feb 2021 20:04:25 +0530
Message-Id: <20210203143425.19595-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/messge/message/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/bootconfig/test-bootconfig.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index baed891d0ba4..08b14ff0070c 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -78,7 +78,7 @@ echo "File size check"
 new_size=$(stat -c %s $INITRD)
 xpass test $new_size -eq $initrd_size

-echo "No error messge while applying"
+echo "No error message while applying"
 dd if=/dev/zero of=$INITRD bs=4096 count=1
 printf " \0\0\0 \0\0\0" >> $INITRD
 $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
--
2.26.2

