Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E237B40174C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbhIFHup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:50:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15150 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240220AbhIFHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:50:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1862vj1c018068;
        Mon, 6 Sep 2021 07:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7l0u+7N0bLZzGGyksdtn7MHUotymuh0ostGz0ER1zzQ=;
 b=s2l/q30lRTL/zO71DPnMxdw4J4aOzZKNDDtJ5oJrB8WRF6iOxQuInIb45AQc7YZ3m+G1
 t38Dd5bcwG9HT6966m1/5Zl+kD3u/Wofg+5Fl3Nd5k7sFTxoCWX4ELC7nNAQOxtK5Rvb
 jdB5x3+ZEq0/q/QjsNLcbcdZzNtqn4IhJ2ZMEi05nW5BycpwB2u6HGhd0ZDnPdpNHHEZ
 YpbS6lswjeM5G4mT3JHRoXYrF47kKvAnTNP0AUd1Hqcrzl4s2PMu9UmXVHznkPdoxoDE
 uz4nuyFyjiLe/PtG0rOp6NP+I2V9xifVSRaTEaPEvdEpaFnlFlyL/uzPGlGyzj+1APpd yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=7l0u+7N0bLZzGGyksdtn7MHUotymuh0ostGz0ER1zzQ=;
 b=mlKCS1sZS/pefHXJyXLOL/JbIvQeaGabgU9vYLGA28wY0Sjn7x/HJU1MFnctHj4R8GyZ
 BLJC79uESVXWPFc3W0CP3bgW5QHGcf16vdv5Ri4qvlJqVt9eZ1jw8qg8zkrakAnz5U5m
 4XyG70WZ0ET+9v7ATTbGUI79azNsLus5zYz9r1uD8+Zozz66f+CVMjQCuaPlgt3ar9TI
 AEooToADgwtTQ/b5fCTiQnn+X2zdDVaVGz6fm98rhnNHvhbDN9QqJkgjI5LX9X69WPQh
 pqt9TZwtGfnaO8/g9H0oL+maNBEDYPpLKB31CddnsP951FLcwRXGJWpAAZhCLILpgVK2 tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3avwcf9k4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 07:49:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1867ihdJ066563;
        Mon, 6 Sep 2021 07:49:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3auwwv0685-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 07:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhd0W3FaFnM6WWjh/flM2X0tW7pcnvxySkNoNuZMaOPn7sR7Fg5fRSA9ndG1ahlHIPgmKH7svgsRSR0u+qm8z4EPIwaW8h4ktY+5cDKlg16k8O937WnlBLcHCkvVuzDyWeBZxrCnH3VxfTSqcnHLBtOyUxaDFwzyISVZh32Ka2Ic8HQy5X4xDe8hboIGHFQ1+3egA2nUk2mtmC8OCJFNcOSNmx3HOfvxWlon6Nd4K5slP2gzxpqFjHzxWl5eyaV8NB8OOElBxTzThtZpgn1qdVJFojN4nhhxhOz9Qk7riYmN9TbHsPTFrPEuaOzWru9JYXq4q/VkxX0f79rUQj5FRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7l0u+7N0bLZzGGyksdtn7MHUotymuh0ostGz0ER1zzQ=;
 b=HwYCdOwpFijGNHt8+IO3tNJ/vRbh9QYKkCGfbOWx6DNaR6Zo5tvg+Vwxbta0B2mVMbi563rpXj9QK2SSLjmF07LG3SHrC1g9yJjHv43FHk/2peyEVrv+xAij9dok9vQAZRSiXt1rawqjIOKxb7Dng+d7s2CzwvdWXdNRduE8CxeaOA56oXMKo7eHdsdNlP8zEd3cq2rdwaENVpmoGswbgeT7L5gf7f20LEBSk/mIg6P3be5s5myUzy1LcuUTysgQ2Wz3fUJYvWm4r+zhakLhDS4K9ccVC61GqcG37DNpYZh3tAxcYMFtHb/rYehxXbonYM1jO5mZo1nx6rdORO4prA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l0u+7N0bLZzGGyksdtn7MHUotymuh0ostGz0ER1zzQ=;
 b=BO5qpRBTDk4UOyaGxm2FNLUdISmsbPxSaXLIecz9XGol97MQkBN30IOoDCnb/X175J7W0TBIpFqA2RnLc4ae6uKCMb/zRU1K8ud8Dc0U8xTRkDoJRSA9X1+puBBavSGb8m4fgFd2TOyqGo4bvK3SwDzr2IkiNlXeDGryEKrCP4Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1566.namprd10.prod.outlook.com
 (2603:10b6:300:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 6 Sep
 2021 07:49:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 07:49:28 +0000
Date:   Mon, 6 Sep 2021 10:49:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/3] staging: r8188eu: remove _io_ops structure
Message-ID: <20210906074910.GG1957@kadam>
References: <20210904150447.14659-1-fmdefrancesco@gmail.com>
 <20210904150447.14659-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904150447.14659-2-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.143.41) by JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 07:49:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf6f3704-fc49-40f2-2746-08d9710adaf6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566D3AACC571183E9664A048ED29@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBO3p5C8MRv+t4rdXpY5wstsejTLIZ/8XjeGbsMxpK6K98K89mn1/uC4hPb29dOB9Ti1bO2WNSs1Gk5W6MibV+S5OUTE+IM2cRjmqfcCS6Ja97jXhaLONexwEy1DWySXIr5CnuHevXEd/YRYOaJJqvcCGTpktHBEPQhFnzvID7Lg9d/qdBbJl1Ohdb2NsiN6LKndVa9tlRq6Kr7M0ltIMWZ1cKsMF5plrKbFKjKXjipwZJjiiGPioPGQmH0zwku6X90NDhjH2MoQVn1yinIaVbzYCFyt0kFPWniZ+hC+IKGi0oftJLJrQ30RGCz+qQeGEgKh3Rq6Ff//Lp4z35ZaGu9ZcUDPQuKBOm23kh/jHa3QSTpkgO5eX4RNfbnVPx4c1zcFlGy4YvXv2F2ALQC8L6zVObSEQ4KRaiL4o/3/LDS6nblXihBZA5YQ9FIMVJpGgc1Zo77WCqDPHT7nTatV1IX/IyKG+Ye1ljeHKgtCp9rW0iDH/37gbijDqnl6ISUaZpnIZFwB2ePwJ0qHiGaSYzY821ZbjxxdoXe9cEnf4QfPeZYHyaJXyqCYSi6pLO96FOaWgjTUwSORT8137lQHaOqV1abwMaT1o0ld1woJz0hqkA0+oIPNpBlUyvVL26nAGZv3EJb5Ri/JFyMjPW6Ew+74DhXSD3m7gahB5g8Uh5qNteK0y9dhxYo3M0tiU/X3tV30bjjyLrvT6/lTTjMqTwmiZWnz0ZC9YEfyuSg620I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(66556008)(66476007)(9686003)(8936002)(66946007)(478600001)(55016002)(4326008)(33656002)(6666004)(9576002)(5001810100001)(26005)(38100700002)(38350700002)(44832011)(54906003)(5660300002)(8676002)(52116002)(2906002)(316002)(6916009)(33716001)(956004)(86362001)(6496006)(1076003)(186003)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+LeHO2S9wcrqhrgqj79YxpVmmkTaZ6f6Cj2dBgi76AK9fDrFvkXb4+Zqx7t?=
 =?us-ascii?Q?G6bN/urNsOUxwt4HpM9ydV1BVOJaAif+CStKhk/O7fbDCyOPf6jbhrXIB3QB?=
 =?us-ascii?Q?jI3Z5YfS7uCHkzg9Evw7Rng4W+AbHelqQkBUl486/aCNHz9iMpaxOVGsJ0nd?=
 =?us-ascii?Q?bDQW/Pw0nWw9NiM1QKvUct89yoN3UM7ESYLX7R3bSRGtFGUhOZbbZmVLHm7z?=
 =?us-ascii?Q?hhHo8PE976VjZo+LwakIecnANqDEkHUh5eDCTEQnM/E9xy9L6DhVABh4ayn/?=
 =?us-ascii?Q?BtYHtzHia4QQPUJrd8S3AHWidkbWfilpA3Q4RKqTo5F37tTTJyqpJ4lTcgpS?=
 =?us-ascii?Q?EUS5K0hmSz0zWjUHI4yY1Xy6fmykGd+QsoQFo77tMWHBCCe0JH4ZNHVKeG0V?=
 =?us-ascii?Q?YyszQnJzat2m04/yp3/OKn0xe0x8lkC/1GCnKCvuTPpnTE/2cxbd/N0vriv1?=
 =?us-ascii?Q?uVlqcU96yNxjHr06PIxVeXpI6qxdZQUWzsLIGqCiF1b1yqKkhA+JdV6Cba/O?=
 =?us-ascii?Q?DvHARmRaR+dnPOXAejwATLEZq0nK6yxvKCbYCpx53deC0NOY/U+fwnMsFVpl?=
 =?us-ascii?Q?eCO5K5WHwJMiQ3+x5WB/z936nJ/7f83qv2GnTF2+5WM100Fbu1Wf54O2bemN?=
 =?us-ascii?Q?sHxH1U47KOjn7VMZ1j5r2ISrjC+uDROv6sIgYDoo2hXDdkbarDzEuGM8UaI7?=
 =?us-ascii?Q?UVxovVBqGEitJqj1VYSPUOPXWYc8fg/SnoNljPvXyzVX6oHyKqoCCAy6OseY?=
 =?us-ascii?Q?HA1adalLxQZGp1Y1wNGoM0wirxdEUhgN7+Ff2xOKWYequYWebpp1OvZOw5aW?=
 =?us-ascii?Q?304Jonu4V3zOP1h/hy8aFNOouEh3HH4JYz68PMgtfsasol0sFajzFfX5GuVz?=
 =?us-ascii?Q?5sTZ/sbdp0IFm4V55GGlFz4+kZ4ecjmogw9vAUCyhOiIfcCTbBf5DKuQnHBj?=
 =?us-ascii?Q?SCQK0t5qS+CCO3wtacVDOCRlrOmopFzTR8qbZvxBsOHFWMdlfD+rp/6OH6b/?=
 =?us-ascii?Q?OjpAByyWNQTnux2GQe7f/7LvzOYPsqu1BJIhOUR5B/nEITVjHKBgO1k1a2Xe?=
 =?us-ascii?Q?BmTKbx7+XEW16ZnPtzTauoxwb/SpOROEomVKb6qkBFKJ6VxSWYwBP6Go1jXV?=
 =?us-ascii?Q?gYG0P2Obs+IFaVrySPv3eQMWN8/ezuxyZH1DJHlT2eC40UavJZJ+iizgzDkv?=
 =?us-ascii?Q?p8fPx3R4EF2z0XmwU8pk2otsnofzvaYq3yaEg1nXsjU57e13Uik02u/LHkGo?=
 =?us-ascii?Q?YWpY527SSSSQCLr2ZX7u2mrC6iVMrbLoIgD1GyCz0dfoymg5k3SkyeXUKab0?=
 =?us-ascii?Q?ws3LTZIfZBap3mWJDo6h1q/u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6f3704-fc49-40f2-2746-08d9710adaf6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 07:49:28.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q7ogY6dbsFljD2KVnq6/uhfowkL6pWFzew7UUncAc9nNdwoV+ia3cgkKCdeoDlfJBGHD2yY5XPZUmKBNHZDMtSGUGF1YmIS+PQnziLxtxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10098 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109060049
