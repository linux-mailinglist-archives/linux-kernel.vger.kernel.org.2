Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25240D90C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhIPLvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:51:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32554 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238100AbhIPLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:51:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBO6o3028344;
        Thu, 16 Sep 2021 11:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VsySnSwWxlBCMrEoLyGL/TWxadnqruoz3TednA5k74g=;
 b=avS7SBkczq/Ao8muVKSC6sCsZd7NJA00LZTiNFkI8mwVWXq8MjX1S9Ra49PGzA/qUzp4
 z4MWDQ509bTOx5L6U5loOZNVjigLqK6DxkifqomX684mYVCsX+lwBEvd39nWjM/4GZrT
 gzHB4EWk25ZCT8RyTTE8W8wkISYu92RGWxRmDmU0+qOLmOWSePnOPKOeQQlAV7OkbhDS
 Etm3TwYiShnkjj0QLmCRlt7aK70vfBiCKoroMidrB2s4W0hxMvLdJcG5ue9qDv1evwM8
 443tanXYKcI6wUqbipqViF5ybxoluTrK2ligaTeIE2Cu34LnyB8Egszoo4DhcwkwL7ZS hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=VsySnSwWxlBCMrEoLyGL/TWxadnqruoz3TednA5k74g=;
 b=XrdKZ79gyNRmFUhTyub9iIvf95SKGbJI9jEhLMKDdr1DSjJkIzbOhC5Oqr/Gk0h+tj8c
 vYkg7+HdmRq88R/IMY/6gpMQy1e0nvZ8Z/S8+l2YP4J5ypheiM6NASnsyzALvEcohPQp
 qioDuXE+7dntxLvj7PNl5MQp5kzLFogonGOGKQA3RcWy6DAV2Q2Jyeoe4ZI05+UrAqIX
 630WjY2GusLBi8y8XYVthTk8BfQGxXejEJNekNdBEcMShb6sVZWWCKcsVYhmhZXrTBJd
 UUGrkgeZsXnFFo8w47gNqwfuhXs2yTnd7SNk+w/87Z8WvYZ2TT51PUf0RiX8kvL/gp0h iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92hr08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 11:49:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GBiVOY070679;
        Thu, 16 Sep 2021 11:49:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3b0m996m1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 11:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtzQUnc3uTf9n97yE4Jb7Js1KjNsNzoWUaZ+mSeUUPDsWLWzZBk0N5uzvGsvnLNRmlJgOT4ka9IV57COAszTDlPSCu8DnbcYf7Jk+4QETzUhRZ81Ljat5eUjqKxwxlFB08rSKJPl9Zu4rMwkNX2OK0Ct5kzQ0t74O5MZQeeOzbzrNICw1J7xQELXvZRnHDRTXryR7Z9nVDNH5r0eHRqnM3zUwIwYeNhalbaYmPzbBuL3dHdOjiE8wI447YGpKKoWHMl38xrd6x7KafLDo4qRgf0bb0xX1PF5+1FTMKibMKc8gFUzfKLxqTTWnGqAdaL9KWzMGzSh5UBGEDfpk+ythA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VsySnSwWxlBCMrEoLyGL/TWxadnqruoz3TednA5k74g=;
 b=ZJ7Q/KV+6VFQnNXObC4y30DOKz68jgWGku8T5rMK0oUXt6QLK7tNK/jFjUbQ2lsQDpwm89OpmBeZ585OBjQJM9NATn8ILm0Kfd7wAmeUv6jVqhtOfUgO43OH8iqOpArzipsx71Z4gj7pDCJkyhmdrDtT/kZTeob4B7ciuHsRfSrL7uE913JsG59fDKSzxHDkXfyKNF/7mOfGVkGUyOsMYQnCuhwIEbFPe+me1r5RBuhXCaSLtMLdY4X1mWFvXz6bNj+4kb5r/uS96eOkkVP7+3wlKFvlqhQ1PGwdWf7WqWPYDtwnn3Bk6NQ0chSmvYWio+CH3Su6BD8SwKCMm6c+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsySnSwWxlBCMrEoLyGL/TWxadnqruoz3TednA5k74g=;
 b=J/4qLTwIVCFvAyQM2w/NRVhde0cFwP46PbmMnuWIdtoc9dGW8q1jX3WnrSDOUC0qzVttbcoVnDte/IcMh7wpIz5E4B2Gp4DdUIl4BWvb12kCzYrQzSz6q6cUbyWJu2oN57q9sp88lzMDBkoxerTDn/QV29ssx46UB3XoQShmvSs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1973.namprd10.prod.outlook.com
 (2603:10b6:903:126::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 11:49:45 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba%7]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 11:49:45 +0000
