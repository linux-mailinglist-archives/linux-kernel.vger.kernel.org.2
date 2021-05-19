Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697BF3887A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhESGhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:37:22 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27132 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237436AbhESGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:37:21 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 02:37:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621406160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw4kA/pet+frMQslwIEpZg5UnIVmC9KQfBlEPUQhIlA=;
        b=c/ewbr5SDgI2FQ44ubnWe9UBZJwYwliCQMfJo5kAmBSTtuNMCr6qgQX082gjnp1GbgHF7t
        I6F/ZtEGAjt3s4oPaxBKthvEu3mDfgcqlvsfCbpT+XhJPub75NMlGpx63Ry79KsmO+RPJT
        UNatmCIQxscvlxMS/cJ5KGvYKXfC6WU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-k1uQpaf_P2-fW0BPnp3HuQ-2; Wed, 19 May 2021 08:28:18 +0200
X-MC-Unique: k1uQpaf_P2-fW0BPnp3HuQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5MWSl6shka0LIoPCYbrG5yHTHC9GWNkVYB9zWz0BDY9Gwa+o6V2b8nN289QJKtxTIPUUvtX7pNg+UqhKaWjdzDoIO53PROKmD6US7G8uOgJAVmcaBO8JhhXf2/KpzrAg7XwRn0o4v7ChxXQkosNmNbx275ga05BcuIv+l188wnictG8gScVBFVSDlb3IXymhrssDAeaxJOW978wZK0GzN0zfJM1p6vxF2Ozav/kUjY7oWpUSCoci39Jf9FEyWrDly6aCENTTulEMpDyOfy+xA/EWFhrqYqeDBdslyUds0QAYx0+/O+N66Kfer9waoQdKG5s9WaDYJcJC7EWtGiPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/0O1vZ5IMRdp4+t5Pug4zsQ7h0vIDLE7b+C0SiAQUM=;
 b=bU6GgB1pYF/n9Y2y7hJMKx7IdLDZuBIebuFWlt/xd24MJwh8MsMc33Gs+jjkZDiKmCCPkSgba/gldcsc65NWsI4gyiypjRhWkRXRDuY+505wpqKGZql+ZUyRn6E5SEoPQeXaEQJI/jxU1wl/LPknBo/regJ04ERCne4eL2PlO3dMvEhOmvNDGZ0xY3vGFhgO01Ag12eTGoFWeNfutrUOXOdxQ9cA5yqIoSh4rj2u3cxFOmYaR1809wXWhuv5lfx2/DHP/DPeAIfVzFoLRh3WHRQSQFBi0xM7D3lalWcXD0ACV7w/+IKgHtf8PjFl1jO11v4qcg043lpqs0ih+HpMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 06:28:16 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 06:28:16 +0000
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com, leobras.c@gmail.com,
        Rob Herring <robh@kernel.org>
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <09cbf655-0f13-5df6-b6a9-4a6a784e211d@suse.com>
Date:   Wed, 19 May 2021 14:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0067.namprd11.prod.outlook.com (2603:10b6:a03:80::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 19 May 2021 06:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: addf5601-b55e-4b70-c245-08d91a8f4976
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6182191FF919BA15932E2F84D62B9@AM6PR04MB6182.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAPsfr4jNFZayauX1Q4QtpKRlIVski1EbI5uZKWLErirHplo8k1ip+7um1yAIMuB4qI0XdjAvcQBayNppERwViG4uTCqdCDOsZkbZnMIOtlMfm8RhBg+YuxmbzJu3p5hLhIJFmBbH4dFWhOPQY9ZXUF5KasMxCsRmY5Qgr+Bm6uVpW/dFgOVhemu/BhzMbxeFfjBZky59FiTe73c2j87ZRqZTF4bxl4Rg6/CNw9EDw0QmUZhxHdigKWl+6VNLenzIzihogyG7s+N5GOPE1fTVUO4/vvgY2TqjDB1v/4xen/IyUA/RMmP1hwe0sS7CDNe9I1q38hV7YZvg1OtZzW0sIyk9peNWfxlI+8lxR49EOjt+PEz8T8Jyj6hO/SZVzIKHqaFQOQkcVv649BFdgALv+NE+XE6wZga/Tdk+c4j+Jc7ECjAPGGTP05+0Y6qJ6vsZmrZoV9kAHQ/yksx0Gw0aybqIt+QSa19YGZc7tXdz1AgRLOINc+bEKzjBp70T5op1GIn23PZm1zz4Xd94RcdJAZ655VJgJu3/DtobOojPH0ZmiU9HlmW7N05l0EcGq3GCg1cjAbcIFthQf768GXUSc6Vh+XxcTrG1or5h+CfWOBbEJHXZMAlDCAcsxUFLENNwo9kfA2T0kfu2ZzLu8huFZqWrtaZgzaKfeknU/fMh/R8r1LG5skpZNbSlDB7ASYLZeRqsrKkkDtDrQSQivF5i1tvaldQAerLEjRUJhDOvH9dK4ImM0bhFCUOn7Lc3IdTpIknTmJFoTish80bNAyeq5oqTNAxk5fSIY+hNAFSXW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(136003)(346002)(2616005)(66946007)(66556008)(6706004)(66476007)(16526019)(956004)(31696002)(2906002)(36756003)(86362001)(186003)(6486002)(110136005)(26005)(83380400001)(31686004)(38100700002)(8676002)(316002)(478600001)(6666004)(5660300002)(16576012)(966005)(8936002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O5NHiIGY7e42FELeRuSnsW0Rsc8UjF3MZSGNWXHiXlXJyk+kr24Zll5U8Sm2?=
 =?us-ascii?Q?/erBWOKBMb0pq43AyWqQSxNdPTs2VTPvahalvJnpihc/szjIXHqBUjxGOOgh?=
 =?us-ascii?Q?UDQn3ck2c2F0MDd2OwHyZtCZDE13Qp2Z214mMlRtPv64WgWJg62OltXKsQ5W?=
 =?us-ascii?Q?vpKkP2ToTwQ7D7Tv2ksHTawf7EMx4rZ9vSwqscM8ESODBPsDHGdkSHHQKDj0?=
 =?us-ascii?Q?+er3Vwht34D9srf4TAd+iGql8GJkJmU5TaxFs3zeRm428ccUbzFCyq3+seHA?=
 =?us-ascii?Q?DNwlaiG37LMzTUBsUHkhckkD39SXS60bhv6QsJMzxZhjQfxoXkmmobLX5j9T?=
 =?us-ascii?Q?cmfZ0nLsiiZ6rS7Y4fgX+W6MpGiKSmxThuQRiTMD2Cq62D23LIgKEeuBF8bG?=
 =?us-ascii?Q?gGKixbOmrxL6NHPuOTg6kqiiAlurmLJMygx63kD+8qD1RbFuwbgdubq9VIka?=
 =?us-ascii?Q?PEez2eJD337Lp+ABdaALQdHOQCGTPsnDV6qq/3Kpz6BrMB1F8h86yNxIBGio?=
 =?us-ascii?Q?3uapHdlhMheSlprzFtoqGoVhn8uhpp/xcuh+xaPckZJzYSFvs0pUikfgv/mV?=
 =?us-ascii?Q?HXNN3FkaNH/71QyxxM765fsv/5mnl7zfpGRaxg3NKWwFbzm2BF0dwSP4KaLy?=
 =?us-ascii?Q?u0lQ3va3Qzhp6NXS+yKhVPWstNJZoxmYZFp7QtIArjssMaT87VkDUudRazeI?=
 =?us-ascii?Q?MO7px5fnlFLIDOjqrT0hK0Xz2ZH1ZJ34BIh+FyDT8uCKgDN7wTytvVdmpmhf?=
 =?us-ascii?Q?91PodUbSZBFwl/fbRiXYi+FNvb8RP+CsTUmIu8LY4Cno25GObgqcwX794qKD?=
 =?us-ascii?Q?h/Hfcodu6Yd6P7NTdbu2qTgIimfAhUeJaR0yJLwFtBxm/mU86WfDVlG90Jxr?=
 =?us-ascii?Q?EvbDk2i78DYBkCSHFcoHSjryRv8DlUAxybnzrM6PwvFrtcCQ4M7MEbojVGgo?=
 =?us-ascii?Q?UcANN/xTziisbr+oJCLfVGrbnSM+QWWoZn/ziMpmTQci5AvOYoon8Z4sLAZU?=
 =?us-ascii?Q?DSeCdJhr7mBQZtMDOIFtlWMu9JtSJVhWmIth34HmwSU7lmLN87xSzufb5fCX?=
 =?us-ascii?Q?GTdBt2s5D7glaCl9s20lpLJlL8gdYu2Ds4aV0ruiSyEP6zRXBcZrOejA3Gpr?=
 =?us-ascii?Q?YCi/gYbEsmKk0ZgzqIIyODwG7XzwVwUkBYbViPUBWXizgjvNlHj6U3fvbI9L?=
 =?us-ascii?Q?HK8ugcg6fAhzUl3rBEYk3f4GbnnU1MSGkP4fYF9sHbDLCg9cbx4VoWrH5HN5?=
 =?us-ascii?Q?HEalH0BZZm4JUrclyaoSSRJOlxcI0GgomffNHSrIA17lJ+XKj8wo1B68QZcW?=
 =?us-ascii?Q?RK6tQNNqnn6pKOY6O11iZ3ot?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addf5601-b55e-4b70-c245-08d91a8f4976
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 06:28:16.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBpzCGO2vXJ51vPwkZWD1cteLy8qOOK0HljGTJAd6nf6vMk276/gc21vDtHLNIgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/18 =E4=B8=8B=E5=8D=885:09, Alexandru Elisei wrote:
> After doing a git bisect I was able to trace the following error when boo=
ting my
> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:

I'm also hitting the same problem, with a RockPi 4B board.

[...]
> [=C2=A0=C2=A0=C2=A0 0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end =
is updated to 01
> [=C2=A0=C2=A0=C2=A0 0.393311] pci 0000:00:00.0: BAR 14: no space for [mem=
 size 0x00100000]
> [=C2=A0=C2=A0=C2=A0 0.393333] pci 0000:00:00.0: BAR 14: failed to assign =
[mem size 0x00100000]
> [=C2=A0=C2=A0=C2=A0 0.393356] pci 0000:01:00.0: BAR 0: no space for [mem =
size 0x00004000 64bit]
> [=C2=A0=C2=A0=C2=A0 0.393375] pci 0000:01:00.0: BAR 0: failed to assign [=
mem size 0x00004000 64bit]

The same error here.

> [=C2=A0=C2=A0=C2=A0 0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> [=C2=A0=C2=A0=C2=A0 0.393839] pcieport 0000:00:00.0: PME: Signaling with =
IRQ 78
> [=C2=A0=C2=A0=C2=A0 0.394165] pcieport 0000:00:00.0: AER: enabled with IR=
Q 78
> [..]
>=20
> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource fl=
ags for
> 64-bit memory addresses"). For reference, here is the dmesg output when B=
AR
> reassignment works:

Great thanks for the pinning down the bug, at least I can try to boot my=20
board again with the patch reverted.

Thanks,
Qu

>=20
> [..]
> [=C2=A0=C2=A0=C2=A0 0.307381] rockchip-pcie f8000000.pcie: host bridge /p=
cie@f8000000 ranges:
> [=C2=A0=C2=A0=C2=A0 0.307445] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 MEM 0x00fa000000..0x00fbdfffff ->
> 0x00fa000000
> [=C2=A0=C2=A0=C2=A0 0.307481] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 IO 0x00fbe00000..0x00fbefffff ->
> 0x00fbe00000
> [=C2=A0=C2=A0=C2=A0 0.308406] rockchip-pcie f8000000.pcie: supply vpcie1v=
8 not found, using dummy
> regulator
> [=C2=A0=C2=A0=C2=A0 0.308534] rockchip-pcie f8000000.pcie: supply vpcie0v=
9 not found, using dummy
> regulator
> [=C2=A0=C2=A0=C2=A0 0.374676] rockchip-pcie f8000000.pcie: PCI host bridg=
e to bus 0000:00
> [=C2=A0=C2=A0=C2=A0 0.374701] pci_bus 0000:00: root bus resource [bus 00-=
1f]
> [=C2=A0=C2=A0=C2=A0 0.374723] pci_bus 0000:00: root bus resource [mem 0xf=
a000000-0xfbdfffff]
> [=C2=A0=C2=A0=C2=A0 0.374746] pci_bus 0000:00: root bus resource [io=C2=
=A0 0x0000-0xfffff] (bus
> address [0xfbe00000-0xfbefffff])
> [=C2=A0=C2=A0=C2=A0 0.374808] pci 0000:00:00.0: [1d87:0100] type 01 class=
 0x060400
> [=C2=A0=C2=A0=C2=A0 0.374943] pci 0000:00:00.0: supports D1
> [=C2=A0=C2=A0=C2=A0 0.374961] pci 0000:00:00.0: PME# supported from D0 D1=
 D3hot
> [=C2=A0=C2=A0=C2=A0 0.379473] pci 0000:00:00.0: bridge configuration inva=
lid ([bus 00-00]),
> reconfiguring
> [=C2=A0=C2=A0=C2=A0 0.379712] pci 0000:01:00.0: [144d:a808] type 00 class=
 0x010802
> [=C2=A0=C2=A0=C2=A0 0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x00000000=
-0x00003fff 64bit]
> [=C2=A0=C2=A0=C2=A0 0.379997] pci 0000:01:00.0: Max Payload Size set to 2=
56 (was 128, max 256)
> [=C2=A0=C2=A0=C2=A0 0.380607] pci 0000:01:00.0: 8.000 Gb/s available PCIe=
 bandwidth, limited by
> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT=
/s PCIe
> x4 link)
> [=C2=A0=C2=A0=C2=A0 0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] end =
is updated to 01
> [=C2=A0=C2=A0=C2=A0 0.394285] pci 0000:00:00.0: BAR 14: assigned [mem 0xf=
a000000-0xfa0fffff]
> [=C2=A0=C2=A0=C2=A0 0.394312] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa=
000000-0xfa003fff 64bit]
> [=C2=A0=C2=A0=C2=A0 0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
> [=C2=A0=C2=A0=C2=A0 0.394395] pci 0000:00:00.0:=C2=A0=C2=A0 bridge window=
 [mem 0xfa000000-0xfa0fffff]
> [=C2=A0=C2=A0=C2=A0 0.394569] pcieport 0000:00:00.0: enabling device (000=
0 -> 0002)
> [=C2=A0=C2=A0=C2=A0 0.394845] pcieport 0000:00:00.0: PME: Signaling with =
IRQ 78
> [=C2=A0=C2=A0=C2=A0 0.395153] pcieport 0000:00:00.0: AER: enabled with IR=
Q 78
> [..]
>=20
> And here is the output of lspci when BAR reassignment works:
>=20
> # lspci -v
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Expre=
ss Root
> Port (prog-if 00 [Normal decode])
>  =C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, IRQ 78
>  =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0
>  =C2=A0=C2=A0=C2=A0 I/O behind bridge: 00000000-00000fff [size=3D4K]
>  =C2=A0=C2=A0=C2=A0 Memory behind bridge: fa000000-fa0fffff [size=3D1M]
>  =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge: 00000000-000fffff =
[size=3D1M]
>  =C2=A0=C2=A0=C2=A0 Capabilities: [80] Power Management version 3
>  =C2=A0=C2=A0=C2=A0 Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable+=
 64bit+
>  =C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
>  =C2=A0=C2=A0=C2=A0 Capabilities: [c0] Express Root Port (Slot+), MSI 00
>  =C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>  =C2=A0=C2=A0=C2=A0 Capabilities: [274] Transaction Processing Hints
>  =C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport
> lspci: Unable to load libkmod resources: error -2
>=20
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe S=
SD
> Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>  =C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electronics Co Ltd NVMe SSD Contro=
ller SM981/PM981/PM983
>  =C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, IRQ 77, NU=
MA node 0
>  =C2=A0=C2=A0=C2=A0 Memory at fa000000 (64-bit, non-prefetchable) [size=
=3D16K]
>  =C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Management version 3
>  =C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable-=
 64bit+
>  =C2=A0=C2=A0=C2=A0 Capabilities: [70] Express Endpoint, MSI 00
>  =C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable+ Count=3D33 Masked-
>  =C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>  =C2=A0=C2=A0=C2=A0 Capabilities: [148] Device Serial Number 00-00-00-00-=
00-00-00-00
>  =C2=A0=C2=A0=C2=A0 Capabilities: [158] Power Budgeting <?>
>  =C2=A0=C2=A0=C2=A0 Capabilities: [168] Secondary PCI Express
>  =C2=A0=C2=A0=C2=A0 Capabilities: [188] Latency Tolerance Reporting
>  =C2=A0=C2=A0=C2=A0 Capabilities: [190] L1 PM Substates
>  =C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
>=20
> I can provide more information if needed (the board is sitting on my desk=
) and I
> can help with testing the fix.
>=20
> Thanks,
>=20
> Alex
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

