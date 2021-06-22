Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E8C3AFD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFVGrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:47:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22472 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhFVGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:47:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M6gNOH011901;
        Tue, 22 Jun 2021 06:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=QfXXLmm0iGyiQYiHgMzRvZ8iyquEj7HAHDtJoxfX+fE=;
 b=J6L4Iv1KmxQMwPC3uMT6OeDHcgkCHWMp6PxSm+l2u774Oj0DE86KWaYyQ9n2PZnBBKqr
 t/1TRwjjsYicuqxUiASMSO0pLyTWHrHy3W5z7Qy8OHZBqPvPAa/u5QXlBVpyqEIo4+o5
 iT3TxANspLHR6HhwPq5sqZfGQBIOj4SaZBLaBWCBBAINaGRl1yWuV6ibDCWl+sX+/PQb
 uadq4A8gxzpH0mQWOfX5jb8iLXzOT2Be2rvhuSpN5ZupEW9RYtT3mUskW8B197QhYN5u
 /fIyJpwknmttwdOi9kM7TVOC/syJ2xF7I6JST0u7cNUJ+9ARCWpjWWb3s1S29NGXMJ34 PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyqb2b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 06:44:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M6fBFq158054;
        Tue, 22 Jun 2021 06:44:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3995pvqve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 06:44:29 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15M6iSkF171196;
        Tue, 22 Jun 2021 06:44:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3995pvqvd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 06:44:28 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15M6iQn5019890;
        Tue, 22 Jun 2021 06:44:27 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 23:44:26 -0700
Date:   Tue, 22 Jun 2021 09:44:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: Remove a redundant null check on pointer lp
Message-ID: <20210622064419.GJ1901@kadam>
References: <20210621152249.20901-1-colin.king@canonical.com>
 <f2ea606a-4a05-8d14-4380-d96ca0f981a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2ea606a-4a05-8d14-4380-d96ca0f981a1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: RuCeNEEez0_8-eKl6Wh6Pcbbaac3s5p1
X-Proofpoint-ORIG-GUID: RuCeNEEez0_8-eKl6Wh6Pcbbaac3s5p1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:38:52AM +0800, Zhihao Cheng wrote:
> 在 2021/6/21 23:22, Colin King 写道:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > An earlier fix to replace an IS_ERR check on lp with a null check
> > on lp didn't remove a following null check on lp. The second null
> > check is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Logically dead code")
> > Fixes: c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   fs/ubifs/gc.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> > index 7cc22d7317ea..465beea52176 100644
> > --- a/fs/ubifs/gc.c
> > +++ b/fs/ubifs/gc.c
> > @@ -899,8 +899,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
> >   			err = -ENOMEM;
> >   			goto out;
> >   		}
> Hi Colin,
> I just found out about it today thanks to your patch. Commit c770cd5190ba
> ("ubifs: fix an IS_ERR() vs NULL check") did import a new problem that
> ubifs_gc_start_commit() may return -ENOMEM while syncing fs.
> I guess ubifs_fast_find_frdi_idx() return NULL pointer is the termination
> condition in while-loop, which means we cannot get a freeable index LEB in
> ubifs_gc_start_commit().

Ugh...  I'm so sorry.  My patch was clearly wrong.  I've tried before to
add a Smatch check which warns about duplicative NULL checks, but I
think this gives me a new idea to try.  Hopefully, it will prevent this
in the future.

Yeah, and it's my check which needs to be deleted, not the other one.

regards,
dan carpenter

