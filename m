Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB03D9485
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhG1RqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:46:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:34557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhG1Rp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627494340;
        bh=2YMhgIVFIpcFYWrl8VJ85b+omZYWYfbhao4JskYXmfA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QREbQZUT8kwSfosauDEsPlBbSoda1IM1ZVRr5LDA/PGpWG0w8ytC+ceEKwioqdxv0
         wFBBCP6FFwowoyKa4YaxtjjOYkIHDPQowxsp3NP1Oyb9zF2rWFzy0KewEYZFX8D7wI
         QI4rw/iuXcSL7tw/OPLCECPqtqKf4goxfd7dnzQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzay-1mZqfR3MwM-00R2QF; Wed, 28
 Jul 2021 19:45:39 +0200
Date:   Wed, 28 Jul 2021 19:45:27 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Len Baker <len.baker@gmx.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210728174527.GA4275@titan>
References: <20210717155145.15041-1-len.baker@gmx.com>
 <20210719053747.GN1931@kadam>
 <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
 <20210721080624.GV1931@kadam>
 <20210723151510.GB2612@titan>
 <20210726081148.GF1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726081148.GF1931@kadam>
X-Provags-ID: V03:K1:hnORNkYY4j+OZ3r38+/VcZ/3w+bN0YS8S8yFZW3qYLNo/MWSVqo
 qrB9gEDvTKlMYbg6Rt0ZUEkkymy8/NclpbYwQ/fhdKb7epTgMz7hU/a3suNZPQbIPaZIjHe
 76twIOkEP3ikinwHCQIWAVs0WBYq5wXCF8faIS3sIxYQmiQDsBmER+s0n9Z977ZO5HRnwYz
 fxNKplQn3LrVEAMc7v5HQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nzhPRzZcdSk=:p01CsDRAtKqDdFLPAFRumF
 UFFU4lPZFUf842WUS1CEBxpOxzEv7QGl4z+zOWwWQpR58lHtoXCbO+ysC+u6php6w1t+RdMax
 JLhkrxLEvY1vQNtjWAkFsrlogEPhfkrfZ24by7FaQ6nskC7LjkknH9owq2wE/gMfUmTwfja0f
 n/bD6HGSzkUk5Gqh+f720C0gS9JJ3Q9VIjvRA7ceboMl/LRHtu9BVslFby7XpRbiaGGgBm3gn
 AlmTADtrwlVmFiyfTjkubSmsVlYlXnYILDr2tEEjkqdOEfEQu6HTjb2+r581gMZ7NNMq9NG8L
 02b9AMMYpC9urkaJRsE7v8NZClZx6IDRIooqPbPnC+VmqjZRsB0g+8zVj1U4ZkwEo3RJspAbW
 cNHLnmGqiPERrsyrel6LchFwDFczOif0rWEF/w4KaFkMCNYIWEHxFuNUE3g8EOo7uKGFEy6ON
 mCa9ztsTdUe8vKdhP+HaFRaIRe1yD0bicYa4lhILPZf41ERNNwZV4hZU7wxJ0hX9tfxvbGcOJ
 KYOrEtOor1wE7DdlaN4OLSLo0CwyeDP+/Gs/5pNsYS7aLdscC3yUMoAXAQq+Ta35ZtxazuzQ6
 AsExNf6+t89hnbg+giTG8jqf4vcxGgvLG4GlFHhbNn9daR3NHF6ae7fdZcIHkQL1SCsxmVbTk
 zKrCG718rVnbrLYDcI3pijbGgArPnRqdBg68x1AkXlANaM2utsexCZ1X+4nBdmD9tsINnBjgY
 3smiWy14KPuEqq+LfbGhhw3sy6lCS8GQROHiGw/NVRBKgaT7zq2sx4EtugWaz6glVgwj8fN8I
 kwgHWDK7K2PGXrhoLpiwBqjTUO3u0vtKhi/J2RoXZhQ9lYkK/SDASYM5dyLEmKKgrqxXQ8AHN
 nfOIiXHDfhnla8zYFueaeh9ajYr6Zj/dUneyEf5vSyoBia874nasH3PJRNUR/Rf8c9pge+Hnh
 RQMecIORr8lj845Eq1rDm+690XseI7OO90lX3M5+UxCJh5ZriPtRuynzYR3xG0FSrjVP4efcH
 vOaiHIP6TiAJSZnyufChQeEkdlQAjDWzoVE/emCEsD1RdBU7zIYPOoBdfjQbFxkqJOGhxKy+g
 cg81Ml1OkhUWP/HYn5fCMH5sEFj0UkWteA9
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:11:48AM +0300, Dan Carpenter wrote:
> On Fri, Jul 23, 2021 at 05:15:10PM +0200, Len Baker wrote:
> > Hi,
> >
> > On Wed, Jul 21, 2021 at 11:06:24AM +0300, Dan Carpenter wrote:
> > > On Mon, Jul 19, 2021 at 03:24:38PM +0000, David Laight wrote:
> > > >
> > > > I know only root can set module parameters, but having one
> > > > that contains a string used as a printf format seems
> > > > dangerous at best.
> > > >
> > > > Isn't it best to let userspace rename the interfaces later on?
> > >
> > > Yeah.  I think you're right.
> >
> > Sorry, but I don't understand if the code needs to be improved or not.
> > Is the code shown by Dan not correct?
>
> We should remove the ifname[] array and the module option completely.

Thanks for the clarification.

Regards,
Len
