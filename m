Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979503690E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbhDWLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 07:11:52 -0400
Received: from mx01-muc.bfs.de ([193.174.230.67]:7052 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhDWLLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:11:48 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 07:11:46 EDT
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id EBE5620410;
        Fri, 23 Apr 2021 13:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1619175812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gS2/+OtZeyWoLKq/wHOdWrUCs+DhK5eUj+Z6M6FpE4=;
        b=Fn/VUMAzwsrl+HvNOer6MZKhub7g33xq81EATh2GdIFcaXSzz6fcSIr/+t5qiT+qL6ntdu
        m5LV6z8ptTwJh6mbdjf6RbNutzl2FH2md+xfvYqjW3xQJ2UahpPbWpeFfDhOoa2qmHW2q8
        3BrNvj2CSTV9NVB9zE1SWxFrG78AdyQCOGqXNkQUPiKLmbSI0i+9kEN1iDUYKmcJF5Lsmv
        jWggcGf8yJS5JfjjYjl4amc+D9LlwIgX1UwTk79VoP9zq5jOsnKb7gGQMMwHVj2Mvo8cZw
        oU3qKRa664DUXWWBIrIEzF2+MM3gbL+SBpYv3wYaMT4u2Z2tjlQfy1s2HeK5wA==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Fri, 23 Apr
 2021 13:03:31 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2242.008; Fri, 23 Apr 2021 13:03:31 +0200
From:   Walter Harms <wharms@bfs.de>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Sergey Organov' <sorganov@gmail.com>
CC:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        "John Wang" <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        "Benjamin Fair" <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Thread-Topic: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Thread-Index: AQHXN1ea5N8/zdZIw0CYuTs8hCrx1qrAlvAAgAFWXQf//+CxgIAAIfA0
Date:   Fri, 23 Apr 2021 11:03:30 +0000
Message-ID: <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de>
References: <YIE90PSXsMTa2Y8n@mwanda>
        <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>,<265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
In-Reply-To: <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-26108.007
x-tm-as-result: No-10--6.432100-5.000000
x-tmase-matchedrid: iGxe9xjWFMzRubRCcrbc5grcxrzwsv5u3dCmvEa6IiHn8EgZxID/ZY/M
        VY+TBf96xO4FvTZs+ZxqTYv2/zFiBuRZms8DIpYPawF+mgcxqmVUbAPLgXqrA1nXqbstvcD5n9I
        cqiX7mgBhhkiEB/71A+8sEaIJ8Jp0NQ5PIu1w5I727WtDgGBc8iz4KCOU3J2crcN9BdgNdeZGIz
        SvkOhmQHmN0n5wvdMIG8motEIKwGh1A7Kay+/ARqRUKLeQWKvT/OXzMJnlSkVqEsgVJ+91qjXoJ
        TJoH3SyuW01O3xWv96VeaEgHjNmGI7WqXAk15HgmlaAItiONP3WF3mkZiRSLlc/Cedjlcvksbu6
        taqvQ/oVMcFRBVLLS+4ijS3WP7bm9v1YvKhgkvnlmGNjPpsVKxNNj6+ApDUj1l38M6aWfEgEpsW
        1EZup8fXmS36YYdHyjdOwhDBOoNL2up/bgDqTK+ds4fnKv9Cbljgw/8s6b3cHZBaLwEXlKGlF7O
        hYLlctH1SwyA4h73QSRgU/at6BrnChPHB61wQjl5lQMzKmF9JxXefgn/TNQ3FdaoII8qYI0sEwJ
        3QPiJorUHYEBY+ayqdkM6CpJVzugWeg41OVP/1GJPF0AyfIleuLFZZYlisfv1l2Uvx6idpWdFeb
        WIc3VsRB0bsfrpPI34T9cYMsdwyUtLEU4x78a5kwE2oBRH4Hq0ndFJmradzYCSOGGYGhX31ZMN3
        dmFhHjvFgsaiECppXFOMLwX9Q8I/sUItVT0+HBmns4ZNuE3zf0ic5zgpSMaAgCgKCG9lmDP7ys8
        dRrrEdy+NYmKKLmVrVflnGTvH9
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--6.432100-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-26108.007
x-tm-snts-smtp: 15B6C36F38B894F33A15C27964F85C6631349DFF79213BD1F76D300504A2D5B92000:9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spamd-Result: default: False [-18.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
         WHITELIST_LOCAL_IP(-15.00)[10.129.90.31];
         RCPT_COUNT_TWELVE(0.00)[16];
         FREEMAIL_TO(0.00)[ACULAB.COM,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[99.99%]
Authentication-Results: mx01-muc.bfs.de;
        none
X-Spam-Status: No, score=-18.00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as indepentent observer,
i would go for Dans solution:

ret =3D kfifo_to_user();
/* if an error occurs just return */
if (ret)
   return ret;

/* otherwise return the copied number of bytes */

return copied;

there is no need for any deeper language knowledge,

jm2c
re,
 wh
________________________________________
Von: David Laight <David.Laight@ACULAB.COM>
Gesendet: Freitag, 23. April 2021 12:54:59
An: 'Sergey Organov'
Cc: 'Dan Carpenter'; Joel Stanley; Andrew Jeffery; Chia-Wei, Wang; Jae Hyun=
 Yoo; John Wang; Brad Bishop; Patrick Venture; Benjamin Fair; Greg Kroah-Ha=
rtman; Robert Lippert; linux-aspeed@lists.ozlabs.org; linux-kernel@vger.ker=
nel.org; kernel-janitors@vger.kernel.org
Betreff: RE: [PATCH] soc: aspeed: fix a ternary sign expansion bug

WARNUNG: Diese E-Mail kam von au=DFerhalb der Organisation. Klicken Sie nic=
ht auf Links oder =F6ffnen Sie keine Anh=E4nge, es sei denn, Sie kennen den=
/die Absender*in und wissen, dass der Inhalt sicher ist.


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
> >> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() functi=
on
> >> returns long.  What happens is that "ret" is cast to u32 and becomes
> >> positive then it's cast to long and it's still positive.
> >>
> >> Fix this by removing the ternary so that "ret" is type promoted direct=
ly
> >> to long.
> >>
> >> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc=
 chardev")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspee=
d/aspeed-lpc-snoop.c
> >> index 210455efb321..eceeaf8dfbeb 100644
> >> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, c=
har __user *buffer,
> >>                    return -EINTR;
> >>    }
> >>    ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> >> +  if (ret)
> >> +          return ret;
> >>
> >> -  return ret ? ret : copied;
> >> +  return copied;
> >
> > I wonder if changing it to:
> >     return ret ? ret + 0L : copied;
> >
> > Might make people think in the future and not convert it back
> > as an 'optimisation'.
>
> It rather made me think: "what the heck is going on here?!"
>
> Shouldn't it better be:
>
>       return ret ? ret : (long)copied;
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
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

