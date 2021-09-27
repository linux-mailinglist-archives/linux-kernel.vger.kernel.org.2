Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC44195BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhI0OCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234706AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C395610E8;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=Sq6Z0jaQBAe5JA3Xg+ko8msje96k4/UZZLCUF2HAs60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNa0GTSsOzMJbvBjebymioBMmaXXqRQegQ7QOKHDwA+LyggC6i+dQWKUv6KGtz9l9
         GiUmPaD6IZTXDBBRpi8oYPF4LjqvuXhmM7rIzqM5r85b/DOJPISjXYILe8TlNinqkK
         6I55vh4bALpMPqsy/E21zN/QuXwaY0hgajyPgi3zNX1WhfaK0E6ws+NzIqW9XbrC3v
         gyNN48uVmmFDuMqpoJKurbBfVWCbTsJq9tJGB3K341BjDDUI8Cc0G+vVPCw2jr4TpO
         4zpw15lg/jS1SukGjrs/tuihtH3sLJB3Swor+u1+4M69W4JGycUn5HdDlIzs1xpIpN
         stfRbK1ABxDKA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Aty-Gx; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] ABI: o2cb: add an obsolete file for /sys/o2cb
Date:   Mon, 27 Sep 2021 15:59:40 +0200
Message-Id: <25210a6af51b65808e3f102f9f08c3f90b763801.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was renamed to /sys/fs/o2cb. Mark the old name as
obsolete.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/obsolete/o2cb | 11 +++++++++++
 Documentation/ABI/stable/o2cb   |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/obsolete/o2cb

diff --git a/Documentation/ABI/obsolete/o2cb b/Documentation/ABI/obsolete/o2cb
new file mode 100644
index 000000000000..fe7e45e17bc7
--- /dev/null
+++ b/Documentation/ABI/obsolete/o2cb
@@ -0,0 +1,11 @@
+What:		/sys/o2cb
+Date:		Dec 2005
+KernelVersion:	2.6.16
+Contact:	ocfs2-devel@oss.oracle.com
+Description:	Ocfs2-tools looks at 'interface-revision' for versioning
+		information. Each logmask/ file controls a set of debug prints
+		and can be written into with the strings "allow", "deny", or
+		"off". Reading the file returns the current state.
+		Was renamed to /sys/fs/u2cb/
+Users:		ocfs2-tools. It's sufficient to mail proposed changes to
+		ocfs2-devel@oss.oracle.com.
diff --git a/Documentation/ABI/stable/o2cb b/Documentation/ABI/stable/o2cb
index 5eb1545e0b8d..b62a967f01a0 100644
--- a/Documentation/ABI/stable/o2cb
+++ b/Documentation/ABI/stable/o2cb
@@ -1,4 +1,4 @@
-What:		/sys/fs/o2cb/ (was /sys/o2cb)
+What:		/sys/fs/o2cb/
 Date:		Dec 2005
 KernelVersion:	2.6.16
 Contact:	ocfs2-devel@oss.oracle.com
-- 
2.31.1

