Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4FC40726E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhIJUXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:23:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB34C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:22:09 -0700 (PDT)
Received: from ipservice-092-217-077-211.092.217.pools.vodafone-ip.de ([92.217.77.211] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mOn2B-0005Wm-Qf; Fri, 10 Sep 2021 22:22:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] remove unused usb endpoint functions
Date:   Fri, 10 Sep 2021 22:21:47 +0200
Message-Id: <20210910202151.4007-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove driver-specific functions to detect the type and direction of a
usb endpoint. Their callers have already been updated to use the helper
functions from the usb core.

Martin Kaiser (4):
  staging: r8188eu: remove unused function usb_endpoint_is_int
  staging: r8188eu: remove unused function RT_usb_endpoint_is_bulk_in
  staging: r8188eu: remove unused function RT_usb_endpoint_num
  staging: r8188eu: remove the remaining usb endpoint functions

 drivers/staging/r8188eu/os_dep/usb_intf.c | 40 -----------------------
 1 file changed, 40 deletions(-)

-- 
2.20.1

