Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2F37B918
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhELJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhELJ0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 879E4611C9;
        Wed, 12 May 2021 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620811531;
        bh=BQjFvb143aTmUaIxfUXb48V/B3l/sa5vBo2i5dSaI8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxArUJtXnJa9fHVJbkO5DvlyGNgOgynv1uSld38p+wpZEqTCMFc52KuY9ujAL/Squ
         9T3U6W3rSEw4Hna+G4Qg+hIStCgSjRjAM3h9jTnFMQLFbI3R7sD7vEel5+9EA/3AnB
         cgLpVX2Fxp9XqEYCU6dzaYv7aEA01CCb1V0l3b6bYCyhqzuO8ua7r1Rs2+/g1Lo9Rb
         XnJWu8wyiDVuM6/9kVbw+y4Ei+Rmf4TYD2xY6HbeZ8fqvQNoOjTAU83BbETTQVmy/H
         0kzZ8Pywuq7Q+xnA6tvqjAWcfMWAKes9X8XPZKsvWjPNGyLw6RaS78SjmFHOX8pyty
         i9CatXKspVv6Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lgl7V-00047D-N5; Wed, 12 May 2021 11:25:34 +0200
Date:   Wed, 12 May 2021 11:25:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 3/8] serial: fsl_lpuart: don't restore interrupt state in
 ISR
Message-ID: <YJufDcQ5l/yz4MF1@hovoldconsulting.com>
References: <20210511200148.11934-1-michael@walle.cc>
 <20210511200148.11934-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511200148.11934-4-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:01:43PM +0200, Michael Walle wrote:
> Since commit 81e2073c175b ("genirq: Disable interrupts for force
> threaded handlers") interrupt handlers that are not explicitly requested
> as threaded are always called with interrupts disabled and there is no
> need to save the interrupt state when taking the port lock.

Since you've copied the above words verbatim from commit 75f4e830fa9c
("serial: do not restore interrupt state in sysrq helper") I'd expect
you to use quotes or at least refer to the commit you copied the
rationale from.

> This is a preparation for sysrq handling which uses
> uart_unlock_and_check_sysrq();

Johan
