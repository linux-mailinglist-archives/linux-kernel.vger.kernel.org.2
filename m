Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049323D3C42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhGWOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:34:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:49171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235438AbhGWOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627053313;
        bh=OjiRy3yEmPn7YKRxpzy1s0ZNeFE94rnGLnb9AsXrlrs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=H1Y1o8/WhCSLA3gc+0iqX22b/7RsEHnJ+T3K35hIWib/0K6FkHReRw18Lwe8bI2et
         SGrfYjew+nX3eCngJhp4bJINYwa93afwF8BWifjCBUWOAEonZyleQtHHs2hyRhY01G
         IwJp/GENms9sZCLvGyVZ4cqetB01vaPu1xhJaQZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0X8o-1lCcqr2KVI-00wX6P; Fri, 23
 Jul 2021 17:15:13 +0200
Date:   Fri, 23 Jul 2021 17:15:10 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Len Baker <len.baker@gmx.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210723151510.GB2612@titan>
References: <20210717155145.15041-1-len.baker@gmx.com>
 <20210719053747.GN1931@kadam>
 <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
 <20210721080624.GV1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721080624.GV1931@kadam>
X-Provags-ID: V03:K1:EjRz48SDHlgr1UpUhBNgHpxEM7iMvIZeYSbMqtOd1Qri1AfHw4I
 rJ8JN6O4hqGwyTqfQgAAa79cnga98vlF3R/AeoCXJMUuBBVEM7AN/b2gMJKvDdoL5KRjeu/
 tovnT0UgvwdS5yr+DGM/NkVq5ZdlXaa5FYJU0cu48Xl65UsX07VNdRRzfvrr6NUSauVrMUE
 Qgi9u0UgkDwUkEGbx+lug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojBJ4x3ZywM=:h8VEkbI3Xfc0vDCVs9p+5D
 bqZ5qDKdnnBaJRewL45NwPqchkzMZRs3ujPsDHwnzZLdzXD8ivKqQHDXdPd+oF2tWzjnb06Tt
 vb+cOG9kzhhZpCLpDRa8eLLwdO3bHosmcPg8p454Oj/4cMcngizLidvch0NNgIRTm/v6zUD5s
 wxtSZnmKHsbGsuUYzyyg4LVNWh5Jz5YxM8qj4LwD3zqBZWAZvSVNhqhjy0yUGfMrVRzf6ZbXp
 D7eukbykaSIw4SGWKyA/StUF71DAHH2mB37pJQUmthF27uWVFaU8lHmwrH6IturgtHQYSKlGz
 rF53Dcx9kzSxizsAMT4wQStt6O8wHlyg1PEpFpnnllknfoCjFfZ86KmtIKbqIJfxaDIoKb8cR
 KASpUSk7nUiRlgpAJGR/Cx4/xx/P76kujEjj3GiITHdlKFd/CKeepGrHdmqVgA+cGkzHs5bOz
 bouLDJ7IJK52zV+tRuamR9n/knyjaA8oPAHmjx2yEtmmzryhB34YkG4LzyLyne0X53MxHyjmt
 gqgWmQ5g8WsgHUzA6ooFyQTlOMXv9OdYhvyiqzX55xYtSObqKw1QTZ4JXU0J+b2Z0MwO9n1Tw
 AYCSnqPrmcVrZHjaOXTxb0FNpTPL/G7mo4kdBEPlG0kkk7ZfQfJ00+BO3wSb8RQoSt2qHyFrt
 SUUy47HmqwoRu9T8ghOcGUoCgAIsYbmrR0j+xTu9XkzSdArlgMbthdHneqiEn7R9LKDxOjxp1
 2PLlpn7FAtzJezVh2TFHBJ39bPA4jI+eP55n5NzXPYdatAPbSawvrrNz92/oFSZdM+Rg4wd8K
 5wM534+63/Pb85RCv8j3eEXvkkE+FLseNBtng0cTpuXBKJdFE1JdLowEn41wEO87DVJKCvZpd
 I/hURtPc3V45BPDCND2+lmZRhujieyXahNLamq5lP2t1Q0uTkMQLmLua8UU6TrTL/EgZcV0RZ
 33lNN+BOtQg3Dkaij4um2v4VSt/n1zXfkjxiTKKi5RGolzeBbyaTKo9QILQKv9CpVd3B/ScNo
 CSjoH89x1JP9spRj0LL2vQ5TjGZ02LPfkdm/olRI2eXLFpHZRa63MNsIRwKuwbBuq4+KXQOC3
 IAXzqlhHgp88dpXZzruNW+LX1KhiQFQZr7q
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 21, 2021 at 11:06:24AM +0300, Dan Carpenter wrote:
> On Mon, Jul 19, 2021 at 03:24:38PM +0000, David Laight wrote:
> > From: Dan Carpenter
> > > Sent: 19 July 2021 06:38
> > ...
> > > Not related to your patch but this code is bad.  What it does is the
> > > "ifname" can be set as a module parameter.  So instead of testing if=
 it
> > > has been set, it uses the checking inside dev_alloc_name() to see if=
 we
> > > can allocate what the user requested.  If not then set it to "wlan%d=
".
> > > If we cannot allocate what the user wants then we should return an
> > > error.
> > >
> > > It should do:
> > >
> > > 	if (ifname[0] =3D=3D '\0')
> > > 		strscpy(ifname, "wlan%d", sizeof(ifname));
> > >
> > > 	ret =3D dev_alloc_name(pnetdev, ifname);
> > > 	if (ret < 0) {
> > > 		dev_err(pnetdev, "allocating device name failed.\n");
> > > 		return NULL;
> > > 	}
> >
> > I know only root can set module parameters, but having one
> > that contains a string used as a printf format seems
> > dangerous at best.
> >
> > Isn't it best to let userspace rename the interfaces later on?
>
> Yeah.  I think you're right.

Sorry, but I don't understand if the code needs to be improved or not.
Is the code shown by Dan not correct?

>
> regards,
> dan carpenter
>

Thanks for your time,
Len
