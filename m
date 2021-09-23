Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1825B41624F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbhIWPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242022AbhIWPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B16D60E8B;
        Thu, 23 Sep 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411693;
        bh=+EyXKl8VzkXaHJWK73eNZryPv9njKJxmuXis83Au4Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyLdC/4u/xN5FsRjBKemZeSBYrqTtHDMsftdKJwj95rJb0L/Vnn/rMlzcxZ4wJl+L
         hjF8W0entvb2/st4jchL3ERtq153q/xEmryTvEcI2XobNS2s2/S88b9SZG6aHCzSZ7
         6MYWZuXaXgmtEHWHhVfYptJeGJzvPDIrFR4m7DKpqXTFbOXM1DW3uz5AYvP/r2mOX6
         LkhSa8TI4Bf2YJbbgdKUiF2jeWTe6SFvwI08jfY63x6d7dcTOjUt3vHzNNl30doozo
         3znScVSarL0khGCxiAYMz4Qzzsdn9ic5cijJ4ozKlIEnWzc6AsEq6+7mcEv3B5weFS
         bN9tIWcEY0b9g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqp-000p69-LP; Thu, 23 Sep 2021 17:41:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] scripts: get_abi.pl: Fix get_abi.pl search output
Date:   Thu, 23 Sep 2021 17:41:12 +0200
Message-Id: <fb27ac372e38f5ae9d088f9f4e9710c659e0b9e8.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
References: <cover.1632411447.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the get_abi.pl will print an invalid symbol
(\xac character). Fix it.

Fixes: ab9c14805b37 ("scripts: get_abi.pl: Better handle multiple What parameters")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c52a1cf0f49d..65261f464e25 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -501,6 +501,7 @@ sub search_symbols {
 
 		my $file = $data{$what}->{filepath};
 
+		$what =~ s/\xac/, /g;
 		my $bar = $what;
 		$bar =~ s/./-/g;
 
-- 
2.31.1

