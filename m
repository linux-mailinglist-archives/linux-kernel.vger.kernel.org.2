Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F13195C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBKWXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhBKWWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:22:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309FC0613D6;
        Thu, 11 Feb 2021 14:21:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DF1F01F4604B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/2] docs: watch_queue: Fix unit of the notification size field
Date:   Thu, 11 Feb 2021 17:21:12 -0500
Message-Id: <20210211222112.1518161-3-krisman@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211222112.1518161-1-krisman@collabora.com>
References: <20210211222112.1518161-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the code and other documentation, the unit of size is
bytes.  Previously, the same documentation says bytes.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 Documentation/watch_queue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 426038e10276..75adb1874a0f 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -215,7 +215,7 @@ the following function should be used::
 
 The notification should be preformatted and a pointer to the header (``n``)
 should be passed in.  The notification may be larger than this and the size in
-units of buffer slots is noted in ``n->info & WATCH_INFO_LENGTH``.
+bytes is noted in ``n->info & WATCH_INFO_LENGTH``.
 
 The ``cred`` struct indicates the credentials of the source (subject) and is
 passed to the LSMs, such as SELinux, to allow or suppress the recording of the
-- 
2.30.0

