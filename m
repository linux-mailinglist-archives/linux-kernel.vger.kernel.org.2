Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C73E3A7A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFOJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:30:08 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:11007
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230242AbhFOJaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:30:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCY4+hHibpDcH3Mg4sEGuSGcPAV99BNam1Ukvu/t26j2ZjeJMVYg9CMD/7Cx5+SXfo92d+1lBwpCMDOq+NPcLvmcBxsJnoikyHvw9NzKMc2kEhcClC7b0x1oEoC4cS+mUxP0sHeWLVxvLB10p2VNsgsql8JgyW0NXpwvSMVx2ogCkhdfpoptmDpCglIVKxt5kSkqWp5SbdG5izahFdDkXElSmlN8DBZBHyt0uPS0V9oLn7lPlw5Rh39UzIrSmDJDNTpycXQM0+wgw17917SEMhD9fVBuhGmILz0ZLEc/htWaapQQjYy5oxi352wqNRydYF2iLx1Mzff4/56q0V3Naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOEg17spWIvHIQbQy4x+h1h4J0ThlKRSudk2jbRibtY=;
 b=DZrZYVENqP3ok8XMD+MW8GAjjbplWMnKXUd5VmN/D5FroDUwi46irw3ZXN26aFI3Eisp6uL6DSmxR8CO5Uh8mXWqfz5udFOV0m5Zx6WZEjg3cRnj/5j4g3njcB5XW0E6qTitYhGx235RHPiqjqNY46NrrMXRDuSyF9Ftio5+J7I7Us4EEI7wdn0Pc+zGRqreYXNWYa0OgstPcgVLMZMdUZsl95gSBJKDXgf5P8PJ/ZBz2STootXxOIwsCSWtLHIH1SLHJM2LLPuDkCWCvzsHht1PVDD9QrQ0uo7nwr3BKjpkwaYhd1Ox6ypJMHfXQ4hVl9C3mMnL29uoa0ibDlmPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOEg17spWIvHIQbQy4x+h1h4J0ThlKRSudk2jbRibtY=;
 b=y0WARRUB87fmNaG98bvfwHO6U0JIPUJxRy8H47w718HU1fE4LIVZp/coz4S6M1cdvwQGNbW6jxX1+2XjFIH3TrCNq6tPrEl8Cvx1AMjFM9Nc5TdO6HRESg064nOZGiGzFVUhFzlog0vUsNSasG/K9MHSasU4vLEjd91nwnLpFlU=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM8PR07MB8060.eurprd07.prod.outlook.com (2603:10a6:20b:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.13; Tue, 15 Jun
 2021 09:27:59 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::80f7:12a2:fbff:6a9d]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::80f7:12a2:fbff:6a9d%4]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 09:27:59 +0000
Subject: Re: [PATCH v2] mtd: mtd_blkdevs: Get|Put mtd_device in
 add|del_mtd_blktrans
To:     Zhihao Cheng <chengzhihao1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, computersforpeace@gmail.com,
        maximlevitsky@gmail.com, David.Woodhouse@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
