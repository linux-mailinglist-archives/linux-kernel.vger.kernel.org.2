Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6255640DA59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbhIPMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:52:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21664 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239766AbhIPMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:52:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBEDPG028338;
        Thu, 16 Sep 2021 12:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SK/py7h3sK7BMdl12UjA9EKhrPhFlHdDQ81yEFUE4+8=;
 b=HBPDhrpHVrIupCTmvPy6xwXJ3k+AtTWfdA5C5aGDIEcCwzHC1cbPWZy2kwxhPs+ZVGHs
 IEyGM2tgeXmk9FphAmq82uzk42zJb6f2/WklOI9PbSbnBikhjhJPYRsJldVBI6rDzoi4
 HEWlCRTIToFX6qKPxyWDrhTrh4U8JcM+NSZK/HpzudG0AvTBwFDcjUMTfjnU8bqB9nr2
 38ibFGinDkQxLvM/Vi5vX774Zz/Xo5mB5dt0mmtwnvvtkvpj/ip3ZiphRfbgWaRtayzx
 1p0GNW+tdOW2i8TecQcPqtoMQX1osB98C/oXf3GNbq2Ry0BSLOm7heZwbIwCnfotb5hJ VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=SK/py7h3sK7BMdl12UjA9EKhrPhFlHdDQ81yEFUE4+8=;
 b=U/+AWCu3h9SKh1QAvFzLWPAeYK+/oBJsX1tJEb6wM6By6ECpB2ow5NlLWD23uFFeqpWq
 Pg2oEKOEC6LYKJNUbG0P+apkHMqJSsrEImYeRJrXBD31xBYA+f+kmJwmjYzwZngiXIvy
 2h+36edHRL/cF6bZWSCVjZKYNMVR+XFbf+7YoEqHmhiAObj+okJCDq88sJi2opvREifq
 4evm61/sK5cOK0204VXZjwjq6egnMVDU29jnl0IxR4UQkJDZHy6dWAcj3OVjMV4K9q3d
 wpgtHf4XJ3+sa4bjBDoTUTyftcxAmp1xinwrvAklq7dcfSqogvOr5qFQpJ4jCP20YXxo sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92j074-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:50:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GCjFiM074183;
        Thu, 16 Sep 2021 12:50:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3b0hjy6by9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX/p5UeUwT2OmYNFoesCfPH9Ztc9H151F2Az3aaCgVVuz8BU0s079/1U+vemJqvdj0gsxBXI4/Z5An7+okA7QTFK72AbrSCz3+91RQbM3lmKhVZtxiv/NXvIta1BTkjcKJw9Qt1BMwsEW3teC3QvhaR7St7fEekKotapuWK9WM3TmSkQ7k82x+wG+cDjanRXKu9uVTKA3wvhKFhtQ5gchTdeQDiHt/d2Fga6xYXrIG+rhVe8bq86DmAipAngNU3uVOAOiUdAthGYN2vNfLOBOZvUjxWLCUbERFkUoIDFked8lv+OZXOD3OAuLZWCSHS+0rbKhBhTRjf7475cfFtjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SK/py7h3sK7BMdl12UjA9EKhrPhFlHdDQ81yEFUE4+8=;
 b=blRIy0Bvw8feQa+it6GiQjIibdItSGisxDXUXjDnUuTFflr6pLyLi658ZIIBxRq1ovqDooTGXGHBnv9NzHkQXTjmB9M0DJZ5hIYqCw1FPeIxf4ldHApJGFAGzWaKpJZWN3qLDcH8+On8O2rv2fHvE1QsA6eLCYu3Bo+BK8EncmhRQx9t9qUsuIzlMnTrcE/qBMmTqCGrS1eUQthP7ZcMjXiNwJLgDl+fKnKyB9mAf4cJAGaBt4yXFule5nac0raZcHSwXg7caqCNs9yk3OGGiXiVmYQOry86DvXbUK/94JvMnS1KTB9bqwTGlpbgKa6A4itj4tIRJF7NOA5N5K4zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK/py7h3sK7BMdl12UjA9EKhrPhFlHdDQ81yEFUE4+8=;
 b=yWDhOIhu4Tc8Xks7Fjz34HZYca1tUXciA7QYH5Zk3BJZIcqx9G/ba0WuMjvcz57bpqInWk0gkCuvb5CDlT7ccQl7bm7zVrDyIoq0CDhPL9cn8VkD8PTvD+4vcGEsowdspqN1hPqWq9IisyrSKE10dGWNC3/15u9gX3Nhw8hjlXA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 12:50:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 12:50:49 +0000
