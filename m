Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01252330885
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhCHG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:59:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCHG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:59:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1286t92V064607;
        Mon, 8 Mar 2021 06:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NpfKH6ozlIlpA197eT9irgtRzkeb3MMCyTVIxRWAys8=;
 b=QUj+GM0Rf23nrL29/CHpFyVUG61thrhL/9cZgPHqPugCPXVg6jlxbDBKp/BLuX0zzvvr
 Uy+Qd2AML8l5wY9QTk9vN5yGZMWTRT5GpZxtauJ2I4p7PEgkCO3gSZb8DHny0LIwcjlL
 rBZHbeNugwtPTJwfed2IiJdr3F78FcSKDyO4zugnKi2g8FlxdnZQc6bs0JHrtvqJ96az
 aJvcx3d5TxqZaJIF2SZ7tfLeN2ASn+P0aFzLFo61Q4+bX9BkOWA0eUlBtr4wNhrKksgN
 QxF+3EwtOjUjGLhE/Xio51vIwdRl+x61XP6gGYrnmY2PKKf4h/WWF8fcDKzuzEQ4fKum uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3742cn2gwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 06:59:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1286tJCj176569;
        Mon, 8 Mar 2021 06:59:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 374knux1s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 06:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c61yU5BRF1UreQl1vOei/KS2kracAtlebVXAO7lHAA4GvqVL3mah/QmtBqpHaQMDYW9hgWC6PinsnB0UNfWKgUyHd9FY9KCpEzyJ/s3fzsaReUt/wATF0ebqRwZAGwU47Nzj8duvd0DuFFFXUn+4zdWEg2pI9ewk9A8mmxdgk+lda83yoOMYH19clXNhJKvya09Ah/+9IVVKpFFYR18EDJmN/VRWyxub0nWov7N/38s11krNt7GjDI/CRgrFTzPiJSc2nQp1ug4ldRIC8jCooMnzX2fC4FEQCdra7MIy2QUsLdrhZR36cqJSrNpkOVBIVtbx6b6nvDex4vtfPCwV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpfKH6ozlIlpA197eT9irgtRzkeb3MMCyTVIxRWAys8=;
 b=fnunk+idtROj30vtylAPehOsaWk/JshNjboMwJRpIVIHQ5kae5Cb3h4lztfbPjE6eTR/O3Yc95U9S782tZbBMpMEf9MHVOhIEXLcsh/jtZN2lqrwBFJ5kjHGq4bXjQvmVU4RABL/Q4Yc7tUd+7IqNXZN3f4d0rT5GpT0kWmRemN7samwRr+W1V2HYS4JiUv0WmOav3QB2ab9W9zQwqqrobZSefJkjFiFztuAI2shbCZdPwTa7BnFvdUXv1l6PtiJvOPHG9RjCTevML1ngeXOWl7lg3yjx4RwOwXVr5QimbNwW6E/QqtbKoyw5eXAYcNZ9eRjHaCdcj6xX+KY9YK6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpfKH6ozlIlpA197eT9irgtRzkeb3MMCyTVIxRWAys8=;
 b=gyGuMkUhvwPNWP9gpfjEJIUeKUDYws5YhR2FQbWsHRY5f1fslE1x15YlC4qgg/Mx6caCOvBK4xDD8hhO5SExmk6pfiMZTM1NMWr67EcpCfhjNGHf7XkRrrV51JDrJqaCtTDxgE1EZBRZrXAyXTKFPW8MMjPHlgw7H1sH2JQPf4E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 06:59:13 +0000
