Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF33FB13B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhH3Gb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 02:31:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233322AbhH3GbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 02:31:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U5G753031577;
        Mon, 30 Aug 2021 06:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H2wBawX8f7JfynqmXfPuKBNrI04tj8AniVdtYtBtIHI=;
 b=w/MqjmmKmzmAvmPnQV623+IGi5EN0sktx5QE3gYyAOapWmAXwoT1Zm9B3GJARPNEZuGG
 mUGaq/cM+/qomFGlwvRPoZNmLCyU5jh+gZdANKzKCcR9B1h+FkMNRFeuIDNhZtSaDNyI
 qqxyg4/aYB7qQUmSonezAaiPQGTiNZP3c7cOda+nGEUnOsPM9s4sedBOyPoSeNNBP4oA
 VkDOVwVs5eZvW2Ki5uAox3A2FVu0Qj1xJe+ixDeQpNlVVvDG9HSjPAJILLJuRqCickTw
 nuCvTp25hXpjh7V5DdXyxdnAkvIvP15phWlmNtBC76NUxB+4b08mAkFHlDLZIfr9mK6n WQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H2wBawX8f7JfynqmXfPuKBNrI04tj8AniVdtYtBtIHI=;
 b=x1K+kwOzbCUNmBJiFpbvEAxt/JWrtYTKTx1FOyl7mbnFAXfawo2gUMmqxSHoRc83UW2D
 cBB0YQoRtE6t0CyoSnzhog6Jd65F1bQL+/te6jzpTRSLW98Cd2NEOi+46Xkm4wijc/KE
 jUzxkGR9eWdlf6cTF9sP/1dbou1C5eqO57tldg/DL+C5vwg4gdJlnATNHHanKJhnJtA0
 /zxSRDD7aMliNYkplFLMuurV1tYDCPzqNzRRxhn5PwIETVBdObPBLSV/pIlrcRQvdEqg
 NywioQUE/KaqcCuQGs71mh3TJMy99LIhtoXUpsz9eHqiLCxaFvGMcUYSqURCMY4K93nj 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxxgqke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:29:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U6Pkv2075354;
        Mon, 30 Aug 2021 06:29:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3aqxwqu8kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9mUrJHFvEeKHDSK3A+LTkqdobgL3cu7WkNL+000c6ZamyGyWVTyCw1kJdxkI6tAtuPriU9sWMLIBhdgkaMRVwtV9PNxRG0ffi00JoOaoWMsOWR8tFsV7Q3LZvt72wcPUIiuogiTOnrESm1DdmVim8miaCc8MED7cgdTvc1qMN4stGVSBykj9etQ1bGPux3C5xncRFyNo8FHEfqTsMHE9BRgfbn7a4LLoRBHvhxNY2ry19sX5tNyDfi5+ndpbKtIzkT1zv2TVAPsmJzaX4/UYaO0AEP3cYei5Glu6/7uZsVO/lr6kUV6QnDFs3wf2K8JBaCJETJEzF43M+T9i9wVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2wBawX8f7JfynqmXfPuKBNrI04tj8AniVdtYtBtIHI=;
 b=VWaM2tJ5FtaR6FSmRPz6IesSlcGlpPTd6g8VWY3ZVgBQUzFeZlRjMuCRkZUyQ/amndjJPgqh0pjglOiH+ou/sZB/jaoT/OtjPm3WUWMBMiftrSd9akDJ/QEgX/9T9h0RFNpwgxtwfP5Qe28/+rG40EWq8K0ugZQZSeTBWyrTSsEN+Dr8XiuKc2fioFn06xeprZ1xBBEn25r68AK3DgPg1YctgaFPrdX8PScTBXm4XYKTpIv6z0K7ehCGb5fFfw5+5VhczJjCOztgZB4d2xK49IfO5Rs8A/cD0fXQyhzhPP/iBAmP2IKbmL3SnJErcJBbmZeD6XNRkUFugIH1tmnD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2wBawX8f7JfynqmXfPuKBNrI04tj8AniVdtYtBtIHI=;
 b=Ficb0apsFNpeWWNKbZmEHADs6w2Fi5idguY/rF74yaVB6gW+YE0qPxJkR3S0WVrMU/hd0na2/Ws/l94MYU+R+SpDZR69EWfsg6wcZKcrXF2PKNTTsqrDMqaZ+B1aOEWS9/M2OkuG5zD8VSpBpnWlmazC4yeZB/sV7WEX/pv94+g=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1504.namprd10.prod.outlook.com
 (2603:10b6:300:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 06:29:20 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 06:29:20 +0000
Subject: Re: [PATCH v1 2/3] pvpanic: Fix typos in the comments
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
 <20210829124354.81653-2-andriy.shevchenko@linux.intel.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <730b1e81-d00f-d99f-cde4-2176c2030a95@oracle.com>
Date:   Mon, 30 Aug 2021 09:29:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210829124354.81653-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-ClientProxiedBy: LO2P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::22) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by LO2P265CA0034.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 06:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d35b8088-c268-4c26-ceeb-08d96b7f8017
X-MS-TrafficTypeDiagnostic: MWHPR10MB1504:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1504086BB78BDEA0A34E0C8C88CB9@MWHPR10MB1504.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMbZuxyuJ/PhZcIJptwK3Hufa8knovThkmUFGQYLmtR/pYJcsbtNZLciKdOVJ1xCBI8BviqhG/AjPpTk9kVmq4nzXD6RF/zWUJnG8i+qHRylU1RjUJ/iwHQbSIUkbxLS2jGy6JbsAQg43FNR+TXwHEc7wXNKw7aXxqwvNGVga60aaRrYV4AL0+AcqchBTFqDbnA9TDiHCQ+rXayNMZnl3MUAZwxqFap036yA4jhnkkZRoz9ROOMWDKwhwll0f2g2LHssle27JYbBCrz6Nkt0M7/O35O04bXksPJWPg2e2s5COMP4jTn6NghRXF0Jv0PdxUmMx5MZa5E6/1P/4xbKoITsJPyRl2Ff2PO//CUzB8Aut+/BSkKwMtmWa7+yGl7wvy5lrAToeG325ImejetMpnLX+QfSaJtNqIxCdnvSunS/YdJrEdfMcxGyFMwdq0e4Km7AYXcgFcsq6koAWLEe5R83UAeeynfEJJfLE7ybs3cDnoYSJRJj8pA/X8ipuI2LfQPRJ2JX0RY047UII6Yaj4heYF5YkKdhK2cyW6VqWoaL68yyztWpJYvmsYs85ZWXhis5FzyWG18oDBtCpoULr54YHFGbb+MwNBedvW2ZRjT3wX7T/Eg3lPLomMmk83hzlqcRzhY7V/EnqLZh/eXK9MUPHA0+j8+PMeuYhHwZvmBPN8J/bsPVdmAjf+yAViDTo/gJ84YLlHJekIBOQZYhE7zkbc7d7AixmDjEAAiOtmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(2906002)(31696002)(4326008)(8936002)(66476007)(31686004)(36756003)(16576012)(316002)(38100700002)(6486002)(110136005)(86362001)(66946007)(956004)(8676002)(2616005)(44832011)(186003)(83380400001)(6666004)(26005)(478600001)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhaWldiT1RSZjUwckZuYW50NFg4NW94WUVtcE50VVNua213VzlJeFVGTmIy?=
 =?utf-8?B?dlc1MzB6ekczbVlnT1VZZXp2bnJoOU5ONW1hcTlRNFoyVUhTMUpZankreDZq?=
 =?utf-8?B?a0pYMjk0Ylp5WlB5eW5YLzBqbmN6d2VQSFRLSzFHS05JUm5RRDlxdE1NWTNp?=
 =?utf-8?B?cGlqY3k4ZHM1NWRYZ1lmOGJPYnpYeEtJQVlJaGV5UzJXeHpjUmNJVEhvMWlK?=
 =?utf-8?B?VzBLdTlNYzVzVkVMeGJEd1pCWE1BaTNuUzJHWk1rSzlEanBSNmdRanprTUR0?=
 =?utf-8?B?SWFNRnl3VUVtVlk4OEJkVXlwOTJNZyt0QVBqY3BiR3kzWklzcHplRENDTHZ1?=
 =?utf-8?B?aW9wQndNRWFNZ1g3ZENSYS95NUJNcjFSclBmTktwUVJzL0lJUlpKSE9Bb3lI?=
 =?utf-8?B?YlpEMEhwSm5JSjZkdk9hejYwZ0xNdHZiNm1rbnBpMTl2YTY1TVhwVjF4aXcx?=
 =?utf-8?B?Vy9sZkZsbFhZbjNhSmRXR0hxOHQ5QVR1SFRyNWltT3JzTVd1UGxlWXJDUWFz?=
 =?utf-8?B?Wjl3eU1qVHpkbk4rNVIwdnM3eXRXblIxTE8zMlZGMDQrdTFKNkNJYk5wQ3Ax?=
 =?utf-8?B?SXBRM0N3ZlBwaE5VV0NUQVE3aHgrdWtITGx1ZnlBVWpSaU0zVzZ3eDRCKzF1?=
 =?utf-8?B?S3dmTWNkWUhJc3pNOEhIYmVBdGp3Sjc2NXRiWEg5Vkp2M2dmbGY2aldaV0VS?=
 =?utf-8?B?Z3RBTHlJdmxZY0EwaHlvSmFOV0NnZFo5VE40R2pwWnNNM0U5QTNUT3ZrVEZj?=
 =?utf-8?B?ZHpua2JKaUdDMEtrUDNBcnN3MW5kcnJSV3hOU2I3R2F6OXZuUHdMM3c3R2dt?=
 =?utf-8?B?c25Ndm9qSHF2SHp0d2V4ZmpMSEZrMGFoSUZyNzNWYWw5QUY1Z0JzY3kyUnFq?=
 =?utf-8?B?L1BoNm9JaUpMdFpHNkNBaHRCcXVDdDM1SlVCblFlQTNFbTFoQzM1elhoTSsz?=
 =?utf-8?B?bGtLY3ZndEtNdmd1NHU1cTlrRXM5WUdOT0xJaWhSNVFtalZSSlhxTGNJS0g1?=
 =?utf-8?B?UDBKb3FVTkdtVkVxUUNHZmJpdDFSY0hjcTVUWW53MFl0YWhmeVdVUzBmZnpH?=
 =?utf-8?B?OFJsNUtob0xSZDViWnZiWkFpbHIxdVlHMExad2RPaWI2MnVwSXpjZjFyMjVy?=
 =?utf-8?B?ZzY1d04yc0F1b0ZISVE3Rk11N2w1UmlqZUVsRGVvc040OXdBSjZmNHlwMUI0?=
 =?utf-8?B?VkhZTjNaUmxSbFJHOXpvVmRaUTQwcGFzNENTZDNaWEhPeGZLRm00cUY0QUF1?=
 =?utf-8?B?ZkIvUUZ1UkpIZExrZ0RZWHN0aEphazhzZng4cENWYi9tSmQ4cGdoWFZKN21D?=
 =?utf-8?B?cGtwRXJ6a1JORDEycHRlUDEreTUrWDdrQTUwTWZzZ0I5MzFUWFZkVHVHQzdF?=
 =?utf-8?B?TVBSQThPT3E2dTUwT21sa2NXWGNxU3MwYzcxNGZkOHdrU3dSL0hzWnBkbXJ5?=
 =?utf-8?B?aUZsMTl2V0RJblFMcGFGUHNZbFNxc3J0TGdrV20wQk5DeER5TFV4UHpnOTZP?=
 =?utf-8?B?ZUpuTWhCaWhYVFhWd01pajJaV0haeCtuckdsNnhLcElzcEIvV1E4WjZEWGRs?=
 =?utf-8?B?dzBKVTUrMFhLcjdnSkVTMUd3dmM5NVg5OVo1ZHpIVzRJZ1ZsbTU2L1NxMGZB?=
 =?utf-8?B?VFpwSHVtM3RoQmZQeHZvdHVQN1lIaHdON0prMFAzZG5jRjFIQkZkQnpNMUFY?=
 =?utf-8?B?Q0l3ZW1DZVhXSzFwbGdIeGlucGdTaXhTL0FnbDVGazdmdWY0Q3BSZit3S2gw?=
 =?utf-8?Q?5enRHEknLtAneREMYDx5HeSZ7wL7Zj7UQWAaLdC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35b8088-c268-4c26-ceeb-08d96b7f8017
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:29:20.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvP2cjGVFOJpuhwdULc9EbYcvtXmvxWKosbKug2q0lrqW+sxGON5T2fS51k7Q/ueVCzzOTa/4UudTb17q8FosuS1lXy3g5jARh6KxwTfoKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1504
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300045
X-Proofpoint-ORIG-GUID: PwoGkXLFfkADk6Nw7of-B-wbZcsfFxPt
X-Proofpoint-GUID: PwoGkXLFfkADk6Nw7of-B-wbZcsfFxPt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 29.08.2021 15:43, Andy Shevchenko a scris:
> Fix a few spelling typos in the comments.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>   drivers/misc/pvpanic/pvpanic-mmio.c | 2 +-
>   drivers/misc/pvpanic/pvpanic.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
> index be4016084979..61dbff5f0065 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -100,7 +100,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>   	pi->base = base;
>   	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>   
> -	/* initlize capability by RDPT */
> +	/* initialize capability by RDPT */
>   	pi->capability &= ioread8(base);
>   	pi->events = pi->capability;
>   
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index fb5411dfd614..254d35efb0b7 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -58,7 +58,7 @@ pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
>   
>   static struct notifier_block pvpanic_panic_nb = {
>   	.notifier_call = pvpanic_panic_notify,
> -	.priority = 1, /* let this called before broken drm_fb_helper */
> +	.priority = 1, /* let this called before broken drm_fb_helper() */
>   };
>   
>   static void pvpanic_remove(void *param)


