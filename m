Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFC368563
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhDVRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:01:40 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:10593
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236058AbhDVRBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5wIj0Xw+Zdi8oKVM6+c3VN4YuamowWVW2Au4u5T4X/eGsikG9QT/9941JOwZ1OLX+CCZlhngHCyEPHqf2jV2Gni8KndAszIljfuDpNqI7pgZpWUEZV8pO1XPkRl9Swlr6gxAONnLPyl4mhBu3TCBCS3xlZlNPVFUMwC7q3gZEXmG/QhHlJvaWugRvI2qUTtLncSv/jDTNj+TI+Fl3viRzbZ4ByfEYvFfePahve2PHYPgS7wxzRZy/ayn7DQb4DbUu5PCPW/tnaVzRtzcHN3PxCTManEoinePxt3UfU4zHNkRq8vD9LqfkgDfCaDrWhjbfxuK0jvQnQJcBx/kjL+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPgzC99kJ7S6gRCyZaQGLpSR5O+Bim1SK6oxHiyo3DA=;
 b=Hg0+0AVppws/ph+igep+T/mao1Icn4XCCH/cxm4KvNT3gY2k8FGJIoQdtcRXj2NWpimwba1Wq2gyJx6QYci79BCeWFsQsQSC76g2pGGH/KLp1jME2ZP+Gb0IGmPcLclagjLZig9N/bA2Z0OCUG74ISuoHjMAg5Wi13poXh2NE2bg2W/T8u5CZyVP+r0bI4/a/hAlHNktPxv/Ko9fRoSEXan8mDzi9I5H6SPpLn21l0YqNOY2y4YpfWpVlxvTq3DnVQVbXF7LqbYc5PwM/eAKXdU3wuiSWZ5RI9o2cy/n9BuUyBHuRd05out69VK9fUwRgbYT02T5qn2EPPCKAi896g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPgzC99kJ7S6gRCyZaQGLpSR5O+Bim1SK6oxHiyo3DA=;
 b=WvYrPfnvABIg0Z35NEHRwPmPHcUFctHEgJ2ekLRsk2CxBGTdxU5FtKR7W0FOYIoEQRkYD+no0nkN3w1jBw9KJL9I04PsNUwRNOk8QgVSvUaFj/ak5PkhqL2j9T4pyeKQsIzxQydPVY6WGz/1tjmdyF+X+giVwb7B8fvrMUkxuNo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3832.namprd11.prod.outlook.com (2603:10b6:a03:ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 17:01:01 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c7e:f5d1:d21f:ce63]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c7e:f5d1:d21f:ce63%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 17:01:01 +0000
Subject: Re: [IRQ] IRQ affinity not working properly?
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com>
 <87blb3ce29.ffs@nanos.tec.linutronix.de>
 <fdebec53-097a-d28f-96ec-cfe8d7ef8412@redhat.com>
 <87bla6xr59.ffs@nanos.tec.linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <c37ed332-6984-f0dc-35aa-1165a7218aac@windriver.com>
