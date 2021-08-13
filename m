Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78F3EB13B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhHMHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239314AbhHMHOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:14:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4549060241;
        Fri, 13 Aug 2021 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628838818;
        bh=/GuW+vfkm3S/fbyXBVALq4+2Ghnm0NY3NP3b3vJEa/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfPHm63KAOfk7dqgKEJMXI0JNXKX+4AOVW93sRb507frK2yL8vQ9ntCkLkVW0re11
         d4Z2DXbNcsHSD64oHZUQUSdgI7bfcdMYO1UGQiuqJ74AZxcb36EJjPNXqiFemt+FPg
         F6sLlN3UUrUABmkToyZcm8rJclOdRPVXoLJLUTCc=
Date:   Fri, 13 Aug 2021 09:13:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 1/2] serdev: Split and export
 serdev_acpi_get_uart_resource()
Message-ID: <YRYboAR9g/193T48@kroah.com>
References: <20210806111736.66591-1-andriy.shevchenko@linux.intel.com>
 <a955083a-a985-0b7d-460f-af196c5113c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a955083a-a985-0b7d-460f-af196c5113c5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:08:42PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/6/21 1:17 PM, Andy Shevchenko wrote:
> > The same as for I²C Serial Bus resource split and export
> > serdev_acpi_get_uart_resource(). We have already a few users
> > one of which is converted here.
> > 
> > Rationale of this is to consolidate parsing UART Serial Bus
> > resource in one place as it's done, e.g., for I²C Serial Bus.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> As mentioned before I believe it is best if this series is
> merged in its entirety through to the tty tree, here is my
> ack for patch 2/2 for that:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Greg, can you pickup the entire series please?

Now picked up, thanks.

greg k-h
