Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCACE3FD3CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhIAGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:30:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42480 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhIAGaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:30:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18168ApQ006211;
        Wed, 1 Sep 2021 06:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IZEJIZhOz2sv1uuJ0hbz1KBYy3rv6YoY+C5YEIDeYWc=;
 b=RHN5diWvbKu2rzPg/HKhIi5lAodSBUbNmGjwMPQEHsXrd0VHQubZpS2bdiYwCF301Q0z
 08xuMwJndFqSp4aqeEguuk+9/8qrBk1NcYWcYhfKmKd/m5Cou+jppEcBYQ3EzS2domes
 RY4TTOvOpMMOqh8en2wD13DW5W73MmuVQWrRiMGYa5AQGoppjq17k9I05lj3ClAZkxUb
 LnUyuS594odjAW1dp0uXD6FwyOrw7yttW8C0tHsZEawKcVPAcjiYRYqISEK7Br1sFXvz
 qwOgnUQ0MIprspOHVS1KHxREx721LZHVPxvMTbtiAe6nTolYkalHYzV4Ve4xUXcIGjL2 uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IZEJIZhOz2sv1uuJ0hbz1KBYy3rv6YoY+C5YEIDeYWc=;
 b=Ix986zR7ZoEnlMheUJH2pzyXUKFxx9W0W4CFHN0FhPLW+lF3ulLD/T8k3boJyJhFXSXW
 yTug3cNw4PjUvr/z0BBohRq1MzYPHmX+MQuxgpMcncFRU3WYyoG7gWinf4l1ebjy0iX/
 rDmki6wOOckzINT27+WAuvkRlAVZznTVAHXZidZlwsHGO2ik7wDWsZ7erc3aG+/Ts1iJ
 Gn1q5WZXcM68sceZjXJQIk9MYJIKbwGvKqo3lguoN1+avc8ZDqcdPc+FjutynyxXG66A
 O5DiaQNFn4II0c02kuXcAtIfpkuhvw0fKi1+Zl/WgLCiFiO6wcsj2h6QxI2unIicXgL4 qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66kej0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 06:29:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1816Pnrr150488;
        Wed, 1 Sep 2021 06:29:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3aqb6f8hqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 06:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RddtXp6d5EzmWSyES364rcIn2pntCqMG5Uh1Hbxr5ND6p6EG+wlMDVKbB7OVjI38cyzfma/TiI3BlDZFcizoixwfa0u/tAjK3n8QvyBxkH3xnl8zErQQY7RBlqilth5XHJ9qyrN+9Qc/1+0gcWlal+hXAeJbaa0iuQ9XA7dMg0kPru8vBf64UTsZkecjnOPGsx2Lt1tHP5Z4QKTjzxZlleaOnEG8Pep62fdXzxOY5W5F+r/jLWDcm6zRi4eIvY2+SrEFWo+xKjNYM4PDxanTHz4YtZeVdyK0VIPGbQDJVZOplOD/v0rQIBdWFuVDXXi9lQIjYgi4xtiu76WheKAasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZEJIZhOz2sv1uuJ0hbz1KBYy3rv6YoY+C5YEIDeYWc=;
 b=FYRVXfoD4qGqCC5o7p9/FfGsTl3wo6RS5s5lJWmJBg7yHhrea53QZZYWyQcAmpIzq4WcFfUXA0NVH2Bwl2GwbICk9lF7/VvlqYzZZJ/D0DhAmW39au9y1FiX9a8vRcn/pkUGjYIoLKRZ3abB9gq+XImiEkEkAt1m3CPPD777TDKfPlglB7swoV7LFsQ5qpC/ZJUfDEikvey1L4i1KEjeQp6qx/Rj7kWi+RveAFmNr8BGMr8bxeXjz2LdXY1/5G7IsQzPNcPARUAulMNGVYeUR8Spvp0axR6s0+bJbYjj1hjBCG0XSHvkIann6xf+3T7upfjB0/WyhVrvxOjqzouzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZEJIZhOz2sv1uuJ0hbz1KBYy3rv6YoY+C5YEIDeYWc=;
 b=a47xzcsDUGpzw7QfcInsfBnqnrDplOB/83hsv2gZnxEfnGnKsylxsDzVFlFMQdjgx0DpgexhuWMAXOfk5pWRDmOrCxaYoB6av0SWT5fp6wvVUCuCag1VIPK7L7DTwjwB0FDMO3Ga8YALP9zMY5IX3uhIs2mZYLgGrX3X7UTP2ww=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 06:29:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:29:07 +0000
