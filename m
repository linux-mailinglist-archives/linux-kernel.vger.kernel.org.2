Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A536738737E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhERHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:47:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbhERHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:46:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14I7j3nW098852;
        Tue, 18 May 2021 07:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iTzTY0x++hD2t/nkrSs36GsjOrSccAq3WjLd9UrUYOw=;
 b=EM+wisu7K6SLf1fo9z25FhCmtftw/veeVCcMm5yU6tPc4T0nru0mXpsTPeRwmJ4g94pi
 mIHX6kzNG+YrGOKzr3d9I/qgN7eSLOofDWe08QjD1jdKmz4Ps9Sj2phE3StXSUI4oNu3
 ryKFy2Tp+v3jBr1V1WXT5mIIBWCI+ZCbhnNVkzzL1Zp9QLoi0jP3/9GoLV6VodGay5In
 8JEO4vMswCf7Ucn1Lio/KCGJckvBRoSKP/jP4hnvC9Ds5knJvF1UivMRXAnXTmf1sypY
 elc8x4tXOrX2Ha1ZwRoEl0srwYEbQ5FGs5IYAczN7cOAwSr4h+RvglxfeznDLYGj5Nmq wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38j5qr5dnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 07:45:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14I7e2CP100614;
        Tue, 18 May 2021 07:45:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38j3du453b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 07:45:07 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14I7hxeJ112006;
        Tue, 18 May 2021 07:45:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38j3du452x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 07:45:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14I7j1EU018121;
        Tue, 18 May 2021 07:45:01 GMT
Received: from kadam (/62.8.83.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 May 2021 07:45:00 +0000
Date:   Tue, 18 May 2021 10:44:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] staging: rtl8188eu: use safe iterator in
 rtw_free_network_queue
Message-ID: <20210518074453.GM1955@kadam>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517201826.25150-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: SGylDce-mjR1AQEiLnPGUUHbHkidKBbY
X-Proofpoint-ORIG-GUID: SGylDce-mjR1AQEiLnPGUUHbHkidKBbY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:18:21PM +0200, Martin Kaiser wrote:
> rtw_free_network_queue iterates over the scanned wireless networks and
> calls _rtw_free_network for each of them. In some cases,
> _rtw_free_network removes a network from the list.
> 
> We have to use list_for_each_entry_safe if we remove list entries while
> we iterate over a list.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>  - use list_for_each_entry_safe
> 

I hadn't intended for you to redo the patch otherwise I would have
asked you to include endless loop script in all the commit messages
and rename "temp" (temperatures) to "tmp" (temporary).

You have to learn to let go, patches are never perfect.  But let's say
that these v2 patch are perfect and add a:

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Don't resend!  :)

regards,
dan carpenter
