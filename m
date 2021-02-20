Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D573244F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBXUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:09:45 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44435 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235297AbhBXUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:08:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C99C98EF;
        Wed, 24 Feb 2021 15:07:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=RYLufI04OScg/
        q2h48yuGO/OEesMeqFUtY3MNWzcEh8=; b=Bh0jimy7vnixVQ9Pz6DTiLhm4hMbL
        Nv217Da+jFskg8R/MzfyHAwR6ayNqHg8GAAxTtGf1R3vHSbZGih8Mk5nfD1tgOqZ
        tOhNSP0KHnsKS4mr760/S0U9wswkfQmfdNNOnQNVlm1UlJ+ixa1YlpySmkO8/a1c
        Kv7+OscX/PvpA48keBYcR3/b9D+az2jjm/Ro1b6EPX5vnZv8p0Ye1Pfqbtp3voAB
        eSLCKXAmTHa7c/pz9nFyZGfzpN/trG+iozNL82I8hhb+9yxyhcwsMHGcI/KkXSdf
        XwUwncGoyWfBzC4bOhH/YHKHLiDZddXZxpeUSrNUSAzFmfGtLX/fWXUEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=RYLufI04OScg/q2h48yuGO/OEesMeqFUtY3MNWzcEh8=; b=Q4keBwCN
        DOO9qrl6LmJzOSng1QfewFI/bOuoXqV73JZYN0ScltsTZDKzXZkovNAS8RU1nxuu
        Kv/JMeSV605RzyXAXh2yKocA34XOoQ6l2hUafnZspJFtYj0Hohd3FmvtbAwExNPD
        XcSLn+RaxWtzsL2nTj1tx/VTvVb+/VjEmjJGEUwGcZZ8ixpVQMqWtL/hvoiv2awb
        z3mG8rFLBeGbFYaxJqoEnU4Gnrco0CwO1G/yPsy/4DiY7rkZ6TY89Meo1M6q8Inx
        hVg1Gjb3Ae6HanK/Ggy69Xs0yFPbVEfVCtgapSBprgeNeIWkbhwPhgbSkt58JJ7I
        X0qx17K//107ww==
X-ME-Sender: <xms:ELI2YOPVaq3hgc4MZ_sJWIucvHxalxPs2wHvzcGMTWsVWlaT0SvnNg>
    <xme:ELI2YM8f4SHBNVyVRv8m9OnqDpkluLmGkT9Dt3qKzolNS5t-XQXyd7VNZtumoHv1n
    0yXUZr4dxHdcQhS9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:ELI2YFTdonvRuaTLbAdch4L0PYZcqZ-9oEtKJVrL86ySYkeZMrfSRQ>
    <xmx:ELI2YOsghR0pqGq7yVp-6obCXNZLWlPPCC3TeeUlRjdhE7QP5oQKeA>
    <xmx:ELI2YGfqKYwfIN2_Q_5n7GIZXowlfuHKTUTs8F4ps6FW8yay8Hh9Eg>
    <xmx:ELI2YOnQ5miqUY7Aq6qmWywnW4NW0nz7IzBfTO7-2pL0yKBfg5jI0Q>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id E570E1080054;
        Wed, 24 Feb 2021 15:07:43 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] staging: rtl8192e: remove blank line in bss_ht struct
Date:   Sat, 20 Feb 2021 17:28:57 +0000
Message-Id: <20210220172909.15812-2-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning about a blank line after an open curly brace.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 11269fe6b395..1bbb9ed18e6d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -179,7 +179,6 @@ struct rt_hi_throughput {
 } __packed;

 struct bss_ht {
-
 	u8				bdSupportHT;

 	u8					bdHTCapBuf[32];
--
2.30.0

