Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62C4398D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJYOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:43:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52747 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233058AbhJYOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635172852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSD6MNKDFzlVI/UXzMApSPqmQgCm5ah94S0s4rjWOW4=;
        b=KpYE6UyTlPBhboUss+oAxFZHNSSs6k5eyVkutz3fj2yygkmJ68qeo6h+YfJy28PsG5+1v2
        x03ck6n4aBPfwHhNdDticBWrsBoBJNVDnwn8Ts6xQYFT0b8OIgjw/wywNDpvXBikdTUhfW
        nGQeQ8YCKaDUIJbKoiWNoAMa476xXWQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-8kR-Om-3O8GWjLEaXTWCfw-1; Mon, 25 Oct 2021 16:40:51 +0200
X-MC-Unique: 8kR-Om-3O8GWjLEaXTWCfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM0Luu9e5MzJjJvT56PyqXGyuGobPSkeS2taLh6Cdq3gzuAXqiYnXmuiZzZ7Mmj74xVeZGYigqovtj6VwyEiPLzdmv0Gnr8fxoJYOwRZCAnEJVxOF9AIXKW8ZEVMTvYD3do1A9rICpcwtDZdFj0kz90FBAvCWwxoKZiQM/vDyGIv1wJPQ+IVE+i56O+mi/7H4iBb76eV765enmOdewiEeDz/oxzfQmu3Pv8Q2OeutKdENqBM3YRtOHDsQIfcwi8s9sZ4BJcBJhnz2J7T0PnujNq/PjA9oY30ktF89lYyFnF6zQuKGA//gmT1V6jNxn08Jd1F6qOsksAbIbnsi6HtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKIsWqdiG+PqEbZLnaaeE/ilSy9JNFB6uDA6Xy/BGrc=;
 b=Ht11uJpiTKS8MIUUzAVDx4g06LMg8AYm74g5dlVFvAShw4Q/GlNXd49wHtlyjNg9lFlPvFr+vDqhzDbUUUeDLKmpTDosUeMz+FyQ0XJXHhfdm0nd8yIPNW4ax5Azf/zBj38plqAGWo9GAJE/BcZl9kBNpe5yhpX2krpGPY3m4ZbD1+Gy213c1SydStazTkhbuFhR7UanOUk28xggia6uOETzkO2bZ/GdVaM9KFe8wFoveWO8FBWyufhFQFMTam1Px1IeOchwUAFRlZuXX/wTTBfWU/6D4z+3r3f+jMa8OdqrWJ/+3wMHBcLYbPWHZdO1kQSBO1Q/jucFspcvb/t70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:40:50 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:40:50 +0000
