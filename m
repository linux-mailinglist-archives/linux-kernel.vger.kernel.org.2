Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6744250EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbhJGKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240818AbhJGKXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:23:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42E7611C1;
        Thu,  7 Oct 2021 10:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633602073;
        bh=9PfpQugG7elvxkugHe80XqW098t6EqO7YTjPZAdWwPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPkjt8B9883DsLj23YmAZdDSm3kJFaUpeWQdFo/RcmmxtkI1r6uBKkYa5ZvIUVD3+
         ATMsAWtJKYE+b/C5SGjTmOGlwi3/G1IAGOBvXSTOUWkYw5nMdX5+W23EiEidUAGhi6
         hEICe0dQaSjRLTAZsdfz0k50AfnGrq1cY9ugBknYpBdzQrNDVqmVmeJaKYKUlyLZ+i
         TuklowNXo9HrD3vOKyuYEXC78atcE3AnmiN+tn7p00wqDhastrAiocvvO+3MTwMtXe
         1uVe3EdMFJ9tJovyRHaISmp8+5iPtBQl8bONN/8yaHskW0UT8fKqv4A57cM6gMG+k+
         HIoUWi24ojCZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mYQWW-0005Ce-6G; Thu, 07 Oct 2021 12:21:12 +0200
Date:   Thu, 7 Oct 2021 12:21:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Razvan Heghedus <heghedus.razvan@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: misc: ehset: Workaround for "special" hubs
Message-ID: <YV7KGE9JfibggVVH@hovoldconsulting.com>
References: <20210915121615.3790-1-heghedus.razvan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915121615.3790-1-heghedus.razvan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:16:13PM +0300, Razvan Heghedus wrote:
> The USB2.0 spec chapter 11.24.2.13 says that the USB port which is going
> under test needs to be put in suspend state before sending the test
> command. Many hubs, don't enforce this precondition and they work fine
> without this step. But there are some "special" hubs, which requires to
> disable the port power before sending the test command.

So you're essentially doing two things in one patch here; you now
sending a suspend request for all hubs except a for the ones in the
quirk list that are sent a port power disable.

This isn't really reflected in the commit summary which says "workaround
for special hubs" as you're also changing the default implementation.

Probably better handled in two patches, or at least this needs to be
reflected in the commit summary/message better.

But this patch is so broken that I just sent a revert. There also some
style issues that should be addressed if you send a new version.

> Because the USB spec mention that the port should be suspended, also
> do this step before sending the test command. This could rise the
> problem with other hubs which are not compliant with the spec and the
> test command will not work if the port is suspend. If such hubs are
> found, a similar workaround like the disable part could be implemented
> to skip the suspend port command.
> 
> Signed-off-by: Razvan Heghedus <heghedus.razvan@gmail.com>
> ---
>  Changes in v2:
>   - style change regarding multi-line comments and a new black line
>     after local variable definitions
>   - No more corporate email annotation
> This time without that corporate email annotation.
> Also has a couple of style changes regardind multi-line comments and a
> black line after local variable definitions.
>
>  drivers/usb/misc/ehset.c | 81 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
> index f87890f9cd26..b848bbdee802 100644
> --- a/drivers/usb/misc/ehset.c
> +++ b/drivers/usb/misc/ehset.c
> @@ -18,6 +18,47 @@
>  #define TEST_SINGLE_STEP_GET_DEV_DESC		0x0107
>  #define TEST_SINGLE_STEP_SET_FEATURE		0x0108
>  
> +/*
> + * A list of USB hubs which requires to disable the power
> + * to the port before starting the testing procedures.
> + */
> +static const struct usb_device_id ehset_hub_list[] = {
> +	{USB_DEVICE(0x0424, 0x4502)},
> +	{USB_DEVICE(0x0424, 0x4913)},
> +	{USB_DEVICE(0x0451, 0x8027)},
> +	{}

Missing spaces after { and before }.

> +};
> +
> +static int ehset_prepare_port_for_testing(struct usb_device *hub_udev, u16 portnum)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * The USB2.0 spec chapter 11.24.2.13 says that the USB port which is
> +	 * going under test needs to be put in suspend before sending the
> +	 * test command. Most hubs don't enforce this precondition, but there
> +	 * are some hubs which needs to disable the power to the port before
> +	 * starting the test.
> +	 */
> +	if (usb_match_id(to_usb_interface(hub_udev->dev.parent), ehset_hub_list)) {

This is the main problem: hub_udev->dev.parent does not represent a USB
interface so you cannot use to_usb_interface() or you'd pass a random
pointer to usb_match_id().

If hub_udev is a root hub, then hub_udev->dev.parent does not even
represent a USB device (but, for example, the parent PCI device).

> +		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_ENABLE,
> +					   portnum, NULL, 0, 1000, GFP_KERNEL);
> +		/* Wait for the port to be disabled. It's an arbitrary value
> +		 * which worked every time.
> +		 */

Multi-line comment style is

	/*
	 * blah blah
	 */

> +		msleep(100);
> +	} else {
> +		/* For the hubs which are compliant with the spec,
> +		 * put the port in SUSPEND.
> +		 */

Ditto.

> +		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
> +					   portnum, NULL, 0, 1000, GFP_KERNEL);
> +	}
> +	return ret;
> +}
> +
>  static int ehset_probe(struct usb_interface *intf,
>  		       const struct usb_device_id *id)
>  {
> @@ -30,28 +71,36 @@ static int ehset_probe(struct usb_interface *intf,
>  
>  	switch (test_pid) {
>  	case TEST_SE0_NAK_PID:
> -		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> -					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> -					   (USB_TEST_SE0_NAK << 8) | portnum,
> -					   NULL, 0, 1000, GFP_KERNEL);
> +		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
> +		if (!ret)
> +			ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +						   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +						   (USB_TEST_SE0_NAK << 8) | portnum,
> +						   NULL, 0, 1000, GFP_KERNEL);

Just break if ehset_prepare_port_for_testing() fails, which make the
code much more readable and avoids indenting the current code further
and break the 80 column (soft) rule.

Johan
