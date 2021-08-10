Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC33E5DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbhHJOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:24:13 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:30283 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240697AbhHJOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628605207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9akZeYJ6zo0oWWGqU10WYgkQd7NZQ8aa/r3biSH++fk=;
        b=MDZrkSYwLg8F0Ez6HLyc4nKAEbj62GLKqa7H90uyzCyx8ArFPBWajfUQlhadMufTO80GhD
        ZiIGB4Kne8GloZbg3y21v/IwVtoMqdHyUt8WwTjO4/d2DXMwLRVvNC2YEPiScdHy7+1xw1
        pPScp3Q3uLIOFw1CMZ704BZyHH5VCsE=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2056.outbound.protection.outlook.com [104.47.4.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-u8oTKZ34OZyEVEp7q04bLg-1; Tue, 10 Aug 2021 16:20:06 +0200
X-MC-Unique: u8oTKZ34OZyEVEp7q04bLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDT7BbtfsVzbs8yCmY9tXzQVdyxeg11/TJr0heuEnAZ3XTLGjpwPeh8zljEF1bYkZW983dkNIqOCq+Qgc79/W1bT1G8WdKHZg+hpLsYu2ON/8OGq1nbX109bL7pL/3a8YX+3txsgOWINUwxHfCkZPQTClY4DKhBeS+fZGX8bWRJubg63Kev8LKs/sdMBnuInDiT0RtSVBMb4lhqsrCKYwYKK6jTwvPrElcQSkzj+gK24ew/P6zcyJxSwGIcG4UkNwymRLBlvhTUQxUe1C3RY3+ebpvJUPxtlO8fwDiM30q/LiwB1vpj0gAlnEA9RuU3+9oTDRhcX+fqpPvQARt2Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbaEt5paPzzVDWyRaEPf7+4xcFdNonVVP5qE1Nww3pM=;
 b=cgE7x/4Seq4h6ZE9ikNIQ7DVnerKNVrIdopWe9M14DhGDpTpC0Esmw3FOM+BNVuWOTQfT/rHEwsTNnTBfx4Yyj8vagyFT3cIB7IY5HT4sO3rSvUUL0IIJOuOOC3o2PvhViumjHxPku/J4fjb3o0KnVqkqTDJ3f4RJbjIx/ZMmOTH59baBzhmRDY3dyMa9xBChDlxAxgdGqfsZ/s3EWQMDV1XvTGwsx3ut7TUwbkpSH4puDzoUyjq11HuyVi+oVrIsDpuInOfxlyrIoTYO8BSaP/mAoA+mNBhL4CysXjtXTOZcSZaVBuGPEkd2GatjgCxzL7pMS9FvoeFXy2KSDbEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB9PR04MB8282.eurprd04.prod.outlook.com (2603:10a6:10:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 14:20:06 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 14:20:05 +0000
Subject: Re: read() via USB bus
To:     Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
CC:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
 <CAHhAz+i5YeQdJnBH6BvMJ-B0DtoBu9ER4Z79CPOfX5NuFvO=bA@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <4e7c9279-805c-c236-c048-2b817b1a7c3c@suse.com>
Date:   Tue, 10 Aug 2021 16:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAHhAz+i5YeQdJnBH6BvMJ-B0DtoBu9ER4Z79CPOfX5NuFvO=bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: PR1P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::14) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:a61:3b0f:ce01:6142:66c1:effb:a0be) by PR1P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19 via Frontend Transport; Tue, 10 Aug 2021 14:20:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 394560dd-4558-4889-22c5-08d95c09f361
X-MS-TrafficTypeDiagnostic: DB9PR04MB8282:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB82828CF4EAF4AE314A407C77C7F79@DB9PR04MB8282.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +krvZMRoNI/DZ7w+OLODtWGSwFs/sIhwAvINY6KFOToNH+9CWwLukcoJ2ye4eLBPLS9ZqA2OYF5Wi29g6CZTuICj9jXBOa4KxjVDf4CJ72FyZ/m+Xx3hhU0UNlVAjfLxsDKpXYMooGtKKHlea1gbCRqOd0XyYTbRug+OzKXiIHAbKW4Dw2K2c5zG524u6yWYePyy9uXEbCNVZilBN5+E0MXHUnhewuJgfkKM0ZeNgCkCWA5xbFbJ3x5Qg80sK+VEVXn/TyPNQAUHGztBdMMhGfESbycwhIbUkvfNu4PCm80D9+jBxtkl1RH5+PpoFiQan/uXiUlsPsh3oLvfV/XQ5chS97s2d77wYL87DrBnnwTD4HpK92bVCzSVPhvf+YRAe7JI0765iT+ufa9v9fsb3m9cHVLGtcfQTVEsusg8wfMKoqeetK7ykZywzUR3z2MvL0hqc2ITgregSdsUvFqE5Qbym4TOwi5Nibg5nQAxintybi5UUqaFMUeMR61Sz0+DbL0sduQTlbQYa6MMjqzmMBUQahF5UQL5xpe2Vm4kCzyTueY2aEzEadIBPmpp3U18ErbgpQhrfoBWgPYVqRqJsEdQt6eZiNV2uL9BvwStOyiiNLH7maLKUGKwp9DXPIcdxYrzOvfJtQunkG0Csxx6QlYRJqCc+lGIDUrPVTDkzajeeE66fY8m0R41RonNP7ris96wRR147CzLnHDU4cW26cg2JdB1QfKOPJ/2lkVbI258MAKQM2AvGS+gA3HCbHhMSuekDoUyeO7mnjOeZuqWMIDtUKFEveyQa4ugmSpZw5nwSJGbOAQPQaDUkf9l/AbB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39830400003)(136003)(396003)(8676002)(186003)(83380400001)(86362001)(4326008)(31686004)(66556008)(5660300002)(66476007)(36756003)(2616005)(38100700002)(8936002)(53546011)(2906002)(6506007)(316002)(110136005)(6486002)(966005)(66946007)(478600001)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8e7hgk3n2Df008oJVLT9r7fnWxBSU8T93fnnHQbz7QDRTlXjosM4zj+DT1J5?=
 =?us-ascii?Q?mBKrY7mLZiCy1PHFnn5lV3Cqem+sbGfd+OmDhk38e2Qmn84SL3zoEMpY2gGx?=
 =?us-ascii?Q?WHx2PKBsKJ+gpAORY7HsfGkECVsI/MGuCbBXMJr6DtE5qsgl31y6ynJPQcJz?=
 =?us-ascii?Q?zdK1khTv3vmsLRNt53fghq+NK0eRcOQp35w5fGjkyQE4Id6rgwY58tBt2w3p?=
 =?us-ascii?Q?hQ+iV9c+iS+BKFTzvrQzo17i9M8wO3Zz3b85j1fdiJyGc3MNqpzqhyEiemfw?=
 =?us-ascii?Q?wi0E3Ac9cVVIXo8W4V1S2orK91u/wrZN6Q0JXs+9v7/pBEm0e+W76BV92Jpq?=
 =?us-ascii?Q?KmtqQ7U/9/v/Jv+zZviP+j0JK0fb+fz/WUUkORvm1X4gh6mLaNC58BKghtnc?=
 =?us-ascii?Q?ut7Iz6m1b99gs6EcDu8BKMSSAbPZjVLLSwSONihGr1JTN6+mHMTLB+dfqC1u?=
 =?us-ascii?Q?xXCeX1Fp4BakK9wX7CnlgM7AEcXdZhOA4M63S/+HxWY+VCmG9TgZbFBZNgin?=
 =?us-ascii?Q?lvsIQYsw4zmjmHZG5gvu+msXEFSIhu0dYZ2FB6/ZO44K3Ln9RJNrFaNWbezJ?=
 =?us-ascii?Q?66Vb2iNqP/6UccW1v2+mpQCpQThXa+gAWuNVnxyz0Y1t54hsMCgT47k1MXV6?=
 =?us-ascii?Q?RtTgUu2LeTsjJNZpiILGRjsO0cNw3TH8fKhQGOo+GRuGn6NG4hDL2N50ceJw?=
 =?us-ascii?Q?CdsOnnvGxDPHoSi9NC0Fw0+VyacKxXhuPZqcUmGLL8u8jWWcIdijZXZYhSBl?=
 =?us-ascii?Q?+REYUkhOPPi0BQ2KpAYH72v1DbvYMXwqt3IO0tjnup6HpY6Vr583znaXFUBV?=
 =?us-ascii?Q?EVHpS/xHznKl3fjoEoJLyXrtNAG5YSQloK57jBGjwT4lHIH5ejpEfBDP5uTe?=
 =?us-ascii?Q?mwCLTsZTqO+eA3DHF6853EtNaCy9+cy4AobSE4lrtwqXHu3jY/aODAjSNsR4?=
 =?us-ascii?Q?jcEwPziAV+UdlMw0GdYFpyfOA0pwKRGUeVvM9AzHwK94VxoBGpFmLtvPFOuU?=
 =?us-ascii?Q?Y/u2VApatv56EW8f9d+v2y6ghdmoPNijhgciDuFIlMRPTflr/0fHGZkdKeUz?=
 =?us-ascii?Q?TQsJWDZS1eCpun+Mbq/AyMjFF5zD+W1Cv2j1c4SFTOxcSlnxVH0/5m9TFIZt?=
 =?us-ascii?Q?/9QEW1MBL/fvipNAbvS3GO8QwAtw3MzqaxttYE27k+pq/thTeq7zhBViCSBT?=
 =?us-ascii?Q?8oaJY4UOSLqPHQDJOV1GM+whD+Pmd0+4i9sOP+9L7+bG3khxpIKQmqy0/aTN?=
 =?us-ascii?Q?FECVVBLPxvYkEJZY56rrEmUinUNA+zpNBM5Bu50kH6ovVjXLpfrDbhuwJccj?=
 =?us-ascii?Q?4ELT0T/jLoNlwg51VQfpplTQH6EWvgsLEmPU6UlCLE6E7+PvvRGCu/tB6JRh?=
 =?us-ascii?Q?8WbFd15NOhV5s6sdFcMoy2pBpkHM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394560dd-4558-4889-22c5-08d95c09f361
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 14:20:05.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnD+xs6gdejfm1U7GrcvGOH6fPfftsV4I5nDH6XV8UZhZqUUYJskRo/6f8PkIIJn/0M89hue8ABV0W+5+Ic+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.08.21 16:13, Muni Sekhar wrote:
> On Mon, Aug 9, 2021 at 1:45 PM Oliver Neukum <oneukum@suse.com> wrote:
>>
>> On 09.08.21 09:58, Muni Sekhar wrote:
>>> Hi all,
>>>
>>> PCIe memory mapped registers can be read via readb(), readw(), readl()
>>> kernel API's. Similarly what are the kernel API to read the device
>>> registers via USB bus
>>>
>> Hi,
>>
>> I am afraid this is based on a fundamental misunderstanding on how
>> USB works. It is based on passing messages, not reading and writing
>> registers.
> I am referring to the code mentioned in
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1534464348-8227-=
3-git-send-email-pheragu@codeaurora.org/
>
> As per this driver gets access to the Qcomm=E2=80=99s USB h/w device regi=
sters
> via devm_extcon_dev_allocate(), devm_extcon_dev_register(),
> platform_get_resource() and devm_ioremap_resource API=E2=80=99s.
>
> What does the USB external connector EXTCON_USB \ EXTCON_USB_HOST
> devices means? Are these different from normal USB devices?
>
Hi,

those are not USB devices. Those are devices associated with a USB bus
and are to be
found on the host's CPU's bus. This is like a graphics card is from the
driver's view
not a DisplayPort device or a SCSI controller is not a SCSI device for
its driver.

A host controller and associated devices can be on any bus. Such
controllers follow
their separate specifications and how they are to be driven is strictly
speaking
not part of USB:

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


