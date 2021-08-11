Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD73E8E05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhHKKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:05:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21417 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236832AbhHKKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628676283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zY7IlNQveS7mZDONl1X1zTg8Sk5luSNcsx4pv8pCz/w=;
        b=FDHns+zZ40YcXe/TnC6VuUJShp3dXUIH7dItNRb92o8yz4mjEWsu2GhV9i6vlC/Ca1rSBB
        JX6h/AbDaLqNscDt93w7DfOTgBvi/pEtEQRsZNCJiHA9wyboqEKKa0T6vrDaqR/GuGxHJr
        jxlGzcgK1RgWAnjvko863cKvkTRuDoQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-j8bKfrjgNreY5JSEjtQoeQ-1; Wed, 11 Aug 2021 12:04:42 +0200
X-MC-Unique: j8bKfrjgNreY5JSEjtQoeQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SObmzXICfc0m6sYyDITd+pn0FUc4S/bh+P9cVU9dkhPl//krAUIrV3WhmyxY060G3tWIDGEsZjVPJxMFPS5dSCXE8nIXw1aPAKvPINCPkAufLB+C+3gsf3UUsL0kJ2/e0WfYzCzHFfgJyNOS5nEYS/w5zHR69UUWFGhSOPrLYEPyj0KpUrBp4KSYnSkiBd5K00lL4IjvG7wiORis0qkPFjeh1DjeA3353qeXfl2czXdVq+UsuyLA1gmjAR9Hz34O263Fr6cZffFUOeo9gD+ZrgUZxFBKGFd7gh318+kq8PBlmgivV8c1xFQjSCRGjviIEhNH16vELmPYN72+rctbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J/Tr3AyUok6Qr6jdvAY7MgLJxu++lwYwVvpgN/TKWQ=;
 b=YwAw5lv9PhBEstwZq3fVNX3SmAWXyOvTE0/fDHY45RdB3SXG5NSAxH8fo9+8Fz0FdWeqxSrzlyBtOawjWKeSUEaL4JphqIWZ6fcVnqMg4ZehDW7vhCAvCDsbPWHCuFkKPGwe1DCylm2ZUfSPMSDn0reNAI/AP9SeoWKNOw2Joge25RqnTMz5OwkPatJLYxUehrFyNV6qrt99N/7NJwOvXSJq5udZBmse1MqGG+jycXZcttKm0atVfMPMcclCMK8Qd6bs0J8QvWfvH/Nqk4aeJDio0kVMpqMzPN0UDBs2iS99h8YsMfRkETkJIfOBINJh85/7FRCAe29uoIkq1O6/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 10:04:39 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::4cc0:191d:5c04:8ede%7]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 10:04:39 +0000
Subject: Re: read() via USB bus
To:     Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
CC:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
 <CAHhAz+i5YeQdJnBH6BvMJ-B0DtoBu9ER4Z79CPOfX5NuFvO=bA@mail.gmail.com>
 <4e7c9279-805c-c236-c048-2b817b1a7c3c@suse.com>
 <CAHhAz+ioThu3v4VW6LVqFn9MhgNaqv=qDoxh8Orkw2LOEC_JYA@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <4ab157b8-5cc0-14cc-9245-5a235a52408f@suse.com>
