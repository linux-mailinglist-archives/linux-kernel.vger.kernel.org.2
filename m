Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558BB3EF821
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhHRCgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:36:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15506 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236690AbhHRCgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:36:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I2WoQR011874;
        Wed, 18 Aug 2021 02:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dPt/k0JUpKQRb1C7fGK1qWbuR8s7589egfa8eqwpLQ8=;
 b=snMy0NckksxM//QlpG8+Gk7X0r0loAAVaTl8/XzBmYr2274xKrMJnP7qrpyEyHbmmTX3
 QTTgwBi/0Hg6FwU7kziRgDIhhHVw/QCulZ9X7gL44D3/3hJNzJTF94+FdQLHYY4VGuE9
 YobNij4VZH4jd1ZriDV5KJEuajDOm165Y0xnWqxNP0aM6l9BSdbpR/g4Xip4J+IlLKz9
 H4/P6j25PRrno98yeNW2wewDEqvyqhEFQN4X3sqcphITt934CmtYZPM9zWtp1mbqr+J0
 3PuMMIDTjBB4VoRyMMYr391igv+Kco0luQ11bYCW0Glc5KaUyWnLoNUUNsrFzdy3QUss cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dPt/k0JUpKQRb1C7fGK1qWbuR8s7589egfa8eqwpLQ8=;
 b=hkjmwblHyF/DZSU5xFtB2rWtLDSSHEWGIkJRV7fLKsdZT5XGeknURitSaQM2zRAAUYkh
 R+3qQ1aiYitH7dGlWlpDmtAz5yIBeU2EnVFp9DqoeYgRcB+JN2L1dqnutoxAlOLJ6j8y
 olWaUFyejZKThgmS7qklqsVUrH6r7PL/W/0MIITrQlvkso3/r8t4PutLMkRl//Y4iPou
 EmoEUvvo+yd6bXOz3O4gL0aVQ1gZTH8XrhlOUmUDuQ5Li0Y7pgHtDgG1U1LPN1Veezi1
 YzrDArlQfgx7MwIwV9vdYwRVOJMWsdAFd7BjR+wVjQvDIkEmrA2+N7NmMh0GEWKsOcWW 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf1q5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 02:35:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I2Up3w065083;
        Wed, 18 Aug 2021 02:35:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3ae5n8mmtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 02:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Woc8kTZRnH4mShYm91eq4tV+FotMYXiOnvnixFEh8nlfO7p7xD+NG/iWxfqdhpBsJYsfRNezlRP5OUc2O6RBROfLUwTDf6myuHwETpxLHPkX723Uw6fTl4ucg0T3CghpBlUiqaOp/oXCkwaOrXQzwPZnrkh0tSGdIFPkOcoZvz+TNBhBVdFB63JN+/iJ27anIiW7trMp2fzEznIJqfdKCHTOyRJZiaH1hpSno6MylgPlRkMMQ+2gKFTG093P0ecWP7cRJRRVRqzj/jDTpgAOHznP3cahG9G7yMPzr9m06y5dHCFZ45qIqH8wQ3Q2S0RvVkMrYpNJMuTbOncR4evm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPt/k0JUpKQRb1C7fGK1qWbuR8s7589egfa8eqwpLQ8=;
 b=e6UobpiuM/8AOcApDwXPH5SxZzq36pAX3Ckl/i95ZkWV1qc30hjy7YBUiNyRwE6rQkT0LOOS6IBfBlLJahj7NRsLhDLWtYzLX9zGRLgG+wYPSddpRGad1IivRts3hrx7Di5E7PnLAhiJb5VoPxaAxPjteb6ytT2X3vjk9erU4cK96SqCpXQi/DnvyXmyjkqIbcx85VwRXj50TX4MJSh9NFMrFJa+IIfR8pQYtV2agQhYfSfmSuTYe6lYz+iMoNtmt0wH7YZc2rLe7bLC/xqmDIiMDIgVvtYveaeGpZqv0gQ+2I9Q7WAvNu+UkLrbIzIpDBdMrgw2KWUXAPj+PeCAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPt/k0JUpKQRb1C7fGK1qWbuR8s7589egfa8eqwpLQ8=;
 b=saa2GT+BQiO8vghBolfWG2P6TL5VsxEVBO7CXl3VY7vwpglnAtcNf2MorYqYdAnWPjEdNCT1ZejvCGnq4MPxKUJO9WGzo7FNL1USy6HtKl2uEDeckhmHJY5ffGCjxAShOBgXUbL6JUh/RPAQth3i1DuhCjf0k96FMIdhLwIWeRI=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 18 Aug
 2021 02:35:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 02:35:55 +0000
