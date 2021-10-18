Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06FB431727
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJRLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:25:47 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:51394 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229843AbhJRLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:25:41 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IBELmW013994;
        Mon, 18 Oct 2021 04:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=++0c+tyddz8yXxwhG0HiIcm5GI18KaV2jXe6odvgN9Q=;
 b=epWrx8GQBbNFk/mbtzcdtoi++y0AQ8AokXhDNngOuhiJK8bFbZddVgFuui4Yr7evNsHS
 TfssBrr7irZKvZrNLOh2NP1R7jjoW3LpL0hJdyrPsUE3Rouzsd/JXRsT3Vn9YbmtHHOx
 s/crAfbMmi7yf2zbRbf4ybGRrv/tIYd8sQQGOtM9Y1z74w8U2D2uvTuHf2Qc7zQZSJi5
 oq08LXrq75DGQqP3hodRPId/5QEZcQfG/nZl09ZIyBgiaNHHhKzx+pAYAg11iZGmEQ/h
 45xyOSqenMzqU1Hh0vl85nqPevucwVKHUb0NGlQwFn3NHeJ9yASKwjaIINJP5+gBxQqT wA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 3brs4v8ees-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 04:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpwACKHQHcKkE1sJAJoHBOkL5J2aOF3mH/H1HpaYXwWOrj4kSYjUUJ6jE8FW5d1ZTPTOf/HTlUN9DF4hgKyLXAUX4v1Dh/8FDjnmlNJfmei5Kgt9RpOsOq1PmAYWfOhIo1e18FZphXuGYXXD61hhUFpAPzNMQfP6mJbeSvuZT/zJUrleKov2EquvNNE+frxrNI+sb1hZxxULyr6pqyfsetjGwmrF1mOJDrRePIpK7nevr1crRlGX1UV+ksDepjHzQm9xpOfhUV9vBpcdUF77zd9P9uZUrSO4YUmc9vuIYuPZcJ68h+lFHCeHq45+FTda4hTErNnftiMvPKoa/v7lEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++0c+tyddz8yXxwhG0HiIcm5GI18KaV2jXe6odvgN9Q=;
 b=KWeclEdCzsFaxEHbtHS8dk/DVVZSk62tINYCZeNWAbbAs+MHH78gjBadwNvL7tVWbj+lo8gx2XHswV8ujyIELcn0N38UGwiNMdTKSnVnE3B+AhNnA750vPuT/SRgWoJ478isI02Cdelht0Yepoq3v7n5jrs9Pm/UOUXGmVwVuS7xtHvCqDA7iKTMVAKOe9r5JltR8XQuIRPmE6hTm/lidUHyCYsXyFYw4R+t/wQajoMU7REWfvwO42VSy7wsmtvCoICHaJhqhI2tUzKqwnBrh1ancsE25eX0p9Qdos8JzYW9QLNpinf2SfLp6dr9nj3YY/if2VgeuYuiszQ9tkmSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3593.namprd11.prod.outlook.com (2603:10b6:5:138::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 11:23:13 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 11:23:12 +0000
Subject: Re: [peterz-queue:locking/core 41/43] kernel/locking/rwsem.c:1023:19:
 error: variable has incomplete type 'enum owner_state'
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202110152145.nWCivoXy-lkp@intel.com>
 <8c0f011a-db83-001e-3cce-326cb8228a75@windriver.com>
 <YW1VQ80yoUmWC8Zv@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <f02c956e-9479-47d9-9a7d-5d50fadaa41c@windriver.com>
Date:   Mon, 18 Oct 2021 19:23:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YW1VQ80yoUmWC8Zv@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.163.131] (60.247.85.82) by HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Mon, 18 Oct 2021 11:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8e672c-d733-47c1-3d94-08d99229ac10
X-MS-TrafficTypeDiagnostic: DM6PR11MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3593CD8CEC61866ECA25E06DE4BC9@DM6PR11MB3593.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRL97Q+mtl70e3Gx+7kD8NkjphW7EMnkpaPuE3fSqrwOA3eOFCQrxzgcVtGE6CpHfFrZvtfWLiOATq+9A5/sgAiimFbHiulF8ucTll8zjlluYTUxVc2TgUsFfPuc/1T/ZKSjB35o8FioDqt5XcCk8Xd7gMCqQTYtGDJoeATpkq51fUM+u06FhP1zuUtO5DJLfj39WsDDPl3HcZJHrg/HPqIhYJfp+WqsnMOvrrzFckwwg6II+AX+3p9d2unyF7bv662jEdkqA8i8n83kMV93LzOH8u07y6jh+TU4ZL52oTTyNjR15sErZNeXKGrMYbUT08ba/tp081LmBszsl1IdqmMTGNmtBkW/MDyJnFlQ/GbFq+0fCqg9qn8pN8y0fthezGW5SVTXdSpNEe8SUcjctLT4KyDyL3hDiLJd7017pyvC5OQbgwcSkcf2hOHEG8343rVgzpdFmyJ+c1bpWWALG2iB4Uu5oVTIW5CX/sixN29a50dDiB1Ax6qln/pNy8gn/o8DH6KhXLL/ZvhXrVrTFK/mF87xjge9jvAn4/2riYrlemkRvkf3QKhcHzmK/EcKHmWTF4rj4WiKmXRNsitGJ3LhfxkaVDopKUcHmmHb/JxIfEjAtglAdkHWLKvByoTIG3CKkmG0hNmkV0y71zyLMqyBT6tNGM0nMncGO+DfIXpsZlH8yMgT76AjhnNNuL+G//Cp1b2AJ/MnnYWjHtHKlpXeRhWucwTX5ZqvPlLACfopj3S7csqOCMo60Cujl0mjfqEri5+uCMwu037+0OG3jsITnicpoL1BaGwAIK+pgHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6666004)(66476007)(4326008)(316002)(2616005)(956004)(53546011)(508600001)(16576012)(6486002)(86362001)(36756003)(38100700002)(4744005)(38350700002)(2906002)(8936002)(31696002)(8676002)(26005)(52116002)(66946007)(83380400001)(31686004)(6916009)(186003)(5660300002)(6706004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdodXowdjdORzk4eXlvUVpRTTZwMkIrS2JQVk4vc2d3cXlUYkZjV1psdTJu?=
 =?utf-8?B?SkgrUVE1Y2RPVmdrNExpUHVwSXFHRUVqVUxlcUt6SEJwRTBRQnp3di90aGZ2?=
 =?utf-8?B?TUNBR2dOck9JMk1pM2NIelAvQjA4bHNZUUZkVllzRXhqNTI4ZTFhZGU2dnVS?=
 =?utf-8?B?bS8ycHZwdUY1ZXhTYXlqWGM0OG14ZitEdDkwb3VDZTlkbnRPUTJ5aitWSHd2?=
 =?utf-8?B?d2Y4QTcxazhMWXRNVUx0aytFYTM2TkNnNDJlN1M1eURiMFpNMkVtOU5XNzNy?=
 =?utf-8?B?UkNlU0x2QzlqRlhIN0VGK08xMkdxY21tSVEvYjY2MUx0eTdLZVY4Z0UxZTRJ?=
 =?utf-8?B?c0N6V2lRdmlUMEVpTTNmOG4vVzdNdER3QXhER1psTHFMc2dtQURyOS93MWM4?=
 =?utf-8?B?c2VRTVJ3VWJxbzNXRmVOaStPMXhrWmpyNkJJUmI3ZnpHbXpkb2dyNXpaZ0xv?=
 =?utf-8?B?SHYxa3IxRkVwek1KcWg1Mkxtc1NMNG05emxFRFZjYWdnMnZreEFoUGVsVUlR?=
 =?utf-8?B?RW9sWG5VclpUSXRPeUQrcE9CT1c2bm1sRjNnd3NCNk94eVBFdHdxcnRKYktQ?=
 =?utf-8?B?WElBRlMyMG4xbzNMNGtLZFhUUXdRM3BIaUNoMUwxM0NUd1lneVlyR21IZmZX?=
 =?utf-8?B?Sll6YUxtVjVXNGZ4UjR6cDVQQU9mL3kxTTJYNUFuZW9Jd3JBM1lpN3ZmTlEz?=
 =?utf-8?B?ZFJQSFphSXd4Nkw4eko4RWlXb1l1a05jTEFaLzEvMzQ2b1Q2eUZPN3NFUVRS?=
 =?utf-8?B?OXRweEVvU08zc2Q0eDAxRWQ4LzFidGMyTVdoUllNTVBRRGdvalRPUWNZVzhK?=
 =?utf-8?B?RzluSzhlS3hWMnBOMnBUcjF4WjhWNllHNXU3WFo4a3NCYmdVMWlpZFpSQ3pi?=
 =?utf-8?B?cFV3ZWkxeUJuVUIwa1E5VDhXVExHRkFqSk9wbFhtUGpHUGdSa09tNzFpSVF6?=
 =?utf-8?B?eUx0cC9USXhheEpkMHpCNnhGRXJlU3VGb2p5a3E0SUdOSlRwM1RaOTdhSmlz?=
 =?utf-8?B?TW1NUStRZnJuU0Yxa2hNQmMrWkovekpWTitnUXBvb0N0czk0bGs0Q0ZBMnhG?=
 =?utf-8?B?SG9XV2gxU2pOMHBxd1ppcXBZTFQyNlJaU1JaMjBuYmNrbGFhbTVWWTlLMTRS?=
 =?utf-8?B?YlBXTWdoV0M2c1pjY3B0T2FsVUt1UWhCenllVnNEN2JLVG1iUHFjUWRhNUJK?=
 =?utf-8?B?VTRGL0dQempidWQyemRJRm00ei84VDNMeVJ2ZVpiOVJiM2F2RVp2OVp4YWx1?=
 =?utf-8?B?L2pKaXdBZGI1MEZCaURLQjZFYjl1TkRqdWxiOE1xMEhRYm50RExDR055aTVB?=
 =?utf-8?B?aHBuRG9qUHgvWFZrc3V1OWZGRVk1QkJnaHRlUi9XVytVNW9kekZISVI4djZS?=
 =?utf-8?B?SnQyT096TWVFT1RhUGZSb2pPN2FQUlFWUWxJMWdRYTZDZzJZK0RGRWpGMm1k?=
 =?utf-8?B?M1VTUmZNTVN3TTJrUUhXcTNWRllTTmdXOGFLNWN3UkJjQmI3a0g1SmQwYnkr?=
 =?utf-8?B?WTJ0em9lbGwzYm5EREZCWWZ0cUhSaXNpdE80ZG1DVlUzeFcvV3NzcmEvMUpo?=
 =?utf-8?B?Y2NpMWxCS01UemRZN1YyUUwxZXpnQkkrcVl6T2ZpTzBtZnZsTjIvMTRWei9F?=
 =?utf-8?B?M2hjL0dwUlVrVnA4RVBuQ3ZFQ25IKzdSWmp1TDczazlsSlNBemNzc0JsWllQ?=
 =?utf-8?B?VzUvSUdKdTh1WXFpSjYxQ1dQMWFtS2ZOTm1KSFVUZThtRDQ1UG1QbEdOQ3ht?=
 =?utf-8?Q?HjpWCwxfnrqy7ec+6pd1YBY1Yq21+p10ZYKFh4e?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8e672c-d733-47c1-3d94-08d99229ac10
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 11:23:12.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbb/lllZ7oyz+S6ejoLI2TWqrz48mkRtGhQf8uXMkmY/BE8/cJIWcXoRq/rX3C+Bnm1Yt++kZfS3JEvxbVHVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3593
X-Proofpoint-GUID: v-1PvMHUA7pH7JWEt8PUvEpSiJ3hVSbp
X-Proofpoint-ORIG-GUID: v-1PvMHUA7pH7JWEt8PUvEpSiJ3hVSbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=868
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110180070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/21 7:06 PM, Peter Zijlstra wrote:
>>
>> Hi Peter,
>>
>> I send a patch named ("locking/rwsem: Introduce __rwsem_spin_on_owner()")
>> for fixing this.
> How about we do something like this instead? That makes the whole
> CONFIG_RWSEM_SPIN_ON_OWNER=n side more consistent.

I have no problem， it's more consistent indeed.

Cheers，
Yanfei
