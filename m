Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3E37AA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEKPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhEKPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 726A56128E;
        Tue, 11 May 2021 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620745297;
        bh=jePJiKnUrenmcW2bcjH1VDz5dQntzoSjJz/YCuEOB5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kh6ICxcSVd2zJ2oJEljCBT1eCLje54LiNkCq9jR0RBqoxhaR4XXWw4YJ2eksFa8oH
         AzdsinQpqMkey8cdCQHwbPTNaZP3Xa5jtK54s0/HRROhqbVWjOy9Csta8MltYfw9mm
         mH1USoHiJ7oLj5UjcZgusB2HnnaeffdYbO9rfKUgYZ8yRMIFFb9h0JRv88H9KU3hqv
         Ws9LexjFSnE7MzuJE/qhBveeOz7N5fgLwIgcm8k7izTifAGhqqg3W7pqiLYONQMqFk
         cUwceWaB8yraRL7ujgOv+iK0aKzrx4+56pXv//S1lGRxfmRBLXDdEzxCY1poWk7gr0
         4EWBWrK9PoD+Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgTt7-000k15-Rt; Tue, 11 May 2021 17:01:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] docs: ABI: remove a meaningless UTF-8 character
Date:   Tue, 11 May 2021 17:01:29 +0200
Message-Id: <6cd3f0b47568fecb7889fd18d1d744c3aaf73866.1620744606.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two files have this character:
	- U+00ac ('¬'): NOT SIGN

at the end of the first line, apparently for no reason. Drop them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered  | 2 +-
 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
index 0360be39c98e..dae880b1a5d5 100644
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
@@ -1,4 +1,4 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.¬
+This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.
 
 What:		/sys/kernel/fadump_registered
 Date:		Feb 2012
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
index 6ce0b129ab12..ca2396edb5f1 100644
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
@@ -1,4 +1,4 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.¬
+This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.
 
 What:		/sys/kernel/fadump_release_mem
 Date:		Feb 2012
-- 
2.30.2