Subject: Re: [syzbot] kernel BUG in remove_inode_hugepages
To:     syzbot <syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000050776d05c9b7c7f0@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1ced323a-6d83-3d2e-c974-71ee3b425519@oracle.com>
Date:   Tue, 17 Aug 2021 19:35:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <00000000000050776d05c9b7c7f0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:303:87::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Wed, 18 Aug 2021 02:35:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55db0bf9-29a8-4598-b03b-08d961f0e799
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4574:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4574CD0924DECAD0C516D0C5E2FF9@SJ0PR10MB4574.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUaAVsVfYwy7L/P1E3xjsiCZr4vle/3+WhgP7wFqiR171627MH0GpMidPnkr8gxYFasXTHUyVXypHjExJbmsKlCXeGJeJmcU5Fg18EB5TOzfiLwxClQ0XRx5xnktl6ySPJVJiPdh8o9GP2mulwx6xP6nzt+1TVFFVnjSYpom9q4zP2slPVFUVwqE75SsDXboOgbjE2RqvQ0S7diEpsMZ5U0J54nbDJJWJdOQuLZ9MOPA50iZGDII0r+iroli52SVE2kC6Q94uE4PhCZIZdqrDzQIoUveMLa8XM0PEJEp59eXXkvL7G5qYGDjycQJWP5jQ78OL0+tDCHj2LhUxA43BZrqjoQjZ1rQ931AwLFQ0ry0leRXzXQOTnuujMCO6fV7bOPHtIIxmxQEKbEC3kjgbL6CA3y3leqTsNt3PmA+wMjBrdRQs5QkxSVVvriul7gmm3whNhy6vahdWmBZLGtjgrEm6iZsvVkgveDOVZInKa/GE/3MT+1wGioNHZdcBJGhxMHuvSpuHSiuUNVCj+cPdcNwflwrSq/yiQJJmtDDaLCETGPspcrgSKJsw1ldZlm9sDnJrMJ9BquDTOYufnuecO1MMboaXgJZtB8+2CH3KIKSwlXGc2Au9WFzZSqBHxAdTpCd0jzGnuQVp2LBcy3s2PVMxHso9jhaC+TQdx+GWhNa2xn1kJ32U3Yng5luPYluTUyh4bbFN78LFXxzjIxo3ZLyC/6qq0gEytXoN/tZ9srm+OOfziLZG0G2MPd2fv5F12tz4DweMbm4gb8Gqp2yzbwbjE9+Ymdt9NZdsmaPk27YqTpO7Aw7mGlbL7OdwLhezqT9FQfCkqtg5SNf5Ldn6TS1Nir2dOCqweyoS6fWJMD9j+75sjWK27XZLlk1uY5p7yncvp5dLLJ65K8Xip4B5h1e79cpLAxqDvHwEhMfVOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(53546011)(86362001)(26005)(186003)(5660300002)(6666004)(478600001)(966005)(6486002)(31686004)(83380400001)(31696002)(36756003)(38100700002)(16576012)(8936002)(8676002)(52116002)(956004)(2616005)(66556008)(2906002)(38350700002)(44832011)(66476007)(316002)(66946007)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGh0WmRIY0llbG1LWHpwQldmdXNBNldVUXJRK2x6VFN0d1FhSmZ5Zjl4VndV?=
 =?utf-8?B?bHBYdkh5T1RyaDlIV0ZUVlJ6aGx1b0dZMk9WODNrbjBhcnZaS0ZQbUNoVkdn?=
 =?utf-8?B?T2pZUlFvc0RLbDhqakJ5d1RHTUxaUWhOVGFTb09lKzZlbnU2T1l5d1RKTk5D?=
 =?utf-8?B?MkNuRkFNVy9rdi91NERtdWdvZHJBOXdsdWYwaFlaY0h4b3lZZGE2cm92eE5I?=
 =?utf-8?B?cWVmNVRGUkVicEU2b0VlOEdNZGtsYlBjRSthV2xXTjlDNmZLZTNRdGl6ZWR5?=
 =?utf-8?B?YjBZVy9EaHVNcW04SmNZZGtMNC9GRE9tZjBFeEFQOWt2VWtkb0VsY040QmJy?=
 =?utf-8?B?SkVPUHF5alhPT1JnellQQUx2M1grQ1ZIbThmZUtTUVJXWkF4aWVRMUNQQjNI?=
 =?utf-8?B?V1JEdDFDS3loK0VGaXg0L3VpbTUxSTVlTjRxcEpmL3JZczdyUTJYRDRDdnd5?=
 =?utf-8?B?VjVNOUhwNUFLbFBQTk8yenc0M3M0VzVybVR6Q1grWVJ2QjRkVjRFKzF5U2Q4?=
 =?utf-8?B?ZVJXUjR4aXp2bGs3NlZpTyt2UzArcCtVMHdSSlpvdUZKeE9uR1dLU3h3V3Vs?=
 =?utf-8?B?Wm9KbDFCMzVzRm5qWlpjdDBZR0pQdlVSa2RJbU83UTNVckhhQ1JqTXVzWnpw?=
 =?utf-8?B?UjJ0REcxMWJGMWRQVCtFeDg4RzV1S1ptMWMvQllUdTdKMlZEMk1TbnByMC9m?=
 =?utf-8?B?VGYrY1k5NzVLTHNwcEpqajJ1Z1BDV0RqVjcyUlpHWXJadXZpc2tXVWo3QTdK?=
 =?utf-8?B?Zk1JQ1d5OXBIbCtvaFFqMFlhTjR0cUtWRHVKL2VMNC9OekUvc2YxNzRtNHhs?=
 =?utf-8?B?QUlFU2tuTlUyT0pOMlhwaUtpTTY1c00veHY3RC9sS09ldU80ZWFaaDg4U1Uv?=
 =?utf-8?B?S2VYTitTZ3g2ZUpvYThDZjRaaS91ZHlvMW5NamtGRFpCd0psb0R3WU5qS3Zy?=
 =?utf-8?B?eEJESlVSRDRVYk13bXBvV1g1TTdJdmZERXBlRXEvYmFLSGFNcU1taEppc0Qr?=
 =?utf-8?B?MjF2bWxZNkJMYUJtNWoxL2pJczVOK2Vwb3lLN29wbFdrTTc2UnZPOURJTXZj?=
 =?utf-8?B?dHBaMlVGTWlBdVNyTjVKZWtxeHNjRU9NNzJybzlvSWtRVWhuWmMrbEY3VDBi?=
 =?utf-8?B?dHo1VmVzZmREcjBHT0lXNjUwUERNR1YvdHV0YzJMM3dxVTJCYTBtUGVFeXBS?=
 =?utf-8?B?ME9ZTGRlQlJHMHhXc3J4cXV2c3F5YXJnRTU4T0szRWtUaUtaY1c2dTRFV3Q1?=
 =?utf-8?B?eHgzaWFSSTgxWGliRWw4eWtUNXNXeFNRZ2F1b2lWWnBWaTRqaGR5bVRNcGRX?=
 =?utf-8?B?NGYrVFpJZjhaKzFZU01VVm5wa0xmMlUxRmkxVzVqL3A4SHlZQkNya1h6d2lz?=
 =?utf-8?B?ZGRwdnpuTHRhWVBPSVBTcXhGVlcyZnpSc0NyM0lSQWQzTTVNazJYVG9PUlV4?=
 =?utf-8?B?WkVXc3c1WSthV3lBRi84M3A2aU9RZDY1b1VLQjB3dU8wOTNRaXh2dEhzWmxl?=
 =?utf-8?B?Uld1T2ZyNzVNUHl6cXphZXRwdWw4TGZyU3JPS0s2ek53RkNaVGQrbHcvelVM?=
 =?utf-8?B?STFRcUVRMUZqTTN0cjFNdWVteWZWNWFhK05DTkhCcTg3aWVtSG5LWEJSL29F?=
 =?utf-8?B?bXY4bnVDMGdGQVVzeFBzQlVIL0I0YndrSU1DN2gyVFJKMVJDY1pvemR5cHRY?=
 =?utf-8?B?dUdvZk50MGplN3VjeVY5VDhwelAybDQ1NVZkdDhxTWVtRGVjQlF2RDBHU1VT?=
 =?utf-8?Q?lWZEiopzvZmKLk+COT5A9EuCMTqew+xT/OGZUVs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55db0bf9-29a8-4598-b03b-08d961f0e799
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 02:35:55.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv58tfEoxiJG6XGAq9luPDdO8HRptBsCTIp5DOpLzI0o0ZzvGN82VDExbMzmCXhRRhIsAJDcI04WkijqEAqRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180014
X-Proofpoint-GUID: 08rfquOpJjbkAn8dZvACPA_-OASyKL-g
X-Proofpoint-ORIG-GUID: 08rfquOpJjbkAn8dZvACPA_-OASyKL-g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 7:07 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a2824f19e606 Merge tag 'mtd/fixes-for-5.14-rc7' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=110d54ee300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
> dashboard link: https://syzkaller.appspot.com/bug?extid=67654e51e54455f1c585
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12eeb6a6300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13515779300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com
> 
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffedef26928 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000043f589
> RDX: 000000000000effd RSI: 0000000020000680 RDI: 0000000000000003
> RBP: 00007ffedef26930 R08: 0000000000000001 R09: 0000000000400034
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
> R13: 0000000000000000 R14: 00000000004ad018 R15: 0000000000400488
> ------------[ cut here ]------------
> kernel BUG at fs/hugetlbfs/inode.c:532!

