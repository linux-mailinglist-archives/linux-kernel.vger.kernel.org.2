Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C239BC48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFDPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:54:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhFDPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:54:35 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154FU4ZT001730;
        Fri, 4 Jun 2021 08:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tWEic1ZhkPe4SB685W8TI3fcRPj/yOUtdS7Pv4Js15w=;
 b=k+KzW1ceqfvHCwXy8l+fW7/Fv9g3gOxxHZgFckO/6cw9sS7xnNp7yIjKbwRLm66UD3Mp
 g/IaNLddAgrEclQWBl5XpIQIxsQD06pYJ903AQ3KcDJFKG71ozTleFXBZE/WpKEl5dEE
 YSFoMDR74LCFZiFIhzJwHOngScXd2r/9Xuk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38ykdkse58-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Jun 2021 08:52:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 08:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/Nushd7/xt+xQYZb7YHDShrKevJZw0hKVmsM2Vj8UnqcrvNJeLHb9wjswG8hjgLaHDg5539B8waSShgHVn3f4YMUSN7TLDNGa/LfZaVLRfiwMgevBA/21WcBlUdGBJkByz3yRrTr6+VEpKtJKz2nah/A9iQSLKMFIfOvVWz0bKxKwr9BQ45ilpAl1wNZOP2AnQnbzuFowcT0qHnTWcf+3bk8v2Gdd39/kzKL3/7sremuGzfQpwxLaLspt9L5E1ZwVjDzgDjhAlZ+2LuvO27zKKHjA98TgD39oITqufeEoIaswWMuRx8rrLhAfPu555Lmm5MnrWZ8WxERohXpAQkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPr6AifhkK91kZJJmX6MtcITKtF/+DKNHk6L68xfMGs=;
 b=LxBAvhwXbEWeWt/kFRxvh9xXruegsfnTpV673Cm+zT/R6/EXGwecbvQDsIr0n60YzT5241ZdQW1emNKWWDioLqApGGlyRAXGwm/lIJEe/5yPy8mpBLVK6pdFIc3LGlL2XHBKPUVXl1ac2NK8AE90YfJ7B5YCWUaJG11bEi6fpBbpEbnFYxnWNmP1160I/zSJYd9mRfF0adDvV1RAjvCM1+iCM9Q80S79e7WN12DKpB7jTmfLgGUMm6V2PyCCKZ9wwGPiQqz+SygFupo0JzcgeMc9WrCKF0yQKtsnzfXokX8G9N5WhKgAQuStgNygzB01ntX06bElr5SPmXaYarLbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2366.namprd15.prod.outlook.com (2603:10b6:805:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 4 Jun
 2021 15:52:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 15:52:33 +0000
Subject: Re: net/bpf/test_run.c:154:14: warning: no previous prototype for
 'bpf_fentry_test7'
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <202106041511.4rHRCtw2-lkp@intel.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b45f82d0-8bc1-7050-a939-4f5791c6981e@fb.com>
Date:   Fri, 4 Jun 2021 08:52:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <202106041511.4rHRCtw2-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:a57b]
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a75] (2620:10d:c090:400::5:a57b) by SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 15:52:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651f512b-fafa-4ec4-61f9-08d92770c406
X-MS-TrafficTypeDiagnostic: SN6PR15MB2366:
X-Microsoft-Antispam-PRVS: <SN6PR15MB23663B4F10FEC3F0CFCF01E2D33B9@SN6PR15MB2366.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:19;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx3V+xDt5wMgDZ2kkyvM9NAFVnUKU3XnBPFu8QShjRWieMWIzaKG0DXGju7Uf24hjPoAWN4Qoi/UBxwgg5rsmvEYHLnVvrPj86y7lME/vkI0MPLChQev0qQaM0+8UuuP65GHlK5j+i7YcUfonHJu97FHbJOdXuhBgkKReCZMXz/6gUYnX770r8OapbeM7N4REId/tvPUuJ54wixrvoRh7x0tOhwEgwsQ9ED9iPDldPmPZ81YyExAtj0dnHNiFyRKV4AolA2dzctVtloOEWFG9WwP0BtfWem3p6dCmHgRn5Pf0ONZelVl+hSkvPuaeek/uIkQ473JD+E+6V5z/TinNXZusUJ4fwXRdtS4Yvi7+z9oZ6BE0Y+W3VFFy5DRBUWsqRyYlV4DJVe06mUZORUWbuYpO5iUWussmhKHhjY0FHFxA/QR6oaO/uvMcqng7QxqsCfWOu4k4wUb+8OPnwCQ5savMXpsmSg691ChMV77Q37N6j/UTLbzti9Tqp3OuH1iG626N8i8DmrV0mpxzUSK6o6DcIs3eulLv/SBR0gE2PREBOTW1R9QeQFZMBLqPvXUvC5KqU+HiQOCT7ClzQJ2W4SH2QCvMteXw1+A8y+VXuQIm/8XqDbJwbq54lhs5CCsXO5aLc2PlYPDqrmKuJTCt1gpC8hZ1oLY3YIvSzMdr0icX8YCmIxaIuFxAmwxg0NxTgl6IkkGUdh7MEnPu2eiNst/4ZEWxUlh71m8/r1mk5hcIjdOS2V3ZeXqaJNIs0ivZ4FYpcMUrKtZIxJgtkc69JnZWlX/ckYz1VYDiWyaWCOEdFUgE6zwfRpf9NuECOvXT83GTS13q2DOU+IRH+523tckuCYc1R2hx/UPOX2nO0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(66946007)(53546011)(966005)(36756003)(6486002)(2616005)(86362001)(5660300002)(16526019)(66556008)(6916009)(52116002)(2906002)(8676002)(8936002)(186003)(83380400001)(31686004)(316002)(66476007)(478600001)(38100700002)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?zRbjhm7tmIBSL9j6nWQawdxcua5vcud77fZp1baQgPOl1Wsea97Xqhyi?=
 =?Windows-1252?Q?cXXZuIwszimJybeVZ22KP8DVqwhJiS+NyUCRLICC27QuF1zwIxskkEV3?=
 =?Windows-1252?Q?dufCTVG45pyNh98dpOc/SMVuiceJBSW9kEysP2poTns2tuGpNjuz29Bc?=
 =?Windows-1252?Q?IukYWV0ACZkkN2JyVSiIjhiTatEy88jTJq4B6kLWCsF4HMWGyqTHXC/Q?=
 =?Windows-1252?Q?gOh0/ddezJ7XN94eWyOal3BBaT4eXkL1lZo1XY+Qneen0dC5etjc8oXC?=
 =?Windows-1252?Q?sCLlMLQy7j+HZeEepEgJ7qCt+C1oV0ShGcDps5UrtCIfPseef9WJl+Yb?=
 =?Windows-1252?Q?taK+OU0MvMNYzttpjSwuf/mEcPZFF6/5fh0Xd8DJ/U8BVSwGsxLoiqos?=
 =?Windows-1252?Q?FACPdYvCJoiVv2coJ+bO8wyV+PJ5aBtDvFhTVQzGkRb/247Ckbys348P?=
 =?Windows-1252?Q?lzBdE8E6e2ibGbBZah+I7GmtnOq+Z940zXQT6X1FDYb/2Ke63LyjFEig?=
 =?Windows-1252?Q?Wqqf/sjklLbbvkhmWpwat8gtFTxgZG0R8typBNtfslPUWae8aOKFBI2N?=
 =?Windows-1252?Q?RqLFC+LJlt5NwTVbjhK6yPog3tcRZ4Ox1rF1YWz8yFktBCaJcPPTV0Eb?=
 =?Windows-1252?Q?KN38I/cq45A5LGJHeu0qrVHMsWdK221tcUExC0Mnh+vrgjw9gKqZ6Bbp?=
 =?Windows-1252?Q?WpndloHM3C8mNTEPRBjT3aUZnzIjN+d64Y3Xid7oJupA0tm2TpRJakyf?=
 =?Windows-1252?Q?hKLQ2RNdccB26lg/9iWHk6QnexQukxDinAd9GpHbX/Y01h4/qX4/O+ED?=
 =?Windows-1252?Q?b3VCGzpD1f2CutfNKVbKxqKeCY5B0B1SFqiRYqiv9wQra6qRZBZs9Mju?=
 =?Windows-1252?Q?MpO7maNwAFs2YIWhHfaQJyYM1QQjKh9O5MFjAT5x5A7Vz5YMaj2ALm7w?=
 =?Windows-1252?Q?Kwx1IrzLTvqmkBVqU1hr2+zCX8I812wIfl92QEhLcu2570SRazPC542M?=
 =?Windows-1252?Q?FsHMHYXZ8Nq0V5YF0bmoMJRoVz7rkfNVNJsRCpHa+HkCrAkL4Thr540u?=
 =?Windows-1252?Q?ExDJbxG3tauDiv9Mk6t9dTIwvIC2ZLc2IiYqZ1WjcrJTrvWSLFejDQKl?=
 =?Windows-1252?Q?VQ+eqst7ZsFlptITkXR57pcwNXaYbdIUMkt/CNI6gldcN0OhA9rXda9J?=
 =?Windows-1252?Q?R1rMXlBLvUIefNJo/P0O7Ajl7SnV8FDgjq4hxPvqUNnRKf3jjq1+FpvA?=
 =?Windows-1252?Q?Sta4zmHjveGhvSqUVtyfbQmy5hEs0Ua9i4hHYwGPedeF5yY/vc7AdWxG?=
 =?Windows-1252?Q?XbBgtuW1ujmYvxd0jnrLrcNnfV05wIRb8HLpMD39YuZMOE2Jb4LVwx6q?=
 =?Windows-1252?Q?JOzFIYhlCFR/NNrceYd6yqAxM8Q4RoEpQElPdUfuRx2lPYUiZxjoKDNd?=
 =?Windows-1252?Q?Tq6+w2hSN7JLxB+FKxcuog=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651f512b-fafa-4ec4-61f9-08d92770c406
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 15:52:32.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9T56Pws075Lz8/zZotjYp5f9q1ILt/pAocED6joX2wKGSz0lqFrVpF9bOWlsnZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2366
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: vYJ9owLfVXTad30sHXCl7in4jqIayZsD
X-Proofpoint-ORIG-GUID: vYJ9owLfVXTad30sHXCl7in4jqIayZsD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_08:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/21 12:50 AM, kernel test robot wrote:
> Hi Yonghong,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f88cd3fb9df228e5ce4e13ec3dbad671ddb2146e
> commit: d923021c2ce12acb50dc7086a1bf66eed82adf6a bpf: Add tests for PTR_TO_BTF_ID vs. null comparison
> date:   11 months ago
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Ubuntu 6.4.0-17ubuntu1) 6.4.0 20180424
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d923021c2ce12acb50dc7086a1bf66eed82adf6a
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout d923021c2ce12acb50dc7086a1bf66eed82adf6a
>          # save the attached .config to linux build tree
>          make W=1 ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     net/bpf/test_run.c:120:14: warning: no previous prototype for 'bpf_fentry_test1' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test1(int a)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:125:14: warning: no previous prototype for 'bpf_fentry_test2' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test2(int a, u64 b)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:130:14: warning: no previous prototype for 'bpf_fentry_test3' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test3(char a, int b, u64 c)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:135:14: warning: no previous prototype for 'bpf_fentry_test4' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:140:14: warning: no previous prototype for 'bpf_fentry_test5' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:145:14: warning: no previous prototype for 'bpf_fentry_test6' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
>                   ^~~~~~~~~~~~~~~~
>>> net/bpf/test_run.c:154:14: warning: no previous prototype for 'bpf_fentry_test7' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>                   ^~~~~~~~~~~~~~~~
>>> net/bpf/test_run.c:159:14: warning: no previous prototype for 'bpf_fentry_test8' [-Wmissing-prototypes]
>      int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
>                   ^~~~~~~~~~~~~~~~
>     net/bpf/test_run.c:164:14: warning: no previous prototype for 'bpf_modify_return_test' [-Wmissing-prototypes]
>      int noinline bpf_modify_return_test(int a, int *b)
>                   ^~~~~~~~~~~~~~~~~~~~~~

I think this has been discussed earlier.

In net/bpf/test_run.c, we have,

__diag_push();
__diag_ignore(GCC, 8, "-Wmissing-prototypes",
               "Global functions as their definitions will be in vmlinux 
BTF");
int noinline bpf_fentry_test1(int a)
{
         return a + 1;
}
...

Unfortunately, the __diag_ignore macro only effective for gcc8 and later.

So for gcc6, the above warning will be emitted. Is it possible for the 
tool to check and ignore this error if the gcc version is less than 8?


> 
> vim +/bpf_fentry_test7 +154 net/bpf/test_run.c
> 
>     153	
>   > 154	int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>     155	{
>     156		return (long)arg;
>     157	}
>     158	
>   > 159	int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
>     160	{
>     161		return (long)arg->a;
>     162	}
>     163	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
