Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632313C9C73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhGOKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:14:07 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11636 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241247AbhGOKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:14:06 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FA4OJ5030230;
        Thu, 15 Jul 2021 03:10:58 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 39sux8ryc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 03:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoMzDnIIeLpc1rf/CtWiTHDA7SLFuHW5v/l2bKqEL1uzawkuvw81Lrp3zv6WiEbiPIB797m4Owo4xghy8OHHbKvLrD0np89AWm7tkAnlBKBFkHLQ0z6at157nsexREdXGpd2Mw9AN3R/ehXjVsbepOHlo5/qewOmrWXEFfWgnUTzhtuGHfWqZptcAnHxTaPcIHTqpfn/WhSn2sXK2J0lxlDEZ0l/lYs2E90doimd4fdZFVdznvm1FccQhP16Q3t5uREshwYu3C0+ifzX79+Uaz67K6YAXqGc7NehcZXXDQoZpvNDQrIGz7/w7csQKBQXGV1hMK8aqSx14dpMrk6fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgCIKIgkPe2IUqRPhUxOikUEi7nYz//P+9wnRBm5hqc=;
 b=kju9h1Do0rg3Oojt73tbN/oFDoaq9pZT/mcSXPDGjnFFP0jlezOAD8lOmi5ijZ/GnqAMqshNJ87QGxkz4b0NfbgQ7zf8SscdyTyD8BFDVTtlXOIAU+Xtp/f4USpvi0GdMMrL+E1Eb+JMyhdSBGC5zwAUQGyQZlcXD7WsyP1P57xtJVfz45HrB0tWyl9FPQEcBwfCIK0ilhxNVw5ANZqED5yY0tvsqwkjHeUIjXmxHZsTKB+yML6w6iTxf7RZSyqp+8eKt5EorIzoHESk24tvxEgmqYwvp7HGQP5t/10QB0rGJ3Z8aGGQ7Qw9f3sQRP0dG+POi3L6cvSnTBK4zoe+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgCIKIgkPe2IUqRPhUxOikUEi7nYz//P+9wnRBm5hqc=;
 b=ecMwtEDLmP6YHCwKA0WOSqE3SF+9EiBqqs4MAW8nvESys/Zt5BK+j+XG1H0Xhs1YageE5x6guTlmz7255dNrxuYIas3kyBd6BToLO3XAEyvixI+APNVpmrUzpaJVgSdsTem1xWbY3x0p1fkh985YUcPNq5Z74xLlXWIzMEh5/KE=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.24; Thu, 15 Jul 2021 10:10:55 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f%9]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 10:10:54 +0000
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
 <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
 <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <e20c3d90-db24-7722-3f89-adadb83a9bf7@windriver.com>
