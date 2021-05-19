Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A7388C81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbhESLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:17:57 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:57767 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346088AbhESLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621422995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBIUu7trt3HwmZIOvlaFm2CzQza8mOD8eot3YwQaPOE=;
        b=DWD7y2n/RdZM9OZQH61CX0mDssgVdWSaf83kPG7ATuzvRY8VpijKNYyovW/0BnrRclJB23
        tqzI5rJuFKMLH0Qj2rPaDnyq+nCkwJqvklG0gpGk1vSR7tU2IbVs8I9mV2hyEXcbqPSthQ
        rzb7DmOV8Y4/Dx6v9/h8eCcly+6JRkg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-_nYteAg6M1G6n2N8VDtwHw-1; Wed, 19 May 2021 13:16:33 +0200
X-MC-Unique: _nYteAg6M1G6n2N8VDtwHw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wma2Hb9FGxHculKdldbDSC0iuBKQUbla96BS8W2mQfF8hM6DSYG90bGDlKN09j8UdKbAztO66CrLmQtrJkIcKknHZ31Q8tnAdrDgVADPx4OcEVYGZr1MuLopuEtKg4bLrNAVhkx+iZMWbUXf/vIDBoTtNRfu1EtzXtFDSZ6VHXPIBjvvNRh9KN9+DiTleX+fMCgUQ7PXLgDcBBcz9fe5l8pVMtwwhHdC4tTDhclJjKYb+ohlh36xJS/cj3mKTvJPCaCokVCkfo+bd3Hd0dMntqvBIrSKF4VIaRFkUcvorVg9/dTH3Vio5CXB8Y76vLJ6HQKl3GgA1ZXQrNCxNFmA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7BpKJ4SaHrQU4FfahO8+3N4wmb/XxYAQOWnzB3hl6s=;
 b=Tnl59IKhMvTUg5dgEBaA8PqrvF5u4EvneRYhRq4NPsN2v6+RD0YoJFCzG9Iu3WtbK5WG+ySmqaFLsZt/Sji0sXY1k+FUfUsOmCzh2mc1sPVS5KbXgfYoeoArOWsxSbT3+GH831XgoPKzgGWtfv/tdVJ9Yd+fevOdNuet1tKUz2AVFW4n18pL4TqB9V0aNgKbPBq+rh3AIZEUlVjLp1igbbr1cFKTZCH/K7Y/OAu0uRCYJbF6HPtZ2uzVyt10AVETsyUSsA7UUnN6ixbi1XRNYo1PxbBgXLwwnxEIKOLJRBhFepxQUlLcLQx9rPbpB9xOAiYhYG10BFOmH2CaPAIcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3672.eurprd04.prod.outlook.com (2603:10a6:209:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 11:16:32 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 11:16:32 +0000
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
 <09cbf655-0f13-5df6-b6a9-4a6a784e211d@suse.com>
 <94fbb521-d045-3c2e-eeb8-4029e1f92015@suse.com>
 <d754c000-7eb1-a8ed-33a6-238171a68c87@arm.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <8a496713-182a-aa8b-3e5b-e527bebc7b03@suse.com>
Date:   Wed, 19 May 2021 19:16:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <d754c000-7eb1-a8ed-33a6-238171a68c87@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0056.namprd11.prod.outlook.com (2603:10b6:a03:80::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 11:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192fb479-384b-4754-15a5-08d91ab78e97
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3672:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB36720BA26C9185CC236D4E0ED62B9@AM6PR0402MB3672.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu5LwHH4YHs2KQzsDRo1glPdHBes2Vudj35k6msSwzk4J/RhJHOtt3iGzcD0plvD2Qf6lFkbMdrhhYjCcMfcl8FFjtYPr+bzvyU+WnlQWOVmze3YBmyK8rfJ9qcRcDM/+CTE1plV/pZncTa7OxbuWnt/SuHLP2MpYKM+2nUDQ4Mp1Tu1dAdu/UTT3oUH9D0w9+8Ec+fROoJL7hhXKUykFHa9pL6q5F6cBJ0d2N1y5SiYs1Ze0VmdRedKziTgCFdik+X325BpLBuIAEP/QxfouKjT/vq8ahm0uHK2KbcUbibfk3vcZsOQ7e0JfSSkweeopESogxVUaZ8M19Fw84eV+MXq51zL+V5mFbASbtRFANy8ZeDekpH15Sk0wXVg785HJqAcgbKl1Du4OUrZFBnlHBXOURtUbVQCDs7qGtrWjo8mN52DIPRQDuXZYMnsSGarRY2ug6Fqhs2S+sb36/rSbBsqYwUDHSpk84+OCndp9vUBZCnXWHI3zBrAC/ApL8kRmkBW1V/9HIOVpypV5X1NdX9wwf+lgj9RaFTz+6Sbt7aqN7cD4Qlyl+nv0FUXPK9jEeKXPi5nOqGJLNtRgOW4lbE2uNaQzhvLY8rrImHJwUhTzm04DrpC3xFab8LsSO1FgOIzYgX+isg5TbVGZpJSQePyAWw9UmbsLv5qBsmu1M3LJ6uXau9fkWQCN+3Vh8tY75UV8jtU4f3Ygo4rwMhZnKfUZXArFibXVchGVA3bAbgIfPIX2HMQJc4Ntm9eSUCLhqLyrMZS6dSiyMsE8ZNQB4Fdm/V1IIKuaxXT0XhV0t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(5660300002)(6706004)(6486002)(86362001)(53546011)(66556008)(66476007)(2616005)(26005)(8936002)(2906002)(966005)(31686004)(186003)(956004)(16526019)(36756003)(38100700002)(110136005)(16576012)(316002)(6666004)(8676002)(83380400001)(478600001)(31696002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FzbOZeaK+m8TnmDX5XAl3FXGgPR2j0vRmvvizp6mmLszqgLlB/dxQE3njfxO?=
 =?us-ascii?Q?qRz3es9+3FBlRBH/Yb81oBR8BjdEAPX2Aka0cSR7/5Q17DmYhlkjyXbeYmTF?=
 =?us-ascii?Q?KsO2aA3reg4GjfOPEsW4O6K7negBfTtNxRTOm9yVHpgar1AyrWWFA5dAP8Ey?=
 =?us-ascii?Q?LR3MBSLKCSsQHCA/Pb5uF8aFabyAhGDgbWjiJFL5PJp7EzhSvYOWar4xM/iA?=
 =?us-ascii?Q?dO1TtESFqnazOPV0DVZDB2q6QoWm81alYKEQ/xbmu/Kjh7R2PR7R5SAEmW8D?=
 =?us-ascii?Q?39n3UBtMhEp+B05x7/1IfiLcj832IJUSW1wsa+QKNvzHQp4V40y5GZFcv19a?=
 =?us-ascii?Q?y7C69UAOuAyfuODQBP9LSNLD0/JYDBySq6qUHUT7uGjOy7yfERLi40Y0+rHe?=
 =?us-ascii?Q?RvOP9KskmxEamvIKGYilWub33XW7H9gH1LHRAhpU/VAjHmz09S6c0zSNsJJ0?=
 =?us-ascii?Q?pjjDB7GsdX8T3WfnOeSYisMtK6RhinmyDe+dS6YpHSLtkA7njvKovorZBSfx?=
 =?us-ascii?Q?xKl8YRzApQQ1mcPlNUJDCZgNwP2td9xbMAn0gSoP+RKqtJwY3U1WM/qnil11?=
 =?us-ascii?Q?TmIplBWburN5HF976ZDRwUTVe3oeEC12BdcX80/ohLrz/4jC9Essk3dhIBvF?=
 =?us-ascii?Q?94U+2rf7ftbAiM+iFrqhEt1+P924WI3DQpY1QWWS+wwmN2MMEwXkmpRklnlQ?=
 =?us-ascii?Q?9om16O3roYcDB/j+zbGh7MU9agKXjtFbqWDJTc3b824ZiSG3lxnhqtTYwQlk?=
 =?us-ascii?Q?vtYXF/s6cUzBB477d3i3X7Bgc0x/dQLGrGEz6eBToMyecDLEo69U6LNqGh3v?=
 =?us-ascii?Q?tnRFCTVqp6exVv/z72Uup7iUQsHspnE8FHgY4EPvtDjVAbdUjENqvPUTKXzp?=
 =?us-ascii?Q?jZLX1pkCbKZjrMhvfmGWQ7XDqH4mdi3o/w7JDhvocbvrsXGSg5t1jMOGDwhJ?=
 =?us-ascii?Q?a7XOR5GcKmRj01PTzIG1J3lPz8BDSXsVITFSUvnF0L5R7o/O8czrWmpxKpuO?=
 =?us-ascii?Q?C3NQnQjFg5gs7raVejs/OUFRUz+OzjLvNk8k3wLJAJMfVoG1ksFan5EUhjAY?=
 =?us-ascii?Q?9OJc2AzvfeEODBwdNM6q2wd+vSWmKV8OsPgg7CtgrChbPVCL23kdcWXTiEx1?=
 =?us-ascii?Q?3i8pQHS2+91+ZENfrSy+w26/4zbmJHLfNfDZAo37K28qZkBlPtfDPgoLPVLZ?=
 =?us-ascii?Q?3B0g350+Eu14meYwBCtQvTO1BCR3bghTeggkJ8tNnMdQp1n9sSuhxO2tG4Vv?=
 =?us-ascii?Q?iLBgcrXlC3e1AN/6B2DzsM/b0l8KwEYYMZrPCJ+v+Nx91TzMYcihEl7VmJzb?=
 =?us-ascii?Q?soFmgiohh/F6rN3CbTqsau7p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192fb479-384b-4754-15a5-08d91ab78e97
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:16:32.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPLNNRNBIK/mpHR22Bof6qadoSSKJ25jtnF1gGcq7v7Ispd4DXImqze6pG7/XMtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=885:20, Alexandru Elisei wrote:
> Hi,
>=20
> On 5/19/21 8:05 AM, Qu Wenruo wrote:
>>
>>
[...]
>>
>> Is there anything special needed to boot the kernel with that offending =
commit
>> reverted?
>=20
> I believe this is a separate bug which is being investigated [1].
>=20
> Things that I tried:
>=20
> 1. Reverted the offending commit from v5.13-rc2, kernel booted.
>=20
> 2. Checkout out tag v5.13-rc1, reverted the offending commit from v5.13-r=
c1,
> kernel hangs during boot. Didn't clean before building.
>=20
> 3. Did a clean and rebuild, kernel boots correctly. This seems to point a=
t the
> regression [1], since cleaning was one of the workarounds reported.
>=20
> Another bug that I noticed is a kernel panic on shutdown, but that's unre=
lated to
> the offending commit (I'll try to bisect it when I have the time).
>=20
> [1] https://lkml.org/lkml/2021/5/17/2284

Awesome! Thanks for your quick mention about the bug.

Indeed after a clean and offending commit reverted, now I can boot a=20
v5.13-rc2 kernel from NVME without problem.

Thank you very much!
Qu

>=20
> Thanks,
>=20
> Alex
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> [..]
>>>> [=C2=A0=C2=A0=C2=A0 0.307381] rockchip-pcie f8000000.pcie: host bridge=
 /pcie@f8000000 ranges:
>>>> [=C2=A0=C2=A0=C2=A0 0.307445] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MEM
>>>> 0x00fa000000..0x00fbdfffff ->
>>>> 0x00fa000000
>>>> [=C2=A0=C2=A0=C2=A0 0.307481] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 IO
>>>> 0x00fbe00000..0x00fbefffff ->
>>>> 0x00fbe00000
>>>> [=C2=A0=C2=A0=C2=A0 0.308406] rockchip-pcie f8000000.pcie: supply vpci=
e1v8 not found, using
>>>> dummy
>>>> regulator
>>>> [=C2=A0=C2=A0=C2=A0 0.308534] rockchip-pcie f8000000.pcie: supply vpci=
e0v9 not found, using
>>>> dummy
>>>> regulator
>>>> [=C2=A0=C2=A0=C2=A0 0.374676] rockchip-pcie f8000000.pcie: PCI host br=
idge to bus 0000:00
>>>> [=C2=A0=C2=A0=C2=A0 0.374701] pci_bus 0000:00: root bus resource [bus =
00-1f]
>>>> [=C2=A0=C2=A0=C2=A0 0.374723] pci_bus 0000:00: root bus resource [mem =
0xfa000000-0xfbdfffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.374746] pci_bus 0000:00: root bus resource [io=
=C2=A0 0x0000-0xfffff] (bus
>>>> address [0xfbe00000-0xfbefffff])
>>>> [=C2=A0=C2=A0=C2=A0 0.374808] pci 0000:00:00.0: [1d87:0100] type 01 cl=
ass 0x060400
>>>> [=C2=A0=C2=A0=C2=A0 0.374943] pci 0000:00:00.0: supports D1
>>>> [=C2=A0=C2=A0=C2=A0 0.374961] pci 0000:00:00.0: PME# supported from D0=
 D1 D3hot
>>>> [=C2=A0=C2=A0=C2=A0 0.379473] pci 0000:00:00.0: bridge configuration i=
nvalid ([bus 00-00]),
>>>> reconfiguring
>>>> [=C2=A0=C2=A0=C2=A0 0.379712] pci 0000:01:00.0: [144d:a808] type 00 cl=
ass 0x010802
>>>> [=C2=A0=C2=A0=C2=A0 0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x00000=
000-0x00003fff 64bit]
>>>> [=C2=A0=C2=A0=C2=A0 0.379997] pci 0000:01:00.0: Max Payload Size set t=
o 256 (was 128, max 256)
>>>> [=C2=A0=C2=A0=C2=A0 0.380607] pci 0000:01:00.0: 8.000 Gb/s available P=
CIe bandwidth, limited by
>>>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0=
 GT/s PCIe
>>>> x4 link)
>>>> [=C2=A0=C2=A0=C2=A0 0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] e=
nd is updated to 01
>>>> [=C2=A0=C2=A0=C2=A0 0.394285] pci 0000:00:00.0: BAR 14: assigned [mem =
0xfa000000-0xfa0fffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.394312] pci 0000:01:00.0: BAR 0: assigned [mem 0=
xfa000000-0xfa003fff
>>>> 64bit]
>>>> [=C2=A0=C2=A0=C2=A0 0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>> [=C2=A0=C2=A0=C2=A0 0.394395] pci 0000:00:00.0:=C2=A0=C2=A0 bridge win=
dow [mem 0xfa000000-0xfa0fffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.394569] pcieport 0000:00:00.0: enabling device (=
0000 -> 0002)
>>>> [=C2=A0=C2=A0=C2=A0 0.394845] pcieport 0000:00:00.0: PME: Signaling wi=
th IRQ 78
>>>> [=C2=A0=C2=A0=C2=A0 0.395153] pcieport 0000:00:00.0: AER: enabled with=
 IRQ 78
>>>> [..]
>>>>
>>>> And here is the output of lspci when BAR reassignment works:
>>>>
>>>> # lspci -v
>>>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Ex=
press Root
>>>> Port (prog-if 00 [Normal decode])
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, I=
RQ 78
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D01, subordina=
te=3D01, sec-latency=3D0
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 00000000-00000fff [size=
=3D4K]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: fa000000-fa0fffff [siz=
e=3D1M]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge: 00000000-=
000fffff [size=3D1M]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [80] Power Management version =
3
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [90] MSI: Enable+ Count=3D1/1 =
Maskable+ 64bit+
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable- Count=3D1 =
Masked-
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [c0] Express Root Port (Slot+)=
, MSI 00
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [274] Transaction Processing H=
ints
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport
>>>> lspci: Unable to load libkmod resources: error -2
>>>>
>>>> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVM=
e SSD
>>>> Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electronics Co Ltd NVMe S=
SD Controller SM981/PM981/PM983
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, I=
RQ 77, NUMA node 0
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Memory at fa000000 (64-bit, non-prefetchable=
) [size=3D16K]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Management version =
3
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- Count=3D1/1 =
Maskable- 64bit+
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [70] Express Endpoint, MSI 00
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable+ Count=3D33=
 Masked-
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [148] Device Serial Number 00-=
00-00-00-00-00-00-00
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [158] Power Budgeting <?>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [168] Secondary PCI Express
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [188] Latency Tolerance Report=
ing
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [190] L1 PM Substates
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
>>>>
>>>> I can provide more information if needed (the board is sitting on my d=
esk) and I
>>>> can help with testing the fix.
>>>>
>>>> Thanks,
>>>>
>>>> Alex
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>=20

