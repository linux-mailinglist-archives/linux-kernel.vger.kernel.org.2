Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDD35EF13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbhDNIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:07:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbhDNIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:07:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E8415x176629;
        Wed, 14 Apr 2021 08:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bSsrfjgQwvGH9LRP3ufLbwMJ3Pr7WpPks4YzKmeR7Gk=;
 b=dmtBzD9YdhhIwrUVyaHX2wTMlm1eWiWTOxMv+sXh/FdkxpFvYgrRu6P6P9tTxUFdDOsy
 G1E4SgU69gVUEYsk7+4zQDKVU2Urpf6wUBUzv1RRvkTJ5VplMG0ySb0t9XsEJlK5ZwK0
 /n/F7087IRwjTDfJZgpx+3szufYX+Dyebsf4wurgoozYf1Zsp4KiCq37BJRa9qi6sPSm
 N2ZwRsydaeyyjE9sW/3iQEHNMXV68lR5lrvsYlWgOoSd/fhVlp7ygh/jUzlMKd+Pkg0t
 IE7DjQhGKEYLPQfDOZNOmoRo0XOKxv9kMZECM5XNVDfxvIFFMNUgylS12K5OjknczWdG 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37u3erhgwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:06:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E86PNd032576;
        Wed, 14 Apr 2021 08:06:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37unxy1q6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:06:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E86W19011816;
        Wed, 14 Apr 2021 08:06:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 01:06:32 -0700
Date:   Wed, 14 Apr 2021 11:06:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414080625.GS6021@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <2418632.vfNx7fMs9o@linux.local>
 <20210414070025.GB6048@kadam>
 <17405149.YoMEP5XZXy@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17405149.YoMEP5XZXy@linux.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140055
X-Proofpoint-ORIG-GUID: hREsJfVc6TNN2rL7WWcu1SczQqIOS1My
X-Proofpoint-GUID: hREsJfVc6TNN2rL7WWcu1SczQqIOS1My
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1031
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:59:36AM +0200, Fabio M. De Francesco wrote:
> Fine. I'm about to submit a patch.
> 
> Is there any formal means to acknowledge (in the patch) your contribution 
> to the resolution of this problem?

It doesn't matter.  Suggested-by.

regards,
dan carpenter

