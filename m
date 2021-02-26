Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2A326A58
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:15:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54400 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:15:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QNEb15178819;
        Fri, 26 Feb 2021 23:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vsJAWkUfplzSWkJIroTlF+6AgYXwIIf7XFf15SNTM/E=;
 b=J7tu0PpgO8rYlnRamvR7qxDPbChiNkttigiDv/NymqUWE5MytlQ4BTWRB9glmH76d73t
 wxtv6uldvjy69uqTL9mAYcDXbrgJ6B7A2SChFz5Q5Co6OJnOFKvAgJ5MT7KaU9kf/MkH
 gIssnwEDL70EFZNT8UFJnWEUL42+tV5KaPBx7DV4JiShb2J+xDcuCaiIQNfMZqoFt+62
 Oo6wBVt6n51R5ketz3iTOLGMXBR1rok98tRBIdJkZVszf/uBOzv0c2gtmsDIMkMRqBMr
 kIbOKT3rz51weyqve+svSdhtfcbwHdU2Uw59z7SbKNfOt6ffYgaLdmMHqpYRV6oa1FuG AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36xqkfb3je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 23:14:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QNAKQQ184275;
        Fri, 26 Feb 2021 23:14:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 36uc6wfq1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 23:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On2Dh5fk42zlimaYL3IczaYJB6HM6XmfubEDvkNQC+qd6CodMf8naJDyOZSoXWM+6v255+b3KGdAltTL3olsWc0lxRIsW7w2Q5a1gCe8ACDyHuqO24dsqqoOOIiXZVTzymJT6YNjcvGrmLJ+J/QSTL09gHoeUd2qy6+WJkX6DSqIriXIpE9ihNVfgm04Hj7gYGGgZq+RMopGtrrjhcWOQrJGvw9zxHos0sQ04afx/tzLpZ2ni26Cp/8+0sKM0ABIH+jptoZsfAElWb1SIrSSmEYWb1lf+fWCOu2FeYchPUk+lr8wAX4ibleN+Yf+dhAXgRHvOm5Z1bBtm9oCkE2iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsJAWkUfplzSWkJIroTlF+6AgYXwIIf7XFf15SNTM/E=;
 b=UfdPmQckRfk1GvMBEMoy8B/2F8K4RulFOz2UkVZfw/6D1uVBoXJlnZWiaEJQBTrTHnfX3RZbtfGiV75egH1vRqN0rnIhJ2zI51kTxJqd+XPVXgeTucMxp0Pcvvl0PyrTy4afrrohhcVfAf7madkjNtgwfkRdP+kKlbskKmFlrVxqqg+4E1nz5scOY4GkSOqTsLMc5PL3LdLRZ8n7lLo4EKCKonmiOMCvfZqnWEhPmI00GEjYLQPhEX6P12uw+G29+sBXzme0debiuRMfTd2a9HfG8t2kNyQuzkXZnzJVigxVyL5KzpSSwyfXQeJzMF6OsDinNlCH58TSSV9e+6hMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsJAWkUfplzSWkJIroTlF+6AgYXwIIf7XFf15SNTM/E=;
 b=i729ZP1DO8oYgJI92H9R4hOY+ABKVHAfkVgC028QaTQb9WHF+BJcOblJK/Mqk0hOnG3+m5HOekptbVTtoXRGrtYDA5enwIZvw36rt4v+w3LTHoyHcth+GbiPjJ6h1eJJT5MiB7eq7JnRmhfXuunEh85o9jJ0NyJyMxHzshBpOUU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 23:14:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Fri, 26 Feb 2021
 23:14:34 +0000
