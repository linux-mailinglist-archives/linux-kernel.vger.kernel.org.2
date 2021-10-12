Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02C429D61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhJLF4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:56:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15460 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232431AbhJLF42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:56:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C5nLT1012464;
        Tue, 12 Oct 2021 05:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+klEplM0F2ThelgDi5iJ6pqa0qYAW9z85qRTmHns1MY=;
 b=b4/aIb87/F2/xG+ofElH/aNnm06I8SeQ+0iM449ME/cYNu/ci/wN22FRMQNFKP+u7Aof
 skepdQdMQAJzlLf0P7IT0g+m+QeWXiC6H3gtK/AcDqkBwsHovrWqJIdnQwf+isyGJ1bq
 FRa8AQvq2cGHu85lk5Faea856pouCux+igAfaBHxqBOk9oMTlFKcwLobWlnYWruGOAqk
 p41BGTF/94SeNTWYIsouZc+jp8I0OMIi1glssfWLXZgpDV0VOlOjCl6kWSA3i6EVt6IX
 hXu9/1sA4G00lHUsfZlSZIfC8pzlHgNeCYLuSSsJ2x1ntSkmO3JR3A1lN17muo3x+GNg GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq2vms54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 05:54:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C5ohQ4041386;
        Tue, 12 Oct 2021 05:54:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bmadxe1qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 05:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAa+dHB+/D+sGRdGBu1hbFK4T7JOdcG15oYREfgMCL4uhWWvQcnY7+T79+oCo0HgaassOdbuv6AYXSP8zmUuqKErhHCKgThFil5YSSbiZI7jO79XdZeetUJjgRvvpoeqzDYM1+9KZ1fdwmsuIk6vlqIqX097UWQE8te05qfD6q7Sa62XsMMqgVTE/WBXMCGUup+mMye+R+vNhreTqcjzx6lzO03qQ7NUdBgpgUWxzDjt3nCtS4/+VRI5wBrtW+8OHxU3mgzwNm4ikG7TnTpyT33/PENTBIumikiMthGWsYyKoF+jgbIKvamQbYIwgR1zbo6jxpryEr0oCA19bDRtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+klEplM0F2ThelgDi5iJ6pqa0qYAW9z85qRTmHns1MY=;
 b=bBkERpUBCM2nva/THiz8l/N37H05+0N/you/hGrRv7jRVazCyzFES0JVmFlPYZkL5pWdYYjlad9ILuuhgObgS9bQPkrwsfXnvVxp1erQUMNDoy9CrBbMQSC8nIMh8OhlpLyirARFTOWYWjxi7lr7dWbQ/yTbnP0liqapfEGgFgor1SW3oaWE3v6AMGjv4KjeapnJ1LGyvS6iboieQ2ZbvuUgFCbSmoFDpx2BcBh+gN/zv9loCpmmdFmTYTpq4uUDn/EA8S/HO8aL9OEerzau22yQPiV3xp3lrdMF0BQUdsitYpzj/1OV4DCOvwMDd61qi7UFhPH6oSumUx9F1zNrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+klEplM0F2ThelgDi5iJ6pqa0qYAW9z85qRTmHns1MY=;
 b=dD2sM2wRO8MAppyGMuS1uteSSrnThkpOtsGz6L5o1HmBvOmUggdc+/rReglUA3q5gbxEgnTBlGQslN+RaohI6bprRl3BS0Gs+scCo/vG8C0EGnrWPbdHR2OH3Ny48DE02wAcRZbLvjjtKwNOa+RldiULzJgodYZggbE98nGhuA4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 05:54:21 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 05:54:21 +0000
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
 <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
 <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com>
