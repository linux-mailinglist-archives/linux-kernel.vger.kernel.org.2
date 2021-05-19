Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88023889D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbhESIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhESIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5466861028;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=LAyiT2kPFXdcExzvSYlhQSg1DZBXNovdWpdLyvOeGfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvgOJQlsq1IS/yOzrVjz+UIPraPm67J1JCayyM9gvi8TkIt9qnNCGK4izYgGrlUKE
         AVUBVI9NNCBbhK7b4b8ykgqAis6nqY6dA7/5emQqXcEYxLXSh/387IoXsVyHMN7ySo
         D967fJdT0ChIxoV75iM79Xn28ZEi7jOb+lKrCxWHvCN6koYyIQ8favsGpDFAxrDJOb
         pf3AH1GnRwV+/u9qcKt+cDHP36av2PezV4LpmxcfXLyNfD+HxL9LVufaeiciFSo4v0
         57rvKQGTdBNmEhwyFgPGjOP9WaaoieF+GZ4DqjWDBWWyrlIe+kfobGX6pE084ZEhJ3
         zm3yUAGLYS3tw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gXy-As; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] docs: update sysfs-platform_profile.rst reference
Date:   Wed, 19 May 2021 10:51:38 +0200
Message-Id: <295089effd8353578b9725c61c0453d920978d72.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/ABI/testing/sysfs-platform_profile.rst
should be, instead: Documentation/userspace-api/sysfs-platform_profile.rst.

Update its cross-reference accordingly.

Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
Fixes: 8e0cbf356377 ("Documentation: Add documentation for new platform_profile sysfs attribute")
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/platform_profile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a6329003aee7..e5cbb6841f3a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -2,7 +2,7 @@
 /*
  * Platform profile sysfs interface
  *
- * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
+ * See Documentation/userspace-api/sysfs-platform_profile.rst for more
  * information.
  */
 
-- 
2.31.1

