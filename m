Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086323BC80A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGFIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:44:19 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:46803 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGFIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:44:17 -0400
Received: by mail-lf1-f49.google.com with SMTP id p21so15225951lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyUpgfzCUbJx1C57gm9KmP1EbMgOX/TnxFpGGqR1W7U=;
        b=UOAZUMhyYCAW3UICa+4oY8T0moHJlvTiXihYIPpk4vkr2IsQCAuCWCQ8CHbw8+/qlj
         5QTMH4KCBHZ0lP3msjKr73Fgeud978PM0dEiShoW/YOkeo4bMohuHDHoVD1IwShIJG0k
         CL5gqaM56KM6/grt38aTyt//FibfGN43ouZvo57swJc0x28TjytNy2tYplFoQVlAtel0
         YfIw+N4H224sqPMT44TKBModZa2WkRe2aNC+1Lspw6aP3AxtCJyqzmBQFqS/3N14E8uP
         AOQtKt5N8AhQ9RD7VUoQ1lwqg4uM5GWrCHFIJsoNC5R4syCXJDuqzNdxnVolhMTvl6cN
         PJAA==
X-Gm-Message-State: AOAM531NIUUp74pBfnG6BF8t6wfC5DIJLV981+UjLOYtyvZmFj5/CL4p
        4X7YqXuLO9juHQziCPSsD1VYTpSDaNYTeg==
X-Google-Smtp-Source: ABdhPJyrCnpayMZF8BAxaUeSsgl6Jw5KXb3K8o0HCVElnzLw9m6ceJtMPpVKQxvfuZDf5ZJW72Timw==
X-Received: by 2002:a05:6512:3499:: with SMTP id v25mr13816233lfr.612.1625560897161;
        Tue, 06 Jul 2021 01:41:37 -0700 (PDT)
Received: from localhost (88-112-11-80.elisa-laajakaista.fi. [88.112.11.80])
        by smtp.gmail.com with ESMTPSA id p14sm444396lfc.23.2021.07.06.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:41:36 -0700 (PDT)
From:   Hannu Hartikainen <hannu@hrtk.in>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Hannu Hartikainen <hannu@hrtk.in>
Subject: [PATCH] get_maintainer: only show lkml as last resort
Date:   Tue,  6 Jul 2021 11:33:55 +0300
Message-Id: <20210706083354.214826-1-hannu@hrtk.in>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation implies that patches should be primarily sent to a
subsystem-specific mailing list [0]. Make get_maintainer only return the
generic linux-kernel@vger.kernel.org ("THE REST") list when no other
matching mailing list is found.

Most patches sent to lkml today are also sent to some other list. This
change should lower the message volume on lkml in the long run, making
the list more useful for those cases where it's the only option.

[0]: Documentation/process/submitting-patches.rst:
> You should also normally choose at least one mailing list to receive a
> copy of your patch set. linux-kernel@vger.kernel.org functions as a
> list of last resort, but the volume on that list has caused a number of
> developers to tune it out. Look in the MAINTAINERS file for a
> subsystem-specific list; your patch will probably get more attention
> there.

Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
---

I'm not sure if this is technically the best solution so I'm looking
forward to review comments. But process-wise I think this should be a
good change. Looking at tutorials and such, many people seem to just
blindly run scripts/get_maintainer.pl and send their patches to all the
addresses the script outputs. This must inflate the list a lot, making
it difficult to follow and making it much more difficult to get readers
for patches belonging to the list (including this one, ironically).

 scripts/get_maintainer.pl | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..c0a8dd5dfdbf 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -627,6 +627,7 @@ my %email_hash_address;
 my @email_to = ();
 my %hash_list_to;
 my @list_to = ();
+my @list_the_rest_to = ();
 my @scm = ();
 my @web = ();
 my @subsystem = ();
@@ -951,6 +952,11 @@ sub get_maintainers {
 	}
     }
 
+    # if no other list would be printed, fall back to THE REST
+    if (scalar(@list_to) == 0) {
+	@list_to = @list_the_rest_to
+    }
+
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
@@ -1303,10 +1309,6 @@ sub get_list_role {
 
     my $subsystem = get_subsystem_name($index);
 
-    if ($subsystem eq "THE REST") {
-	$subsystem = "";
-    }
-
     return $subsystem;
 }
 
@@ -1355,8 +1357,13 @@ sub add_categories {
 				}
 			    } else {
 				$hash_list_to{lc($list_address)} = 1;
-				push(@list_to, [$list_address,
-						"open list${list_role}"]);
+				if ($list_role eq ":THE REST") {
+				    push(@list_the_rest_to, [$list_address,
+							     "open list"]);
+				} else {
+				    push(@list_to, [$list_address,
+						    "open list${list_role}"]);
+				}
 			    }
 			}
 		    }
-- 
2.32.0

