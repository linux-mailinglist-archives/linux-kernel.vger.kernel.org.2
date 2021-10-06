Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F54239C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhJFIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:31:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24756 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237551AbhJFIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:31:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1967FC9E002190;
        Wed, 6 Oct 2021 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WWRoMQ8zhTaXom/z2uhkObyUuEKE4LiEirH3VhZ7Oto=;
 b=qOqFeI2TzMljk4P+1EKbWg0+52/OyKZavap88cifPygSXBUZul24RNk4FB+quGrRb/cp
 LLSuBdg+5ywXib9z+GicShneGDcFYNgb7QyfMIINkINSIETD04FkdOujoJgA1a90669N
 Qb5cU1VSAX6bL+UB2naYWH7J6hU/rFBPWFl/3P5jmD5bbFgKELlH4ojEW/asKjPG+GDF
 EgEh0Al0DdVjIYuT5tp7TGPSVpsqvFiJA16hGX3fSMUAnw96dEGqzewMMTR/SEW8uGmt
 nuag4ykW5VXylH8t/i0suSAVj8Vv2VeWBOAJgmYXa0d35zhnpkAAUQB8lnFXJzLxmjct NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3yn198e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:29:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19689xON141998;
        Wed, 6 Oct 2021 08:29:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 3bev7ugrng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGbIFWRNswtGsBJchSxlXX3lBk/OjEkTJiM315c0V/AEzfLBNRsB1ChBKIGutfqonTbh8H7DlwrXvIS0QLsLt28mJyU9q/CalT9PjVwkdasDKvFCxSPRoRXsw34MHoiEEjNpnKI2+wLt+PUVZGS3QS3S8fCUbfH+fBV5ZwXJgUQosl0irUFcrSvy9oyufzZ4U1uQ3GNqBHrADfkFBhet60gWQ0e0xXYdhO6/xIsIy3TUfSfZLkVSKyLa2hXwp6iAc9wwJIOVph/nhoNCku3vcMCL/tHfzGb21kEtda3LXG6YkWN6V7zo514TN8j0qnE21NGbdJMh8s+U6SnactynYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWRoMQ8zhTaXom/z2uhkObyUuEKE4LiEirH3VhZ7Oto=;
 b=kqI90n3079zw9dmWxDV75zvv5Q55b5/rRYGjRCPZtIuNXn1woQeybOjCyIKmQQ+Izp/S9w9TsBqPFpmg93ivLqrJcf52uXv4mT4f96me4FJkUT5vjR7cThQ+p8+FppKp+tRLiyaxXiKKtpmDt1Cjwj7mSOxMRZCTe781OfwR9XQXix31F3MMIQdJDDYC0RmY7VKWqg6rYBz0PWRVhJJWgMFpMFqxyvdDuFQOtuhxDSPrrE71Dn9Rcn/72pAYw4kKt4pgvwkxEvVpsg+gKOE1Fm1Z+EMskdaF3V/YqGvMhAUx2M1odzhPVqTuqMV++LsIcehC+u8m7fpLMDHMoMgjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWRoMQ8zhTaXom/z2uhkObyUuEKE4LiEirH3VhZ7Oto=;
 b=rcewUYhO4rf2js5uWAaokNdSRXSEBn99nGrA4EkcQGNV+kGunUz7lIMJB/UI0CAc5ov2V7LJ4b11a50H6kkfjPDcg10sC8cylap5sMOJ95EKKA4MR5Ls91zkRHSI1DYUxQvFcgjABgzB0tIUeJRQhkJwa01MuOMXLl7PRrCVEPg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 08:29:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:29:22 +0000
Date:   Wed, 6 Oct 2021 11:29:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: Re: [PATCH 3/4] clk: ralink: make system controller node a reset
 provider
Message-ID: <20211006082903.GZ2048@kadam>
References: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
 <20211006061204.2854-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006061204.2854-4-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de7eb57-39d1-4b96-713e-08d988a365b8