Date:   Tue, 12 Oct 2021 07:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0196.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
Received: from [192.168.1.13] (86.217.161.200) by PR0P264CA0196.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 05:54:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 245b4e87-8c26-402d-c476-08d98d44bc90
X-MS-TrafficTypeDiagnostic: PH0PR10MB4632:
X-Microsoft-Antispam-PRVS: <PH0PR10MB46326906DCE7296747AC03A897B69@PH0PR10MB4632.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgytUAeTnVh+shpvLo89fdMV6wJPDe1VabCBrV0OjbGVOIQLxk3XTUjYz4gShO/3UoMhuRPmhcrM0Ou8agRMHOfZjZyVR2QFQdYoctGO6CCrlrgszKbJLK9o26X1OsddNTKqd2qPbqwnVt9MroLz+hBX9QY/Q3NzvchgEOyGGEoBVb4qu20SIXJsWErd3nWuFEBunA6pB2T++JDFsenmMa33V+BgGOIKxA08JHsCMnaisNoJOQBu18ehoQjwKvcZgD3N0kphmMQSaitREF1W0cnHMwWY0OllJSgvIzMg3fA9R9bc4BN4X7qySlNz0PfJy6H4dcX0TK/cbBkHCk56orMrfE1e0j0WSIS3EVZxw19GUuE/qbwI5AS0lZ3zCQWeCF+4z37ky//pviVF8gcp2K+Oe6cssl7/sJWDc+6N+iT5oA1OjH3XLMx86G7EbvIFL7Vd8ziZCMYPXvhTMJJkvGq9q6SygNNebAieXgC9ly/L4y2Z/kWjznmm3ux+IkCKKr09BIdknf7woQidviOP9mYfvVzwVa8Wf02JUcMiFPwDXAY94LAqYz+VjwcOv/fp04XGE1yC/x7K66PyMjx4ECd+cv7G3+/EMI81cH2nQjiBIXXKs0h4AdZK1FHSYuoarBh95rjrKOnCN53J+fuOip+9wlpDCfOjTZG4mnLNl1ByZF9AEZDHlc2ExAS5ZOSSQq/rG+mz1jyJCaDOCt5f6I3LyxkSXhgNiTX0z6vGM/pfIkUX/uJANkiKJoqNNDAGYvHEOXoPUO2VPatIfwTBoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(83380400001)(66946007)(54906003)(36756003)(508600001)(6486002)(8676002)(44832011)(8936002)(5660300002)(52116002)(2906002)(31686004)(31696002)(66556008)(66476007)(186003)(6916009)(2616005)(38350700002)(38100700002)(6666004)(4326008)(16576012)(316002)(53546011)(26005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01wNmtrQVhjM3pob0c3djAvdEhSeWlaWUJZaW0zSjJpTkdoUXlSdHE5RzdZ?=
 =?utf-8?B?aHdjYzI3VlhaZ2FIbDE4V2liWVd3WjM5V1RFSTBZQVZXY1ZvL0JiZ2VBaWpB?=
 =?utf-8?B?czZIYzhlVjVyanlQS2hBZURGZlhSVGlabmx6dzRIUDlvYjFwcG9Ed2pWL3U5?=
 =?utf-8?B?dy9zMFkxN3QvVWtnc25ia09ZcTIzdklHT2J1Wkw2WDhJcTVIWk5mR3haN3BD?=
 =?utf-8?B?Z3p2bXExQ2tZSXhFa25CM2NpVGtYN08xNDB1VTVFT2p0T2lHYm5ERFg0dXNr?=
 =?utf-8?B?b294Rm1CT2tkZVgzaDBJVDBleS96ZjdYcVI5VGlmY1VBejdLc293NEgrZmQ5?=
 =?utf-8?B?b2FJc25TYUw1bXhaZTQ4SlhWSnpVYTVhTTNUZ090YTNzVEFvRlhYN3dvVitS?=
 =?utf-8?B?eHFScU1QVFRyc29JQVM3RmlrUlhtNHhYME9TekxCSnJIZ0JDS3JmZTdSUkFh?=
 =?utf-8?B?V1M1bVZZbDBOTzZiY09kaCs3dXNJUmF5R2QyVC9yaUxFRTRFY0NkVWNMRWF4?=
 =?utf-8?B?NHRtN09xT2lKNVVHTmgxUGxjTFdSOFFWaDlxN2U3MU0rZU9wSy92YnN6d2RB?=
 =?utf-8?B?QVM3MVErYW9EL0RVZk9QQVl0T2MvRWRYT3l5aDcxMUc3VDBEZ2RXNCtZY1h4?=
 =?utf-8?B?K2dDZTVGQStPZ2hROGVCSmhzTWt1aFJKNDVwODhNdk0xbm9wdElTUXJIVGhl?=
 =?utf-8?B?YkhRYUF3QVplVkg5NFd2TDh6MGZCbFFVUUFNZ2hZWDFCQmN3WVQ3WVlMSkZu?=
 =?utf-8?B?NUlhTmVVa1J4OGNvcEoyN1VMUFZheWdldktqQXNKYmFFT2FaZVRSbm5ianl4?=
 =?utf-8?B?M3RhTHFxZTRZVVVHbXFyQm02Wm9iZ0lZU2ZnM1g0WDRYSFpWampOcjY2Ykxz?=
 =?utf-8?B?Z1JRVEZpSmd4dFhySEV6eFc3c1dsK3VlYVFnU2hsK2lneGUxT1c2S0VFUWpk?=
 =?utf-8?B?UTBQSnBOL2FTTFNVdHEza2ZGVHBKci9OTlhXbmIvUU5wRS9jTHV4bDVkTTBU?=
 =?utf-8?B?SzVSU2NFOUZ4V245OXl1Rmo3Qmo0Szg2NFN0c0hSQ2RLMndRaE1sMmRvU0s4?=
 =?utf-8?B?L25VS1FEdnJHUzEwVDUwVTR2Q3hGUElCOXVSNVIvMk5NRElpY1dUZk9vOFlK?=
 =?utf-8?B?YWRJY3hQemRmN01vVkhpb1d0aVYxNi9yTFluQjkrai9qcUp4Z2l5Ukp2Nk5S?=
 =?utf-8?B?M01velJpRzhnSlNaWk43VHlQbncrVDVDa09vVGJiZGJ3UE12ci80czE4aExM?=
 =?utf-8?B?UzRSN0NPUkUxeVZZY3dqcEhXTkRxZi90a0RLNjNkSU1mbWtCa0VmTTdsNlg1?=
 =?utf-8?B?ZlVDYkp0TWl5anR6cEtqbXV1ZXFGMTBEdTFuVEZRdnU5QUVYTlQ5ZmFsNS9x?=
 =?utf-8?B?Z1ZpSDhKbXh3aDdQdHpRSFpXWUZLL1E4QkZmMlJLOGJpa09WS0lRdzErUFk4?=
 =?utf-8?B?aUM1TTBFek5jVHQ0bmxvVno1blZURllxRXdLaWNONHBQMTU2RWMzU3ZYUU0r?=
 =?utf-8?B?NStoQm9OMWxOZmd5dWlEck1lYklMYmUzcWllVTFMOTI0YUJUQ3loMmkvejdq?=
 =?utf-8?B?d3dVUmg1TVIwUnFiNEk5Tnk1NEk2MzJzcjRkd2pzeTRRWFkwSWpIZU8rNXAw?=
 =?utf-8?B?Sk5VenFoMGE0WWpobms2YWZYUDVnN2JBQ09DRTg1ZkRzN1QxM1FObDhmSkw2?=
 =?utf-8?B?N0FTQW85T0ZKQ0NPd0V2eTRQVEkxUjZrM3U1THVTemxjaGQ1L2lLN05QS1NH?=
 =?utf-8?Q?e+mzQhU+gN/yjjTstubtHsw6Ju8N+AKPjMFcPcB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245b4e87-8c26-402d-c476-08d98d44bc90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 05:54:21.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGqjptZ0M1u8tU5Y+d1gCDA3+ivpbew/dvmmHO78/QaUbjwmHM882JV38A0rZMbRcov9G7aUnAhf5i5iIS71Pb8Cw/vxX0iiWJ0ilwJpALA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120032
