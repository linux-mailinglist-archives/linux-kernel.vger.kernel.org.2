Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC35387419
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347497AbhERIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbhERIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14I8T5e5030752;
        Tue, 18 May 2021 08:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mjm2389M6xU+/vps2nDbC/9gZkJjzYIN9Xv+5bntbZA=;
 b=PSeveHJW0vgvKGfYSyGkKZPWcuJ8Mx4L69mbeBP8MrNMhi6cdcXyjAc8TsojaYlJSkF3
 UJhiMMysyk1xTwb/hf6F0EHOcY9K0H6VZEH4m+fzchVpyahoSJV9XJ2AFbsmnNy35P/z
 CZvcXqrHk3Nn0uxoTFt7SAL8HnLqoujtaJmRjdYJlQsj7T6QLmhoe855/sSGTw4+mxrA
 rpQa4xyLzgC7CgajAryeEP4GfqP53RpNc/UTfl0Ek2A67TAQmmu2/U919Xl7fc92YB0Q
 dbWgpSYGDzurcXGuFjlXkcveQjD8lrDf3u2zWc3o50H/P78wmUF3GYZgLqb6b9WSwXbl kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38j6xndfd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 08:29:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14I8PrTn024766;
        Tue, 18 May 2021 08:29:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j647w740-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 08:29:04 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14I8RHSH037750;
        Tue, 18 May 2021 08:29:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 38j647w729-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 08:29:03 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14I8T220011971;
        Tue, 18 May 2021 08:29:02 GMT
Received: from kadam (/62.8.83.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 May 2021 01:29:01 -0700
Date:   Tue, 18 May 2021 11:28:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8188eu: use safe iterator in
 rtw_free_network_queue
Message-ID: <20210518082855.GB32682@kadam>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517155733.GK1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517155733.GK1955@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: UdcIccWTxjhHBZviQBZGOBBlLnO8prSb
X-Proofpoint-ORIG-GUID: UdcIccWTxjhHBZviQBZGOBBlLnO8prSb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 06:57:33PM +0300, Dan Carpenter wrote:
> Thanks for catching these...  I've created a new Smatch static checker
> warning for this but it only works for list_for_each_entry().
> Eventually someone would have run the coccinelle script to convert these
> list_for_each loops into list_for_each_entry().  Otherwise you have to
> parse container_of() and I've been meaning to do that for a while but I
> haven't yet.
> 
> Anyway, I'm going to test it out overnight and see what it finds.  It's
> sort a new use for the modification_hook(), before I had only ever used
> it to silence warnings but this check uses it to trigger warnings.  So
> perhaps it will generate a lot of false positives.  We'll see.
> 
> It sets the state of the iterator to &start at the start of the loop
> and if it's not &start state at the end then it prints a warning.
> 
> regards,
> dan carpenter
> 

That Smatch check didn't work at all.  :P  Back to the drawing board.

regards,
dan carpenter

