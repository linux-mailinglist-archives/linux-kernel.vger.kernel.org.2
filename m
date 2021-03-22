Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A4343D16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCVJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:40:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhCVJk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:40:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5mWBaykHdw6i41UTwYkjgwF5f9OZTuA0Eg2QiNmO3I=;
        b=Qsp4ycLoc+ldur8rIm8gP2ylp8JJpv3ryP/vFoTrRl1G1dyB5cW6BC0t0UcXGAOnBHnRcx
        20INH82p3vuqKSTSb3RSzN4AeA475WgEgA7uDPhBs7Y1clNErOajzlOe5yTWnL9mwQRPoa
        7Ft+Qbm/B5mBy7Pu9tGvxhBanY2DIoI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60ABDAD38;
        Mon, 22 Mar 2021 09:40:28 +0000 (UTC)
Message-ID: <ab10ad58a1ceec678de2d685e1936f1570114427.camel@suse.com>
Subject: Re: [PATCH 4/7] USB: cdc-acm: drop redundant driver-data reset
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:40:24 +0100
In-Reply-To: <20210318155202.22230-5-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
         <20210318155202.22230-5-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.03.2021, 16:51 +0100 schrieb Johan Hovold:
> There's no need to clear the interface driver data on failed probe (and
> driver core will clear it anyway).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

