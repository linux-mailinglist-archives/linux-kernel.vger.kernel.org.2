Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48A40AAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhINJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:34:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhINJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:34:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E8iCZA009867;
        Tue, 14 Sep 2021 09:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=PLGXOYyUY+kNdz7RK+DWQHIhO0vUL9U230+eRbRea/Q=;
 b=I9g3hQIawhVcNm6rwKbZmBy0FePvpKOV5UnTOkZz6LDLDB5gYPanR8ggpHdTOKvTJ+ER
 wfpy4BUv+3d/9YfxyB44HZPPH3ZBKjsxMSqOC7mfDVlrtqcpl5mpfCc44nQvUmFnSdnI
 t/16NltFlm3Wv2a5EKoxbtJUIGSNNj6WqmokvAb7DaJpo3YUvZIViysOD+BVe2GeKfZB
 cooFCQMHXRyoG1cHVYGWijaB6keg835/Z6bGz/xiV4F75xQykDgqTnZitBmFrbzxdEcU
 iQMPWU1/GXPU3YrwxufBvTT0aT8b37ICRR1WsbU0ByBZ+fBcBExoDhWiMsXlzpB5hhUP bA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=PLGXOYyUY+kNdz7RK+DWQHIhO0vUL9U230+eRbRea/Q=;
 b=HoJlRd6qIc1922PpNaQIfX3xb+OmOzYps4IvIYcTxz3mm1ffzN/bB+QDob8SHsylzfW6
 Tn6iIzNrERG2TiQIvgXOcQ5v9cyCEf/rjkbAt/8DruG81CxvRAPwt9qKWu5puFYgfmmk
 ymUV58hKp8abA3zbx8SK7hPbwhOq3fSAHwSmv9rTo/pNABuA01zBhVmW1JYhO1acwBpd
 nGj3WcrzZaiT6GgNU+BhhrfFQt5g9uUMuKCUk+k9srzsBYv6GU9nBOyAHQnM0WyTA9+x
 yrf6P+9JUxblVPiOxhuJrexSWuyorsrWH6sSCQvmQZ8fERVGdvYuPR+xJwYopOBKSoeF kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mgqxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:33:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E9UWHs114856;
        Tue, 14 Sep 2021 09:33:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 3b0jgcu6dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apg1V1Jcb2/6tLijxLHYegfxcGxi348Oa31ody4RIQhk9ZdXkT03q8YJFDChh2A+wUKV+kjIuXI69lE5EVSVkZKU2AJ3QcgEXPnyI14uPzteyAzQtvmKTMce+BuoV2zKoYxIK/bdOFhEClgzXlZ3/w6zvPBdr+qOZhC91oTcc8wK2mrgESeKdmToLL8lyktmzsXAXrWCQWQl2GOQP5Ytz80X1NSIaFAEYgJtGJSD33C3wpBuZQgBCFWuLred56Wlqlq5qMXKOGQ68tDzR7DlNa4scNC1Ez2/4SHC2GiSO1X2Xe3X+T+dHagvRIDHTy9q07wbRtM6AyxYern/M2zYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PLGXOYyUY+kNdz7RK+DWQHIhO0vUL9U230+eRbRea/Q=;
 b=nd055r5cMs20fsB+jdhjIvl+UDpl2Q4aSkAfy1i0fDHX61xym/c4pnWxlw+xCt56qJ7gUfWKW2URVfBFr4mUE6Qpq/0gQj96vVC5M+Z5QvfZFOJLvjxKE4MUTyFcVsJCBfcZVbezey3jyg2AOo1D28UGEn9FacLtBLtRJwcI73DPp5WwC7cZnsh0Q/leEtrXXGNz29H/3TYr9hHvazGml1dkpYNKCuDGdzXq0JJutPfIaKSMlXNzkGeJb90AAk5f7fWA4DGG/DRf5Ao09vgZqT1s8OsNri87w5BEaFUI2aApTkv+CbFuabnKgtpNWgzbNzymBlVkZZXokVqHce+fQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLGXOYyUY+kNdz7RK+DWQHIhO0vUL9U230+eRbRea/Q=;
 b=ybTPhCYCGerrlIXP9QkKm6SswRgQe6b79N8SOwnsJpi1ZDFsu/X5cdmrIlMmOtI3eZxTRe848LPI7pRfX8vF9SvImslmIVw1Gxc9gIrdPTlBEAR3/TqmOphk6wiXYnU54LsjBrWyZxxuWbSh03sFlE1MUI0MqbJmr7WmFvwqKBs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4690.namprd10.prod.outlook.com
 (2603:10b6:303:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 09:33:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 09:33:16 +0000
Date:   Tue, 14 Sep 2021 12:32:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 17/18] staging: r8188eu: Shorten calls chain of
 rtw_read8/16/32()