Subject: Re: [RFC PATCH 1/2] lib, stackdepot: Add input prompt for STACKDEPOT
 option.
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oliver Glitta <glittao@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
 <20210831062539.898293-2-imran.f.khan@oracle.com>
 <ac61af5a-f6f3-315a-59a8-7beed8de2aac@suse.cz>
From:   imran.f.khan@oracle.com
Message-ID: <b136043d-9585-0d57-4c8f-510a754a8df3@oracle.com>
Date:   Wed, 1 Sep 2021 16:28:58 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <ac61af5a-f6f3-315a-59a8-7beed8de2aac@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0145.namprd05.prod.outlook.com
 (2603:10b6:803:2c::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.191.132.27] (138.3.200.27) by SN4PR0501CA0145.namprd05.prod.outlook.com (2603:10b6:803:2c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14 via Frontend Transport; Wed, 1 Sep 2021 06:29:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841c0a36-ae14-42b4-51c8-08d96d11cce2
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-Microsoft-Antispam-PRVS: <CO6PR10MB55702CC1968E77646D35F61EB0CD9@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17EWAZ1ujf+GG/t1YR6Xln9VPt9DJtcm83/Q2r/3x8m0UQPje4YUPVIWEOS3okWs/lqY5CrCtrqQDQPtWnPu4fXe+XWZpGSzZZJ4vJbhz9uph8fpRvwTKkKW/iPoqvBrnEDL3Wuc6dqPvIOP4nfxs5xyWOIdt5oq3y4GT3tc7BRRZbXwf17wJUvcW0nZAfUgve2FAlpdrL+4VlazoTewf96M5cfu8msaLEkWTO0XiXnLePzqIHYdGZJ5FhHeRAseLWi4eYdz23j+Ph75fG7TZ88plLD5eqH5ii+7vsLqsu/GravQCDNB+WI0VxTFTM+HR1PGvPKZHseBA6iJkgHiTEchX30eAd5SDXiixaaH5VTlZro43fuK/MZOOap1T/N20ptJWk/VQLQ2V0FcNGgjSedPV4k4A8aIYON0zzVTlLma5ZPP+QKMEkyex92fCPi7EunmVLHdToNgakwVwFRPUESnLqf4xpG90+hZELxxYZgF0TTCtyowsd4L6gn6ECKefXFajTwnreVIhX+cYJLhBpx4NedsgBb4IwjZArIm6hg/QFsov+VKeF3ABUq090lxzLrnYQVVoU8LSbQFcjaxjwonxIprjC7Mapmsq6a3rew2FZ7fAdPpRqt8R0kleuI9LxBRSvZLImtNDv4WIIFZg5VOrx/7VlM/wlIRbFfYlj2ogWafOQafvU9PCL0E1NnOKrueOcpjr6jFWdJJgLyf1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(86362001)(8676002)(2906002)(9686003)(31696002)(54906003)(36756003)(316002)(31686004)(16576012)(8936002)(26005)(6666004)(7416002)(6486002)(53546011)(66556008)(956004)(38100700002)(2616005)(83380400001)(478600001)(66476007)(5660300002)(66946007)(186003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUEwREFKNUtCWEhaVGhxR2tzWmRCa1E5bW8rY3VJRmhRc1Y1S05haStzOGpO?=
 =?utf-8?B?UjNOeno2VHFQMWpoOUsyemlwWGpvMG5rbTFYeE00Z1Y3UXZBOS9kQ1RMNXVY?=
 =?utf-8?B?WXNUNE1IcHFpTGxoT0pra0tmdTlGWHJSMHo0MlNYZEdtWUZ3Tkh1bzFITjFT?=
 =?utf-8?B?MkoveVlnaVZhMXYwQS9OZ0VFTDhaL1RzMDE3K0xxeTV4M2NVUW1BWURDL1F0?=
 =?utf-8?B?WVN2Q0pvNXFRWXczeGJid2JhY1hxQ1dQMlR1UVI5d09uSWlZa3VGZER2Qkxu?=
 =?utf-8?B?UFU2Sk9SL2J3S24vaXcvY2VWcUg2Y2VqNHU2YlVHNzA5TllITUh2VzNQcWFu?=
 =?utf-8?B?Z0UxSlJDejJuanBPTE1IeVBYZW91WEVURHJNQlp6K2lXMlVyZ3dHd3A3QzJL?=
 =?utf-8?B?MWVidGgyMjRNSEgvS0Q2ZmhPSG5YOGZobTR1T1lUN3VmcnkwckF2bDZKaWJJ?=
 =?utf-8?B?NlB2UU0xcGVnWFdZZDNYNjN0ZngzVUphWStwUDkwS0xneU52eWRoRzYxcFpi?=
 =?utf-8?B?eXAxMjRNVVNueFlZUXlmVG1ZdzREaTN0YXQzZlh3ZmZlalpIamFpSjRjNVow?=
 =?utf-8?B?NHp3YTh1UFlhc2ZvdUl0cCs0NytqMnR0anFkZFF3ckRneU1NZEdBWSs3S1BF?=
 =?utf-8?B?U2dmcGFVMlVqbHc5ZFk3dFNqZE9HU1dabTRHTVUvZmZuL2FuSnVxclR5RFY4?=
 =?utf-8?B?SDhvSmwxMVRQNUVQSnJ5UjZ2STNtaXM0enJiemR6ZGUvbktMZmVIdzZEWFB0?=
 =?utf-8?B?Vk52SEk1c3hqQnNnR1Y5QitYbmVqczlpb1Q5dDM5Wmc3d2d4d0NxbmNGMmlN?=
 =?utf-8?B?OHo4NXl5MVF3azRBRlpnM3NMem53OGV3dG5BV09DQjhjc2s0Slc3eDJFeXBB?=
 =?utf-8?B?Vk4rYkswWlBCaDBSdEQwNUtmR3NVZUxyemptRlJkQWdUTFJSUjhYYm5LUlls?=
 =?utf-8?B?eDVFYlZOUEtkaGFsbk14S2lIRWlra2liNXpWTkRyZG5UR2FKRW5RaFhydloy?=
 =?utf-8?B?dkNNbktqZmd2TnNKcTNhN1BDK1kvTlUxSk9Md1ZKeFJPWEhJMHdFR2tOQjlH?=
 =?utf-8?B?TXVXbnFBNUpIc2NFQUdydGRSZ0swbHNYUkpHUDczQ2M0cEZpcHEvS2JzYmhk?=
 =?utf-8?B?M3YzOUVPamVqOXFPNXdVdHhoRFR0SCtxNHNuZWhXRHNTNHgrRnpFZ2tPZWN1?=
 =?utf-8?B?bTRJQ1lMTm8xZUlRYUJENnl2Ni9GcTB5MFVxbVljS25XQm1SZ1N4UVQ5YUEx?=
 =?utf-8?B?Z3BmOGsrTnhKWnhsbTVqRkxMeFc1ZzlRc3JhUTRna0xFTldDcTBvVjdBcktt?=
 =?utf-8?B?RUVXWjZJSnhEU0grbUFCY0F5QWx4MHhGYmNocCtvY0xTRGhSZkF0YUFRTXNr?=
 =?utf-8?B?L1oyZkpOMUN2eGdpZG1CcjhxV3FNaUx4ejdSVHZQcHQyRTBJZjNTV0JOMDZ0?=
 =?utf-8?B?STQ0eDFuc0dNeGh5bzlXVjZ1Y29JQkdSVnZXdCt5Ymtpc0FOYlpmMThwSTlY?=
 =?utf-8?B?NzlOR1FRQVdiS1RxbmhPL3M3elQ1Z0I0TXMvSklBMXhwRnBKUkxJTkFuYyt1?=
 =?utf-8?B?RWM1TGE0bU5LOUU1ZVpPeldOd0Z5aEZHdE9ELzRSeUJtYUpIaDUzT3NYNWFl?=
 =?utf-8?B?dmpFVCt5R0xxTE5DUEVjUi9zNDFFaDVUc0hmd0dQcy9zZFFvZXA5bDdhVGdk?=
 =?utf-8?B?T2ZwRXFVdDkrbXpxS1Q5TUZUbGRZMmU1VjUzSUZHODNkeGJ6UkVyTmh4Nnp2?=
 =?utf-8?Q?qqB0N5ifIoFHML0MKgYSl665b71yh5VGgqew+ox?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c0a36-ae14-42b4-51c8-08d96d11cce2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:29:06.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS6EtHawuEzsorJxUv3xa2UUAyoqQM5i+Obk60al4pJuj7PSfHHXCTUQ4d6FusCS4lFVdfvLc5jKa6b0yrCfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010035
X-Proofpoint-GUID: yyTJcb-dUttWCDbkOrMifRoCFD23_dXt
X-Proofpoint-ORIG-GUID: yyTJcb-dUttWCDbkOrMifRoCFD23_dXt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/8/21 9:25 pm, Vlastimil Babka wrote:
> 
> +CC rest of slab maintainers (please use get_maintainers.pl next time)
> 
> On 8/31/21 08:25, Imran Khan wrote:
>> So far CONFIG_STACKDEPOT option was being selected by
>> features that need STACKDEPOT support for their operations,
[...]
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> Right so you're probably not aware, but switching slub to stackdepot was
> just recently attempted by 788691464c29 ("mm/slub: use stackdepot to save
> stack trace in objects"), but Linus reverted it in ae14c63a9f20. Enabling
> stackdepot unconditionally was one of the reasons as there's memory overhead.
> 
Indeed I was not aware of this earlier attempt. I checked tip of 
linux-next and saw presence of array in struct track and then went ahead 
with my attempt.
>> ---
>>   lib/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 6a6ae5312fa0..7e4b54f48af7 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -665,8 +665,9 @@ config ARCH_STACKWALK
>>          bool
>>   
>>   config STACKDEPOT
>> -	bool
>> +	def_bool n
>>   	select STACKTRACE
>> +	prompt "Enable stackdepot support"
>>   
>>   config STACK_HASH_ORDER
>>   	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
>>
> 
> I'm not a big fan of a solution that throws another prompt at the person
> configuring the kernel, especially if there's nothing to help decide how to
> answer it.
> 
> Incidentally just yesterday I was trying locally to resolve this in a
> different way, where stackdepot would be enabled if both CONFIG_SLUB_DEBUG
> and CONFIG_STACKTRACE is enabled. That could be enough, unless there are
> systems that would like to have STACKTRACE enabled for other reasons,
> SLUB_DEBUG also for other reasons but still not want to pay the memory
> overhead of stackdepot. At that point it could be more useful to investigate
> if it's possible to optimize stackdepot to not make memblock allocations
> unconditionally on init, but normal buddy allocations only when actually used.

My main intention of making STACKDEPOT explicitly configurable was to 
use it as substitute of STACKTRACE as far as storing user info was 
concerned. But now I realize this approach was wrong mainly because 
STACKTRACE does not have any memory overhead of its own whereas 
STACKDEPOT has memory overhead of it's own. So if someone enables 
STACKDEPOT but never enables slub_debug=U, STACKDEPOT
memory will remain useless.
Probably the most acceptable way forward in this scenario would be 
optimize STACKDEPOT memory usage, as you have suggested.
I will do some more digging in this regard.
> 
> Thoughts on the below?
> 
> ----8<----
> commit d3582a7c54b26f6fd3a44f1327a26c383e6b951c
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Mon Aug 30 17:26:15 2021 +0200
> 
>      Rework stackdepot deps
> 
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 80b57e7f4947..8c25b27014ee 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -267,7 +267,6 @@ config UNWINDER_FRAME_POINTER
>   config UNWINDER_GUESS
>   	bool "Guess unwinder"
>   	depends on EXPERT
> -	depends on !STACKDEPOT
>   	help
>   	  This option enables the "guess" unwinder for unwinding kernel stack
>   	  traces.  It scans the stack and reports every kernel text address it
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 7ff89690a976..4638c4ece8f2 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -47,7 +47,8 @@ config DRM_DEBUG_MM
>   	bool "Insert extra checks and debug info into the DRM range managers"
>   	default n
>   	depends on DRM=y
> -	depends on STACKTRACE_SUPPORT
> +	depends on STACKDEPOT_SUPPORT
> +	select STACKTRACE
>   	select STACKDEPOT
>   	help
>   	  Enable allocation tracking of memory manager and leak detection on
> diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
> index 72a38f28393f..70794c6bb84f 100644
> --- a/drivers/gpu/drm/i915/Kconfig.debug
> +++ b/drivers/gpu/drm/i915/Kconfig.debug
> @@ -21,9 +21,11 @@ config DRM_I915_DEBUG
>   	depends on DRM_I915
>   	depends on EXPERT # only for developers
>   	depends on !COMPILE_TEST # never built by robots
> +	depends on STACKDEPOT_SUPPORT
>   	select DEBUG_FS
>   	select PREEMPT_COUNT
>   	select I2C_CHARDEV
> +	select STACKTRACE
>   	select STACKDEPOT
>   	select DRM_DP_AUX_CHARDEV
>   	select X86_MSR # used by igt/pm_rpm
> diff --git a/init/Kconfig b/init/Kconfig
> index 55f9f7738ebb..f9a4ec802516 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1847,6 +1847,7 @@ config SLUB_DEBUG
>   	default y
>   	bool "Enable SLUB debugging support" if EXPERT
>   	depends on SLUB && SYSFS
> +	select STACKDEPOT if STACKDEPOT_SUPPORT && STACKTRACE
>   	help
>   	  SLUB has extensive debug support features. Disabling these can
>   	  result in significant savings in code size. This also disables
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5c9c0687f76d..67c388a09b7a 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -661,9 +661,37 @@ config ARCH_HAS_COPY_MC
>   config ARCH_STACKWALK
>          bool
>   
> +# encompasses STACKDEPOT dependencies
> +config STACKDEPOT_SUPPORT
> +	def_bool y
> +	depends on STACKTRACE_SUPPORT && !UNWINDER_GUESS
> +
> +# STACKDEPOT consumes megabytes of memory when compiled in, so we want to make
> +# sure it's only enabled when needed. But we don't want to burden the user with
> +# another choice. STACKTRACE is already configurable (but often selected by
> +# other configs).
> +#
> +# Due to how kconfig dependency resolution  works, it's slightly complicated
> +# as we cannot e.g. change STACKDEPOT to select STACKTRACE. Here are common
> +# scenarios how to use STACKDEPOT with your config options:
> +#
> +# Scenario 1: hard dependency, will select also STACKTRACE, your config will
> +# only be visible when STACKDEPOT_SUPPORT (and thus also STACKTRACE_SUPPORT) is
> +# satisfied:
> +#
> +# 	depends on STACKDEPOT_SUPPORT
> +#	select STACKTRACE
> +#	select STACKDEPOT
> +#
> +# Scenario 2: soft dependency (e.g. for code with #ifdef CONFIG_STACKDEPOT
> +# guards), will select STACKDEPOT only when STACKTRACE was configured by user
> +# (or selected by some other config)
> +#
> +#	select STACKDEPOT if STACKDEPOT_SUPPORT && STACKTRACE
> +#
>   config STACKDEPOT
>   	bool
> -	select STACKTRACE
> +	depends on STACKDEPOT_SUPPORT
>   
>   config STACK_HASH_ORDER
>   	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..56a248814788 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -47,7 +47,7 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
>   
>   config PAGE_OWNER
>   	bool "Track page owner"
> -	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
> +	depends on DEBUG_KERNEL && STACKDEPOT_SUPPORT
>   	select DEBUG_FS
>   	select STACKTRACE
>   	select STACKDEPOT
> 
This looks good to me but I will wait for feedback from other maintainers.

Thanks again for review and feedback.

-- Imran
