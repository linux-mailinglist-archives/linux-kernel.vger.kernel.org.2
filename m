Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32723623CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbhDPPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:21:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:42011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243051AbhDPPVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618586432;
        bh=o8y9pcmg8Eesddl3oGmRlZ5y7tRkqQSYlyuTQm6bUt4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dLNgC41zHDE41jGivU1wiyGuJYWZGPSelfQxgRiieV0hG83f7WPtVEKfC1zJl8ofa
         l0AMTDyC8jNbnkfZXOJbTtEwEdOH6vyiOBEteqKsHqbnh3IFCojYkfAY+af1VlVxSn
         9rAh9+lDWfwg5EF9O8EHvR8ohZpenrcQ0w/6WHsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1lFcBy43Dl-00I092; Fri, 16
 Apr 2021 17:13:28 +0200
Message-ID: <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
From:   Mike Galbraith <efault@gmx.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 16 Apr 2021 17:13:26 +0200
In-Reply-To: <20210416144459.GB22348@zn.tnic>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
         <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
         <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
         <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
         <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
         <20210416121636.GA22348@zn.tnic>
         <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
         <20210416144459.GB22348@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y7YG8mesp+ucSQBe9vAuOgwkkH8o0iUHqPsI/eG8TYCbhKvMYZe
 Yqn/XfLnv3FbQvfU8j2XqtQzFHrSMCtCIstgvcjAbFp593d4vxAlfvJvKlW2lSifkpOm/+i
 lLO0ILfgu5AqdMAYGG4Pj7RaPevI7LepykF2L+41sG8Qr1TaYCKgW5fBxAW0gNCe9qgqMbv
 J/sVzh4JqUB/q7X1MVxbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+f3s7v0sDw=:nvxg/VVipUJwGadXpOu7JD
 hLhrguOvfKiq4RSlkdtwSXjxpkbRrxKwnZCZ0U70jhJHvC6+uU780obraNYPSV0FngpcoYCf/
 8nA4dox1RVLIvVhs3JQx0py6uvKozOpnur56WgjLicBzcE7V4q6i7WJ/5qXakkOJFC+O9Az73
 rXERFXAWeufeHOCTVHYm9Vljp+iwmoURVlsaJeBolB8zgcXtzI1oxJQ9GYL/LqR7DyWZt+rRx
 VxOCrfgFqBJvLSk3ycpqXZD9TzcfqS+3q10FU1dWphlFzz8MRJ2tHxkfGiuuAcEm0NZVLva3q
 F0QEOIuedLGgBUpUxalfYvzMdttSwQdLklzp7JDvRLED1wzowLEdKtDhM0tr9+LN30knuWEGq
 JmVSVG7Icb/JsgLnNapB1oF7VlmMipGm9Hbx27Oe7+8DyyJGDF6JHtBGoQaOxB+89je38/wNW
 u68A86ZYI4zagZTnag8QN22OyTsX4EmSSXhORLN8VUH/uKXSrrbr3N/Riuex1YzYPu4V+bkjE
 p02knZb3BjDG6EPMcfvkcOB9LjFF9oK5uhL1NRPdZrpw40JiJl6y52MmP7KmPJ8cqIU6piE/b
 bSOs4SjP4AN3OL7EDuzDp4O0mV4n75ZetM0lXfgRJSZOJqDRAecgOtC+Y1Uw7ou7Jg7Ob4giw
 KLqG4484gCxX1zI3CfP+YZw8MGn8bb7a1aepj7rHOB8QVgg6YsrWRrF1UwmzEAgPZBgrlNb5E
 7Tk7yXOX3ZPQSQqi/oqYLT0kc45PQWU/7/7ZqmCi1luiAVpyjrIgAzWI+onH8Nwl5RdaRk3vT
 jVouyXrRS6S5h2yLQs+GCTAkAjrEQTsIXokeNjfRROxbY1oiJtriorKQezYG9JILURnsE8zoY
 /7JP44JLDEwpiGyqKkvRBIl30AWSeZwVUynvFLx/Yzx0XicueoA9hldmVVREsRmhB3Bww5Ed2
 Sy3o48fI9ywIWXgpmG2YOQNn0rRd98wRUqj4W/u3MBzjGgYWOZ37lU7ikQAFqQcanSquQIMc0
 0GiERy0mRRzl2AQR1ZgdgIjJDMBPvSlInM0kWrR7k1X61n2RPBDxhUHzUDoOkVGYCiXhK7216
 /hRX901Tam53cs1UAOZuSPoCRzanFALRaTDwm02Rtup76ET1swRRpAqPg1H+OZylFF80T6yTK
 U7jy24y6h4hUdE8Ntc5NKqDgeVIfaBhv8EJl4o1+uT4++SqKhF9OXnrPtNKMHy17Q1kdU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 16:44 +0200, Borislav Petkov wrote:
> On Fri, Apr 16, 2021 at 03:16:07PM +0200, Mike Galbraith wrote:
> > On Fri, 2021-04-16 at 14:16 +0200, Borislav Petkov wrote:
> > >
> > > Please be more verbose and structure your commit message like this:
> >
> > Hrmph, I thought it was too verbose for dinky one-liner if anything.
>
> Please look at how other commit messages in tip have free text - not
> only tools output.
>
> Also, this looks like a fix for some previous commit. Please dig out
> which commit introduced the issue and put its commit ID in a Fixes: tag
> above your S-o-B.
>
> If you don't have time or desire to do that, you can say so and I'll do
> it myself when I get a chance.

Ok, bin it for the nonce.

	-Mike

