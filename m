Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54541B9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbhI1VxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243001AbhI1VxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:53:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BA26128E;
        Tue, 28 Sep 2021 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632865897;
        bh=HU2rIkn452EBEM7riX0Tb1eZUixsiqey2KImPfM+l5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9qRq5tb4xy9OkjD4dw/iYDtpw5WnSE55aNbHMyC1Rvmh1GeVQVsMZqCvp+XREky1
         TGQqJo0WwdzRO8FXLRwageGed/1CcO6rrCFjB+0WY/A7JLmmgrE/6Gyv+oaDgX+52i
         T5iUF5R/BbYAqb75qxPnrBRK3zfvntM/FD1fFbBGiXuh4N+W3W50VihczOOexDrB29
         OOvq2punZUr58wCaCxP2Ju5f7KqdVuu4uolmroGcZEVeM9Be2MgNNmiKFZGJ0zRB3W
         iv7iycTPwP+8mBr+HA9Amv//+9f4joQ4e5CXRN5bqK9nfxWHYpnTEOkb8M3xGwhwv2
         DysjJx3GoR4aQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVL0h-000mPl-7Z; Tue, 28 Sep 2021 23:51:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: get_abi.pl: make undefined search more deterministic
Date:   Tue, 28 Sep 2021 23:51:32 +0200
Message-Id: <5dc55fd42e632a24a48f95212aa6c6bc4b2d11fd.1632865873.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YVNOZ3GKcpRxPXzv@kroah.com>
References: <YVNOZ3GKcpRxPXzv@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort keys on hashes during undefined search, in order to
make the script more deterministic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 841d889747c0..d32dcd7cca5d 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -775,6 +775,8 @@ sub check_undefined_symbols {
 	my $next_i = 0;
 	my $start_time = times;
 
+	@files = sort @files;
+
 	my $last_time = $start_time;
 
 	# When either debug or hint is enabled, there's no sense showing
@@ -909,16 +911,16 @@ sub undefined_symbols {
 		}
 	}
 	# Compile regexes
-	foreach my $l (keys %leaf) {
+	foreach my $l (sort keys %leaf) {
 		my @expr;
-		foreach my $w(split /\xac/, $leaf{$l}->{what}) {
+		foreach my $w(sort split /\xac/, $leaf{$l}->{what}) {
 			push @expr, qr /^$w$/;
 		}
 		$leaf{$l}->{expr} = \@expr;
 	}
 
 	# Take links into account
-	foreach my $link (keys %aliases) {
+	foreach my $link (sort keys %aliases) {
 		my $abs_file = $aliases{$link};
 		graph_add_link($abs_file, $link);
 	}
-- 
2.31.1

