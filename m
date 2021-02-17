Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4394531DBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhBQO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBQO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:57:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A14C061574;
        Wed, 17 Feb 2021 06:56:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u143so8557415pfc.7;
        Wed, 17 Feb 2021 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=umrhymygAjTfKKuGa9j9kzWZRmkTLrdJqnZSqOqe44c=;
        b=ZRifIs2DaEZ0LEtho8jXMGQeDYrvcjndsqk9MOhjsYC1fpC279lJddN/I/YPBvqQAp
         Xh6Ef1WOxac+h3I4blwPlP+KfFs2EAyXPvCmQI5IvNEIFkCbcplzM5R83do0IHnjY3WT
         Ein/k+c3X+YGvtMCLb/lEelZXXcb4kcJfKC+SUksF1yzlq/w97+X/uPrMpfAMPqyP47v
         jgyVYWth0/bZEt65CYppdBEFDhhIwnuKtuXGQT0ldoKjX0sMBkEOraTM0jd1Yp/G1LmO
         yTOsGGZ/AmQaCoNGRLMoKoO/dQmB5XQzH7isHETw05N6fcOK0BPa+8lhcLPUB8yIdwhj
         a4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=umrhymygAjTfKKuGa9j9kzWZRmkTLrdJqnZSqOqe44c=;
        b=i1YqoJvpnDhEAWgulhVHlMQFQKMDs2sVxuW4H1JqB5UyNlwQq9igZIM7pTRvxjgvvk
         iyMwK549fB6PlCmQ4kuDoQProlbHAMO13wIOIdMJkmiwtzGHRA7NYqXJs9OPxjuHYiho
         Kqud045/crx4jVzXazKTeMcTpIJ4aTFeK80Doep6MBWMTLO/UZGogbVvBHkPN53lrKQq
         sVJDWkTJlA3DPKLBxBiQh6sCbb77vUwb9ZVk48sozYn5Kj4TweMxQ4nL2I+quAQXPz5q
         +WpPzrWk1K8EaiQ5a1WTcwNo8ty0nSi5l4SmIPjzY57UM4P4QxK1yQCI12exS/Ppi7Nh
         xtMg==
X-Gm-Message-State: AOAM5303E97vE5VDkCjKFFoFlFc946VCyofTHojmMol+i7+B61m7+qiQ
        3Tu1fE1xu9gzj4P0oSDXhhI=
X-Google-Smtp-Source: ABdhPJzjdsLfosibFqefQs5Lrqw/fmLmF8ruBYTEeDJ/hbrpviG4kOHul5ZBVqG2Y929SydEwDBoVQ==
X-Received: by 2002:a05:6a00:1a03:b029:1d3:1fa3:4a5d with SMTP id g3-20020a056a001a03b02901d31fa34a5dmr2996903pfv.1.1613573795393;
        Wed, 17 Feb 2021 06:56:35 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:b8fb:8ce2:5aae:b58d])
        by smtp.googlemail.com with ESMTPSA id 190sm3064124pgh.81.2021.02.17.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:56:35 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [RFC] scripts: kernel-doc: fix array element capture in pointer-to-func parsing
Date:   Wed, 17 Feb 2021 20:26:25 +0530
Message-Id: <20210217145625.14006-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel-doc causes an unexpected error when array element (i.e.,
"type (*foo[bar])(args)") is present as pointer parameter in
pointer-to-function parsing.

For e.g., running kernel-doc -none on kernel/gcov/gcc_4_7.c causes this
error:
"Use of uninitialized value $param in regexp compilation at ...", in
combination with:
"warning: Function parameter or member '' not described in 'gcov_info'"

Here, the parameter parsing does not take into account the presence of
array element (i.e. square brackets) in $param.

Provide a simple fix by adding square brackets in the regex, responsible
for capturing $param.

A quick evaluation, by running 'kernel-doc -none' on entire kernel-tree,
reveals that no additional warning or error has been added or removed by
the fix.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly over next-20210217

 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e046e16e4411..8b5bc7bf4bb8 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1553,7 +1553,7 @@ sub create_parameterlist($$$$) {
 	} elsif ($arg =~ m/\(.+\)\s*\(/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
-	    $arg =~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
+	    $arg =~ m/[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)/;
 	    $param = $1;
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*?)\s*$param/$1/;
-- 
2.17.1

