Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E83F06DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhHROkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhHROkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:40:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC59D610CF;
        Wed, 18 Aug 2021 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629297606;
        bh=GcDcn1p5bbIe0j3lDftYK1lLYju/eoi4yW4XncUjXv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WV9iTYVHIy8ObTfgjZwgmSFVzNaBVwypYgC5gh6MKpUVJc1vnnvmU1A8K84BlIMdg
         HLnE1fN48lexq+wubKlTbc6zwFq94eIzQBeCUxzP5gionxsaQylGI+7s9Ixs+8q3uT
         JWrWnvA6Hy/GEXhJjMS79QJjndU1xfuK4LCSwVIY=
Date:   Wed, 18 Aug 2021 16:40:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
Message-ID: <YR0bw+k0S94cmeDS@kroah.com>
References: <20210813043131.833006-1-icenowy@aosc.io>
 <YRuDG78N2mB5w37p@kuha.fi.intel.com>
 <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io>
 <YRuW0fENBEcIVkZb@kuha.fi.intel.com>
 <YR0Rlj+jk9dnoG6N@kroah.com>
 <E1804EE0-CBA1-4BE8-875B-57E82EDECDBE@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1804EE0-CBA1-4BE8-875B-57E82EDECDBE@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:02:24PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2021年8月18日 GMT+08:00 下午9:56:38, Greg Kroah-Hartman <gregkh@linuxfoundation.org> 写到:
> >On Tue, Aug 17, 2021 at 02:00:33PM +0300, Heikki Krogerus wrote:
> >> > >Why is it necessary to do discovery with data role swap in general?
> >> > 
> >> > I think it could be possible for devices to expose different altmode
> >> > with different role.
> >> 
> >> OK. FWIW:
> >> 
> >> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> >Is this conflicting with https://lore.kernel.org/r/20210816075449.2236547-1-kyletso@google.com ?
> >
> >Which of these two should I take, both?  Neither?
> 
> Don't take this, it's against spec.

Ok, now dropped.  What about the linked patch above?  Does that work for
you instead?

thanks,

greg k-h
