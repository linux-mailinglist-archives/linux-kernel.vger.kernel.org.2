Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF994297F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhJKUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E981C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:22 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1ei-0004mk-PX; Mon, 11 Oct 2021 22:12:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] staging: r8188eu: more odm cleanup
Date:   Mon, 11 Oct 2021 22:11:51 +0200
Message-Id: <20211011201159.10252-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg and all,

here's some more patches to remove unused odm code.

This series should be applied on top of the series I sent yesterday
(starting with message 20211010175204.24029-1-martin@kaiser.cx).

Thanks,
Martin

Martin Kaiser (8):
  staging: r8188eu: remove dm_CheckStatistics
  staging: r8188eu: simplify rtl8188e_HalDmWatchDog
  staging: r8188eu: remove rtl8188e_deinit_dm_priv
  staging: r8188eu: remove LastMinUndecoratedPWDBForDM
  staging: r8188eu: SupportICType is always ODM_RTL8188E
  staging: r8188eu: remove odm_SwAntDivInit
  staging: r8188eu: odm BoardType is never set
  staging: r8188eu: odm SupportPlatform is always ODM_CE

 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  16 +-
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   5 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   5 +-
 drivers/staging/r8188eu/hal/odm.c             | 308 +++---------------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  69 ++--
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |   5 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  60 +---
 drivers/staging/r8188eu/include/odm.h         |  30 --
 drivers/staging/r8188eu/include/odm_precomp.h |  11 -
 drivers/staging/r8188eu/include/odm_types.h   |   6 -
 drivers/staging/r8188eu/include/rtl8188e_dm.h |   2 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 -
 12 files changed, 93 insertions(+), 426 deletions(-)

-- 
2.20.1

