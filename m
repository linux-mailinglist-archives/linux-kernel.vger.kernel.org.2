Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA99F31BC42
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhBOPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:25:10 -0500
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:14294
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230446AbhBOPYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:24:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9Q4paE+ERY0eEayFLRxd1dNINHOE5SJ6Y0ksQhng5DFW6FxE4lxvNvx5sfvbtqvitzYygY69C5oza2yi+NRRaIENNSGcC+eduQVExOoBZQblYyFYlyFokkA4JwofbxkzVn4G0H+ZvNrYkdgKUBTTB+j3Tlpz6zuDKS42ZouEaovd06prgaELAu2augZes0vouThFPtVJrMmYnUdvzXDEaFscIf8knUwS+iy5CnibP0GXVaLYEU1jMh7iOwxVfDzRpddWzXvy+mqkhbzU47XM16qzDGTbN4UPskLF5uriqPr9G0Oq+mhPBuf/uSN5ek/JFIWOYknaa9a39TO/3CjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyhJDNoA1RcDav9RqoCJxNMbVbwqKrwk7GBwDqfj+oI=;
 b=V8Nj+Nre5UDwO08MMHU2LR8410okhGFKtgSUr4GmQQzvRAUYrq1kxDBaZKxsxk8s/i+RLRj12Z96EyypJABWTl5hiXShxRbjiUEdN4vKI4ns7in6WauImEGcfIuGRDDWotvJ9Kg33yFhiwqqOuWpiDjA4aziKfyfHuuPbXK+pLt/L5OoN2llFdcqq58BU/W7nXkKgzQpXVVrQD7+a6Mt+sB4KG029ylv94rWUXfxFvr5Rsm+NKPtDRy5BOLnwX3KM1+l9H3cCdN2m0IAQ9SZ+1yNDb8kvqb7yGilH+CazJX3GhN9YkKi6bSe9wu73h6Q8lYId+VbhZXlabdMXFpMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyhJDNoA1RcDav9RqoCJxNMbVbwqKrwk7GBwDqfj+oI=;
 b=hDNteTCOKJgoCykH8moz8ymGo4o3p8d3Wi0doPJY01DTsQ4zpTllxuExlYXVLpnohZDBo/7tB12Lu9Hj1N04n8ozodKRlI2AihI5OOQCeGj+vejs2KJdM9wwAUHmQdqgO9a9Xz5GxpiEiLLi17KKENnZ4+nFigA5x2RRxh2JpJw=