Date:   Wed, 11 Aug 2021 12:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAHhAz+ioThu3v4VW6LVqFn9MhgNaqv=qDoxh8Orkw2LOEC_JYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:a61:3b0f:ce01:6142:66c1:effb:a0be) by AM8P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Wed, 11 Aug 2021 10:04:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13af83f-5c10-4847-ac4a-08d95caf6e33
X-MS-TrafficTypeDiagnostic: DB9PR04MB8284:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8284DC6AC565B683AD03D00CC7F89@DB9PR04MB8284.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0POsGkkrV95my6xFAGePkrdd3Kspdhdq46h/V4pzlCK4bguEv8zHsbJ4v5AybtLMS2pKW2Cwa01M29QVRYlEKaZreZt40HAopM57UMMRS1B0RIfTD8qLnYCm4s7VeE+yzhypqL/Qa8SV2SovZHAMYTryNNmpBy9trW5r4eCm/tuEuZkLGUCjWHTbX20hXzJb8g46sw2CUY7KIlPM8iEjc73BsupkTX0V5OQ+h9v3XNtHsXkf7InMqsJwU0r9FGjCr/f9pRi3FXEBH43wmU/BO7RinyxctS9KScOQUbMZX4JXOP4+ZewQ32Kk/KcmnlNCYPimLHGWXvzzs/4A8Jqd7esLLD84Y9P1qrvcL9vNNYSIVCifsMugaMeNpXeHkR4Lx8yESED0Rcv/2LvYSPktuhs3UKIOuvyf6Olp8igOWArSx1n4a7Wu7/3M0GOsxqz0Uup42HLkJUXeKS7mqsnJ+bPlIV3qNh9tEZJL8uFdao4cGd15/3sSVoLlS7/osiAg5bBtfvHO+pjNnDVxfYu3C2lN1bhhV86rQwr87r9LGpAf25jmDrwyNa2dEa0hYlaArwpTfNL8IjmqYuSBgCsMeeHC+/VFsra7QhUz49YlSMoPYmknNj1hM7H/IpViE/K8u8mbi5FrUukPVYBVUQArP3aUYBxeXk+ssGGjTzjffGSBAgWYsKMVZDhCs5NAv5UwxICzc30VCV2+N02LWvW1LbpvJMyI+bjY5zrXQaK7DgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(110136005)(186003)(8936002)(66556008)(66476007)(5660300002)(31686004)(86362001)(53546011)(8676002)(6486002)(6512007)(31696002)(6506007)(4744005)(66946007)(508600001)(316002)(4326008)(2616005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8I9V21+d5TD5kKuA9Y76bSQTUJDtO5irnSDXf+V503UpOBj6zT1CrA9+a7BX?=
 =?us-ascii?Q?HWVHlQsOUDkFXdnodGXlRnIf46ELs9O4LTlFj2f7Zpl2TqqAZQ0l0HyT22qA?=
 =?us-ascii?Q?N1SC7b30ngeLCgHGprYqVVMgTzVXfSyjHXhz4co1W1vj/dHSqDyvF57Zxlwx?=
 =?us-ascii?Q?oiye11HgE5m78mFRItpb9dhI1Nu0GI5H3ycPS+aouXYuuY5KKhzg4ZfrEYMF?=
 =?us-ascii?Q?NyXwIceZn4ziejI6m9d8vAtaeJYiMHr7sgZG9s95/NF/sprgU6uM5tMSWgSr?=
 =?us-ascii?Q?3wTEM4McL/ft9YpXetEhyEs2wM7/TdfuRummxWdXimbG4h1VAMWprWK1yWed?=
 =?us-ascii?Q?c7YdcNKJk13Tn1KA8G3BMRIDGLPZGRm/l6GuI+Moby3v8buSOrEJcj5x/z/e?=
 =?us-ascii?Q?m1934ZjepgiyRTkKBZ8I6OO1UNBY/GJgjLubuoNRwBqswg6fLz7u5m0d5QEh?=
 =?us-ascii?Q?FXjSk8clh1zLpicJ6tqFKaoZai3zWFP1nAYn6ykA8tEymJPv9cSMXdnJ5EuC?=
 =?us-ascii?Q?ntcWfxikCWK0kBzes8gTxFR1ct+dvOlYZNqDZ/YAFPFe96VflQTmTyZh3wDm?=
 =?us-ascii?Q?iPfEONi+AhBB4EOXoDIipQn5t2PaUXce8L/Iaqf3i2MFIrzdYi3zurL51NMf?=
 =?us-ascii?Q?mEzpWyzC0E6ZQcq0lLnWa94WdCLismxj/lG6oSgXTruYMo+L2uiDf16N+nRi?=
 =?us-ascii?Q?uIr3ytX16Usrad8Ml0sraPocJBuYOvSidUlfZJ6P58M+PtGOF3+RF8nv25G8?=
 =?us-ascii?Q?LDM70qmU60LR3Z+Zi/XRk/xIjHPuZQ93qhBk8xwbYoar5ZWI9s8E1CmFMkLQ?=
 =?us-ascii?Q?WBr92FoMHD75kE//IN6giWeZMN53YWiJCTLfhqEqSUr1AKxZbgPsrVS+9z1p?=
 =?us-ascii?Q?q3bDF/AXIZALxL/eHlwFem5iSTkIeSkWNj4RcfHGXmmGd66vp6ckOiLDdF/a?=
 =?us-ascii?Q?FSsHSirwx45upmG6iGU6nw6EpcRrDUy7p/VstjgrnLMkiq1wVLmRXcs8FBfR?=
 =?us-ascii?Q?AEmS6bj4+QL0W+3r5/jw4NkjSDV5uP1jB2pTkZpcMKjS+eV+qRPGG1EYRkr5?=
 =?us-ascii?Q?42mqiIkPPzoC3bH5nRH7mr8Vcb78fQUr80so71+FsRn0m4YaFR6Cp1jxSYh6?=
 =?us-ascii?Q?Vh48yOVpks43hkRfm40L2gNaEsBE87W6IjXjgHQBkFrHzb79Xwqm7lyzSMA1?=
 =?us-ascii?Q?eB/ez2b4xu7BEItHPj7XLBJlHcyaHGmu3Htyef1PTMR9FnuORp4grqCaqHq+?=
 =?us-ascii?Q?VKgTF9giyp93dt/4e924nGv45oqILaQN0qpP2HIEjSFIFqcnZeX1rS7l2uQh?=
 =?us-ascii?Q?0LlIheldRocRGyMW/2DuP60YjzxoN0CPUY7J6n6O1Ayyd7Wurip050fvDreG?=
 =?us-ascii?Q?pa7PptPaRnN0vuPyo1BCBGTQFNry?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13af83f-5c10-4847-ac4a-08d95caf6e33
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 10:04:39.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzrdaRZ2EcpKOn6aYYCtJI/Ewt6LPFJpwzfcqRWYgGUdMXGNIUoqinzVYaYBWwIXz7upca6OxW6GNLJ2CetL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.08.21 21:27, Muni Sekhar wrote:
>
> Any other examples of devices associated with the USB bus? Do we have
> any reference driver in the mainline kernel tree?


No, not really. We have the debug serial drivers,
but they are associated with a host controller
as such.

> Does lsusb reports these devices?
No.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

