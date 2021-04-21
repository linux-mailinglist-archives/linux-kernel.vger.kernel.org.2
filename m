Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8813674EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbhDUV7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 17:59:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235570AbhDUV7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 17:59:01 -0400
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 17:59:01 EDT
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LLbKI6022166;
        Wed, 21 Apr 2021 21:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=K9FL1qsLufkIPvXdrntgfZvo0gSzHD9PrcNfBGNvLtE=;
 b=vi6g9FQhzE773IiWBdpNPXjaW05i/it0Z2bnMUI+TsrGxTRiBEw+4MJPVbtjO8Le2oHr
 Qc3ghrQ3D7HnKPuJDAgTmWvjtEt3thcrh5DF/ljjUMW/Ne0jycxdyymFbfsctd6GHO4J
 aMO1xX6yz2Rsmm/hTF9PzHXavFBgRVozDndxrxmg8/OsMDcM7IXhAh/98LjzJW2MJ1bD
 bIHPT679sdtfMqs5rcTIXBIvP+T7QEdJdvlR4RuQznCzchhl2Ljh4VlFY0QD85J9o0vz
 wulpTwFSKOOhtl06uU72Y25qbYxCLSnGpv40fbS1KQNjiCQ3oTbTfJclHoHWUtn2nXD0 cw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 382unxg0aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 21:39:43 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LLdaAN104482;
        Wed, 21 Apr 2021 21:39:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3809k2gtbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 21:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjsUtS845n48YdvUJIREq0DFG6wfI2pogdYljp6J+P3it1wMJUafToThMNH/zCCv18ZxIF6d0VMlogVpIMTvOP8mVOlI0T68ALT99KRX4+QQAf88i0COGxRcLqh4O+hDN/B9/dOTS6vnQQPdlY8OPUEndO2s2XrjhMPu3tcC5YDuNh0ZPGiD+A65TPrWDvNe0l7nWMUMIbdFLoJaJHCH2sMD8gtAyGVd9vaYAIBCmoyGB1y5Wp5GpMkulxkobjkQbpDoeQH4O42U75IEuNFh3er2PmpvMqdRjmTvWSJ7WgMxaPID0TzmnoM7nNlYRu69HCpXbW9RorG0mLc4F7vX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9FL1qsLufkIPvXdrntgfZvo0gSzHD9PrcNfBGNvLtE=;
 b=iqbpfZ035q/DKN0tVRn+nrI1LzFiUb/x2ulIRkm8RTmTVMPqCYBvmnhA2XAHxAB5HtxhW7ijBWCOY5qlH22yl6O0sCpQ09+r/zZ+VV+Ql++UIpLYi57zTK1RB2CHDP7tUSpFvpypm8d5YKlvt/6t47OR36fAfKF9YXbp5CYJhbXL3Z21wlKZVC0yW5QaK5/S+RdBq8o1E1kDenM44EMXhdO0z9MsfftbO5HO4VETCQOb99Or6ZtVQiWQK35/E478xQzz6gg4BQ7CsQovFXj8Cjxl1uSaOIea+dRYurZt8FsOctzJe5D9Aj/ZDNq1cmds3DlcKxUF/Lul4Lz4LEHn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9FL1qsLufkIPvXdrntgfZvo0gSzHD9PrcNfBGNvLtE=;
 b=ZPe1egfYxMNH0D+BiLmDJHVtv0FbZhyf/zgav2kjmpiUjt/TH6XieKGRbKfoB2BTk7sg9WSv3ioQt2D6pE9sK4IY46reY8dRloKVv6XX7NSmF0/iHPBxVqRgHnjSzaUAkfre30NEW1dLfv1UqXw35Fmpco3a7yoqInHcNY4WswU=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 21:39:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 21:39:40 +0000
