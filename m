Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DAE323268
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhBWUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:48:41 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54507 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234442AbhBWUsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:48:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9F0FE874;
        Tue, 23 Feb 2021 15:47:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 23 Feb 2021 15:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=45Wi2JFjp6wXfWMzxWLqv25emt
        NujViNpgl+b2pBUE8=; b=IBrjHrPyxlIZTMDQ65M71tcxCTc/qolqxn8uyOHsNK
        xpUpKut+wvd81qu8gCpG5pRNsU3ihfqeL2602nzl0ypmUlGFONZLECFUKus7BJpE
        xN1UKJDTuyzY0W9PJkSZSzMQenY8KGKDNQpMLTYDPUucRJaNdItNPIaEyoxOxMgk
        snFQMO/lX9S8WoH+PnUocb8PtgLA/BFlpfNKI0QD+4uQeNRogNK7zMFyYbN5ujhn
        L7EUuz6T9lIgHwR61aJuhMA/gesil0A72NtkWRgz/heX3/OEUhFAuz4EjUp9VAFJ
        E7/yMyM+8SBn+T++kQlTB6fUFixjUiEecSITCuU7C0nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=45Wi2JFjp6wXfWMzx
        WLqv25emtNujViNpgl+b2pBUE8=; b=NY9KzYrBer+4jHfEZM2h+P8tnwxfLfe1l
        TOUJbw1fzLu2KtdQ23qCM+oXBiV6tvjFx8draU/UCuIPf/U6TmHy36Q8/MHydiJ6
        botOajFNizzHZgx8gn+ebw6018Bp5EQ5Mo/O7foNljpvuKj/zEY7WB5jLKHeCAoU
        ViioxLqDKcXdHtcjHE65zFo9Q3QNy576mITOzm5r542TsYRiCn8XyrW59FzVjTI8
        mCnbpF/UTU9OHJb9m+93CTv0f/Bww/dyq/5s4FTwdmecJ2ixFEJxQ+hutcFP5hlY
        onVCcmHDdJFLnZYQkk/3yAAB9t5mMsVC2o4loqB4stxJZis6lsLpw==
X-ME-Sender: <xms:4Gk1YBF8MDPE62sT2c-e21UlwubXz62e6gxZmZoKkk9bBX9qZv6kzA>
    <xme:4Gk1YIWE6vSKFE3X1YN1RE1Yy9ASPKnZzNqAb4UsIaFsKYeSx6Tyqj0lTRpVcQpcU
    W3-32LyzRuOc-Lvlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghm
    ucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrthhtvg
    hrnhepffehieekueeileeufeeuteegveeugeejfeelhfevkefhhfdvtddvjedufeekfeeu
    necukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:4Gk1YMhr--PMRDuHKQJVG8WLFPZNuLG6iizcrW6d1RNhHxBsJ1Btdg>
    <xmx:4Gk1YJSJZ2Lfw-XPtNR-kFbBoCcsloZzqjWyj4poXKVmsJE1GI9tPg>
    <xmx:4Gk1YPF4y9l_E9-2_cdNnXLnvVMvg0MjMUzzH9LpaKe0WrPsvMjGvw>
    <xmx:4Wk1YJs65zhVBdAfkfzOnPkryIKqI05m0vrqhkYA7iaIStcpWc6Obw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48FD3240057;
        Tue, 23 Feb 2021 15:47:28 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] bss_ht struct cleanups
Date:   Sat, 20 Feb 2021 15:54:04 +0000
Message-Id: <20210220155418.12282-1-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the checkpatch issues related to the `bss_ht` struct
defined in `rtl8192e/rtl819x_HT.h` (avoid camelcase). The first patch
removes a blank line and the last patch reformats the struct a bit to be
more consistent with the other types defined in the same file.

William Durand (13):
  staging: rtl8192e: remove blank line in bss_ht struct
  staging: rtl8192e: rename bdSupportHT to bd_support_ht in bss_ht struct
  staging: rtl8192e: rename bdHTCapBuf to bd_ht_cap_buf in bss_ht struct
  staging: rtl8192e: rename bdHTCapLen to bd_ht_cap_len in bss_ht struct
  staging: rtl8192e: rename bdHTInfoBuf to bd_ht_info_buf in bss_ht struct
  staging: rtl8192e: rename bdHTInfoLen to bd_ht_info_len in bss_ht struct
  staging: rtl8192e: rename bdHTSpecVer to bd_ht_spec_ver in bss_ht struct
  staging: rtl8192e: rename bdBandWidth to bd_bandwidth in bss_ht struct
  staging: rtl8192e: rename bdRT2RTAggregation to bd_rt2rt_aggregation in bss_ht struct
  staging: rtl8192e: rename bdRT2RTLongSlotTime to bd_rt2rt_long_slot_time in bss_ht struct
  staging: rtl8192e: rename RT2RT_HT_Mode to rt2rt_ht_mode in bss_ht struct
  staging: rtl8192e: rename bdHT1R to bd_ht_1r in bss_ht struct
  staging: rtl8192e: reformat bss_ht struct

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  5 +-
 drivers/staging/rtl8192e/rtl819x_HT.h        | 23 +++--
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 58 ++++++------
 drivers/staging/rtl8192e/rtllib_rx.c         | 96 ++++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 12 +--
 drivers/staging/rtl8192e/rtllib_wx.c         |  6 +-
 6 files changed, 100 insertions(+), 100 deletions(-)

--
2.30.0

