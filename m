Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD357391B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhEZPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:08:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51720 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhEZPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:08:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QF4f8R196347;
        Wed, 26 May 2021 15:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kcmcvYW9XkOf1yk6LbbGV2gpXFhvsHtXFg9gLmTj2ag=;
 b=ZRq2e0+PKhoP0bEVaz4PH+ubw3oHFZAcW8PDr9UtH4JX+961XTSq1/NHgq/o1HU/JOYu
 SOHlY8Z7oj6m8yEtOCJP5wxrlH34yqdUjxP+QE97DSxA6aFtWfrnk1HjYwKl4dHvYaXi
 xCgKDQ4zMXscs6keQFyiSOh/N5bnGkYRI5BdMXmwKNcCK+JwCvG2MpstSNsjMaXjweCp
 vmKDwllMkUW4ONMuCgJfIgJlIQkDb2oYcAcZ3j+U5RcM2J17zCqq3yIZ6dQGTiZ7Rg/i
 jCTeUdhe0KBR8a3M39OhFR5IaoSyeMLeJ3q8PrsiNNx8PszytBCxYdfEy3VCkHl64Qob Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38pqfchh1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 15:06:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QF13ut186017;
        Wed, 26 May 2021 15:06:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38rehdb9cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 15:06:44 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14QF25sA195849;
        Wed, 26 May 2021 15:05:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 38rehdass5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 15:05:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14QF1hAD004468;
        Wed, 26 May 2021 15:01:43 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 May 2021 08:01:42 -0700
Date:   Wed, 26 May 2021 18:01:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>,
        cluster-devel@redhat.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
Message-ID: <20210526150133.GQ1955@kadam>
References: <20210526134039.3448305-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526134039.3448305-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 5CLh-ECD08lLS6id9XUgHywJZSufP6Bg
X-Proofpoint-GUID: 5CLh-ECD08lLS6id9XUgHywJZSufP6Bg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:40:39PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an error return path that is not kfree'ing mh after
> it has been successfully allocates.  Fix this by free'ing it.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: a070a91cf140 ("fs: dlm: add more midcomms hooks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/dlm/rcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
> index 085f21966c72..19298edc1573 100644
> --- a/fs/dlm/rcom.c
> +++ b/fs/dlm/rcom.c
> @@ -393,6 +393,7 @@ static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
>  	if (rc_in->rc_id == 0xFFFFFFFF) {
>  		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
>  		dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
> +		kfree(mh);

Am I looking at the same code as you?  (I often am not able to review
your patches because you're doing development on stuff that hasn't hit
linux-next).  Anyway, to me this doesn't seem like the correct fix at
all.  There are some other things to free and the "mh" pointer is on
a bunch of lists so it leads to use after frees.

regards,
dan carpenter

