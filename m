Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224733224CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 05:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhBWEEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 23:04:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 23:03:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N3xtjW171388;
        Tue, 23 Feb 2021 04:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lPB/P7511gbxg/6ug6E6IT74QHkwKn4qA48lmiueyzw=;
 b=DGkwF4ajiLPDvJRLGKMJF8CwT8dvOAUlnI+2w5qS85FqO9mmkcX2JxT7bgBclqDC1UfR
 lHPndGRj3bVq2X9QDt/QFsA+BCbndlN+dplGYKOadV3sY7nqNsVMJn8yJ11ouXieHGWn
 SzO4IC0qplgWpPgZM1GLqICHFLUIOl9kxI+2Fqo+ht9Uk/4h8M329j043YSo8WuvWN7q
 pXR17kY+z/MhUaYCBorO+oYiVV1gtjHfywoLPiQoPYgSndjbgwN8B76cL/9PmMyV/vTk
 uxZdcCSt7rUyaKWwGIBI7e1s4RRr/q1UOduD2Sq8tXUGOmTxmWNJXYlLVUmu5E6IqyRz sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ttcm5sjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 04:00:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N40XfC077190;
        Tue, 23 Feb 2021 04:00:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by aserp3020.oracle.com with ESMTP id 36ucaxu7s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 04:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiXglMLJcO3NfF92heoFBL697tcg6s0OH6FmBcQ8ZB+KoQecrmvG1yVD3+dXMZYsqkYop/IxU9WNjnNL8u4WdNF/ujbi18mYH+gYWky4IJzXlEpZ9kAIt7/9r3AirbUl/L9PhcT5e3Al7hrxv3i17wOWBVBB4aO4SqdDnzG3tKLCsd9rJ9ILh9RO8m7HPEtV6IgYmlk9TfMIZH5YoaCjxLsdi8Cs8E+VDeaGFPKH3KcV+gIJq2OLWjhugf3b0jDnaH8NCs67EaeLrPUIqgEga2eRk/HjQVlmUdTvKkYahV6hFA/ZKUg8+bishCOo+9w3jYNMZplIj7BRSrG3MpEvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPB/P7511gbxg/6ug6E6IT74QHkwKn4qA48lmiueyzw=;
 b=M2FBh8KpUEpniCEc3/McBH0QFPKmFzqHQyqta0EEvYdjx+aRE1xWfGzviRGsZ/YPlz5RTrNXTkVjk7O9ebG9olw9sSEnJ1bqlOBwN3WDrG0hyDpwS4V400yTW7W0I6S1p0KAl+3UDHLg+3Nh93sHls34eCFgznktG0MUSAKFKZXJR1VSpdFF/W3cimpw/noiGt5dYTfpTpdSg7H0CUOqs8QqXwHcfj7MuAYsd/6ArhUIB9WASIlKDvRh26OSHABll9oYucmxKfaCUTOUR4/TJYVLf7XY8jCZ/lb96wiEz0cDpH76emwHdDg4fOjGPlWcMVV31hWtTP7pX7MpCIqLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPB/P7511gbxg/6ug6E6IT74QHkwKn4qA48lmiueyzw=;
 b=o+xWaJVcXgBPHpFh4d4KvHe8Lf+h5VRSXpk2BLm1/BO5E7ZdqMZloB3EDpo01TwgfiRsa+B0PZ2pQuY8XKkoY65qL9sCGmg8QTenZhMsV5KZkCE6ZPzZP21CgouCG5YNnn/u0RA/9xao/HqZu11U7MDswSGqQ6+J+CrrrkDTR/E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 23 Feb
 2021 04:00:44 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 04:00:44 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
