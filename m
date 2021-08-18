Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35A73F056D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhHRN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236970AbhHRN5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B8C60238;
        Wed, 18 Aug 2021 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629295001;
        bh=V+ir9XKGfiYGDgjYbKV/tp1chlKASpVM6Q3MYbSmJ3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwOnzRABWdiZFccv1E2Fkfng5oqv/pMzaWL+dAo7E+s9NPMFEwg2P/vu3+TWPVeYG
         AWHcpb7xgTz4taOt2QCitokC/k4zoD8UTlvwsOoW1B8EfFtXYGp5hlC2gacxzr2sdr
         3dCDawWEYvTMaLlDTtcGdTIBWfTYVFJ3Lkb7f+Vs=
Date:   Wed, 18 Aug 2021 15:56:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
Message-ID: <YR0Rlj+jk9dnoG6N@kroah.com>
References: <20210813043131.833006-1-icenowy@aosc.io>
 <YRuDG78N2mB5w37p@kuha.fi.intel.com>
 <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io>
 <YRuW0fENBEcIVkZb@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRuW0fENBEcIVkZb@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:00:33PM +0300, Heikki Krogerus wrote:
> > >Why is it necessary to do discovery with data role swap in general?
> > 
> > I think it could be possible for devices to expose different altmode
> > with different role.
> 
> OK. FWIW:
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Is this conflicting with https://lore.kernel.org/r/20210816075449.2236547-1-kyletso@google.com ?

Which of these two should I take, both?  Neither?

confused,

greg k-h
