Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33550308D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhA2TTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:19:03 -0500
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:23905
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232644AbhA2TS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:18:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRHoMXQjAFaUMrmz7JGPsF3+82sbd0rSBWi8NZ3Na469riKdwxdECPz9uHNToipMU1tstsOK5iXaUuI/WgdZxfmy6gKgzjat3f3Aw9IlS2UrkCBfmLm9v+i9hOJevpLmhePnGEDc33vq8AVvzFgXpGeex1a08ScIv+j16AWqyjUI7zaf+4pxP+Cx11aIRbg8TxPSAnq4zl9ryeqEZjneBcKVJ3AhO77plK0Bdrufg8obA95CJ8PxqtHR9G+wLfxwXis1vJJ/J2lW5+UdPFRf2vWwJ0ykIyEwF8qh52i9uEbWLJLxiDHARlVPH/i8gTLtap46NfDrk6XD5czyOXX2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGlK8X9dOHt/jlFkM390OqiiGuj2IIUku/03ue8TxfI=;
 b=eHeTXzXuiUUby6e7o4xV+ZKcK4jM8qwG5wlVNDr8ja4w/mZc2eDoz1rKwNMADw7sm7vaBXTbbY/Cpf+qI2GRIqPIF/d5XHjyxlXfYQm7MnELj2xmFCMd9ZBlScIxBbH0I78ibycHPeGevsqnLQQCBQ6t6iGcGkOUp4NJ7tX3pvMj/kQoAICm4wxdzST7hYbb+8qQiQ434FjcjAgyesNsnkqGpnXFuKbYK/28dSwfKO2BnIZrZKiVTrOc5mHFtrGnLmpGMVpiY5dKQvwDiFaLpUBrRY89obGxeMMw1jATXi3ZsE7gBhWSQPtQA5gD5sF4BLdEOrY0C1ngxTLmS/n+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGlK8X9dOHt/jlFkM390OqiiGuj2IIUku/03ue8TxfI=;
 b=TDxTNMT0Abqt4XWxDGKdmSjyUskKdIly4BUxYIc/UI/eJ2DMjRhLGnuojc5WdwL3MkyuN2iFxuqo4kWRerzZkOEC203f/MKuk+NNkZyFZutSdH0tCCFn37C69xhfgbotsJwO+dD714wgrVszNCu4y0QcOIbUi3VcrqQSTqAk9Ec=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9)
 by SN6PR11MB3200.namprd11.prod.outlook.com (2603:10b6:805:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Fri, 29 Jan
 2021 19:17:22 +0000
Received: from SA2PR11MB5116.namprd11.prod.outlook.com
 ([fe80::407a:951f:97c:f70e]) by SA2PR11MB5116.namprd11.prod.outlook.com
 ([fe80::407a:951f:97c:f70e%6]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 19:17:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: [IRQ] IRQ affinity not working properly?
Message-ID: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com>
Date:   Fri, 29 Jan 2021 13:17:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.74.82]
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To SA2PR11MB5116.namprd11.prod.outlook.com
 (2603:10b6:806:fa::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.74.82) by SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Fri, 29 Jan 2021 19:17:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1367422f-b902-4b2f-545e-08d8c48a80b7
X-MS-TrafficTypeDiagnostic: SN6PR11MB3200:
X-Microsoft-Antispam-PRVS: <SN6PR11MB32005A7CA9889FCC5794EC49F6B99@SN6PR11MB3200.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9fszRi8ypOBLdL2pmWiQOpshBlGjtVQ/LRkvyunsE/9kxZYHAR6Kbcc7n1cXRxWl7iXHqfr6wYIxAt9XNBCsGrDVNVsaDYJIRoj3wS/EBsU8yqNlQqyf42ehXUmbTw6IOT8FInQgXNbonDGqLnu9CVquhmIWqrCSSpB1iScZqk1HFgVmOwAxSHOMX83qzKYKaZpDKM5VD9YtjPid1ki71PMeTdpWrrf0ToPkXSHP2nnlmPiNwUGgVvQZA3NrW4UJYuvD2E2gDLyDvT50wkAqlxQ5PJiv+7iK4PnGXwFKfpAyYCyeP4a9Epvre91LW+qcN2sT1KAQDUwPjFVCjBoDZclMmmQBLQ6qMGZtXI3S5RHWxY7JntQmj0FZwwELkYaLgYt+QjjGnTrn+NtoCBuxT/o9Ef6QcDuwjbDGt9Zuzl8NU+2k1ulM6cCbLKKIud8x2HvFojDNyrdbCbQrl4/EdTRSeoQf6pKgU5KMyLQBhkbkXM8u1sYpyoN8bNGfGii7uFs5DUy9QtSs3OgbvlF4K1o+7GJlW1a7V9xva1WlkzTzBJq0u9M3U2GFLKqgKmnqxJdzLXZ2cKeRb+DbnJN/Rs2cb7soB4I3VnUzJqIe9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5116.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39850400004)(346002)(316002)(2906002)(66476007)(8676002)(31686004)(52116002)(36756003)(5660300002)(86362001)(16526019)(186003)(26005)(956004)(44832011)(66556008)(6486002)(31696002)(8936002)(2616005)(110136005)(478600001)(16576012)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3NCTkZYek04aVQwY0huS2JkVVNpd0RZTlF6cVlscUgvSGcyWnFaTmh0Zytn?=
 =?utf-8?B?THU2RzdFWTZ1cHdZUkdqeHdXL056bHpZaFpoaUZSRk5xdzFPUkt6VHJhem5P?=
 =?utf-8?B?czlHT1JUaWt4SmcvYlBlaFlMWnQ0S2xTTnFhcWdSa0d0Y3pPcGYxTWdlYTNj?=
 =?utf-8?B?THQ3WkpMemVFVXd5WW1ma0VnNjRYWmdMTlBudURVWExNUzZwYXJkS2pySTI5?=
 =?utf-8?B?R3VXZ3FBMFdPRnRKWFN1a3ZyR3pZSlVJTkRnRnlSZXErWW1ocFdMTWFkVnk0?=
 =?utf-8?B?bFJmT0E5cUhZU3ZhVDIxS2JaRkNXZS84N3lqOU9LTHd4a2JLOTBYNFQ0M0tW?=
 =?utf-8?B?Smg2a08zYkYzWE9pc1VrU0VYMnZoY2tDQjNGOThuY29GaVJ6eWJubndxVDU0?=
 =?utf-8?B?cWY3K2RMN3FmSzNKUkFVTCtMOW95SmxJc1RqM2ZlcGkrTVJsWWpMNVJUWU9O?=
 =?utf-8?B?ZnFZQ2dPT2M2TEtlcSsrTlJLZTlGLy9ERk1wb3RmTjlwRXU1QlhqNFVaLzFZ?=
 =?utf-8?B?NGxZTGZrakp2R0J6MENOd1loK0Q4dTk3L2VOK0pjU01hUmljY2JHNXRBVVBk?=
 =?utf-8?B?a1FRNjJId3Bwd1V4ZDhDRytJV0E2dFdNWmZXd0dYdFNpSlUvOHozYUtFWHdP?=
 =?utf-8?B?NTlPNmtJeFczRVF0NDJDQTVPYTFyLzFST2E0dWJ2V2VxbzZyWG94U2ZxSnJI?=
 =?utf-8?B?V0J1UmUxN2RaNWtrelplcXIrRkdRTE1QdXBvYld5ajdYWlhXYWIzUjZSMzJR?=
 =?utf-8?B?UWcwazg2eEQyTy9iMDRLTEdUdmRTb01pWjh6cVo4MktOclh4K2FpaWZMakhJ?=
 =?utf-8?B?Mm1tc3JpdFE2c0FhQkYwakJzV28wYlJoTDNNVEF3REp2cTlqZEJJcWxZRDhP?=
 =?utf-8?B?V0FsTExFL0ltM2hZVWdrZ3V5WUExOC9CYm83ckZpSGIzaW5KV1FHbGFIZExT?=
 =?utf-8?B?cmpmc3p6MENkbGhDUXNCUHdNdlZwRVZ2WCtGRUxIT3dCK05ROGkycHpkTGFY?=
 =?utf-8?B?bW5rbDlYcjlhMC9DbkZZYkFtNCs0UVpqYjk1RDBWZUlBZ01xSEZBMitKOWxs?=
 =?utf-8?B?czlrWXdEMnJNQmxyVnh5NHllckZvUnU0cUt6ejN2Rk83RnlkVXVvTWtSa2ZN?=
 =?utf-8?B?aFJrVURmRXVweDMzZTQrSFZHWGpuVEt4bUpmZ1VpY043dXY4bzh6YndEK1FO?=
 =?utf-8?B?VCt3WWFIR09jZ0ZGSUJLR2doMHlPc0RCUXBwdUpnaXFpM2tpdjZtT2hhaG9l?=
 =?utf-8?B?akl2NVNVSVpZVFZlbzNGVDRpR1p6eVRGcnM3WG1rNU9PS0cwVkkxQ0lobnFD?=
 =?utf-8?B?THp2R2VucS93NXR1cXUvaUU2SlRsU0JGVXBuMUhybVJhdDJTTmdidFU1cXF2?=
 =?utf-8?B?OGtoR1JoWmlPR2JCc3RaMlNmdU52UmRzM2VqejRIeHVGaDNiK2I0RlBFc1Nx?=
 =?utf-8?Q?Zs5uWAy9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367422f-b902-4b2f-545e-08d8c48a80b7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:17:21.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izKrwJGHKHkrQvQShfyRMGz8YmHnuA6p2bA+++ljWzXOJgIUXiGcf2RfIz+/xzzpjlbQsg6VUdfUl6ylwcdJzKO3TctxaB/EbtPjYF5bPsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not subscribed to the list, please cc me on replies.

