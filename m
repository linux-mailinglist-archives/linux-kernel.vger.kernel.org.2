Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250163F9DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbhH0RSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:18:50 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:60421 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240482AbhH0RSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:18:45 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 1115082098;
        Fri, 27 Aug 2021 20:17:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630084675;
        bh=5Nw7v9NTMS8258UFCfYCXGLMQoTyuQKiZqWPaggUcRg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=pdVACW35hyhaFzg3zWisQOuPMSYYs1UIjG96vGDuqJqVxdnqb543ANHeTHaE5Oil3
         P+gkXxKGL59DG69Of1wKoTNWHY2DiaBaOPEQ294l5Q7uIaTd//1Ranf2Oqy5nT8EZ0
         pQiEeh/LOv7IYFHZbAWhk3MoHf8ZRHp7UtXfUhLc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 20:17:54 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 20:17:54 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kari Argillander <kari.argillander@gmail.com>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] fs/ntfs3: fix an error code in ntfs_get_acl_ex()
Thread-Topic: [PATCH] fs/ntfs3: fix an error code in ntfs_get_acl_ex()
Thread-Index: AQHXmN4THTu3LgVVhE6dhDj9H1dO4KuCqQOAgAAH9QCABOwqsA==
Date:   Fri, 27 Aug 2021 17:17:54 +0000
Message-ID: <dbd79495182b43568d1c6b397d1abfff@paragon-software.com>
References: <20210824114858.GH31143@kili>
 <20210824163851.hfbjqqpztgk4ngd5@kari-VirtualBox>
 <20210824170720.GO7722@kadam>
In-Reply-To: <20210824170720.GO7722@kadam>
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

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Tuesday, August 24, 2021 8:07 PM
> To: Kari Argillander <kari.argillander@gmail.com>
> Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: Re: [PATCH] fs/ntfs3: fix an error code in ntfs_get_acl_ex()
>=20
> On Tue, Aug 24, 2021 at 07:38:51PM +0300, Kari Argillander wrote:
> > On Tue, Aug 24, 2021 at 02:48:58PM +0300, Dan Carpenter wrote:
> > > diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> > > index 9239c388050e..e8ed38d0c4c9 100644
> > > --- a/fs/ntfs3/xattr.c
> > > +++ b/fs/ntfs3/xattr.c
> > > @@ -521,7 +521,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct u=
ser_namespace *mnt_userns,
> > >  		ni_unlock(ni);
> > >
> > >  	/* Translate extended attribute to acl */
> > > -	if (err > 0) {
> > > +	if (err >=3D 0) {
> >
> > So now if err (size) is 0 it will try to get acl. Didn't you just say
> > that you want to return PTR_ERR(-EINVAL)?
> >
>=20
> If you pass an invalid too short size to posix_acl_from_xattr() then it
> returns PTR_ERR(-EINVAL).  It was hard to phrase this in the change log
> but I feel like length of 1 and 0 should be treated the same.
>=20
>=20
> > So overall good finding but maybe more work is needed with this one.
> >
> > >  		acl =3D posix_acl_from_xattr(mnt_userns, buf, err);
> > >  		if (!IS_ERR(acl))
> > >  			set_cached_acl(inode, type, acl);
>=20
> regards,
> dan carpenter
>=20

Applied, thanks!
