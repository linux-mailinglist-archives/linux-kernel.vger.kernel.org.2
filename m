Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A504440D8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhIPLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:38:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40942 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236774AbhIPLiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:38:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBR2C9008819;
        Thu, 16 Sep 2021 11:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zhcnw2aubgY/sivMIePP56Q9Uv7SrtNOCGDr0Kumbto=;
 b=JVgHq3MdT8k4fUauxJYplXNC7PD+qML+YHmUTW4YZW6Us82ihkb6yYFlTDOvTRTHfzGY
 ssBOD6n0djLj6uInwHxveftYa70q2q3RjT2Zv+u7tI7znY5979aZWu3FwZPD1kNCuWwR
 RJCLQJz4h7cebuZbsxx9msgMCB9S2Ld2sgQIvWgnOyaNp4Ln/yDXYqLPzqaWMeuGnLW4
 pdhC6z+B7pI5m3INFRgaRoNRbOlXByPLHEK8BxXRtbEW9Tyd/Hw0a2WsghYkB6CE1UWU
 Gxkm97V3WP2Am/9xwqIZW/bUIVythHmeHKiolfGGf3h+yLJ0qK2us3disdQ5h6vAJMcH Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=zhcnw2aubgY/sivMIePP56Q9Uv7SrtNOCGDr0Kumbto=;
 b=J42BxP/lqbNBZMUxkAxGPNqXqIdXJX8dzXQjSfC8wCMbhiZ3Y2RPlN9FZUSCOLNKthFL
 kx+we4JIzqqm5JQ5nid57QTgemwZL3uddoyFZFBJABc0wR+Lu33Fr8Kjd9TSfWvOTTuL
 bwe8kaMqQ9PMILQUhXezS9cmz7RJpEmXdyjLqnwObXOPH2sG/P8zzxhMMkSkveebKCK6
 FQBHe+CG7Ou6l0XdQDmYuv61iDbLo5EKYY19NdUpgrtJgRa9KU1yzA0DZB1LM/6wQSGO
 jlDcYf4h3xTeqq/gyHeQm74IbwGhpexmEXOphzbgvohrLHV4Eg/w2X1TqLIJAeHHu1ox 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3vj11e3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 11:36:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GBVEM5145204;
        Thu, 16 Sep 2021 11:36:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3b0hjy2s7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 11:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb2fScf5mZRvt4TmLc1KBJ+tts5KebWkRihSnuSdmS9nXtFBxYSGSkzcN8m1eVVuVduNoCKF6BFLenYsJzs4tDr2ip7Q5ozNCg39biKsgJGrFwhZc883C+raxegaR9l73xLsnv5zyNGavf1puIThmvzIhB8EsaPWH7YDejpUjwIslHJLY+cieG701LJOXK/yyzUhB8IqJLWQ92AlwMZUd24DeE7YBX7yMGgpKc8Y/IpDYVe2g0bBrwF01t1KAlljKLFN22ZPaKayz8LHlYl4H9wBAKvesxEsmIhCOEMebzBc9/USK5GJV+gYDaEoc1+tvMqC7NKkYKRB3BCCM2audA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zhcnw2aubgY/sivMIePP56Q9Uv7SrtNOCGDr0Kumbto=;
 b=YdcB2NylQmcYFDnPULrVluVb34+aMptvsnn24oyXATt9KJEbKXo+m5kqYsujONtIATM3UvOTM/vDm9VVzxu6Av3u3AQzWuy/hi/KGH4H3pC6+HiQlXSjuYsRcOoMJ/IhnhJBivzxNyoZ/1EAOdiB2XAU08UcRGzfLu7wILSWF3oN1bEGTeToXeU87bt8JaiJuxL9mrwuUpk8Ct2QEBER3U8xIVADdlbVuOSZvxdaTO2W0P5fh5V7yRnDqKOnqAHz4/a31gEhG9PRf4QQ+wC4lzcULC76CkA6myLNv7XMNh46STmDQDA0ZdXyu23VxG4FS6LHemXbE8PcI/esdZX4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhcnw2aubgY/sivMIePP56Q9Uv7SrtNOCGDr0Kumbto=;
 b=rmvoJ0dS0EVqKd1XgKfMi/w/ZUQ3c79DMYrZzfGF40F3bIp4m8v9NluXzb6dPgqePotn7iOSOZCCOgyI/qwQ9R36DGC1NIPGUnPGTzf3wrUrxOeGhk2K3rC+oqct9kSbSAMfWLnoZo0zuoA4kg17/hk9Kt6/q1bBgF0ydHdEx58=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1943.namprd10.prod.outlook.com
 (2603:10b6:903:11a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 11:36:24 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba%7]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 11:36:24 +0000