Date:   Thu, 16 Sep 2021 15:50:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v6 16/19] staging: r8188eu: Clean up rtw_read*() and
 rtw_write*()
Message-ID: <20210916125029.GL2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
 <20210915211103.18001-17-fmdefrancesco@gmail.com>
 <20210916113606.GJ2116@kadam>
 <1797501.xtDa3BoUpI@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1797501.xtDa3BoUpI@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:50:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1bd6bda-3f6b-48fd-17b7-08d979109bd0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44495852A471EC64B969E2CD8EDC9@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/BtWF1C9HxGXcFohdBB9oZy3k8cCvqMGuFrEjlU+25H53Wh6Laa9QkxeD8Kz8fMMQp7Jw7kKzdoVFavfV0MyRcdqhXkwoonEVCRxJMGM469xmLZ+BuKLOO7iIwb8/4i7bmdhwgPLyEezU8aXinUJHxN420GzC8HPg8lx+FcqxZmVoK9IbtceQUlDV9Q/pyVTTw/hCvXqBwMh1s32+TLPirhgNUjjvhcmijXTZQH51N1WpDKh89Q+AROA8qvrhkdzhGZpFgkrfhy/Zy3qoQ/QdPEiSPSkcXcy3/n0L8JVAefd+RvCaXz5b/PU52lu5A9sz20m/QRDoVDf99DMWYo+4GtVKecBa8teCHQWp87xiQp5feOYvf9SRVK0aDnhDsfG4FuDaQU/67OZWEdzSU8+JnvudJAf2/8uQKJy/GUe0wDGE9OsSLjyMs7R+x10nt2K9haxuCNYYBlEWIAQnw4xSTy5SWer9jbB6fH1b7QVf6dostHzf/61ec4wZZf0KAuO0O2PHtXvo3RMqi6N1h5SzOJ4XjgY/24kC3MU9fusd4Qg0tdNpynAykdGvB9OpI6bPltR/Rro31M62ZB52+pxJH4isBFKakmGNPMGJkqBm5K929Xtj4STk/ojrNHCIK0MKtFuRqwa87id6WgCQcugWuNXhmQrP7XCFqsOlH0GVK53gOWkAfCO5v9Cpk1fldr2xxtTFILs56tqU1jPd490g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(54906003)(508600001)(33716001)(5660300002)(316002)(6666004)(186003)(44832011)(4326008)(9576002)(38100700002)(8676002)(86362001)(38350700002)(55016002)(956004)(33656002)(9686003)(1076003)(66556008)(6496006)(66946007)(2906002)(6916009)(53546011)(66476007)(52116002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HErnLGc2v7I/DipYKxK+HMbrXHfv1S/7K1YnVLbd1GOe+DkLIuKAN1C1T2S?=
 =?us-ascii?Q?X//YoT86QoGNEY0InGaT4DxLgrNrycppWNxGAKfroAuBUAp5E8gn5yrSEnye?=
 =?us-ascii?Q?FvexZU3tkQbyJsLVhkILjr0Q83RtGyExlZXwqyolgDtxc8KzP6Omg9z1/aPw?=
 =?us-ascii?Q?GTrTX2lAnpr+WfEhTRcOcUrBU5mU6GIeIcgcYPhR+ueO+9bnT2ttk0uGJ0ce?=
 =?us-ascii?Q?nj528aLgHZnm8rUCP1u9eY4xQDXdDlrEEe2AhbaTZ9IO+AI31R3j7abwIU6U?=
 =?us-ascii?Q?C5v+GKxXC6aLiXA1CZhCL/Yzn1aDGddbWCeELMLagFzj1UvMIs+hLFgp9Vrj?=
 =?us-ascii?Q?LwjPTCm9jePWxd/+nsrFKw3kHGwrxxMXhVaIlSRhibn/blNaaSo4qTEQN3VE?=
 =?us-ascii?Q?Z19MsgRFWb7pR0yhvfEW0t4XF7xRrF2s84PaiVsBc0glNjlPIIp9O2nOK1af?=
 =?us-ascii?Q?NatcYJMhkQZ0Cv/3dyMXP5Y9hJvl6Ran5ehD/Y4YnG+ec73RHvraEWmU9qMs?=
 =?us-ascii?Q?1Tj7GtHkd6PPX4mkgRA/qiBcaHVWjKub7XlWpTYR5gujL60ltlNeqRh/dGs6?=
 =?us-ascii?Q?SbsAE4ubgOpo8fuo8YMywcnZgSM7Wfw3eHHaYnHNgW9VSOn3nV2j5iUhEjqW?=
 =?us-ascii?Q?6O+Zl1MbcXNadLgIi5jd4LZrjxLPTZD7Z9WhthPgcBEASa+NPszaLaR9GMf8?=
 =?us-ascii?Q?DIl2MCt/VMugZu9xGKMLnwtWIQXQ4lOIYedTkuCNTDlsH3qlfWU9cyjTGkaP?=
 =?us-ascii?Q?zNBB2z1ZXj9yBqNbW4Nd+xdb7WXrviLQg6lMLwZDDyiihzB3NsO1rDw5Vzm8?=
 =?us-ascii?Q?Ghci8Z51YdnpKS699/6SdWb+TumxpIYxrzgM5+44wQHkNiWbN2SPZUBiEhjo?=
 =?us-ascii?Q?JMlWzkrKwJLwOYqgCVS9eAO+28fIjnTfDNMeSOKa/tRMSharuGevWcE4Zcxu?=
 =?us-ascii?Q?8OrRfaR/O3naWZXn5gemaLBzoajDox0rjpxnYmvfUuVQfeSNIVE7VGB08D1/?=
 =?us-ascii?Q?ELOu/kOst38PkhadtbQBuap3egQWm/x3CpzXvZzwIVHl86uD1L7avoigMjxZ?=
 =?us-ascii?Q?7P7ozc6O4o5GaBuEKSuNPWpNcic99/FetNRfj8m1KzcncsYD7aNc9SPsBeYC?=
 =?us-ascii?Q?gaZ/ouPaThfdDRcaMZ8V1NU3icw/uYXlYTiraY5kTtg9w1BtFs8va4SKbPLw?=
 =?us-ascii?Q?RWNRE5ynUPkUrJOm+Zv0dal+VEPuPQpu79ExvUfJopTAXuvkqljstJmcZF4R?=
 =?us-ascii?Q?JHJAB15AkH0d95f2E3vdbocRUUE6ADeah53HCtOm0g82zLtIxP6wOuy6S1HV?=
 =?us-ascii?Q?MrdHgeWxlMEjVV+N96vYS03d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bd6bda-3f6b-48fd-17b7-08d979109bd0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:50:49.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBtXUHbI+EjbQpgkpjQwUSCZW3uEkJgmw4lWu5c1Cj+d/eOCfTXJMt4+Gi4QXOQ+Y0f+JGEAwS8uj5Ol96rlglujlbuyDmaUH7fEo15a0OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160082
X-Proofpoint-ORIG-GUID: tFkgtUizy38GNqrWgJgpr3bJ8l0MrmGd
X-Proofpoint-GUID: tFkgtUizy38GNqrWgJgpr3bJ8l0MrmGd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:14:14PM +0200, Fabio M. De Francesco wrote:
> On Thursday, September 16, 2021 1:36:06 PM CEST Dan Carpenter wrote:
> > On Wed, Sep 15, 2021 at 11:11:00PM +0200, Fabio M. De Francesco wrote:
> > > Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in 
> usb_ops_linux.c.
> > > 
> > 
> > It would be good to know what you did more specifically.
> > 
> > 1) Rename variables:
> > 	pio_priv => io_priv
> > 	pintfhdl => intfhdl
> > 	wvalue => address.
> > 2) Remove unnecessary casts.
> > 3) Fix types.  Use __le16 instead of __le32.
> 
> Dear Dan,
> 
> I'm sorry for missing that. :( 
> 
> Now I remember that you asked for this specifications at least once (if not 
> twice). I'll redo the commit message and add the list above in v7. I guess 
> that I have to do the same in 15/19.
> 
> > The last one is a small KASan bug fix.  So good job on that.
> 
> Thanks (even if I don't yet know anything about KASan).
> 
> > > Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> > > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 68 ++++++++++-----------
> > >  1 file changed, 34 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/
> staging/r8188eu/hal/usb_ops_linux.c
> > > index 2098ce935dc0..d87da84eca07 100644
> > > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > @@ -91,91 +91,91 @@ static int usbctrl_vendorreq(struct intf_hdl 
> *intfhdl, u16 value, void *data, u1
> > >  
> > >  u8 rtw_read8(struct adapter *adapter, u32 addr)
> > >  {
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > > +	struct io_priv *io_priv = &adapter->iopriv;
> > > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > > +	u16 address = addr & 0xffff;
> > >  	u8 data;
> > > -
> > 
> > Deleting this line introduces a checkpatch warning.
> 
> I didn't notice the warning. This too will be fixed in v7.
> 
> > > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, 
> REALTEK_USB_VENQT_READ);
> > > +	usbctrl_vendorreq(intfhdl, address, &data, 1, 
> REALTEK_USB_VENQT_READ);
> > >  
> > >  	return data;
> > >  }
> > >  
> > >  u16 rtw_read16(struct adapter *adapter, u32 addr)
> > >  {
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > > -	__le32 data;
> > > +	struct io_priv *io_priv = &adapter->iopriv;
> > > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > > +	u16 address = addr & 0xffff;
> > > +	__le16 data;
> > >  
> > > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, 
> REALTEK_USB_VENQT_READ);
> > > +	usbctrl_vendorreq(intfhdl, address, &data, 2, 
> REALTEK_USB_VENQT_READ);
> > >  
> > > -	return (u16)(le32_to_cpu(data) & 0xffff);
> > > +	return le16_to_cpu(data);
> > 
> > The last two bytes of "data" are not initialized.  I do not think that
> > will cause a bug on either endian type of system during runtime but I
> > this that KASan will catch it and complain.
> 
> I don't want to add mistakes on mistakes. I guess that you are talking of the 
> same fix you wrote above and that "return le16_to_cpu(data);" is correct.
> Am I interpreting your words in the correct way?
>  

In the original code the last two bytes of "data" were uninitialized.
KASan will spot this as a bug, but it doesn't affect runtime because we
mask away those bytes anyway.

> > >  }
> > >  
> > >  u32 rtw_read32(struct adapter *adapter, u32 addr)
> > >  {
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > > +	struct io_priv *io_priv = &adapter->iopriv;
> > > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > > +	u16 address = addr & 0xffff;
> > >  	__le32 data;
> > >  
> > > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, 
> REALTEK_USB_VENQT_READ);
> > > +	usbctrl_vendorreq(intfhdl, address, &data, 4, 
> REALTEK_USB_VENQT_READ);
> > >  
> > >  	return le32_to_cpu(data);
> > >  }
> > >  
> > >  int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
> > >  {
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > > +	struct io_priv *io_priv = &adapter->iopriv;
> > > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > > +	u16 address = addr & 0xffff;
> > >  	int ret;
> > >  
> > > -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, 
> REALTEK_USB_VENQT_WRITE);
> > > +	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, 
> REALTEK_USB_VENQT_WRITE);
> > >  
> > >  	return RTW_STATUS_CODE(ret);
> > >  }
> > >  
> > >  int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
> > >  {
> > > -	struct io_priv *pio_priv = &adapter->iopriv;
> > > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > > -	__le32 data = cpu_to_le32(val & 0x0000ffff);
> > > +	struct io_priv *io_priv = &adapter->iopriv;
> > > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > > +	__le16 data = cpu_to_le16(val);
> > 
> > This is the other interesting change.  I think the original code works
> > though.
> 
> Here too, I'm a bit confused... Do yo prefer the original code or you're 
> saying that, although the original code works fine, I made the correct choice 
> in changing it? Can you please confirm?
> 

Yeah.  The original code was buggy but it still worked fine.  Ideally
this kind of logic fix would be in a separate patch from the other
"rename a variable" changes.

regards,
dan carpenter

