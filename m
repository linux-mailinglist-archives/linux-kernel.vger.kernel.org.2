Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5783B5EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhF1NMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhF1NMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBBB619AB;
        Mon, 28 Jun 2021 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624885815;
        bh=+VFZSKnK8SyvGBP4gDqe0C/KPvLEj9KZlsmAGZCdk5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvHUT5sbGQLYxLL4IuaUzmUi6oDotstTU3BA40F0hpFAUJjSFsvgMlgSAHFCqjF6f
         qOe4nGYWi3lh+GgmDhXYA2Y6ZSCSf/Sdqgd2lOgMrDD4vLCVHeu4UR2TK3iYwWay5r
         B5+3sfbzfnK+pg8C9+/BZ4WB9HYtVkCB17BXsfwiEIWwdB4sB+uUbEvDvi2xF25yOa
         QE5zfKeRKaoicTRP1GbqX5P2yuecuq69VvX7ZxyKzpnMSG5unIZnQsXp8rEvFaKD8j
         /ossoyZBqqzBV4LlQpQ9SklJZn2y1WHI6r4P0Gy2c7sw8f4rEmU9jTdr93MLGeDDHt
         rJRMnMpvZyTxg==
Date:   Mon, 28 Jun 2021 15:10:10 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox.dts: remove
 mrvl,i2c-fast-mode
Message-ID: <20210628151010.518efa95@thinkpad>
In-Reply-To: <20210628121015.22660-1-pali@kernel.org>
References: <20210628121015.22660-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also please remove ".dts" from commit title, i.e.:
  arm64: dts: armada-3720-turris-mox: remove mrvl,i2c-fast-mode

since "dts" is already present in the prefix.

Marek
