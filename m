Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18031399C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhBHQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:38:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhBHPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:14:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118FAGfS068010;
        Mon, 8 Feb 2021 15:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KE1pI9BEiEgOw43MBeIIDsP1Cww7nN8D0TMKS6ehj+U=;
 b=UCh1xYJc8yPlKJv3X9oa+uiGIOTmY4+cZ3bM4z1267kSAI46qHwDFrs7m/zjb0XM6EPY
 RPVJ+vpWjsT+wBiviD/5U1pKFNOx/MZSoC3xyhGQbPV0Uq1M1w4q93UTRv3jzKSQM0Xt
 ethkodgTbhm305INtJCzsGC4Or0tcFAUzf9KZZj8SENFYZKLRcR1BWMz5pyKXSmxfVCP
 +0vItIUReHvAbu7w5gnuHyXlmbYSoBFpuNn2lEJW/QVonnPKQWy+MMiEV3L7x9vuDSfl
 pE3arqKLn8zjSF9UUyX1y57dhQ1e7vZ7gyyuc0KD8hGBKzR8zAKvakX2urUpA44UYikR uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmacamp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:12:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118F9tnO153309;
        Mon, 8 Feb 2021 15:12:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36j4pmeje9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:12:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 118FCThL028875;
        Mon, 8 Feb 2021 15:12:29 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 07:12:29 -0800
Subject: Re: [Jfs-discussion] [PATCH v2] jfs: turn diLog(), dataLog() and
 txLog() into void functions
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1612686770-26163-1-git-send-email-yang.lee@linux.alibaba.com>
 <d8c873e6-d6f5-22b2-43ac-207fb7a1fd07@oracle.com>
Message-ID: <bc8a4bd6-110d-2ccf-709a-f230f018eca2@oracle.com>
Date:   Mon, 8 Feb 2021 09:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d8c873e6-d6f5-22b2-43ac-207fb7a1fd07@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080104
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized I mangled some whitespace trying to mail this through
Thunderbird. I'll repost it the right way.

Shaggy