Subject: Re: [syzbot] INFO: task hung in sisusb_open
To:     syzbot <syzbot+fd9d03311cdce9a9ec36@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, thomas@winischhofer.net
References: <000000000000c87fc005cef26865@google.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <ade6c05e-fe82-c61a-bf02-8c8fcd918a75@suse.com>
Date:   Mon, 25 Oct 2021 16:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <000000000000c87fc005cef26865@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM5PR0601CA0041.eurprd06.prod.outlook.com
 (2603:10a6:203:68::27) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from localhost.localdomain (2001:a61:3b0d:4601:21ab:d1da:15e9:ca07) by AM5PR0601CA0041.eurprd06.prod.outlook.com (2603:10a6:203:68::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:40:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04a74cf-0626-4403-465d-08d997c5704f
X-MS-TrafficTypeDiagnostic: DB8PR04MB7019:
X-Microsoft-Antispam-PRVS: <DB8PR04MB70194B7926798EDCF8611F73C7839@DB8PR04MB7019.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ki5PmJb0bxrZhWyODgUZQXVLQbRclCxvg5yEaONHK1q3tA5sYRxzkUtGFbvdOfzJQGFToprRr5GkG2CJvuK1Z++zgzyjz7odQ0slpvc4RheWIt3Vbw43g+Xz6BdQt/LfgkizFIo6Q+BCefZXcmDVRHA29l/+lI/coTzDlBv0aeWdi/OZlGLB6SyRjw880sXsgQi7TaY4scQbSvr5leErm+Raqu+UnigfMDJoDMsCjijOYPf/qRo5i3tV4CETP1+AEIcYV1dM7xZNM+gGWIeCLXPX+GK3PSgNIwNMcXfiDARx1X36baWV0aepLqljmvW332/s6JpwpYje64+rjNhtGmJEuL5JREyo3ZXl4Jl+IibmuO/xRpYFTJqcobrFsDWaqQS27r98P9kiIMqzv8Z5PS+cBOCFQx5+roX5B825sJ30aUsehjgycgymoHcxRRYjTwJbkxNNfEkygulYA6nPwq9udghWuAkHLFuU6f3TWALnQ7kObADMQIZxTygYW5RERAmcvyDLVIJEv+jixzaEkD0D9ByWN1V9lug1mPU6TvsHqcrOPpiwSeLwl6j7Hrk4bE/Se7qtF0r8cEqRuKiY0PPqmYdVA4IMh+tnjCozySFqyabLK49PvJJxgHErooAhKn6GOKmOwohZkv7m4QpTpuGsr1rXrv7knQ4ZAb/PvtpQ47yhinfqIMRsqDucPH+tdAVqlHqW4iyAI0b9Q98vTee+fXQtSV/HkufSrFSLkzswSZoSoGHBVX4Sh32WxajphNCCb8DZJhs5HHX5F1YzDnQ2GkKwztIq/riz80gr3zbrQMcHEZmYyQhKx21lhiiVSM0hIhTgihM24l13Cc2FFFnGEHPui92ZoNF5vykf7VI5uphqt4bJBihVKuvO7ybZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(966005)(31686004)(53546011)(86362001)(8676002)(4744005)(66556008)(66946007)(6512007)(31696002)(66476007)(186003)(2616005)(38100700002)(36756003)(6486002)(6506007)(508600001)(8936002)(316002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpPXyDaJCDvJLKFysCo57288ugUs2Afw8Ey7CjTuYcrVWy0FpJoj+kbjbNfN?=
 =?us-ascii?Q?OMaOeb6NVcz1GGEgsxGvLReL/0Y+zd4GROurjWavv0UyzKugaNhR9Bg6p3lb?=
 =?us-ascii?Q?lU1fPLZ15YncB5QlaRX67SZMnEs58ZUcxQspZ5fsR68BeHO0Gm/PFDuqoJAm?=
 =?us-ascii?Q?G5JghGmwM4HrukH1/6cx+3lJxmCSewYFUZkIa357qJB/e5aJPFSXcC531lvM?=
 =?us-ascii?Q?qio2ne0RJxvbx8CYy8mY/m5sfPl6Ym97ip6v3o8B12GT5uEa051aEsWU8dN4?=
 =?us-ascii?Q?XcLxL7YDtQdZsA5aluxiJpcN2DhHEo++1fJIBoFQPzDxYZVrTFflc3nVuM3P?=
 =?us-ascii?Q?6UStGtgUFbAguheJRZ/19Mh2riTDFFgY+y6O8nyQi/mEDK1NjCOON/pWg+xY?=
 =?us-ascii?Q?cdmRDHOoc/UzJOX9BmmS6ROwPITtzW0l5W+Mp4FlEC0Slhwys08YEIrEYAb0?=
 =?us-ascii?Q?mDa4YM68mCwkRlDkVyn3OhPrqsL1T9U4OEPRwVwUp40/iL2U2HwVLVzocmpu?=
 =?us-ascii?Q?hhV/7gcssw6TwJCmWDHQdTdAaDFbW3wYDhl3cplUw3rfW+yppTg4tTjCvdBE?=
 =?us-ascii?Q?j1A4ZDyMcp+9ARqf2JmbiahZZSmG6lrp6A0fU+uKVzepTHDiSNWG5K1jAGQv?=
 =?us-ascii?Q?ESepSY0E3RSdyDjjRcvtbDWj/2kNrLz8oFn5/QvwwOjCH6pFickT4YnmLVUY?=
 =?us-ascii?Q?l536esKOH7FOmBVreRqCBqR2RTXVX3DNNDLjFwQ/IvQz8TEVgW2FS9qEry/D?=
 =?us-ascii?Q?BYhscRmkYL9oHSUbkAnkcn1DIaXZ1rcS2bnNQK6bOTdsZUH5fjKehbkCcbiW?=
 =?us-ascii?Q?73ySLlpNYa2jJ8upqQWqQKDlvPty42hbGssJ4t31IMpVZcHv9ryEGji3M8tZ?=
 =?us-ascii?Q?GCtslE8enpQ4pl3cdyeWXSZyg2jF8Rcq6to6gNGr6FiUyWH3NzIYZA+4pHRW?=
 =?us-ascii?Q?w7HjIvplsZc6GHjwhKva87rcIqgWU9HIFMqzi2LzQ6Lov9/15bidF0Y4sDpo?=
 =?us-ascii?Q?VLpdbhBbnH3Ddcz5tMD76QskPcMzyWWFoBWBoqdIGYJKP6J8yrolOrfAVoE5?=
 =?us-ascii?Q?b38hxiM2q5zSOMURI+vEkcpPV/zCy69j91HIPTtOSwxBjGd2rAQtpunvKtoP?=
 =?us-ascii?Q?8jDIZEqedKui3AVHS84TgWShoJNaiZq8pl3E6g/lflNQDSkqq5J7Ja5RZrrh?=
 =?us-ascii?Q?8u5VvWGRRUvESt3rbaV5tGs5H+3fFXXv+jqFdIqPvodBQwh1D7UVGyfUlWXV?=
 =?us-ascii?Q?46FRCnHReQhr6xw1of9bG9ZL3KT9WuRr6xkTZI8rKWNWb4K1DJotCkv1RJvv?=
 =?us-ascii?Q?JBdw/pmUD83ApdoD4D2MPJoa+e+buNRGd1ihLXcOUQov9IhIWlaByFMl14OA?=
 =?us-ascii?Q?d2nqCg+jJrmb5d/CiS4FoCT9i9bRm/fDuhjtPwCsDpY1beVqIh17ju7tkG+2?=
 =?us-ascii?Q?jpRe01SmqvJFTkpyh+7XhT/sjzXiBsoeLnqBjM/Lvj+0G0MHH7d3mQWsw2ie?=
 =?us-ascii?Q?pvnYIinA8XtfI3nV/ph/Qp+5x+hX9bxnn12bXiiALJPAc2LwPE7QokwaD35V?=
 =?us-ascii?Q?3rLAqWHtWz9EVqkjVKJmImsk2MC+T86jPJJwy+yjtY2nRLkjVDQJSC0XpqRh?=
 =?us-ascii?Q?ls95asbPyHmIo5PaUc5ZE7joZ5TEsjpqz0XuAMuSGa5gxrqAu3Hur31rPFOE?=
 =?us-ascii?Q?mo1jOtmMtongagPeos+JLcxuMks=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a74cf-0626-4403-465d-08d997c5704f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:40:49.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq1GWXmAEP/qoDehjERR0HxLhmMwcNY++/35amQRmWrqVXvFn5vArOVd9gk2vJUxSIsqj91d2yBovm6fgT4MpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.10.21 17:10, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://githu=
b..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15a3aaf0b0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61f4d9af07d3b=
bdf
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfd9d03311cdce9a=
9ec36
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13d4e9fcb00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1444ada4b0000=
0

Hi,

do I understand the reproducer correctly in that it just creates a
device and then
does nothing?

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


