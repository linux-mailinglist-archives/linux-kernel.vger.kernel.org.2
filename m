Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4752313DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhBHSnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhBHQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:43:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C50B64E8C;
        Mon,  8 Feb 2021 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612802584;
        bh=eLCiW8dr74SmNMqhQLmPCWGg86Kkdeyl24xAHJmSH6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzHDqEWWD5aeqJIHzBUqPJobuUFlZ/qd7a2zq7ySL5xX5SA6E9sAUvOFHW0m+hWtq
         ezGE+Tg9p8elZwfmUJqMB7hz6kMxdHD4LZ9r8NGWTIimj2XxYldSbuAEvr9QOkR1Sn
         HJoHIx6J5Qe3OmEniITDvAeJubnq39NXrJPeQCbk=
Date:   Mon, 8 Feb 2021 17:43:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: drop bogus to_usb_serial_port() checks
Message-ID: <YCFqFdqE64/UaX6o@kroah.com>
References: <20210208154806.20853-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208154806.20853-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:48:06PM +0100, Johan Hovold wrote:
> The to_usb_serial_port() macro is implemented using container_of() so
> there's no need to check for NULL.
> 
> Note that neither bus match() or probe() is ever called with a NULL
> struct device pointer so the checks weren't just misplaced.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
