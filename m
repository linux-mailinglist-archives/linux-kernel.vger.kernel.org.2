Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F7389DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhETGYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:24:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57980 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhETGYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:24:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14K6B7YJ057473;
        Thu, 20 May 2021 06:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QB2g+2DXqhIggilOZgeRLm+pvf1LP0mNVd0V0kmWVCE=;
 b=z/n4kewksj7wZdJgEbnQiPgZq/E5GXfZhwv1nKTjDTaWNIqk+oeNpRLX9Kd86GwAcUMt
 qXbGpU9S3PJaIANQRWM4aUEHH+9fWv9o1u8GykiLOc0xiCCt2lSoDrVsIPeuuO7uWeHX
 9VfIaL8FQCyy02K1kUbq3xR0s/Wb0OtKFyepv76+aC4VWCpxvCVquqXUZWL80vryS4Ey
 V3D/vOb+uy4i0oPM8vKps95YcHbI+Td/ez/+vfBvCmDTfZP7AVvH+2hKbBeFxH/pmlZm
 po6e1kd0qJH8XIjsY2q+FCX3/fqjjCpeSNYmB0Pz+ATmPZvjx+eaP29T6N3z8gWZ7GA4 UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38j3tbkpu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 06:23:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14K6ABmB192901;
        Thu, 20 May 2021 06:23:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 38mecmghdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 06:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzogtufxa74AvXRbaDdPaAAvZlPQyoya0O2mAbl72cEJMMczbY6HSf8MxVSMQpypUukKqTIkWUPXb3W8hts3Nln+FBOm9K6YpHPmX9vF8OHSE9JpiOXAsoyihhmlhznF1x+/C+sZCTOg5QFmSuCEIbw8tE+Nn9lvuWbKnaMnG5f+M2J7wnGfSpqqx+G50SKvkzTqjTLZ/CumNbK/C9rB2TQcqZ2hoDXKvpuJNEqWZtBQf5D/LCX9UTiaZOP06exzETe2Mb53c+xgYTj3912dNApfFqUPTgZTScAwYyIHONKKUvt3Npb3Tb1FaWY8D/LjOfNfScDJ0vLDdnatt9ZNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB2g+2DXqhIggilOZgeRLm+pvf1LP0mNVd0V0kmWVCE=;
 b=PdUJBPAnQ19DHseU07UsymmZfMSXWkQCuv/P2DCBD8fvmPHq7MzMSqKdHunBnimKLnrvhOo7c4KCmct7x5z54L/h28BiNxDeqDdvDwlIOW1lwb8seNQZ3Zj5o1QUArgOtHqAOBUcOqqfcIKmkfUBvnpUKPdqnY1btt5xxN2mTnzywllWWhGtFuuJtZIkwv+8vqZwLrOE0I7oNxIRLZ+h/AdZjWon6mDJx4MhidnPv2ICN3cqU3lXqnXUnDoRaZkiQKsAspT79BYllxkV7SmNDtdulY+SDSu+sF1yygpQt8IvhZ0TX9osGqSYUpaxmQUszwNpddb5uKzYHH20tUhyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB2g+2DXqhIggilOZgeRLm+pvf1LP0mNVd0V0kmWVCE=;
 b=nxRUtkNwaM2I0yZ1TBitJ01tHCoS7fwHLlAPT6mQjUHF9A1o/3wEvcRh28J/5CC4zWllc8Tf78RJgKim1Frhq7LXHBRzpRuWA7HCrKZMbp+oEkKRggoWXGARY/hIoWckDS9A0Jjw5nIgAPUghDHQk5xfqSK34doUo1ugOqJ42HU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2320.namprd10.prod.outlook.com (2603:10b6:301:2e::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Thu, 20 May
 2021 06:23:02 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752%2]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 06:23:02 +0000
Subject: Re: [RFC PATCH] x86/apic: Fix BUG due to multiple allocation of
 legacy vectors.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210519233928.2157496-1-imran.f.khan@oracle.com>
 <YKX6AJZVaqGNn3Yg@kroah.com>
