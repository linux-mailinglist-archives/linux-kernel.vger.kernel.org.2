Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE93C8530
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhGNNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:24:26 -0400
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:56611 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhGNNYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:24:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 4GPynm2rDgz2xmw
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:references:message-id
        :in-reply-to:subject:subject:from:from:date:date:received
        :received:received:received:received:received:received:received;
         s=dwd-csg20210107; t=1626268892; x=1627478493; bh=rC91dTXFvRr3r
        OtpPl0ShWTCp53IkHsjHHQqKnRECTc=; b=Z8SKd8SySXFBOX/LEeAWQlOIK61QO
        xX0mWn3B5QxI8DE9oMXhVHxbxDaKfNN4uNwYwo0cLmIuDX+TqxxgGNMxhRcUaqry
        miam00/SVQHx+tm7YqVVE+PZyahqP1Zd8FlkIye+MO0AuXIh0cGxwG0MR5hVuxz0
        GWssJVlvQNe1WEHirJb6f5Nx4cVMJseuNQOzF6FmM5z2GtcJVPbwqRoX6u+JQ/Sc
        8szx6PIWxX2xEO9ZlBBLduDz/AQHe/neLbEzYNoEltnDMTMKEptWC+bvxihOwa1p
        xbu2lV0XK2/oZalSJdtSbC2lrvrmRcYd6Gzg6bEbj/UIBaAi4MlsnvmIQ==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
        by localhost (ofcsg2dn3.dwd.de [172.30.232.26]) (amavisd-new, port 10024)
        with ESMTP id ep5a1XElZ-Ji for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3972CC901C81
        for <root@ofcsg2dn3.dwd.de>; Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 2E028C90244C
        for <root@ofcsg2dn3.dwd.de>; Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.26])
        by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn3.dwd.de>; Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Wed, 14 Jul 2021 13:21:32 -0000
Received: from ofcsg2dvf1.dwd.de (ofcsg2dvf1.dwd.de [172.30.232.10])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTPS id 4GPynm0xHvz2xl8;
        Wed, 14 Jul 2021 13:21:32 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs16.dwd.de [141.38.39.208])
        by ofcsg2dvf1.dwd.de  with ESMTP id 16EDLVIV032363-16EDLVIW032363;
        Wed, 14 Jul 2021 13:21:31 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 8E83A45410;
        Wed, 14 Jul 2021 13:21:31 +0000 (UTC)
Date:   Wed, 14 Jul 2021 13:21:31 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     Pavel Machek <pavel@denx.de>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.13 000/800] 5.13.2-rc1 review
In-Reply-To: <20210714104119.GA30649@amd>
Message-ID: <eb7845ca-985-e5af-39bd-a7d68ad57727@praktifix.dwd.de>
References: <20210712060912.995381202@linuxfoundation.org> <68b6051-09c-9dc8-4b52-c4e766fee5@praktifix.dwd.de> <YO56HTE3k95JLeje@kroah.com> <50fb4713-6b5d-b5e0-786a-6ece57896d2f@praktifix.dwd.de> <20653f1-deaa-6fac-1f8-19319e87623a@praktifix.dwd.de>
 <a59b73aa-24f6-7395-6b99-d6c62feb0fc4@kernel.org> <83b8a9a7-a29c-526-d36-78737cb9f56b@praktifix.dwd.de> <20210714104119.GA30649@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-8.6.1018-26280.007
X-TMASE-Result: 10--13.025200-10.000000
X-TMASE-MatchedRID: 6otD/cJAac2WfDtBOz4q28bYuTb6+cQg69aS+7/zbj/mNRhvDVinv6Sx
        VUPqsOdUF1ap610mzeKT2y3cScrksRlYm7tAsl9CbMGKOuLn5FUB4JHtiamkLOyiG9Aw9qJGS6j
        EzaLelQhA5GooFgjK1/fNFVA4Doasq6H6eyKIRsNZMZ6MZ0H1Ugv/9UzFeXITP4H+2nyK0FPiKq
        oPfA0a+hkNsHcU+86WvDcKSRapMI7+nNN71kmJXN+G9ND+fWcZV0QSZ/pNFUFW1jLbx3/ruueaW
        nfyNIoBrr5vesNAzYmXVoiCvbmRFCOQI/AMVaY11T7WuTapx0rId1+nCKlIfpsoi2XrUn/Jzhtq
        OA7SSC8fRoCwBzgRYiAHAopEd76v+7QElErey66ako8gXpYWFHDRxJHMsF1yClANR2EqcjxuNWq
        kLJ2svQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021, Pavel Machek wrote:

> Hi!
> > 
> > > On 14. 07. 21, 10:15, Holger Kiehl wrote:
> > > >> Yes, will try to do that. I think it will take some time ...
> > > >>
> > > > Hmm, I am doing something wrong?
> > > 
> > > No, you are not: -rcs are not tagged.
> > > 
> > > >     git clone
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > >     linux-5.13.y
> > > >     cd linux-5.13.y/
> > > >     git tag|grep v5.13
> > > >     v5.13
> > > >     v5.13-rc1
> > > >     v5.13-rc2
> > > >     v5.13-rc3
> > > >     v5.13-rc4
> > > >     v5.13-rc5
> > > >     v5.13-rc6
> > > >     v5.13-rc7
> > > >     v5.13.1
> > > > 
> > > > There is no v5.13.2-rc1. It is my first time with 'git bisect'. Must be
> > > > doing something wrong. How can I get the correct git kernel rc version?
> > > 
> > > So just bisect v5.13.1..linux-5.13.y.
> > > 
> > But what do I say for bad?
> > 
> >    git bisect bad linux-5.13.y
> >    error: Bad rev input: linux-5.13.y
> > 
> > Just saying:
> > 
> >    git bisect bad
> >    git bisect good v5.13.1
> >    Bisecting: a merge base must be tested
> >    [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> > 
> > If I read this correctly it now set v5.13 as bad and v5.13.1 as good.
> > How to set the correct bad?
> 
> You can use hashes instead of symbolic revisions, and that may be
> easier. I suspect you want to say "git bisect bad
> origin/linux-5.13.y". You can also just do git show and note the hash.
> 
> There's other option: git bisect can be quite confusing, but you are
> searching for a bug in linear history, so you can just git log
> --pretty=oneline into a file, then do the binary search
> manually. Should be 10 steps or so...
> 
Thanks! That 'git bisect bad origin/linux-5.13.y' got me going!

Holger