On 2/8/21 9:05 AM, Dave Kleikamp wrote:
> On 2/7/21 2:32 AM, Yang Li wrote:
>> These functions always return '0' and no callers use the return value.
>> So make it a void function.
>>
>> This eliminates the following coccicheck warning:
>> ./fs/jfs/jfs_txnmgr.c:1365:5-7: Unneeded variable: "rc". Return "0" on
>> line 1414
>> ./fs/jfs/jfs_txnmgr.c:1422:5-7: Unneeded variable: "rc". Return "0" on
>> line 1527
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>
>> Changes in v2
>> -turn functions forward references to void type.
>>
>>   fs/jfs/jfs_txnmgr.c | 32 +++++++++++++++-----------------
>>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> This patch missed fixing a call to txLog() which did check the return 
> value. I took the liberty of fixing it here.
> 
> 
> jfs: turn diLog(), dataLog() and txLog() into void functions
> 
> These functions always return '0' and no callers use the return value.
> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./fs/jfs/jfs_txnmgr.c:1365:5-7: Unneeded variable: "rc". Return "0" on
> line 1414
> ./fs/jfs/jfs_txnmgr.c:1422:5-7: Unneeded variable: "rc". Return "0" on
> line 1527
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   fs/jfs/jfs_txnmgr.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index dca8edd2378c..053295cd7bc6 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -148,10 +148,10 @@ static struct {
>   /*
>    * forward references
>    */
> -static int diLog(struct jfs_log * log, struct tblock * tblk, struct lrd 
> * lrd,
> -        struct tlock * tlck, struct commit * cd);
> -static int dataLog(struct jfs_log * log, struct tblock * tblk, struct 
> lrd * lrd,
> -        struct tlock * tlck);
> +static void diLog(struct jfs_log *log, struct tblock *tblk, struct lrd 
> *lrd,
> +        struct tlock *tlck, struct commit *cd);
> +static void dataLog(struct jfs_log *log, struct tblock *tblk, struct 
> lrd *lrd,
> +        struct tlock *tlck);
>   static void dtLog(struct jfs_log * log, struct tblock * tblk, struct 
> lrd * lrd,
>           struct tlock * tlck);
>   static void mapLog(struct jfs_log * log, struct tblock * tblk, struct 
> lrd * lrd,
> @@ -159,8 +159,8 @@ static void mapLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>   static void txAllocPMap(struct inode *ip, struct maplock * maplock,
>           struct tblock * tblk);
>   static void txForce(struct tblock * tblk);
> -static int txLog(struct jfs_log * log, struct tblock * tblk,
> -        struct commit * cd);
> +static void txLog(struct jfs_log *log, struct tblock *tblk,
> +        struct commit *cd);
>   static void txUpdateMap(struct tblock * tblk);
>   static void txRelease(struct tblock * tblk);
>   static void xtLog(struct jfs_log * log, struct tblock * tblk, struct 
> lrd * lrd,
> @@ -1256,8 +1256,7 @@ int txCommit(tid_t tid,        /* transaction 
> identifier */
>        *
>        * txUpdateMap() resets XAD_NEW in XAD.
>        */
> -    if ((rc = txLog(log, tblk, &cd)))
> -        goto TheEnd;
> +    txLog(log, tblk, &cd);
>        /*
>        * Ensure that inode isn't reused before
> @@ -1365,9 +1364,8 @@ int txCommit(tid_t tid,        /* transaction 
> identifier */
>    *
>    * RETURN :
>    */
> -static int txLog(struct jfs_log * log, struct tblock * tblk, struct 
> commit * cd)
> +static void txLog(struct jfs_log *log, struct tblock *tblk, struct 
> commit *cd)
>   {
> -    int rc = 0;
>       struct inode *ip;
>       lid_t lid;
>       struct tlock *tlck;
> @@ -1414,7 +1412,7 @@ static int txLog(struct jfs_log * log, struct 
> tblock * tblk, struct commit * cd)
>           }
>       }
>   -    return rc;
> +    return;
>   }
>    /*
> @@ -1422,10 +1420,9 @@ static int txLog(struct jfs_log * log, struct 
> tblock * tblk, struct commit * cd)
>    *
>    * function:    log inode tlock and format maplock to update bmap;
>    */
> -static int diLog(struct jfs_log * log, struct tblock * tblk, struct lrd 
> * lrd,
> -         struct tlock * tlck, struct commit * cd)
> +static void diLog(struct jfs_log *log, struct tblock *tblk, struct lrd 
> *lrd,
> +         struct tlock *tlck, struct commit *cd)
>   {
> -    int rc = 0;
>       struct metapage *mp;
>       pxd_t *pxd;
>       struct pxd_lock *pxdlock;
> @@ -1527,7 +1524,7 @@ static int diLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>       }
>   #endif                /* _JFS_WIP */
>   -    return rc;
> +    return;
>   }
>    /*
> @@ -1535,8 +1532,8 @@ static int diLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>    *
>    * function:    log data tlock
>    */
> -static int dataLog(struct jfs_log * log, struct tblock * tblk, struct 
> lrd * lrd,
> -        struct tlock * tlck)
> +static void dataLog(struct jfs_log *log, struct tblock *tblk, struct 
> lrd *lrd,
> +        struct tlock *tlck)
>   {
>       struct metapage *mp;
>       pxd_t *pxd;
> @@ -1562,7 +1559,7 @@ static int dataLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>           metapage_homeok(mp);
>           discard_metapage(mp);
>           tlck->mp = NULL;
> -        return 0;
> +        return;
>       }
>        PXDaddress(pxd, mp->index);
> @@ -1573,7 +1570,7 @@ static int dataLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>       /* mark page as homeward bound */
>       tlck->flag |= tlckWRITEPAGE;
>   -    return 0;
> +    return;
>   }
>    /*
