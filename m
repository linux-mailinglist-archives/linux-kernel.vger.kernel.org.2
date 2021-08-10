Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7C3E851B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhHJVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:20:18 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:31585
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233874AbhHJVUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk75pZttnwOdTuYuerNLIak2QhwziIYsOO3UmfjcdGQEouXr6BUKyzSmGPoJjSP33juM6ynJLk+6HEK5dESbgyib9U2YGyiUWwTOlC637Hp5CD0ZmK8u/3s0evU0Y5P+tzReIiH8BaIKtlvdC/gbHqSN7PnkLXcpO93nG0VBRvtKzfytMS98ocw4cGB1kdJGxdVAsZrcxji9N21+CQV6P1OVvTYBrcf/MGqUcr9skhvOizMudMrX0HhYfBQPJPfPjjIgUhCnM1OHNa/QR18ycLZw1CYTDNws35OYn9xTPT3GJWAEnvx5IiOu+jqT77LmYuBHEGYGH+oZYVolI7ZTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRo7l4yLY1BZnvrsqtFAgZY+eiSW0YEkiKz7raPOpwo=;
 b=YQvx2IDmE1ZV39x/3II+siH0Yy/+cGo5WmBTzSuXJ6gxTmsB3o5h/y623wzHj/tt4+7Nr8bBeOWQ64zXaRrRUD0hYCbHGEyddT4lQ+joidg2/djEVoc3NJkhhnM2FmEirqJJT8ay+um51RClPNgZ2jTAnbZgsIeM/PIWGhKP9PxpB1iAfwmfipAoWfCeX0lJ9vrSUpdvjiK+wul72bdrbI7bY83TYFcRRdalUiMhM651tY3L5hnlR0BuP62+wDaMI2LE752yl94jr7yjvlCBtebDnBrpODuQCBU2OgYS817j/y+odqBtHTrzApl+57hIg6zlW2Ku1qqgX+ZWtmR+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRo7l4yLY1BZnvrsqtFAgZY+eiSW0YEkiKz7raPOpwo=;
 b=airXeCn/St78dH5wsYtkMw8murJHQuQPD6/CwVAwhhuXxqjwKX+6tjM+hb3OTzvNBFJo7faHMBHVhg30zARZFC0pVpQsj2EQKGmAw5TYCZ18wlb6rSeExo1R4GXCVxzhznyELcu6sIUnJcz2iXVVgfp1G0MNqIUDMMm6ymUQmLnV0gSHbZyCTPzkojUgG1kb8gbyIlVLnRMnb3kbQ9F930bTq7R3GlWXBKb4xFpNj9hBW7XKMvGdq3XsJIOOASHZmnduqQAyVM9EZHfbG6/1abxutCSRP+omqRmjmLV1q/IFME4s54kVxFfa/u/lIu8x7BbNsJlo+6U5YEj8tRpw5g==
Received: from DM5PR19CA0070.namprd19.prod.outlook.com (2603:10b6:3:116::32)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 21:19:38 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ae) by DM5PR19CA0070.outlook.office365.com
 (2603:10b6:3:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Tue, 10 Aug 2021 21:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 21:19:38 +0000
Received: from [10.2.53.40] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 21:19:37 +0000
Subject: Re: [PATCH 1/3] mm/gup: documentation corrections for gup/pup
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-2-jhubbard@nvidia.com>
 <YRCHZObkj/BJgCmR@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <33b4673a-0509-79fd-2572-5f88255bf585@nvidia.com>
Date:   Tue, 10 Aug 2021 14:19:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRCHZObkj/BJgCmR@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2342cea6-069f-43f3-906d-08d95c448f67
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268EAA2DFAA6ADC2D855B2EA8F79@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPkYBulyJPeQ6sOUmbJVR+aA08rAuTvKYWlY5ndwIYQiQI6rWL7EcuD5mY8JKc0jo357kJWY/GBzqMyYCqiec4+p3xSBQNG8eu+YASXO+3BJVq7PO2c8wumwN/uCTKAmAUpHDR9qmywzoHl5rxGYeD9qn/ZYHH71FhIflK3nlZ5ynMMq/xO86mup020O6kYRJtLl1VfF3fZ4uvLexUEv/V5BJKfBVgMmlth9ona9yXH2mIJRk0d5vM0NUSXrWOplhDl9BMMcwUTYAkpov6ZzO7cJeHPWkxDFjcDjj/66x2X3COUjGQjImiRRQU8faTNqaqct7NVXurmrwxhdPzn8XfLwvXpR4PBb+X7pgWs9KWZsK5WntnRx7jqempauAbOFWveUtaUAgiw5pNmHI3NccN22kPjezUOSRSpVhuEzgOPwefVgeuQf+0kdqjJeiW/Yy0uvJtvDtJuUyceKv+tr139XYV3L6zzgXUQHUWDSO0Lt0x8/qbX+K2NvtKGYqXgTupe8wUznNhOt8g2/1K3eO8yerSXVJEJfdGh82zBD0ZzoBocUwhLqktWwcCdaWnQHkZpg9IWba3aSwPM34JEtc1N+MjDmORpQpWq4udPNPBrKUEGafraOISmf2+7cxpsyNWXsQyOA+8UsdaX++JTVDzzs4qjrEqK3M26Bq7nG+3Z3/QYg27EnfurOPhzqM04fHSLXM8mpc4P4I53LgoCPFpKV4r/mfBHKEduvwkMlDD8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(5660300002)(36756003)(31696002)(16526019)(186003)(2906002)(83380400001)(53546011)(31686004)(426003)(82740400003)(336012)(4326008)(8676002)(7636003)(356005)(2616005)(478600001)(26005)(54906003)(16576012)(316002)(36860700001)(82310400003)(86362001)(70586007)(70206006)(36906005)(47076005)(6916009)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 21:19:38.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2342cea6-069f-43f3-906d-08d95c448f67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 6:39 PM, Matthew Wilcox wrote:
...
>> + *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
>> + *        be incremented by refs, and page[2].hpage_pinned_refcount will be
>> + *        incremented by refs * GUP_PIN_COUNTING_BIAS.
>> + *
>> + *    FOLL_PIN on normal pages, or compound pages that are two pages long:
>> + *        page's refcount will be incremented by refs * GUP_PIN_COUNTING_BIAS.
>>    *
>>    * Return: head page (with refcount appropriately incremented) for success, or
>>    * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
> 
> Did you run 'make htmldocs' and see how it renders?  I haven't looked,
> but this might work better as an rst list?
> 

OK, after a certain amount of sphinx and sphinx-extension-related
unhappiness, I can finally report, "nope, rst lists do not help here".
That's because the rendered kerneldoc HTML versions of non-numbered
lists look identical to paragraphs that are not lists. And the numbered
lists either look identical (if you used the "1." format), or different
in a way that hurts the source code (if you used the "#." format).

And the lists are also fussier to maintain, because if you do not
*exactly* line up the second and following lines in a paragraph, then
HTML version of the list breaks. Whereas, the HTML looks fine either way
if it is not a list.

I probably shouldn't mention that the only function in gup.c that is
listed as "make this show up in the docs" is get_user_pages_fast(),
because that might lead to people asking to add more items to the
:functions: list in mm-api.rst. And then I'd have to explain that the
kerneldoc rendered output for functions is still mostly useless: kernel
developers need to see the implementation as well; non-kernel developers
will find it incomplete and cryptic; and it's hard to read for anyone,
due to being spread over a country mile's worth of whitespace. So I
won't bring that up. :)


thanks,
-- 
John Hubbard
NVIDIA
