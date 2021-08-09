Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676AA3E416E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhHIIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:15:58 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:60958 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233647AbhHIIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628496934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoydGIN7b0uCKKI2WdlSCtAyutB0W54SEbGWnh+FsmI=;
        b=RvJjd444JgsI2SzesM3pOhQ4gXzqTFU8/C3/dqTz4hj2PLr1TAAqOkruT/tXFjvwYipj9g
        Hl28GQ24SYbjGkq72eya3CJUQ5xJh6zsylGcAKmk5Sb7bQC8gOPjGtdS63UeLwUhRoBXY8
        SbKrhQ6+Lw+jsw43IzuhRbFiLp47gEE=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-5SrSgZyHNFuZenRNh064Xw-1; Mon, 09 Aug 2021 10:15:33 +0200
X-MC-Unique: 5SrSgZyHNFuZenRNh064Xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCpADvujw45yXuPygm0eGxrm36xTcA+NZuJI5mYH7VrfCDCROZJ7OeiP4f0XGwSyV0RyPBiMPHBNYpoGMhJo5Wa3IFk2+sOFwk7DT7iEZpvL2OTLRpiX3cuRGj2x+Zna692Pwtu5cHHSoclfxLJRMu17FjTSpZN5K/rpz3+In88UpoZDy4OVbd5APMHSEXN0zKXr+lxlCaqt88BL70V3d3RRGj33OWE0fqToLIAD6DnBQIFDmK7F7Zx2F4yvlo3ik/hYK43bgyTymc9m7x7lyrqnSrqm+YeXK+TOysaARe0qNS6bI+RTiPZNN1C+pSN4QM4ZWEH4NnUTFtD6sZaB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCQPOuB3Cq/RQu8bOPR/5YYIfxPQC/bsDHdL2nJgNW8=;
 b=YLHjhInCW2wvaauxCacRHMa1/R11GTOvqDjrhNBXFDyvkYJQ7AViIVH9CH3IGneDHnybGn4vsxDvdFWATdnb8wTNi+umTLzm3QR4MzYHPzrVfwj+v6ni8GnATKKpiGh8hAyohKbXHwplilBuFQhfz4gbrUmOqpEwdifAAyDwR8Gm5/z5ui4NQ6T6wdUrHDI9GTFxJXikTAHbUJmbs6VvSAMYtpw8A2muexrS9tHB6FfHaPGD0qJ0aeU5Y10I9i41kOsnTEnRH5IW8KIWl8BoBBt94zLU6nwA8IXxzw/dYKc+ZQqxKbe1ihSYV4JZtDA/UbtLfFOORP2tPatEFHZtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DBAPR04MB7398.eurprd04.prod.outlook.com (2603:10a6:10:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 08:15:31 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 08:15:31 +0000
Subject: Re: read() via USB bus
To:     Muni Sekhar <munisekharrms@gmail.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
Date:   Mon, 9 Aug 2021 10:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (2001:a61:3b82:3e01:c3c9:c93b:1b8e:a220) by AM0PR06CA0091.eurprd06.prod.outlook.com (2603:10a6:208:fa::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 08:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d934c3-c851-499c-cb3f-08d95b0ddaa1
X-MS-TrafficTypeDiagnostic: DBAPR04MB7398:
X-Microsoft-Antispam-PRVS: <DBAPR04MB7398B78B0B44D5930B744CE1C7F69@DBAPR04MB7398.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofhZtQVj7c2O2yfVImbdF4xYjzQWPQAQfvjmo3IyF1+SpdKAr8hMd4CKfAhJnT0CXuha01EG3r9iWLT++Y869OYQCtc6Wx3yb7vbMZxaC9A6iv21XsTKf7dRhqFCpblx16XTNnYqbkqP78s3/sjZmWQoRQq6yx4PVUCGn2P2EK+rBCmkWMq0SS5RdHwFlSlxNObQnrW8f+Gn60w1wFP6uRhGPr4kPjeIo2TOrYv83DK60mITqOHYiPNOMgK8qyoQI4EbfWFM4I5dd6iHWze9xmfixh6btKxn4vmBHLFHYUjwuXD6KnWbh+9l+2l/E8WihyvysXgOc4IH2uu4TTdofqR2G0tZ8XuoJfCeDF07L8ivOmRxsLCHmgQi8msa6OZxMQAXepUz0TkCK/bhs3n2u2OJE9+eG7AY8jcRePI+1MTN0tshLXoF1PpE9VpfL4d7DhSzwY2bOLoE3q+GJZARZiBshnj0ku8qAe7RBpA1aLlA++0c9ImTMjfLuPyWRheWl6r8/RP4jFFnmdUhUsRvPQEwsqbfMUoxNZQwRwOJOZGWs0c2XfeADtsi2OPfhGhR1FOhcgBqopPDTaoN7PEL6+xcPNbZr+G2NDsC+DuIMaKEH3EqiqnpRyJ5gWBxWgetLypbJ1B9AT/7QCdb6fXcFca30QM0egpI/eOmUBWlgo4FyrtG5fV3tlDMxpsxn45SMK0CaEpwMr+GHOtHc755Qwd/KAOUwDFYhINs9fZVXg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(478600001)(5660300002)(4744005)(66556008)(66476007)(66946007)(2616005)(8936002)(8676002)(31686004)(2906002)(316002)(110136005)(186003)(6512007)(36756003)(6486002)(6506007)(53546011)(31696002)(86362001)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RsCDQtQFDBLkZqvP6hPcYJKeJl1o5sPTqqWPJBff4OETWZ6gGDG7yDMWzJkd?=
 =?us-ascii?Q?N7kIy2obpSq8RFP1vcJRuVl15M4YLarh2w4vhX04ia1Luh3IsL06YmTC2scM?=
 =?us-ascii?Q?BdPP/OOw/CshHIzO1LsVUnXfBPWy13AbsWzeSBWZIuGTEOWLlZMFImAKam5S?=
 =?us-ascii?Q?HeSboh9mXf4g57oY45gc9la/FfGhPPE4VHZy56UHoNMpGr9caEmhJxQOmm6c?=
 =?us-ascii?Q?y94oYXH6J9Nu3rTgzK2Zw2qkR9hxpS08F29cx8THwgpUp9ely2yki/lW142+?=
 =?us-ascii?Q?cCV+6mSeaoi0B/hXgX0ABAio59QFmIK1hLyqeeIKJUhh9MfAgYf6UZvGXpgD?=
 =?us-ascii?Q?fTfWvNaYT2gus82EMK1byw+IJ6eJ4bHwHEskyH6RsQB1Tqyh/HFz1W2Qnl5r?=
 =?us-ascii?Q?b5RQD7ToollB0twtJ9bxrxJMqVCh5ECplAJHsuusUKgdPKyygTBsUYFXvvv+?=
 =?us-ascii?Q?W6wpemUokt6WJdFDnmXRJOEeTKPd3i5v/IEZqIv/dFKejF7BRQex3mPe5ZxQ?=
 =?us-ascii?Q?WAdxZOv++uresa4mpIWJ3jXCP98/dHDVzge7+6Jgzz9eLwdjjUgADqs7QB3H?=
 =?us-ascii?Q?yPTzFOGfr8Ta/qBEQkNew1BCdDktXkhNvgOVBXLATaoCa3rbTiPrGUMAv4oD?=
 =?us-ascii?Q?LJ9jsmzzLVGyd8iyozBEK4pDgQZWo0oeA/MG25/ubYd/n11/hNWf2cgRVnFP?=
 =?us-ascii?Q?d8XhYj0iVatoiQDBddmCc1vnBSYTUJuj8JE2Rd0oNs/vPYy407SzuI0xplHz?=
 =?us-ascii?Q?xAlSJ4fXX1Eemp+wCqQ+klbQ6VSOOtZBmg7p6PcI6JoG+VFx/oC4hTc1pT/i?=
 =?us-ascii?Q?3ppGIZR9ewOCfhO2xCR/r20dMdUU6+LOR4mDNDkA2vf+ePKfwy8gXKLo5FoQ?=
 =?us-ascii?Q?uWOKJ1nf/Yq4gVrL5R/7v/QRlID46qE+O5worUNuqVoar9iYaZRFsRgQ74Gj?=
 =?us-ascii?Q?cUBpMb3hOQtqptcrQE4IVSCAcKgSXXfEAFDxuyACF/20vEfKKHwDpzKOsXbk?=
 =?us-ascii?Q?O4qH6AK/P9jlJ3qjiRRyWnLDuGwdzRBH3LLRh5E+Cl1dv/r+h3F0DZkPpLfE?=
 =?us-ascii?Q?nUNszK9+mCn/t7z4MeLlxtNJAKHta0Z1jYoqbw0vpn+a1VYXGEONd6Hw6uLw?=
 =?us-ascii?Q?DPs/AXixZLkpf4nAG46JAbHWuoWdEFPomkuskSTwXxNLzT/y0ROaJ/1/VvTk?=
 =?us-ascii?Q?lcKg6GtG98m5wX78A6M5ARCkXLogi3dtue9Ufu1XjZJlyOuce7xrf2uVp1k/?=
 =?us-ascii?Q?Xb0P76XIVxXB18rbY/ZOgFCWXUUONatOZqiwUheYLwD2/jwVjrx52ZCyxA+Q?=
 =?us-ascii?Q?fjiQlIPydISrtAv5PL8sK9mGlt9r1FI0PEe+8Vo689hgRSMU2sayYKThtQAV?=
 =?us-ascii?Q?zyRQqhAUXDHvF6DoDO792e3ddMSp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d934c3-c851-499c-cb3f-08d95b0ddaa1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 08:15:31.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THtPZwYvvAkQk/eTDILBEuoqxsrm21blmBWXClwGF+4YAVzekU+bgPtRJc4/TkEYko8KqElCIFrf9zTU9Vbufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.08.21 09:58, Muni Sekhar wrote:
> Hi all,
>
> PCIe memory mapped registers can be read via readb(), readw(), readl()
> kernel API's. Similarly what are the kernel API to read the device
> registers via USB bus
>

Hi,

I am afraid this is based on a fundamental misunderstanding on how
USB works. It is based on passing messages, not reading and writing
registers.

USB devices are primarily based on endpoints, not registers. A literal
answer to your question would point you to the clear/set/get_feature
standard requests of chapter 9 of the specification, but that really
will not help you, as you are making assumption that fundamentally
do not apply.

I hope this list stays friendly to newcomers and we will answer
specific questions, but at this point I must advise you to first
read an introductory book.

=C2=A0=C2=A0=C2=A0 HTH
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