Received: from MN2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:208:fc::42)
 by BN6PR02MB3268.namprd02.prod.outlook.com (2603:10b6:405:6b::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Mon, 15 Feb
 2021 15:23:37 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::a) by MN2PR02CA0029.outlook.office365.com
 (2603:10b6:208:fc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Mon, 15 Feb 2021 15:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 15:23:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 15 Feb 2021 07:23:36 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 15 Feb 2021 07:23:36 -0800
Envelope-to: michal.simek@xilinx.com,
 devicetree@vger.kernel.org,
 frowand.list@gmail.com,
 linux-kernel@vger.kernel.org,
 robh@kernel.org,
 linux@roeck-us.net
Received: from [172.30.17.109] (port=39162)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lBfip-0004Sp-PY; Mon, 15 Feb 2021 07:23:36 -0800
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>
References: <20210212033120.GA100407@roeck-us.net>
 <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
 <20210212151725.GA57042@roeck-us.net>
 <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
 <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
 <20210212225049.GC115630@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <85d6deea-abd9-f7aa-8eb7-9067f6376d49@xilinx.com>
Date:   Mon, 15 Feb 2021 16:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212225049.GC115630@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8938bf0-a918-4c1e-f12b-08d8d1c5aa72
X-MS-TrafficTypeDiagnostic: BN6PR02MB3268:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3268991EA1F563DEC536906FC6889@BN6PR02MB3268.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdEyASOBgOCoL22WuQBe6aLtYd6pMfdEGEaZUBhbYnrbuGMUUZJ3JcSbQ1oK3f5/8RRxKQTX/rVo12mzVkIu+XNc+rP7k5IIhLkcjNedry+hnlaky4jjJdYnThhVowf+ourusbuwpceK77CMENasMj/WQkTAhKWrAeAgrpOnfRcCLU+GrMaSu51UfbbnMts2iisDK1stVmcimFaWEGBBk0hRNWi05nzZMeyhGqbo6i+pzvks4m5WO3XggKYi9/XerGbjI54dSa3S4DMJ7JSUmN7RRf7jtG0tVjkrs9knIp0ziAEVA2ZZuf1VJ4olRytY6g7DkyzD3Abzbg3Ic/dHz+8HmWgfjY0aQcoWYko4hRsd7Z031aFcq8uNrxff/Op0KB7UKtxyDcqGD61LALtLMdMZ93D6kE044+OtPk3nfPogy2/5sFmYrwB788lpE5LFx90RGxRzC2YNuiqhGG8fA0PAXG/146XhyIn8Fza/+nI4IuMm3fAujZwA/jGrH6fVXYLBvt5eQoh8qWY8ov1ZWkfZjQdw1Cc9aE7G6s4XOCG5X+51DwMvboAxPyZ0TH8Kh5VIA5KIzr8wisw95wePOkbbPAgpfeBb9TXgMXh2YT7XtsIOnlmLfVHyUTqQ9yr2z8239N4Dky80nrMeWVZ8cDTCEMKaL59auHXBzVP6yYkhT+vl1QKnckohNXf3hM5kG3KDlqDdUA6nY4Gp/amd2yS8lUC0UfLHnxmn564+EayI3tCrCN7XlFDWj656qlOQ9NrXshHNGO/S+WHWBxgsTyvDGf5x5iDa1l5qlDpCAoc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39850400004)(46966006)(36840700001)(336012)(110136005)(54906003)(9786002)(82740400003)(426003)(186003)(478600001)(26005)(316002)(70586007)(2616005)(4326008)(5660300002)(83380400001)(82310400003)(53546011)(70206006)(8676002)(31686004)(31696002)(47076005)(15650500001)(966005)(7636003)(8936002)(2906002)(36860700001)(356005)(36756003)(44832011)(36906005)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 15:23:36.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8938bf0-a918-4c1e-f12b-08d8d1c5aa72
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/12/21 11:50 PM, Guenter Roeck wrote:
> On Fri, Feb 12, 2021 at 04:34:04PM -0600, Rob Herring wrote:
>> On Fri, Feb 12, 2021 at 3:01 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Fri, Feb 12, 2021 at 9:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Fri, Feb 12, 2021 at 08:16:04AM -0600, Rob Herring wrote:
>>>>> On Thu, Feb 11, 2021 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> Hi Rob,
>>>>>>
>>>>>> On Wed, Feb 03, 2021 at 03:26:03PM -0600, Rob Herring wrote:
>>>>>>> This adds the following commits from upstream:
>>>>>>>
>>>>>>> 183df9e9c2b9 gitignore: Ignore the swp files
>>>>>>> 0db6d09584e1 gitignore: Add cscope files
>>>>>>> 307afa1a7be8 Update Jon Loeliger's email
>>>>>>> ca16a723fa9d fdtdump: Fix gcc11 warning
>>>>>>> 64990a272e8f srcpos: increase MAX_SRCFILE_DEPTH
>>>>>>> 163f0469bf2e dtc: Allow overlays to have .dtbo extension
>>>>>>> 3b01518e688d Set last_comp_version correctly in new dtb and fix potential version issues in fdt_open_into
>>>>>>> f7e5737f26aa tests: Fix overlay_overlay_nosugar test case
>>>>>>> 7cd5d5fe43d5 libfdt: Tweak description of assume-aligned load helpers
>>>>>>> a7c404099349 libfdt: Internally perform potentially unaligned loads
>>>>>>> bab85e48a6f4 meson: increase default timeout for tests
>>>>>>> f8b46098824d meson: do not assume python is installed, skip tests
>>>>>>> 30a56bce4f0b meson: fix -Wall warning
>>>>>>> 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
>>>>>>> 67849a327927 build-sys: add meson build
>>>>>>> 05874d08212d pylibfdt: allow build out of tree
>>>>>>> 3bc3a6b9fe0c dtc: Fix signedness comparisons warnings: Wrap (-1)
>>>>>>> e1147b159e92 dtc: Fix signedness comparisons warnings: change types
>>>>>>> 04cf1fdc0fcf convert-dtsv0: Fix signedness comparisons warning
>>>>>>> b30013edb878 libfdt: Fix kernel-doc comments
>>>>>>>
>>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>>
>>>>>> This patch causes my little-endian microblaze qemu emulations to fail
>>>>>> silently (no console output) in next-20210211. Reverting this patch
>>>>>> together with "scripts: dtc: Build fdtoverlay tool" fixes the problem.
>>>>>
>>>>> My guess would be something in libfdt. Maybe 7cd5d5fe43d5 or
>>>>> a7c404099349, though that should return to historical behavior.
>>>>>
>>>>> Can you give me the qemu command line and kernel cfg?
>>>>>
>>>> I copied everything you should need to build a kernel (including toolchain)
>>>> to http://server.roeck-us.net/qemu/microblazeel/
>>>>
>>>> [ wow, I really need to update that compiler ]
>>>
>>> I can't seem to get BE/LE nor reverted or not working. It's always
>>> dying in microblaze_cache_init() based on the last print. It's your
>>> config, but gcc 10.1.0 off of kernel.org.
>>
>> It seems gcc 10.1 does not work. Seems to die before here:
>>
>> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>>
>>> There is at least one possible problem here that the FDT may only be 4
>>> byte aligned. The assumption is 8 bytes to not have misaligned
>>> accesses (and only for 64-bit accesses if 4 byte aligned). That's an
>>> issue with the qemu image loading depending on the sizes and
>>> combination of images loaded. That doesn't explain your failure
>>> though. As the initrd is a multiple of 8 bytes, you should be fine.
>>
>> It's the built-in dtb alignment that is the problem. I had noticed
>> this earlier, then discovered I had no built-in DTB and QEMU provides
>> a default. And changing didn't help because on broken gcc-10 it was 8
>> byte aligned. None of that should matter because we're not using the
>> built-in either, right? Wrong! The assembly entry code copies the
>> bootloader dtb into the built-in dtb space. I remember this now from
>> the last time I cleaned up the early DT code. I suppose the reason is
>> the bootloader dtb is not or may not be at an address mapped early.
> 

I have tried 9.3 and 10.0 from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/
but none of them did boot on real HW.

Xilinx stayed on 9.2 and I have asked team to generate gcc 10/10.1 for
me to be able to try it myself.


> I think the problem is here:
> 
> /* initialize device tree for usage in early_printk */
>         early_init_devtree(_fdt_start);
> 
> That probably also explains why enabling earlycon doesn't help.

Can you please elaborate more on it?
I see earlycon to be enabled quite early.

[    0.000000] Ramdisk addr 0x00000000,
[    0.000000] Compiled-in FDT at (ptrval)
[    0.000000] earlycon: ns16550a0 at MMIO 0x44a01000 (options '115200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] cma: Reserved 16 MiB at 0xaec00000


> 
>> I'd really like to get rid of that copy. Anyway, the oneliner below
>> fixes it. We need it either way, but I'd like some comments on the
>> copy.
>>
> 
> I can not comment on the copy, but the change below does indeed fix
> the problem. Feel free to add
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> to the patch if you send it out.

Please send the patch. Would be the best as early as possible and I will
queue it for 5.12.

Thanks,
Michal

