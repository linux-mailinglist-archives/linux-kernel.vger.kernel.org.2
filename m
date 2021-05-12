Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588CC37B335
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhELAvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:51:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36284 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i/3C/hjIk05NQu3nwTqgwisfFRauNxcxQu+WgCsQ07o=; b=DGsEr+0BLaRv/HdzIHnN92DgSb
        ZwBmqZTiLlpxs61qm8gOfD6xtaCWQVTWSB5d4qIvxOLEF4t561GR2Xp0eIibIOCyZeeLLT5Lc4V1y
        z3epsTbxTgU/Y7+c2aZwW8L4kib3IMiUtB7KeBQ2pwGtM8E7fEeQUzrUjcr4EpQjpGMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lgd4T-003qIi-39; Wed, 12 May 2021 02:49:53 +0200
Date:   Wed, 12 May 2021 02:49:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm: fix
 reply status decoding function
Message-ID: <YJsmMfVWY49pwmzB@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506090802.14268-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:07:57AM +0200, Pali Rohár wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> The status decoding function mox_get_status() currently contains an
> incorrect check: if the error status is not MBOX_STS_SUCCESS, it always
> returns -EIO, so the comparison to MBOX_STS_FAIL is never executed and
> we don't get the actual error code sent by the firmware.
> 
> Fix this.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