Date:   Thu, 16 Sep 2021 14:36:06 +0300
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
Message-ID: <20210916113606.GJ2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
 <20210915211103.18001-17-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915211103.18001-17-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 16 Sep 2021 11:36:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 859c409c-0880-4db5-66a3-08d97906369f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB19434ED1093BDC4E07E12D178EDC9@CY4PR10MB1943.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2PqKv/nibWSs+9x7KOE83/ZGkbY8W8MdHmzLMZaF/dDNohcFBXWCA7y4EywsyJMtBu039ipgmr1Ppa1wjVj6/55CwX6Ks4vVS+3BQCN0jGCqTXPm0j+G5EUYjcd3H5wYhdiZjW7U1sVMOrRguPoqHAvrnvHGtsnj43IHDr6Te59kGmkSbRMYu8qj+CWLhNEk7rYWB9Ehe94wzHZEfWUZiDkLbGbqwecEqzX6fxtEQefaSvEDQr9VKR9jPkkK3uyRTiEMUgvo12yL8GGZaeDcDzTsG8mbq1LrZGGvGXXFWNabWol5l/OD+ZeKnDCI+4TdTJDV/ezlhPME1cf9zt0bbzFCwt/k9hRzrEdlfvf07bI1eCMn2IX0862pGsHS84ZZbAzifwdIqhxVnV4vGI9VsVQTEa/qoqAPrHjezQ3jsqOgwVgY9t5jHFCwlBeOUc81XfXU12Zgpv0gWlnRxj1dARfS9XXz9as1gVwMtjBfyX+JxhFhVQg2/hBpyo8I9P15mZtcXWB7y+ljW6ahmc4c/D7AzV5GetE5jYRqjtz18rYq+8aHMhPyoqLmMA9RCCb6+cFgsrY6QIcXzzuY8xC1keKRSXZEohh0gDhgsSS9pvEdIOOJAyOVUMpZJ12ZTRd777S93NPZ9LfVmqsbmXqDJ3VOlJSD4mMJSRA61V8B4hYRv51m8C+KYLNX7ck5j5EncAtV95IqkOmaBG0jP7/mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(38100700002)(6916009)(8676002)(26005)(66556008)(86362001)(9686003)(55016002)(54906003)(66476007)(38350700002)(66946007)(316002)(956004)(8936002)(186003)(6496006)(33656002)(52116002)(5660300002)(83380400001)(478600001)(9576002)(1076003)(4326008)(44832011)(6666004)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ufHdg6gRIxXJKa7FdRA0aVv/qm6lKmro6CzGmqZ5ifNi55SLdmiBaqwFCXYC?=
 =?us-ascii?Q?GsM8WyEjvewSmFqRk25W3KtkkIYQwp7gOKgl4/1FZgaz/nNECz0Tgy8uIoLV?=
 =?us-ascii?Q?H1cRDCC8n+eVDD3bguDtgz3w55jmbku0DYbWue9Y4VQhV/+UWyMNQ0WHmWdC?=
 =?us-ascii?Q?IcXSYfYNq5Q+A0t5sibrwSLMIvJNeXRyJUU4xHqDH1DbFogbmCNnDlVJDFv1?=
 =?us-ascii?Q?csZDFQNerVwXRXfFzgVYfBG0rAIcGMBPOpCQes2p0cqlzmrg6nmKh5L7NfBF?=
 =?us-ascii?Q?oClPz+7Q/YK1zUNbjqKu3ydh4G1T+t4kmyPu3l7frV2hPajmDYgmL6UO3Fu5?=
 =?us-ascii?Q?9K0Ij2YnedekycJQCTdYIHwtYn/gd8tZqc6L5aLTBn7BkFcfgz/sG3md1u60?=
 =?us-ascii?Q?qF+shrEnHq1dYm7tS91BomxoeetTvr1ijUbTO5vEfq3GH9CKsRAvCeoeF273?=
 =?us-ascii?Q?wU9XfoCBDrH++SP79MjkbwRMQs4J2/UqOfXm9VFQGryJsxtPWj5AE/kjUsWd?=
 =?us-ascii?Q?1b8n1ONq3Xf1LbT0u1KB2sT4xas82vay8a9Q+uZTnMorWY9PtcQ3IVpH/W3d?=
 =?us-ascii?Q?1WNxyq75MRAuGYIyJEDqjnSmMgK3i1MRGyzJori4jrXEKWufU+Ewv6GoGZK6?=
 =?us-ascii?Q?XUrN9cYlIiEiXXBbs7ws5ySmJqI2cI0VICM+05PZ0EsmHwm/5Iv373vZ9rfn?=
 =?us-ascii?Q?67ZAw56DH7fwPRQgYThPaPpGjIulvURq7mUshZnSFPUowwbsYc/IxAku58lF?=
 =?us-ascii?Q?vkoc1PQZSst0NdnxyOhbq1/Gwk0M+InTDut0DBrSAfPSPJ9SFCD+7uotqn+d?=
 =?us-ascii?Q?yBiEroXW/yaWQXEvOU3yrZHA9ZF1cdDswdgOiOmbWucqf580ovaXt0FCjOSw?=
 =?us-ascii?Q?hRUdEgQyq5reltgSAVUJVtpEjQGaT0orpwyapSbXoqAX2M/7PR8GTFp7n1M7?=
 =?us-ascii?Q?umsJMm+Qe812BihZJ2mu0ZSp8n0MWp0YGVu+l1TVWB6HlpsHdcUt9iVtXKGA?=
 =?us-ascii?Q?X9bLDTTftER7yglNwM6bZO8iAYh0vWYbYkFdbMk1jtIvDqlSIYDTOfVhT8QX?=
 =?us-ascii?Q?Llht8xCMROo/ugpyhTjxuklWGOEt6TdtFFrfRgTrLXT4nQQG1NBQ06HPK2PC?=
 =?us-ascii?Q?iEgXhEVy9ppSviCbxnfAZ1QZRTngDpV8PT+GPx63WOX38T5b+lbdqNxXSGMh?=
 =?us-ascii?Q?Ydep0L+v99tnnAFHjrAZWxZosrZG7NXGRc9eOEEqYcYmqrcC/qtCmSWrA29Q?=
 =?us-ascii?Q?WrfErpEenIm6g4pYBThHle7GGkP6VTRz6uVl7Fi0ZqQQQuEfIuePbfwSqWli?=
 =?us-ascii?Q?ryRn1yHelTVx4zg2PjHBooAg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859c409c-0880-4db5-66a3-08d97906369f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 11:36:24.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMJI8LI9Q8lWmPzC/1EMNZPT234NohQtoiJCjczZwDX7hei1Qve5PEWfq41Dni1WC9GAW/HCC1fE5LIZk+grTOlqrdJgWe9jK+42qeDD50M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1943
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160073
X-Proofpoint-ORIG-GUID: fGqWx0sNZ-DqykVbYd6S2bA25xzhGS0D
X-Proofpoint-GUID: fGqWx0sNZ-DqykVbYd6S2bA25xzhGS0D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:11:00PM +0200, Fabio M. De Francesco wrote:
> Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in usb_ops_linux.c.
> 

