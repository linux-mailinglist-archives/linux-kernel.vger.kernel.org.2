Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC5338655
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhCLHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:04:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30806 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhCLHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:04:18 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210312070413epoutp03536adfe71c9d6ec1026c2fe038d99695~rhmN3tniH0244402444epoutp038
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:04:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210312070413epoutp03536adfe71c9d6ec1026c2fe038d99695~rhmN3tniH0244402444epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615532653;
        bh=ueBRFe0PozkmE7udTafngrmT/ocvr3IYi4oepb5DYlM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=u8yEp7mwffSoZfN6sLBYQcpVJ9xAmT8iKdPUiem3nda6fo4fXb8LVvm/2T/6N2V1s
         KDEvzpYsvA+mOnQU5ud+BeREPTDtMxt5jy3UmX1MjdKYbl3/Jflrh5ypZyncug3CNX
         OrbOI3Ppc20Mwhy3ic5AknKOudup8/I8dP+/dFgc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210312070412epcas1p220db33dbd7e90c9e72df6733d1ee8af2~rhmNkxCTi2276122761epcas1p2-;
        Fri, 12 Mar 2021 07:04:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DxcHb5gDSz4x9QK; Fri, 12 Mar
        2021 07:04:11 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.A7.11962.8621B406; Fri, 12 Mar 2021 16:04:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210312070408epcas1p356f1421f0af1d29d3ca7abd37f73bd4c~rhmJkma7t1738017380epcas1p3H;
        Fri, 12 Mar 2021 07:04:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210312070408epsmtrp2049685e0484be4ca80067eefd2a3995f~rhmJj6ucQ1539915399epsmtrp2d;
        Fri, 12 Mar 2021 07:04:08 +0000 (GMT)
