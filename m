Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE69A308273
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhA2Afv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:35:51 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:42702 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231204AbhA2AdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:33:23 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C912B80D7;
        Thu, 28 Jan 2021 16:31:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C912B80D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611880276;
        bh=Fbk9USW8Nu9kdu4dFY9vLqMkamDEPD9pW/bTjAsJrl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZynOoBLcF+8tK60Fe83KDX7rTwvmbxhXSvGsyHUsccb2mkl8Owurha8NMS+sMeMOs
         ubzYJYAoVN+U9oieLfDuy6QrT4A8gzkm6Cqs2sf4LbenGC9Dwy9DydxmIpxynOjI2b
         BnLlyjFXzlJw7XNm/EPSByrx/EmwnEUZxIj42EKA=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v10 12/13] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Thu, 28 Jan 2021 16:30:28 -0800
Message-Id: <20210129003029.10672-13-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129003029.10672-1-scott.branden@broadcom.com>
References: <20210129003029.10672-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..76f3817cf22c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3744,6 +3744,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