X-Proofpoint-GUID: OPrWBirJ3XrM1GAZo7REYFU9hCkiqM2i
X-Proofpoint-ORIG-GUID: OPrWBirJ3XrM1GAZo7REYFU9hCkiqM2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 05:04:45PM +0200, Fabio M. De Francesco wrote:
> -static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
> +int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
>  {
> +	struct io_priv *pio_priv = &adapter->iopriv;
> +	struct intf_hdl *pintfhdl = &pio_priv->intf;
>  	u16 wvalue = (u16)(addr & 0x0000ffff);
>  	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
> +	int ret;
>  
>  	if (length > VENDOR_CMD_MAX_DATA_LEN)
>  		return -EINVAL;

The caller treats this negative return as success.

>  
>  	memcpy(buf, pdata, length);
> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
>  
> -	return usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
> +	return RTW_STATUS_CODE(ret);
>  }

[ snip ]


> -void usb_read_port_cancel(struct intf_hdl *pintfhdl)
> +void rtw_read_port_cancel(struct adapter *adapter)
>  {
>  	int i;
> -	struct recv_buf *precvbuf;
> -	struct adapter	*padapter = pintfhdl->padapter;
> -	precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
> +	struct recv_buf *precvbuf = (struct recv_buf *) adapter->recvpriv.precv_buf;
>  
>  	DBG_88E("%s\n", __func__);
>  
> -	padapter->bReadPortCancel = true;
> +	adapter->bReadPortCancel = true;

In these functions it would be better to rename "padapter" as "adapter"
in a follow on function.  Keep it the same for now just to make review
easier.

>  
>  	for (i = 0; i < NR_RECVBUFF; i++) {
>  		precvbuf->reuse = true;
> @@ -134,22 +124,21 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
>  
>  }
>  
> -u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
> +u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *wmem)
>  {
>  	unsigned long irqL;
>  	unsigned int pipe;
>  	int status;
>  	u32 ret = _FAIL;
>  	struct urb *purb = NULL;
> -	struct adapter *padapter = (struct adapter *)pintfhdl->padapter;
> -	struct dvobj_priv	*pdvobj = adapter_to_dvobj(padapter);
> -	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
> +	struct dvobj_priv	*pdvobj = adapter_to_dvobj(adapter);
> +	struct xmit_priv	*pxmitpriv = &adapter->xmitpriv;
>  	struct xmit_buf *pxmitbuf = (struct xmit_buf *)wmem;
>  	struct xmit_frame *pxmitframe = (struct xmit_frame *)pxmitbuf->priv_data;
>  	struct usb_device *pusbd = pdvobj->pusbdev;
>  
> -	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
> -	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
> +	if ((adapter->bDriverStopped) || (adapter->bSurpriseRemoved) ||
> +	    (adapter->pwrctrlpriv.pnp_bstop_trx)) {

Here too etc.  And below.

regards,
dan carpenter

>  		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
>  		goto exit;
>  	}
> @@ -196,7 +185,7 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
>  
>  	status = usb_submit_urb(purb, GFP_ATOMIC);
>  	if (!status) {
> -		struct hal_data_8188e	*haldata = GET_HAL_DATA(padapter);
> +		struct hal_data_8188e	*haldata = GET_HAL_DATA(adapter);
>  
>  		haldata->srestpriv.last_tx_time = jiffies;
>  	} else {
> @@ -205,7 +194,7 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
>  
>  		switch (status) {
>  		case -ENODEV:
> -			padapter->bDriverStopped = true;
> +			adapter->bDriverStopped = true;
>  			break;
>  		default:
>  			break;
> @@ -224,15 +213,14 @@ u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
>  	return ret;
>  }
>  
> -void usb_write_port_cancel(struct intf_hdl *pintfhdl)
> +void rtw_write_port_cancel(struct adapter *adapter)
>  {
>  	int i, j;
> -	struct adapter	*padapter = pintfhdl->padapter;
> -	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
> +	struct xmit_buf *pxmitbuf = (struct xmit_buf *) adapter->xmitpriv.pxmitbuf;
>  
>  	DBG_88E("%s\n", __func__);
>  
> -	padapter->bWritePortCancel = true;
> +	adapter->bWritePortCancel = true;
>  
>  	for (i = 0; i < NR_XMITBUFF; i++) {
>  		for (j = 0; j < 8; j++) {
> @@ -242,7 +230,7 @@ void usb_write_port_cancel(struct intf_hdl *pintfhdl)
>  		pxmitbuf++;
>  	}
>  
> -	pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmit_extbuf;
> +	pxmitbuf = (struct xmit_buf *) adapter->xmitpriv.pxmit_extbuf;
>  	for (i = 0; i < NR_XMIT_EXTBUFF; i++) {
>  		for (j = 0; j < 8; j++) {
>  			if (pxmitbuf->pxmit_urb[j])
> -- 
> 2.33.0
> 
