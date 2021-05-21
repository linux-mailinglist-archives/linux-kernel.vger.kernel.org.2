Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B225138BBB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhEUBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:40:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50292 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237248AbhEUBkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=06G/O6J3XHotDB5owKwaftOvJQ3HxtaF3e5DFA0lABQ=; b=j2
        Aq60qnBbl/IAC4qtF9PXd/fMdkwKEqui2ebraX8t0toFgt7shJ7SRQvC9sKLP/nbeHSGSgijppFMX
        aYceM2isMCXR2K0627zPgcrJw/Rcw/O/BvMd0hXQmkimxRMKZejkf8F61Q3IAwZw6kB63+c9lo/gv
        ejJt5cqFprVtZik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lju86-005CLi-7G; Fri, 21 May 2021 03:39:10 +0200
Date:   Fri, 21 May 2021 03:39:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 3/4] firmware: turris-mox-rwtm: fail probing
 when firmware does not support hwrng
Message-ID: <YKcPPnkl8GVlH8bv@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
 <20210520113520.32240-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520113520.32240-4-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:35:19PM +0200, Pali Rohár wrote:
> When Marvell's rWTM firmware, which does not support the GET_RANDOM
> command, is used, kernel prints an error message
>   hwrng: no data available
> every 10 seconds.
> 
> Fail probing of this driver if the rWTM firmware does not support the
> GET_RANDOM command.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
