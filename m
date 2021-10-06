Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541AC423A40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhJFJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJFJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:12:06 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A548C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:10:13 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mY2wD-0006je-Nc; Wed, 06 Oct 2021 11:10:09 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: clean up PatchID / customer id
Date:   Wed,  6 Oct 2021 11:09:46 +0200
Message-Id: <20211006090949.1694-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series should be applied on top of the series I sent yesterday
(starting with Message-Id: <20211005200821.19783-1-martin@kaiser.cx>)

Thanks,
Martin

Martin Kaiser (3):
  staging: r8188eu: hal data's customer id is always 0
  staging: r8188eu: Odm PatchID is always 0
  staging: r8188eu: merge two signal scale mapping functions

 drivers/staging/r8188eu/hal/odm.c             |  7 --
 drivers/staging/r8188eu/hal/odm_HWConfig.c    | 65 +++++--------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  1 -
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 drivers/staging/r8188eu/include/odm.h         |  2 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 -
 drivers/staging/r8188eu/include/rtw_eeprom.h  | 55 ----------------
 7 files changed, 19 insertions(+), 115 deletions(-)

-- 
2.20.1

