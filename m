Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16DF451C53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbhKPAPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:15:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1680 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354112AbhKOX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:28:35 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNNmDk001717;
        Mon, 15 Nov 2021 23:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DbXhL3PTSczo8azvjqaIVL+YlNhhi5G3lrYX2igzvlg=;
 b=p/AWO6ZLAAxfEtIQApcUxMhw6qNVeNZ//7Z7Wn8HYoolbnqoaUIFaMJc3zSa4FwMwEcn
 Fz/8yQiCfZx5/HESQsON8KvkEqEsjoYi8gToo4Hf7n1hd3n7xFth6q88heJM+3IP/Y+t
 yTwHXBB4j5p3oKoHuUQGBT3AvFnQrZFAZ1J6SU1GSCHHCIHa/nK9Z/Ype4PX00Fs6Wz+
 SfEijcb4gUWP6ZxvBIwkOt5F8Xe8y0mqLLlK2z+1YpGv7GTjmStZSW+P+VDVoZIYvisj
 e5CjtHMQxVOHnOH7wB5HaM5UC1oE1JBU0jCHEaD+Oxb+ReOSRqB4a6f9SslRHWGtKwU8 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dwqb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 23:25:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNAOow068293;
        Mon, 15 Nov 2021 23:25:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3ca3df51t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 23:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6F5tKXT66aoZsaXtviMXgUc/saukYrIEhhr78GjL03YwE85uV9fJ3I7rhT7OdMu1FbHCq4Ztk8qNrnBVCDSRoTX8rnZuveZ0SDv+itncws4cQDSGpQn6d4Y0zH8qUcSYNhux19okzUAxP5GjayvdP7SSXYLHdntBpmwHvaR4PxHpVcdiY1s9B703sIbENHbPyY+K3QDN5nWcEmxmWop7qECat0t5+N8pL472fa91ejiSez9Rr3wlvTq/RfQ6qNpgH2ItNFcHEFtAcj4cj8Ja0rHwwhV1yiD6rHWJBfeDvjKFvr4b0n8JNEgP2QWH5OQWmuPOr3iXnQ17HHajab1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbXhL3PTSczo8azvjqaIVL+YlNhhi5G3lrYX2igzvlg=;
 b=FVvy/wFjmpqLfoHi4gsO/OT8jJ/qss9eLxO/vmvP9Kk6xsC39UObxz2NoQf/Roe/Johpqy/J8YU+LJeWK4A+r2S1tELvS1azSfV2DFbNi+Q5mGw6T36PlTC0IGQdJ2+XEt/kke5hBJHt9DOaDgP9s6cie5hObqm4byjwvU3a3P4JLCCFZVMTfB91VdGP2yzlqpK1hKj8P+SHrvNBmklfE9nHj1ocCqpwO9vW/lyMD5Vmtk6KTvpo8hW2rP/QzB5wEyqOvnlQr+Jav6CXwkQKa8E0TzEoZeVsuPWm4F9on3KIPZngcTWrBuwGBrZ6Y6191xViqLag1SYGYxCBDdW36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbXhL3PTSczo8azvjqaIVL+YlNhhi5G3lrYX2igzvlg=;
 b=Zl53o74GzgfiNNCIj+rAzLva/BZ4uGCckijXEA6rjT0mDzaW/vrIhmMObITx9KjymcOEWq481sXc/z/4k30rnohCTJZPQTSSBPiAMBU06wubFP9fh/PI7CqINQfRHY/znukPtgCgTBJJxvRw5VWTW4LhonohFozgzQPr0P88ZpA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 23:25:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 23:25:25 +0000
Subject: Re: [PATCH] hugetlb: fix hugetlb cgroup refcounting during mremap
To:     Andrew Morton <akpm@linux-foundation.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211113154412.91134-1-minhquangbui99@gmail.com>
 <20211115131633.81e1879e36aed4a0290e6f0c@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a2b26f56-de7a-2192-f6b3-bf80d598f725@oracle.com>
