Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2B45EF60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377716AbhKZNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbhKZNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:47:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B0C0619D4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:04:21 -0800 (PST)
Received: from dslb-178-004-171-146.178.004.pools.vodafone-ip.de ([178.4.171.146] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqatk-0006Hl-Ee; Fri, 26 Nov 2021 14:04:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/4] staging: r8188eu: some trivial removals
Date:   Fri, 26 Nov 2021 14:03:56 +0100
Message-Id: <20211126130400.26151-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125164745.8188-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty functions and unused function parameters.

Tested on top of "clean up workers". Most likey, there's no conflicts
with my previous patches.

v2:
 - add Michael's Reviewed-by tags
 - remove _ps_open_RF prototype

Martin Kaiser (4):
  staging: r8188eu: remove pm_netdev_open
  staging: r8188eu: remove _ps_open_RF
  staging: r8188eu: remove _ps_close_RF
  staging: r8188eu: loadparam needs no net_device

 drivers/staging/r8188eu/hal/usb_halinit.c      | 18 +-----------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  1 -
 drivers/staging/r8188eu/include/usb_osintf.h   |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c      | 15 ++-------------
 drivers/staging/r8188eu/os_dep/usb_intf.c      |  2 +-
 5 files changed, 4 insertions(+), 33 deletions(-)

-- 
2.20.1

