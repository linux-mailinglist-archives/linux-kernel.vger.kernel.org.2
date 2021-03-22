Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525BD344DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhCVSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:00:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60872 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCVSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:00:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHs9tN175928;
        Mon, 22 Mar 2021 17:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+bWymf19onlssSJhzt3+kNTPLSdADl9aeU5yZm0l+bY=;
 b=gMWLBqQovyaitPYeSJ1IdP5FLcSpAHQjxmgt9uh07AhxqVl56Yuol0PtWEDqrHFZmLrh
 3oOvkQp/B4r5r0sMxK+0mG88YBh4u2Oml3qKTxyH7If3awoApwRm9CuqwNymhfuGreCY
 GBERc4QVk8frJnXI3Zxg7xoW3TT3eWDSiLCO1hwE9uCZ33N/pm+x9oMacBNcQjhCJIlu
 Nn36ieIwg0MQgcIEbROftuG/+rQOwYp42EmV/6nb4aa3HyjtoSgRd04rpJ3aZKJsl7US
 RCnh8o3QzBqfrKqE5pUdMTQMqrI/l7DRnWdukLNahrRYUb0RpRFr0sgGPK4tFt7tIK2K iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbcfpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:58:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHuJPA175004;
        Mon, 22 Mar 2021 17:57:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 37dtxx8kh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:57:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdPATYAp5DHSQDwJwBqC4IziaFu16AE/E4TqCSNrFXNcmRlsb7elSA6dQrX8RoU1EtZ9+QRgkHnzUGe4gy7aDONumD7JrVYwOcVHmgvgQSv3inMLIUCo8E6Tu1DkVlbVEX7ozD/ZpPc/5I9LpImp+KaXTWI8Bcza4kmICkVBs5e7QmrpreeN9qfFFbISh1pOKuUbu1MljPqpVvYnx9YlKxReFn3rP4UhqMgNhLpb9IF1ZGFu1L3lPlVbv2cNzxKh/8k9SW7ot9CQaT0TJhdbCrEsOj9GEMJuwcOCD0CjF8atVOELxeBbV2gcNQsZLVy/jfLBQ+0obnpBNe9sPq91xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bWymf19onlssSJhzt3+kNTPLSdADl9aeU5yZm0l+bY=;
 b=dYsdFcozoZbTmvnlS8q8uOwdmkpP+oVp5AegFSFVGcd2y+xjERP9Ws5jJ4LzNa5Ln17/a8Ksn55aP5aeaT+KBwEw1zAcRLw48YU2xTtqmoObUsoP+XT4z7SUIt0fiDkzZouI3oMx+AK9qsYaFPSGCVmguoBN05NbkDFnYEAUWRxUZcny4dkNFMUYrkWqgNqlqICeKiNWYGpu76eY1h4ZdWmMCmMirzmgGytqyb2lfn3o/8Vh0kgW8Rh5+TsrsLZ/iiXgXFEdv4J1nQrBIb5xStwq1sydhJwaJxlEVuVQaUy6tWvPlX+X9fwAabQhtcPOuQ/BIolpl7seeS/7uZ7qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bWymf19onlssSJhzt3+kNTPLSdADl9aeU5yZm0l+bY=;
 b=lo/9AzQz1H4s+RXS83u0R7auLI6Fi6Vcg6KufXzcZsg/3877ZZAwcA3gtSMfK5g8vU9er1KfE8BLjq5DnLRQ9YpMZ9F/7LRHrNzQGZTbJVHTLeBrvQV4fjmN/l5WAJR++fH/ioHjFIbEZyYS/aTDks8uGRO8tA+XiXDt/89+oiw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1357.namprd10.prod.outlook.com (2603:10b6:300:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:57:57 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:57:57 +0000
Subject: Re: [PATCH 2/6] sched: tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-3-joel@joelfernandes.org>
 <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <ff9c63f2-0953-03c1-9b1c-25cb90954dee@oracle.com>
Date:   Mon, 22 Mar 2021 13:57:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 17:57:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3d2ea5-d1b6-4dc3-a168-08d8ed5c05f5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB135744BBA4B8B2961227FC459B659@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEDNPpkMFDphm4/0/venxg2rMnW0uXkKBImFYO8hYkEPwg+QKpfoZ24fY2vUORv24QFb6T80oVzFSibg1KT8xzHYmjWCvqHvJS9csw2IUhEV1BmdKWNP5u79We6Hdk8s0E02QtUw+5AC7JW7v/VRz2XMNfyK4VUyJ3xtP7hwn//YdaVfMixuJgUIMtDMUH9ug136VjLEnKHdxN/goPFOdvDBRwH4O3ErjVjDzvHXb2wqKxdxxIH9cXHM9CvrGo2LEnrPjTPCqUztmRrDevuutMgE/WnjvC2qNyy8FCejCq0uWfR2ejPk/FxN2HqiUkgPzP6HU2mcxU4IKW1fNxXb39g+/86Y8/nE70eybPiChAhuVh08hArVSCRRpNJui/tvZ/Rw67TJaEU5pwn03P40fxot0MtmRGGGS5HUwPHS4R5DlHT1eNh22Vb9/kbylLhkEU9DWzZowQJR/K+CqUhBOi6S9VuyVxG/hKdBSXKqqwOY3gX33mTwaTu+FvY9dnRhGoGI/dAlY/0bnkhhQhS5ZHqXr2/zJNKaWo4z1eH7/T2N4zTY+QzV/oBKpTROW3W0pcrb0qIlMxfPxoSYC6XFj47y3W8PC7cr+uDpwKZzjjiU5EwX2ncQFbyt3P9BbprpbfXmQm1DZ2AyZO2ta22rp/4Oe1xFxxq7AjXj51z0a5Pou78UfGY4FUMmqMOWb9EA2UHJZ3hWWGuYkTu7MMiXdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(376002)(39860400002)(31696002)(5660300002)(4326008)(31686004)(54906003)(83380400001)(110136005)(478600001)(66556008)(316002)(6486002)(86362001)(36756003)(16576012)(38100700001)(2906002)(52116002)(53546011)(7406005)(7416002)(44832011)(16526019)(956004)(2616005)(6666004)(66946007)(26005)(8936002)(186003)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U0dnUlM0L29KalljTS9vU0ZCV1NETlhQcWhGNGlVcklTZGhKZlJPSzdqQzgz?=
 =?utf-8?B?MDZNd0FQc09Na08zVEdrWWx6TGdSMWZ5bG9ORGJRa0VnRkVEbStIMzdKbDVO?=
 =?utf-8?B?THhSOWdURlZpSlk4Wi9jd1c5YW1FU0dERk1HNGZwcWFieTdZUEUxNi9RWXBj?=
 =?utf-8?B?eGgvZG1sSU5MRTZ4MGdSbTFRQXpnWEY1Y0dNRXlnM25yemN0b3VES1RUdTln?=
 =?utf-8?B?WlptZHRwU3BveHovUVBGbTBZYUNqSVdjS1IrM2tMdzlCdzhqZkRNakNSdjFW?=
 =?utf-8?B?QllBNmVhTmtIL01TcURha1pQQmtQeU5YNEJpZXRyUitiMVYwdnc2OXFXT0R1?=
 =?utf-8?B?SlkzWWhLRTZzZkIrSjl0dkhRcEZPcXMwdFByL3Z6c05KOE5nWnFySUMwTjQ0?=
 =?utf-8?B?TFdXSzFlSmZGRitBU0J2b3FYMUJKM3Vub0ZMRWN0OE42R25FSWE5M2xXRVNK?=
 =?utf-8?B?WDJ4bHZpMGd5M0V3QnhoK0o4YnM5dEc4R2NhRU9vNm9CdFNpRU1HS2RRckxs?=
 =?utf-8?B?d29xZ0phVys2ZWdWOW14blRad01PaXkreXdoU2lzT3FUWXRBbEV4V2tEMmtW?=
 =?utf-8?B?VGZKaU5wU3NoNUdWdXNuTDdoNG1xSUdFaW01MCtaSU1VUlFVK2JUblJCR0Vu?=
 =?utf-8?B?MnlYekFZSTZ5Z2x0RGNhRjFtN05TQnNMbDFQYUR1T1dFZ0N4WGttcmtTeldB?=
 =?utf-8?B?OE5pVFVESVowOUhHYW91MHpPM1hNV2Nia056b3k5RVlkUHNlRkZYZmtXaWV3?=
 =?utf-8?B?NkdHSTZjLzROZ2hLeVdDbk45V3NqRjIxckp1NEhRWVgwdkZxSjhhNmtqUk5n?=
 =?utf-8?B?T2lKNjBueERiNncvYzB6MmlTekd0UmFxWXJlWW51MHhxQkcwZkV6dGRaREkv?=
 =?utf-8?B?aHBZT3REYkJlczNpYjl5cFZiVUJncU9BMTQ3MlhWK2VTa0NESnFoKzdoU3F5?=
 =?utf-8?B?TUhtM0lCSks4dC9weUNiZmcwMzdlNzNTMnNmVXcwbXdJV2dQeTRWVDM1VnBy?=
 =?utf-8?B?elpCOFNpNTBqdnpTRjNZTStHWFFRZGZXbEMySThpY0MzeGJNSmFkRDhKWngv?=
 =?utf-8?B?TUl4eUt3N21DV0RWT1E3L1JKaktHc1Z1aCtBVnJRUmxqWDJuMnFOd2lsTEU1?=
 =?utf-8?B?WmdOd2dYUERIMDFBQ3pPTlVxZFMvb1pWK29JdEl4OGR0N0wrTC9qcGVVbzhI?=
 =?utf-8?B?YzVVR05VR0dvNnJKMWRzSXJyaEtsQ2RuVG9NV29ycE82WXVtY3VUaFpqYWFa?=
 =?utf-8?B?Qi9hR1hXcnpBd3Jvems3bDdTMDl2eFE3QzlHN2RvRlZJaEVVS0xXejcwQU10?=
 =?utf-8?B?M29Ta0VkQjI5RXhXQXIxUEl4bTE1LzhqbE1obGh5MHdZZDQwdi9NdW1OZ205?=
 =?utf-8?B?ZW1ub2RyUnNzUktORkQ3TVhFMFlvN2QyZGNKRGpjN3VqcGNQOGtkTlBCa1NY?=
 =?utf-8?B?OEZ2cTh4VTFUZVlUdWxpSVl4U2NDanljczh5WEpUVWdJcjlYSG45SjR6QjdM?=
 =?utf-8?B?blpOajFSdFJ5eCsyVzlEcndwNFJCaGZ2V0NNU0psSzc5aFVUUWJvQWFidWRC?=
 =?utf-8?B?dlI2TEFyOUNyeWh6ZzluZWMyVEV3VVVOU3ZXVEVUclRTamlDZEZ4WitEc0RR?=
 =?utf-8?B?UjlqSGhiaTFSQXB1UzVCYUpPR1FDR2wybzdVNVk1ZE5WK2dLMzhlWVNoYmVR?=
 =?utf-8?B?WTR3MDRaM0s5dXJ6V3lTZzZTVi8zbENNdnBudksya3VOTi9QN21VbzE1cTZV?=
 =?utf-8?Q?nw/sZ4IA3HSNJL4gh2NMZYw4a4Co8+5CXn1k3qi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d2ea5-d1b6-4dc3-a168-08d8ed5c05f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:57:56.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4wlK2XXce5eAa7SNY9glkm8LwiochB+qC5xc8yBNvemCdoWGMD2wREvctKKO7JgFCVJO5JTA/owupVQOEl4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=840
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/21 11:46 AM, Peter Zijlstra wrote:
> On Fri, Mar 19, 2021 at 04:32:49PM -0400, Joel Fernandes (Google) wrote:
>> From: Josh Don <joshdon@google.com>
>>
>> Adds per-task and per-cgroup interfaces for specifying which tasks can
>> co-execute on adjacent SMT hyperthreads via core scheduling.
>>
>> The per-task interface hooks are implemented here, but are not currently
>> used. The following patch adds a prctl interface which then takes
>> advantage of these.
>>
>> The cgroup interface can be used to toggle a unique cookie value for all
>> descendent tasks, preventing these tasks from sharing with any others.
>> See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
>> rundown.
>>
>> One important property of this interface is that neither the per-task
>> nor the per-cgroup setting overrides the other. For example, if two
>> tasks are in different cgroups, and one or both of the cgroups is tagged
>> using the per-cgroup interface, then these tasks cannot share, even if
>> they use the per-task interface to attempt to share with one another.
>>
>> The above is implemented by making the overall core scheduling cookie a
>> compound structure, containing both a task-level cookie and a
>> group-level cookie. Two tasks will only be allowed to share if all
>> fields of their respective cookies match.
>>
>> Core scheduler has extra overhead.  Enable it only for machines with
>> more than one SMT hardware thread.
> 
> Oh man.. I'd soooo hoped to first see the simple task interface and then
> see the cgroup patch on top of that... I'll see if I can flip them
> myself (on monday).

Peter, given we need to rebase this and we have some cleanup, we can go ahead and flip the order if you have not yet 
done so yet.

-chrish
