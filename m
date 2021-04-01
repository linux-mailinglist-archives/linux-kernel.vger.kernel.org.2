Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA51A351E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhDASfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238898AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 824EF611F2;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=Y8Sbo9hVCbxTKSZ3zBFEyFuLdewEeU0DD4dDrcxymF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmXJNkMDY6HjzWIpoy0p2LCBxwlOqEEt6xAj60aeGL/k5ZOXg8edAZgjaThxHz3+1
         8bjY/8yuiwRvtWue1O2n3R67vGOdtPc2uerijwSRwnurgfL5kqEbPfi3BznuSYqGnc
         OexgBFaq61MtJ9rZmpF5NwR7W5RsR9LAYjXFbYeFREEBNWtL2eNMs2Y4bo02Kg+KQg
         HoIRs1osqCoXVhOaDOtwbkE/k/dCKDzbCxHnQ7cGzzsVAA0GM5BMGbsZrmQovtBjID
         9UHzj3FbyuBDVqJQSCn+6l2XG27EDo6waC1eQUt9KUP5bFfrJwfT+Gux8TPSH/t+yg
         yGzmFDyuRF5kg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3e-Jw; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/32] docs: dt: update writing-schema.rst references
Date:   Thu,  1 Apr 2021 14:17:49 +0200
Message-Id: <7cfddf303f1508d26f90d87546d3812faebfc5ba.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
renamed: Documentation/devicetree/writing-schema.rst
to: Documentation/devicetree/bindings/writing-schema.rst.

Update the cross-references accordingly.

Fixes: b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
 scripts/checkpatch.pl                                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index ee4feb53f8d0..104fa8fb2c17 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -25,7 +25,7 @@ I. For patch submitters
 
        make dt_binding_check
 
-     See Documentation/devicetree/writing-schema.rst for more details about
+     See Documentation/devicetree/bindings/writing-schema.rst for more details about
      schema and tools setup.
 
   3) DT binding files should be dual licensed. The preferred license tag is
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4dbda85fd7e5..3870c8a01987 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3245,7 +3245,7 @@ sub process {
 		    ($line =~ /^new file mode\s*\d+\s*$/) &&
 		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
 			WARN("DT_SCHEMA_BINDING_PATCH",
-			     "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
+			     "DT bindings should be in DT schema format. See: Documentation/devicetree/bindings/writing-schema.rst\n");
 		}
 
 # Check for wrappage within a valid hunk of the file
-- 
2.30.2