From:   imran.f.khan@oracle.com
Message-ID: <7e1877ce-360a-65d9-8e8e-48795fb47493@oracle.com>
Date:   Thu, 20 May 2021 16:22:52 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <YKX6AJZVaqGNn3Yg@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [1.144.231.137]
X-ClientProxiedBy: SYBPR01CA0047.ausprd01.prod.outlook.com
 (2603:10c6:10:4::35) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.20.10.12] (1.144.231.137) by SYBPR01CA0047.ausprd01.prod.outlook.com (2603:10c6:10:4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 06:23:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873a1e76-8855-425c-1ed0-08d91b57b8c7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23207720803D7F22FA933DC8B02A9@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGFlb4MT+hMfsPIPDLCns1C+ZtNieG+Cr2nsX4/x2ddhsSeMhO1MnnNmMJMeU4WwtdDPIcCqZ4IkW5Vy0U157J6SsvkLuRVpHOlGVO3IN7nQykjBT1JSgQFtjPDy4vnl3YbcdPgN7Jo7UMtCfvBbUAfVHzwahyIBGnj/tJVDsHD/VXjLHlaOlzEKWOnXh0n3CC5azkBzyVW/EvuvP3DrsJKZQt4ZNF6hNCYrdkV6TFu4/m1wsW+55IwM2e2TU3TVq2Gb4GdB43cHICnW0Rb75XnjWH3mKv0HDFtbUJ29j8d1GMkffI8ow6aU68uRA30KkUq9nzKXki+uW6jNPbQU2kUcSURcenBNA1oZhAwzlXlbF+SmNclhKb69uM2BsVUPzPUm4fnz7LpZQJpqHsWl6OxBPULxOGm1vLsN9CJht938mIkT9dMpUGLh211zn84aXJDxa32W481+Vd4ZYXAvWU2EJVQVN9ldjHz5oHRPg8QuAt9W/oBezOWajUXNv23TKPKF+wuUyBDst7oU25ZgTUa4AuxBmi330cdgDyHNPB6dN0cm0rjDiG4/EinkCdR4MW7wQalF+ojRQTMJDxwT7UEzuipFSPS36S++JtY/0HeT1oxqxaaxec6henz6f6dHI2xnpNy7K2lnypY0CtQLVdiAjNYMjn1Qo9/qWqRW4Z14+6qonT2QlFoKbOm/W3PrH9YHfPRYPKRw7RSiGZQAwarGT8r5HXZZ0kuQzyliMuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(376002)(346002)(66946007)(4326008)(66476007)(66556008)(86362001)(16576012)(6486002)(6666004)(9686003)(53546011)(83380400001)(8676002)(478600001)(26005)(5660300002)(31686004)(316002)(2616005)(2906002)(956004)(36756003)(6916009)(186003)(16526019)(966005)(8936002)(38100700002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QTlEVko1Ukw4V2p6SG0ydmlQQ3F6eUQwUWdiUUd6UXYyQlgwVDZBV0dhN0tV?=
 =?utf-8?B?ZDlGODZtZHF6bE9RZjJwYWt3elJPWmlMdXRIUGtqWEFhSEQ1cS8wRzZyTlN5?=
 =?utf-8?B?Z2Vpb3hYbWdsc1BNNGt4SWxabVBUdk9NYlYyVFptNGN5bHFJVWxaZzR1Qytq?=
 =?utf-8?B?S2w4Z1hjeitML3JjRlhxYUEyWFdjb20wU2w3YUxCenEzb2p3cEZ1b0grcm5o?=
 =?utf-8?B?UEwxSUZRWURySC9FVHBVSGRsOXp0c2phVExGNEx3c0xNWGt4NmJhYnhrbVdR?=
 =?utf-8?B?bG5ScVFJZm5lY0lWVGFOYmU2SFgwc3VISDAzdjIvZzBydlUwempKSHNMS2Fy?=
 =?utf-8?B?dERja3k4MzVoa0JkRGF2QWt1Q1E2TFoyYVUvU2JOQmJYbThBVVM2K3I5bmdn?=
 =?utf-8?B?VmtCeWx6RmRHUnhoUXpocmdpb1ZHZW1lSTJyeEZGalB2ZUxLdCtENSszcU9x?=
 =?utf-8?B?K2RMYnVBSUwrK3hhM01DTGhVTnNHUkF4RVpGRExoNEl6bFloTDBvSFhLOURW?=
 =?utf-8?B?VHNhMVJVNTI0MmlPYmhXWVNDWE1NWnkwTGR5WGhlMnYycjZlMmJDTXIyaFI3?=
 =?utf-8?B?cWFOSjdBbWlJMXJEMGljRnEyNnh0RGh1ejJhRCsyZUZxSWhTNnhTeXNodDVR?=
 =?utf-8?B?OGxjb3lheHY2T0tyS09vN1NUUTRJRFg2b1pLME9NWWVrQk5hMThJMWRHZzNo?=
 =?utf-8?B?dkFRQWUvYm9hYzdIejZ2a2VVQkE2N1BwdkYrL0hpWVVRU1AwSld5RTd5cnlR?=
 =?utf-8?B?RzBXUmZoSFI1TVpiQjFSbTcxZUsxUldxVHFZVnhHM2pCTjhZa0NYM25tSm5C?=
 =?utf-8?B?QStDcmViVGM0ZWRDYjVPNnlUQk1QeXB6SGd1S1FCMGZmd3p2aWdXTlNnZGVy?=
 =?utf-8?B?TURyQUpPQ0Y1dzd3SlVTZ2xIRlRYcktoNE9VRzVkT0dBdk5vdzBzMHVSd1BL?=
 =?utf-8?B?ZEVGQXBiaEk2RlVDTmdsQzRrYnZTREZZa2NWZHVMbEEweERFVmdrbWJmbGJN?=
 =?utf-8?B?NWhyWVZSNnF3WE8rRU9POWdJc1p5dW1iTTFpL0Z5UEJMTWtqeFZ4OHNWeXQx?=
 =?utf-8?B?OEM4aDkyVzc0UDMyNjEyNXJIanpnR0ZDY3U5cnY0ajd5WGJwcmhab2NCNHNZ?=
 =?utf-8?B?dmFwU2RqemYxdXg3TnVCU01CRW9qa0FrVDQ5NWV4cEFPbVZ3WVcvYXlNNm9w?=
 =?utf-8?B?ZlQ4UGZVS2JpT0RqWTQxbGJHTWxXU0FRdTE5UHYxcnRRTUlRYkdmekFZRURz?=
 =?utf-8?B?VnRCZ21PT25XVFEvZmU3djZlQi9rL3gzSHBzbk1JeHNseVB2L3cxZ3hidEky?=
 =?utf-8?B?TXc5a3l2V2RBM1lwRFE5NmRreThlM3ZtazUvcnhXeFQ1TXFVNDczQWpsYm1j?=
 =?utf-8?B?MEZZZTFJano2aUtrVUJ3eXJOVzcrTWtuN2dJc2FzY3doUVFPU3N5QmNqVW9V?=
 =?utf-8?B?SHJCSm9QZVNqejUxcXVoL1dUcVRYM2pBVVI0TllQbWdyWUpVbDc2U3Z0RkFj?=
 =?utf-8?B?RDdUR1RaTndMQzVKSXRCTUhiVG9KR2tSc1plRnlZYml3V2tzczN5YXJvc1d1?=
 =?utf-8?B?c1Q0S3lRdmdBdDlkNUpMNHkvanRScjVMeTJkakVrQzRLS0ozckJranBHNURH?=
 =?utf-8?B?QnNLNGNyVEFwZkR4T2h5U1M4MXZWY3hQY3hiRmk4anJLSHY3R1J5eExsbUMw?=
 =?utf-8?B?RWxxRktSem1zdTVWd2Z6WW9RRjhGREdoQU41OGZCVnVmODZlRkFuRXRPL3dD?=
 =?utf-8?Q?ZPnFnc4f3y1DIIdjbmyc4WM+KKsrwtMfwSdABXC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873a1e76-8855-425c-1ed0-08d91b57b8c7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 06:23:02.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvA9BG+P3DOV3YZBHsu0bsm+uVgj2RHin1X/Qrf4uSoBFCw1hRwj54jjBA6gqPDRa8HJwwA6mA+XPlosN6bYJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=828
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200051
X-Proofpoint-ORIG-GUID: eBSUBmGJmT8kosE5AVXxbEPvI2wQ5J_u
X-Proofpoint-GUID: eBSUBmGJmT8kosE5AVXxbEPvI2wQ5J_u
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=933 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/5/21 3:56 pm, Greg KH wrote:
> On Wed, May 19, 2021 at 11:39:28PM +0000, Imran Khan wrote:
>> During activation of secondary CPUs, lapic_online is
>> invoked to initialize vectors. While lapic_online
>> installs legacy vectors on all CPUs, it does not set
>> the corresponding bits in per CPU bitmap maintained
>> under irq_matrix.
>> This may result in these legacy vectors getting allocated
>> by irq_matrix_alloc and if that happens subsequent invocation
>> of apic_update_vector will cause BUG like the one shown below:
>>
>> [  154.738226] kernel BUG at arch/x86/kernel/apic/vector.c:172!
>> [  154.805956] invalid opcode: 0000 [#1] SMP PTI
>> [  154.858092] CPU: 22 PID: 3569 Comm: ifup-eth Not tainted 5.8.0-20200716.x86_64 #1
>> [  154.954939] Hardware name: Oracle Corporation ORACLE SERVER X6-2/ASM,MOTHERBOARD,1U
>> [  155.073636] RIP: 0010:apic_update_vector+0xa7/0x190
>> [  155.131996] Code: 01 00 4a 8b 14 ed 80 69 01 a6 48 89 c8 4a 8d 04 e0 48 8b 04 10 48
>> 85 c0 0f 84 d2 00 00 00 48 3d 00 f0 ff ff 0f 87 c6 00 00 00 <0f> 0b 41 8b 46 10 48 0f
[.....]
>> [  156.268168] Call Trace:
>> [  156.297409]  ? irq_matrix_alloc+0x8a/0x150
>> [  156.346408]  assign_vector_locked+0xd2/0x170
>> [  156.397489]  x86_vector_activate+0x1b5/0x320
>> [  156.448570]  __irq_domain_activate_irq+0x64/0xa0
>> [  156.503808]  __irq_domain_activate_irq+0x38/0xa0
>> [  156.559050]  irq_domain_activate_irq+0x2b/0x40
>> [  156.612213]  irq_activate+0x25/0x30
>> [  156.653930]  __setup_irq+0x58f/0x7b0
>> [  156.696690]  request_threaded_irq+0xf8/0x1b0
>> [  156.747784]  ixgbe_open+0x3af/0x600 [ixgbe]
>> [  156.797827]  __dev_open+0xd8/0x160
>> [  156.838503]  dev_open+0x48/0x90
>> [  156.876065]  bond_enslave+0x2b6/0x12c0 [bonding]
>> [  156.931310]  ? vsscanf+0x5af/0x8e0
>> [  156.971986]  ? sscanf+0x4e/0x70
>> [  157.009546]  bond_option_slaves_set+0x112/0x1c0 [bonding]
>> [  157.074148]  __bond_opt_set+0xdc/0x320 [bonding]
>> [  157.129389]  __bond_opt_set_notify+0x2c/0x90 [bonding]
>> [  157.190871]  bond_opt_tryset_rtnl+0x56/0xa0 [bonding]
>> [  157.251315]  bonding_sysfs_store_option+0x52/0x90 [bonding]
>>
>> This patch marks these legacy vectors as assigned in irq_matrix
>> so that corresponding bits in percpu bitmaps get set and these
>> legacy vectors don't get reallocted.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>>   arch/x86/kernel/apic/vector.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html__;!!GqivPVa7Brio!MYRIHQM1qBB0Raf823KeG1-OSUDCwlOyOxqTp5fzHTlxAL1H4LZW6XniBtajqKVb3w$
> for how to do this properly.
> 
> </formletter>
> 

Thanks for clarifying the process and providing the relevant doc. Looks 
like CC-ing stable list for RFC patch was a mistake in first place. I 
will wait for review comments and, if the patch gets included, will 
inform via option 2 of the above mentioned document.

Thanks,
Imran
