Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508593A3EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFKJL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:11:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9328 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhFKJLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:11:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15B94EaP013543;
        Fri, 11 Jun 2021 09:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g1knzCO2x5sfHUo9G+1N+uTizI/Qrl8Kh1W2H9UFjLs=;
 b=VQKvN7Xkz+uCYHsbL8Cz2nIN1E3QiLis266uP0Yas0/PIEtVF6yVTAsqfWfOH/vRcHxx
 LyOgSmmuDO763Iy/C5vNuQVMFT+A0oVwBJYtKVZjfrTWZl5oowbZrvECpnhfaZZJDCNa
 cm4XBALHW2Ga8z+9BgmlYnswmbNnUyUJvT6rGrxYGfKjR19tSvXTLE6z0gtv0QgV2uVk
 zOg+jIy+Zl6A/07HZFBF+jXg+gV8urMZXx94dTrtAJvn/0z0zvSTBIizIW5IsKLrgm66
 JStDXy1w4SBSWW3vrJPty9SmKEy1u6oIUu1A4YhnXrsc8dU2c7iU6Cjf9DfAav8JgVUg Wg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 393y0x03bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:08:40 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15B98dlU104340;
        Fri, 11 Jun 2021 09:08:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxcxchca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:08:39 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15B98cbe104297;
        Fri, 11 Jun 2021 09:08:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38yxcxchbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:08:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15B98U6c011918;
        Fri, 11 Jun 2021 09:08:32 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jun 2021 02:08:29 -0700
Date:   Fri, 11 Jun 2021 12:08:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, kaixuxia@tencent.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, unixbhaskar@gmail.com,
        gustavoars@kernel.org, martin@kaiser.cx, bkkarthik@pesu.pes.edu
Subject: Re: [PATCH 5/6] staging: rtl8188eu: remove
 DebugComponents/DebugLevel from odm_dm_struct
Message-ID: <20210611090819.GD10983@kadam>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
 <20210611002504.166405-3-phil@philpotter.co.uk>
 <20210611002504.166405-4-phil@philpotter.co.uk>
 <20210611002504.166405-5-phil@philpotter.co.uk>
 <20210611002504.166405-6-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611002504.166405-6-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: wkVToofiUe25XB05DVQ4jSloiInlsDgW
X-Proofpoint-ORIG-GUID: wkVToofiUe25XB05DVQ4jSloiInlsDgW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:25:03AM +0100, Phillip Potter wrote:
> diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> index 80cdcf6f7879..3e7f184ed39a 100644
> --- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> @@ -1851,11 +1851,6 @@ u8 rtw_hal_get_def_var(struct adapter *Adapter, enum hal_def_variable eVariable,
>  		}
>  		break;
>  	case HW_DEF_ODM_DBG_FLAG:
> -		{
> -			struct odm_dm_struct *dm_ocm = &haldata->odmpriv;
> -
> -			pr_info("dm_ocm->DebugComponents = 0x%llx\n", dm_ocm->DebugComponents);
> -		}
>  		break;

We will want to delete everything to do with ODM_DBG_FLAG but that can
be done in later patches.

regards,
dan carpenter

