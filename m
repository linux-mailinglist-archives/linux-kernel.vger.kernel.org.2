Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15543469A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJTIRL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Oct 2021 04:17:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:51874 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:17:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-cXpa1CEUN6Sk8MILzfGu8g-1; Wed, 20 Oct 2021 09:14:44 +0100
X-MC-Unique: cXpa1CEUN6Sk8MILzfGu8g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 09:14:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 20 Oct 2021 09:14:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Thread-Topic: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Thread-Index: AQHXwUZ2FnqdAiWt8EaCTgFmgVgUJ6vbkYrw
Date:   Wed, 20 Oct 2021 08:14:42 +0000
Message-ID: <e1a8f7b746944ccaabe6b610e7922b54@AcuMS.aculab.com>
References: <20211014215703.3705371-1-nathan@kernel.org>
In-Reply-To: <20211014215703.3705371-1-nathan@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor
> Sent: 14 October 2021 22:57
> 
> A new warning in clang points out a place in this file where a bitwise
> OR is being used with boolean expressions:
> 
> In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-
> Wbitwise-instead-of-logical]
>             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
>             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this
> warning
> 1 warning generated.
> 
> The comment explains that short circuiting here is undesirable, as the
> calls to test_and_{clear,set}_bit() need to happen for both sides of the
> expression.
> 
> Clang's suggestion would work to silence the warning but the readability
> of the expression would suffer even more. To clean up the warning and
> make the block more readable, use a variable for each side of the
> bitwise expression.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1478
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/wlan-ng/hfa384x_usb.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
> index 59aa84d1837d..938e11a1a0b6 100644
> --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> @@ -3778,18 +3778,18 @@ static void hfa384x_usb_throttlefn(struct timer_list *t)
> 
>  	spin_lock_irqsave(&hw->ctlxq.lock, flags);
> 
> -	/*
> -	 * We need to check BOTH the RX and the TX throttle controls,
> -	 * so we use the bitwise OR instead of the logical OR.
> -	 */
>  	pr_debug("flags=0x%lx\n", hw->usb_flags);
> -	if (!hw->wlandev->hwremoved &&
> -	    ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> -	      !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags)) |
> -	     (test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
> -	      !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags))
> -	    )) {
> -		schedule_work(&hw->usb_work);
> +	if (!hw->wlandev->hwremoved) {
> +		bool rx_throttle = test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> +				   !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags);
> +		bool tx_throttle = test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
> +				   !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags);
> +		/*
> +		 * We need to check BOTH the RX and the TX throttle controls,
> +		 * so we use the bitwise OR instead of the logical OR.
> +		 */
> +		if (rx_throttle | tx_throttle)
> +			schedule_work(&hw->usb_work);

Why not the slightly simpler:
		bool throttle = test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
				   !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags);
		throttle |= test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
				   !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags);
		if (throttle)
			schedule_work(&hw->usb_work);
or with s/throttle/throttle_silly_compiler_warning/ :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