Message-ID: <20210914093258.GC2088@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-18-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210913181002.16651-18-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 09:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b402e935-6f76-456c-dd36-08d97762adf1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4690A4A003C3DD1BA25F421D8EDA9@CO1PR10MB4690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fl8nksubBwMFPea7uRhjS0gIeuJ1x0GJoFcDKKbSurpdKNBaCrKvpTs6Yz4UndsFhzN8IW8ac3dO72Ax7UPD+JCGFqGgFiJY5r4iqxO5xoPcOI62ISC7alVfMLJLgX3HajOBb8j11F/OxsW6Yclnd7E1UTXxbNNxqyPrxwfBueft7UHF6rKY6wubs4qLcEqpYryHng7dz6HDZjn1xCaysR+o7+IrxzrlG1W0DporFCEulEvqIA4WrrVfPjir/ejqqKCUZAPFEiel6rx/kgdBP4N4zUncXRW1SMYTMRoX8SQsgYpLipchPxtfF6LNhTEdzCVXaUbVJLF1IsdvYWeFYanr+efPf05deetNTMWEEOGDScUVfeUkHLbzzbq9jEVQ7ayPbzvww2OD4DrKxR3HyRLPGEXuy8Z8/rK/xI75/gFhl59ettkGmNq9LDEbxtHiC+WsPiS6j0z6hefN1g/ZD/L5VEjYjuxH4nox/KPkIxWRxG6WQuzjB2vUw2Vhy7ZzFIy3nIeub/G1lChPX371yabMQJVu5hVm3wGGVKtEQVD2OqXT6DwwSPve0fW7SaGdti5+pMfWDJUphHqiptgZ6UhSca2pxqwmSyXf3i2GPvu1CkuvSDLYwfzcLL00/0d0JxCB81zSfVpNT45Fudkb5ZPqvzF8i0ho2HKt1ciBWJHBwcJF/oSExuAmPLNw3weuzdpzP/W/ySREeDQj9D4JlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(55016002)(83380400001)(956004)(4326008)(316002)(52116002)(33656002)(66476007)(66556008)(66946007)(478600001)(5660300002)(6916009)(6666004)(2906002)(9576002)(8936002)(1076003)(54906003)(38100700002)(6496006)(44832011)(26005)(38350700002)(33716001)(86362001)(8676002)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlhdTJoR0ZWVldBUGI5UTR5azhqTTBueEJHR0FjK0daWkN6MDFONFovNzUx?=
 =?utf-8?B?eEUxTDhER0twODJVeUtuaFpnNGZDVWhuUSsydXAzUmgwZGFJcVg3bkJTb3JR?=
 =?utf-8?B?V2lXZXE3TlFjMytVMVErVFpPeGV3WUtPNzRaVEI3Z29wakI4N3R1UVJKWEhU?=
 =?utf-8?B?RUxIOWpJM0phZEUxUlJOUTg3RmdtY1NaYktWU3NaMmhKUnhuZW0vNWZmZ3pY?=
 =?utf-8?B?SXdHWTZrUkZOWEVkQlcxRWQyWkZTUDZ5SkF0bU1QMVF6WjdHaTBQOXlJWTB2?=
 =?utf-8?B?MTQ4c1ZUdUZnY0gvbzZjNTdETHo4VWZkWGpRM0lBS2VFS25oanRESFVsdW0x?=
 =?utf-8?B?bjBFb2RhdWJvV29iZnZUSHh1SlhxeTZmM0FoNGpzaVZVQ1ZsblZqR2tRVGpH?=
 =?utf-8?B?eDlGMXBwQlNoMTVta2JtZVI2ZEpTczVDM0YrZlRXTjJEMmtHbVBRZjhBcHNE?=
 =?utf-8?B?eDZFNFhwcXFLQi8yMngwbjl2ZEVMVGcxaGpmRGcwZHk4enFPRmhKb2k2QW5a?=
 =?utf-8?B?OW5yeDMzM2JyeHoydE02VldGRGt3S3pHNGt5dXFDNysrMWFjVkljcDFseGo4?=
 =?utf-8?B?dTBycndIcFpSOHZnWnlTZk1jK0IwRXVid01lMW1qQndTVmEvT1YxdmtOV09M?=
 =?utf-8?B?c1ZoN3VXTnJ1UHQ0RS85VlNidzVUTG5GeHZ0KzZUek96NEVjOC9CdlNYZHBq?=
 =?utf-8?B?WExjaWdtQVM5YkFvK3lrclE2YUorbEpvOVIwOTdKL080MzRJVzFPbldyQ0JG?=
 =?utf-8?B?K0s3ZEJHTXF4alpDVi9iRTZzMDIrVVpkWDRrQ0c1Zng4UmFKUVpNR1lmWkg2?=
 =?utf-8?B?Z2hGM1pRcnl3MlVDeGRkZlRkU2tjVWJjTEl5Um1HOHF0OEk1OFo1T3hNdWNh?=
 =?utf-8?B?NDFJVVVCdFlFZ0dkcTdOcFA2VzU1TWlrVkZZbUNKbWorUUlPUE1aVy9hdGxY?=
 =?utf-8?B?SjhEcFFxZFh0UlBxc3NwNHhSYnhyRnZGd3R2QlF1SjVkbVlyTUVHdVd1QWFP?=
 =?utf-8?B?N2dvbVlFSUtMazZIWFJXdVkwSmJzRDVNQmwxYjFmdWJGa0N3ZXpGbVlXZUts?=
 =?utf-8?B?bWhVTUtVVzNrd0x5WGlVVVBGdzNNSHdlYnEvcGtQWk9kcmlrNDVmRm42MXhL?=
 =?utf-8?B?ZTBQd0hpNzJROHh0QUpHMmNGZmZXUmpQR1RmNHlGZ2FBUUNhcFpndnRNTzZQ?=
 =?utf-8?B?ME96RGM1V3ZPWGxPWFlJdEFlTEFDUDlSVEJVTE1xK1p4d2ppaGx3ZENBUG4x?=
 =?utf-8?B?VTlBNjBFUTR4c2lCbHNrdWY2bjZ2YVFKSDNWRWZMSzEvcldCcjlQQ21FYjhS?=
 =?utf-8?B?cTRpbXNva3ZNUk5pbjIvRWZlL2ZqNnBZMjkyT1NQNWhEbzJzNjAxOHFsNzN3?=
 =?utf-8?B?Z0Rac0s2QjlKRlA0cmtKZGdFRFpxcG42cW4vaDVxem1PbVJUWXVXWURZekd6?=
 =?utf-8?B?SE9ucms1bzhIWXNERzhtdkpsbDRUcWlrdVErWkdSaE5BQ09vUk8wOXFENHAr?=
 =?utf-8?B?dmhneHlLZmZMZjdLYkZVV2Z2TXV2WU1nVE9mZkZpRXFQbVRuL0JOcWRvWXVQ?=
 =?utf-8?B?S1VoMC81amx1SWg1QnlYQUVLMXJlcFkvZjEySXk1ZmliM2FUMm9xQ0MyaWJS?=
 =?utf-8?B?YU9ZMUE0SnZaNUJNTjVsdDRrZUZXRzlNR2szOURFN2VHcE1ZVTY1WlV3aXNZ?=
 =?utf-8?B?TkdTdTVDeXkwZHJjamRQRE50T0htOVl1dnprM3R3L1FnSm55TmJrcDN4YnM0?=
 =?utf-8?Q?CJs46LO17sokOfnW2pb+47gg02xlHSFHr/TJ8G6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b402e935-6f76-456c-dd36-08d97762adf1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 09:33:16.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hClZs/MxE9SI+UP4F9tBQWGq2wAXIv2xrokXJsHOMu2wHHqkIN04ye6bGO5WfGgS/tSkYLcrD4lMsh6b9+hHqU51PJN6BOaXTCzJy1LL7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140057
