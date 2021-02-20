Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158793244ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhBXUJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:09:16 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37377 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235325AbhBXUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:08:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 94386715;
        Wed, 24 Feb 2021 15:07:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=a4SvWZ4mRnZQjwvZsd0BmDkuU2
        RvVRgdRXdczOv4N3U=; b=H/PfSYqv2EX+frCX9pQVTppCsS829F6g5iHH8EXliM
        6/juUH8Ev/zcnDezNSUOoAkRM0XTHi71CncyUusJ1mFy04G5IQ0u92maGq32eAQL
        7CV+hX66Xur+2CsaifYF0lfgkyEI5O88z768DDYcETHZaOnxWVD4I5e3VfCPS/88
        RCJVZCGOuyPfWKDo9DrLMBiJifMtj7kH0nS5KS4jhQWBp+/pMk6c8A6svxFQGxiQ
        rCoPFC/MT+PSbN6pi/ZN6F/mQ+kkWLxMKUbFV1ojdwMqjhInYugaOEut7RAFiX6h
        YR+3Q0SSKEIVz6cB08FSzSanqx0aKoUIkJwW4B7jW58A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=a4SvWZ4mRnZQjwvZs
        d0BmDkuU2RvVRgdRXdczOv4N3U=; b=C2NZDp3nI59LogqwWT38JRdCjV0fohFy4
        WGW//m6F8LcwHLW3DlY73Advpf4XPskI6fphftUJqDeST0BTHGyyMc8jQRyvXa81
        dmlO70SNh6owywdEslunWfWgvwNVZRldfufUB/HLoZ9Txq221H/B3RC9u243FMzl
        C0aUsZVOWU0K89YPK2qj3Po7OWRpaR1qYPoz/RvQvQ6lEfYnOQB5a3H7xYjSAVFU
        +RPSbfAUlePYxyuNCA5ZFqiiYKww0LOQ5UcB6POuY7Z4GXh7dYdcjgix5IXV4ZRj
        fI+gCgibZZjkI3ueuXklw9uKn0jh6O/Z24EX7q49aRIDP9rhCI6eQ==
X-ME-Sender: <xms:D7I2YLjntuFD8bHN1A6GyildG5Pzl5Iei-aWamM5kOe_ykA-Yjoj-g>
    <xme:D7I2YIAVpuRu8_Xf0yqqX5xVzN3JkIdogsd8EerZKO2nIoJxXcMYp9zyZETI4ma93
    SNY6_X88KruqPCU_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghm
    ucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrthhtvg
    hrnhepffehieekueeileeufeeuteegveeugeejfeelhfevkefhhfdvtddvjedufeekfeeu
    necukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:D7I2YLF_aFsqF5MLuNy0qia91aFn1FG8s_3dH6eVRl__eHng6Mp2Bg>
    <xmx:D7I2YITQRkj5eUQrLtZhBMTJWCqlM94yt9pPEcuZ47e5-RoEKXvk5w>
    <xmx:D7I2YIwkcVPjlNx9mY3PD5lkxwe5jt-PQHmQ2KlFMkhybzXn8nY7gg>
    <xmx:ELI2YOaBqTv-Y7xKRQ6tamvO9Y4el7lMPC28Mvc1mXkLV-Krn2qsGg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49D6C108005F;
        Wed, 24 Feb 2021 15:07:43 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] bss_ht struct cleanups
Date:   Sat, 20 Feb 2021 17:28:56 +0000
Message-Id: <20210220172909.15812-1-will+git@drnd.me>
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

Changes in v2:
  Updated commit messages as per Dan Carpenter recommendation

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