It would be good to know what you did more specifically.

1) Rename variables:
	pio_priv => io_priv
	pintfhdl => intfhdl
	wvalue => address.
2) Remove unnecessary casts.
3) Fix types.  Use __le16 instead of __le32.

The last one is a small KASan bug fix.  So good job on that.

> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 68 ++++++++++-----------
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 2098ce935dc0..d87da84eca07 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -91,91 +91,91 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  
>  u8 rtw_read8(struct adapter *adapter, u32 addr)
>  {
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> -	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	struct io_priv *io_priv = &adapter->iopriv;
> +	struct intf_hdl *intfhdl = &io_priv->intf;
> +	u16 address = addr & 0xffff;
>  	u8 data;
> -

Deleting this line introduces a checkpatch warning.

> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);
>  
>  	return data;
>  }
>  
>  u16 rtw_read16(struct adapter *adapter, u32 addr)
>  {
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> -	u16 wvalue = (u16)(addr & 0x0000ffff);
> -	__le32 data;
> +	struct io_priv *io_priv = &adapter->iopriv;
> +	struct intf_hdl *intfhdl = &io_priv->intf;
> +	u16 address = addr & 0xffff;
> +	__le16 data;
>  
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_READ);
>  
> -	return (u16)(le32_to_cpu(data) & 0xffff);
> +	return le16_to_cpu(data);

The last two bytes of "data" are not initialized.  I do not think that
will cause a bug on either endian type of system during runtime but I
this that KASan will catch it and complain.

>  }
>  
>  u32 rtw_read32(struct adapter *adapter, u32 addr)
>  {
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> -	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	struct io_priv *io_priv = &adapter->iopriv;
> +	struct intf_hdl *intfhdl = &io_priv->intf;
> +	u16 address = addr & 0xffff;
>  	__le32 data;
>  
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
>  
>  	return le32_to_cpu(data);
>  }
>  
>  int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
>  {
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> -	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	struct io_priv *io_priv = &adapter->iopriv;
> +	struct intf_hdl *intfhdl = &io_priv->intf;
> +	u16 address = addr & 0xffff;
>  	int ret;
>  
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
> +	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, REALTEK_USB_VENQT_WRITE);
>  
>  	return RTW_STATUS_CODE(ret);
>  }
>  
>  int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
>  {
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> -	u16 wvalue = (u16)(addr & 0x0000ffff);
> -	__le32 data = cpu_to_le32(val & 0x0000ffff);
> +	struct io_priv *io_priv = &adapter->iopriv;
> +	struct intf_hdl *intfhdl = &io_priv->intf;
> +	__le16 data = cpu_to_le16(val);

This is the other interesting change.  I think the original code works
though.

> +	u16 address = addr & 0xffff;
>  	int ret;
>  
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
> +	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_WRITE);
>  
>  	return RTW_STATUS_CODE(ret);
>  }

regards,
dan carpenter

