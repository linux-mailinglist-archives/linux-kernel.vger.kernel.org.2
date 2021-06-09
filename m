Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA403A1221
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhFILSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:18:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234508AbhFILSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:18:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159BDvDV023649;
        Wed, 9 Jun 2021 11:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k2Q/TB9MGcJNchw06veGMKNS97ORNy5N58Oflu76ZNk=;
 b=Pco8jrH0ic37kyJEfzGTCQfXO41VEi4YBI0NKzWE8nwKPiBDAred15SC/J1TWBnHoUkr
 vO08+zhxzVQ/8LAnuKay2yzRAe8WIXi17QNX9ulxbAEoyXJGZJKAEXfdYCHHUMNCR7me
 b46+GymJgv1w4M+zIr6E8cQtpZCmy9QwAVa7I6jEF9kmgbXac5HOFDGfE5o2jFVhg/Ji
 roYQIaNTZtUlTdz6xCVxUaBes+UR3sDWNRUs6gmVzrxXoRiI9MdecEo9rWRLsYTLdJ8g
 XlBPhVhapq44rVpq3XQlbjPemTJPeve03ZoHwB9XIUIWJeyxQhdnyl8Wmsq11duBeGMi zQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 391g4g8xb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 11:14:58 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 159BB0T0080401;
        Wed, 9 Jun 2021 11:14:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922wunr7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 11:14:57 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 159BC9AI084922;
        Wed, 9 Jun 2021 11:14:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3922wunr6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 11:14:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 159BEtRe003010;
        Wed, 9 Jun 2021 11:14:55 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 04:14:55 -0700
Date:   Wed, 9 Jun 2021 14:14:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] staging: rtl8723bs: use list_for_each_safe in loops
 deleting iterated items
Message-ID: <20210609111447.GG1955@kadam>
References: <20210607134618.11237-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607134618.11237-1-fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: CK_0LLT_dRHv0wWLwkPcyIXldEIjbJNz
X-Proofpoint-ORIG-GUID: CK_0LLT_dRHv0wWLwkPcyIXldEIjbJNz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 03:46:18PM +0200, Fabio Aiuto wrote:
> Fix some beautified loops over linked lists.
> Use list_for_each_safe on loops which could delete
> objects in the list.
> 
> Fixes: b3cd518c5abd ("staging: rtl8723bs: Use list iterators and helpers")
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

