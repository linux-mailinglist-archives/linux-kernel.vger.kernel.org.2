Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4EA32316F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBWT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:28:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45832 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhBWT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:28:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NJODFa022360;
        Tue, 23 Feb 2021 19:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=e/FRnLYc1wNfiLVJyE+lwLvcUoSmmD9TsTJJinq1NzU=;
 b=RQY7RReDsT5gVHIiM60Kj02SeTUtHaOM+zqNE51VywG7K/yMO30Z6lqHMoQUHDShcszW
 G2XhktrjZnoGENpNhcAlQ24lvt1TgFzfqyEdoErLsVeEXuTQ8BDhBxk8SQI/4gTxnA/3
 iACnA++Nahe1aWuHvcKUXTpzIiKyPaRlOuEp0NQMippTzBl/3/SrYBLXDMaWeYjFXTQI
 IXatBJHmaUeBafD4lmFVs/dPaqmGfiUZlP/2qXiW9o4q0Dtbj/L2rmWS6uvK3l7iR1j+
 mLwnLp5jA0OhcOyTdvQF5jRlv2+hZHZXd8tvsuXbRCePVMAt5uYX5uG+Lb0bLVHKDWsY 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm8jfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 19:25:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NJKSHJ170445;
        Tue, 23 Feb 2021 19:25:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 36v9m517cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 19:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChGhEgt54euKkI0auAoTzqhWG0R+meQ0TwPihuzUzabU0UovDbSfXPsNoAPiLhm+jABmleDfwQBQQX/OIAVK9UMDjtrQnDlz4VovcvZyIyGe4CXBnCojHqmYt8HGOAqJIEcKmI0y5qdzoT//hNYJ5Elxchf0N8Zt5S+md7bOSOWklim4Wtnpt7X8lvnd/Mq5Czs4qb2JetqsjQ4hRppw0Iief5JuaXhA/EnSg3JN6U3QmH8U/Dth5K9AC87lmOOgl/oXXY9ZjnKFEIVi/O1z7V68S9DQkniyKmiTCx2HwradjW11YFUFkB5aW1U6qu5rxa6F2w4A9Z2ZcTBv/dZp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/FRnLYc1wNfiLVJyE+lwLvcUoSmmD9TsTJJinq1NzU=;
 b=i0iK1BRGy4wyRV22GXvviblcP6v1EPIpcCAGX8cg73QjcFTX5YU7NG69m8yMR2tvwpje9Tlg3OsbcqSITDnjc4Ood2EMnKCaAgW4sthQ8efNmCj9JjB9+pB9Yzk0FpPrFNpB6EWBYbFlpQFxzwgsKCHGGvZRzdS0oZBXW+1xPCAdE22zK2l6t93KyXgITu9nmp7tacWALQlUk19i7I5fr6TEWa7ZAI8yA4tLeOuWTqgmB6+NeJmEkEXUdVZJephhC7PgxIrLvZiRhTyaNajSSeBqdxw3kvn2FseYsQGzQAOSkKf3voMP80rVJc1nx2hglf2j2IpT22NPxTMwoRUNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/FRnLYc1wNfiLVJyE+lwLvcUoSmmD9TsTJJinq1NzU=;
 b=TNEuPubnYEd4uca9xW7BSlmrOVWyPK+RihB/PT/0zchgS/hhQIuj/Bq6z+lt/6/79wBWFt6rYGus5lhhThy48PZN72PZ4KdzzfSwolOPS3UFXz4WTKF0zXgLDnKQ2TFxz9KtSwdZxJbWPYNPmV3wDBiAgj6NikhUhNd5RuH/NLY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR1001MB2160.namprd10.prod.outlook.com (2603:10b6:301:36::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 19:25:25 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:25:24 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
Date:   Tue, 23 Feb 2021 14:25:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
Content-Type: multipart/mixed;
 boundary="------------DBFD54D6A985E2D9E97A092F"
Content-Language: en-US
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:610:e6::13) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 19:25:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9163fa-2803-48a5-36cd-08d8d830c4c5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2160827081D53FE04850E2FE9B809@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgMh6S2qONYdq8UazOWxbKztVcEptjvp6AO1P4PBrD2gflh1wK5pyOwdAy4a82FzWsCIQuOz5pdl3NeMa1i6H41kqWoxnl/8xYVv+/2XzA0OH88encIWbE/6e44cmnvMXy83LYWIXXYT4+TGQ49t+mGYdpfbh2TIdWA53mbFuJTQkorEnSVHynEt10Fe/VxuFwiRRMkBqpzAGj+2KFe1AeixqZLF6FEYbFuNHDFlOHAjZFeVesZ28QA5EJv70gicCcYhxIMflHDiWERnUgOcVn5Lc10iF++2f0FjbSM3K1tU3uVohn8hGyqSVDxM5r3MVq9hhm6Odv8+rorD94zWEnXG+rA48XgecqIFoArq6bNKLQcrP+IpmTzOxTyxf0N73/7kdKbl6FmlAum9Q8DvNpar8RxxBnG31BH8wv+XI7tUlu+3AXUluAdr1kqbJjibLhCJffRYP1Gx6+QHUEe1JUfJtFnyfqUC0YNsYBvdQrdJtAnjs0vtKCaVSenbH7AeF1emTIutGst4aVg61/ZRR2SOf6L2BZ8FHi5sBAfej8TOfZ5y7HzhddidpVfpBty/r+VJd+s34z+8VwJ3SkYDFqLi5AjrbNg1rl4LtJHtLYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(16526019)(186003)(8676002)(26005)(478600001)(5660300002)(235185007)(31686004)(33964004)(4326008)(2616005)(8936002)(16576012)(44832011)(66556008)(66476007)(66946007)(53546011)(54906003)(66616009)(83380400001)(86362001)(31696002)(7406005)(316002)(7416002)(6916009)(6486002)(956004)(36756003)(52116002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGhJTWxlRUVUaU8wMENpYmQveDRJdDJIWU1Na2FJR3RLKzFlNFVrdDFndUY1?=
 =?utf-8?B?YU5VQndLeDNsdDlINHNKY3F0aDJsTWxEQ2d0b0dmQjRQdWxGWE5JVFBLZnhl?=
 =?utf-8?B?dHBZVUc0Vm9LMnB6QUx0K1NsZTErVHlZMVgxMll2eW1sdWluaFk3NlZCZW1m?=
 =?utf-8?B?QjdRczZXYkxDM1Z1cjJCb0RCOXNvM3RuejhyVWVKVlRyLzhzOVVWWFhDaC8w?=
 =?utf-8?B?TTEvdE5JQmdXM01MSENOR3NOZkh2RmNKT25IaXZVN3R2aTZURDIwMnJnZVpM?=
 =?utf-8?B?dnR3bTdjZHNqaFFUd0todXR6ekJ2WVBpdG54RWlrZjY3K254b1A3aVRaWXl5?=
 =?utf-8?B?TkZlOURHekZzaWYrTEhLS1VIbVEwbVRDWFJ4ZXhIejV6eWhaS1ExSE1LZ3k0?=
 =?utf-8?B?OUZNUWlsMTRRcFZEV0hldGNGQitnZ0ZERlRkVXVOWlpYTEFGZm5MQ256SkFZ?=
 =?utf-8?B?NEx0RlNUSDFyRk5NT1pkT3FkN2NqK0F4SlhYK0x4TU9wSUhMVElONkVkQ1BW?=
 =?utf-8?B?eGRzUFFLcENvTUFTNENyM3NUQklSK0orUG9LUDZhRGZsYlNtVUpKUGc1V2lw?=
 =?utf-8?B?UjUvVjFFOWRNa1VHeG1BVFczckxKK1U5RFNQS1BOazJ4cWNzOUpuWmNpTjBp?=
 =?utf-8?B?QmFhdXRKRHdSZW8wYWg2SU5YZ29lN2FVb0NVQkxZbWIwTkl6WjI2MjlIeW16?=
 =?utf-8?B?UUY5em5IWFA2LzZ6V3pqREo3Vllwb1ZpMFlSZW44d1pKa1lnTEhBNkcybEp0?=
 =?utf-8?B?b1kxU2ZwWjRyMUljblZhZFZPWE90Vlkza0dDMXRhc2tqYjBDY2NBWWUvRkFn?=
 =?utf-8?B?alJSVk5EVjc2MkdWaEREZUs2UTVRVmxkTll2RktFNVVQYTkxT3E1MHYycTZV?=
 =?utf-8?B?ZkIzVVhGWHV4bmlwMXZhYmU0cWhWQ0NDQVhiTnR5RzV5bVN2NVRBMzYzbkRN?=
 =?utf-8?B?Tkx6RjVXMXNhQjNhQkRPbG95TjV4eEhJUGkrY3pmeFd3RGZPSEExcnVCMW5y?=
 =?utf-8?B?ckVBa1VvdFNuMlZWQUo3QXhDYjlZaUhSbWRKN2xGYkF0dEI2WHZma21wZ05S?=
 =?utf-8?B?QmJLUkNIZkFBcUxuS1IyaFhaeGRUaFlMSE1kNERDZnhDS1lWQUd4V1d0TXg2?=
 =?utf-8?B?aks1U1ZnQUJYdlVraWpJcEZBWS9YbEhzeWVxZloyQlFnNjZxZWppdEQxcjYv?=
 =?utf-8?B?L3J5WlcxUmJ1cmRsSGlSTXQwcXNCaUdidGJQc253Tk12WmpCVkVZbkc0S2RC?=
 =?utf-8?B?N29Jc0Juc0ZMUjBEU29qWGZNdUdtU3hWYWMzTmp0K2VWcGRaTUhBMmlQT2U5?=
 =?utf-8?B?eEVKMENlRDJjNkdCT0xpak12Ny9uMjZiY2lGUitaV0VzdWl2TkxSYStpUnZ5?=
 =?utf-8?B?UnRwSW9Vayt5cVpoMHRuYW9TQm4va1RBVzN1VUZGdCtCc2JyZkEvZWZYRUYw?=
 =?utf-8?B?MnFVWUE0aUlDSitDUVlCM0NEbis4WnJ6VXRPVXk3WkNuMEg4RHYyemdtV0Vn?=
 =?utf-8?B?d21NVWoxVXVLVjdlRElNY01LWVQ4cTU4b0hXQ05ZdUF3b09RL2xWcHErRU90?=
 =?utf-8?B?bG94YlJWNjdvZnB2aUZTalpwTkdONVpRSXVyVnYrNm5URzZjVktHaDc5WE1F?=
 =?utf-8?B?NVhQZjRYRDBaclgvNS90OGJpaE4yQk85NndFWk9ZYUxya0pVMkQvejBqVjZw?=
 =?utf-8?B?NktReHNGZXl5RVhNYy9yNlhxWGRNTE1oRlpPQlVXZm56ejZ5RVVCc2d1T2V4?=
 =?utf-8?Q?8zYSEn3Yj5wyFxUHgn12z8p/biqKcBSQ2MZiszn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9163fa-2803-48a5-36cd-08d8d830c4c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:25:24.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 983gTLoHriZnJgdDPb9gcxa1NR092NhhTfk7gPwtCCMeB0j8GlCtZXDk8IZzAVQgBJsH4AX6FKu5VymMSHTbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230161
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------DBFD54D6A985E2D9E97A092F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/21 4:05 AM, Peter Zijlstra wrote:
> On Mon, Feb 22, 2021 at 11:00:37PM -0500, Chris Hyser wrote:
>> On 1/22/21 8:17 PM, Joel Fernandes (Google) wrote:
>> While trying to test the new prctl() code I'm working on, I ran into a bug I
>> chased back into this v10 code. Under a fair amount of stress, when the
>> function __sched_core_update_cookie() is ultimately called from
>> sched_core_fork(), the system deadlocks or otherwise non-visibly crashes.
>> I've not had much success figuring out why/what. I'm running with LOCKDEP on
>> and seeing no complaints. Duplicating it only requires setting a cookie on a
>> task and forking a bunch of threads ... all of which then want to update
>> their cookie.
> 
> Can you share the code and reproducer?

Attached is a tarball with c code (source) and scripts. Just run ./setup_bug which will compile the source and start a 
bash with a cs cookie. Then run ./show_bug which dumps the cookie and then fires off some processes and threads. Note 
the cs_clone command is not doing any core sched prctls for this test (not needed and currently coded for a diff prctl 
interface). It just creates processes and threads. I see this hang almost instantly.

Josh, I did verify that this occurs on Joel's coresched tree both with and w/o the kprot patch and that should exactly 
correspond to these patches.

-chrish


--------------DBFD54D6A985E2D9E97A092F
Content-Type: application/x-xz;
 name="bug.tar.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bug.tar.xz"

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

--------------DBFD54D6A985E2D9E97A092F--