Date:   Thu, 16 Sep 2021 14:49:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v6 19/19] staging: r8188eu: remove shared buffer for USB
 requests
Message-ID: <20210916114928.GK2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
 <20210915211103.18001-20-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915211103.18001-20-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 11:49:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7d2f7d-3e8d-4f52-44b0-08d979081401
X-MS-TrafficTypeDiagnostic: CY4PR10MB1973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1973CD1DF4289268091811368EDC9@CY4PR10MB1973.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cIRypu+8z9X1sXj7g6RY31Et+2veehs07WE5MzPMl8OZInkHwtbR1kfH/v302by99a1pjszrm5aQENxr2rxvsfVzQy4wEZErru9uNH2xzSST22GIzW0FRspkJOtd9jQQQkw886Rus7vsDEAmckAIqvsOy+a7OY5YfqL5O7zbPW6myyT8giaZIqJZRshVtrKj8cGYSXB8YbjxLY5fwWVtaO4Spz9WWWLOo/C9Oos4SxFS2NF1iGZo9z0PWEorW0mIssbsL031bKvEL2xlvkdawDveA375ywZexLIdzjiVrd309lwZH+B6Pkt2jspqto8ieJII3gWhccL9ES7wFmQocdh5iO63S5q2v/sHKoHdY4UrIS3f1qn/KT8yeXzSv2ky/bOGoGTA4D8v1t793jEsY8LmuBRZjh06OuISc1wA5ubMXHWIsrvKy/nkDNttBjksXJhI397ie59RD8a8RGl31TxN2UqMIkCP/zvmZ/DdVtYFgYmigqiULo1SDv4G3RLzY7DSOygoIs1oaa0zQbFTBSf+u2zDBDbOB1JZNCAXzWgeOrL5WHQoTphbQ1tqbzxPanyKrCItAhBKx5wpTzNoX8WbNSgXt8AT87O6ytSeUjWd56Bx/8ey9kIEwkPTOeRLGEoNy+hw2Rh1LfIuzgks2IqpI04uuAlcBaMfbCOAXyPaJHz3I1ac+RF+vfCVXpkNKIaFI4pJ1jUFT1zjLuiww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(956004)(9686003)(66556008)(66476007)(66946007)(86362001)(33656002)(38350700002)(44832011)(33716001)(52116002)(8936002)(6496006)(6916009)(8676002)(4326008)(2906002)(9576002)(54906003)(186003)(55016002)(5660300002)(26005)(316002)(6666004)(38100700002)(83380400001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhLJkoHzUqXrFcNgQ88WvjebXuWIvPk+fNKWrxK+E5FFOa+ZhH+qQ8wf5zEI?=
 =?us-ascii?Q?ggXXTASfsUqB1KzsPGyNLoDJ+C1cKtlAIUzqwfSj/fEsQz6H9s1n1CDENQoc?=
 =?us-ascii?Q?rbaBUIevYSZshRFtfYix86qXWdlwUsYgeytDPhrQ1lj+yXd6NUxISZzSz5vk?=
 =?us-ascii?Q?4csvn3BC4kZX0x2WQqT/T3LSbZeCknrWNLXxbFMF3ryo8PGL1VM1Eg+6K4iS?=
 =?us-ascii?Q?m6pn/M5Dr7B6ADFlqSRgXZKutkJMeB4xz5LLYB2aj9bsVmem45IH9gXyERMK?=
 =?us-ascii?Q?JpyRfCpIdluTf+10blkRz4FlfvqfYZ8YDzdeHfIfpeOVjPTWEQlSIHzMGwLU?=
 =?us-ascii?Q?n1D2NpAt1Ttt3yQ5DECISuI651ADpUOuCC9o20GrQ35tExx8/oXsfysQQ/z0?=
 =?us-ascii?Q?jYQSwlM9osLBOxF3697n3m6f8Ti27ANNwO8DWFjQFyZtj43ZbxpUSnbyxIhy?=
 =?us-ascii?Q?WK/LUu/wklj2MLz9SzXYCt3OdVICejMAeMw/EYtSWbQf9btNY4rD8kUkT47F?=
 =?us-ascii?Q?2x+eLKzaMD4rKk6Z5JxvRdlzi3/fY/wlGYQEp94ACloDwjhB3aOxGY7SN/eL?=
 =?us-ascii?Q?KEbKL8+qqWPiONHVFcUuDXVirw1NZAt9TeksXh2KtR/fkKEtMOrP8HOkQQj5?=
 =?us-ascii?Q?XB239xEbeCs682WjO6NdTgQeadPqw7k5+3VPZX0fNYZGdtgDc6HFIcihMzjC?=
 =?us-ascii?Q?tHusqptyo995xnltf4M+oe4oA6cIoOAXpf7URe8OAaMZCuEqIiVjmFjjsM0h?=
 =?us-ascii?Q?ZsvJOnrZZdhIzwxDk0At4z/ekXndKJ+I7VSv49aQMHT8cne80U7tcbclVhw+?=
 =?us-ascii?Q?Yq4QFgZT7ZocaolP+s79wNdG7wFexheW/8cKgvM6Z9yEl5DAV0y7/laUYE2N?=
 =?us-ascii?Q?vL4/N5P1xC52vcbwzDvgyKzi6Q6qyTN6DoLUlvuzT9vfPSCq2ZLBkr6g0UC0?=
 =?us-ascii?Q?SMimEz+MkE2FOv7CVtkJayKJuqz+yxVjMZxmt7unKmNE7IbDqalJhiQJevZE?=
 =?us-ascii?Q?qY+Y9OQWY3KcGIMkSWMmwoMdzyQkxq3naY9HSatzAmvKfHW3NAN6KWfI9Ajb?=
 =?us-ascii?Q?jjkEtKmZj+ToDkv/pJtQHHLq0m4aHEWE1P2pMusArksoD8Tc/KNRGKv+oeVH?=
 =?us-ascii?Q?EZMtPFNJyt1y4r7pjGYDlJAoattZ5aqSHc9uiuZqbIpRV9/E8AKZ2qZ3yJjO?=
 =?us-ascii?Q?1oAPGZsXZDBlqdTH/8Z6NA5IOG2NY31jzyfmbumMFEV0UvbBRB+73lTYq2Vh?=
 =?us-ascii?Q?n0zn+OPWvoxFmhPe+JrtFkdHpw6fdCzIdCu1Ma/rFCAPDLUAO+5KXI/EyNlD?=
 =?us-ascii?Q?iy27DTbCHLoJQVN8l5kzUBo1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d2f7d-3e8d-4f52-44b0-08d979081401
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 11:49:45.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phLMrmjImt86BgF3mBGqoY11FIRZX2X15thbQF8LezXHMMjQLPKkLscnNfrSPKBB+SvhsD/TJFixxTlVxFoav191pqCQ01BU1yUsifcOWiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1973
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=993 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160075
X-Proofpoint-ORIG-GUID: bJkoLOdxY3fudfphkBE6jeWtr1LwPSE9
X-Proofpoint-GUID: bJkoLOdxY3fudfphkBE6jeWtr1LwPSE9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:11:03PM +0200, Fabio M. De Francesco wrote:
>  static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
>  {
>  	int	i;
> @@ -158,9 +135,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
>  		DBG_88E("NON USB_SPEED_HIGH\n");
>  	}
>  
> -	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL)
> -		goto free_dvobj;
> -
>  	/* 3 misc */
>  	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
>  	rtw_reset_continual_urb_error(pdvobjpriv);
> @@ -169,7 +143,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
>  
>  	status = _SUCCESS;
        ^^^^^^^^^^^^^^^^^

>  
> -free_dvobj:
>  	if (status != _SUCCESS && pdvobjpriv) {
            ^^^^^^^^^^^^^^^^^^
status is going to be _SUCCESS so we can delete this if statement.

>  		usb_set_intfdata(usb_intf, NULL);
>  		kfree(pdvobjpriv);
> @@ -200,7 +173,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
>  				usb_reset_device(interface_to_usbdev(usb_intf));
>  			}
>  		}
> -		rtw_deinit_intf_priv(dvobj);
> +
>  		kfree(dvobj);
>  	}

regards,
dan carpenter
