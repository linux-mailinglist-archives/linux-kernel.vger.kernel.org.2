Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AFC359CED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhDILPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234017AbhDILPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72EE26100A;
        Fri,  9 Apr 2021 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617966899;
        bh=0xBkD+he3W0F2fKoAl+j3RSucxzjZ3CqggJbCxWKyMs=;
        h=From:To:Cc:Subject:Date:From;
        b=aqXJjfr/VHOlXT+S2ZYsA0QaGeT9ICPv8Xl4SGtwN+QKUnE2NVlmLpfY9oW9FfoMo
         zkhS253XQ1OxDhQEeqx/RyX28lTL6C0meCfMxNLePWPvR83AVMQbklfxxZrEm2ySvR
         fef8naKcEw5f7kKyBVEr9SfmDsTuVUNSWQeXi0pIZ5k6WvCjpUvSKC67n5lKzv3ysc
         XzyHnokJ71we2qnWDmDxurt9JbIyXnyI+TYt/PFMRawawi2B9+YbseOgqKWcpN6PsP
         bWIq4ad3VP2LmbTD4UilplTMAx0D0bcfjM/Kzf1ez0h5FCwvfi0IKkAgpjVgsg9jDj
         umUbOKbv6K0sA==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH] mailmap: Update email address for Nicolas Saenz
Date:   Fri,  9 Apr 2021 13:14:53 +0200
Message-Id: <20210409111453.28121-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my kernel.org address for old email address.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 78835e80214a..b407e1192fb3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -260,6 +260,8 @@ Nguyen Anh Quynh <aquynh@gmail.com>
 Nicolas Ferre <nicolas.ferre@microchip.com> <nicolas.ferre@atmel.com>
 Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
 Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
+Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
+Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
-- 
2.31.1

