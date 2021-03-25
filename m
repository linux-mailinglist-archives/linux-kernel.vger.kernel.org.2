Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985AA348E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCYKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhCYKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC83D619B8;
        Thu, 25 Mar 2021 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=IzAoCaIDnqs4WkY2d9+gWl+UVm60iWEc+pu/WlaQ3+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVWC8AVoQh7TUIZr6CoqE+VFRJDVr5aQTA38h5LJ/bApNKmz5Wz8+Qjq3uwG4CPn+
         nuarxA71PFSZRzALB214FBl62qjTtgUA23Gm/rleWRc3Wjc3PdxOO9cGfyqorvkbrC
         4Rz2Im+fy+SxetxvPh/m7jQJYmJp/I2MBxCIDnFffeBvHqFzDihTwN5iW8co0uZkKd
         UmMmzBIHdby5V0wUY6QVCU4oPCjYkPZvquOp4zPEIWD9Ki5U5ANPdFZPe+zLHTLdj1
         YAoYCtDCDzE+ex5/n7SkBNTcONViR7FaEc94ihuNRefEE899vBo+fE+1UvlK0Pk2V/
         rTtykqBbOP+IQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001AvY-91; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] scripts: get_abi.pl: extend xref match to other types
Date:   Thu, 25 Mar 2021 11:38:25 +0100
Message-Id: <a1c7e2b2c37ed6e111dfc8641deb37ed96375a63.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are "What:" symbols for more than just
/sys.

Extend the regex to also cover configfs, /proc /dev and /kvd
symbols.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index e87028257d1c..eb1a23103afa 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -285,7 +285,7 @@ sub create_labels {
 # Boundaries are punct characters, spaces and end-of-line
 my $start = qr {(^|\s|\() }x;
 my $bondary = qr { ([,.:;\)\s]|\z) }x;
-my $xref_match = qr { $start(\/sys\/[^,.:;\)\s]+)$bondary }x;
+my $xref_match = qr { $start(\/(sys|config|proc|dev|kvd)\/[^,.:;\)\s]+)$bondary }x;
 my $symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x2f\x3a-\x40\x7b-\xff]) }x;
 
 sub output_rest {
-- 
2.30.2

