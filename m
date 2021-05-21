Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D590438C667
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhEUMYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhEUMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF4B76108B;
        Fri, 21 May 2021 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621599748;
        bh=hZB5mRvFhvekBVKyrmsMnvBvDkupZwGcOAedXMe34CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B105qBG9k+unX7Qa7omnzMl0M5PGM/H7CTtJfg1HEiucvEZWktl/TLnKU2Qm53QwC
         4rLHaWM97akaxshQbVvTH8XrxkNMMtnhKO2zqu3yar6PiP1nQmsrJqm8YynwIx5rNm
         BM0fvqTg8J9dpqtKxcO2Pl/NyNqaN6I9wrwQqLjU=
Date:   Fri, 21 May 2021 14:22:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] USB: serial: buffer-callback clean ups
Message-ID: <YKemAh63ldwGUWBh@kroah.com>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:20:00AM +0200, Johan Hovold wrote:
> This series clean up a few things related to the chars_in_buffer and
> write_room callbacks that were found during review of the recent
> conversion to have these callbacks return an unsigned int.
> 
> Johan
> 
> 
> Johan Hovold (6):
>   USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
>   USB: serial: digi_acceleport: add chars_in_buffer locking
>   USB: serial: io_edgeport: drop buffer-callback sanity checks
>   USB: serial: mos7720: drop buffer-callback sanity checks
>   USB: serial: mos7840: drop buffer-callback return-value comments
>   USB: serial: drop irq-flags initialisations
> 
>  drivers/usb/serial/digi_acceleport.c | 34 ++++++++++++++--------------
>  drivers/usb/serial/io_edgeport.c     | 27 +---------------------
>  drivers/usb/serial/metro-usb.c       | 12 +++++-----
>  drivers/usb/serial/mos7720.c         | 17 ++------------
>  drivers/usb/serial/mos7840.c         |  5 ----
>  drivers/usb/serial/quatech2.c        |  2 +-
>  6 files changed, 27 insertions(+), 70 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
