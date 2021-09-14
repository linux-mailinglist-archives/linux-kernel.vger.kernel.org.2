Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C630440B0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhINOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233844AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9E2061168;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=KNBPNk1//mcnk2FNKBwWq1QXjN5szO00uqOSQNF0zz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEBQ0ImkcnLt22GjdBhi4T2j4TfO2OKXfHd6RYhDQSzO/U5AXJ1jVv32/r6hqyw4c
         PWYZXBzGGYOxrpU66D5dv3RG/skb0i99obvj98y9czITugasWWlcQwyIG9ySJnKjmU
         d5LXzPL5i9AzVOgvE0HyVrv/ki2ioEuxbC/anysDv1Zd0hRr262x4n6qzCLvUWFleR
         rWyI8IqAvOWbIeBJeE7Ogale2palrNYxET0+ra+PlV6Ov2rSyQq3zd0WMj/cUlGVn8
         QmgJabJGA/xiPRE1YJwyN3xCMDjbOY6smIXKCiVp8Uw9MGGmaGhStOL3ZHErQCsN/D
         HPElNpJu2YzQg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kkq-Pg; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tom Rix <trix@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/29] ABI: pstore: Fix What field
Date:   Tue, 14 Sep 2021 16:32:25 +0200
Message-Id: <b0ad4d3e915f2e1543b3037b43148b76d5480a37.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both /sys/fs/pstore/... and /dev/pstore/... are possible,
it should use, instead, two What: fields.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/pstore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index 5b02540781a2..d3cff4a7ee10 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -1,4 +1,5 @@
-What:		/sys/fs/pstore/... (or /dev/pstore/...)
+What:		/sys/fs/pstore/...
+What:		/dev/pstore/...
 Date:		March 2011
 KernelVersion: 2.6.39
 Contact:	tony.luck@intel.com
-- 
2.31.1