Date:   Mon, 22 Feb 2021 23:00:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20210123011704.1901835-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:610:4c::32) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 04:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0d0b14-419b-441f-3359-08d8d7af97b3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB464348EC2448D57608E2F8929B809@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TId0n/5407ueOxmmbpykcIWx+XFXfuNJyRbmNhigDwZHpaaDn0TjITtdfTb/7GcA8tnDRqDRtEw3pAIxkIMvWqy6MoYt6XmV7lpR2nR46+Ow54P2Kkv8tvfmiHARA22MkXg9x+kA2lhS0t8Dr0MAgfzfCLc7rAoI4xt68tDEqOV5jKWVQuvwGULXeOmGP05T5SlWB3eHxXw9qN1kvdxSL2nJo4xg2WTshzs7L5VuePzB+2JNER18dSaYsbuMymSczmMvL5arXjqbjDB458ofdEO6g/UG/DE3V3igBSkngPd2bDuaVWjhSMA3nix99xgwiR/plb/IsT3sK3oPMHIWrDQph1VMD7KQEWpXyGtrjjeyY5M58hQYE4U2+K4cwHMoyPEZOMmnoRcG6dtl+7lJKI59x2QGW7wtDuXAzM/gGfYrsa2WzLvvG6Aa1M4QWY3+AysoEf/nk59e0FiTcwporaWyhOGCYi/S1wr944j5XELB77RKqF++srxZobVIbPTnbe17Msye5AfHGSlh0Ro+hMRt6QK4VPN52LF6M5dU9Q4BgCLIheAcidDwD3nALnM+KUYDQQxY7XUA1RqZr2S+DiL2a1gH8VlJJcP2cQEAqag/sWZagaJOp3YQEbW2YGP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(6486002)(36756003)(478600001)(110136005)(86362001)(4326008)(26005)(54906003)(53546011)(66476007)(16576012)(316002)(66946007)(66556008)(5660300002)(7406005)(2906002)(16526019)(7416002)(52116002)(186003)(8936002)(31686004)(83380400001)(921005)(44832011)(8676002)(2616005)(956004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWRLVS9TMURUWVBhTG5KUytSRE1Xcnovc1lnUExYYXlaZEJnUm1mOUZ6NmJq?=
 =?utf-8?B?KzlDVDhuc0lmSy9YNERzKy83QytZSEdsb3l2UGZoZ1RjcXJMODFjUTU5S0xL?=
 =?utf-8?B?YmVWWjJiV2xhMnVia0JYZVoxVk54R1JpVUtTYUhKSEQrT1l2UW9ydENBSmpH?=
 =?utf-8?B?eWdUMGVrcEZ3dktlUVh2TUVHSU1DdkluN25Telk5R2U2UGU3NzVwWFZwdnhw?=
 =?utf-8?B?a0kwZ1BPbkFTc2ZUNlJTbWYwK2ZVeWMrRWc0ZVVaVkFaM2xKazRrMDNJUWxM?=
 =?utf-8?B?TGxaT3NvTnFMdk1xRCt3Y1JveDhjcElWdFpHUnNNODR0RkQ0NzgwMDFFeko4?=
 =?utf-8?B?ZGZIL0IzaHFUVGUrS3kyMy85cGdRWE90U1E0WjdYL016NEhHTEtidmh3dVhI?=
 =?utf-8?B?RExtQ3lQa1IwdlRGd25ta1NsUmFFN1ZTNS9yY0REcURZMUppVzU5Z2NhWE9k?=
 =?utf-8?B?TEs1RzAwRnpLcHlEbWwzZDZDc3lzdmtBd1FoWm43Z0JTWk5PSjJjaFA1RVRt?=
 =?utf-8?B?QVB0YWp3R1JCSEtHVHNtTzVSeDQ1ekRma1NYMXlpNkdZbDhnVGg4T0xrUnV3?=
 =?utf-8?B?WVNaZmxoSkxoc3dxUW9URlF3MVhBbHVTQ3VFWC9mR3EzWkRDeFBmWjhncUNZ?=
 =?utf-8?B?VDYvUGlxc3NydXh5Um10UzE4VnFkSTZaVkQ0TnFIQ1krR2w5YnNUUFF0bUs2?=
 =?utf-8?B?blNuWS9VTU0wRFVRandBanhUamhMQjMzMnZZZGVINDRkUER1QkFwWGsrZk4x?=
 =?utf-8?B?S3gzODlMQ0NlZUFDcUhVaDYxaTN2UFlwUXYvdWpMN216YmV1SXpNYjNPY3JL?=
 =?utf-8?B?a1J1ci93Y0lFaUNYOTczdkp5ZEsxd2RhUEJWbmdWK25uN2pscTlROFo4Mk5N?=
 =?utf-8?B?UVdGUzVWRWh4bW9WcnhnMEtyZVBDUmtkejFFNEd1UTJxMERrc1h1dEwwUW1L?=
 =?utf-8?B?VnM2bnBHRzBtbXA5U3dQcDI3OGpaNWxwNGswckRVSlRuT1NYbFBTQmsvcWhu?=
 =?utf-8?B?YmZDTFh6elQ4cDlIbUQxdE1kbE8rSVYxelZLbzlKeW9qZzlpR01PdzZEZEoy?=
 =?utf-8?B?K3VsbE56dmdKajlqM253YXFqU2Evam13Z09WSzVJNnRWSERGZEZPa20xTHdx?=
 =?utf-8?B?UWNOMndrZW9FQU5sYlJqM0tYZEFSYmp3L09HYnBuT3BHMEtSU0hKdTliSUNo?=
 =?utf-8?B?MDV6NE1KYVFOUFEwd0lFMk03aC9uSzcrajJ5VCtSYzhLWGVKL3NseTluRUxv?=
 =?utf-8?B?QlVaT0RnVTlDNjF4eXk5TTRGMWEyVWd3OUlLMnlJQXBKeDk1SVZ2akZnQitn?=
 =?utf-8?B?bHVwNWZDRENUSTdERStCcTA0MWIzSFhxM0NwT1Y0elhkTnQ3RnJ3aDVjazBv?=
 =?utf-8?B?MjRYaVg4YkNxbjFYaUlsbHB0MHNqZjJTcnl4YjRXQmFFSzY1YlRPMEladTQr?=
 =?utf-8?B?cWxGWWwvdnJFb1MxNzd3WHFoeVZtNjdYNVN3empQYndheDFtWjZXbmNCWks3?=
 =?utf-8?B?ZTU2dm9meTc1SDNYWVRHdTNrZkRTNk92TVpMNWRsUXdwQmhZOW9oeXBNdHNE?=
 =?utf-8?B?RWxKVjR2UjRZOURHbVlYaDZEaHhvR3lFWS85Mm0zcUl3RFNzRFpNTVNzdXdQ?=
 =?utf-8?B?dkpVUTVKNWNydWFnRkhUQmJuT01xcFBpdkFSZlVoUUVCMnRMeDN4SDBUbWlP?=
 =?utf-8?B?V0NEd2w1VkEzMXdpQ3lYYWNBakhLQU1pbitTWXpmdmIxM0xIQVhZUTN2MEQr?=
 =?utf-8?Q?yiJURx7PjInspRyjRMABE+H5Kd34S+lDGHDWDq2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0d0b14-419b-441f-3359-08d8d7af97b3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:00:44.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yjrt4MHx+3KFmFOcmgtHwC9JzVjnCI+erwioGMZwkCa8HhvTz9lbAKVObIA7HyvaFuXTzDZQT3t4DjJQFtS8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230031
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 8:17 PM, Joel Fernandes (Google) wrote:
> +static void __sched_core_update_cookie(struct task_struct *p)
> +{
> +	struct rb_node *parent, **node;
> +	struct sched_core_cookie *node_core_cookie, *match;
> +	static const struct sched_core_cookie zero_cookie;
> +	struct sched_core_cookie requested_cookie;
> +	bool is_zero_cookie;
> +	struct sched_core_cookie *const curr_cookie =
> +		(struct sched_core_cookie *)p->core_cookie;
> +
> +	/*
> +	 * Ensures that we do not cause races/corruption by modifying/reading
> +	 * task cookie fields. Also ensures task cannot get migrated.
> +	 */
> +	lockdep_assert_held(rq_lockp(task_rq(p)));
> +
> +	sched_core_cookie_init_from_task(&requested_cookie, p);
> +
> +	is_zero_cookie = !sched_core_cookie_cmp(&requested_cookie, &zero_cookie);
> +
> +	/*
> +	 * Already have a cookie matching the requested settings? Nothing to
> +	 * do.
> +	 */
> +	if ((curr_cookie && !sched_core_cookie_cmp(curr_cookie, &requested_cookie)) ||
> +	    (!curr_cookie && is_zero_cookie))
> +		return;
> +
> +	raw_spin_lock(&sched_core_cookies_lock);
> +
> +	if (is_zero_cookie) {
> +		match = NULL;
> +		goto finish;
> +	}
> +
> +retry:
> +	match = NULL;
> +
> +	node = &sched_core_cookies.rb_node;
> +	parent = *node;
> +	while (*node) {
> +		int cmp;
> +
> +		node_core_cookie =
> +			container_of(*node, struct sched_core_cookie, node);
> +		parent = *node;
> +
> +		cmp = sched_core_cookie_cmp(&requested_cookie, node_core_cookie);
> +		if (cmp < 0) {
> +			node = &parent->rb_left;
> +		} else if (cmp > 0) {
> +			node = &parent->rb_right;
> +		} else {
> +			match = node_core_cookie;
> +			break;
> +		}
> +	}
> +
> +	if (!match) {
> +		/* No existing cookie; create and insert one */
> +		match = kmalloc(sizeof(struct sched_core_cookie), GFP_ATOMIC);
> +
> +		/* Fall back to zero cookie */
> +		if (WARN_ON_ONCE(!match))
> +			goto finish;
> +
> +		*match = requested_cookie;
> +		refcount_set(&match->refcnt, 1);
> +
> +		rb_link_node(&match->node, parent, node);
> +		rb_insert_color(&match->node, &sched_core_cookies);
> +	} else {
> +		/*
> +		 * Cookie exists, increment refcnt. If refcnt is currently 0,
> +		 * we're racing with a put() (refcnt decremented but cookie not
> +		 * yet removed from the tree). In this case, we can simply
> +		 * perform the removal ourselves and retry.
> +		 * sched_core_put_cookie() will still function correctly.
> +		 */
> +		if (unlikely(!refcount_inc_not_zero(&match->refcnt))) {
> +			__sched_core_erase_cookie(match);
> +			goto retry;
> +		}
> +	}
> +
> +finish:
> +	p->core_cookie = (unsigned long)match;
> +
> +	raw_spin_unlock(&sched_core_cookies_lock);
> +
> +	sched_core_put_cookie(curr_cookie);
> +}
> +
> +/*
> + * sched_core_update_cookie - Common helper to update a task's core cookie. This
> + * updates the selected cookie field and then updates the overall cookie.
> + * @p: The task whose cookie should be updated.
> + * @cookie: The new cookie.
> + * @cookie_type: The cookie field to which the cookie corresponds.
> + */
> +static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
> +				     enum sched_core_cookie_type cookie_type)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (!p)
> +		return;
> +
> +	rq = task_rq_lock(p, &rf);
> +
> +	switch (cookie_type) {
> +	case sched_core_task_cookie_type:
> +		p->core_task_cookie = cookie;
> +		break;
> +	case sched_core_group_cookie_type:
> +		p->core_group_cookie = cookie;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +
> +	/* Set p->core_cookie, which is the overall cookie */
> +	__sched_core_update_cookie(p);

While trying to test the new prctl() code I'm working on, I ran into a bug I chased back into this v10 code. Under a 
fair amount of stress, when the function __sched_core_update_cookie() is ultimately called from sched_core_fork(), the 
system deadlocks or otherwise non-visibly crashes. I've not had much success figuring out why/what. I'm running with 
LOCKDEP on and seeing no complaints. Duplicating it only requires setting a cookie on a task and forking a bunch of 
threads ... all of which then want to update their cookie.

-chrish