Subject: Re: possible deadlock in sk_clone_lock
To:     Shakeel Butt <shakeelb@google.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
Date:   Fri, 26 Feb 2021 15:14:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:104:7::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0118.namprd04.prod.outlook.com (2603:10b6:104:7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23 via Frontend Transport; Fri, 26 Feb 2021 23:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c082ab-5f44-46b5-fc43-08d8daac4772
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4671842C550A152CBB43FCC9E29D9@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdInOj98bYaTSO5zqfyQLEcYy4uNMBpop/zkqwRkFcdI8aq36USJ+u/gOgrsi3Bq7008WE8ZDAUplGXWEfcfx1engzei/CoINZBXCsVKj6EeM02nhlec+chz86B1NQhCCXwt0Ly53B5cdjRqo/ADCVYcuT6vJmQfOdnqIR1R6IPlULKts8d57ywmcPIKuhoDlKtmnMonuGy03RJGcbPM+pxP4S0RVHK8ABacpzrYmyXxh7gLVBsz47Lk2j0QE/RRCK21a63qlaGaHe/Qt9BOy88lGpUrj5L4psz15TPHIiCI2QB3kyd3suSpieMykr7LTxIuAFUZ3TJ0OgVqaTpJ/JnmKTi/3SnH2qxe/h4Mee4/mwaIjtWsKLCf+IVkn9uaboae5WqR69IOLk3HPLTaVjoK78j4bs9l0I3A3ggqZGzTGCoWl+iQ0MxNAaYvrw4tITpgKgXWpQzOYx3w8seDFkc2ESwlyVJvsIerjUO2BPH2+9+WcMtsCsBbSJx+ccteN5OvaYoKqYH5bsBCxv/P1D2uP5BgEbia9fEkGQN6eempXxR+5daRGhDQtnO0OWz43TZr9z1FWSLUxZwnJkfCnry+ZYyCOf6cwnVzHMtd0jQyg5xd6GuT4mb9AyBkcNAz5w6kdDtE+SXtc7RKCj1xscIUo1w8h9OMlEnQdXPWTdcX+ZQ78qCelUISIjE2tFUZcqJdanlirjbRqxczu82jaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39860400002)(136003)(26005)(36756003)(6486002)(966005)(478600001)(4326008)(316002)(86362001)(110136005)(16576012)(83380400001)(53546011)(31686004)(31696002)(2906002)(52116002)(8676002)(54906003)(66946007)(186003)(44832011)(16526019)(2616005)(8936002)(956004)(5660300002)(66476007)(66556008)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2dGeitpWkcyRzJ1M0V2ank5Q1RaZ09zSjI4UVVPNmhXZkVNZnVDbkk3dnJX?=
 =?utf-8?B?RDk3Nmx3RkpiTnpmbzVlUzU2OWtlQzRMelhjQVhWSkQ2RUZTZy82NlZyazVH?=
 =?utf-8?B?NmpGWkVIUWwvMnJQbUVWYTZ2MnJ3MEU5Mjd3anhYREdtZ3A5RlhaV29EM2My?=
 =?utf-8?B?NGVabEN3cWNhSXRDVysvTHVhdlNIcEFORytrZjBWdm5WMS9qb20xRDlDQTBt?=
 =?utf-8?B?YVgvODVuUmtNNGNBVEZyamxXelFycE9mb2lpMVJnZVRWajRDYkdqTmZzSXpU?=
 =?utf-8?B?V0o5ZlFQUkVXdmhJWEVWWEFicjdlejQ5OG8rMmFOaUUvcGJ0RVJWZEpNcjlT?=
 =?utf-8?B?S2M3eVpNY2huVUFkbUhoMDd2NnBzRXhtQU4wSkErNnVmTENYeXZ1RHlWbVdR?=
 =?utf-8?B?OEU1R09QVG42Sm1meDEzOXl3aWYxb3dIMjFrQkVBR28rVStwL3BUQXZDd2tC?=
 =?utf-8?B?QnJpcUl3NC9jZVdDb3NsT3Z4b0JQSU9uTyszUWo5TjJKcktZNzhCOC82Q0hv?=
 =?utf-8?B?bmRSS2l1Z2xWOEFQblduOTBpTXpjNFV5TFAvN3pZNzVMYmVoZnRZK0F6ekRw?=
 =?utf-8?B?cWNOUlBmRzV5Vi9vc0RzcENBK1IzaEREa1hRUnkwQ2FrK0pXamxKL3QrLzM0?=
 =?utf-8?B?WE1jQlBJbVBDbXAzRU1JTVJSbHllcEIvMjVENnUyczA5UjhVNFIwakJJTHIy?=
 =?utf-8?B?bzJtN2t5WXZFc2lUdm0yMzlHMFFZMzhIQ21pSnI1c1hKS2lhZnh4N0NoTWV5?=
 =?utf-8?B?NG9hakYwd2lVQlMyYWZpMzMrcURIK2tQMmJBZXdtSmtyNDk2eEtYMVZiNnJN?=
 =?utf-8?B?NmIzMUVIZU5UY0dVdjJQNFUwQ3M0clhiTEw2d2FUS3FCZmw3bnJIeTVydUFC?=
 =?utf-8?B?N1k2dlhQT0xkNHVpdG0rWFRPc1pXeFN0N2grTklHelYwa1doQWM4ejM1akxw?=
 =?utf-8?B?UmgrY09SV0tzdUVqdzFJSFNCRXRqY3dUbWNDcksyR3pONWNWRG1iRzVKOFFw?=
 =?utf-8?B?VmJlbTVUK1JXRUMvbGFxcGtwUGtqNlVzc0FyNWFYRkZHYkpsU0tiNlg5V01R?=
 =?utf-8?B?NEZ0R3M3ZHFLNWhnbnRpNG5KdkRDSHM3ZmlNQWg1cFhlRDc0dmhRSG1zWUxW?=
 =?utf-8?B?dXBvTnRxNGtuNUttdGc5Q2x4U3JRUnpUUmVmNlN4NUVSYS80Zi92WDRXWElz?=
 =?utf-8?B?YUdLUUFBeW5UVmQ5elRKNWY3RlBYQ1ZGRkw4NGs4L2hSNVlIQ3d1ZnFvYURZ?=
 =?utf-8?B?c0ZCZXBGYWd1RlQvcnJsaG1hMHovQ1RpUVAxdGNXdHVTMmRPOXIzcmJITU0z?=
 =?utf-8?B?eVlzVzBIc2ZOVzEyU2t3aHZuRnFFMlUrclhBcTBSaG9EdXZ2ZTlvS3U3Zzd5?=
 =?utf-8?B?dG1iTlJhaGpLMnk2SmkrNjRRUkZWdFltN1BkeEJNbzMzdTFTUUY5endBTGNN?=
 =?utf-8?B?ZGpmMDhDZTQ4UXMwQStxK0tKK1hGVDdreWVDZUErWUNpR1cySG9aWmJMODdF?=
 =?utf-8?B?a2FrTGNwOElYMEQ0SmdaU0thVkRGTkx3S2dQeGtRRXo5TEE1Qjk4ZXRWdExU?=
 =?utf-8?B?bEt4Q1ViZXhJWVFaeFB1RC9IcjhpYVllc1dBR3RubUdYY0Q1SCt1VFlVb1Vk?=
 =?utf-8?B?VnNiQWc1QmhUWW4wc0xMNW12LzN6eGF0bFk1YTJSMGF1MlRLRThhVzJoeDZ4?=
 =?utf-8?B?bkNVSnZidmpNbHBlUll4OHN6WFloTSt4L3pobmN1UlMyb0pyQ1NEV2RkUStu?=
 =?utf-8?Q?oj+GnhxwEmNXSi3OKnCpArWVnywovJ1osi9x2Jl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c082ab-5f44-46b5-fc43-08d8daac4772
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 23:14:34.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHL5EBApo7+3SnL4M7Nh5Y/TfEVj0BfggpuyVFa/YxXU+MIF18oDyva2tEKLPwmcmN6otvXpNz3ryfxhhXdGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260172
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Michal

On 2/26/21 2:44 PM, Shakeel Butt wrote:
> On Fri, Feb 26, 2021 at 2:09 PM syzbot
> <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
<snip>
>> other info that might help us debug this:
>>
>>  Possible interrupt unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(hugetlb_lock);
>>                                local_irq_disable();
>>                                lock(slock-AF_INET);
>>                                lock(hugetlb_lock);
>>   <Interrupt>
>>     lock(slock-AF_INET);
>>
>>  *** DEADLOCK ***
> 
> This has been reproduced on 4.19 stable kernel as well [1] and there
> is a reproducer as well.
> 
> It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
> wonder if we just need to make hugetlb_lock softirq-safe.
> 
> [1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93

Thanks Shakeel,

Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task
context") attempted to address this issue.  It uses a work queue to
acquire hugetlb_lock if the caller is !in_task().

In another recent thread, there was the suggestion to change the
!in_task to in_atomic.

I need to do some research on the subtle differences between in_task,
in_atomic, etc.  TBH, I 'thought' !in_task would prevent the issue
reported here.  But, that obviously is not the case.
-- 
Mike Kravetz
