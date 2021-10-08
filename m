Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9E427218
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbhJHU0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:26:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14146 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242286AbhJHU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:26:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198JIm9v025384;
        Fri, 8 Oct 2021 20:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RN3tJqzgmxc6XjG9apQC27cuag6y4NZT0+zehbVR35c=;
 b=OF8sBmPFmcGyenp9Ah/fTG5Vap01KpBM0L2YDs9lDPnc9GWFhej+MMK4LL14Q/ewyQcY
 LZuN+exA74THIgT3qir1iAHUr1ZkcyLDvAw7Qmn1xPcH9KQFgjf93sMJ8A/JVVx9TxMU
 gJrO6wf+266Sm/pdsERxQASox3nAdy0smnB+h7hUuHSQC/4SzGe1R0m2bTdFQtoc1TBu
 gGd/FxONWo/FxWCneL9vXYUJanbFt2uPqa7zBBPxUe1E9wR5xBykBYWx/438uWyYSrP+
 83wROt9LEN6Z3Qhy5fc/43Ik1Rw2TAvc4gPN1BXwSzwFzR/+xilBo0d8WfuAxOj3VKNN xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2djag2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 20:24:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 198KKtaY030145;
        Fri, 8 Oct 2021 20:24:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3020.oracle.com with ESMTP id 3bf16yx8n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 20:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZvmVL0pyxwQN7seHr1QSmDu9lvBGataN58Jw2Si+nDIjukXgwFfe+JH1gr40z7wJG9aiqQUBsvjyiVsazNPvdiKnJ5nrtUCA0FGBv0avsDH7C4xTakesVUBlRtmXdf5+UZ0n9zaxljf6uxXylv3rs2anEQkSiw68k6KrJiTCdew+46WavccIknGmJ+n9O2L1dS52b5b6GGcUGVbs2kmd90d1gxdIVy6EMVUHKulPPyXWr1TK6B9gz1q7NJwUPoChVydUDBu+ZxJE8tPUq0pQs0vVRrkLi6tYylYKRumFcrzgDSlf6nYrgHGETFXbXfvhf0FKymKOFzSHnVNGOi13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN3tJqzgmxc6XjG9apQC27cuag6y4NZT0+zehbVR35c=;
 b=glLaKrdQjwD3EtiUsJEIrC1LnbURiiWd+hDEP3IkKwoclMykYtTFIqHInNTzls1zUQggFpkdIkEMV/yDshZRjMUjGwJd/WX2XnGep45yOt8gnuFZ/S0vxwMEYueFF/U0cxQ9sQ3qwlQorkTF87slqd0bAFInmah9BeXbmW/Y+rKtfHULbhIwtuWMljQ1Qnm+Xe86zBj5wyNp2qZ2Ci6SZKOd14Xw9a1lYB17ErqSDU7Lgv/NgL+u5O/GbLwehuJ99HBmg7xqrj9zLuWEALzAEIKma6nMyIe1jmTtDGP3PFJ1LIAxoLGro9W6ntRkeYJL2T0pVSIdSp2BkoYW+kL5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN3tJqzgmxc6XjG9apQC27cuag6y4NZT0+zehbVR35c=;
 b=jKvxpOk2vNHJVHD4waaSYzS0WC8c/1cl3vJ8VhvzawSdAYp+Ao+rqU5QvGchHAOTdbiGJGcN0mynBTpLgA+2KEyaDTOgtrtDAiJQdbyQlmeNzrWosHSFfKWf1mm4ij3DGdrpHam1Yv4/Ekoj++Y3MNggAwENKv5HPWNmTEGWgm4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 20:24:32 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::acc0:d361:da0:dfe7]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::acc0:d361:da0:dfe7%3]) with mapi id 15.20.4587.024; Fri, 8 Oct 2021
 20:24:32 +0000
Subject: Re: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-2-mike.kravetz@oracle.com>
 <YV/4ZFCvoGRn2rtr@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <47e53389-638a-1af1-e94f-b3c7e5e7459e@oracle.com>
