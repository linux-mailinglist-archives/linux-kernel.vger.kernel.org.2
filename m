Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA33D3D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhGWPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:50:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:56431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGWPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627057845;
        bh=i2eyECN2ErolGI155WrFmDMOyXQmF1jvaDqN7DICg/M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iVxJINsCiFT6AHJ/S77uhb8a/GuEwW7LnI2u6zpkqLEV8pYR/9woG8MiZbfMyp2o8
         2NFL1BjM81dGSS/Ae605dWVSqAN9dxHHWvUp5wLNOExgfhV1GfhGN6Mh8yIADe85UT
         a4X57pVSKNv8isdMiqBq7g8UepbzLEd1uByTlkIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2W5-1lPcMU2FlP-00k4bQ; Fri, 23
 Jul 2021 18:30:45 +0200
Date:   Fri, 23 Jul 2021 18:30:40 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Kyx <knv418@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        William Durand <will+git@drnd.me>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        zhaoxiao <zhaoxiao@uniontech.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/rtl8192e: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210723152559.GC2612@titan>
References: <20210718090636.7905-1-len.baker@gmx.com>
 <20210719054345.GO1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719054345.GO1931@kadam>
X-Provags-ID: V03:K1:7GxA+IL5sU8hfSmhpedcRUgch+iG+s9S2PsG6gsn8CHkkbm3YCM
 Wj+kqwaG6rTENKA0yOqOGfPxnAgQ/B4XjpBaoeCYacyHpj3E/uC2JF45iJKhLgYje87z63v
 5CVAwtLcIIASoX7pGnqCYsXOi4xGmH5wEAOYECSRlDw6LUIs5iBxnMv8aJWVA2Mjxij2uOF
 7B4EKBd0wl9D5ygPfCVWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:50g003CcOz0=:2rOTzdOQO6oYSyj8EECuNG
 YmgNPkBIAoF4gBSx9S0vp4WvGjcDccEzre8dKk830U6V75kk1KAUWeNlWfRGLtj5t+j3H5O/2
 NF8ceukSQKbpco1GNMLgbhziHl/nko5vQllL8k8rieK6aBqL8iJwpjQTUFlFHf2fhZeOXqYIJ
 hbBWyoPlJn8TOn3fMl5aO7df5bMbCSYQUTx99yqAgmE6KpBG6tZlZpJBoopzYru/ER9w7IHdx
 DzSZQIkESgubCPtlKqszVrI54N/8CGHPrY2CUetOL28SRBNJBjNS0iTg9GyyjhhTXfqbKSXpg
 Lm6a18VnuVjN9Na9uY9uVnKGaifJqh5vHgy8TqMrjH1UYM1KbRjXHx0Cs6X6lH2Lg7F6kDdSH
 sk0dlT6iXsEGciEg56sZDnjca8lkgAVKA5qi1KLs20kVjeOm6qWIB8x82NEMcbFZ1d35MtcTu
 qNpM3lzbje26Es3/J6MVL8NC+vMqhqF+9U35bB3mpuKFES9fPAncoUku4nycCOHJr8NDk2Yet
 6zoGUczAOhHmyXTKLieftlaDy/jNQRrfXH39Q0Z/w+z+9fWazm9bBymNsQq+ZaXvRbPqMUtvF
 usEARj5quoVoBsOlRfu0tXDOgVXQB9l8maKuic18dYRTztJcwMMA2WvRIr1p8R8a0hEqzS5hq
 R42NqkA75wrBtIgu5PuIBE5ykrGV+7o77A3YTwbAY3yPyXV+HbWWedDTNwdFIgFA+8jVQQ0Ip
 mLz1Af6SoGv88KuUJNlBD8oLxRzbQHryCWd15CpIxMwvVsRD1/QXZkuHLkh/HQyjoHUnQ/y9S
 bDCWZTvzokIQ7A8XtzPWmpaMcIvKrApiEFiBsStx5EqNsuUgLCNt7yx/PArG9EapJjiMiDCYJ
 JGqYAk08ptDWn89CqDkkNR5uGSiEp+gqnKYyoQn0bRuCa09xYiwnToCedqLEGtLu/+iUvJtaH
 VPbKnyvMeoGtXPsdhG3yZqRhrM3odVwpNK/z2zgdGUfANn1fLworFi/DxvM0mG2cMzcgor11s
 Nz9BkvjAI/NpOHedXy5LYGfCvsICEhGIBLa3Nwq1GkYT8/JAP8FIjgj6ub3uwHgcHbw75O9Tc
 5ffHTBnNzwfjHFYI9FcpovnABxC6TXBdzm7
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 19, 2021 at 08:43:45AM +0300, Dan Carpenter wrote:
> On Sun, Jul 18, 2021 at 11:06:36AM +0200, Len Baker wrote:
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/st=
aging/rtl8192e/rtllib_softmac_wx.c
> > index f89799d43b1b..5968407c646d 100644
> > --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > @@ -543,7 +543,7 @@ int rtllib_wx_get_name(struct rtllib_device *ieee,
> >  			     struct iw_request_info *info,
> >  			     union iwreq_data *wrqu, char *extra)
> >  {
> > -	strcpy(wrqu->name, "802.11");
> > +	strscpy(wrqu->name, "802.11", sizeof(wrqu->name));
> >
> >  	if (ieee->modulation & RTLLIB_CCK_MODULATION)
> >  		strcat(wrqu->name, "b");
>
> This patch is just about silencing inferior static analysis tools,
> right?  Most checkers can figure out the size of the array and verify
> that it has space for "802.11".  Probably it's only raw grep which
> can't.
>
> It doesn't make sense to me that we have strscpy() followed by strcat.
> So let's fix both.

Ok, I will send a v2 for review. Thanks for the feedback.

>
> regards,
> dan carpenter

Regards,
Len
