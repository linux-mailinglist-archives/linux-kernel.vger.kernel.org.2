Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41A380320
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhENEz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:55:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhENEz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:55:28 -0400
Received: from 111-240-128-202.dynamic-ip.hinet.net ([111.240.128.202] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lhPq1-00073z-W7; Fri, 14 May 2021 04:54:14 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v4 0/2] USB: propose a generic fix for PORT_SUSPEND set feature timeout
Date:   Fri, 14 May 2021 12:54:03 +0800
Message-Id: <20210514045405.5261-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

For the Realtek Hub which fails to resume the port which has wakeup
enable descendants, trying to propose a more generic and better fix
to have the runtime suspend/resume work instead of a reset-resume quirk.

Chris Chiu (2):
  USB: Verify the port status when timeout happens during port suspend
  Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"

 drivers/usb/core/hub.c    | 21 +++++++++++++++++++++
 drivers/usb/core/quirks.c |  1 -
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.20.1

