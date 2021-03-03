Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32D32C228
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387813AbhCCTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhCCTSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:18:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AAE664EEE;
        Wed,  3 Mar 2021 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614799034;
        bh=Mf9uhVFc+A+W81vbbEZka2vShXqxHw+fMiv1AfIbBSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aruZB9LSnEkR3QWVm5jcBB79RVNMXdYPUcsGDUPFCr1rnhe2bdGGJsSDQuMDUjdzQ
         QLXtrKEVK5k7/vn14C8kZDbzaXLIg8Kic4HdPhNJCgoeR46LmuHA3sixV7Ccr5qM9M
         2viGCfdmYpMRrVtaR2Dk/ncTa3gkFV+/xLkRSZVU=
Date:   Wed, 3 Mar 2021 20:17:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 37/44] USB: serial/keyspan, drop unneeded forward
 declarations
Message-ID: <YD/gt/U2fzaV+yNh@kroah.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-37-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-37-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:22:07AM +0100, Jiri Slaby wrote:
> Forward declarations make the code larger, harder to follow and rewrite.
> Harder as the declarations are often omitted from global changes. Remove
> forward declarations which are not really needed, i.e. when the
> definition of the function is before its first use.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/keyspan.c | 20 --------------------
>  1 file changed, 20 deletions(-)

I'll let Johan take this through his tree:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
