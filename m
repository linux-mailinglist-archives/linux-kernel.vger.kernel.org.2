Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F12A3B1471
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFWHRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWHRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:17:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0726023B;
        Wed, 23 Jun 2021 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624432499;
        bh=BIJkp+bmcpYoUNpthePnxTk/99MSKXjR1s8U+gXPqxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJZy04Xz4F2KocY6sOqVmz2/2kcEzHRoPOXKtLIXZYqL4KEB0Gue3K73R7IQ6oqzU
         yvRzpo2jY0kwfpGwoWFnyrp7p0Je001Zg4draSJNUs/iewNdKQUOEQx9/uPJbgetR+
         5fjruXQ2RunUdpVoFKbzr0UZb/Ru9UTJFv1QdM7c=
Date:   Wed, 23 Jun 2021 09:14:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     vgupta@synopsys.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Pavel Andrianov <andrianov@ispras.ru>
Subject: Re: [question] De-registration does not remove port
Message-ID: <YNLfcKFL1LkJgXAR@kroah.com>
References: <3e131267-e1b3-1b83-f8be-0577da479223@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e131267-e1b3-1b83-f8be-0577da479223@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:42:36AM +0530, Saubhik Mukherjee wrote:
> In drivers/tty/serial/arc_uart.c, arc_serial_remove always returns 0,
> instead of calling uart_remove_one_port to remove uart port from serial
> core. The comment says "This will be never be called". In my understanding,
> a port added using uart_add_one_port should be removed during
> de-registration.
> 
> Is there a reason for this behavior?

Did you test the code to see if that function will ever be called?

thanks,

greg k-h
