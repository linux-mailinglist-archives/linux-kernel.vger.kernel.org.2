Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE03D3BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhGWNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:50:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:34013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhGWNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627050636;
        bh=it+WGUc0qD88juRqzwleShmRVvDkiPGSwR+c+wEC9Hk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YbQzt/SNYUZCxHyrlgaF2dchTqZdeW54ZTNsHfgW/SqJKuQ9n0Gum45nGAHJsqyu2
         zOr6LJjlyNzIVoQxvxwHC5cH1oFz6yBL702Q6XpBYEsxDWTzpxW0UlQ/JYCPwSGpqQ
         g9w7HH9sRjZBvbSlcALmI4lqvcwPMq3O6/JVkl0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXUD-1lq6AN2Gjn-00JbTU; Fri, 23
 Jul 2021 16:30:36 +0200
Date:   Fri, 23 Jul 2021 16:30:25 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/ks7010: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210723143025.GA2612@titan>
References: <20210717153759.13468-1-len.baker@gmx.com>
 <20210719052623.GW25548@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719052623.GW25548@kadam>
X-Provags-ID: V03:K1:S7QRq/4lLilEyOfATqKxG0FwSWSB7RtXGR4Dujf7AbfAkO4dalv
 0+2g2AMniHp1pO6OXEEWL86WM1anhaybgcBHBT5R2askXg1vGayrkKP7vtJpZzb2Bkmy3AF
 xntbVtFlpUbgI6Xmkof3KE2mM6CwZlwyWZ+cG6jB9jaoJg73l/HqK/3fux4//irCZq1jFpv
 kPOEavsdwNj8wX/4+Je9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BFInwDXwN3Q=:w37R065HZWXQMXdTZYnbn8
 JL4Sn3maaHa2+NoidMKxdzEQzCD4GLkrjPNhTcpcqoTsEhlSAt0E0416kC7o2+rvKrtlBiayo
 LFy4wwdFFVuoEU8szRM19o+6DjyXeSFvUBs6b2M8ja9d2sQ84i1K5J0Ts/BYFR8ZWihp8Jzt8
 iTvM/7wYo/ZUioTm1pN+1zK3huIqKn206pa8bl+WH9TwyltseyElys0TcZ1FVVQnxWhoDut6q
 /BhpHqwVJmA56nj0gZT/Yj9R8y5rWlRRUok5IDhzjRYZ6n2rcJY+pJSREY9f2odwh8xIrMaZs
 j0Pr57C5U3SXVKb+kKf1QS1z3gB5TIOI509I84/jB4hSu2gM0iTSn7aQt6p4opB5UYL+C3Hv4
 V1BwFxBRC+krozyqiRGop1GGTg2cPdOX+kgPaVZ6L1k2hHJnu5gYX+BHlNiPButpIMMil0kbJ
 JkwZO1uNye2pOe+u3EBbRSTrq6FD/zKFFWsOmXqrD21VJrGQCdY6vlWBKfJefcdS8hX7eM3+g
 jUSlMm1HxsFRv/lSZcy16UBlpHoQPSMdh+1p8atqgJtlhoZLqua8NfBS85LIELxlS97rrlQ3N
 c15Cr+5/r3s35B3mGc3uevwpEry7NPIXNpFdfiyk8kWIZS5zYbDKLDPlHWYQeDCbnLIzY11eC
 RyaAqXCmUDNTW22PKsw8X+gA97txIrDIVv20Va6HN6dCPTO3PBrPgOJbbFEnP7EXGqFGn6dWt
 TSbRvM9XC/y+8BKfZi40I9EUHzsZ6cPhuCq3CGKuF/m8iKOAljGwcjn9UosCyq8scJgqS+OFv
 iMMn45zZzg7Z8KpiOYSkbpoGwyZIREyHSvgnbOxMGhOLVv7MwxYscAdiQmxv2Mwj7u3JJ8et3
 qVJnz14McZqscjsn6PVPOu97V1LAMNRcKhj1RNEJFZJGtkXS6hdffrVzXCmPKCD1DgWH10Eqb
 wl6mhYVP9WCs85vDm9XAgCedzDakNl9g0Mr/MXh8gbd48muiCkO0hbugMe7PWUAp7G8kKA5G9
 BYch4xzPmFS3TdlMymlmINjsmKlVAug+bvEK1oGHOoVfk9G5ODxRV/c59sTMvRJ7NPc4laBsI
 bKp62uQ5BnG+dR+koIUBsgyR1mQiv8P/p9j
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 19, 2021 at 08:26:23AM +0300, Dan Carpenter wrote:
> On Sat, Jul 17, 2021 at 05:37:59PM +0200, Len Baker wrote:
> > @@ -1808,7 +1808,7 @@ static int ks_wlan_get_firmware_version(struct n=
et_device *dev,
> >  {
> >  	struct ks_wlan_private *priv =3D netdev_priv(dev);
> >
> > -	strcpy(extra, priv->firmware_version);
> > +	strscpy(extra, priv->firmware_version, sizeof(extra));
>
> Extra is a pointer and not an array so this doesn't work.

Apologies. I will send a v2 for review.

Thanks for your time.
Len
