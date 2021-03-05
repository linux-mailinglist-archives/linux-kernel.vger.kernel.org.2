Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337D32F256
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCESU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCESUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:20:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08404C061574;
        Fri,  5 Mar 2021 10:20:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 16so1204963pfn.5;
        Fri, 05 Mar 2021 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3CVrexvlnJ9koHqsw9KISnLFg3fxWfnmtiSsGGgZ+Gc=;
        b=TlPYtjeJWQ1c3yJnKjXXITsVClv1F3kvPBiYsCoBCdz4D4EIpe/zbuA5XvPZFQXZSh
         2peqSH/mV3qxpe/mLX/DCYLJed3J4Go8mocRrlP9KCkvAxjawMlXZ40vxIPUpX3IsN6u
         f3rEt2iEvgKbE0362T8zKJGI4oMwQ61azL+jFF2heJkCujqJv6kQN9n/tlNnBJ6uyKQP
         XUqXpEDaGJewbJu+ad80v8yG8gfNQxfUSQYgoUcwExwX+eFpJWngK7ICpGOcmFxRXUgq
         XYqiMW8n2d5RWtYgrvQJxnxKBTft9Sds8zoy0GHmtD+5Z9jTFP8IyYORaJoR3EM+h6OP
         p7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3CVrexvlnJ9koHqsw9KISnLFg3fxWfnmtiSsGGgZ+Gc=;
        b=MEOR9cDnJp1xf0u+LNT/Yza5bxw95NoxFqwZVvKrNaozdxI3cR4qL5X5NBLa6DwLmS
         7kG7yoUsL+G1HxTB3KEy74DFw9NTQKY8gMZklvhWWhVfOdlwbVNxGFFLT0kd9wSIltuZ
         E8npB5PV1g78cuylWG4q03oyCEd+IC9JfnDbJE/1wfaGS3a2zlrNRplStIWO7ufll+7S
         cd6LEzGCVgCqMZvfvV+uK6W44apj95T81dgjFCow0jpIdThvQSgSkmEeSs8g9LIJFI0x
         nrvFcfhCfjUuyqHpcKwjKGU1i+Zsq4r3GYxe0TC/4ZGird+B3ojZ6kCgP81yEkoYNGVB
         0pQg==
X-Gm-Message-State: AOAM532PUKsHxTHet1ug2HtFIlheWPfa+avKACP6OTEkDL07Ecx8oe1w
        9YvGbJOkpNsWEYd3tm6Kxx8=
X-Google-Smtp-Source: ABdhPJxF4cp8/nCAppH0weT0KuimOzvtzq1ghNdldIGUP+NU/zbPHXfFhVf1+8umlgbBW50RkHGzLQ==
X-Received: by 2002:a63:db10:: with SMTP id e16mr9966734pgg.234.1614968409376;
        Fri, 05 Mar 2021 10:20:09 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:58af:ffb4:5a90:f2bc])
        by smtp.googlemail.com with ESMTPSA id mp19sm14581545pjb.2.2021.03.05.10.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:20:08 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC] scripts: kernel-doc: fix attribute capture in function parsing
Date:   Fri,  5 Mar 2021 23:50:00 +0530
Message-Id: <20210305182000.8363-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel-doc warns for function prototype parsing on the
presence of additional attributes in the definition.

E.g., running kernel-doc -none on include/rdma/iw_cm.h causes this
warning:
"warning: cannot understand function prototype: 'const char *__attribute_const__ iwcm_reject_msg(int reason); '"

Here, the prototype parsing does not take into account the presence
of attribute, "__attribute_const__" before function name.

Provide a simple fix by adding "__attribute_const__" in the corresponding
regex expression.

A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
that no additional warning or error has been added or removed by the fix.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/kernel-doc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 68df17877384..8673dc783309 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1753,6 +1753,7 @@ sub dump_function($$) {
     my $prototype = shift;
     my $file = shift;
     my $noret = 0;
+    my $attribute_const = qr{__attribute_const__};
 
     print_lineno($new_start_line);
 
@@ -1808,7 +1809,7 @@ sub dump_function($$) {
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s*\*+$attribute_const?)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-- 
2.17.1