X-AuditID: b6c32a39-b5d34a8000002eba-76-604b1268512e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.ED.08745.8621B406; Fri, 12 Mar 2021 16:04:08 +0900 (KST)
Received: from jhs2lee03 (unknown [10.253.102.101]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210312070408epsmtip2f8d0ec93a4a62a13d6da9166d726a940~rhmJaD79u1964919649epsmtip2I;
        Fri, 12 Mar 2021 07:04:08 +0000 (GMT)
From:   =?utf-8?B?7J207KCV7ZiE?= <jhs2.lee@samsung.com>
To:     "'Sami Tolvanen'" <samitolvanen@google.com>
Cc:     "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'device-mapper development'" <dm-devel@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <CABCJKucMyQbtt-LACCRSk6bxAqmS05eVhv-5ou3_XZ1Nz+XYug@mail.gmail.com>
Subject: RE: [PATCH 2/2] dm verity: allow only one verify mode
Date:   Fri, 12 Mar 2021 16:04:08 +0900
Message-ID: <009001d7170d$e584d360$b08e7a20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJywKbl46ZRzKPvCQNOoTqt3A/c2AF7PY8mAhqlor8B7jzycakcb2ag
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTVzdDyDvBYEeHjcX6U8eYLfa+m81q
        cXnXHDaLpSveslq0bfzK6MDqsWBTqcf7fVfZPD5vkgtgjsqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMn429/LWNCvUrF61zemBsYPkl2M
        nBwSAiYS1zdPYuxi5OIQEtjBKHHo41M2COcTo8SxVUehMp8ZJd7sucYI03J/QR9UYhejxOe9
        W8ESQgIvGCUW3eMAsdkETCUOLlkCFhcR0Jf4e/UxmM0ssJFRorWdB8TmFAiUuHn8OXsXIweH
        sICdxIIv6SBhFgFVifZNL9hBbF4BS4kbH26xQNiCEidnPmGBGKMtsWzha2aIexQkdn86ygoy
        RkTATeLSA3eIEhGJ2Z1tzCBnSgj8ZJf49nUTC0S9i8TBxstQvwhLvDq+hR3ClpL4/G4vG0RD
        N6PE/fOv2SASExglenuYQBZICNhLvL9kAWIyC2hKrN+lD1GhKLHz91yoD/kk3n3tYYWo5pXo
        aBOCKFGSWPHvGtQFEhIbDnezTWBUmoXksVlIHpuF5INZCMsWMLKsYhRLLSjOTU8tNiwwRY7q
        TYzgtKhluYNx+tsPeocYmTgYDzFKcDArifBeeOmVIMSbklhZlVqUH19UmpNafIjRFBjUE5ml
        RJPzgYk5ryTe0NTI2NjYwsTM3MzUWEmcN8ngQbyQQHpiSWp2ampBahFMHxMHp1QDE9tTQR5z
        oXqDdtPNZYIuWR/SHRVS9Bgu39XyE9Gds/D5JcW/mw5ffTrpWMqGj+2yT1bIOIuKNT2wc6j7
        wJ+894qah4r+hDDr3jD2YzYlp/ZnpF8zXOT1O/m4Ydvf1W4vd9vtcny6meGa0OxVmt3Lfu34
        bzHnX/li5c44bSP9b5/T2GzeeV/vX3Vzy9X+4iaRH09e55+o32exIvez6uotDt7Rxz7cnX3q
        2vLb840+eQasWaS4saQwo/5g8dPGsmvrJ9tHPjRK5TpXLNWTtnCG8uKKo8cUeJ5++XFF4PtT
        d7GcpjjfUx1NC16emr9xpkSzvEoMexaf6reqlttbHrMYzNr4wNt9xgmJjZ4M+b/ZmpRYijMS
        DbWYi4oTAYalL7UUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvG6GkHeCwaR5khbrTx1jttj7bjar
        xeVdc9gslq54y2rRtvErowOrx4JNpR7v911l8/i8SS6AOYrLJiU1J7MstUjfLoEr49mLjewF
        h5Urfu9ex9LAOEOyi5GTQ0LAROL+gj7GLkYuDiGBHYwSzz7+ZYNISEhs2LSWvYuRA8gWljh8
        uBii5hmjxJ2OnSwgNWwCphIHlyxhBLFFBPQl/l59DDaIWWAzo0THurcsEB1TmCQWTzjDDlLF
        KRAocfP4c7CpwgJ2Egu+pIOEWQRUJdo3vQAr4RWwlLjx4RYLhC0ocXLmEzCbWUBb4unNp3D2
        soWvmSEOVZDY/ekoK8hIEQE3iUsP3CFKRCRmd7YxT2AUnoVk0iwkk2YhmTQLScsCRpZVjJKp
        BcW56bnFhgVGeanlesWJucWleel6yfm5mxjBMaKltYNxz6oPeocYmTgYDzFKcDArifBeeOmV
        IMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTL/OdiKr/
        O55bhXJOti34e2MLr19u+53Z7/6oyN80tpuXvXVtJu+92PDrPhqvG1nWdsxWrjv1xpJ593Hr
        jJ7MVUz2s9sc+EUfCEfUzZBTYvkpO91IU5oxzMBiT+IU7wevb5365R7Xdtvm0nLxBRuufxXc
        cN3mx9LoOI6/Vj+jFs3lPru8OGjehxlNRo3593aKSj/tivy5uNXiJh8fz+/zPzmVfHPj4rKu
        xMi6Mf4IeZy7QPXH7ZgGuz9vz9ye33UlRHiu6j2Z9MnXQn/xbxDnW39r9cYI88IjdrLTb6y+
        s3u9deOGK7sFUttX3qmKm3Pi0sTYTatdlTO+7na4qv7mg3Ox/+SLp5Pn8Bk4/X59U4mlOCPR
        UIu5qDgRAGlsocAAAwAA
X-CMS-MailID: 20210312070408epcas1p356f1421f0af1d29d3ca7abd37f73bd4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210311121850epcas1p493c255a586998916febfebaf994bc5dc
References: <CGME20210311121850epcas1p493c255a586998916febfebaf994bc5dc@epcas1p4.samsung.com>
        <1615464651-23675-1-git-send-email-jhs2.lee@samsung.com>
        <1615464651-23675-2-git-send-email-jhs2.lee@samsung.com>
        <CABCJKucMyQbtt-LACCRSk6bxAqmS05eVhv-5ou3_XZ1Nz+XYug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dear Sami Tolvanen.
Thank you for reply.

> I agree that we shouldn't allow this, at least not without a warning, but
> out of curiosity, do you actually have a situation where this could happe=
n?
> One ideally shouldn't be passing untrusted parameters to dm-verity.

Of course, I don't think this will happen because they are dm-verity expert=
s.
But since we are humans, I think this case could happen accidentally.
So it would be a good at preventing these cases.

> I don't have a strong opinion about this, but the documentation doesn't
> talk about verity modes, so perhaps this could be reworded to something
> like =22Conflicting error handling parameters=22?

Yes of course. That looks better.

I also had some ambiguous about how to express it.=20
This is because I couldn't find it in document.=20
The code says verity mode, so I wrote it down. never mind it :)=20

