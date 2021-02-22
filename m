Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7493432172C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhBVMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhBVMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:17:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D1364E67;
        Mon, 22 Feb 2021 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613996201;
        bh=aDrOIhhLPS8fdsbA/Tn0kJqNlUVarlzIKJs+IVnVuM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGq5tojpHN5CmV05hRgf5uKptNl6xmS1olybs5mxGCH5m1atqiQOQfzTRAuVXrXCG
         uvxgtynXMeXl7yr4f2HnukYD4d97+Ts93WNKIai70GveWMP6SNmpCLYZrAk0vSfPjg
         t3r9fDmy3TO4Z7hj5KhTUYsn7vbQiozfVeacLTBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.19 27/50] usb: dwc3: ulpi: fix checkpatch warning
Date:   Mon, 22 Feb 2021 13:13:18 +0100
Message-Id: <20210222121025.226447902@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210222121019.925481519@linuxfoundation.org>
References: <20210222121019.925481519@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

commit 2a499b45295206e7f3dc76edadde891c06cc4447 upstream

no functional changes.

Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/ulpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -19,7 +19,7 @@
 
 static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
 {
-	unsigned count = 1000;
+	unsigned int count = 1000;
 	u32 reg;
 
 	while (count--) {