Subject: Re: [PATCH 00/23] userfaultfd-wp: Support shmem and hugetlbfs
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210421160352.GJ4440@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e75874bf-188b-0aeb-c548-01fc3e33bad4@oracle.com>
Date:   Wed, 21 Apr 2021 14:39:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210421160352.GJ4440@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:101:1f::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0046.namprd15.prod.outlook.com (2603:10b6:101:1f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 21:39:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b975588-79e9-4140-5bed-08d9050df80f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR10MB406512957E2A817D54A56C40E2479@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDbCo3HUts9c51ejY0zMwUmhhtQtsV1dItIGBsCdfSGxx1vAHi8ex4CGkWMPrShmVr93dgOhmeBGDdeO0bAbLMonhkjSQX2hkR27D3riM/xRQdron/Wuc/KDcO1v2HgHp446QJq6gXMXqempukklkxKaAG65Dd2D3dwxI/zZkZqtrw6uZ5EBpusIq1FvD9kHDDl4umzrsElGOUr/JQsc9LdWHr9de8+Zd0bGPU3XYbwbPAohPNDhXRGAtrbC7aiqfJJKPCQriS3/jJq4KvjzP1xWnCcRM7k4N99lcqKhCEDiDAUg5YNm7vNYAAQ8beAt81zL1XzMQl/hRzJg4Zz58bSR8DLm8ndwfsO4U5OGcfO5kOyCNFpQREhkRHM3QJ5i5qYNzFzcJTejYuw9iPoEa2OT58P2VK8+q5g5578E0fqA4BX3SKUda+p5wfa02yKO5wHbHrB2pXZ3H13ZoSjidpwpFe1m1ED+SVGm/6EEQfd6jhJlGLyvyM2ehJN+DxR/ZuMo+6udUGHncde85J8w62eCgN7WGADNRaSwBHaFtscamsi2tj6nrIsLX9dugfxuRwAvxSWy+HS5GDBz9Np/DDpJ5S1geF6uO1OT6hPQzqAVtRBaZhcao2EueOfXSKbJx2a7n2oCr/Pj8k+YD9OrCu4xMXg863OdFKYPxQe39x1Uh0gfmn5OejT+CIlrIMngaecYr7RD7YyPK79trOccDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(6486002)(66946007)(4744005)(16526019)(66556008)(66476007)(478600001)(38100700002)(956004)(86362001)(38350700002)(53546011)(36756003)(8676002)(186003)(54906003)(26005)(5660300002)(8936002)(31696002)(52116002)(16576012)(44832011)(31686004)(2616005)(2906002)(316002)(4326008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTkrVldkRjZnaXkzdUVQbUliaStLMXM0OXEraGxzMmZRQlhPbGx0dE54Q0xz?=
 =?utf-8?B?bVBtUE1VcEJaYXYyY1V4ZldrUXNTYmQ5V2NXdWhzQTBqWlUrR2l1VzAzNUNz?=
 =?utf-8?B?dG14blFuOEUxcEY0aVg2Sm0xUmhSR2Y2Ni8vbGVzazZPa3BuUkFmdzBHaDg5?=
 =?utf-8?B?UnBZTG13VThJR2IxL09VWlpUdlJSZWhIc3dsVXhhRFJsT08vdmw2L3RHSmdK?=
 =?utf-8?B?Um8zamdHazNaTlNVcExveXN6aGFnT0tLdTUwbnJZZnY3bS8yMkZYTEU5eVRR?=
 =?utf-8?B?dngxc2dpV0UxMjJGWFB3cEp0OHdlVlNrYWVSa3hwRlE3SC90eDVHSnNnWU9G?=
 =?utf-8?B?bmlSUVNiV0FDSVZJeVhrNEJ1YkI2czN0b0hOQ0NGMEtPZEgyOVJMNy9Ramlu?=
 =?utf-8?B?OHh6ZDN4eFNiNk5kZW8vb3p5ZUgyMzNSdHlQZ1JGd2xZMHpndEMvVkhWdjhS?=
 =?utf-8?B?TTNaY0pQSms0THJUQUJXa1dnQWk0WU5GSlN3ZUUwWklyRmZSc0lCaDdaYVlF?=
 =?utf-8?B?TTF3QmVSQlQzNk15eUtDWTZ0aHhFeUd2a0NRaWhoRGc2ZUFqcEZtL0VHQlhI?=
 =?utf-8?B?a2F6V1hlQlFWalVSenJyY1hTbVhqb1JXeVNLN2k5QmNwQllCM2tQYXNKM2s2?=
 =?utf-8?B?R0hGNG9JZUJubzRwV0JhV1M3ZFVxME1aaHFzVnc3cGFzSXlJNExUQ25ZcFhH?=
 =?utf-8?B?cHh4QkFmMFZWTXdPakc2WTdNUVI2MWM0UHlibW0wakRjWFQ4RTFpSEZHLzIr?=
 =?utf-8?B?WlgyZUNIRlNWTjBpQitmTUdiZEt4cGNpeklmNzhRcElJaDI1L3BVUFhMaEpt?=
 =?utf-8?B?TFhpbkw2SWFXVDFLL3BjMTFnQVdwRTBNUEZqUlh3a0dQczhZdm9aQy9DYnJN?=
 =?utf-8?B?dFArU1hMZWVyWHVGM1lQbGdPbmU4YlZ5eE80L3FlWGhacnRuZ2xLaFdOaWR4?=
 =?utf-8?B?WnllMytGUkl4bExwSXM0OWt5RjYyZ2JtTHVjckhFUzVNTWRLcVMyUm9XLzFT?=
 =?utf-8?B?OXA5NnJqZ09tTm5MTVNIOWRKTlRVRVAra3FnNERzUlVkdzQzSWVUVWV3U1BH?=
 =?utf-8?B?UVFLd3Z6ek13U1NxeGdCbHpwcStjaThxcS9CeWxQS2dMbG1QVXVKSnZZTDdM?=
 =?utf-8?B?YkVOR21aajB5MmxMdUplR0FCdDhGRmZqME5IdWZIMVplSG1IUDFTWWRndEJs?=
 =?utf-8?B?QnRhb1FuUWhyTGVJZGhFMTNXUFR1bUJCZnBxQ09ZRG1MTWhxSTlnQmwvY1Vk?=
 =?utf-8?B?WkQxRUxDaGtNZjJPcE9NdFUrOWxES0FVMGRsSEJyNEZhelgrYkVza1d1MW9k?=
 =?utf-8?B?QzJvNXJlbFZoMEZKbnl2akM2czM1blNoSGlRZ2xPTFRZeU1FN1pLTjNxMWF5?=
 =?utf-8?B?QnN1MjNoMDlMeGEwZVllL3BGandFSksxR1ZPc1pjbjdycys2UGhjYU9XcGR6?=
 =?utf-8?B?V2FCOXAwWGNFM3pqZVgrTlE0c0t3Rmc2TjdDbXlCS0lFZlhaODlKN0FhWnJB?=
 =?utf-8?B?VGNBTkVPbmxXZnlRUTliVW5aMS9xN2xoYUxZTVVzb3R1Mjl3ZENiZ2drSkM5?=
 =?utf-8?B?OW1ldGRtR3hVYm8yRW9YNitocG5XcDJ6am1ueTRRWGF5eVFnSnBWaE5heUJR?=
 =?utf-8?B?MVFIMndvMHBYa01aSnQvbXdSS09pZVM4Z1RBbkFUN0NDV29jM3d1aERPOVBh?=
 =?utf-8?B?RGdFUGxhUkdHYmprSHRMb1g5VHcrcG04RnZNQWh1L3JaMmdpbk5kVmZqNklY?=
 =?utf-8?Q?jNfIxLp042t0VKmkfnxAMIONNNDDDTt88GNOD0m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b975588-79e9-4140-5bed-08d9050df80f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 21:39:40.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WngNA7Xj8Zcwi8v88N2zg2zyZlRIo9t/Zwq0rDuXkbaIzZeuyrv/rLzLv9V48K8YCuRLpJ4k2dXkPlW2OqjsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210143
X-Proofpoint-GUID: ezJre5KnkNyjdXx1odfjy6BGh8G9NLfb
X-Proofpoint-ORIG-GUID: ezJre5KnkNyjdXx1odfjy6BGh8G9NLfb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 9:03 AM, Peter Xu wrote:
> Hugh, Mike, Andrew,
> 
> Any comment for this series?
> 

Sorry Peter, always get preempted with something else.

I'll start looking at the hugetlb specific changes and back my way into
swap special pte support.  I feel qualified to review the hugetlb stuff
and hope others will join in on the common infrastructure changes.

-- 
Mike Kravetz
