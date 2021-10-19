Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128544330AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhJSIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234772AbhJSIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 492F0613A4;
        Tue, 19 Oct 2021 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630672;
        bh=OLQmIGIa96dqOjXdQ2IruQsJW6tAzqr/YAsyfqvgLa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9B/TDwT0Qn7yEcTUBhZ5Fe4yT/XY+9+QmBYjYdHYbeHdN4CABZUaFuN+KJSALreT
         6LFpfAlinMeakg9tauHg9CadEOKSTc+heswFTGosVoGCEfPDcKIADR/cDi5aYA+Juo
         AS+4ymTXSzuFySdSs7vnpb+m2f18HgqCSkOOAzalv1rtLMAKKclV54T6h0uljBAl6x
         yICttUVdmkQp26JVTupOTskHmN1Eup/iBUNO+/iTN/XXWlTbEy8B/7mQugKCeuH3Kh
         vw73hGehxs68WGBmPrkIBNsl4MlseLZZEc7UGTBfTuolbWRwdSCnJTDSFzCQJVFKhD
         uCVUufzAUXmIA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJd-8a; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/23] docs: fs: locks.rst: update comment about mandatory file locking
Date:   Tue, 19 Oct 2021 09:04:16 +0100
Message-Id: <1dfcade1692df5435d4f0fd8e439a6e55cf44fa6.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mandatory file locking got removed due to its problems, but
the fs locks documentation still points to it.

Update the text there, informing that it was removed on Kernel
5.14.

Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/filesystems/locks.rst | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/locks.rst b/Documentation/filesystems/locks.rst
index c5ae858b1aac..26429317dbbc 100644
--- a/Documentation/filesystems/locks.rst
+++ b/Documentation/filesystems/locks.rst
@@ -57,16 +57,9 @@ fcntl(), with all the problems that implies.
 1.3 Mandatory Locking As A Mount Option
 ---------------------------------------
 
-Mandatory locking, as described in
-'Documentation/filesystems/mandatory-locking.rst' was prior to this release a
-general configuration option that was valid for all mounted filesystems.  This
-had a number of inherent dangers, not the least of which was the ability to
-freeze an NFS server by asking it to read a file for which a mandatory lock
-existed.
-
-From this release of the kernel, mandatory locking can be turned on and off
-on a per-filesystem basis, using the mount options 'mand' and 'nomand'.
-The default is to disallow mandatory locking. The intention is that
-mandatory locking only be enabled on a local filesystem as the specific need
-arises.
+Mandatory locking was prior to this release a general configuration option
+that was valid for all mounted filesystems.  This had a number of inherent
+dangers, not the least of which was the ability to freeze an NFS server by
+asking it to read a file for which a mandatory lock existed.
 
+Such option was dropped in Kernel v5.14.
-- 
2.31.1

