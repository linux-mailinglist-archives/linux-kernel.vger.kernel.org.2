Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC7416250
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbhIWPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242054AbhIWPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ECEF60F0F;
        Thu, 23 Sep 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411693;
        bh=3CsCCWh413B1aUjMg8I/otDBDvIVYcP91QWTDc+Aa5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqjEV+JThD3fvG7zcn/7n2NkBdCJ4spQy71GCSiVyJGCkoQ9rpSDy4JIoe07TDRER
         qDCGNKb9SyqbFqQ2VIWM+chjgEPwDwvw+LTLsm1lAiVMc55TXn9CgcJqNDpVHZcd9o
         ANhZlZTDy+q1UT4CsXQmN8UkrYxK6rJWmHCWtVJeifSW/7/T4BuwGtNOWHvXgepuDg
         wDUH3frBM+V3oLO7yrHlMciT6Mb/ohm/N/73dFr7u9zH52mHJVT5dBqFWI4h1mP9Bc
         /u4J3/u+rRezuOS6gOpc1c+BWU5pYHXSkBMmu2cmtOYmjlf5Fw2VldKU5dQS+s9DMz
         rzCu8mKfvZe8g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqp-000p6C-Mx; Thu, 23 Sep 2021 17:41:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] scripts: get_abi.pl: call get_leave() a little late
Date:   Thu, 23 Sep 2021 17:41:13 +0200
Message-Id: <a21631f8a884f50a962beafdd800f27891348d95.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
References: <cover.1632411447.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The $what conversions need to replace some characters to avoid
breaking regex expressions found on some What:.

only after replacing them back, the script should get the
$leave devnode.

Fixes: ca8e055c2215 ("scripts: get_abi.pl: add a graph to speedup the undefined algorithm")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 65261f464e25..9eb8a033d363 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -777,8 +777,6 @@ sub undefined_symbols {
 			# (this happens on a few IIO definitions)
 			$what =~ s,\s*\=.*$,,;
 
-			my $leave = get_leave($what);
-
 			# Escape all other symbols
 			$what =~ s/$escape_symbols/\\$1/g;
 			$what =~ s/\\\\/\\/g;
@@ -790,6 +788,7 @@ sub undefined_symbols {
 			# Special case: IIO ABI which a parenthesis.
 			$what =~ s/sqrt(.*)/sqrt\(.*\)/;
 
+			my $leave = get_leave($what);
 			my $added = 0;
 			foreach my $l (split /\|/, $leave) {
 				if (defined($leaf{$l})) {
-- 
2.31.1

