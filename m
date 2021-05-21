Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B038BBC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhEUBm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:42:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50324 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237319AbhEUBm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=2Yn65lC6i8sVFKx/L3YcV+OJEK8N8S01XvjA4gZKG9k=; b=Jq
        MxsDpMvE9ovz9VXmULsHaETNwdpkQerXaWWy8gt9vlvW9iKdYWZcut+UAuzhE9+5rI4juYAM/hG9O
        CkUibh+GVmjwEpT435S/dp1w/L4B4vTeQJfnSMED+Jdfcpu1MKWSuxBipZ3XyWCtNq+PxafJ810xM
        zgGCNLQJ5/ivKlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ljuAP-005CO2-6x; Fri, 21 May 2021 03:41:33 +0200
Date:   Fri, 21 May 2021 03:41:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu + mvebu/dt64 1/2] firmware: turris-mox-rwtm: add
 marvell,armada-3700-rwtm-firmware compatible string
Message-ID: <YKcPzahkHYwgMLS6@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
 <20210520113844.32319-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520113844.32319-2-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:38:43PM +0200, Pali Rohár wrote:
> Add more generic compatible string 'marvell,armada-3700-rwtm-firmware' for
> this driver, since it can also be used on other Armada 3720 devices.
> 
> Current compatible string 'cznic,turris-mox-rwtm' is kept for backward
> compatibility.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

Since this is intended for the next merge window, it is clearly not a
fix. Please drop the fixes tag.

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