Date:   Thu, 22 Apr 2021 11:00:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <87bla6xr59.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.120.181]
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.7] (70.64.120.181) by SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 17:01:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f826b330-49f2-4868-cfe9-08d905b03545
X-MS-TrafficTypeDiagnostic: BYAPR11MB3832:
X-Microsoft-Antispam-PRVS: <BYAPR11MB383209AADF8941504069E6F6F6469@BYAPR11MB3832.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KhMv4Kgalp0D+nltDtdiaNWeiZKnrlIoUWeE5yLX/BiMV1WiNcJUDngaIeNWdP01j8Ya3q2X/aBQpUco4RGvI4IEWszHUjEb2r2YK1Y8kctgKYmhTqXjPWALyv073AuLJTntgSe8L5XkA3kWlGB9ZemTi2H6NGXfdBR1VAXBVv4iFduVXPqYFFxFHG4wT0seVEW7+SOCVMvQRxoaRANyxh4HGQRExTV34Z1ChBrdZXva/g+J0AcG9I2pUUS2IIxfHH1TIT6JQ8EfqvrgPoCWNbgyKn/85fG+3Y0kG24+Q/bWt9FMzaxsoyRN7zKMnPIt0p0Q/ZqNXRNSbWh+9dTprQhEfQorZZ8j+CXn55w4qgkDAo00sNQzh3RLpsrprS/RlUDiVo1v0SPXQywSGifZteE99Zp2qNeUORTcG+CrtctmkODg8Ovl23lbWpvt5wA7YwiiORiWSRBFSK0ITXMrjcprgcxK8K/Piyjzl+fISEhy8qAJBKF8978BmusvXmTYP0p5+IB6FJ0KQcA92G2KvCnexfHW/6uiSexahuZDwirNKeS2sUksWmNjr5qEm+IFyhGCs4W9rvcz/C5P1YBIEdA/A3kiieQIxlPU63OT70APPmY1geRowELr/WsCNMeuMqHf3mUnMOHhqdLbD1Wjtqo63xVrX22gBi5Ps1Vv7RAM2EYqZ9Iv3S3Ybtqt+/vvWG7HeIiMhRv+Crsxc3b2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(8936002)(4744005)(26005)(52116002)(38350700002)(53546011)(186003)(16526019)(8676002)(5660300002)(31686004)(956004)(38100700002)(31696002)(478600001)(2906002)(110136005)(6486002)(44832011)(2616005)(36756003)(66476007)(66946007)(316002)(16576012)(66556008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnBXTkVvdmtib2dkUlp4QXlVT1lxNnhKcW0vVWNqMFdad2JSanY4OXVGUzBy?=
 =?utf-8?B?OTh0ZFl5ekFDdWR1LytkcG1jWklrcGx5ZHdiUExhcUYwK3kzRklUL2ZnVjNm?=
 =?utf-8?B?RUwrYkNsU1VpeXRaS25vdWl0UjREM2NORGR5N2hZL0V0VWN6Ujc2Rlhvdm1R?=
 =?utf-8?B?VUxmeVo3cXVqcmlqazZRcHBlWFQ1Zm1IdDBpSmpTU3FZb3FQQk1XZkZETlFP?=
 =?utf-8?B?VlN6eHZrWlJrTVBneHgxTkNORlE0OXJlSG9jZG1rK0FLM1Q1dHRnVU83N3N5?=
 =?utf-8?B?NFZPZHJObGtIMWRHS3RjTm5QdFFRdHFITXFrVGRBRkFmNWthNHNRUk16ZU1I?=
 =?utf-8?B?a2RlMWU4a3JORVlTaW40ZkFMZWh4UjVOWWF5SkdMUGNOYVNrNlVMRnJuK3RY?=
 =?utf-8?B?Uk5EK2J3KytRWGxWczYrMnJiRVhOOTAyd1AwdDBvZ2M5MnJ2b2J4b3hmb0dz?=
 =?utf-8?B?K3o1NkVTVXJ0ZDdVSzRmMWtQaytZWEQ3dnJkZkN1Sk9TN0N2dzdGaXp0N0J6?=
 =?utf-8?B?M3VHWmRyMVBVbkpvWkkySURCb2xMelVuRjhWVmxFSnAvc1p3cGtURlR5cFVM?=
 =?utf-8?B?Z25xaGpTMkFFeU0ydlJXbGdqMldOMHRub2JRbHMwR0RxdThCT3ZnOFJoTVRW?=
 =?utf-8?B?MkFsRnFBa3BSdWtubGlkQ3IzcUR2Y3AzTEJGNW1KKzBFcWUxbXlvODVIMGxl?=
 =?utf-8?B?bm5HUUlTazNrNHIreUdTdzFQcUp4WnJFSnYzeDRIeVBIcTNrMGo0eEtvS0xk?=
 =?utf-8?B?UC9Rc1FaVERYUndudFRSSHFhdTlncUtOSHpDVzEycGRRNXFFTXVVdWdpK3RM?=
 =?utf-8?B?TTNYbzVjMmtKRFZJNWtSeGxVNk5vM3JhS2hrT0k2UVhiSUk3Um5JSjgvZWNW?=
 =?utf-8?B?QjQ5YWFDRDNSME5yazY1YVhsODJIdERIN09wSUVyemNXVmc3bnRjMS9YMDhr?=
 =?utf-8?B?WHptMGFKVHJYbXJ1M2toT0MvSFZDY1d1REU0dDRuQ3pjWnIwZDduOXVGZVFS?=
 =?utf-8?B?YmJrK2JXQ2dpbXdwWm5GNytubVROS3dWbkNIWGRKajFPczRFVFhldkJiUWQx?=
 =?utf-8?B?eHJRQUlNOG5lZmFGUXdFdzV5THRBR0JENTMxajhCbkI1WHRDUEYzaHpvZ01a?=
 =?utf-8?B?Uy9BRkZSN0xub0duSGRTZFZqMTJmTXBibXhxUmJkL0hMQkxiZ2Zua0Y0R3Ni?=
 =?utf-8?B?cksvTzhyUHFubGJYZURzcVZJUTBHb3UxUXl3Qy9PQTN3WW9DZDhWZ1FsZFBX?=
 =?utf-8?B?UGlpTExrREhZR2FENFpaSWZQcnRtaWlMMTJUaU1HTlkva1RBZ3ZlUExvQkpS?=
 =?utf-8?B?SW10M2R0bW55d2Z3N2pEYmNZRWxnNHNKVGprUG9QYTBSZ240SjR5cXBwVXVX?=
 =?utf-8?B?ckpTeXQxSk9tWFVSdmtKU3pTaEdWWisvdU94Zng1citReUZoTDRuMzUwTi9X?=
 =?utf-8?B?eDhza1RGWDNRS0l5cmtyN0FDYlRvNUg0YlNneXY0OW9UT1lIcno5eklxU25x?=
 =?utf-8?B?SDdPNnRHeEovSUpwNjkyYk55Nmc5TGZCei83cUxBaytNRUpxK3JPY3J2VFFm?=
 =?utf-8?B?YnpFQ2pXTHh4cG1Mc0hqdWFEVVdtUWViM0N1ZmVmOHBCVEFPWElEOHhRTjUz?=
 =?utf-8?B?QkkvNDlVNXBpM2U5ZGZTcXN1aUFPOEIwODNnUk9hRlo2T3NYWkFLUlVxYmIz?=
 =?utf-8?B?czgyR3pNRW1HTVo5N0YvM09uakxwdjZzc096RjRUbGdLZzhockY0dXlRZ3FS?=
 =?utf-8?Q?6oaNHFRwGbe3iMu+hZWZgwekhkP3kZHDDpnPvJz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f826b330-49f2-4868-cfe9-08d905b03545
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 17:01:01.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lp2R7vFaxflF3288MSOTQL52ZDfk9QWqSOLa9Pu20GUq4TbBFGHuU7lAKuUSsJaH9oH/poWhhvO3uahA5IYbhicC8V54/PtopdXlFXZNbLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2021 9:42 AM, Thomas Gleixner wrote:
> On Wed, Apr 21 2021 at 09:31, Nitesh Narayan Lal wrote:
>> I agree it will be interesting to see with which kernel version Chris is
>> reproducing the issue.
> 
> And the output of
> 
>   /proc/irq/$NUMBER/smp_affinity_list
>   /proc/irq/$NUMBER/effective_affinity_list

I haven't forgotten about this, but I've had other priorities.  Hoping 
to get back to it in May sometime.

Chris