Date:   Mon, 15 Nov 2021 15:25:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211115131633.81e1879e36aed4a0290e6f0c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:301:1::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 23:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8157bd8c-1fd5-4aa5-c087-08d9a88f3414
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-Microsoft-Antispam-PRVS: <BY5PR10MB421190EF7D3B996BDF823135E2989@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XcimTHc3OHM5p4DPAWNhxHBlUuUDgx4jCOYkyayLmxTKvizOZ0Oc99jwfrsKj71gffa/P0HU/MznYoyAlW1p3qtVcF1Y9qD5/yvVu/Yip8kxq8oMBRdchSOqBDgD099m5KWi/R24gpAhhO6psB9wl9ec07aQpXXaPNVj70FLWyNtbYFDn6zRxJTVZldqkI4ln54KgQi5kWfy1LO8DK1oYnwgsbwTQAcvYc9ppkBNxKpksGYVCU8sJmkhzmV+EGy+ekFionOXAzXZ7W/IYLulbypj+hH/oD3r1Nsipg4ZWigEc44J3f8InH+MRFA+5Cu39MW9bEVz0LCzfEb6GQeyqKNRgETTHdtfcJihBqYkfzRcA/MVT8XKn3LLjrHU1cp+EwBRr31VaRa4p2XttcscT4wEoETf7HkHBKNyvfcRhIJg2XTn7RB3dBINli0ja7qolmH1D83VgqTzwNjwtPSbsniy9tuUgUiBPfvbJwYJBFVwoxfZh6eowTbKHOmv9jvApPS+rnu1m9hYFiQ8XL90zQ7MmxfIYwHN3dZpvFv4Othbh5QJyc4aYFfdKC1QkvZh4xLcwsXT5SqE67jX6LS0ydPbFFDG88u5MgkZiPf1dF+0Jai4nsODSpddDWbQn2U6Ctht5bf4KZJX1gFeACaSvDGIfCu2zW4Dg/sgdGwA3xrfNErXGavWSTA2qvTTf2FnyRVdUIXHIQ2mAbxgublTn/VDKOZNa8JDmjVjrgHoBSmXMsxu7s6Tl4ytRtIEmGyNm+9ujepbiYD1T+/18gzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(38350700002)(8936002)(26005)(186003)(66946007)(38100700002)(8676002)(316002)(508600001)(66556008)(66476007)(54906003)(4326008)(5660300002)(6486002)(110136005)(86362001)(31686004)(52116002)(16576012)(53546011)(36756003)(2616005)(2906002)(44832011)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkh2S216cVM1VDI4c25Ha2c5bzJGK3p6ZHkweExnZytlODNOTGp5VTZvcnAr?=
 =?utf-8?B?U0k3UXdQTTM5ZEhwbUtBVnZDZXVwK21rMi9OaHdQL0YvTWFVVGFNZUFlcjAx?=
 =?utf-8?B?cHo3N0RROWFCakVRUFA0QlE0c1Z1TGUwY0pyOURQRTJLUFBKbGEwRmZNd2RS?=
 =?utf-8?B?NFJQYmlFZ3lFa2Y2R1U4Vi9hcSt2cm5oV0Rva0xMb2szaWRtU2pLYkNiSDlC?=
 =?utf-8?B?cU94d0V4NVFWYjNJUGY2YnE4ZVA4OUlmWFZpdnY5bnJsSTBGNXZSakZuTTVs?=
 =?utf-8?B?bmpxTlkvbnpOaGQya05LUUdzQnZKRkJtOEk0UXVxajhUaUVrdlJONFNPeDZR?=
 =?utf-8?B?bHliNGRIQk9IL3NNbHJZTEkyVEI1OTdMdFlqMlBNZ3h1b2FpRktRbjlYZDZB?=
 =?utf-8?B?T05nWUpuVjVqSDJLNDVjVEFzNVFKQi9TcnAzYzJGaWtTM1NLb0lDbmc2clZJ?=
 =?utf-8?B?WWxXaWtuTWFsUWgzbjlicXBXc256Nytsc1dYVHhEcXpjYW9vV21OOVJVOGtS?=
 =?utf-8?B?TDNKdWpqVytNSzI2L1pOcE50ZjhNUkNaZEw4SDJ6NlpPaVVSckk1bGhrbWpE?=
 =?utf-8?B?Q2xueXZlUTBrVERra0FrdGpGNVg5UEdwd1J3d2VUV2kwUjFkZnlPVG9nMFBi?=
 =?utf-8?B?U2tjalV5aEtLTWdxTlpxY0lYRjVuVHdIUmJ2cGZUUlpnN3JiTXlreC9DakJh?=
 =?utf-8?B?M1FESWVZZzJrZmh3OVVxUlVmTm5QTVVYN1l4dXhJdm1KVmlBelo1cjhMZm43?=
 =?utf-8?B?ZEtQYWp0N2I3VU1GMFIweVM1SFEwaWJlWVNYM2tVSENwSDBEWThmWE9iQURl?=
 =?utf-8?B?dUdkb0pRTXkwaHVaWFd3OEVtdjFQNE9kK0JyTWdoRGIxc2ZCZW9aWVNDV2hW?=
 =?utf-8?B?dXg2T3RPL0pXbEx1NklMZEZKOEd6YWFNWThMVVhRUk40R3dhR0pNcjlWSFRi?=
 =?utf-8?B?eWVQZXpqMTdmT3RXR29mRERGL0ZzamMybUNsRVVvOHdySlk4S3hxMzBQM0Jh?=
 =?utf-8?B?ME5mOStIQnpIYkthSGMrbGpjRThxc2hFUzBHdHp2ZFRpN281OW9mS05UOHpu?=
 =?utf-8?B?amhZQ3lOR29yYnVvM0ZGRnVsdXIzM3l0MktVUllkaVUxUnU1ZFhjRVFEZlR1?=
 =?utf-8?B?UG51c1MyRnVkUHpxMTVJaFU0ZE1sWkk3MDV1UFdvb0RBYlJHR0tsT1NQcUJN?=
 =?utf-8?B?U0RFTDVaeTl5WUdqUk1GNzdYY2ZKN1FNbG9hWDNCMnBCdy96djhOSGpia1F6?=
 =?utf-8?B?QWFPNmt3RE9GanNFOUorUWdReXRjaUJyb3hpUFZPSGlsdzdSVk82N0svcU13?=
 =?utf-8?B?V3pHdFpyZExVa2kzSjJLMVVGZmUvMmRISEs2cERrd3ZJSHVzdng2NlEzN3Qr?=
 =?utf-8?B?NzRoNldIcFQ4TUtwWC9JZG9QTjNRL1NnNnVyNENzVlVjOTFmVityT0l5R2s3?=
 =?utf-8?B?L04rOTdVaFJDMTlFNGxsMEp6WWhXT2VQUVJVZk9xdUlKSUVWYXptbGtpWFJa?=
 =?utf-8?B?TDJPSzF5Q1lGVXpROXorUDg5dzVrdktVK2ZUemg4dVRnN1YyekFocmhJeno2?=
 =?utf-8?B?MUZ1RmxlSTBlRTl2MFNTaUJ1TEpTLzBqSStBNGZRU0hjYXF0aXhNQzQ5R3FG?=
 =?utf-8?B?SWZEeFlIZ3RRMTBqeFNtS0dGdVd3K0ZOaW1GMThzWHJPWWxrVlhYdTlaWUQz?=
 =?utf-8?B?QmkrRzQ2L3FaalV1SnlQSm1HZWVPNnpiamlSZW11am1KQ2hnbE43RmxBN2Jv?=
 =?utf-8?B?OXhxT3dGNm81dmVHQlBWMzZnMmRDNmZPS2dBREMyU1Bxc29nQ1d1T05hQVFJ?=
 =?utf-8?B?anVtUGR0c2c1UmRuZXNweXZ2dDVnV0lsYXJSYkFRcWxnYmJYVTEvOHdrUGlS?=
 =?utf-8?B?Q2NpNzMwTE1CUDAwZ1lnUnRrazBxOUtjTG1FWmw3dFB1MWtNMkhtQnlRZlpF?=
 =?utf-8?B?aERONnlTbFBRTkxTeXRnbUVNMDBLZ3hwOElKcEZmcEo4TWc5eit6OHZxeE5X?=
 =?utf-8?B?RVNKZDRBQXUvcStLeS9pV0NGNGpGSGEvL1p0TVYyTmk2UHg1TERJeXV5eXlO?=
 =?utf-8?B?dkZDcEcwcDBRZ1MrUEsxZ2pxZ29DWm9sMXRxajNVTzZOWnd6N2JtRk1GMDF1?=
 =?utf-8?B?OC9sVFVOTGJiajdCQzZka2lRZ1JYM1VGdWNzKzBORUhianZJTURHOEl4U0pz?=
 =?utf-8?Q?Hza6fU7r2FeVoQa4SK9I1ao=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8157bd8c-1fd5-4aa5-c087-08d9a88f3414
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 23:25:25.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdJ+fYfGch4R0m5+xMHlLY48ecr4i0dGgeNJozS6OoyN2RZhHwRriShniZEpzNd8yVrGe1jUP5SgcaWopVsCMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150118
X-Proofpoint-GUID: mLBHlPvy92n3iLTVko0Z5aCJMcYSSGpr
X-Proofpoint-ORIG-GUID: mLBHlPvy92n3iLTVko0Z5aCJMcYSSGpr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:   Re: [PATCH] hugetlb: fix hugetlb cgroup refcounting during mremap

To:        Andrew Morton <akpm@linux-foundation.org>, Bui Quang Minh <minhquangbui99@gmail.com>

Cc:        Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, Muchun Song <songmuchun@bytedance.com>, Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org

Bcc:       

-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-

On 11/15/21 1:16 PM, Andrew Morton wrote:

> On Sat, 13 Nov 2021 22:44:10 +0700 Bui Quang Minh <minhquangbui99@gmail.com> wrote:

> 

>> When hugetlb_vm_op_open() is called during copy_vma(), we may take the

>> reference to resv_map->css. Later, when clearing the reservation pointer

>> of old_vma after transferring it to new_vma, we forget to drop the

>> reference to resv_map->css. This leads to a reference leak of css.

>>

>> Fixes this by adding a check to drop reservation css  reference in

>> clear_vma_resv_huge_pages()



Good catch!  Sorry I missed this in my review.



Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com



> Thanks.  I added cc:stable to this (550a7d60bd5e35a was merged a year

> ago) and I've queued it for 5.16-rc2, pending suitable reviewer feedback.



I may be confused, but 550a7d60bd5e35a was just merged in 5.16-rc1 so

no need for cc:stable.

-- 

Mike Kravetz