I have a CentOS 7 linux system with 48 logical CPUs and a number of 
Intel NICs running the i40e driver.  It was booted with 
irqaffinity=0-1,24-25 in the kernel boot args, resulting in 
/proc/irq/default_smp_affinity showing "0000,03000003".   CPUs 2-11 are 
set as "isolated" in the kernel boot args.  The irqbalance daemon is not 
running.

The problem I'm seeing is that /proc/interrupts shows iavf interrupts 
(associated with physical devices running the i40e driver) on other CPUs 
than the expected affinity.  For example, here are some iavf interrupts 
on CPU 4 where I would not expect to see any interrupts given that "cat 
/proc/irq/<NUM>/smp_affinity_list" reports "0-1,24-25" for all these 
interrupts.  (Sorry for the line wrapping.)

cat /proc/interrupts | grep -e CPU -e 941: -e 942: -e 943: -e 944: -e 
945: -e 961: -e 962: -e 963: -e 964: -e 965:

              CPU0       CPU1       CPU2       CPU3 CPU4       CPU5
941:          0          0          0          0 28490          0 
IR-PCI-MSI-edge iavf-0000:b5:03.6:mbx
942:          0          0          0          0 333832         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-0
943:          0          0          0          0 300842         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-1
944:          0          0          0          0 333845         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-2
945:          0          0          0          0 333822         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-3
961:          0          0          0          0 28492         0 
IR-PCI-MSI-edge iavf-0000:b5:02.7:mbx
962:          0          0          0          0 435608         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-0
963:          0          0          0          0 394832         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-1
964:          0          0          0          0 398414         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-2
965:          0          0          0          0 192847         0 
IR-PCI-MSI-edge      iavf-net1-TxRx-3

There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
roughly 1 per second without any traffic, while the interrupt rate on 
the "iavf-net1-TxRx-<X>" seemed to be related to traffic.

Is this expected?  It seems like the IRQ subsystem is not respecting the 
configured SMP affinity for the interrupt in question.  I've also seen 
the same behaviour with igb interrupts.

Anyone have any ideas?

Thanks,

Chris