X-MS-TrafficTypeDiagnostic: CO6PR10MB5789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5789E56AA806559689856D428EB09@CO6PR10MB5789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4/mJwaH/EtWORwTU/2ObEk1u39c8qUHb/W8sBsYolxq9lURsko6yQCOo/5EOdtWHWGoRK6D+ZYUeok0YI84PLt5jEE2bEsWwAJzexLIYosLwcuR185opoxYjHIj9iHNeIMHGD6n5uwKwGgc6+P6Lnq5USBGROp7ftOqNmAUnYqCWPbErTljnREzYrAPkh+MgPxGHyFsts3rwDYyruUPOywwYeXQSRmZ0b9q9XThXeGCMBz5ExN0kZQr+zGcI4g4XeFnIc44tEtF3M2wUU663nSaA5ko9oL34G30rRnHkGKbVK+B+vQR/NYTJV2gNHvTkPt58qttjEK4DxG+jqQPr/eqInYYJWgUkLXAhvDv17u3ZXU5il2RHfYYJuqFIeS34xOKZKKwaF+AWrHyZnFHO7WkYdlhQ132M+PQ0bVNSp96mYHFey05u6KfixWp9XNr0VNGiXWqXYkvIfJVr6HSD9rgqMTss3l9ICGgS4Dn9BohN1npkmLTBtlPyKyt0aCsl2GFyJ4UDePZnRqWPypHYCoAyydq9R2taHyaURiaONMKe5GWrEjJpkgbOmdeAwer+Jby8Ra+vHpGflKd16kmLRD2UxpK13plNff+Ui5l0WGvU02G9lI+i2ZfPAE8VzxDWJfjrajEzc5OXFJqapIMLE+2Jkp+BaKWszCismHvsGn/wxZpHAUX9Lpq7peawvn0edH9LkmlF6A4hSLpaPFbjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38100700002)(33716001)(66476007)(6496006)(66556008)(508600001)(66946007)(9576002)(6916009)(44832011)(38350700002)(33656002)(2906002)(6666004)(83380400001)(9686003)(8676002)(7416002)(5660300002)(186003)(956004)(52116002)(316002)(26005)(55016002)(4326008)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fk+VThJnp1xV70vd1AurqBuclylZKblmuf76lDH6SOM3bk3M6YRF/ir3GZAT?=
 =?us-ascii?Q?wDzI8m+EvWWqzTPH0jdnA79jJmGH0pFSqlj44fi5kTurdFMvGZcFBCsftwmd?=
 =?us-ascii?Q?DEor9di+bXPwAj6YpwcXZfOinxkfpIJDKgracRCiIJQuNu2FtnivrUhxXGMs?=
 =?us-ascii?Q?RpPpDLuxssQ2CsUKpy39797pakcIf2T8f6C9WGtqzzyTnpbFKJdwG4TYrAnc?=
 =?us-ascii?Q?kpXrPu9lNyw2bGk/1O4XTEDdzf1HxUCFYhM95b3VarrSCXTc6Va81GjcsmyO?=
 =?us-ascii?Q?sC/35f08AeCuhOHDv1XRkkkSQhroqNE5NfR/4oJawxGiXWFuQWrKEcxY1zSj?=
 =?us-ascii?Q?WcAZsfCLLPZy4DRHXf2IY8flSGd9maSuR2wvF7Kn/T+vfOZGmHVkCbsVL1EZ?=
 =?us-ascii?Q?RComdMpo6BFA6iZ53zUc/+wtyjnEO24wn7q/SzxeuueVEKoefsQ4dlkYwblI?=
 =?us-ascii?Q?7ilmwhRJ6mhqruAIBaAab5W5EQPkPBOx6COsq+azJaKDiFhLmXagLjJ7tl+S?=
 =?us-ascii?Q?epATPMKn8euY2hzlP+M7AeKQMHb8dfUOHYiyqJDhABO9Zy5iH4zibvfa9ZaL?=
 =?us-ascii?Q?knLaxMbASW7AF45quAFPgbpS3Roxr6/t0ythuejOAQFvPIFE8y05Sm9VMgQx?=
 =?us-ascii?Q?hPKV0vlffk6WwGddFvwA5iAfGveuh8DQZTPB8GDu1rsZ5f3A322Uh3BMsUWw?=
 =?us-ascii?Q?ePGHkgeq+f93ZvmJulJ+OnnVN2ysqVLN0ahPWXTUsbtdwm9M18XAsCQF1zKK?=
 =?us-ascii?Q?hE8ASF56XhBrA7yWY2QX19HZfgvBIp3Dw8gSZZWimplUw1EqckJH97xgyHfp?=
 =?us-ascii?Q?zJWOeHjuzfWTeK0jfGmcR4RsrBYrERIVO+fxiL0l6wUvbs6zqA7o3SxmcH3C?=
 =?us-ascii?Q?VEeTYyH0CpoZQ+4z33oSHNkxnE4ccyx191RbVr1U1lDuDk3GoZZD2J8Uip7o?=
 =?us-ascii?Q?Yv945YWOKnLdNlf0URYviJl9vYRf+rcKYf7iYKoT4HN5G/84KxD4k7gsB2nz?=
 =?us-ascii?Q?0Y2B794kTm3qb42MxZf2ujYQQh7WYObdELBcm2CarkE6vjzGzrVvflejGmns?=
 =?us-ascii?Q?0ClROYs4BsoX/W9MJmcHtF/1r/cwRpl93NFcTKAfMyEgBdjgtfKFk4kEYGXn?=
 =?us-ascii?Q?y/K6Dpj0LEX21uZ4p6KvweXxWdffBjWLi3cwpC4zWmL2ODhc+BDFHXvMTmZw?=
 =?us-ascii?Q?FnRpntEF+2E16b/TuLH1FTMnuIKhzhyGs6w7ATQNP0PD6NfMejcSCp5T+i20?=
 =?us-ascii?Q?c9Lk47etQqYXPOMhZBUlpbeTHADvJWAGQwYK5AR1HyA4t/BIRzbBheSvhAdr?=
 =?us-ascii?Q?0OvIYNqd0lzZxlm1ndWgW+Gt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de7eb57-39d1-4b96-713e-08d988a365b8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:29:22.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw4iSX+F1cuSAS0IpzhA23qIOdpQmHCaTXslS2a1sx5JLnVI32aX/T6cHeIbUibxKOufbMm9/WUZqt6NE2tbudZXsC2h1Z1j7GXeNSV3Dco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060052
