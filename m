Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41F402A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhIGOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:15:01 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60429 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235347AbhIGOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:00 -0400
Received: (qmail 571841 invoked by uid 1000); 7 Sep 2021 10:13:52 -0400
Date:   Tue, 7 Sep 2021 10:13:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: ehci: Simplify platform driver registration
Message-ID: <20210907141352.GA571275@rowland.harvard.edu>
References: <20210907123002.3951446-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907123002.3951446-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 05:30:02AM -0700, Guenter Roeck wrote:
> Use platform_register_drivers() and platform_unregister_drivers() to
> register and unregister ehci platform drivers. This simplifies the code
> and prevents the following build errors seen with sparc:allmodconfig.
> 
> drivers/usb/host/ehci-hcd.c:1301: error:
> 	"PLATFORM_DRIVER" redefined
> drivers/usb/host/ehci-sh.c:173:31: error:
> 	'ehci_hcd_sh_driver' defined but not used
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Explicitly include platform_device.h.
>     The ps3 driver is not a platform driver, so we still have
>     to handle it separately.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