References: <20210615091302.3428611-1-chengzhihao1@huawei.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <13509562-158e-f883-5a70-094126dca993@nokia.com>
Date:   Tue, 15 Jun 2021 11:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210615091302.3428611-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: AM3PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:207:5::28) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.166) by AM3PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:207:5::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 09:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ab32587-972a-485e-a815-08d92fdfdd7c
X-MS-TrafficTypeDiagnostic: AM8PR07MB8060:
X-Microsoft-Antispam-PRVS: <AM8PR07MB806028CA0041356FBA02EA2688309@AM8PR07MB8060.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QM+nDIhdgrdhXtsKt5FXqID7qqeVFykQ1ayOov6LtaGB67L0dATQVqi/CoS+PluuWPYCsm8Ho5be5k3dvPFJzirFrRcYrrcxcKsT3C9wwPAINECRdX62W4RDl/LpgfMXcqArH8tUSSu4jbDcI1awyGCyvcfoHwDGuz0Y0X2/+n2eFofEO/GDdbWyZSbpu/Dsyb3iSYza6qSWwHzc9EhlxiPwd/yBlGywe7GBnHEU6u3UcLf9cjv841DeS6FZ1l7iPwHP9dleWPSpY8J3/3bkHxjpXjfsSFCQI7xxOW14IHgAJ3H1gJBGgSWboH7p1o7430U06bwHF1SmxClDtcP6u6Bum1Fm4jcnOl6jDFxvU+FXf0qtK2w/VJk/7cjAPIhjMEodJsh23wj3aIFb2gqWzsB0STLdGRJqXaF47umCidifJ4y/lNKCLavdHGwENQUNLBPf4NHmZQWM4wuV+D/sPQSqmU1ISPeNSqnTHY2zrw0VZNb5Fu9dc4HknZUwLNBXYCIcyIMJ4qi+QqzrAaGVBdY6TV3l/QfPBkP8aNk11HE7i0wzGXN1wiEb2Ts0JDm6icY5zp6kULS+XMdUv8UdNCH+gw/kRTp48Z7lHeMla4VAokq25qe7yTZ2r2YFMTHq3ME5bdsGRmwtLn1P8fX2RgBxXZY1RStvo6jkKgKlLcwADFnmSaQyM1L4un3NcdOMGSMt1Skc/C/LkSAh8YZWbkIJrG2TZ1Tba7Ru9cZSRPBAi1Qdf3FcuLZ8IiaN0+ONgdJxxy60zNDsM6fTzLZRpeCgFM9RCCDFDBO5XXiG5To=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(31696002)(52116002)(478600001)(86362001)(16526019)(6486002)(31686004)(186003)(6512007)(26005)(53546011)(6506007)(83380400001)(44832011)(956004)(2616005)(4326008)(316002)(36756003)(6666004)(38100700002)(38350700002)(66556008)(66476007)(8676002)(8936002)(66946007)(2906002)(7416002)(5660300002)(43740500002)(45980500001)(44473003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0EvUkhCbThLZGZHMlhBZ0VVcmNTeUc1M3N4cnlUSk1KdS95WVh1TzdiL0Fv?=
 =?utf-8?B?dW5ocXZ3UUUxR05xSmNvZnI5MXRaVE1pR1l1R0E5NE1ITjJJSlhQajJjSGVE?=
 =?utf-8?B?WTYxOGsxTHptNTB6dnh6NnFhUWkvaXByei92ZHp1VU5zeERnSkZzQm5QQVd4?=
 =?utf-8?B?ZDFTMlFKcnI4RFFDNzhHb2ZvSEVRTFIyek90OENQVmpsc1JGeWV4WDRtQUhx?=
 =?utf-8?B?b1pVak5rVU9KZW0ySnhLS1lXYytoOEtYN1J4MEk0Smo1SGpMVnhvVEdHM01r?=
 =?utf-8?B?VWxWVlBrOFI3WmdWQjdvU1hOUTN1Q2dCa0Q3bFVCbDhmWTFteUd0aVh5bHc5?=
 =?utf-8?B?UytVUVJlclZaZHhUdURUUUxJcitOTFpIWnVwN1pxdmdqNjNUNXYyK3NvUy9W?=
 =?utf-8?B?S1U5U3FzUmVKbjRjUWlUL2xYbEpVWHoreURmbFJ2QTVQSnVhVllJVUhmQ01s?=
 =?utf-8?B?NE5vUDVKelErTmY4di9uLzV1MjRXN1grWEJVdHFqbHJHTnlCVXN3V01tWkpo?=
 =?utf-8?B?R1JiaHdXRU9ZMGtzMmhHNWlxaVpOSDZYRWpRbXpQWVZDbmIzSjBvRmNsM1c5?=
 =?utf-8?B?MHhubFVXY3pEZXFCanphVCsxTlYzVWFwbkM5ejAvYU12dldPaC9MZjhOY215?=
 =?utf-8?B?bmZtelJabTEzSE9ndWZpZStMZjVra2RXb2xkM2xjSmFWQWhuT1lmSUNsaEtI?=
 =?utf-8?B?YlNLNU9kbGNVZnpGR2l2cENreW8wSWlQbWQrNGFiZDZCVXdFRW5uZU5UNDhY?=
 =?utf-8?B?bEVLRXpvTVlDamx2QWErZjRSeFBXdHVjQmsyTzJYV2tSblVQTWlNcTJrdTBZ?=
 =?utf-8?B?blZaUU1WSkZOak5OOW43MHN3eGRHajJKRU5IdFVQTUI1TE95UGZvekdMMDZV?=
 =?utf-8?B?cmVqeUdYRGhCaWNVNHlGZ2pZN3c4YmpmVjA1NkxkNGtVaVhUaGRpUnZsdENL?=
 =?utf-8?B?RlVVSXB4dFZDeHJEd0Z3TmtiQ21DWThvRmJ4dFN2WVQxNkQybWgxTVBKc1F1?=
 =?utf-8?B?L1NmWHNNd0orTnp2MjNmbTZlZHlUa1F4dUc0OHo1N0VLNXZLK25FaVljMnF5?=
 =?utf-8?B?QUdKYmJ0OUMycXZXZXpMSUVZUXlROE5DcVpQSnB3NHliSTE5QzZZWlFHNzFN?=
 =?utf-8?B?ZUJJUEMwRCtnM2gvVCtoUDVOcmQyT2cwa2QzdWFIdzBSdWM5Sy9wbkVVNUNF?=
 =?utf-8?B?Y3YvbjF5bHo2NWZ5R3h5eTlHYmxwV0NDdkpidWJwYUMwU1FCYi92Y09qZTZM?=
 =?utf-8?B?U2hxcmI5VU9FTFdMZld2eURuWllGa3Ywc1hrcjc1ZzNadnBaNVpRdDZ2VERH?=
 =?utf-8?B?SGFBa3loZmUwQU03Qkh6WHdONC9ZeEFiMUNkcnhYbWV4bUttWm96RGlTNFl3?=
 =?utf-8?B?c1BVc1lWdStyMjBJRE5yTDJTZmFxVXNMcWQ0YnhDbmNaVVVMUFFYcHRMRlRL?=
 =?utf-8?B?aTdMeGFrRmZZakZTdldJbnhOUWMzMzVjOUxRakgzdm5CQmhXTk9uenRqM0xD?=
 =?utf-8?B?S0FSRGlWMHU5L0hUZXRsYVhpeUxsbUxTbUVmSHVTN3QrSGlJaVZiVmxKYmJu?=
 =?utf-8?B?WjdmOVFGOGdKRmJTeFdpNEpQY3pSb3RXTDRGcUo4UFhGSnV4YXZ0ZEw0b3I4?=
 =?utf-8?B?YWIyMjliYmZ4RFIrcTJ2Z3BKZU1HSVpxTUtkQzB1QU41RTNYMXQ1RWNDSDlE?=
 =?utf-8?B?SWpSN21PQVk2Zk44aDFpWW1ZUUM2OEg5RDNWeXVhSExHa2dQRHR3TURIWk9B?=
 =?utf-8?Q?CHq9bEaWPtCFELGrupeFNGN5YKqcw+T0G2267Qg?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab32587-972a-485e-a815-08d92fdfdd7c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:27:59.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK6DE8bOpdBPDJyO/yXwLRu+xnExXvDLg2Ax/i/DNSQklbNIgo4M2C7P7EkpC54utLCD2kJFNCBq7R44wg/Q8rCQNkRV/p0bLyottn7iy68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15/06/2021 11:13, Zhihao Cheng wrote:
> There are two reasons to move mtd_device get|put operations into mtd
> blktrans adding/deleting:

...

> Fixes: 073db4a51ee43c ("mtd: fix: avoid race condition when ...")
> Fixes: 008c751ec78587 ("mtd: allow to unload the mtdtrans module if ...")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/mtd/mtd_blkdevs.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index fb8e12d590a1..19a2870a097a 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -209,7 +209,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>  	if (!dev)
>  		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
>  
> -	mutex_lock(&mtd_table_mutex);
>  	mutex_lock(&dev->lock);
>  
>  	if (dev->open)
> @@ -227,26 +226,18 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>  			goto error_put;
>  	}
>  
> -	ret = __get_mtd_device(dev->mtd);
> -	if (ret)
> -		goto error_release;
>  	dev->file_mode = mode;
>  
>  unlock:
>  	dev->open++;
>  	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>  	blktrans_dev_put(dev);
>  	return ret;
>  
> -error_release:
> -	if (dev->tr->release)
> -		dev->tr->release(dev);
>  error_put:
>  	module_put(dev->tr->owner);
>  	kref_put(&dev->ref, blktrans_dev_release);
>  	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>  	blktrans_dev_put(dev);
>  	return ret;
>  }
> @@ -258,7 +249,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
>  	if (!dev)
>  		return;
>  
> -	mutex_lock(&mtd_table_mutex);
>  	mutex_lock(&dev->lock);
>  
>  	if (--dev->open)
> @@ -267,14 +257,10 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
>  	kref_put(&dev->ref, blktrans_dev_release);
>  	module_put(dev->tr->owner);
>  
> -	if (dev->mtd) {
> -		if (dev->tr->release)
> -			dev->tr->release(dev);
> -		__put_mtd_device(dev->mtd);
> -	}
> +	if (dev->mtd && dev->tr->release)
> +		dev->tr->release(dev);
>  unlock:
>  	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>  	blktrans_dev_put(dev);
>  }
>  
> @@ -425,6 +411,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	}
>  
>  	gd->queue = new->rq;
> +	__get_mtd_device(new->mtd);
>  
>  	if (new->readonly)
>  		set_disk_ro(gd, 1);
> @@ -474,15 +461,15 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
>  	blk_mq_unquiesce_queue(old->rq);
>  	blk_mq_unfreeze_queue(old->rq);
>  
> -	/* If the device is currently open, tell trans driver to close it,
> -		then put mtd device, and don't touch it again */
> +	/* If the device is currently open, tell trans driver to close it */
>  	mutex_lock(&old->lock);
>  	if (old->open) {
>  		if (old->tr->release)
>  			old->tr->release(old);
> -		__put_mtd_device(old->mtd);
>  	}
> +	__put_mtd_device(old->mtd);
>  
> +	/* At that point, we don't touch the mtd anymore */
>  	old->mtd = NULL;
>  
>  	mutex_unlock(&old->lock);

-- 
Best regards,
Alexander Sverdlin.
