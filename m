Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9B3C3356
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhGJHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:01:05 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:51328 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhGJHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:01:04 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A6wE9M003617;
        Fri, 9 Jul 2021 23:58:14 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 39pjap8r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 23:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cICPly3VnCggRstRuNjJr+uj22hmNI+liJa2G1+1xwBwaVhwr+eGCzYOA7rCyu3dbYFbiV+HcvGEwpeNh4eL8Eu3qWDtIMrrORWW+PF1QhTfbGW1r1FGowAlPgj2sxKD8WuGKXxcjUETe5b1rpp+Ypu8Zv8e1URvHHDbGy6Ps50HCOS5SMDLU3y2AtXCgK3MZb66h4qN3fi6uFx2wmKtxZq/q8LcUC77/KQJVm608WTx0Qq2XcMbA14lz5XseXeTDom2BE57gYzkKISiY5HwXvsfcIZdA3I3Lb+dTAw7F24T/MDnkHAfAGEfSYa6ZxpV3SeKbQxM2RdYGgW7djZZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXRnyikUooMlZgVDviqlDlvxyqKRQBzSF2FLEkqRzRU=;
 b=i4Z9A3GaulZy9rv+wrMjr8twOTDGX0cBMoM6KiWXa9mezTPh3lV+vDDsWBKByU/w4E9JcExlh7SYAs6NCsRQ2Bj0SvqtRblVsH4/6ndm8Hf/wRtdeWb/vPgBqfnjOLuR3WJKOLVsr7VRAS66uaBKub+butfjKHF3/yNuxFPYJ/7e72W1pUyBWll1TNrrwLxaijREwiFWV9gpGhPoOb3iDBx3GgeAXF0/c9oXwEHtQ71yqqIzZYPHvRMu9zFIVXMRL+/rsshUnK7IsXt61ToTtcUuVE8M1z6JfXrGl0winZy6Uv3gnGtFdXu/GCcVdAOocyGY1Pctvwvci/ueZjts/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXRnyikUooMlZgVDviqlDlvxyqKRQBzSF2FLEkqRzRU=;
 b=DUUX7Y57CxEEECIjtEImI1Crzo2+dPFdZl1qzFOZQuGzgj7Ft0kQG7ZYEn2yv0XcLdUVdWSwllaC24fT4blXLx5p6Y2a8VEb9QbuJCYRpK4nEhkCTfe+icsaivD2MDd83lWXgB2tKPLlqabC80wGhzMywtj+NyrLaTDB5miZla0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Sat, 10 Jul 2021 06:58:12 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%8]) with mapi id 15.20.4308.025; Sat, 10 Jul 2021
 06:58:12 +0000
Subject: Re: [PATCH 1/2] mm/page_alloc: correct return value when failing at
 preparing
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
 <20210709122225.GZ3840@techsingularity.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <98c83852-6745-bf57-2415-696edea89704@windriver.com>
