Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3534E4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhC3JyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:54:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46588 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhC3Jxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:53:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U9oKnc124224;
        Tue, 30 Mar 2021 09:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=f3NOUVfYBZDqDaLq+La4z5a2EVZxT7FKK+poLKDJXxY=;
 b=zbUliJSSsjrxqIQelqnAhb1+/AVsN5cX1Ws71j+bctGpgyluUkQ8TcEv8U/vIoUWl6vu
 C3fqSetZ8Ui7KiqpuuPW9Utxxy9nU0IQdKNFcU9vVtW15lyIL55BqybUfZHEWEgT2DuJ
 rGTZI84uDHMDnPXQ/ZrPXrDZsEnpizHEuJ57EyDL/sWTyd5K6qcbFoGon/DzvVlnWveX
 T5CoxJ/8jdUihjPoYWEgSOwKSddCsn/sH1oORLvoDBWEcu3CttOfF9pJ7QRib5PDpIJi
 gWuwSwHpw5zAsP/acNoyt4ALOi+u7/hqoScqK8mldPt1YfUvgdwYehGdzjVk+KbOlu8f kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37ht7bendv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 09:53:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U9pTXc038744;
        Tue, 30 Mar 2021 09:53:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37jemwwdym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 09:53:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12U9r5bS020620;
        Tue, 30 Mar 2021 09:53:05 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Mar 2021 02:53:05 -0700
Date:   Tue, 30 Mar 2021 12:52:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210330095254.GA2065@kadam>
References: <20210329170730.121943-1-colin.king@canonical.com>
 <20210329171434.GH351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329171434.GH351017@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300068
X-Proofpoint-GUID: 6mRciYx8kZjzCfYZSzmqAM4lLbWrv9Gu
X-Proofpoint-ORIG-GUID: 6mRciYx8kZjzCfYZSzmqAM4lLbWrv9Gu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:14:34PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the memory pointed to by area is being freed by the
> > free_vm_area call and then area->nr_pages is referencing the
> > free'd object. Fix this swapping the order of the warn_alloc
> > message and the free.
> > 
> > Addresses-Coverity: ("Read from pointer after free")
> > Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
> 
> i don't have this git sha.  if this is -next, the sha ids aren't stable
> and shouldn't be referenced in commit logs, because these fixes should
> just be squashed into the not-yet-upstream commits.

The fixes tag won't "be referenced in the commit logs" because Andew
is going to fold it in.  And the "mm/vmalloc: improve allocation failure
error messages" information is useful.

More generally there are a bunch trees which rebase often but it's
humanly impossible to remember which ones they are and there is no
automated way to track it either.  If the maintainer is going to rebase
then they're going to have to think about Fixes tags a bit.  Normally
rebased trees fold fixes so it's not an issue.  Otherwise it would be
easy to write a script to correct the Fixes tags during a rebase.

In other words, my view is that everyone should just use the same Fixes
tag format everywhere.

regards,
dan carpenter