X-Proofpoint-GUID: 9Cg4o-CBu9sh68sLzU17ZgiKXMyAmuxf
X-Proofpoint-ORIG-GUID: 9Cg4o-CBu9sh68sLzU17ZgiKXMyAmuxf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:10:01PM +0200, Fabio M. De Francesco wrote:
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 04402bab805e..75475b0083db 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -89,6 +89,56 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  	return status;
>  }
>  
> +static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
> +{
> +	int status;
> +	u8 *io_buf; /* pointer to I/O buffer */
> +	struct adapter *adapt = intfhdl->padapter;
> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> +	struct usb_device *udev = dvobjpriv->pusbdev;
> +
> +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
> +		status = -EPERM;
> +		goto exit;
> +	}

Just return directly.

	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
		return -EPERM;

> +
> +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> +
> +	io_buf = dvobjpriv->usb_vendor_req_buf;
> +
> +	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> +				      REALTEK_USB_VENQT_READ, addr,
> +				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
> +				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
> +				      GFP_KERNEL);
> +	if (!status) {
> +		/*  Success this control transfer. */

It's always better to do error handling instead of success handling.

	if (status) {

Remove the comment because now it's in the standard format.

> +		rtw_reset_continual_urb_error(dvobjpriv);
> +		memcpy(data, io_buf, size);
> +		goto mutex_unlock;
> +	}
> +	/*  error cases */
> +	if (status == (-ESHUTDOWN || -ENODEV || -ENOENT)) {

	if (status == -ESHUTDOWN ||
	    status == -ENODEV ||
	    status == -ENOENT) {


> +		/*
> +		 * device or controller has been disabled due to
> +		 * some problem that could not be worked around,
> +		 * device or bus doesn’t exist, endpoint does not
> +		 * exist or is not enabled.
> +		 */
> +		adapt->bSurpriseRemoved = true;
> +			goto mutex_unlock;

Indented wrong.

> +	}
> +	GET_HAL_DATA(adapt)->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
> +	if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> +		adapt->bSurpriseRemoved = true;
> +		goto mutex_unlock;
> +	}
> +mutex_unlock:
> +	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
> +exit:
> +	return status;
> +}

regards,
dan carpenter

