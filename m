Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06F445DF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356492AbhKYRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347724AbhKYQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:58:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61DCC061371
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:47:58 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHud-0006ye-45; Thu, 25 Nov 2021 17:47:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: some trivial removals
Date:   Thu, 25 Nov 2021 17:47:41 +0100
Message-Id: <20211125164745.8188-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty functions and unused function parameters.

Tested on top of "clean up workers". Most likey, there's no conflicts
with my previous patches.

Martin Kaiser (4):
  staging: r8188eu: remove pm_netdev_open
  staging: r8188eu: remove _ps_open_RF
  staging: r8188eu: remove _ps_close_RF
  staging: r8188eu: loadparam needs no net_device

 drivers/staging/r8188eu/hal/usb_halinit.c    | 18 +-----------------
 drivers/staging/r8188eu/include/usb_osintf.h |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 15 ++-------------
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  2 +-
 4 files changed, 4 insertions(+), 32 deletions(-)

-- 
2.20.1

