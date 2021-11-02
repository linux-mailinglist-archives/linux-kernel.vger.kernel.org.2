Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDF442934
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKBIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:21:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA6C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:19:01 -0700 (PDT)
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mhp0Q-0007h9-JV; Tue, 02 Nov 2021 09:18:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: remove odm wrappers to read/write bytes
Date:   Tue,  2 Nov 2021 09:18:28 +0100
Message-Id: <20211102081833.18054-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the odm wrapper functions to read or write bytes. Call the
underlying rtw functions directly.

Martin Kaiser (5):
  staging: r8188eu: remove ODM_Read1Byte
  staging: r8188eu: remove ODM_Read4Byte
  staging: r8188eu: remove ODM_Write1Byte
  staging: r8188eu: remove ODM_Write2Byte
  staging: r8188eu: remove ODM_Write4Byte

 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 10 ++---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 43 ++++++++-----------
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   | 30 -------------
 .../staging/r8188eu/include/odm_interface.h   | 10 -----
 6 files changed, 26 insertions(+), 71 deletions(-)

-- 
2.20.1