X-Proofpoint-ORIG-GUID: TWToqgPkw8zbw3ONeb_I--p-t8VB-Fwc
X-Proofpoint-GUID: TWToqgPkw8zbw3ONeb_I--p-t8VB-Fwc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:12:03AM +0200, Sergio Paracuellos wrote:
> @@ -398,6 +401,76 @@ static void __init mt7621_clk_init(struct device_node *node)
>  }
>  CLK_OF_DECLARE_DRIVER(mt7621_clk, "mediatek,mt7621-sysc", mt7621_clk_init);
>  
> +struct mt7621_rst {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *sysc;
> +};
> +
> +static inline struct mt7621_rst *to_mt7621_rst(struct reset_controller_dev *dev)

No need to mark this as inline.  The compiler should do it automatically
or it will ignore the inline.

> +{
> +	return container_of(dev, struct mt7621_rst, rcdev);
> +}
> +
> +static int mt7621_assert_device(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct mt7621_rst *data = to_mt7621_rst(rcdev);
> +	struct regmap *sysc = data->sysc;
> +
> +	if (id == MT7621_RST_SYS)
> +		return -1;

Please, return proper error codes.

> +
> +	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
> +}
> +
> +static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct mt7621_rst *data = to_mt7621_rst(rcdev);
> +	struct regmap *sysc = data->sysc;
> +
> +	if (id == MT7621_RST_SYS)
> +		return -1;

Here too.

> +
> +	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
> +}
> +
> +static int mt7621_reset_device(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	int ret;
> +
> +	ret = mt7621_assert_device(rcdev, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mt7621_deassert_device(rcdev, id);
> +}
> +
> +static const struct reset_control_ops reset_ops = {
> +	.reset = mt7621_reset_device,
> +	.assert = mt7621_assert_device,
> +	.deassert = mt7621_deassert_device
> +};
> +
> +static int mt7621_reset_init(struct device *dev, struct regmap *sysc)
> +{
> +	struct mt7621_rst *rst_data;
> +
> +	rst_data = kzalloc(sizeof(*rst_data), GFP_KERNEL);


Can we use devm_ to allocate this or do we need to clean up if
devm_reset_controller_register() fails?  Also a free in the release
function I suppose.  (Please, use devm_).


> +	if (!rst_data)
> +		return -ENOMEM;
> +
> +	rst_data->sysc = sysc;
> +	rst_data->rcdev.ops = &reset_ops;
> +	rst_data->rcdev.owner = THIS_MODULE;
> +	rst_data->rcdev.nr_resets = 32;
> +	rst_data->rcdev.of_reset_n_cells = 1;
> +	rst_data->rcdev.of_node = dev_of_node(dev);
> +
> +	return devm_reset_controller_register(dev, &rst_data->rcdev);
> +}


regards,
dan carpenter

