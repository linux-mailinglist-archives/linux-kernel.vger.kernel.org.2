Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2233AA13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCODjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:39:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39898 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCODjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:39:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210315033919epoutp0180bc03032176877ab1cda299a09332fe~sZvLQ6PY21443714437epoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210315033919epoutp0180bc03032176877ab1cda299a09332fe~sZvLQ6PY21443714437epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615779559;
        bh=zCyivUJ6qSOhcj91qWtfJzDp30ap+JZ5ZwqO/3zCdYA=;
        h=Date:From:To:Cc:Subject:References:From;
        b=C+uwLGv6CKF3YASSi4O74l8yKin6L+CGOUThs6GrPMmWABip14SXmNwgCimRPIMpK
         GiEJzpVarp8+RCkE79XA7i+6YWaHfcSpjB4iJBhk9rxu6PPm+KYXo0+dlhihbnkisI
         /Y8eAH2uBTixUNFPxcNiDu9DLhnKyGddS6Sd/sgw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210315033919epcas1p4a2015de13a4d1ec33c9e48ed8a626e70~sZvLFDfnB1168711687epcas1p48;
        Mon, 15 Mar 2021 03:39:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DzMbp1grlz4x9QJ; Mon, 15 Mar
        2021 03:39:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.6F.02418.6E6DE406; Mon, 15 Mar 2021 12:39:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210315033917epcas1p39ee45fb36b097aae1fb4cac32464e8dc~sZvJsakAi0336603366epcas1p32;
        Mon, 15 Mar 2021 03:39:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210315033917epsmtrp175811e8eeb0f7d06bc617eb9b14969c5~sZvJrxqn21319713197epsmtrp1B;
        Mon, 15 Mar 2021 03:39:17 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-4a-604ed6e66b11
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.C0.08745.5E6DE406; Mon, 15 Mar 2021 12:39:17 +0900 (KST)
Received: from jjungs-linux (unknown [10.253.101.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210315033917epsmtip115028f0ce1f6615e595f32b01a9540cd~sZvJfIEPT0180001800epsmtip1d;
        Mon, 15 Mar 2021 03:39:17 +0000 (GMT)
Date:   Mon, 15 Mar 2021 12:33:42 +0900
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     samitolvanen@google.com
Cc:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2/2] dm verity: allow only one verify mode
Message-ID: <20210315033342.GB13408@jjungs-linux>
MIME-Version: 1.0
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmru6za34JBv9nclqsP3WM2WLvu9ms
        Fpd3zWGzWLriLatF28avjA6sHgs2lXq833eVzePzJrkA5qgcm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygjUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
        /OISW6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyM3t6DTAUT1SruTl7D2MB4VrqL
        kZNDQsBE4tqc5+xdjFwcQgI7GCXuPV3IBOF8YpS4e3U9O0iVkMBnRonH27NhOh5cnccKEd/F
        KHHroxhEw2tGidbnG9hAEiwCqhKTn+xiBLHZBLQlbrdsAhskIiAtcWnWDCYQm1kgWmLb5mNA
        NgeHsICdxIIv6SBhXgFDiU+LWhghbEGJkzOfsICUiAqoSLw6WA+ySkJgH7vEkv6LjCBxCQEX
        iTmbCyBOE5Z4dXwLO4QtJfGyv40dor6bUeL++ddsEIkJjBK9PUwQvfYS7y9ZQFyTKfFv6wyo
        XkWJnb/nMkLE+STefe1hhSjnlehoE4IoUZJY8e8aC4QtIbHhcDfUdA+JhvM3oaEWK3Hpxm2m
        CYxys5A8MwvJNghbR2LB7k9ss4A2MAPDZ/k/DghTU2L9Lv0FjKyrGMVSC4pz01OLDQsMkSN3
        EyM49WmZ7mCc+PaD3iFGJg7GQ4wSHMxKIryfdXwThHhTEiurUovy44tKc1KLDzGaAiNmIrOU
        aHI+MPnmlcQbmhoZGxtbmJiZm5kaK4nzJhk8iBcSSE8sSc1OTS1ILYLpY+LglGpgMm//bBgZ
        vbPhwYYp/gmlm5ruaxpea1r9lE/5NlOY8DXBLQf7uQoED3JwW3sc3PH6WreLb072x7sliesa
        mPR2Zha6xHj8iXxnEjlPU+jk9htVDV/VDIMTyhad2SY6ac78oCXrDizYHWXUwnrq1p4XD4LE
        mENVHmftbTa5udj4n153nN/BBxalngtmPxZn3pBdvnV1+hEjj7u5C0IDs6UZpW19Nljuu/Bm
        lcCK9q5bH4r1S238Crg/pG7+cUOauaiszzQvcp/OqdQ/P+J7Xs56YfZUoIl9m8Nd0aUmLkuL
        vf7zmc2+u/NhKiNv4tqdV5TN5C74nwv+KnnRruLPmTtPD9soOCqx3BGS0ds5+bi/EktxRqKh
        FnNRcSIA/jlfjQYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnO7Ta34JBmeeKlmsP3WM2WLvu9ms
        Fpd3zWGzWLriLatF28avjA6sHgs2lXq833eVzePzJrkA5igum5TUnMyy1CJ9uwSujJXtL9kK
        zilXbHpo1sC4WLKLkZNDQsBE4sHVeaxdjFwcQgI7GCVufrrFDpGQkNiwaS2QzQFkC0scPlwM
        UfOSUeL+6RWsIDUsAqoSk5/sYgSx2QS0JW63bALrFRGQlrg0awYTiM0sEC2xbfMxJpA5wgJ2
        Egu+pIOEeQUMJT4tamGEsAUlTs58wgJRriVx499LsHJmoDHL/3GAmKICKhKvDtZPYOSfhaRh
        FpKGWQgNCxiZVzFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAeoltYOxj2rPugdYmTi
        YDzEKMHBrCTC+1nHN0GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGJldWn7zs7xFM/R69vhfue7wuCj5vVfCyZwKz5W/3coZCk8KN4onXot7tNf9wZWfw
        i8lcFuwfFzw2bC7tya/MvvZv3/HatMe6274uU96u9H7zrgt77p2dJv5PcU/o053cezh49xzL
        vHZP5LXS0fP2T+xcHgbxy55QbShY+eeensHkWSUqKy7zLNSMjKrM/CUsfkxmnbvYvXmiCayB
        x1he7WiuNBec/ibKtnKKxtNpj9+lVCVlbQibNrHrqUjOuYTt0YzLROu0bQXPyb/03p5tt0zw
        7+UCzr0Kcx90e8858rLZS6HD+8xmtUoXdptqSUudgwxcefPfyUTNnHlm5oOWst9rz3ww3qid
        tdA7S3jfMSWW4oxEQy3mouJEACN+hRy/AgAA
X-CMS-MailID: 20210315033917epcas1p39ee45fb36b097aae1fb4cac32464e8dc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----V1oBYrHh8kVlH0vl1DhTBnbYZqliemR8pfKkIoDTIwboyIJz=_300463_"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315033917epcas1p39ee45fb36b097aae1fb4cac32464e8dc
References: <CGME20210315033917epcas1p39ee45fb36b097aae1fb4cac32464e8dc@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------V1oBYrHh8kVlH0vl1DhTBnbYZqliemR8pfKkIoDTIwboyIJz=_300463_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello, Dear Sami Tolvanen.
Thank you for reply. Sorry, I send it again because my setting is wrong.

> I agree that we shouldn't allow this, at least not without a warning, but
> out of curiosity, do you actually have a situation where this could happen?
> One ideally shouldn't be passing untrusted parameters to dm-verity.

Of course, I don't think this will happen because they are dm-verity experts.
But since we are humans, I think this case could happen accidentally.
So it would be a good at preventing these cases.

> I don't have a strong opinion about this, but the documentation doesn't
> talk about verity modes, so perhaps this could be reworded to something
> like "Conflicting error handling parameters"?

Yes of course. That looks better.

I also had some ambiguous about how to express it. 
This is because I couldn't find it in document. 
The code says verity mode, so I wrote it down. never mind it :) 

