Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E5320D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBUUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:12:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59375 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhBUUMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:12:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C7BA05C008D;
        Sun, 21 Feb 2021 15:11:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 21 Feb 2021 15:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=erQ4aLlXdSLCQDO88xDFv3qgQA
        2+7qeoglQ68NDOqi8=; b=hu30NFH4CXD2PDv0+5Sj/mH+unPN1XmNDIgWqxZOli
        PcEwSHbnDToAbJyP7iqZkz/OfJB2Nn+03zmdwHpcXKkQsCy+0TRifRLMBCnAX5ZX
        nNm28aAQxfoEBSqGqk+V5jnoCOCzo67WnnNlTvgrpuhFJKIfnW+aXzYteyCpszWN
        3thidWC1t+iaRSaqGTPJGlfnFIczcw+G9fz12TmHjaLk9gLLG1YRVc2HVDHI+9LA
        k4bew172fwob8Hu5XNxz5gazQDQX/LrQNQvg9sRlUvhCwD2qVaMaFkfwQX7uAU69
        pTPNrqQzx6qxcq9wQgvWDLGfnScDvUePC7lxQ4mSvVMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=erQ4aLlXdSLCQDO88
        xDFv3qgQA2+7qeoglQ68NDOqi8=; b=BrilrTiSuv6m0zheL1WbYVluGWbC148hB
        y1YhtbJ14WHcfnW1df7u4FDDq8N+csP4uR94XzKKCyZLg/kxcATKagFG+lvALL/D
        uPw89jLkSDahWDdK2ckFO9P9pV0rlUFw77PV97k1Te2TSF/ZhSMc+quDV5/TaA8L
        GR9eknnt/mBExIw9xlF+l0cFbrBiuFYRKp849XlKkj5/QDtpKrcUDQJ4xLmjzKSh
        ITRWidfV1ZmK+uuv8Jn9Jk0kuC/RKVrBvrb/N/j6YnMqKbZaeKSgGgtADMLlFVtF
        6L8sVWzpPLK3r21jrToauCzIhpWYTs/g4R6FT367qBfrT9ST4YhGA==
X-ME-Sender: <xms:Zr4yYDUgijwNm8XFk0gsjDDKGGyCXGz3ZR-47ArIX3aRPFVPia4EmA>
    <xme:Zr4yYLlwkc7KGDlU_TE8Dqc1ld9hAT62Sx64wolNzaBkr3p7_P8OZgbi8GUvB5u3W
    xeeFdAWnuZrY2EfAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedugddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghm
    ucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrthhtvg
    hrnhepffehieekueeileeufeeuteegveeugeejfeelhfevkefhhfdvtddvjedufeekfeeu
    necukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:Zr4yYPaMH-85EMCjpwcrqqVjdPSq06_At0bzAQAwS8pEQA3RPIGizQ>
    <xmx:Zr4yYOV0v7SLhNc5wam0o8jq-_pOyZVpyydjv3ih1irPbYBD1m6jdA>
    <xmx:Zr4yYNlH6o1N-6uZW-4bxilq9xI1cB8OMMkCI2n18qWvTXHsENQOWg>
    <xmx:Zr4yYMsSeb2cGk12_P4s3K17C9qKUapplpMx2cP5Yk3HprITWL9UVQ>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id E55B7108005F;
        Sun, 21 Feb 2021 15:11:17 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8192e: ba_record struct cleanups
Date:   Fri, 19 Feb 2021 23:11:21 +0000
Message-Id: <20210219231128.27119-1-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the checkpatch issues related to the `ba_record`
struct defined in `rtl8192e/rtl819x_BA.h` (avoid camelcase). The last
patch reformats the struct a bit to be more consistent with the other
types defined in the same file.

William Durand (7):
  staging: rtl8192e: rename Timer to timer in ba_record struct
  staging: rtl8192e: rename bValid to b_valid in ba_record struct
  staging: rtl8192e: rename DialogToken to dialog_token in ba_record struct
  staging: rtl8192e: rename BaParamSet to ba_param_set in ba_record struct
  staging: rtl8192e: rename BaTimeoutValue to ba_timeout_value in ba_record struct
  staging: rtl8192e: rename BaStartSeqCtrl to ba_start_seq_ctrl in ba_record struct
  staging: rtl8192e: reformat ba_record struct

 drivers/staging/rtl8192e/rtl819x_BA.h     | 12 +--
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 96 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  4 +-
 4 files changed, 59 insertions(+), 59 deletions(-)

--
2.30.0

