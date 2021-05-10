Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2C378E19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhEJNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:05:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350830AbhEJNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:01:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ACsh09034235;
        Mon, 10 May 2021 13:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=a9CihIi8AdI96/7vWdMS2rzd/zuQLU957/TQUQ4NOtY=;
 b=cnhihZSIOe/YzvkZZ0qpRbDVVQChdj6d3Z6l12fF1A3QlRV0n0ve0cAbFDd7vdoxXSgW
 GIORNtz5PhRqv2CKy8wh6mmCycVBJCJxQLS9BRTQWaHJ3Fda2RQr+iwPFpVMpglyGAQ4
 wzB13a+bj+tYnqq0l0+7q1RV5K8dBhY2Cr0PhFlY0haxioBEnp3ip20wjI9ZN5pMxs+c
 fRKB+ue0oVsS3dtFfNuASrSjR+e04FhirM7l41ckjRzjYYWP4nLKUk971VbHWHxzW6Nj
 NlNI4PDwZKY9maWSGftnfYT+2VAH/1VlrAsrAITSAenlOdpvparjp0jmYybTh8Pl8Lbw yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9nb33y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 13:00:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ACxuUF001293;
        Mon, 10 May 2021 13:00:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38e4ds7bsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 13:00:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14AD0TwW005285;
        Mon, 10 May 2021 13:00:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38e4ds7bsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 13:00:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14AD0Qxw020397;
        Mon, 10 May 2021 13:00:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 May 2021 13:00:26 +0000
Date:   Mon, 10 May 2021 16:00:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8723bs: move comments to silence 'line
 too long' warning
Message-ID: <20210510130019.GT1955@kadam>
References: <cover.1620650484.git.fabioaiuto83@gmail.com>
 <cdb37302e4d7618141997229c59467f9d196eccc.1620650484.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb37302e4d7618141997229c59467f9d196eccc.1620650484.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: k2Vmmon6O__BCIj4Xs-Zi7PFm7pi_j4F
X-Proofpoint-GUID: k2Vmmon6O__BCIj4Xs-Zi7PFm7pi_j4F
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 02:46:19PM +0200, Fabio Aiuto wrote:
> move comments to fix the following post commit hook
> checkpatch warnings:
> 
> WARNING: line length of 110 exceeds 100 columns
> 115: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:510:
> +					*((__le32 *)crc)
>  = ~crc32_le(~0, payload, length);/* modified by Amy*/

Please delete the Amy comments.  :P

regards,
dan carpenter

