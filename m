Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878C6391EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhEZS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:26:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhEZS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:26:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QIDVuG009775;
        Wed, 26 May 2021 18:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CUhrj/EFyB/hyuXzgZKJrow9r5Ofii3hVO9psvF/C2M=;
 b=Bpld/KqEXziz9tZvRBerahKjEI0wfqNAyrx7Wmnbp4Ix0wNXIpDAkglg8vVJBmAkAA8+
 RudbkmKNo+HUcLx4rA0xY4I2jaondp/Apt9y8oHANN+q7OiGauc9PhGWSfjSLPK53NVK
 +oFbM54owzPsK2LPwlGazmBgyneUbPTPrAZ8Jl9bYqlCcKv5oFygIUEFvNI4jOdTs6+t
 qFkOIjVqieA3nrzlJTXjcCAYbrvjSGFGs0Ga57cHQbYub4LdqLxYAeWuTfStg83tY/ws
 KHTHy7+xOoQoZbMnq1RKOfntNvdjnlK+V84rac7kixW/AUGLPXhtAnC3Knit8q82KHVY 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38ptkp9yq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 18:24:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QIG7Ge062507;
        Wed, 26 May 2021 18:24:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38pr0cxpka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 18:24:30 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14QIOTdV078205;
        Wed, 26 May 2021 18:24:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38pr0cxpj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 18:24:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14QIOQeR016010;
        Wed, 26 May 2021 18:24:26 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 May 2021 18:24:25 +0000
Date:   Wed, 26 May 2021 21:24:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>,
        cluster-devel@redhat.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
Message-ID: <20210526181726.GJ24442@kadam>
References: <20210526134039.3448305-1-colin.king@canonical.com>
 <20210526150133.GQ1955@kadam>
 <c5ea0085-969a-339f-fd92-6724cb1d928e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ea0085-969a-339f-fd92-6724cb1d928e@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: UXNj3i3LJ95i3OKi1rjqUTzyWfrzcEKI
X-Proofpoint-ORIG-GUID: UXNj3i3LJ95i3OKi1rjqUTzyWfrzcEKI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 04:11:06PM +0100, Colin Ian King wrote:
> On 26/05/2021 16:01, Dan Carpenter wrote:
> > On Wed, May 26, 2021 at 02:40:39PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> There is an error return path that is not kfree'ing mh after
> >> it has been successfully allocates.  Fix this by free'ing it.
> >>
> >> Addresses-Coverity: ("Resource leak")
> >> Fixes: a070a91cf140 ("fs: dlm: add more midcomms hooks")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  fs/dlm/rcom.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
> >> index 085f21966c72..19298edc1573 100644
> >> --- a/fs/dlm/rcom.c
> >> +++ b/fs/dlm/rcom.c
> >> @@ -393,6 +393,7 @@ static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
> >>  	if (rc_in->rc_id == 0xFFFFFFFF) {
> >>  		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
> >>  		dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
> >> +		kfree(mh);
> > 
> > Am I looking at the same code as you?  (I often am not able to review
> > your patches because you're doing development on stuff that hasn't hit
> > linux-next).  Anyway, to me this doesn't seem like the correct fix at
> > all.  There are some other things to free and the "mh" pointer is on
> > a bunch of lists so it leads to use after frees.
      ^^^^^^^^^^^^^^
This is sort of impossible, of course, because the struct only has one
list_head so it can only be in one list and not a "bunch of lists".

The dlm code seems to be going out of its way to use void pointers and
that makes it difficult to parse with Smatch.

But in other subsystems, we could make it a rule that list_heads are
"poison" "init" or "added".  If you freed a memory with an "added"
list_head then print a warning.  Or if you added a list_head but it was
already in the added state then print a warning.  Another idea is that
if you freed a struct mh before the mh->page allocation was freed then
print a warning about the leak.  This one is probably more prone to
false positives but there might be workarounds for those.  #IdeasToImplement

regards,
dan carpenter
