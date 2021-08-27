Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4843F9EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhH0S2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:28:40 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49232 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhH0S2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:28:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 8994682098;
        Fri, 27 Aug 2021 21:27:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630088867;
        bh=PutFRYxjXodbWViMVg+LuI9INKa/f4FnuJ9noz48B/E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Y/TqgD+v+VnAMaOFLsYEujukHPg3o+sLrPPOpWY8NTzRd8OSKUhnNakNpMpP5P9Ot
         B5klg/z8X1g+jS0n1GEaF3MCERngJMJqFBN5egGLueRAGaqXFDe3Dn88KLwBX6OHcH
         MgXrCJbdUqs410HviRn+RGfVn0peRES5PCc6fl/w=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 21:27:47 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 21:27:47 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: RE: Ntfs3 git repo in github should not back merge
Thread-Topic: Ntfs3 git repo in github should not back merge
Thread-Index: AQHXmedQiBjFmTMWl0yF1pCHwuQpm6uHqJ9A
Date:   Fri, 27 Aug 2021 18:27:47 +0000
Message-ID: <3e3b8facf46c4d68afeb0346dee66f5b@paragon-software.com>
References: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
In-Reply-To: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Wednesday, August 25, 2021 10:28 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev
> Cc: linux-kernel@vger.kernel.org; Stephen Rothwell <sfr@canb.auug.org.au>
> Subject: Ntfs3 git repo in github should not back merge
>=20
> Hello Konstantin.
>=20
> I notice that you have made back-merge in ntfs3 git repo in github.
> This should not be done without good reason and there is none in this
> case. If there is reason you should also write good merge commit for it.
> As you are just coming to maintener I will write little info about how
> this stuff works. I'm not maintainer, but I have study about how kernel
> is maintained.
>=20
> Here is link which you can read about back-merges. If you have any
> questions you can always ask.
>=20
> 01.org/linuxgraphics/gfx-docs/drm/maintainer/rebasing-and-merging.html#me=
rging-from-sibling-or-upstream-trees
>=20

Hi Kari!
Thanks a lot for this piece of information. It is really important to know.
Apologies for messing the back-merge up, we'll study the provided documenta=
tion
and will follow it in future (and won't be back merging again).
There is really a LOT of information to handle there.

> You could also go check some other trees how they do it. Usually there
> is next/master/main/for-next which will be repo which will contain stuff
> for next-merge window. This is usually based on rc1, rc2, rc3 depending
> when you put first patches to next merge window. As you based your
> branch top of the rc5.
>=20
> https://git.kernel.org/?s=3Didle
>=20
> Because your master branch is  for next you could have rebased your
> branch top of the rc7 if you want to but that is kinda pointless. You
> could always fix little mistakes in next branch with rebase, but you
> should propably info this action to ntfs3 mailing list.
>=20
> The idea is that this repo has very clean history always when it get
> merged to Linus tree. Also developers who work with ntfs3 can see
> everything in one eye.
>=20
> Example take a look Ext4 dev (for-next) branch
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=3Dd=
ev
> You see that this is based on rc2. Theodore will create pull-request
> based on this when he creates pull-request. Very clean history and no
> back-merges.
>=20
> If you wonder how should you do development then if you can't back
> merge. You should do develompent in linux-next branch. This way you
> always know if others break something reletad to ntfs3. Then you check
> who was it and send email about it and you solve it together. It can be
> tricky some times who will take which patches but help is given if you
> ask.
>=20
This last paragraph actually is not very clear. Can you please refer couple=
 of
examples of such activity?

> There is lot of small info what I did not include here and hopefully
> everything is correct. Hopefully you will also in near future respond
> patches which are sent to you. There is already quite lot. If you need
> any help how to maintainer should handle those I can assisntant you best
> I can. There will be example little bit work howto make all fixes tags
> right because you will have to rebase your current commits as they do
> not have example reviewed-tags.
>=20
We've just applied several patches proposed for past ~month. Please have a =
look
on them - we tried to stick to the patch acception guidelines. Hopefully, t=
hey
are good from this point of view.

> I also CC linux-next maintainer as he knows this stuff and can say if I
> say something wrong. And I feel like new maintainer can have little help
> from gurus.
>=20
> Kari Argillander

Thanks a lot once again, Kari! Really great help here.

Best regards,
Konstantin
