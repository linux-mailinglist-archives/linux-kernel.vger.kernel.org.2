Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5130D37B33A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhELBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:00:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36312 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELBAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yULmy6qmP4OWVSFziQ4kEng8jFKfikaxHTllnwXE2l0=; b=EEHbVvsAzEoAprAWdcwCtLDuNp
        +pSg6Vc9gjrnDjLID06mFJKlmuyeqzVmMgv3j6m8Xc3YW0uX/EeEhcmtUEqyouIDDh//O2NEq8TVl
        LDWF23gZLEP5jere05du+RioQVKhBKt/sIk3wodTBorrPo6u21lYInUeLrAEiGtMNTkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lgdDg-003qMw-Kw; Wed, 12 May 2021 02:59:24 +0200
Date:   Wed, 12 May 2021 02:59:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mvebu + mvebu/dt64 6/6] arm64: dts: marvell:
 armada-37xx: move firmware node to generic dtsi file
Message-ID: <YJsobDuLvxpr4aVr@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
 <20210506090802.14268-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506090802.14268-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:08:02AM +0200, Pali Rohár wrote:
> Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
> the generic armada-37xx.dtsi file and use the generic compatible string
> 'marvell,armada-3700-rwtm-firmware' instead of the current one.
> 
> The Turris MOX rWTM firmware can be used on any Armada 37xx device,
> giving them access to the rWTM hardware random number generator, which
> is otherwise unavailable.

This is a new feature, not a fix. Please split this patchset up into
fixes, which get applied to stable, and new features which will get
merged during the next merge window.

Thanks
	Andrew
