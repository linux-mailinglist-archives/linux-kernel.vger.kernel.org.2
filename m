Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339143E19DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhHEQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:56:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhHEQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:56:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175GtSwd000654;
        Thu, 5 Aug 2021 16:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2r8p5WGMUMV6+n1brIkOIppDgjkWhQ/oGT8yn97Bi9g=;
 b=QF/5NrZWNv/9Bu4QeHLpQrl8HHgvwZ6I70fM77B+9CTB6XsOsl1kjSkRIrCTvxdEl0xD
 EgmroSikokuRp2FPF7Yg/qQmoD1hnINiFj3HLCkn2Hh/PJsbJy9yz+kLlxJaPHGGtxGm
 NquYwvUJ3tOjyzqP0mxIsHH/55vOcFwbNKSY8TZrGgFIjCm3l/QWQGlRsAUQXOw2011s
 U2rkLKEFvQzR637MpV8cWSgTdr2V7pwS3GPdUTmgqmLCwFHUyer7V3Rl3PixqpoxWhAb
 4T8fItGJbUyjQKxalrWQe4xsG1cpIgkmujMT31RabvhNb2KHLRTilnT3skS44pbUesbk Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2r8p5WGMUMV6+n1brIkOIppDgjkWhQ/oGT8yn97Bi9g=;
 b=f6rJEYvS11/YIKlodhc3K9jJzN1kyuQaKWMlxfHIZZV/sNXAKDnMp8UFRN+Q6kaj28+n
 stQCwrXzyz6j7vgC5Q1sBkuRfPg+19E6EXShEUNFewpI+cwO+hQZYw3cd0YPWYeDjSv3
 01KUVcLNiZvyq4cCq+qnjrUUeM+Dul6+OtpFJOYS5HE7GJYGr6cGI6mutQrNjFU8l0gp
 KVXAKnCXvicntRf/IlGju4bXSlUk+xv97/Bwsrt3v3wcqpvPOaeKAmVCRAVHRi44WwHA
 lYnlQQIQsKHPHBhPeGlhHSqxBjlxubT2p0r32ZAW4G72bUQgXRtg+IUqd31lppmV0mmO xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpmnm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 16:56:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175GtXuM186814;
        Thu, 5 Aug 2021 16:56:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3a5ga0jjyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 16:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLrNqwKk1z+CGpqWBgKEufM7NkNyivofAhgMW0+pQDIu0pl7VzE/VJzbfh58EtfOoAbRTZtajjgmK+9Zn7pNPcM56u7V5EJ6biRou2CtmGjqrwOC6kfV830jYlfDkNRHfwTRFO+Ve51rl4HB48yf+uJ/3+r7V1jO5Kq8nnzlbOSyIX6CauXg0ozCoanNRBavUnPxqsobAB7EeRQKJoJq8bvR09OsQqWLiwdRvRm9bAMccwOppe/pLjGl8n1Xe9+3H2O8kJUk048DJPsDOap+t37v/+1f89ekZmiuHSW+MrIFP6rlkhl+mwCEcefE7Zl1sn+sBVbf7qrgN2Tnna/C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r8p5WGMUMV6+n1brIkOIppDgjkWhQ/oGT8yn97Bi9g=;
 b=VpdZsfhbBko8LppS0OdmxjVBqNvYQ1+dQL8aSxDaSZLepWlT0R7zEBCf7Onk+VsuzziAbhYj/EtUuCHCpN7qGLlh3gXlOF3cmtUdrBqQ6r7osRrqWi/uYuOZ0W0j7raM43rbrd+fYhzxxyskXqKD6C8zdcvUetpH3E/IjQbRRWNkIlJjntT3LlJi5AU2y4r9maeEhRZXSNeO9+lHr14hnGIgW9ofw0NxTpFLnOHPuY9XVJmY5W7fShIe8TAnaxVD8AaOGMiXZJYiuoBYtHp+N0exHNCZsVOQIf0Efz/+h3zN+hQL0p8Vh5LHlkV93HazrbzVJt7LAo9AQqILpeWAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r8p5WGMUMV6+n1brIkOIppDgjkWhQ/oGT8yn97Bi9g=;
 b=UiUzZmTm81WtjoqF1toA6eimrqmKgnOa8xYwL2IfKSiExOXJpFW7DYdRyUWa1vapy1IBoxuSFzfSEcCFl3Kc6iDbUhxBgnW0HiYdUjJTm6TlV227nQSdbixt/cOPbs3P8vYsYj4lEScp4fEz6B19MtYxegQ+LDWNYDMyGBscMgc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 16:56:22 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::48f9:8d98:c3e:4944]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::48f9:8d98:c3e:4944%7]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 16:56:22 +0000
