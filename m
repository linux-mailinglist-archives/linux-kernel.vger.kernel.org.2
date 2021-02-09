Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307683155B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBISJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:09:21 -0500
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:29662
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233170AbhBIRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcunolmlXYJq2mDi3YfmorZP5oXE2Nytl0EUzdk3q8s8l7KOC+zuHAkFD+NbU+fJAmj+eODt87FmhIsu+J0Rbi/GuWreNfWfaN1hfL9/70zR6WdFnf/HtOa4CyHZwZMr21BYhL/CGaSJ8nWq1WRnQOAEfU/L5nWfGkzi3OI5HXuneX4zlC7o1r6vEwMx02bK1+IPbl0Q6RY0+5zOUvq2MMrnFmYIBQpRhrUxRMHTf/zm61kzRK1vKUtyMake+7xZ161qG85lPK7hyA6AyyuZ2rtC7/PWksRbliz8xbHKztKfnP6N2yEDEGj5SXlSlQ63aUps2vbTWpGMphbRmC/z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciVStjLIT8UlT0rkvJWMaBI0w9hNptS4g5bB2fEsVcs=;
 b=dMkvwxXcl7vz5pK+Jkv/zWgUPlmPCtSlH2Tb2LSnOxf6B7tXuZfROTB40pwXXg/BBEDD1Q3+dxgl8wezGhsvnVCieOvEPEpEwVvP8Y14/QiNzybKwbvZ4wUSecCs0Ek0waIfkx9hJiNYez9f5ZaUa6ZvxOO+1CktfoFtxQAU/UZRBPYw2jJX3jNaj3pZfXEEM2k7Yehx6n8fq171QhKy6XKxVA4B23MbDDipyvr5Wm4nW+Ggp3zciO459yH4/0d5VzU/8gMjDTqFD8hQIiqitFNq7ZVSjbVsTC+F9c92WbJzLnPT3t4jc6Z2zHFYEGFqGm+EkkrIIQb8fk3ifngvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciVStjLIT8UlT0rkvJWMaBI0w9hNptS4g5bB2fEsVcs=;
 b=ZRIyXcWTdRYHoaGpSvubwtf40RtXlpZdPviT9JU2d2oJy33usMQ8nBqLPYICwIYROHSJ9n9GiLhpn4x9dt8pyvUURLZ/3G+rn83YlhMtI9yZ85711mQ1n2ZJQdHF4GQofpDQ54f/XLWyXr3lEAj80BMIrbCB3yhroNv+SwdGaAE=
Authentication-Results: narfation.org; dkim=none (message not signed)
 header.d=none;narfation.org; dmarc=none action=none
 header.from=studio.unibo.it;
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15) by DB6PR0102MB2600.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 17:46:28 +0000
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922]) by DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 17:46:26 +0000
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
References: <20210124232007.21639-1-richard@nod.at>
 <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
 <443281182.378615.1612885278254.JavaMail.zimbra@nod.at>
 <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it>
 <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at>
 <ad4fd822-016e-e11e-682c-077a1ced2a18@studio.unibo.it>
 <231074135.378774.1612888173941.JavaMail.zimbra@nod.at>
 <705c010b-653a-1dd0-87b9-f3cc83c21802@studio.unibo.it>
 <492787386.378826.1612889412476.JavaMail.zimbra@nod.at>
