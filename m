Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B325141ACB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhI1KPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239952AbhI1KPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F8936113E;
        Tue, 28 Sep 2021 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632824050;
        bh=x3Vwlgw4ZPtyHaYJOkNR9XD5Hyws0tTR/KbuT7n9iOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHniXu7E5rR29QNodFvJIdykV5A7N0X6uZdBJU718iZyOqRO4D2FDdK7/rFmDfAg5
         XL6ubZgSNntKEKntEcHVrXhiqowYH8BFOl+lo6w8lkErn7LjkVDRbZVK7SHDKK6iBs
         4ivd/c+Vhn6OLDexxJAnq4N0r9hBOTkzy/l+d+zo4jrJs6p/oJoGXDru4lAjYxRpx6
         321Z+R3i/BJHf7aazZ7hEwmEQ0Oxjft35V8WdJpQgfezybG58OfHDlF0dvDhqGt87Z
         w5GrrfPX1bfPPiUfRmJ+6Sf/CtpX1G51yAJy95//JyqKKU39kU0VkJQFxG+89p/3Vg
         k9YMHN3lkUBVQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVA7k-000Ti6-Gl; Tue, 28 Sep 2021 12:14:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ABI: evm: place a second what at the next line
Date:   Tue, 28 Sep 2021 12:14:04 +0200
Message-Id: <1f1e29ccdc0dd0ec089a67b8a4e9650517c6137a.1632823172.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632823172.git.mchehab+huawei@kernel.org>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, get_abi.pl was using spaces to separate What: parameters,
but there are several references that declare things like:

	/sys/class/powercap/.../<power zone>/enabled

So, the logic was changes in order to properly address it.
That broke the second What added by
Changeset 18e49b304633 ("ABI: security: fix location for evm and ima_policy").

As the only file that defines multiple What: at the same line is
this file, let's move the second What: to a separate line.

Fixes: 18e49b304633 ("ABI: security: fix location for evm and ima_policy")
Fixes: ab9c14805b37 ("scripts: get_abi.pl: Better handle multiple What parameters")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632823172.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/evm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 4b76a19b7bb4..44750a933db4 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -1,4 +1,5 @@
-What:		/sys/kernel/security/evm /sys/kernel/security/*/evm
+What:		/sys/kernel/security/evm
+What:		/sys/kernel/security/*/evm
 Date:		March 2011
 Contact:	Mimi Zohar <zohar@us.ibm.com>
 Description:
-- 
2.31.1

