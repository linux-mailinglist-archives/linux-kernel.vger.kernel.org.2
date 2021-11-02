Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01244359A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhKBScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKBScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:32:13 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACFC061714;
        Tue,  2 Nov 2021 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=1ieuVzyfBKvZOljqpQjGnJfWFfeJ28/F0/+Bfa8Vs/w=; b=7f
        mfiofwBR/gHLr/ZAexJI5CxabzyVyG9pcLEs2DHhEvKRzNbWw7IXlZrmbgPolmqPOAu2Z/eLHrBpT
        ePU5n91fj5h5ZdfzhlqJ8lFCEGvz/XVhyrLzgx0Ba5qZxHhD9E2j9I2bKA9zw0S3LvfQA5LZX3J0H
        2neFt7meFgNpBS0YR3HsF0WP1V2bV4BJ9CTYdPJcfZzhNzHPnLjHHANeK1Qik1JSnf6bj5L//FONE
        bzjwNybsV4A5juXRb0H2OU5tY12t8CjE17rojBMRr0HwiZygc6PTsWT4XcOMenWG/sH850OuE55d2
        yQ0wFZTdXAFT6eW3xyIGYNuH261Z0x8Q==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mhyXJ-0004Uv-UJ; Tue, 02 Nov 2021 18:29:30 +0000
From:   John Keeping <john@metanate.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andyshrk@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>
Subject: [PATCH 0/2] arm64: dts: rockchip: fix a couple of vin-supply typos
Date:   Tue,  2 Nov 2021 18:29:06 +0000
Message-Id: <20211102182908.3409670-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same "vim-supply" typo appears in a couple of DTs.  Here are fixes
for both of them.

John Keeping (2):
  arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
  arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply

 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.33.1

