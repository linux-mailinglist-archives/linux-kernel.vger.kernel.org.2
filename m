Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7696238BBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhEUBkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:40:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50282 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237201AbhEUBkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=YA1CpuQqNxgntUbTlcO9OSqATJyfes00f93NSI1wOKE=; b=dw
        d8VXw3shVyEIxT3yT0e2GpktutmnnEae6J7yN52JUZ4RHsAqAuudI/5VYivSzP10sISTM4RyDoIfr
        sIXEc67U+H0+ls5lUp251G2EliIrrdUNag7HfhOy6gCS1NrYOs0W5Y49c8tWrcEDkP3W8785SEwGn
        9mSUqi+nq4+DI/c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lju7V-005CKh-U2; Fri, 21 May 2021 03:38:33 +0200
Date:   Fri, 21 May 2021 03:38:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 2/4] firmware: turris-mox-rwtm: report failures
 better
Message-ID: <YKcPGRzBJPyzQqOK@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
 <20210520113520.32240-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520113520.32240-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:35:18PM +0200, Pali Rohár wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> Report a notice level message if a command is not supported by the rWTM
> firmware.
> 
> This should not be an error, merely a notice, because the firmware can
> be used on boards that do not have manufacturing information burned.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
