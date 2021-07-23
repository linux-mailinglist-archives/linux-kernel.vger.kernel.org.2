Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73E3D4030
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhGWRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 13:36:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:49211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGWRgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627064188;
        bh=ecvkC8x5/3D59+xc/e4I6ND0hbFLhwax+Ut44N6q2Jc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i4RmDwn9rfZkQpvnyD+5TqEw4w1R19km3lS4+dlPw1Ck2jZBPhkWuvL3HqM8Ti6P8
         mR+cIAng+KP0SEDYcMc2RnkoxipetvMxSjx9+wQ0ca025ek1xpWRqtcEInLxVSdvOe
         oNlSY6IRcXs5ioSbFlWywTQNuUMNPlE9S7zTbFns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1l5AiT07BZ-012LD4; Fri, 23
 Jul 2021 20:16:28 +0200
Date:   Fri, 23 Jul 2021 20:16:25 +0200
From:   Len Baker <len.baker@gmx.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Lee Jones <lee.jones@linaro.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Dmitrii Wolf <dev.dragon@bk.ru>,
        Iain Craig <coldcity@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/rtl8192u: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210723165353.GD2612@titan>
References: <20210718113207.10045-1-len.baker@gmx.com>
 <ec6c9adc089849b5984b9273c38efd93@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec6c9adc089849b5984b9273c38efd93@AcuMS.aculab.com>
X-Provags-ID: V03:K1:84BVanMfKv1FcUJtwjIClWXu88suYQh0HtMUImvBEZxZyNqmKJC
 yKueTsz3rcnIMFGMaErRqwvo/Mtg+M1gD7sh+z4f3HRsNNwcKCs00+xqLk0ZnS+4eyO51Wz
 vmadz9x/OCw0yfcj76L/6Sm2KfcBbzKiaUyk/nAi93OuWQaxbSWBMhns4fhwZZ7MIJLy0oP
 uwFcimyKY4Aj9xz7UIi/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9OIW+uX1jEQ=:nGU6ZSl+B1rlp/dVsaTXU3
 FBmHK7/gff2E8TECaL7eFFBDeZ3tXScmZAzWcQ/hf3sgfznFQOmHDtduXfJg8BPR/KZJ9hSrZ
 EqjNaWirjJ4MArFxcWD6EZaUQfXWkiM9ulZeWzrvHy9sPzI2YFzROIS8VmvqBrkG4rUEwX+L3
 04lsp0W81fowZ26MDsUTUDGJ1XgtiwJ086MU6sY+fAFYh2EuEph7Ptthkaoay3aBqzpOpp2S6
 Y9cezSNSWua2M8mPn0rVoXpKZ/yFoDKnwh8cPu32/CneuVGAeYTT2Er1fJKXYS3CdRsDdMIis
 9nyd39v1XlApgLtJVZ2QdFr+VmSjNF+h3ox4BMD1vx9yj11p33qgqTX6rbXe5gZMXm2VfLS9Q
 JHUakxzO8+F0rbBPgmgBXFrSgO7iWunURwnFNM8b84JcpZGmGcZ6IAlg7WHQy/GvE9rIME6E9
 BzIN6TJXj21LgopfM2yKD/jvB1hoPd47WSIGfFr8NuwDS7K66Fv3jQc3sCfa2Q1vGivo7pKvR
 PTxtR9AkSdMe5ReF1dV4ew5TBy9lWZn6zDv6txHjkt2G26XYs6pKJkmfbln4MdZXyzyPsDJTU
 jxL/RapepB5wyEdUQZGP2yGdmzPiSNnxfjAz3TK7m2ClIyH1rP/5ANiFLwYfjkjna3q6EpG3X
 T33RHGvF//sUOBNsIIEziRMeh2S+3h/Rl6cM5zOkSOSaxf4FAJvKkhPEdWvdGg9rNwqP+xqZr
 VjGKB/KalMOrPindJhQWFoHZuxLwtRATbAY4BwiFlQvAmecWK7hDsm7mPz7dJpOPMpmspoOCS
 ccPDJUeCzAFC7/BQ5KAnh0+GRAvxNQQxqt5TzqiceRGmff+JSuw5pB4sOcWcT477cM88bf5RY
 PTWHU2nIrC+Tmt3VlfE+cglmXx0s02hYeQWqN1gXa6WeaMSOaRzEWKaLNRM1SUr48CEp7pJsG
 dYiJcIhA8i5QYPdU8/Sshcb43ucEywcaCif/pb26rbwqYZ9CAforKfkysGJz2hTivtufP7inH
 h26nEvYH0v27gVLmQZheZOKSuIXpGuB99rIxDQri0CGVc1vlrQyd62GW9koERG9YVR+EQdATF
 xTVrKciEIpH4b7jCLMFEJhBy0YOd3MZZHKG
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 19, 2021 at 08:49:54AM +0000, David Laight wrote:
> From: Len Baker
> > Sent: 18 July 2021 12:32
> >
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy().
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > index ab885353f668..1a193f900779 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > @@ -2226,7 +2226,8 @@ static void ieee80211_start_ibss_wq(struct work_=
struct *work)
> >  	mutex_lock(&ieee->wx_mutex);
> >
> >  	if (ieee->current_network.ssid_len =3D=3D 0) {
> > -		strcpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID);
> > +		strscpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID,
> > +			sizeof(ieee->current_network.ssid));
>
> I'm pretty sure that recent compiler releases know enough
> about strcpy() to error overflows for strcpy() from quoted
> strings into char[].
>
> If these checks are enabled for kernel builds then they are
> actually safer than the run-time check above
> (which can be mistyped).
>
> The compiler can (it may not) convert the strcpy() into a memcpy()
> using the compile-time length of the quoted string.

I agree, but if we want to remove this function entirely from the kernel [=
1]
we need to replace all the strcpy() uses as a previous step. And the safe
replacement is strscpy() [2].

[1] https://github.com/KSPP/linux/issues/88
[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK=
1 1PT, UK
> Registration No: 1397386 (Wales)
>

Thanks for the feedback,
Len
