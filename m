Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91567377C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEJGgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:36:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJGgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:36:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14A6OM8T186109;
        Mon, 10 May 2021 06:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VtGcUhRuwLqpoTI5vS+Z1II8imjiXpdn8n8IvXV8XVc=;
 b=POG9D6lqtSl2z3cG6bRq/t96HzzRc/lwIhxqR31mF5zdHdxTdiBXzUCxqii7qs97lQIk
 LuZDtuYGQsiao7zP7x3IYtoqcVBUIlrO5+l9y2IFqSAMOcZwEb5KCKwIVDZdMELqfGBt
 brQs+Eq0E9SOBwammQR2mIFXeZN/CyAxwohG6HokFQRVHIA12FxIStd0o5jaySENLAwU
 0cwEi3pDmMxfz7XP9s6G3i3rMMhbuFgq1yCL2ZFEupGarrom97r+4GvXe5nYxJKIgMkF
 AvUtBqobjg5Pz7Isyp5y8wUfjWhTXislN19hsbU09JEiKLvg9MqyZolFxWGkwC06CHy+ xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e28599bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:35:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14A6PveE104694;
        Mon, 10 May 2021 06:35:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38e4drmup1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:35:26 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14A6ZPYk131852;
        Mon, 10 May 2021 06:35:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38e4drmunr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:35:25 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14A6ZMx3003019;
        Mon, 10 May 2021 06:35:22 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 May 2021 23:35:22 -0700
Date:   Mon, 10 May 2021 09:35:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        akpm@linux-foundation.org, stefani@seibold.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tty: nozomi: Fix a resource leak in an error handling
 function
Message-ID: <20210510063513.GQ1955@kadam>
References: <4f0d2b3038e82f081d370ccb0cade3ad88463fe7.1620580838.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0d2b3038e82f081d370ccb0cade3ad88463fe7.1620580838.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: kchRdrmfwxTiWOYOBjO132BR3sfqjbM6
X-Proofpoint-ORIG-GUID: kchRdrmfwxTiWOYOBjO132BR3sfqjbM6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9979 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 07:22:33PM +0200, Christophe JAILLET wrote:
> A 'request_irq()' call is not balanced by a corresponding 'free_irq()' in
> the error handling path, as already done in the remove function.
> 
> Add it.
> 
> Fixes: 9842c38e9176 ("kfifo: fix warn_unused_result")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I also wonder if the loop above is correct. The 'i < MAX_PORT' looks really
> spurious to me.
> 'tty_port_destroy' can be called twice for the same entry (once before
> branching in the error handling path, and once in here) and
> 'tty_unregister_device'/'tty_port_destroy' will be called on entries
> that have not been 'tty_port_init'ed or 'tty_port_register_device'd.
> I don't know if it may be an issue.


Calling tty_port_destroy() twice is fine, but I think calling
tty_unregister_device() for unregistered devices will lead to a NULL
dereference in cdev_del().

regards,
dan carpenter