X-Proofpoint-GUID: eo0RC4BNN5YtqbAsqJMPZcn_Ddky18eZ
X-Proofpoint-ORIG-GUID: eo0RC4BNN5YtqbAsqJMPZcn_Ddky18eZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/21 9:37 PM, Arnd Bergmann wrote:
> On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>> I also suspect that satrandconfig samples the configuration space MUCH
>> more uniformly than randconfig, in the sense that "make randconfig" will
>> tend to have CRC32 enabled just because there are so many drivers that
>> _do_ select it. (Think of it this way, every prompt for an option that
>> has "select CRC32" in it will be another 50% probability of actually
>> enabling the option.)
> 
> Yes, of course. I've seen other problems like this often happen with
> 
> CONFIG_I2C=m
> CONFIG_LEDS_CLASS=m
> CONFIG_IPV6=m
> CONFIG_CRYPTO=m
> CONFIG_PM_SLEEP=n
> 
> Not sure if you're already hitting those or if you need to add something
> to your setup to make those more easy to find.

The CRYPTO one I've definitely hit a few times (usually combined with
CRYPTO_HASH) and a failure to link crypto_ahash_* functions.

Otherwise it's mostly CRC32 and a couple of odd ones like this that I've
seen so far:

ERROR: modpost: "dell_privacy_has_mic_mute"
[drivers/platform/x86/dell/dell-laptop.ko] undefined!

  CC      drivers/scsi/aic7xxx/aic79xx_reg_print.o
gcc: error: drivers/scsi/aic7xxx/aic79xx_reg_print.c: No such file or
directory
gcc: fatal error: no input files
compilation terminated.
make[3]: *** [scripts/Makefile.build:271:
drivers/scsi/aic7xxx/aic79xx_reg_print.o] Error 1

I'll give your suggestions a try, I have about 9 patches queued up so
far so I think there are definitely more problems lurking around.

Thanks,


Vegard
