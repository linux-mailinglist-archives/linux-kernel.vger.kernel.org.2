Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABD348E33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCYKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCYKid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA47661A2C;
        Thu, 25 Mar 2021 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=wrrYLBWnyLJ2Nn2/jedot7XUqegfjMKZxIQEc4fg+/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEY8vW+9Slf6gLgA+h2dXSozXcZ8+eEiWspQtnx9c85U12GrG9sU0q89tVF/HRMtm
         eOj6ywd0K7eK3wP44zXryqUv1h6wOdPTGbEAUfihqIkRjxVDE5ZpUEy1DSZ+F4NfHE
         k6Q/iaLmlZYKCJgErGU4g+9unFfqVKTBnPwXz3Xo6LGiZhuul2aWy+0E1WWJ6/eRxC
         KWwJAqbWLghTYisJH/lqYnqXzAwlnKB8MkDo4PVfVXW3SevTHBns7U8uRw2z9A8hdz
         UZvNxeC7IdkYw+TkCxyAB5LzZlTGcmXH6EtKrY+9F/cwommMyOp0f9GwKvQ962e9d8
         vxCYrj0EIBNXw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001Avg-CW; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] ABI: sysfs-kernel-mm-cma: fix two cross-references
Date:   Thu, 25 Mar 2021 11:38:28 +0100
Message-Id: <87907316390311c6b42e86c3ba9fb2f2903d9499.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the text in order to generate cross-references for
alloc_pages_success and alloc_pages_fail symbols.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-cma | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
index 02b2bb60c296..86e261185561 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-cma
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -5,12 +5,10 @@ Description:
 		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
 		heap name (also sometimes called CMA areas).
 
-		Each CMA heap subdirectory (that is, each
-		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
-		following items:
+		Each CMA heap subdirectory contains the following items:
 
-			alloc_pages_success
-			alloc_pages_fail
+			- /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_success
+			- /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
 
 What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_success
 Date:		Feb 2021
-- 
2.30.2

