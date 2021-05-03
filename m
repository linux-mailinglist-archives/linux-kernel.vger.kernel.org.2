Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0943711F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhECH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 03:28:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54348 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhECH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 03:28:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437PsMH188793;
        Mon, 3 May 2021 07:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4QhsnwfWWGTJsnHGnfCjugjG3L6QRBDRvL9dREoUpBw=;
 b=Asl98KJQx9JPGRH93OxMrO/MEiZb8/LPsWHuGZ7iUXGWacPF/7Orl61ScXaG6Sv4xYCp
 JcsndbO7pehU7Rd3qCsBgxWSvUv70bwFPoaJB/fdMwcMNP8wxywD04S7dFuCQKaxtg/H
 k8CzyaUHp6IiENjQbHAlfDDyTL8ZAMgVqKM2ACo0qw1MexbfsUhG+XVIX5ux3JcxN48r
 h4c8RgQKzFeU2gEeT2UmFBsxT+Bui2GJDqLUU8jKbjr+RuELKavMybGBijh5sMnjE+lC
 IF9GFyk57g1gZ3YiQJlpOqAvA1LIKNzG15kzUDwPUAp9NwO3/z/BV3q+E/lflSgoejzC bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 388vgbjtff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:27:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437LC8a026024;
        Mon, 3 May 2021 07:27:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 389grqbfx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:27:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1437RJ45046642;
        Mon, 3 May 2021 07:27:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 389grqbfwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:27:19 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1437RI1h010712;
        Mon, 3 May 2021 07:27:18 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 00:27:17 -0700
Date:   Mon, 3 May 2021 10:27:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/43] staging: rtl8723bs: remove if-else blocks left
 empty by ODM_RT_TRACE deletion
Message-ID: <20210503072710.GL1981@kadam>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
 <0e1196ebf56787f62dcbfbcba1fcbc2ed37a65ce.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1196ebf56787f62dcbfbcba1fcbc2ed37a65ce.1619794331.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: KlwFlM16WT-AaIUxvm6DZ-YOwjoDoD-h
X-Proofpoint-ORIG-GUID: KlwFlM16WT-AaIUxvm6DZ-YOwjoDoD-h
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:56:24PM +0200, Fabio Aiuto wrote:
> @@ -1533,13 +1529,10 @@ static void phy_IQCalibrate_8723B(
>  				result[t][6] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
>  				result[t][7] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
>  				break;
> -			} else {
>  			}
>  		}
>  
>  /* Allen end */

This comment doesn't mean anything.  It feels like it was supposed to
go with the code that you deleted so it should have been deleted as part
of deleting the empty block.  But it's fine to me if you delete it in
a later patch.

> -		if (0x00 == PathBOK) {
> -		}
>  	}
>  
>  	/* Back to BB mode, load original value */

regards,
dan carpenter

