Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60F37B339
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhELA5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:57:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36298 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhELA5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hLk8R+sPEq1fJqeDs5YrbWitukFkj2eeoBAVdTu4lno=; b=jCrLCW9FGl8GeIRmXcY2O32Kz9
        iF1LYJPu5gIYlR6OYqEJZbF66Dnr9a0k2V7G/8u1+w9Rusqo8aj1irrukXuC5DEvGsyPky5OGoB+X
        8F4B+J0vSry2+R3g/87oMz63qKHGpx5sCiDhZv8w3Ebidb/nAG2A1GXIn4Zy92DaKSuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lgdAX-003qLE-9H; Wed, 12 May 2021 02:56:09 +0200
Date:   Wed, 12 May 2021 02:56:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mvebu + mvebu/dt64 3/6] firmware: turris-mox-rwtm:
 fail probing when firmware does not support hwrng
Message-ID: <YJsnqUjJMehtbqgS@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
 <20210506090802.14268-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506090802.14268-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:07:59AM +0200, Pali Rohár wrote:
> When Marvell's rWTM firmware, which does not support the GET_RANDOM
> command, is used, kernel prints an error message
>   hwrng: no data available
> every 10 seconds.
> 
> Fail probing of this driver if the rWTM firmware does not support the
> GET_RANDOM command.
> 
> This makes it possible to put this driver's compatible into generic
> armada-37xx device tree, to be available for other Armada 3720 devices
> besides Turris MOX. If they use the rWTM firmware from CZ.NIC, they will
> have HWRNG available, and if not, the driver won't be complaining.

We start getting into questions of if this is relevant for stable.
Running Turris MOX with plain Marvell rWTM will spam the log. So i
would say it is a fix, for that situation.

However, i would drop the second part of the description. Making the
Turris MOX firmware work on none Turris MOX hardware is a new feature,
and so not applicable to stable.

    Andrew