Date:   Sat, 10 Jul 2021 14:58:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210709122225.GZ3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR01CA0064.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Sat, 10 Jul 2021 06:58:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd0042a-181f-4a75-5fdd-08d943701520
X-MS-TrafficTypeDiagnostic: DM5PR11MB1692:
X-Microsoft-Antispam-PRVS: <DM5PR11MB16921382E98A3D4BC7EA042DE4179@DM5PR11MB1692.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8T1IdE4oOHRwnSvHU9+tGX6kMpYL78EK0NrKQs892kyl45+XIvcSCKlxZCBQFDeB7n5WAFxlk8a22L4UnEMHnTAQqoPgt7Ql3DdQRYkvNlFhHdtgQTT5oFO4NvyC88dQYMKX760Txfv4s1hj6DdwD4uE9bTM7PcDRdE80UY7V8qsuoVfbVvM26416/h6NpRQv4zXP7MUdnTdvbDsOQqYV5duUdL6TR3Klp02xNYGUUzGddI5UjoCUOg4SKJQs32xI1Ggyf4CGn+PPTXFuXz2C5lKLmWi57IjYzU63hn/iLPDR1dCv7mU4ChxqAek991wDxBR8hQIEo6NGYyEBZh8nhkXjElbzNzjmt2CUo3rTg7BWrsZTIIJN0jwfEVcIi/EgJZyhvFg19uWxsAJyrSzuNFPnuKe4vKaTLEqbTzu0gNqbMKdBHaAVv6szXj8JEyUID/nt7vFhqi8KPE9eq0ZqgQ5JFJhaEvqhMmiHsvSArFhcJkYmCRzMS0rSQ190cymm49Z9T0NmKTccm51ss/4oBFHP/C1e2Og4jpx2gNWaldGT2gUWTTq6ehbIxZ0Afade2suXQ2aQf4pqutHwXnFn3kXQnDvGfW3FOYZFA620/Oxw+FWxwVznFmjUOpMT53eoD+VORz2Q20TtbTJMcq2sIv7qv7UhJMmLAYXvrfAYWhhN1RCtBzgH3vpleUqMDqbLoH5nSO3OooOiwp6MeCG/5DgMhnm1uvJu6hrUqIVsWCh8llxaTTIk94dWLLUIoT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(396003)(376002)(5660300002)(53546011)(16576012)(6486002)(2616005)(2906002)(186003)(66476007)(26005)(31686004)(52116002)(316002)(8676002)(38350700002)(31696002)(38100700002)(4326008)(66556008)(956004)(478600001)(8936002)(6916009)(6666004)(86362001)(6706004)(66946007)(4744005)(36756003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?0HkM0i/da6G95ej3xq3LxuyRqSkRPcGsuSrAVOfhfblpEcdEwNE/pZD/3?=
 =?iso-8859-15?Q?i0jiwHTrV2KFxtgt8ZX0CPnRycLioj8XMgfG5O8a0R8GzDWzXto+SxAvD?=
 =?iso-8859-15?Q?lZI32uLmWPcD8d7FRZZFhTKmH1KLuDTbCOrK9nTEKVDbnQVo4aKoyTXcd?=
 =?iso-8859-15?Q?JEkE+APapKuSAsQcnWW5LSm8YgbP5mqLIh4kpBVpK81T9bZS5ziY/krqX?=
 =?iso-8859-15?Q?XTeuIIlG8UtKgEnS4AbKb/xlykoIk1Vr0KLhVCjPh5sqOEBPlpagtoBY1?=
 =?iso-8859-15?Q?4WwjBWSvjiiGlYXujwfeNsGK1CZhvZWuasZ8/V8EclDS3CpbzPd9J1kqO?=
 =?iso-8859-15?Q?KE9mR9e7l23h8E8KtLv7ek7RMYVL2drgufGJzk/fSfbKt4s3F0TV248Rw?=
 =?iso-8859-15?Q?kdx483F8R2IiKoTv6CogqMU3vLBFc/rMOfubmK0FuTbe4xL6vxe640ulH?=
 =?iso-8859-15?Q?AUYse+sU8SETO1nHU9VIcVAnvBglyz4YceRojVM4/Ww8P3zRomBkR2HMp?=
 =?iso-8859-15?Q?ECafBeErhncZmb4H2eGIS8RNW+3c3nbBWxkKhUn/p60Y81hhCRBYyRDoL?=
 =?iso-8859-15?Q?k8rUHgAFvUezK1W6rPJHUWOZDxDtCSwZwLCTTRhntb0Va0Lb2qks8mKiI?=
 =?iso-8859-15?Q?b3oelquyBQp4O8Hw/NkwszkfJB1Rq6F/LJzX8M/VbiDTUxUCFujHCXgER?=
 =?iso-8859-15?Q?39HPVL/sovtaE+L5uITDbsDgGSPZk8avXrUaLCfyOk3fSznaiJuguNYXn?=
 =?iso-8859-15?Q?ozbzZz+iJM7vJpFCiU6r50pUvzBSl0xmNRFWqBpqUvIconHH+1a8PBjTO?=
 =?iso-8859-15?Q?YU9dYFbSqJQneIYHzds4NimBlVF90ZXSsxsBMf+MWyGq1AwjRL4T3z/VR?=
 =?iso-8859-15?Q?ZZuJXwYqbl+oC3xUGPW/YfN/INJBkLlBd3eidrNL7/mA2BEALTzOqaoC1?=
 =?iso-8859-15?Q?YqxF2/f3fiJozz2UJdg1JHD64hqwW0LpON2MQhnSqjeeTc9y+9FrS7qeR?=
 =?iso-8859-15?Q?AQt9SkkvLctCcAp0vriPca5b6la4spcn1l5ab0jlNjrF3I5gR9+IvH2aQ?=
 =?iso-8859-15?Q?FQtlZ/VTvoI1KsonsK9eDfQERZ4ImQGVzrny0yIisfVxwSi8pgPt+JYwk?=
 =?iso-8859-15?Q?2MNhlKcd+tHRfpqDZqY54G8jGQW/JRW9ddkxewiEsHqsjnR5Ec/2Fi2Ar?=
 =?iso-8859-15?Q?XCssgGIDrOSChZ391njE6E6T4MpSNdx9snviUCaOKQVEo2HJRhKik+3K/?=
 =?iso-8859-15?Q?czy5GNVuRvRpzsjAB2mqheQDeNw9kYm5zXrjz/yW/DPtIQx3aFuC+75FI?=
 =?iso-8859-15?Q?Logz2J+eCCgIA+W8K/3nuSmXIi9LrsTups9Ns8Dk+SmoLTFl8DHeiDjp/?=
 =?iso-8859-15?Q?8b2b9uzWY922fn4zhL4W7/49VlT3y1EJd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd0042a-181f-4a75-5fdd-08d943701520
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 06:58:12.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6LM+08SpYLpDu8gOtXYDaKriBYEWrEeLsQsRqpBFqs4xqHioQYTTHH26tDrxRpW9UlM+eaXGER+oOmDrth6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
X-Proofpoint-GUID: 5k9uReR7JYzA682c8GlEjID8-N_618AI
X-Proofpoint-ORIG-GUID: 5k9uReR7JYzA682c8GlEjID8-N_618AI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-10_02:2021-07-09,2021-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=956 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107100024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/21 8:22 PM, Mel Gorman wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Jul 09, 2021 at 06:28:54PM +0800, Yanfei Xu wrote:
>> If the array passed in is already partially populated, we should
>> return "nr_populated" even failing at preparing arguments stage.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> 
> ff4b2b4014cb ("mm/page_alloc: correct return value of populated elements if bulk array is populated")
> 

This is a different return location from you posted.

> --
> Mel Gorman
> SUSE Labs
> 
