Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785BF40A198
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhIMXgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhIMXf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:35:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:34:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso15064076ybj.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p2PhjhfGHPzRMVxAEYNgD/aavMWF7FNo4YbH8kVjAfs=;
        b=a3xaUwu2+vU/jm2XnXWRIje3mB6RH0kDujiREtfR7BZYAjcbrrdLzL/gpgriXOlXH8
         kENATyILFr904Ps620RkMdlNQ6LHIKA9wS5UEjc+p9xt7MX5zSpdmg5wdbEaZ1SWPoQZ
         BvX0G4TaDrNljvn+oW+RcGcmwegOLqQVjIPle3sybqZmwOnIXBiV7P+mq0lZP8VdasaP
         OrgCQtZJxlonFb0M9iE1jWIo/dXGPUVdoVdDRZWeLggd2rIpjHY55O1xWCOPxpiBBfU5
         9hnervHnmMX242Ap3M94WkOEfk4J4MGNBUUYqac2ce+CUx4mthn68WH0RpbUqny8aKAW
         ndyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p2PhjhfGHPzRMVxAEYNgD/aavMWF7FNo4YbH8kVjAfs=;
        b=txIpCzKhA7Z24flUjAlcD9Svz1my7/H/OWTm9bZafsshHcsfjnIogIXIJxBLQl/krO
         7KA81vxre+QqE/kwBQUhnY3+vXZHOCEQQaW+WZA9PsjG5QvCyghsGYoEzUlwnEVD3Q7V
         NjIZS12F63sFDTLMND12k+ZRMD+jxuMajOyX1Phc34T5Wc3I6CjrB1poBR9mLMZCeMal
         LoJSdl5mqN/bQfaOGF//hzmpzjaSTmZay8Awa5GjTNC3zEX8fwZZbz/ckrScHfGyPrs4
         WFiAlqeiy812rRWy1rngaSDIoKJYPHfsocO41ha05SrGtz82SKuCGeEUjALwYu0AKHkx
         Fj1A==
X-Gm-Message-State: AOAM531iielYMIlga5qqx0BjoHl9C+gB4dztF9L5kEF3n03LgY7nrk7D
        7DWaiXFfydYNF3BrLc81vdEBrWs=
X-Google-Smtp-Source: ABdhPJyDXoqlRGNoT1dnab3DsU6YHiEHLSvVDhKKv2IKHWRwwunxEwlpROdDdlIP8tUPO4YF7jxw1lE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f533:d5d5:c2b4:c981])
 (user=pcc job=sendgmr) by 2002:a25:bc91:: with SMTP id e17mr18515191ybk.218.1631576082609;
 Mon, 13 Sep 2021 16:34:42 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:34:35 -0700
Message-Id: <20210913233435.24585-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] get_maintainer.pl: support running from non-top-level dir
From:   Peter Collingbourne <pcc@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My workflow usually involves running scripts from a subdirectory of the
kernel source tree. This fails with get_maintainer.pl because it assumes
that it runs from the top level. Fix this assumption by setting $lk_path
appropriately based on a check of $0 similar to what is in checkpatch.pl.

This also requires fixing the VCS available checks to also check $lk_path.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I1ceda4106b3f90d8608fc7911079d2eda1c1a0c6
---
 scripts/get_maintainer.pl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..47474cb85ea7 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -114,7 +114,7 @@ my %VCS_cmds;
 
 my %VCS_cmds_git = (
     "execute_cmd" => \&git_execute_cmd,
-    "available" => '(which("git") ne "") && (-e ".git")',
+    "available" => '(which("git") ne "") && (-e "${lk_path}.git")',
     "find_signers_cmd" =>
 	"git log --no-color --follow --since=\$email_git_since " .
 	    '--numstat --no-merges ' .
@@ -154,7 +154,7 @@ my %VCS_cmds_git = (
 
 my %VCS_cmds_hg = (
     "execute_cmd" => \&hg_execute_cmd,
-    "available" => '(which("hg") ne "") && (-d ".hg")',
+    "available" => '(which("hg") ne "") && (-d "${lk_path}.hg")',
     "find_signers_cmd" =>
 	"hg log --date=\$email_hg_since " .
 	    "--template='HgCommit: {node}\\n" .
@@ -333,6 +333,10 @@ if ($email &&
     die "$P: Please select at least 1 email option\n";
 }
 
+if ($0 =~ m@(.*)/scripts/[^/]*$@ && top_of_kernel_tree($1)) {
+    $lk_path = "$1/";
+}
+
 if ($tree && !top_of_kernel_tree($lk_path)) {
     die "$P: The current directory does not appear to be "
 	. "a linux kernel source tree.\n";
-- 
2.33.0.309.g3052b89438-goog