From:   Luca Risolia <luca.risolia@studio.unibo.it>
Message-ID: <dc083537-fced-f502-f8b5-189b1827ab1b@studio.unibo.it>
Date:   Tue, 9 Feb 2021 18:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <492787386.378826.1612889412476.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [151.41.227.128]
X-ClientProxiedBy: MR2P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::19) To DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (151.41.227.128) by MR2P264CA0079.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.26 via Frontend Transport; Tue, 9 Feb 2021 17:46:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2674d71f-7f66-4d2c-b681-08d8cd229f46
X-MS-TrafficTypeDiagnostic: DB6PR0102MB2600:
X-Microsoft-Antispam-PRVS: <DB6PR0102MB260007D534FF51FAFDB06129DE8E9@DB6PR0102MB2600.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vxoyoBsXBUsRZxWaDJ/ZuKsQ6Rc3QHUAoluLebwgFFxaWQEC2hvEvvkTJUGS6zaL2m1NIZu6G0NUJf9qaK40KvaoaxZgagfSO2ZngnLzK4MU3vJ1vOIvx2nLRLEnMefrtL9mU/mZdEsXaFvNa6eHDNUur9bJ+Fj3sYZScIRUydw/fqbBCWJeSXcum3jKTgJbd1tMJGXNT/JytGicEt6IVZKutsiY39mxnSTBWun1T31wI30zAaWGCdoyVv/dnvgDq/eyz6hu4S1Qq0Nn/9ifvCsaC7nRQA3jnVKxVtI+FHPta7XfpsDOfRfM4DBKCrlNJZ+DFsQwwZR7sZBX20Pv18EMNIOr7NJNSiV3Qr2GdFkyvxz9Oa1ZqDaWqFfCkcWqGD2p5OL6YHLdMC65fApCG2otCrgm8gR0gzsP41aDFr7kNvVNDTaDkfYSGQC3E59blNgDKE/OwC2eSEq54pyVIhzCdZ9WgHNtmETpWUZatcNS7sb5OrzzrypBQ7qSSoEpzpXN9rekcBLQ4JZqnNFfISSZZuGROpP00b1Q7wVTWdQ6DcSLSQrW/yxBg+ufStykohMfRHBCcidjljohlN7BQvN94POAmW9Vf5+9fekL3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR01MB7109.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(44832011)(956004)(66476007)(66946007)(2616005)(54906003)(7416002)(66556008)(16576012)(4744005)(83380400001)(316002)(786003)(5660300002)(478600001)(6486002)(2906002)(53546011)(8936002)(6916009)(16526019)(86362001)(31686004)(52116002)(26005)(4326008)(31696002)(186003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NDA4anR2aVFBMnRBMjdjMy9FQm5XRk1RS3ZKUWJiODNhNmlObmpCMldLMkJV?=
 =?utf-8?B?dEFEbFdtd3VhSi9ScFFRZUl5TFNPOURBMkZxelZBNWtpdGhYOHBJMmpyaG5p?=
 =?utf-8?B?OWZnTVM3UTI1aFhGTTRkdVFnYlhDWnR4aTNlZFRvQjlKbGVvVWJVNU56VTFN?=
 =?utf-8?B?ZDVOWjlEdEMrSlR2ME4rNzJhTDdYMWNQcUl5ME5JdkxXM1Rma0Q4QkRoNm9L?=
 =?utf-8?B?T3NRdzBjVFhIYmU2NmhvSm9WS2l2bU5JK05SNEZFRGpHdUNJdEhSRFRjZ2xx?=
 =?utf-8?B?bHBkL0t0Z3Jkdyt6MGVHaHkxRnRmSXNjalBDd2RnSmFKaHBZbkdFQlJTdWsy?=
 =?utf-8?B?cW9acDRaNXQ2YUl5NGZRREpoWXFLcDZSTmwrNlBERTJuSDc4b0RBemRoall4?=
 =?utf-8?B?YmdVUkJrc1BNVDYwWUdNN0EvZitBRkw3WlZQM1RzMGd4NEFYYnNNWGxJa2VB?=
 =?utf-8?B?TTlPY2Y0ZHdWaUUvQml5WVBEU1BHb2FIc3JkZ0R2QloyTzQ2TlNPN0FBeEVu?=
 =?utf-8?B?Ny9zTXljTGExZ3dLd0ZBREMvYmhGY0hoZmdJL3p0cWgrcVRvYjVDTkdOSkxi?=
 =?utf-8?B?cVAyTjNtS0VuVEU4RGd1Nkc3bUFST3FZOHRyVk44U1lYY3VIRHEvaDRKUmor?=
 =?utf-8?B?WmlkQmtWNndaNVMvUXpzVVk1Yk5mWXgxN1dqekVPZVJxQWJEQTdhWkJwVTVj?=
 =?utf-8?B?T0swSXQyVWsxOWlCOFBFSFpLL1NQaENGelF1VmM1UWlZTzhERE0vdE5KcFVQ?=
 =?utf-8?B?S2hGUVFWalNhNE1MUDM3MVNIZnZSUXRaK0NtNDlaL0Zsa215cHc3aElGUTlK?=
 =?utf-8?B?K0huZTdYUFFPU2NIVUlYNy9nMzBWOEJIdWNqQllKS2J2L2hKQVkvNkFxakhM?=
 =?utf-8?B?ZERFWnU1Tk0zOWsvem4rcS85d2F6VGhIcmtvOVhYRnhSSHJZczJPSm5STCt1?=
 =?utf-8?B?YkVzRHMxZEl4L01LUWFQRVZDWWp1SXkyV2JKVUQ1am11RmNMakxVaVpvcHNr?=
 =?utf-8?B?cHJXZzRsTDBvR2doc1lIRmw1YjgyL280dFRVUDBYWEVjSkVaOUpTcHRXaGZv?=
 =?utf-8?B?bkdJSThac1ZMUThvMituNDFCdkhMc1Z0UnAwN291eHY1ZWZzcVd3TmYzaTlk?=
 =?utf-8?B?RGR0T1g1cndpWkY0SFZUMldUQTV5K2NvMnpWSkhxejY2QVNkZTNGd0psOHZV?=
 =?utf-8?B?b0lvd2ExRVhRa0NmRmxXcE1HRGtUYkZUdzBNZCtLUjQ1REpuZUxNcHNJR2F6?=
 =?utf-8?B?N1BPVzNTS3NUNGNucGVmTC9EdE5YSDFoVlhIczd1dWV1d05MaDZvNFRVMEVK?=
 =?utf-8?B?UHA4RjRqYWsrYk9DRkZMUUNJbitoYUcxMWtHek41ZmE3QmZVdmpoSDhBbHpB?=
 =?utf-8?B?dk45M1ltaWduTWdTeTlzcWVqL3RhTDgwL0JRbjZLVHF4UnAwMjhjTS9ZYXN2?=
 =?utf-8?B?bDJIbytGdkVSa01MYUdZK2RSaWtTNDVYNVhEZ0FTeldncWRvT0haOXpMdWNy?=
 =?utf-8?B?dDhIUXd0cUtNb25RaU5vbHErQy9hZk43RVFtL3ZrYlQ0LzJzeDBzMU9ubmk3?=
 =?utf-8?B?S0xYL005YVppbUdrQnV0b0FVc0l5UkV6dnNsWW1peGxWUmJ6MGFLRmc0WDM1?=
 =?utf-8?B?elhkbmNJeHBGb2t0aFE1dEtGU3k0Tm5HdEgvRFU0aXNGRTdVSDEzOU9jdFdp?=
 =?utf-8?B?aHdpUThqeVpYWU94bjZ4WXNtN3VKWnhBTEVHUC85NS9lTnlYTlczbEg2YVdE?=
 =?utf-8?Q?stf18wwvD4n8q3AhfLzH6fADoKT0DGdb+2YMVoO?=
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 2674d71f-7f66-4d2c-b681-08d8cd229f46
X-MS-Exchange-CrossTenant-AuthSource: DBAPR01MB7109.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 17:46:25.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCsnV0UmzwKUnqmaJyvcVARmSESZg1TY3TXW4oZJledzIS1qsXdPZTmHvU++cr7egNFK2vNawPMoBW+SWavLLUDzSLHX175vhzGpKU6mG1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0102MB2600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 17:50, Richard Weinberger wrote:
> Well, I think having a generic mmap() for CUSE is hard to achieve.

Hard or not it did work for what I can tell you. I was not the original 
author but I certainly contributed with testing that patch. Just to be 
clear, by "not considered" I meant both the patch and the request were 
completely ignored with no answers at all, silence in other words.
