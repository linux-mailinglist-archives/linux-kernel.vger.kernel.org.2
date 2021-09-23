Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6584B41664E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbhIWUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbhIWUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:03:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E9C061574;
        Thu, 23 Sep 2021 13:01:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so20424574wra.8;
        Thu, 23 Sep 2021 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUxsvSywYATF0ZbuEzEN98G8Ufj/uEueYTTCMkm//7s=;
        b=Ti6apDVSQZsmzI85j655wo3rfzUaUXGZxieDPgCnYPMCewcLMs6DlA/SplmRpeQwvr
         4wzAsk5XIhy8UWCIyUb25/c0Cfirc/7YwJFGgYVEQNAb5xW2df6TfXLjH7aPi2/MHg25
         OZgaHIltyCDJeSh8+DQAIxMKZLaAqxY0h3DFQ+BClHoNq+R2Hvm7K4TDdUe7ORgT0r/N
         ZNL6SQ4Rs8bUt8e0P4mfOp2gwW7iCGknYFlx8bLGYdRXekq8vmFSGoicCseuzyU6JgDJ
         1GaiNAVZPpBlJcomhsH+OVSxg9/3ly3uUqq9vpyhD0lwzq0o+bsbJujWTdWaosvFwwkS
         juLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUxsvSywYATF0ZbuEzEN98G8Ufj/uEueYTTCMkm//7s=;
        b=ztymrG0LM0+Bqx7fBiVbaNCN6T+AROAtvQjg99hbWrfuob7MFAaJvna4dHO3+0IT6s
         DdYqutpv8wlrh7egJuMtrKrgC/GetRDHzoQkKaISrIAOrkb4dsR+b8zg+sxMMfG/78fQ
         mh4PdGLAttmNXjh6SA3AEOMbeUz28vaA6EliXoeTx9lFj6CcOFjckfJ6VUqEaE/YeSxe
         99RtuFRM02XeHlFyfqlRjmgdbXYJPAoo0QJYVL21d9Uu0WHFEBmGyA7Q6/G8JXdpyPy3
         Hrajn3vL8XOn0KAZOfXZqzHLJlYmh3a7GPayegZ3hQPeJp/QNE7UnLnpd7HaPnUuFqHI
         ShzQ==
X-Gm-Message-State: AOAM533Q/HjP5rYoENzfX3+yxjTfrFwM28UOUO669T4l4LpM2pp0TdMu
        ZycVjgFvqIIGtfjyJAr02bo=
X-Google-Smtp-Source: ABdhPJy8glkruwTfarrIIpcL2FwAB3cpiGav0BcFFK3Phs4V7wy0WKIDnIa0tl0gO9ZzIyl5U3ODjw==
X-Received: by 2002:a05:600c:4c09:: with SMTP id d9mr18192798wmp.194.1632427294336;
        Thu, 23 Sep 2021 13:01:34 -0700 (PDT)
Received: from localhost.localdomain ([78.159.99.15])
        by smtp.gmail.com with ESMTPSA id y7sm3597391wrs.95.2021.09.23.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:01:33 -0700 (PDT)
From:   Leonard Crestez <cdleonard@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Count enum warnings for -Werror
Date:   Thu, 23 Sep 2021 23:01:12 +0300
Message-Id: <46192b4c4ef74b2130333b52a569bfa55f3a7f03.1632427198.git.cdleonard@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warnings about enum members were shown but not counted for -Werror, fix
by adding a few more increments.

Also fix a misindented line.

Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
---
 scripts/kernel-doc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cfcb60737957..1f22daafe44c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1425,10 +1425,11 @@ sub dump_enum($$) {
 	    if ($identifier eq "") {
 		print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
 	    } else {
 		print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
 	    }
+	    ++$warnings;
 	    return;
 	}
 	$declaration_name = "(anonymous)" if ($declaration_name eq "");
 
 	my %_members;
@@ -1440,19 +1441,21 @@ sub dump_enum($$) {
 	    push @parameterlist, $arg;
 	    if (!$parameterdescs{$arg}) {
 		$parameterdescs{$arg} = $undescribed;
 	        if (show_warnings("enum", $declaration_name)) {
 			print STDERR "${file}:$.: warning: Enum value '$arg' not described in enum '$declaration_name'\n";
+			++$warnings;
 		}
 	    }
 	    $_members{$arg} = 1;
 	}
 
 	while (my ($k, $v) = each %parameterdescs) {
 	    if (!exists($_members{$k})) {
 	        if (show_warnings("enum", $declaration_name)) {
-		     print STDERR "${file}:$.: warning: Excess enum value '$k' description in '$declaration_name'\n";
+		    print STDERR "${file}:$.: warning: Excess enum value '$k' description in '$declaration_name'\n";
+		    ++$warnings;
 		}
 	    }
         }
 
 	output_declaration($declaration_name,
-- 
2.25.1

