Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4943360404
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhDOIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhDOIOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2489F6113D;
        Thu, 15 Apr 2021 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618474466;
        bh=Sf8fOsqitkV5qdfY6PEsQKbYOdJV1drsU7tKJPv/8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE4al/KhLXcCwk9V0wRJ2qzxQMq/BIH3lKNauX30BunAa2SkEKxCway7NrbZiib6i
         kBlBO7SAKrVXPRo540mjAYtUNpyOR5LzKLSoSk+KdaREH4z7N59gtcnMCleAboCK8K
         kljfzBM/9l18phTrObZoC3ETQjNsjO3I9Uq5pH6E=
Date:   Thu, 15 Apr 2021 10:14:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: omap: don't disable rs485 if rts gpio is missing
Message-ID: <YHf131xZBsus3g5h@kroah.com>
References: <20210411085743.510-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411085743.510-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:57:43AM +0200, Dario Binacchi wrote:
> There are rs485 transceivers (e.g. MAX13487E/MAX13488E) which
> automatically disable or enable the driver and receiver to keep the bus
> in the correct state.
> In these cases we don't need a GPIO for flow control.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---

Same here, what commit id does this "fix"?  Please add that and resend.

thanks,

greg k-h