Received: from SJ0PR10MB4605.namprd10.prod.outlook.com
 ([fe80::a021:790:7ce6:6f16]) by SJ0PR10MB4605.namprd10.prod.outlook.com
 ([fe80::a021:790:7ce6:6f16%6]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 06:59:13 +0000
Subject: Re: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "terminus@gmail.com" <terminus@gmail.com>
References: <20210121043907.76037-1-ankur.a.arora@oracle.com>
 <20210226005333.1576246-1-ankur.a.arora@oracle.com>
 <DM6PR18MB2698B4CB0114D7D1FCE74B4BE3999@DM6PR18MB2698.namprd18.prod.outlook.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <9ece62e2-df7b-09b0-d96a-8105048c0ed0@oracle.com>
Date:   Sun, 7 Mar 2021 22:59:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <DM6PR18MB2698B4CB0114D7D1FCE74B4BE3999@DM6PR18MB2698.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [148.87.23.12]
X-ClientProxiedBy: CO1PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:101:1f::30) To SJ0PR10MB4605.namprd10.prod.outlook.com
 (2603:10b6:a03:2d9::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.108] (148.87.23.12) by CO1PR15CA0062.namprd15.prod.outlook.com (2603:10b6:101:1f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 06:59:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f7b8be-ce4f-4211-742e-08d8e1ffae4e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4798:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4798C7CD82094F1DAA4BA582CE939@SJ0PR10MB4798.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td5PUEq0IrzW+uRsh3lpntISCPQC1uO3qoxq6p4CcazoDJjYa3nb2NjlN/toSCBMs/gHCqy8cSq3FX77R5je+ByYyMkBHu/Wg/az0aq4/05nQEe6ZARs4SES4iIn/O85/xEiezZYfytBuQIBjc2I09yha8nGc4yV/BLM2dlGl8tVvVhbjL1kKv2LBnUWsrLe21H0GKH3ROFHpzrtzYxGB+R1w1LgVRGPqC7DbJQ+agNxttY30bste9VzSU5vzAAwy0yDmHPTHeLERsWGQpQZ0geI3iqgfnHw/AFxDPZ1oJ0nv2D6jsR07GUJIfMxVoECYNTYJgdPfx1xkMGp3dkSfz6CVW+Vev3FkLw69rpVGphfByy3if39+Jf4LFk5D/Dh4uyuuRCem8lOPK3oOrjww391EL1+hhkaHAc8P8iKu/cJ+vF2UVpYguQUQtroVC60RWXh2eYvvKLvASknsWaJU+yK8yYGxXgnH3Pf/Ot34MmKQyZC6ils6B8I8QqMNtuUneRbT9iBeG5D8IMzbf3wwQTlmIxfTSLD+f0/gFZ5i+2JjD2ccjkD5Kz5q+7W5D3oGas/Xnz1hmuQiJZF5MKtlaGP6YLa7rpxLYg/B9p3q0NoYaMNVhAMMJIVAoBnb9pilhvqnL63do1+jmNIhJpBocaKL2Rl0pgfbM3nUzz57ngwjhSUN23qwhJnAN836eIb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4605.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(478600001)(54906003)(16576012)(4326008)(31686004)(31696002)(5660300002)(2906002)(8676002)(966005)(316002)(86362001)(8936002)(53546011)(26005)(6916009)(66556008)(16526019)(186003)(66946007)(83380400001)(956004)(6486002)(2616005)(36756003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFJzeU9HQXJlZHhwd09ZS3JsaC9pWVlnWHc5RDJnZzR3TUhydFo4UWRSR3pX?=
 =?utf-8?B?WE5waGQ0Y21TTUZrL0tYSVMrNG1OY2cyRVdieFF4VjkwdUxzNDhYSE9RaGlF?=
 =?utf-8?B?SzFWUHdDKzBlckx0MWUzaDM1dkJsWFZYNmZUaXBpdDNKKzg3S3BieU51MFVy?=
 =?utf-8?B?THFPTVpxdlhpSHdNRWhCd1dxR1gwaXZ1ZDF4V2tOTmFic1lva0dzeklDOU9U?=
 =?utf-8?B?NzhXbDNxNzBkc1RaanJiV1AxUUo4MEpxQ2VCb2x4bnd6VnlubTljakdDdzhQ?=
 =?utf-8?B?TXlLTXNtcDF3cWduTEJQQ0FranhsdTJXUjdGWVBrMVhIa3pzK0NWUSszVnpu?=
 =?utf-8?B?YUV6cVlGVFdhQ1pORXQyOVNsVTFnSnR6Y2RFRmtjeFBTNGNaRGJRYXdTV3Rw?=
 =?utf-8?B?dERyYkd5RGRmY0FZRWxIekJvS0c1eitQUXd6OVM3UGMxbHFPT2NvazN2YWVk?=
 =?utf-8?B?RHFKbldleUdtNjFhRDFocXVEdS9rYXpQVElEdWtzZEFHTlczcEtwZldvdGdE?=
 =?utf-8?B?MVVhbmJLNUwwOXZSMGdGN1d0Uy9rZmFWUlVxMFRFdHpWT1BOMGt1ZUZBZEsy?=
 =?utf-8?B?Z0t5K3EzU3JMTzBNYU4yYnd4M1ZIR3I0NWhLcEpXWUNheDFocHlYWlkwbGxX?=
 =?utf-8?B?UG53QUYvT21XSjhzNHF4YTRxS21pUVh2QzhMc29yUzVqckV6RDl4OXZ0UkNU?=
 =?utf-8?B?TGdqZGl3V0RqaEhLNjdTN2UxM210QlVnVkxZTGg5UjUvSXY4SmRRREp1Sm5U?=
 =?utf-8?B?c2UzN1N5M3JpTUFmeXpKakR0NnI4bWVaQzNXZXZwaUYrQ3V6WGl0ZmpCTEZ6?=
 =?utf-8?B?QThBVDllMmR3Wi9aN3hZaEJObDcyUDg0Z1JCaFRzZVVxbldoaERyVVpEckkr?=
 =?utf-8?B?clRVemJlUUNEUVFCbStBMmVMR3pDYm03U0hxSHBRcGpySFJuN0lhT3ovVmhV?=
 =?utf-8?B?RDViWU80NnhDYzZDdFlnK0dGZmZ1b2RQS2tVTktuUC8rTCsyYS9ER3p5RSs0?=
 =?utf-8?B?R3hscDRIcjJ2VTBVS3JVRHFQaXh6RXJpeVRYN2dGdTEvM3lzYXJXMGl5Zlp6?=
 =?utf-8?B?RDZveHJlY2dxS2JDUTZVbUw4VWlwRy81c0dEV0c2Q1A4VTVJdGx0dWVFdEhO?=
 =?utf-8?B?dk9oS0txb1dWTFVrY0pDdDlSY1dNZXdGM3JrcTBRcEN0M1dMSkhlRmFxQ3dB?=
 =?utf-8?B?NHpqUVg1U2ZqUWNDWWRNdEU2cU5jQmMzL2VmQ1lJY3pXZHcrSVVpQnVzL2pz?=
 =?utf-8?B?SlM5Q2VuMkVMbWRneVlhZXZ6RDEwRlBia1R2L1N0S0dnUjZKRE54SWM0eHhD?=
 =?utf-8?B?elluTGQyN2gwZ2xFU1RIbmN0Q3pwUVR6SGxQMlY3TWpDR1NzOTR5TDdkcHk1?=
 =?utf-8?B?dXJkRjhyc1RvNEtyYkdhYU1yK0F4NTBBeGYvMWxRNjFRODIxUlhCbjlzT1BM?=
 =?utf-8?B?cGdueU00bVpjdDNhK2g2RnREVk9yWklXYTR6blNGMjdQTGhQWHQyOGJidVNu?=
 =?utf-8?B?bGUwcjZYZytodllzeWc4S2N1bisxU05SNVg1Q29MMjl3cHo3eDNEOHZyaXho?=
 =?utf-8?B?Z1lwMllpbFQrRTNwUDE2OUVIYVJvMTRDRDhTdytaeEtQVWlBN3lHMFlPS0VO?=
 =?utf-8?B?ZEM1K2sySjV5c2tWV2w5NTZqbTh6QjFXR2ptVHhQemFrM2ZTU0VGTFN4RHZF?=
 =?utf-8?B?SWlvUU1waGZXOGhoL0ZFZjE2VDFtKzJIZ1EvMVBhaTJsYnJvRnhPQkY5RXZr?=
 =?utf-8?Q?TIyObDp8s9w4w1VS2nQYr99N5oPz3s2Se63DeGO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7b8be-ce4f-4211-742e-08d8e1ffae4e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4605.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 06:59:13.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VNJMLAGZqGX1SjMh8f6qXtKubeowq+ZR2cYtdJ51NumA0b1RqR0dUZOvd0EdtrQEmmPcFJL2UHU0UtsulzTK8TyOWmzKHiDNFCennPS7rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9916 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080036
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9916 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-02 4:47 a.m., Bharat Bhushan wrote:
> Hi Ankur,
> 
>> -----Original Message-----
>> From: Ankur Arora <ankur.a.arora@oracle.com>
>> Sent: Friday, February 26, 2021 6:24 AM
>> To: Bharat Bhushan <bbhushan2@marvell.com>
>> Cc: alex.williamson@redhat.com; ankur.a.arora@oracle.com; linux-
>> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>> terminus@gmail.com
>> Subject: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous calls
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> Hi Bharat,
>>
>> Can you test the patch below to see if it works for you?
> 
> Sorry for late reply, I actually missed this email.
> 
> Reproducibility of the issue was low in my test scenario, one out of ~15 runs. I run it multiple times, overnight and observed no issues.

Awesome. Would you mind giving me your Tested-by for the
patch?

>> Also could you add some more detail to your earlier description of
>> the bug?
> 
> Our test case is running ODP multi-threaded application, where parent process maps (yes it uses MAP_DMA) the region and then child processes access same.  As a workaround we tried accessing the region once by parent process before creating other accessor threads and it worked as expected.

Thanks for the detail. So if the child processes start early -- they
might fault while the VFIO_IOMMU_MAP_DMA was going on. And, since
they only acquire mmap_lock in RO mode, both paths would end up
calling io_remap_pfn_range() via the fault handler.

Thanks
Ankur

> 
> Thanks
> -Bharat
> 
>> In particular, AFAICS you are using ODP (-DPDK?) with multiple
>> threads touching this region. From your stack, it looks like the
>> fault was user-space generated, and I'm guessing you were not
>> using the VFIO_IOMMU_MAP_DMA.
>>
>> Ankur
>>
>> -- >8 --
>>
>> Subject: [PATCH] vfio-pci: protect io_remap_pfn_range() from simultaneous calls
>>
>> vfio_pci_mmap_fault() maps the complete VMA on fault. With concurrent
>> faults, this would result in multiple calls to io_remap_pfn_range(),
>> where it would hit a BUG_ON(!pte_none(*pte)) in remap_pte_range().
>> (It would also link the same VMA multiple times in vdev->vma_list
>> but given the BUG_ON that is less serious.)
>>
>> Normally, however, this won't happen -- at least with vfio_iommu_type1 --
>> the VFIO_IOMMU_MAP_DMA path is protected by iommu->lock.
>>
>> If, however, we are using some kind of parallelization mechanism like
>> this one with ktask under discussion [1], we would hit this.
>> Even if we were doing this serially, given that vfio-pci remaps a larger
>> extent than strictly necessary it should internally enforce coherence of
>> its data structures.
>>
>> Handle this by using the VMA's presence in the vdev->vma_list as
>> indicative of a fully mapped VMA and returning success early to
>> all but the first VMA fault. Note that this is clearly optimstic given
>> that the mapping is ongoing, and might mean that the caller sees
>> more faults until the remap is done.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-
>> 2Dmm_20181105145141.6f9937f6-
>> 40w520.home_&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=PAAlWswPe7d8gHl
>> GbCLmy2YezyK7O3Hv_t2heGnouBw&m=3ZDXqnn9xNUCjgXwN9mHIKT7oyXu55P
>> U7yV2j0b-5hw&s=hiICkNtrcH4AbAWRrbkvMUylp7Bv0YHFCjxNGC6CGOk&e=
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   drivers/vfio/pci/vfio_pci.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 65e7e6b44578..b9f509863db1 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -1573,6 +1573,11 @@ static int __vfio_pci_add_vma(struct vfio_pci_device
>> *vdev,
>>   {
>>   	struct vfio_pci_mmap_vma *mmap_vma;
>>
>> +	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
>> +		if (mmap_vma->vma == vma)
>> +			return 1;
>> +	}
>> +
>>   	mmap_vma = kmalloc(sizeof(*mmap_vma), GFP_KERNEL);
>>   	if (!mmap_vma)
>>   		return -ENOMEM;
>> @@ -1613,6 +1618,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault
>> *vmf)
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	struct vfio_pci_device *vdev = vma->vm_private_data;
>>   	vm_fault_t ret = VM_FAULT_NOPAGE;
>> +	int vma_present;
>>
>>   	mutex_lock(&vdev->vma_lock);
>>   	down_read(&vdev->memory_lock);
>> @@ -1623,7 +1629,21 @@ static vm_fault_t vfio_pci_mmap_fault(struct
>> vm_fault *vmf)
>>   		goto up_out;
>>   	}
>>
>> -	if (__vfio_pci_add_vma(vdev, vma)) {
>> +	/*
>> +	 * __vfio_pci_add_vma() either adds the vma to the vdev->vma_list
>> +	 * (vma_present == 0), or indicates that the vma is already present
>> +	 * on the list (vma_present == 1).
>> +	 *
>> +	 * Overload the meaning of this flag to also imply that the vma is
>> +	 * fully mapped. This allows us to serialize the mapping -- ensuring
>> +	 * that simultaneous faults will not both try to call
>> +	 * io_remap_pfn_range().
>> +	 *
>> +	 * However, this might mean that callers to which we returned success
>> +	 * optimistically will see more faults until the remap is complete.
>> +	 */
>> +	vma_present = __vfio_pci_add_vma(vdev, vma);
>> +	if (vma_present < 0) {
>>   		ret = VM_FAULT_OOM;
>>   		mutex_unlock(&vdev->vma_lock);
>>   		goto up_out;
>> @@ -1631,6 +1651,9 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault
>> *vmf)
>>
>>   	mutex_unlock(&vdev->vma_lock);
>>
>> +	if (vma_present)
>> +		goto up_out;
>> +
>>   	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>>   			       vma->vm_end - vma->vm_start, vma-
>>> vm_page_prot))
>>   		ret = VM_FAULT_SIGBUS;
>> --
>> 2.29.2
> 
