Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5530FEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBDU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:56:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58130 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBDU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:56:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114Ko3sv193214;
        Thu, 4 Feb 2021 20:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jEqLzNxrBIAf8hNxssDWtk9yMvYL8lwFIykarC7U9MQ=;
 b=hQiXVQ6pGmUwiJIR++nYCnsN1tzJ2vIkQuxcKEyYb/jj167lXVVRdo00WImjWdsZDs/K
 Pw7++6SLjTDMevgNLp1zdOKz4hqfkYASqzVvmwodYjvKQP3y8hbUFxIUOULrUdNSBvJE
 q43VHfNBFcB68ggD92A5GxB0qadg2f1wioxdwvPTdDLkFMMIuqOVbXhT89epEJKwP+2w
 She/HDYw00lSP/2xtAgdTlrkVqGSFM8Xpif7k7A6iOz1jhiEQD7ixTWVxa6dAHP1MuhE
 CF7Nq5fnUG1fy0pQ9kR9pQrt4FUGYWll+rDBKKONZ+xk8oUNtsVATRzY65tU9Age0CHB ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb7b1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:53:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KjdKf017914;
        Thu, 4 Feb 2021 20:53:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 36dh1t01c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqKhZKb67RK/SH/wgRpbDNDe2VSMYLRGRurztI32RnAdaWtLmtLzFEMMFCzFFYO1bbo8mvO1Q7vdqf5qXqP/XhJCWE/xJyq/EmohHeGs37qYp2API6VShz2kpYJxvgEY9bwftsV/ozS5SEEV0IKT5LWTcw8tKrmOJUOzURy7L9YDTsu9NoLZpDSeFcu0GCBtLE3Ba8EKjxuby3cadLMVhWrS5cPZNGOcY/eMT51HjXVpFuXYwOjNjFT2+OW96CiU8K4tw4e+fT5n5R/+WNzEExWcXCPZMr/pH9S16L69e6NEXPBH5rQK++B17yEOW9pefdCkAdJ2rFeqF2Nftj91mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEqLzNxrBIAf8hNxssDWtk9yMvYL8lwFIykarC7U9MQ=;
 b=TJQ6qJvEDSKac5vm4WNP6cQRnt2/zsivdB8v7QvhmO3o6XeFELQxrr+uDHrde4EUGxbCp7vOwU3qeUW+oZXPum55brmzafZsuE/i4UoEpQI52Z/IAR0iq4OY+Dsk4X4fVUTTKj5/F7qnIw6cYfdas+A5Tu4OCV6ic64mnmi4vwEC4GwfmWZR22xbpWtMqstm3UuSsJhInp2OtGdlvNGGBonEONl58Qw4ynBvhWTMtRQhPw9CC+gn73JQy7tuNLgAMmYF7/X7yvRY33L3lNOwYdEh8Rpg+a40uIBySyC+p5mHzYyY22mxTI63TfGPvv/0AMkjUzvcaeh/J56oel2WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEqLzNxrBIAf8hNxssDWtk9yMvYL8lwFIykarC7U9MQ=;
 b=QhOMQFMm9/50wIyt9kyAWmqgQSEcRCWQXIV/0G8Gimb1ZDI9fqfYEv7lrz+0qkUUpcpdHDK27fTBfe5Yxtv5ATEJsKhyNMYSu8iXE83qrrajRf+eoMrOUip01HgKxZ77jQQ3xITPtDogHF+0RIGOzmw0pq4J8XS8VY+r9qdu948=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1295.namprd10.prod.outlook.com (2603:10b6:300:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 20:53:05 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3825.017; Thu, 4 Feb 2021
 20:53:04 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
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
 <YBv9Uy1dyv8E2LAz@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <94bb9424-008e-6d3c-dff6-a1329c16551f@oracle.com>
Date:   Thu, 4 Feb 2021 15:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YBv9Uy1dyv8E2LAz@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by BL1PR13CA0141.namprd13.prod.outlook.com (2603:10b6:208:2bb::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.16 via Frontend Transport; Thu, 4 Feb 2021 20:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af458dbf-2d8d-45e5-efe0-08d8c94ede2f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1295:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1295FEE5A98002ACB3F7AB6F9BB39@MWHPR10MB1295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YL2fbLx2Au6HibDcx0iM4HTOCfRIyyDbJ6NlCVM52G64+BMhMM/DiNV6cCtSesbrlhR3Z0SK09RoPCVFv8By0jIVDnPNNNpSEPIISRLMwlgY0wRenBntwRgD5dt2UjERREzoISKeHJmKznp3CVTPN306b5vEumgg6fotCWLXe/t/8wzcZEyfzvdiJ52jxdKjM6TcHI3RZ2hXGmrjW4V0uOt/dk9wCXVxuHpI9BYvg6Anmr10kLrQljLnh2TWtzplMcDTj6sbKG9PvoO5jyYR1Plf7fD72pu7epXqRb/UzrDMrQKVCj3A/bvaCRzVZalfsudkCtMWB1ROZHaK03UhQEguPk6OCdheeKmkicQIObrn8whDcgC+f2f75lqjnfOqy9DyL+iXJID+d3uQg6gXrNQg9Nkh8fiRflTE96vqMMlafkW2Mld9S4m5nIWadouH64Z3ksYSOFX1689HCZAGvlO+xEQs8cWyVeKDHyQiBrL5FMxWGFjo6i6dQn/zKpiX52ky+852RrHzrhEUAK4VooqIe7iutsMaEgZ41ppIQ6uX3GM+UWHQHqd8ny3dm6O99ddqZsgGjxO1kdRd9r6HHD51rjA02M5gLKdJnlaSN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(16526019)(26005)(5660300002)(31686004)(2906002)(83380400001)(956004)(7416002)(66556008)(6486002)(53546011)(66946007)(52116002)(66476007)(7406005)(186003)(6666004)(2616005)(44832011)(4326008)(36756003)(86362001)(478600001)(16576012)(8936002)(316002)(54906003)(31696002)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFZKem5wWlhBakN3cmYrcEtjSEtvQmVYcnRpVVR1K1ZCOWFsUmR6K29UL3JT?=
 =?utf-8?B?MklJV3pZSS9QOXFQK1FBcGxEc3g1dTM0NGU3QzIrUkp3K2d6aW1sMlJzOEM5?=
 =?utf-8?B?eUV4eWt1NkR6VVZXRjB6YW5tTlMrSDY3RnVPRmx6b3B1ZHhXNWtRMEV4WjhL?=
 =?utf-8?B?MzMzVUwrdm9ZNTFJNnFIOWYxYW5XY3J2alNOS3d5Q1FYMkg2NnBWZnhJZmtH?=
 =?utf-8?B?bE0wZ0w0bUlPanJvcmRKNzBURXREOHZ5ZEREWWUycTlmaHNXUEV3UG1nV3Ns?=
 =?utf-8?B?V2pCa1hTdVhlNzJGa3lQMi9vU0UycWtkMHl5UENUbzZpVUtYTUxwUkZmN2dh?=
 =?utf-8?B?R2JCNzlVKytCYzFpZ1FoYklaZmI5RjJ4MUNnNE1FL0VEU3dBVkYxcGthOEpO?=
 =?utf-8?B?ZVJLUFJtOXdBd2VzQnhSaitqYjI0bGFNNDZXU3lYeVlHYTVlcGJickFaSjFS?=
 =?utf-8?B?SGJkSUpVU0pyMThNQk9oTThablJDcDdsZWMvVm1TeFFiRjF1YzF0MDNOYXFy?=
 =?utf-8?B?OEl5YnFUTUJ1STd0clltYXE2aEpQb1RwQWorSGlFUGpTVXYyMWJ5ejhKaERV?=
 =?utf-8?B?REtBYjgwNkN4cTRIdENMU25QN0QxODRvVGJNV3lrMmJOY25IOXc3K2lzRjY1?=
 =?utf-8?B?YjJ1cEhqUHd2dUNyT0VjUmF1TlJpbXA2QVErSU15YnBPWEdKSGxrNCswcE9Y?=
 =?utf-8?B?ZkNmeHE3ZHlmWkNDN3NEQmZPcDFTU1Y5UWh6N1lGLzNEa1ZUYkhsalJ5M2Y4?=
 =?utf-8?B?NDdDR2g1U1dmNXVIMWhlaDFXd05VVUE3OEpzVW1aV2w4Z1RNL1c4SXRTTVNu?=
 =?utf-8?B?YXZxWXNPeTFmZXg5VktZZ2JUcjNTSFBNdjBCanlpR3dSOGs4bW9VOElHVFMv?=
 =?utf-8?B?aVRYb3N6b0pnRXl6TVErbFdWSVM2MWdLUDRDRHBGaGxQNHBTSVkrVHVKYmJa?=
 =?utf-8?B?eEJrSTJpMGJocUdlVGhDdlJCNHNzS1FlOXNxMTdKcWt5Rnh1OE1zMGEwZElY?=
 =?utf-8?B?YVZVZjB1czc5eVZvUFM3ek9oWjRLVW5BYXdtc3pDUnRyUzVvTzdBNFNoYVFS?=
 =?utf-8?B?R1d6ckZOR0NRd2dKaDVWWkxmcndRNGtoalVpTEdicmo2S1ZXN09iM3Q1Q05Z?=
 =?utf-8?B?UGRGc1NYUzhZL05BMHp5a3d5TlFFQUlnRzlSZ2tXV1J2UEpnUzVQd1BDTmo5?=
 =?utf-8?B?akpPbU9UWXRXTU0yZ25ZWWI0M2ZnS0lvNlBhTzdoRXB0M3g2dzh2Zk1MWVpa?=
 =?utf-8?B?ZW5EayszSW44dnNQMEgvYWpldE0rN3ZhbGhlRlhWRDUxeW5wOHVLT0R0QS9L?=
 =?utf-8?B?NzJ4dFpIRmZwQldPellteUJNSnU2cDNyWDJOY3BsMmN4TDQydVZYRDdVNGl4?=
 =?utf-8?B?UE12KytkUUN3NUJJR04xRFVhVHB0dDgwRjQvVlB3R3dhVUwybFJLTEFpSkgx?=
 =?utf-8?B?UHd0Nk9iaWJkYmxMOUJXZ1RiSytlQ1BxNmp5bVpCQ25aNUpOS0xDZ0ovbkxN?=
 =?utf-8?B?L25aRndVc2I3TFNHdGdVWU9VclJnZ2lKYlZmRDBkWGU1c0l0QTV3UzBUVDJF?=
 =?utf-8?B?dTc4NGhNRWVyRXJkY2xhd0lNT212TGhCRHovNzNxZEYyNjhiRFV2U28wejFV?=
 =?utf-8?B?dWowcGdMclRTUld5QTdDR2hsbmFZSE9zN0l0ZldLQnFma3pnUTh5ZVN2TE1J?=
 =?utf-8?B?UVl2d2JmbkhPSmdveFBwYVZoYjlSSXBKRmF1QVI4cHdkcnJNZzcwZDhUZWFt?=
 =?utf-8?Q?XnFsvK3GfQk9Qd4k4WOH0a9Q7HX5g3z/PdpBiVC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af458dbf-2d8d-45e5-efe0-08d8c94ede2f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:53:04.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5QJ3DwoG5UeUsc+y6Q3UJz7Z/xaLgZFDWNBl6g9ZkbUTsAOWvER3hsToCEkDvw4YsEMIYZln7OqGDx+v3Asbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1295
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 8:57 AM, Peter Zijlstra wrote:
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
>> +/* Request the scheduler to share a core */
>> +#define PR_SCHED_CORE_SHARE		59
>> +# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
>> +# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
>> +# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
> 
> Why ?

The simplest interface would be a single 'set' command that specifies and sets a cookie value. Using 0 as a special 
value could then clear it. However, an early requirement that people seemed to agree with, is that cookies should be 
opaque and system guaranteed unique except when explicitly shared. Thus, since two tasks cannot share a cookie by 
explicitly setting the same cookie value, the prctl() must provide for a means of cookie sharing between tasks. The v9 
proposal had incorporated all of this into a single "from-only" command whose actions depended on the state of the two 
tasks. If neither have a cookie and one shares from the other, they both get the same new cookie. If the calling task 
had one and the other didn't, the calling task's cookie was cleared. And of course if the src task has a cookie, the 
caller just gets it. Does a lot, tad bit overloaded, and still insufficient.

A second complication was a decision that new processes (not threads) do not inherit their parents cookie. Thus forking 
is also not a means to share a cookie. Basically with a "from-only" interface, the new task would need to be modified to 
call prctl() itself. From-only also does not allow for setting a cookie on an unmodified already running task. This can 
be fixed by providing both a "to" and "from" sharing interface that allows helper programs to construct arbitrary 
configurations from unmodified programs.
> Also, how do I set a unique cookie on myself with this interface?

The v10 patch still uses the overloaded v9 mechanism (which as mentioned above is if two tasks w/o cookies share a 
cookie they get a new shared unique cookie). Yes, that is clearly an inconsistency and kludgy. The mechanism is 
documented in the docs, but clearly not obvious from the interface above. I think we got a bit overzealous in patch 
squashing and much of this verbiage should have been in the combined commit message.

So based on the above, how about we add a "create" to pair with "clear" and call it "create" vs "set" since we are 
creating a unique opaque cookie versus setting a particular value. And as mentioned, because one can't specify a cookie 
directly but only thru sharing relationships, we need both "to" and "from" to make it completely usable.

So we end up with something like this:
     PR_SCHED_CORE_CREATE                       -- give yourself a unique cookie
     PR_SCHED_CORE_CLEAR                        -- clear your core sched cookie
     PR_SCHED_CORE_SHARE_FROM <src_task>        -- get their cookie for you
     PR_SCHED_CORE_SHARE_TO   <dest_task>       -- push your cookie to them

An additional question is should the inheritability of a process' cookie be configurable? The current code gives the 
child process their own unique cookie if the parent had a cookie. That is useful in some cases, but many other 
configurations could be made much easier with inheritance.

If configurable cookie inheritance would be useful, it might look something like this:

PR_SCHED_CORE_CHILD_INHERIT <0/1>  -- 1 - child inherits cookie from parent. 0 - If parent has a cookie, child process 
gets a unique cookie.

-chrish
