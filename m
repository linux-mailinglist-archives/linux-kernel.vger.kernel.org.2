Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA239D9ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFGKpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:45:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:45:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157Af4xP013200;
        Mon, 7 Jun 2021 10:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4BySCnWuo2+hBh1Kf5OWJjhQ7R1JkUgp9tMIzaJrMgk=;
 b=KjyQjqXg9EVzWPBgobqAP2wEVsZnCQD1DIfs0hrqpa4I11i45ER+unMsaVYL/txt98uM
 TRF+R6qlEKNskd7Ck5KzVtMf8az2/mvIZdxVKOWzliH7leOgOFqN9bL6pFqifOYYpR39
 yIoGt2cfDH2qfHQYMHyxKu7nF3rh1LAIGveUrmSs6IVgfKZy8YNIevbz2tFR80Ks365L
 Sn+Qlx9lqalsVfBOlORCwmNe2vTldiuuaidTODWUYz+cIzqthHD/Nt212JXjGFABVkCi
 zOAvyM0oi6RJBHiciw0fU9V0YhQLUG7M10pMsGJHbV4S8c0ZOGLkGMQpB8DfzElr4Y5F jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3914quh3xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:43:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157AfoIR033590;
        Mon, 7 Jun 2021 10:43:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3906spcf4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:43:47 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 157AhkA7068010;
        Mon, 7 Jun 2021 10:43:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3906spcf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:43:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 157AhiXV001715;
        Mon, 7 Jun 2021 10:43:45 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 03:43:44 -0700
Date:   Mon, 7 Jun 2021 13:43:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wenli Looi <wlooi@ucalgary.ca>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <20210607104338.GS1955@kadam>
References: <20210606070021.116284-1-wlooi@ucalgary.ca>
 <20210607083316.GO1955@kadam>
 <YL3lih8OqGOLjVBf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3lih8OqGOLjVBf@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: MBkrJHtGGsCNe1LSbjgthg_VyBqll-n7
X-Proofpoint-GUID: MBkrJHtGGsCNe1LSbjgthg_VyBqll-n7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:23:22AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 07, 2021 at 11:33:17AM +0300, Dan Carpenter wrote:
> > Greg asked about struct holes and the answer is "= {}" will zero out
> > struct holes but it's not important in this case.  The "= {}" is a GCC
> > extension for zeroing structs and it's not part of the C standard.
> > The struct has a kernel pointer in it so we had better not be shairing
> > it to user space.
> 
> I thought we proved that "= {}" will _NOT_ zero out holes in structures.
> Or did we really prove that?  I can't remember now, do you?
> 

Assigning a struct to a struct will not initialize the struct holes.

	struct foo foo = *p;

We worried about = {} and people looked at the C standard.  The
standard is not clear.  But then people said that = {} is a GCC
extension and will initialize the struct holes.

The other thing is that in GCC they had intended "= {0};" to work
exactly the same as "= {};" and initialize the holes but there was a
version which had a bug and didn't.  :P

regards,
dan carpenter
