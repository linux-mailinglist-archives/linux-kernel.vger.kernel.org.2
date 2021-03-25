Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D1348E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCYKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhCYKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D9A61A25;
        Thu, 25 Mar 2021 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=Ilkw96WNd8R2sx6UtKlPOLy9dxlFpMI4gUyi5XXst9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWKygQ5l0hgfs44qUMSTHfxFh1/HpHDSFMk2sgZxIjT4ugg+QWgnOFf8Q6Ly3ZPzU
         FqSN/3gwiBMb2UX86jw+Nn4zQDWWMsvq6Pna3PaGOL8U/AXuf2IIgKStsfEiZq58Oh
         G4HgE+sAJKwAvsuDLgRGQveGoTZyW3hxiYImcO7eE+5X/nPjv5f67JcYyIPFeezOzM
         dg901zrpUkGBK2uAi/Ch462XE9svNgIvuPVJumdsfiUBZQfO5Zz9xgAQ0ilEmRMmE+
         rMSqE2lu7M63x72z1r+KG7iBFhEAhiiW81XHoQOkbxHZWPAds9npeQdgTFGXX4r2ZA
         8+Bhi41vgx4tg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001AvU-6L; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] get_abi.pl: seek for all occurrences for Documentation/ABI
Date:   Thu, 25 Mar 2021 11:38:23 +0100
Message-Id: <17019b73e106d1b1b353b8880ed189bad3604c13.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of retrieving just one match at most, ensure that the entire
description will be parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index a9348b9bdaa4..3c82cd188368 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -380,7 +380,7 @@ sub output_rest {
 
 				$desc =~ s,Documentation/(?!devicetree)(\S+)\.rst,:doc:`/$1`,g;
 
-				my @matches = $desc =~ m,Documentation/ABI/([\w\/\-]+),;
+				my @matches = $desc =~ m,Documentation/ABI/([\w\/\-]+),g;
 				foreach my $f (@matches) {
 					my $xref = $f;
 					my $path = $f;
-- 
2.30.2

