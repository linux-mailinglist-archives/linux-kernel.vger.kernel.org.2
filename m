Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B97419565
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhI0Nvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234583AbhI0Nvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E52360F39;
        Mon, 27 Sep 2021 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750595;
        bh=/bOTaTmzGWeOrx1NvxdBUUcp7sjpew/tVp0sOd6hnug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2sAeA6eryJvSq866rse+8FBL6cA6CkUy9+hm51NPBXQUtNU6PM2Yz8P+zjwG88iV
         OjipCFk3ZisQEFdyW3/x/VT5xyu4/9m670olcer6izeYdSKnpD1R1JIRS+lkmQCXUC
         wZapp0mWJJ60RDHDPV6BEH2eRpvRY4QyNMTOiZNh0Ikg8FtGimLO3c0T8aB3ttfCJm
         OhXp1+vPQh571NkbJq9R7TmZLvy5tIagTvJNXVNpzr0Gz7s21f0j1C3aNDQmwOYwLY
         ntUoF1AeCeB8/tPvEppPl7OCv2G305A2btJRKeC50Lpphvsh4yL1LlToYDha+3j/Kf
         Im891uej+k0Yg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUr0z-000AjU-JN; Mon, 27 Sep 2021 15:49:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] scripts: get_abi.pl: produce an error if the ref tree is broken
Date:   Mon, 27 Sep 2021 15:49:49 +0200
Message-Id: <e7dd4d70e206723455d50c851802c8bb6c34941d.1632750315.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750315.git.mchehab+huawei@kernel.org>
References: <cover.1632750315.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic under graph_add_file should create, for every entry, a
__name name array for all entries of the tree. If this fails, the
symlink parsing will break.

Add an error if this ever happens.

While here, improve the output of data dumper to be more
compact and to avoid displaying things like $VAR1=.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632750315.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c191c024f052..26a3f8ff566a 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -27,6 +27,9 @@ my $dbg_what_open = 2;
 my $dbg_dump_abi_structs = 4;
 my $dbg_undefined = 8;
 
+$Data::Dumper::Indent = 1;
+$Data::Dumper::Terse = 1;
+
 #
 # If true, assumes that the description is formatted with ReST
 #
@@ -597,7 +600,6 @@ sub graph_add_link {
 
 	my @queue;
 	my %seen;
-	my $base_name;
 	my $st;
 
 	push @queue, $file_ref;
@@ -611,6 +613,12 @@ sub graph_add_link {
 			next if $seen{$$v{$c}};
 			next if ($c eq "__name");
 
+			if (!defined($$v{$c}{"__name"})) {
+				printf STDERR "Error: Couldn't find a non-empty name on a children of $file/.*: ";
+				print STDERR Dumper(%{$v});
+				exit;
+			}
+
 			# Add new name
 			my $name = @{$$v{$c}{"__name"}}[0];
 			if ($name =~ s#^$file/#$link/#) {
-- 
2.31.1