Date:   Thu, 15 Jul 2021 18:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b73f8986-9071-6fbb-5c6a-d7892ba2302b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by BYAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:a02:a8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 10:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bad3d4f-76ae-4af6-244b-08d94778d4e6
X-MS-TrafficTypeDiagnostic: DM8PR11MB5574:
X-Microsoft-Antispam-PRVS: <DM8PR11MB557472397D6A63B3A2F7BA4A8F129@DM8PR11MB5574.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LagGn28GpOKTm4UtAQSFvIkYD+t1L01mYQsqJDdCWg60AITC0vlsyAGbr0y2ZLP9GBHxznPRmIstB18nCkf5P68+qXHl9ZzHJeOcb7NpwtxLbagTX8+FbnV50MNn2be1ml/Atly43MdkuZkFJFpZkWvEpCCQ0/7Mh0s8xYKKfU2VFj5NmX/XLdphjD3xPF4PVWNq4TmNxpdGCmyNBgBqdcy7ii/pvy82GEbnodojc8WgNtBEYzYW+ODCE0q2vPjj0M6YKrXHGileQqb0mN//P23YSD8QXu+ZG0E9vHf0U4/Vfz9eTLvhzWcg8OeqALPyy/qjwiaDHAoVSGb4sdaRv/ur96+5a87WeCslMaCZgUxthmbMyxZjnKtvxE4kBbxMZdRmkYfJS50nVFnnrEaTnqcoBKpFwf7qOH7q2WgXglI5qrdm4uu0d7jLdHN3/wUeHQVktB0849bPQDSeDVi2WCJ1Y0ZW6PErsxE3jw64KUv5b37SO7WeE1CNLhqxagFAeULNikkkByOt1wak3tUlnsfOBXIQtMfmcKV6XM4lTaTHsz2Xpe8bu678Vl7cS2+HXVjNq0DL7zKXHo8hJnJJD4NEi43v3MFWSIfGLyFr27PsgVvymq/lmtgO179M4XIbR4V+MhjpnS0jEWVkd/EzlPUvnOnC6FpT8UzQF85cFknftXTs5LhUfseR8G+PJI6iN7iYvYt1IWmAL2H1/VwpvkzHOloX+ixgJOhnAYJNDv8QQSwGeFO22ZdekyaSxJeOXW8cHhSgtG7zq+ZUlInvBHQEThNB3HrlH7fYfhb692ZvwHS8hntWgnII5aBWkF8qHeeIt6GZLJvAeL7Qc4197ov8tB0Jrte1JBc7ZnUYJDLRP1pzAOKO/IRhSDi1TDggwqyMqG0Dtnqw/oZPzcdno7tJb/K53/XG7P2wP5bZkUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39850400004)(136003)(366004)(86362001)(6486002)(53546011)(38100700002)(38350700002)(2906002)(26005)(966005)(478600001)(36756003)(186003)(31686004)(5660300002)(83380400001)(8676002)(52116002)(54906003)(6706004)(110136005)(16576012)(2616005)(956004)(316002)(6666004)(66946007)(31696002)(66556008)(66476007)(8936002)(4326008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEwvR2xqQ2tMdHdSN05KUnZ2d25GWGVPUlZWQlA5SkloYXZFRUx4TlQ0Z01B?=
 =?utf-8?B?V3RtcW01REl4TjlHRUxmSmpGZ3g5VUJsVGVyNTc5alFLRUhMakdMUUhMNUZs?=
 =?utf-8?B?bEhpK2xTa2I0akJKbGtEdjZzWWJDdXErVTF0ZFNwdmdoRmUzdklWbHdtMm9i?=
 =?utf-8?B?dkdscHB1a3pGVzh0ZWFaeTQ4Y2lPREIrVnkxQ04rRks0Ym1iYXZhb3JTbUEz?=
 =?utf-8?B?WkJ2RTVqZkcwZ0F2V08vNjdNWVZQTGtvaFZ6dGZEN0NsOGptSEVtMUM1R0tR?=
 =?utf-8?B?Y3l0eGlHeEdxQlJ2UFZMTTFHVktRNmVPQ3FFZ0kvQnNZV3JmeXc3Yk5PRmFR?=
 =?utf-8?B?TWN4M01ESUZwY2ZySmtVYUlSdmJjS0FzZVdEVkNyeDJvT0hIRkUxSmtjc29P?=
 =?utf-8?B?NlJIMjZ5akNMWnI5QkdLeEJYa253dkpPMXpCVHZkQTF6RTJ2d1lBbFQ0RVdB?=
 =?utf-8?B?WWNuTEZNdGh6OFhrN1JnWlpiaUJrS0Z4a0t4MlNiSHNLZFFyeHJNc2huQ0Ri?=
 =?utf-8?B?L2x5T01xSkNEZGZWVVplc2xodGxaRU1qZGNHUCszRXpJdkUrbnk2RGgwbGJj?=
 =?utf-8?B?dk4yaDAxZ0ZIOUJTWE56dnNoM1lENlBhejRqbkJRN2pJWWlQRTB2cXNhVkdm?=
 =?utf-8?B?UVYzMFRjdktCdnZBNmJSU2J4TDNrbWFuYkxaR0JWbzNjRTJ3eTV1YmpCZDk3?=
 =?utf-8?B?ZXhZK0N5RG8yTjNZY3VlWnB1WVdrNHN3akN5UjdyKzdwU2tYYmk1TVltSG1l?=
 =?utf-8?B?UklnWStReXdzc1NITGhsZitxbTdKRys0ZE4xeittOGVxUWc5bnFBRzRDZDVh?=
 =?utf-8?B?bkFwR0JTS2ptVnAyRHhNRzNvcklFa3d2bjhEYlB5SndIQldNRzIrWGlUcTkz?=
 =?utf-8?B?UE1tQXZacXJVY1VkbWtnUXpORHNQcExZbmRHRUVNRlZSS1dRYkhRbmxENFVw?=
 =?utf-8?B?V084RG56bmlCT1ErTmRtYzNsVGtJdFZHWG9JMGpIb3FlRnJmUkZqejhXOXo0?=
 =?utf-8?B?UVMvU01LMWN2U3RtZG5qSHVKY2xwOXZVWmlQeklvSHRyV2F3Z1JrMFJPWkM1?=
 =?utf-8?B?a0RVV3pndit0S054N0FtWXpYaGtWczNBcEJOdlpuaWhmV1E1WnRkblZNenJM?=
 =?utf-8?B?bmRhTis1TENCeG84RFZNcUViS09XeU1kVHVaZVp6YmhxN2JLcjNpWTJ2SlV6?=
 =?utf-8?B?Y2N1YUhDaGc5UlpoblBOcUFwZjJKOC9WZ2EybHZBU0h3VnRoMy9LSllTOVJo?=
 =?utf-8?B?VjVvZXRIeUVTQ0d5VGdwV1crS1g2VTNLY2VDQTBhSFZWVU1wVXl2Qzh0UVBH?=
 =?utf-8?B?Z1hhek8xTEU2NDhpR1Q1TlQ0ajZRSVhZc1B1aXUvREIyejBGNlphbEUyaDBp?=
 =?utf-8?B?ZGIrYUJraDhxMDF2NFVEOC9YN3hGM3BXclZ0c2NLVUxTSXBqZk1zcmFhbnQw?=
 =?utf-8?B?endOMjFSV1JlT3hkVWwyNHozYm9kMER1VFhqM2JxSjRIZVVyS0t6VU80U3dF?=
 =?utf-8?B?VkMyZGdqMElnQmJ3S3o4NEp4TFM4QkNHUWtOY0t1Vmh4NitzVnZCN3JnYzdR?=
 =?utf-8?B?L1RrNlhRWk1ZaTRJMG9zaWtkQ2N5aGJNSitHTWVvazZSRzhlRXJDSnlwN1dk?=
 =?utf-8?B?VWV0SUw4R0piaVVzSXdwRlhjckdpZ2lsaW5pczZtQmRsem5IRVNUNGN3Z3Nz?=
 =?utf-8?B?MUlpRE1CRkNWNm40QUxPUU5vdzVWS24xWVd3TXN0L010KzlPZlRPTlBzaVRh?=
 =?utf-8?Q?84Gj4lEBwvtwd3PB3Xxj5KfFIw2EsRI/KKG/g8E?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bad3d4f-76ae-4af6-244b-08d94778d4e6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 10:10:54.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gs5RMeV6lkblgttirzYUujWkGGO76srGZ7akn9CxCxOjytgjqOlxFkhO93Qr07pd9l0TnC6FNoreCsHx5bG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-Proofpoint-GUID: -MOAAw_IAn6WCNp0HYwEvX78ezBoB3IO
X-Proofpoint-ORIG-GUID: -MOAAw_IAn6WCNp0HYwEvX78ezBoB3IO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 5:51 PM, Paolo Bonzini wrote:
> On 15/07/21 10:44, He Zhe wrote:
>> It was to increase the recursion depth to 2 so that vhost_worker and
>> kvm_vcpu_ioctl syscall could work in parallel
>
> The count is per-CPU, so parallel operations cannot cause it to become 2.  Your patch might fix calls from ioeventfd to vhost_worker to another eventfd, but not *parallel* operation of KVM and vhost (except on PREEMPT_RT).
>
> You should identify the exact callstack that caused the warning for vDUSE, and document that one in the commit message, so that reviewers can understand the issue.

The following was provided in this thread. The commit log contains the call traces that I met and fixed back to Apr. 2020.

https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/

And the problem has been reported many times until last month. So when this patch was pointed at in this thread, I thought it was still the same case.
https://lore.kernel.org/lkml/beac2025-2e11-8ed0-61e2-9f6e633482e8@redhat.com/
https://lore.kernel.org/lkml/20210703043039-mutt-send-email-mst@kernel.org/

Zhe


>
> Paolo
>