like this)
    case DM_VERITY_MODE_LOGGING:
    case DM_VERITY_MODE_RESTART:
    case DM_VERITY_MODE_PANIC:

Thank you,
JeongHyeon Lee.

> On Thu, Mar 11, 2021 at 4:19 AM JeongHyeon Lee <jhs2.lee@samsung.com>
> wrote:
> >
> > If there are multiple verity mode when parsing the verity mode of dm
> > verity table, it will be set as the last one.
> > So set to 'allow only once' to prevent it.
> 
> I agree that we shouldn't allow this, at least not without a warning, but
> out of curiosity, do you actually have a situation where this could happen?
> One ideally shouldn't be passing untrusted parameters to dm-verity.
> 
> >
> > Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
> > ---
> >  drivers/md/dm-verity-target.c | 38
> > ++++++++++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c
> > b/drivers/md/dm-verity-target.c index 808a98ef624c..b76431dc7721
> > 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -893,6 +893,28 @@ static int verity_alloc_zero_digest(struct
> dm_verity *v)
> >         return r;
> >  }
> >
> > +static inline bool verity_is_verity_mode(const char *arg_name) {
> > +       return (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING) ||
> > +               !strcasecmp(arg_name, DM_VERITY_OPT_RESTART) ||
> > +               !strcasecmp(arg_name, DM_VERITY_OPT_PANIC)); }
> > +
> > +static int verity_parse_verity_mode(struct dm_verity *v, const char
> > +*arg_name) {
> > +       if (v->mode)
> > +               return -EINVAL;
> > +
> > +       if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING))
> > +               v->mode = DM_VERITY_MODE_LOGGING;
> > +       else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART))
> > +               v->mode = DM_VERITY_MODE_RESTART;
> > +       else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC))
> > +               v->mode = DM_VERITY_MODE_PANIC;
> > +
> > +       return 0;
> > +}
> > +
> >  static int verity_parse_opt_args(struct dm_arg_set *as, struct
> dm_verity *v,
> >                                  struct dm_verity_sig_opts
> > *verify_args)  { @@ -916,16 +938,12 @@ static int
> > verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
> >                 arg_name = dm_shift_arg(as);
> >                 argc--;
> >
> > -               if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING)) {
> > -                       v->mode = DM_VERITY_MODE_LOGGING;
> > -                       continue;
> > -
> > -               } else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART)) {
> > -                       v->mode = DM_VERITY_MODE_RESTART;
> > -                       continue;
> > -
> > -               } else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC)) {
> > -                       v->mode = DM_VERITY_MODE_PANIC;
> > +               if (verity_is_verity_mode(arg_name)) {
> > +                       r = verity_parse_verity_mode(v, arg_name);
> > +                       if (r) {
> > +                               ti->error = "Already verity mode set";
> 
> I don't have a strong opinion about this, but the documentation doesn't
> talk about verity modes, so perhaps this could be reworded to something
> like "Conflicting error handling parameters"?
> 
> > +                               return r;
> > +                       }
> >                         continue;
> >
> >                 } else if (!strcasecmp(arg_name,
> > DM_VERITY_OPT_IGN_ZEROES)) {
> > --
> > 2.17.1
> >
> 
> Sami


------V1oBYrHh8kVlH0vl1DhTBnbYZqliemR8pfKkIoDTIwboyIJz=_300463_
Content-Type: text/plain; charset="utf-8"


------V1oBYrHh8kVlH0vl1DhTBnbYZqliemR8pfKkIoDTIwboyIJz=_300463_--
