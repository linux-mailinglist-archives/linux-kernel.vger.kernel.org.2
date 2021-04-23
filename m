Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66663690A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbhDWKzy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Apr 2021 06:55:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58267 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229920AbhDWKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:55:52 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-edUjWyPgOc6IiAfhYVLPBQ-1; Fri, 23 Apr 2021 11:55:01 +0100
X-MC-Unique: edUjWyPgOc6IiAfhYVLPBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 23 Apr 2021 11:54:59 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Fri, 23 Apr 2021 11:54:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sergey Organov' <sorganov@gmail.com>
CC:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        "John Wang" <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Thread-Topic: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Thread-Index: AQHXOC3N+IlNNgnl7EGootyN/jCOrarB7AEQ
Date:   Fri, 23 Apr 2021 10:54:59 +0000
Message-ID: <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
References: <YIE90PSXsMTa2Y8n@mwanda>
        <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
In-Reply-To: <877dktuvmz.fsf@osv.gnss.ru>
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

From: Sergey Organov
> Sent: 23 April 2021 11:46
> 
> David Laight <David.Laight@ACULAB.COM> writes:
> 
> > From: Dan Carpenter
> >> Sent: 22 April 2021 10:12
> >>
> >> The intent here was to return negative error codes but it actually
> >> returns positive values.  The problem is that type promotion with
> >> ternary operations is quite complicated.
> >>
> >> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> >> returns long.  What happens is that "ret" is cast to u32 and becomes
> >> positive then it's cast to long and it's still positive.
> >>
> >> Fix this by removing the ternary so that "ret" is type promoted directly
> >> to long.
> >>
> >> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> index 210455efb321..eceeaf8dfbeb 100644
> >> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >>  			return -EINTR;
> >>  	}
> >>  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> >> +	if (ret)
> >> +		return ret;
> >>
> >> -	return ret ? ret : copied;
> >> +	return copied;
> >
> > I wonder if changing it to:
> > 	return ret ? ret + 0L : copied;
> >
> > Might make people think in the future and not convert it back
> > as an 'optimisation'.
> 
> It rather made me think: "what the heck is going on here?!"
> 
> Shouldn't it better be:
> 
>  	return ret ? ret : (long)copied;
> 
> or even:
> 
>         return ret ?: (long)copied;

Or change the return type to int ?

The problem is that ?: doesn't behave the way most people expect.
The two possible values have to be converted to the same type.

Together with the broken decision of the original ANSI C committee
to change from K&R's 'sign preserving' to 'value preserving'
integer promotions causes grief here and elsewhere.
(Not no mention breaking existing code!)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

