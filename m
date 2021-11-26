Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8645F338
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhKZR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhKZR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:57:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E86C07E5E8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:22 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf54-00083N-9v; Fri, 26 Nov 2021 18:32:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] staging: r8188eu: simplify usb in ep handling
Date:   Fri, 26 Nov 2021 18:31:57 +0100
Message-Id: <20211126173205.21352-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code to detect and use usb in endpoints.

Martin Kaiser (8):
  staging: r8188eu: rtw_read_port needs no cnt parameter
  staging: r8188eu: only the bulk in ep is used for network data
  staging: r8188eu: get the rcv bulk pipe handle directly
  staging: r8188eu: remove code to get int in pipe handle
  staging: r8188eu: if2 is not used
  staging: r8188eu: remove ep_num array
  staging: r8188eu: don't store nr_endpoint in a global struct
  staging: r8188eu: require a single bulk in endpoint

 drivers/staging/r8188eu/hal/usb_halinit.c     | 24 ++++---------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 10 ++++----
 drivers/staging/r8188eu/include/drv_types.h   |  6 +----
 .../staging/r8188eu/include/rtl8188e_recv.h   |  2 --
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/include/rtw_recv.h    |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 24 +++++++++----------
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  6 +----
 8 files changed, 24 insertions(+), 51 deletions(-)

-- 
2.20.1