Date:   Fri, 8 Oct 2021 13:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YV/4ZFCvoGRn2rtr@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Fri, 8 Oct 2021 20:24:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3396a16-0d92-495c-221c-08d98a99a2ff
X-MS-TrafficTypeDiagnostic: CH0PR10MB4857:
X-Microsoft-Antispam-PRVS: <CH0PR10MB485722F6B5C97FE536498A7EE2B29@CH0PR10MB4857.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SH0ts9tgmnJInuOmzukEO2WkQ1xWs+Z5kckidFSoOYU4j68BxrGsz980dG5hR5EVTJIRFdvcXinpWmqIHHDh4bWNuA+855rksris6rm9ee7U9KInhEXPCRZi09HCd0q436U/SXXWOuEdurzpc/nrFbigKI6nyfJy95hLqrZ+jRCnCwhRThHL5nT3MEjnSsNq3QqheelM1/xvL6IJ/RBDQXODpCrPm87jIrkUOTor7Tq1pD/dG+bzjxYTxpEObN+7iMRTFjHdJfTc4knIJWcaRqfCxF072iCUfhUeku+NPXqtI5iGgx2L0G75zWjfMHMxgravTSQ2Fp3VGq+17RLKnlF4Fc0WAT+leDkMZccstZ7rDFDODnWTDwip1xipH0uNefUAdzr6O0ZHUHR1rBPE33OpC4VE59ONvThGX/wgFey9j7uvt1/ojxpJXvBojuaUDqrMioRNL3eyVeJMeRdG4QVG/kB9enSEaOSFIm4xTLOBH/5Gb7J0rs19PEmrO6u5hHmcToa8W+iHWA8ODV1GfGyIxJpM3Ne1622cDVaSszOlFsPR33/4b/Ei/dtTn5/bBIyBHrEddMEIiPghnc9X/gt7OfcbdY+wOja7qD5gKxmaaGvCfeqX4hA6RvDSZDvpH+dIpa8K1mcqzc3ZwwzoSzKneBZOvtOzyfWPt2iwi2s2TRg402D4KGoYCr8DokDBl9uqA0emnWH8lQaanzGjoRszhScr3KJK28AO/LCF5xPFQE9s04T1hoB33X8WEu/dvyi45Glrvvt1+e49J4lYlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6916009)(5660300002)(53546011)(54906003)(26005)(66476007)(36756003)(8936002)(7416002)(508600001)(44832011)(186003)(2906002)(66556008)(52116002)(2616005)(83380400001)(6486002)(956004)(31696002)(31686004)(16576012)(86362001)(6666004)(8676002)(4326008)(38100700002)(38350700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDAxSHB1cXNScFpNa21pSndrZjdkY2g3Tm9RRDNFT3p0dTEzdjgxbHV5SU5r?=
 =?utf-8?B?RTFOK1hYTUFRQUJaTjhqNGhobFQ3ZkZ3ZHVEYUxUOVh1dU9SbDFlQ0o5Wmlp?=
 =?utf-8?B?ZVZ1bjcyaXlPbUxHN1hEdnNjQktFSHNoeXAwRnNKN0pOeEhMbk5MVVozSktw?=
 =?utf-8?B?VVpMU1ZHdFZINkozVityUWpUbzZNRllIVU9uMi9oY3FCU3Joc1I0RVVDVCtP?=
 =?utf-8?B?TERoSlY0WjI4eGhua2I4cjlsYngrd0hUSHlhQ0lhaTg1cWNuQmZaNTVodFFu?=
 =?utf-8?B?M0gwNU1Kb3FMeEc2bnRmRWRQM1lZSEhiTXdlR1dUaW52SncwV0pTaXlqQVNY?=
 =?utf-8?B?OGo5L1VOR0t3aDVKbzg5T0tUdW5SN2toeHUrOGZ3QTF1ZVpEZXp3bW9sa1VV?=
 =?utf-8?B?cG1GOUlmaURxai9hS3hoNi9WVDlMTHo0V2thajdDdlVJRmEzV3BQcS96aGtm?=
 =?utf-8?B?VXlza1NjRWhXcVpMSUIxdnBJdG5taWw3aFVWTUFPWEMwWXdSdFBkN1htUEY0?=
 =?utf-8?B?Tm5JRTg3M0JMTjlzc1ZERlhBakQxcGQzY1pMMmFsN0JQdnBNN1FQdHRMZjB1?=
 =?utf-8?B?OEd1OXBSYTM3bjcxTVhkTFhja0o5dXY0UnZaUUZ5d2I3YUNxM2IxdXRzL2J2?=
 =?utf-8?B?T3dLTlcvQVdPYzhueFBwVFdnRzBLSldEaEU3QXVBenJmUHlPS2hnQlBhNzVD?=
 =?utf-8?B?MnNQUWdKN0F0UUs2eEg3dDU4ZGYvdnpIc2ZuZVYxL0o0aGREbTFNbnN6VHoy?=
 =?utf-8?B?YjZ0MWdNK0JYWmNLRXErdmgwR3JZb3pkV2g0VWg2L0orQ0RTUUNhUHZGSk9W?=
 =?utf-8?B?SDZLTW02aU80c3hKaDY0ODFYZnhzZFpJK3I1c3l3TGNMbGR4ZmtxcjZvOWR3?=
 =?utf-8?B?TXo4NlYwWUtTcGRkV3c1WjI5NS9TeTBBVzJ1dzNpakk1Y1pCamdFNk04eENR?=
 =?utf-8?B?dUpvUUVQV2Zhb1NXNCsyZWpYM1M1ZDdYR1B5Q0V3aStrUUdWMkYwN3lBSjcy?=
 =?utf-8?B?NEMrall3ZWh6aGRFSzlkWmx0NTdMMnlVK2ZFMEdOWWl1d3owalpobTJBQTVa?=
 =?utf-8?B?aEhkRzdndkVBNkRoazd5dlUwZ1VvMk5xc1c1Q2hMRjE5S1ZnaWg2dUxKdlhF?=
 =?utf-8?B?ZC93ME9FNFVHdkwrRCtCYksvOVgvRTJCcUhwRE1IeFllWHQrRW1EY29vOFVn?=
 =?utf-8?B?RFJGSk1EOG94QmF5TlN4MWh2dkhZRHFyaGpPd0V6YURBckh2NHBkZkhWdnh2?=
 =?utf-8?B?ZVFkUzFOTm4xNjlyMk0vWnRwMXQ1STBxR3Z2WGVuTGI1RVM4ejJxS3BzeGdZ?=
 =?utf-8?B?QjR5Snhkek9pdk45bWpmZVZTaFAwdTJCUkthV0hUMjAyaE9kdUVlVzh2U1F1?=
 =?utf-8?B?UmozZXd4L3Y4SUNJditocnFsMGNwK3czT0FMbU1JR2tPRnNnY1R3S1RIU0pI?=
 =?utf-8?B?Z0JCQ1pHNUp5MVVhSGlqd3lLUURxMXl6SFZBVzhhMnVHTVpYSE5xczNuQ3da?=
 =?utf-8?B?WVkvazJQOTMvRWhtVjg0YXA4bnhqMWpNOE9ObUxhd2E1bGZuMnlTcnJVamdO?=
 =?utf-8?B?UjArTWYrcXVUcE50cjE4M1FheWNsRDZsdWo3WFNPbExqWkZCNldldmNXamFO?=
 =?utf-8?B?V2h1dTU4Y2dPeG12cUYrUjdUSU84dUtabDkveTNVcWxzQmxFa2QwNGcyN1JC?=
 =?utf-8?B?cW1SaU13N1IrWkhlcndLekJFWDlNd3Frdy9wWGNkUGxORHNnL2VIK3Z4WVFz?=
 =?utf-8?Q?tib3QXiXp88ltbqE8f82Pc4JAAv8OZrGhJvHSxu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3396a16-0d92-495c-221c-08d98a99a2ff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 20:24:32.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvLGzGsS1yXf2TdRTB8b0Clzh0/XaF61kX1a0qy7u7hqWofpXMzMsOlfw1gFvV1VVcqOtgPHgAycc1whJHg9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10131 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080112
X-Proofpoint-ORIG-GUID: is_G1BQYdq19ZSZLwLlyOXFeCttwhwHv
X-Proofpoint-GUID: is_G1BQYdq19ZSZLwLlyOXFeCttwhwHv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 12:51 AM, Oscar Salvador wrote:
> On Thu, Oct 07, 2021 at 11:19:14AM -0700, Mike Kravetz wrote:
>> +static ssize_t demote_store(struct kobject *kobj,
>> +	       struct kobj_attribute *attr, const char *buf, size_t len)
>> +{
>> +	unsigned long nr_demote;
>> +	unsigned long nr_available;
>> +	nodemask_t nodes_allowed, *n_mask;
>> +	struct hstate *h;
>> +	int err = 0;
>> +	int nid;
>> +
>> +	err = kstrtoul(buf, 10, &nr_demote);
>> +	if (err)
>> +		return err;
>> +	h = kobj_to_hstate(kobj, &nid);
>> +
>> +	/* Synchronize with other sysfs operations modifying huge pages */
>> +	mutex_lock(&h->resize_lock);
>> +
>> +	if (nid != NUMA_NO_NODE) {
>> +		init_nodemask_of_node(&nodes_allowed, nid);
>> +		n_mask = &nodes_allowed;
>> +	} else {
>> +		n_mask = &node_states[N_MEMORY];
>> +	}
> 
> Why this needs to be protected by the resize_lock? I do not understand
> what are we really protecting here and from what.

In general, the resize_lock prevents unexpected consequences when
multiple users are modifying the number of pages in a pool concurrently
from the proc/sysfs interfaces.  The mutex is acquired here because we
are modifying (decreasing) the pool size.

When the mutex was added, Michal asked about the need.  Theoretically,
all code making pool adjustment should be safe because at a low level
the hugetlb_lock is taken when the hstate is modified.  However, I did
point out that there is a hstate variable 'next_nid_to_alloc' which is
used outside the lock which could result in pages being allocated from
the wrong node.  One could argue that if two (root) sysadmin users are
modifying the pool concurrently, they should not be surprised by such
consequences.  The mutex seemed like a small price to avoid any such
potential issues.  It is taken here to be consistent with this model.

Coincidentally, I was running some stress testing with this series last
night and noticed some unexpected behavior.   As a result, we will also
need to take the resize_mutex of the 'target_hstate'.  This is all in
patch 5 of the series.  I will add details there.
-- 
Mike Kravetz
