Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0C31BB33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBOOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:36:17 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:48838 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230158AbhBOOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:36:14 -0500
Received: from tech.aim-sportline.com ([185.56.157.72]:34080 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lBeyF-00GYMx-5T; Mon, 15 Feb 2021 15:35:27 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/5] docs: iio: fix directory naming
Date:   Mon, 15 Feb 2021 15:35:08 +0100
Message-Id: <20210215143511.25471-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215143511.25471-1-luca@lucaceresoli.net>
References: <20210215143511.25471-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This directory is a, well, directory, not a file.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/iio/buffers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 3ddebddc02ca..9f7dc245d37a 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -28,7 +28,7 @@ IIO buffer setup
 The meta information associated with a channel reading placed in a buffer is
 called a scan element. The important bits configuring scan elements are
 exposed to userspace applications via the
-:file:`/sys/bus/iio/iio:device{X}/scan_elements/*` directory. This file contains
+:file:`/sys/bus/iio/iio:device{X}/scan_elements/` directory. This directory contains
 attributes of the following form:
 
 * :file:`enable`, used for enabling a channel. If and only if its attribute
-- 
2.30.0

