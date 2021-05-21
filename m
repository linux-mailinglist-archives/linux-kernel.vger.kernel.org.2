Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0538BBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhEUBle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:41:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50302 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhEUBld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=WrQW0JmUFiFAiggrELZsfh0WtmGzI5HxUDO0u+YddEc=; b=6G
        Phpb48Mm2XrGJb/pn9CYLTyVBobEh6VWAe6XTrlVnzxbM5HM3P7cdOsS0RQP5mewCv0H6qz1QbHnQ
        4KEkOE7AbgMQtIyvVqwZ31IUBijLtHl75nypRA0Ha8Cxekb7z5Er/xSOE5tn/LcA/aTQO8zgaTwR8
        4jbla4pJ+usjf8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lju92-005CMH-D6; Fri, 21 May 2021 03:40:08 +0200
Date:   Fri, 21 May 2021 03:40:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 4/4] firmware: turris-mox-rwtm: show message
 about HWRNG registration
Message-ID: <YKcPeGRWVyI84diZ@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
 <20210520113520.32240-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520113520.32240-5-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:35:20PM +0200, Pali Rohár wrote:
> Currently it is hard to determinate if on Armada 3720 device is HWRNG
> by running kernel accessible or not. So print information message into
> dmesg when HWRNG is available and registration was successful.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

