Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE33B8BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhGACOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:14:16 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:36842 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236453AbhGACOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:14:14 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1612BYcB015807;
        Thu, 1 Jul 2021 02:11:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 39ga5r934h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 02:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajwjkNVM83nU0hVPTmI6uFrDEAL3JPbwuy8VSeD2blA8KE1Yz0B3lNKsfgNanCCjP92TJBXZuVChfcogFYp8ojZ5ytYmTQxVDEGHy43bOeUTWACc/CPO2wdxOXDv6EZ+M0b4g1Xk5bYwlKxd4Gj9d47P4JaXs9StLG3xD00TF/ZeK4HsSm3hPzoMFatFkA1yvqW7guHqGOe/nQcaZhRbz+2SAXNtnoLpoAf9V+fFSgju1+50BZ+chUlIKVWWEZYWW3+XyXb4EQEHHnvbaD7wpd2yCcOPf0ZwOQShuCmjSFMY670+KTNmhW5w+2+3EQ76FToD7EGnGwiu+WI7uHKiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLOYW8upqiOvp3nL70jirMCEh7A5QGDGyeLGZKszbnc=;
 b=bR5sOABy9KhFiyqvGOYmIpE7L1/4OWkw75M9+pXCn3uB1AZ2s96Yi7Iig74DepkLQ1o+UQ2noFSCN113tr51iuKONvMmlp55e7nCGctfz99scf3l1sNXNmgHSoMfISmTnGV6j0/0GnkSRElqMwSNB0TkC1zhyxRIfBgCqFWJCV2hxiSB0C1aDpHCmt6ck8b9KTeR+6i28pruAYcI1mZtnuAChG4rvj7ZfkgrZuZXNzoJpSUPB1dTtpd3taAzaFFaBEpQlnTmoUCNL/VxrRe10NqoQLVl1aSgJB3uRGP2smWa1kcpopQy4szzKaGqmnN2tPR90OScaMJgVSGPbW63Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLOYW8upqiOvp3nL70jirMCEh7A5QGDGyeLGZKszbnc=;
 b=RXk3UdguMUZgZ59Kj5F3x3kPCU1SxPYcDwipgvagwXzwS+6SifHyHMVgtLD4OZJfbVQpjHha9hGyrBSd0/Un/+ENuLojE+lWIMfbSLWM0Q2DBsX3BtMus9ave5+2ixnfWFyYxIJwTuqBqAryZ1jmEfi0mqgOwL1+Q87dt3iSk6A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3061.namprd11.prod.outlook.com (2603:10b6:a03:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 02:11:31 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.027; Thu, 1 Jul 2021
 02:11:30 +0000
Subject: Re: [RFC][PATCH 0/4] locking/mutex: Some HANDOFF fixes
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210630153516.832731403@infradead.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <d488d413-f151-1863-942c-2cc4edc09645@windriver.com>
Date:   Thu, 1 Jul 2021 10:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210630153516.832731403@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.2 via Frontend Transport; Thu, 1 Jul 2021 02:11:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7cc1550-d658-4cea-d4da-08d93c358a83
X-MS-TrafficTypeDiagnostic: BYAPR11MB3061:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3061DF6CE02E97790A2149BFE4009@BYAPR11MB3061.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dz+8rYfYbUPZU6jm+zhV7xAvNGEpMYB8ROsSLZCF/rW7jElaEMl34oOdB7QVSi4ePk5+bYPqY6pyTP5Gnri4r+Ae0Qu2JIngyyZQg3hNvd0TI7TFWnRXwos4nYp9LUbKwTF/r0xarGMx+yaPjRaxPIOsz604XNllQ9pUNxyfTaxJnV2vC12lQXtOj5eAmZwz9dNeJLyYhYb6ACUyPkM7rYkGGgCED8mW1w5+epZfntdlKbG1zkPQkES3Fhd6Ts+S3IzFe7ejtBNr+nS+dUqxajWKG2uXYxLPrWFh3JpDjyKTcSsgc/63YhjvmXn/p2vdzk68va2v2i3JpD6dMKmNSIbGYpqezJIjW4FmXNJ/EpnQIl1PLu/5SDchFAaYj9Tt7x+RguSqwP3BlfuTYNoDtgJhOHrz2Y5Go83sAKKf9fgG7WC8K9BivTw+1+T18pp3CHbREXAH5WHDeuygMyb2SWAzX248roiHntmTrhqzvaG6UhuZMGg3WNEEmdOavc6F/HPGGDhsHKxj0b8bUdL9CXctdy5510EcjJbGYlIUt10yt/Oc5PX5lN/UU8uFUQErV8yoZrLgrNsP6gizTcBPUFLNmHVyRpiWA0pRQcNNmaces6ooZb0Vat+W8EWJ9JOKm6Q0Ed9e3IMFWcoSGc9c1AJb9ryWSn1MQSjS9VUxAe2y8zGfeWS6nBQ9N6UYgF+vlzhRd4QPHHbh7QRjbzY5+XZORgWG0w1jYaKWqolI52MzwkZHr7mLfffo3GDsjWzU3Y2QWOsfwk694L7slhP9q8TNoYTp/TXJyxRUlPrjPds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(36756003)(8676002)(31686004)(186003)(38100700002)(6666004)(53546011)(26005)(38350700002)(956004)(2616005)(16526019)(6486002)(52116002)(316002)(31696002)(2906002)(5660300002)(4326008)(66476007)(66556008)(8936002)(66946007)(478600001)(6706004)(86362001)(16576012)(4744005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhzZER2OHp6Q3FXajJkTS8yemRWSmx5eUg1TXptL0NrZys1ZFNCbzYrZkxn?=
 =?utf-8?B?RFRyUFlXYnVoN2srNlYxUEp4bnJQQ1ErUkVOaUxmc3p0OEk2Qzl2YmlCSm1v?=
 =?utf-8?B?d1k2bzdIUjVxNDFHUE41UENQL0R0SXVCaFBXQWpFSUpEdHNkMCtBbHREZmt5?=
 =?utf-8?B?ZHg3WkZnZzVVa3dleVhROWdGTHpqVnNBWDdEY2xsSzRQZVl3NkpTS3VBdWJl?=
 =?utf-8?B?Q1ZoYXRCQVNnanY3aXVKSGZORUVpcURjbmtBL1MyYUdvdXdpWlRVZVpJbUgx?=
 =?utf-8?B?Z09JZnFiQVo2eVdlWGhyRU1WdVdTTHRMNVRnUVZrKzRia0Z0aGNvQzBMSUxh?=
 =?utf-8?B?WHNpRlhIQWdQVVorU2lCMFJyT2tqSlFHN3ZpL3FwTTYxcDhIbFhDWVhVdmVH?=
 =?utf-8?B?RnpKalJEVExyeHBPa1dwZnhmdTh6ck5OVXVIQ1J0VGNXS0psc2R3bERDc2dt?=
 =?utf-8?B?Mi9ydytIWEtLK25uS1lCdzJqWGNyNEZTWTVHK0hhWUJudUVXbHdoclRZSHdw?=
 =?utf-8?B?RUowV1krbG95RGJIQVJNNU5MZlEybDQwd0haNHRJSDE1SU8xWnZlK0pJeGd3?=
 =?utf-8?B?YlNJMkJwaDVjV3BKUVNEeWZQL1JyNWxyUXRWZ3o2dW5xMjJPR2RzblBTc2s3?=
 =?utf-8?B?dmUyMW54dW5FLzlVS3ZHeG9UbDhBeGVRUys3bUVXZEh4emEwdkg5bXVDcnBC?=
 =?utf-8?B?WDFxZXprM2JSV0EwZ0VpVmdUeUdzb2xoT0p4YnM5QXJ3ZEdkc3ZhVEdIKzl2?=
 =?utf-8?B?c3l3WHBmVUt0cVJZWTZzcEJ2S0wxT1VFd1pXZ08vdXg5TzRWZ0hybXViUjZC?=
 =?utf-8?B?K2xMcEFaSEdLY1oxbUdqNUJ2V3YvYTRqWGpUb3VOdmd0bi9WMVl4V1U3b21E?=
 =?utf-8?B?eXN3ay84aTUwbWJlWXNXYWVRSEdjMkpWc0Jyd0RING1ML3d4N25HU0FPRTJP?=
 =?utf-8?B?VXo0WVFWUHEyMEF1Uk5pVGRTOHpVSGJSaFRrN0sxeUxvVi9vaWk2M1E2Z0g5?=
 =?utf-8?B?NDhuUk1SNlc2RmN5eCtwc0FVbHJQUnpHekJkM1dmdGR5S3NKNm1zd3NyM0Jx?=
 =?utf-8?B?TEo4TVFvRXRUaGZRcmh6VThsTGFZcjFXbGlYMWoyUUttOWlzUmhmYTdMYlly?=
 =?utf-8?B?VXJWbnNNSFpsUFVwSmFZSDZaNTR0d0ZyZnl0NU96a3Q1b0huMVdzZUZIWEJK?=
 =?utf-8?B?UzVMMnAxVG1MY3RmOFV3U1pEbS9DUjVLQ2t0QlNHUExCK3YvZEc2Vm1IT01p?=
 =?utf-8?B?Q2lLRnRXWiszT0x2T1NoL2NQL3NFSUxPbklkWDVmTVFDTWtGeHdIaWxGd0M2?=
 =?utf-8?B?ZTF5cHljRXBnUjhNbEF2NzBXbnBzZ1FEb0l0dkRuWHRaSnZTakxFdjBFcUE1?=
 =?utf-8?B?NXB0STQzTWpON1o2NGlSYWNGMDNSUXZmS1lkZWlqaVBLc1czMW5mRHQySGNr?=
 =?utf-8?B?SmtBNHR2QXF5Rm9QclowSVJnYkwwTVRLT2JkbDlYRjdhaDZRRUllZnU2aDV4?=
 =?utf-8?B?Y3hBOUhTaldLMVdsOXB2d0YxQWQrVVByTS8xSWFWT1RlSDFCbjU1VVV3Vm1T?=
 =?utf-8?B?Q2pteUI3SHVYeUtHeTdhMWJ6TkdjN1FwdVM0TTlNbDhJaTEramlORDdNYW5u?=
 =?utf-8?B?MFBpeHQ0cXhsaVhmR1NuazdVakZKSGpCVllXeXBSOGdGTGQ3bXFLS0Zocngw?=
 =?utf-8?B?b0N1UlhpQmJUVXRPZlQrRjA0WGl6YndITE1zY09iMTcyM3R5M0NlQzVLTUgw?=
 =?utf-8?Q?zJTY3ixNYqGnZb7kysKV5EGjZY8X3z814AF7irj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cc1550-d658-4cea-d4da-08d93c358a83
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 02:11:30.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS93WYKkUpeMsgfAeSMJILTfyqQjFhMlvbKGyTGc64OpkP/5sxKwxYBvgxOj+nr28+Pn/0YiYuvZwf0ybVtDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3061
X-Proofpoint-ORIG-GUID: 9FXnn7QAaeLhFMAdl_BiZtcR5PoJmV1y
X-Proofpoint-GUID: 9FXnn7QAaeLhFMAdl_BiZtcR5PoJmV1y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_01:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=991 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/21 11:35 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hi,
> 
> Cleanup and fix a few issues reported by Yanfei.
> 
> Waiman, I didn't preserve your reviewed-by, because there's a few extra
> changes, and I've not yet boot tested them.
> 

Looks perfect to me :)

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>


Regards,
Yanfei