Let's me see if I can get syzbot to test it:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a2824f19e6065a0d3735acd9fe7155b104e7edf5


From 39f8d6a86215f980ba27a9618b8ec2eed4d9a963 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 17 Aug 2021 18:59:58 -0700
Subject: [PATCH] hugetlb: don't pass page cache pages to
 restore_reserve_on_error

syzbot hit kernel BUG at fs/hugetlbfs/inode.c:532.  This BUG triggers if
the HPageRestoreReserve flag is set on a page in the page cache.  It
should never be set, and the routine huge_add_to_page_cache explicitly
clears the flag after adding to the page cache.

The only code other than huge page allocation which sets the flag is
restore_reserve_on_error.  It will potentially set the flag in rare out
of memory conditions.  syzbot was injecting errors to cause memory
allocation errors in this specific path.

The code in restore_reserve_on_error is doing the right thing.  However,
there are instances where pages in the page cache were being passed to
restore_reserve_on_error.  This is incorrect, as once a page goes into
the cache reservation information is correct.  Even in the case of
error, the page will remain in the cache and no reservation adjustment
is needed.

Modify routines that potentially call restore_reserve_on_error with a
page cache page to no longer do so.

Note on fixes tag:
Prior to commit 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error
functionality") the routine would not process page cache pages because
the HPageRestoreReserve flag is not set on such pages.  Therefore, this
issue could not be trigggered.  The code added by commit 846be08578ed
("mm/hugetlb: expand restore_reserve_on_error functionality") is needed
and correct.  It exposed incorrect calls to restore_reserve_on_error which
is the root cause addressed by this commit.

Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functionality")
Reported-by: syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfc940d5221d..8ea35ba6699f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2476,7 +2476,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 		if (!rc) {
 			/*
 			 * This indicates there is an entry in the reserve map
-			 * added by alloc_huge_page.  We know it was added
+			 * not added by alloc_huge_page.  We know it was added
 			 * before the alloc_huge_page call, otherwise
 			 * HPageRestoreReserve would be set on the page.
 			 * Remove the entry so that a subsequent allocation
@@ -4660,7 +4660,9 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
-	restore_reserve_on_error(h, vma, haddr, new_page);
+	/* No restore in case of successful pagetable update (Break COW) */
+	if (new_page != old_page)
+		restore_reserve_on_error(h, vma, haddr, new_page);
 	put_page(new_page);
 out_release_old:
 	put_page(old_page);
@@ -4776,7 +4778,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
-	bool new_page = false;
+	bool new_page, new_pagecache_page = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -4799,6 +4801,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto out;
 
 retry:
+	new_page = false;
 	page = find_lock_page(mapping, idx);
 	if (!page) {
 		/* Check for page in userfault range */
@@ -4842,6 +4845,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 					goto retry;
 				goto out;
 			}
+			new_pagecache_page = true;
 		} else {
 			lock_page(page);
 			if (unlikely(anon_vma_prepare(vma))) {
@@ -4926,7 +4930,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	unlock_page(page);
-	restore_reserve_on_error(h, vma, haddr, page);
+	/* restore reserve for newly allocated pages not in page cache */
+	if (new_page && !new_pagecache_page)
+		restore_reserve_on_error(h, vma, haddr, page);
 	put_page(page);
 	goto out;
 }
@@ -5135,6 +5141,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	int ret = -ENOMEM;
 	struct page *page;
 	int writable;
+	bool new_pagecache_page = false;
 
 	if (is_continue) {
 		ret = -EFAULT;
@@ -5228,6 +5235,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		ret = huge_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
+		new_pagecache_page = true;
 	}
 
 	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
@@ -5291,7 +5299,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared || is_continue)
 		unlock_page(page);
 out_release_nounlock:
-	restore_reserve_on_error(h, dst_vma, dst_addr, page);
+	if (!new_pagecache_page)
+		restore_reserve_on_error(h, dst_vma, dst_addr, page);
 	put_page(page);
 	goto out;
 }
-- 
2.31.1