Subject: Re: [PATCH v1] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Ken Chen <kenchen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
References: <20210730221522.524256-1-almasrymina@google.com>
 <1b970f88-ea8a-18bc-3643-f0e81062f569@oracle.com>
 <CAHS8izOCAq-UG1xcSDi2y3N-Cvb0xFnJi5Qcyr_DwPn63VW3VA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <86051b4f-491e-1f73-4999-a6c318b4eb2d@oracle.com>
Date:   Thu, 5 Aug 2021 09:56:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izOCAq-UG1xcSDi2y3N-Cvb0xFnJi5Qcyr_DwPn63VW3VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 16:56:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0b9119-f3eb-4ada-1cda-08d95831f42d
X-MS-TrafficTypeDiagnostic: DM6PR10MB4153:
X-Microsoft-Antispam-PRVS: <DM6PR10MB4153E5E59886AD5CDCCD7600E2F29@DM6PR10MB4153.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XlAmtlsdN8yEh8fLEH7urUFC/dlu4ljIAb1kSFwDTt309YzFDG91x+E+/sPWMIF6juRA2EcrijFguErXBnRyN9gMfw0xuFwqmMjWcjFk2YX8wCJ193oRpPXexEDuqw0VBUWC10+nhIcyTTC/j1Pfs4zJ/e17YMTIkZXClqrg8wzc8aTs7klIjIY0tpwQ/yTbeCXSFqG77fkDRthtfvLMXizBcXryQRdUSicTzwt3VjYG0wxjwThtm5XA4Kqqqi4TxLQEyWtTb/N1d3pZuuQxadmW+wPangJDIPYyrpFH/uw2mLEZy61M5Zsp4AJ4aSOcvg6HELOdureM2OwYHRavjCu4rt0pT/isYK3eiF3YrI+oades0mwrKyrV6C2ZZ1zftD3GLySNpepe/dGerQebLXvEZo/NJspyGJgXVSuEButBXcDvSLKx6Co4giwxqKHMVwckAAPHe2ANz5mDXYdVDqI+7EEvASjoCypl4bMKvKKPC9H3JRq3/GMObKSc4Xoi+I+yngnhubpRYg8WFVEwYY27yZe2tu2BBDhMz9LI467J4j4Z5N5Tb4G99r/3brG8VWmkR33Dc1STeG8XwK4fj/gxmlTP1tu9jsyNRj58egYVemw3hHo1cpxugpZ+eHfV3UyxvF5h5vLKID9qbpyscYRdnpNWNAVFPJ3Q0qJqeMiuRCv2xOqDFf9igVUwrUFoRJSrGaE1zKQBw33kqLddHQxgdcJd6P+rGYvZMNA6hQP6zN36km0hKMX9bi9Iu6d2EeeMjzXcJ04CsLYpKAP+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(31696002)(16576012)(52116002)(66476007)(66556008)(38100700002)(38350700002)(316002)(6916009)(66946007)(2906002)(186003)(26005)(6486002)(5660300002)(478600001)(956004)(36756003)(2616005)(8936002)(86362001)(4326008)(44832011)(54906003)(8676002)(31686004)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG0yTWVlbjJrRnI2Y2IvcTBrZUp4ZlF1bXZSNnVWRlpXWXpqSWpnUkRndnpr?=
 =?utf-8?B?UXpGaUpMT1g0N2FDU2JuQUp2RmVLUHU5ZnJnYm05bGI3M3liQ1BWWTV4cWNq?=
 =?utf-8?B?eVRmZERFTnROejRIZWVBdlJjYnpLY3ltYmx6Rk5FNmdrc2lMKy9YbUEvYXVT?=
 =?utf-8?B?WFhIUElHa2YzdmpNaUpYdDVBRHhvdXFIblA5bTFhN2MvcnlETEszdmlFMFRx?=
 =?utf-8?B?dWNlQWs2a2t0VldNS0k3K2Jxcm9XMGJvWkhnMW90SjlVcmM5MmMvbmUzZUI5?=
 =?utf-8?B?VTlpVGh1bjRCNkVvbldVTnF2SGtCUmZPcXQzcVNOWFlWREhZMVNQVk4wdUhB?=
 =?utf-8?B?WDZQRGF6QXhPRE1RaUo1YVdoMXJhdVUveEx4R2d2bElGU1ZTTWtSMzNDUThZ?=
 =?utf-8?B?M1FaTHIxL21KaU15TG80dm1NNjlnQXQ5Y3Q4NDNSMW9sajhRZXhQbDBMYWZH?=
 =?utf-8?B?Ly8wYVhsd1htblR3YW5pNm41dWN2RXBkbSsvbm14WlZmRHg3SjhTWUpXa2VH?=
 =?utf-8?B?TWY2Y0tYWWtmNldJeVBOMWVkL0V1VGQvbXlzL0MvTlJ2a0dPU2dvTnYxdHh0?=
 =?utf-8?B?RFBJYVVLcVNVWmdCOEh6VmRHcmx5VG1ZMkxyRGh3ckpRUzBFRmU4UCt3V3Ar?=
 =?utf-8?B?cFJYeGVQbTh6NzJrbG1IZDliSFlYdG93OGxtdVgreC93bWV1RjUvcEdaSmRG?=
 =?utf-8?B?N2JwdHVlTzJwRDd2NzVmR3ZabllsTjlBWWNmRkRHMlNGWW9TMjhSNXlFZ1Ny?=
 =?utf-8?B?blV5dHNVbmQ0Q1pDVzVwdVVHRHdwUGpHZDFTbE5DYzBkOUJBcjAzaU1LYmxr?=
 =?utf-8?B?R0NYendsYm9WSitvRFBxQVhrOFpnS0JwakdiSXZ1MDRVeitoM1RCNE8xWFBs?=
 =?utf-8?B?R0g5dkNYSXlHQ01xN1U3MkdoN3RFNWpwOTRsVTV4dXRLN1ZtL28wR3MzcFVu?=
 =?utf-8?B?V3VvSDRZZ3hjT3JieXRrdW0rM2pUc3lBTHM1Wk1CQ1pDaVF0ZytrcGozQjJo?=
 =?utf-8?B?RXFCM09SeHVLRU9CUEdyV3VTTUswOVJPR25TRHhnbGN4bXFKNWprSTJRSlFN?=
 =?utf-8?B?SG9xQS9EcmhTSC9OMWdnNm5WRTFsTVZYendYUWdwYndCdlFHSnlQRm4zZXJX?=
 =?utf-8?B?VXE1SzhlTjBOU29YYnFzZk5xV0I4WW5oMFhEd0NpY1FGMStIUnBONEI3UWNx?=
 =?utf-8?B?NUZqZ3E2Y01SVDkxbzhvMVlPY0FqMHlMYTBNejA4TndoN1lQaTFPcGZBT09k?=
 =?utf-8?B?WWFFMHpZVVAvcTVSOXVBUkZ6b3JtaWlmOGx5UkhnbTIyck1uMmk1RHhGenVE?=
 =?utf-8?B?THZiNjBvL1ZFVVJrVjRTVXFQd00zb1hlR1pFbWxaSkNXZERsKzRCc0VydmRJ?=
 =?utf-8?B?M1FGTWZzOFN0eG95WGcyNTNHdEl0UDk3RmtRc2xodm5YMlJSZGlLTkRKM1A4?=
 =?utf-8?B?ck9QeFAvUnhiTU9qTjhQOHhiVEdGQlhsQUxPVk1tbFhpaHp2cmdTTi9NTVR6?=
 =?utf-8?B?VW9OWXBRWE1uSW9oYWJNNVNycGdwdHZsSkpCVzhwYWV3YkxrRXdEemR5WTBz?=
 =?utf-8?B?NC9INkFSbWNySjk0TWVlZmNlMyswWmZZV3JoUmR4WUxQVU43eWdja1FhWGJT?=
 =?utf-8?B?Z2dFN3BHK25XK1dnajFCY0w5cEgzdDNuWm14d21CUVBXd1BsSU43N2haRjlz?=
 =?utf-8?B?N3ZNRlZhQzdrOUlKUDUrMENmS2ZnWWZiN0gxVEJUYmhST3piaWVlbTI0MWJ4?=
 =?utf-8?Q?2BB8+NNK7uctHAzfFaciai53MAcPctDvu7A4aMf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0b9119-f3eb-4ada-1cda-08d95831f42d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 16:56:22.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lKKxTdmsuGSiQQe3tlF16DqTaulvgP3hpkSi5hG7jzUTkxcGSYjvnxqcG5gN+uyySasA9Fqi1riUj/LYDsGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050101
