Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36339479A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhE1UBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:01:13 -0400
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:18060
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229493AbhE1UBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O96kDzchqCz67lgmWEH/iYuDfDcyzJLT5Rfe89+GjpWrkeuiMAYBNO3hN5RtvStKPoUBsEoMqKR6UnYkdh0inK18VfhddkpSRro7Dfy+oa8IxJQyvFFjQQrqdC3f/GCd2gNvuEt32WVzv2a3FGByr5iB0FojayixZXY5MJP8yJt7BOJz/rRPd0jkfPt8LXksl7GwbhI280Bb0HQ89oIgLjbIP4jByxaj9RnPHyu0QXc0FmDiJWyPuPWXLblydV2k+2t3B+/BpocZCY0d4iT4p3n5y1gXMOwArmwpjE/SScABA/DMroTZ7tWNqRDXOrhspkujdwTANy8oXwlfmduynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPLMlOmPyfsQ//zoPoxR0s0Kw7wORrTkkAap7UtasUY=;
 b=fBmZ5lHwsY5NJOVGcZ06CM9madrX4bgMvODCfRhVSYcJV/5BN9giF0B3KN5shu7HmO/rtdg3cvbgv5AcxDewm1F8bI1YqBt6p0bw96Q/WQbjoXLaKx8Rrm0d1EfHcjbkv+tdj1JebiZpumbarNDUbexx/1PH2VhNwuRMDO7gdwQT8po/kvjFK4d/pdbjPzuRd3FnmKQCCcOK9iHq0huMtdqM0OF1UBYJGMMOKtm9hCAKjwqrUXrWv+GQsuvYCLVrbBkEiLeSCnRI5c6hbFvKoE0+bXi0zNAaDq60RjwtVcMosAq6ryEBWWlRGO4uvy3aR8dpJi3j+7jNFBbNy4pzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPLMlOmPyfsQ//zoPoxR0s0Kw7wORrTkkAap7UtasUY=;
 b=IO/G6ol+hdJpfA8SxQDAgXPBNn1Td/NxiWGfYsd9IRCDYpYi7B5E7OI2b26/NcC4vOwEuyFRlBjnIP3kSj2zFjQLsANe4RQWf4wVd32gFAgArV5bYWJ1Hota5HUaQ9XX1ZRn+piW+c1UiQS6QoHqRNms6RTq7/X8/CQUuquGC61xVB/BZILjG99RdjaPBdHIbne9QtIeFqITaV1gtl6c2pVj0CCIwyDSK3cpYptZiugwJi6+vwBsSK0A192mdkPeQV5XbOK2z8CnZe5IChdKsICmfoQHgliQDGPhc75Upld41x8I2KW07evbRZIHXUw4c7uayJPjyw4/wCLtR4mcrg==
Received: from DM5PR1401CA0022.namprd14.prod.outlook.com (2603:10b6:4:4a::32)
 by MN2PR12MB3726.namprd12.prod.outlook.com (2603:10b6:208:168::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 19:59:34 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::b7) by DM5PR1401CA0022.outlook.office365.com
 (2603:10b6:4:4a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 19:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 19:59:34 +0000
Received: from [10.2.60.247] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 19:59:33 +0000
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
To:     Yang Shi <shy828301@gmail.com>
CC:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210528175403.4506-1-shy828301@gmail.com>
 <ffc5612f-9403-9bc9-316f-fa50199769b2@nvidia.com>
 <CAHbLzkpMFq4955wOq9bANxtonm3cM+yFPh_gfr8nJmnXu9_fgg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9d7cdf4f-502c-6710-1ff4-55c279f13039@nvidia.com>
Date:   Fri, 28 May 2021 12:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpMFq4955wOq9bANxtonm3cM+yFPh_gfr8nJmnXu9_fgg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1927aa7-a2f8-4126-bcc5-08d922131d92
X-MS-TrafficTypeDiagnostic: MN2PR12MB3726:
X-Microsoft-Antispam-PRVS: <MN2PR12MB372664AAC83CD06B20844707A8229@MN2PR12MB3726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nATthSzcFe4dQK4F7tWWvNrIloFu0p7b0AqoIM88BjTUycazhWEDJgzkb6fjbFIMpPfVCXMEo4JlmF3b/B4FUVFSSKK/zg+U7sxhM6D9OuDytJBXmUwAN7qxbirce/9EiWq8tUqDxRTRN8BnmNJfue+j75kW1isFbsZ7G5qh/JJe/9w2GmYlq2FBXlza3H1l6uLcsy0dWX1hLpXQ+X8gvLABt6/071Nl8LrhjKdqFMV9KaEi1Gjp+v4ph4TFtJ0etHg5G0xIvbS9DwrhwFNoHevfHjjU6hRtogmNyA1nN+a9bmhkSUv4sjSLhs/VLfNuerleRygrYgS4ohB/fPuBA5DrRfWFX0S7WML0w0ElnCBZWIqssteEGOebKu+699Nmb19JYLg8QQAw3bBMKaTOPJkiENAzwZOIeZRwaHImjtq9ezhpZQPb8D5u7I4pdKOLtrN7XigvaFS2eoWqDbHi++EN5VWYohkrJrVaJ7lXYQBk1wiBM1Ak2tNDRDp4iab9RHHTjFLVPy0j+vroefVYudSyMB1zBP2Y2n6yir/ZX/ANhnATXOW4qxGHry6AqbCY1er/b0wT2YC9Dq2riPMfNoo5ZGmJoqfB0CtjNEDym/0sS5jiMSGVw7s2zWoy6rXO2bGZiZKooBy0o++vXcoRdO7VibtX2Zh/przDZV9OqH7uAMESFvMdzfgpDcIY1XR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(6916009)(47076005)(4326008)(426003)(478600001)(70586007)(186003)(2616005)(336012)(8936002)(356005)(36860700001)(82740400003)(70206006)(7636003)(16526019)(36756003)(31696002)(86362001)(82310400003)(53546011)(26005)(36906005)(54906003)(16576012)(316002)(31686004)(83380400001)(2906002)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 19:59:34.4025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1927aa7-a2f8-4126-bcc5-08d922131d92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 12:03 PM, Yang Shi wrote:
> On Fri, May 28, 2021 at 11:26 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 5/28/21 10:54 AM, Yang Shi wrote:
>>> The total mapcount is a useful information for debugging, but we can't
>>> call total_mapcount() directly since it calls some assertions which may
>>> be triggered as commit 6dc5ea16c86f ("mm,
>>> dump_page: do not crash with bad compound_mapcount()") met.
>>>
>>> We could implement yet another implementation for dump_page() but
>>> it has the limitation when individual mapcount of subpages is corrupted.
>>>
>>> Actually the total mapcount could be decoded from refcount, pincount and
>>> compound mapcount although it may be not very precise due to some
>>> transient references.
>>
>> If the mapcount calculation were in a separate routine, *and* if something
>> else in addition to dump_page() used it, then I'd be interested in
>> calling it from dump_page().
> 
> There is. The total_mapcount() is used by mm code. But as I mentioned
> in the commit log and that discussion email, it is not safe to call it
> directly in dump_page() path.
> 

Right! I apologize for missing the point that it is a separate function.

But unfortunately, the conclusion here is still the same, if you are
unable to actually call that function.

Basically, if you can make simple calls to retrieve and print out
information, then that's a good situation for diagnostics routines such
as dump_page(). But if you have to open-code calculations and those start
to get complex, then you have probably gone off in the wrong direction.

Keep in mind that the diag routines themselves have to be correct, and
they usually don't have the same level of testing that other routines
do.


thanks,
-- 
John Hubbard
NVIDIA