like this)
    case DM_VERITY_MODE_LOGGING:
    case DM_VERITY_MODE_RESTART:
    case DM_VERITY_MODE_PANIC:


> On Thu, Mar 11, 2021 at 4:19 AM JeongHyeon Lee <jhs2.lee=40samsung.com>
> wrote:
> >
> > If there are multiple verity mode when parsing the verity mode of dm
> > verity table, it will be set as the last one.
> > So set to 'allow only once' to prevent it.
>=20
> I agree that we shouldn't allow this, at least not without a warning, but
> out of curiosity, do you actually have a situation where this could happe=
n?
> One ideally shouldn't be passing untrusted parameters to dm-verity.
>=20
> >
> > Signed-off-by: JeongHyeon Lee <jhs2.lee=40samsung.com>
> > ---
> >  drivers/md/dm-verity-target.c =7C 38
> > ++++++++++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c
> > b/drivers/md/dm-verity-target.c index 808a98ef624c..b76431dc7721
> > 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > =40=40 -893,6 +893,28 =40=40 static int verity_alloc_zero_digest(struct
> dm_verity *v)
> >         return r;
> >  =7D
> >
> > +static inline bool verity_is_verity_mode(const char *arg_name) =7B
> > +       return (=21strcasecmp(arg_name, DM_VERITY_OPT_LOGGING) =7C=7C
> > +               =21strcasecmp(arg_name, DM_VERITY_OPT_RESTART) =7C=7C
> > +               =21strcasecmp(arg_name, DM_VERITY_OPT_PANIC)); =7D
> > +
> > +static int verity_parse_verity_mode(struct dm_verity *v, const char
> > +*arg_name) =7B
> > +       if (v->mode)
> > +               return -EINVAL;
> > +
> > +       if (=21strcasecmp(arg_name, DM_VERITY_OPT_LOGGING))
> > +               v->mode =3D DM_VERITY_MODE_LOGGING;
> > +       else if (=21strcasecmp(arg_name, DM_VERITY_OPT_RESTART))
> > +               v->mode =3D DM_VERITY_MODE_RESTART;
> > +       else if (=21strcasecmp(arg_name, DM_VERITY_OPT_PANIC))
> > +               v->mode =3D DM_VERITY_MODE_PANIC;
> > +
> > +       return 0;
> > +=7D
> > +
> >  static int verity_parse_opt_args(struct dm_arg_set *as, struct
> dm_verity *v,
> >                                  struct dm_verity_sig_opts
> > *verify_args)  =7B =40=40 -916,16 +938,12 =40=40 static int
> > verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
> >                 arg_name =3D dm_shift_arg(as);
> >                 argc--;
> >
> > -               if (=21strcasecmp(arg_name, DM_VERITY_OPT_LOGGING)) =7B
> > -                       v->mode =3D DM_VERITY_MODE_LOGGING;
> > -                       continue;
> > -
> > -               =7D else if (=21strcasecmp(arg_name, DM_VERITY_OPT_REST=
ART)) =7B
> > -                       v->mode =3D DM_VERITY_MODE_RESTART;
> > -                       continue;
> > -
> > -               =7D else if (=21strcasecmp(arg_name, DM_VERITY_OPT_PANI=
C)) =7B
> > -                       v->mode =3D DM_VERITY_MODE_PANIC;
> > +               if (verity_is_verity_mode(arg_name)) =7B
> > +                       r =3D verity_parse_verity_mode(v, arg_name);
> > +                       if (r) =7B
> > +                               ti->error =3D =22Already verity mode se=
t=22;
>=20
> I don't have a strong opinion about this, but the documentation doesn't
> talk about verity modes, so perhaps this could be reworded to something
> like =22Conflicting error handling parameters=22?
>=20
> > +                               return r;
> > +                       =7D
> >                         continue;
> >
> >                 =7D else if (=21strcasecmp(arg_name,
> > DM_VERITY_OPT_IGN_ZEROES)) =7B
> > --
> > 2.17.1
> >
>=20
> Sami