X-Proofpoint-GUID: NUoTQrgy-2WCX_CBuYjuv2zYwmFUgluZ
X-Proofpoint-ORIG-GUID: NUoTQrgy-2WCX_CBuYjuv2zYwmFUgluZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 11:03 AM, Mina Almasry wrote:
> On Mon, Aug 2, 2021 at 4:51 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 7/30/21 3:15 PM, Mina Almasry wrote:
>>> From: Ken Chen <kenchen@google.com>
>>> +static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>>> +                       unsigned long new_addr, pte_t *src_pte)
>>> +{
>>> +     struct address_space *mapping = vma->vm_file->f_mapping;
>>> +     struct hstate *h = hstate_vma(vma);
>>> +     struct mm_struct *mm = vma->vm_mm;
>>> +     pte_t *dst_pte, pte;
>>> +     spinlock_t *src_ptl, *dst_ptl;
>>> +
>>> +     /* Shared pagetables need more thought here if we re-enable them */
>>> +     BUG_ON(vma_shareable(vma, old_addr));
>>
>> I agree that shared page tables will complicate the code.  Where do you
>> actually prevent mremap on mappings which can share page tables?  I
>> don't see anything before this BUG.
>>
> 
> Sorry, I added a check in mremap to return early if
> hugetlb_vma_sharable() in v2.
> 

After thinking about this a bit, I am not sure if this is a good idea.
My assumption is that you will make mremap will return an error if
vma_shareable().  We will then need to document that behavior in the
mremap man page.  I 'think' that will require documenting hugetlb pmd
sharing which is not documented anywhere today.

Another option is to 'unshare' early in mremap.  However, unshare will
have the same effect as throwing away all the page table entries for the
shared area.  So, copying page table entries may be very fast.  And, the
first fault on the new vma would theoretically establish sharing again
(assuming all conditions are met).  Otherwise, the new vma will not be
populated until pages are faulted in.  I know mremap wants to preserve
page tables when it remaps.  Does this move us too far from that design
goal?

The last option would be to fully support pmd sharing in the page table
copying code.  It is a bit of a pain, but already accounted for in
routines like copy_hugetlb_page_range.

Just some things to consider.  I would prefer unsharing or fully
supporting sharing rather than return an error.
-- 
Mike Kravetz
