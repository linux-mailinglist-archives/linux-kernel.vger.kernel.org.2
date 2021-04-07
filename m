Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8A356C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352146AbhDGM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:29:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8089 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhDGM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617798554; x=1649334554;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k3xBWZnNhuVibyl6ejaXtPkwGwiq4ETtj/asO4Cndck=;
  b=Lc+bHvKDtgwi926U7+Znu/O7Azrkj3mxi8vjq2o0e+pR3yV9N3pFWE41
   H+d7+7/v1+/rdN7x5nFa5ja+YbcQCWiEMc5v1383bZLKx98qmQWAVKA2+
   vkztgFYFtUK5MtNhhuVf5ejJX6COshURoJ2igrvX+uCmuFBqhEhH/W+/6
   seNAIrO8HVZCMG7sXLRw4w5DgV8O/ta43NuSM4Fpf3uruq7VzWr7Lmk2T
   HfXDgKszF4SY24VBA5QzPMUYAhTK0Xp7e/xX/B07IPyYMxAwfSiZqzBtg
   jY/v0mw9q5oWIlD1YTIWECkKGDNwD7TPwaaOBWiJXN5HEix+LAguWhpav
   Q==;
IronPort-SDR: QrnEcWLWy5zMGeR9zOzdL8FmVSy+hdDQsfmw5cky2eYQ96jYDTcbu60pytDngWV5LGepd0xtg+
 ms9NUQ09BxogX7BgzYBLDFIzs9jTUXlwugcIGqbI+amhjNgNoL5LAVvJwNV7wzUBTCFhsKojxR
 MI9hnKpF/dnYUGgtS4sjwUUbXnh6nlMpf5w1BtHmRmWot/1iBTooHPY6sefc/ImT1vM9Wjm9A4
 f3/M0m/+3dcbGHj6d3Fbwqm57GarCUCqiFaFhPWVLy4FUcq/s+pl51USCcPGqy6j3NpvfeRgfR
 VLw=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="164064112"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 20:29:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtLdpGcPky+zzfVCaSlb0IeUqnvRIaxMHeKnRZZR7S3YMnOxeq8mXgbVEtHfgbFFemxljFhf+gv1zbGgsIbQlwG8qwi4lRm/4KOeyBnZyOgd+qQCgiuSrAeHF4VKKB6qeM65dxR2nfnKtrC6AdO4qqAzRR/GsZn+l1Bd24yyKPb8ZgYnb/7ndAKkogaHtlQAqf2/JttpWTjr06VQ6ryFJmNgLydvvwKYQdVBtEz3VVzWUNInJFHLr8K33hlFyeFZeRZEQ+G4gzZYUCmbc8PxU5IqMgWsEL+55wO81533LkA6AWLVna6U2BHhcluiQwxPROr4iS9kCOmYLo5ZsqMZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeGM6G5NIjarWr9ZFKowTYq1wzangq6+RQUaR9qSQiA=;
 b=IUv/1AwOCHtnl7xrneBDurgYwSWoceyUEiLCUKLoW9yeXsdJtGk52XVZw2kSTKy9CFrEDdzSY9MznlTvx/cR3XKxJwihOhoVXIeMvwKGY7W3QQpwWumSN0yX8tp7DpSo8qSetUW84aqW3WsQCXXOYHS1TrIBfb9kR2EkHs3woVfg/I/1/GfHGo86XKtAl6aVReXCUtI6eGjOQ1VIVd2imRjIcaVTFGTHb7hlC1fekwOUNUsvqk0PCwDjAdhZB3pxLkVYAX1fhovqttTbHLNMeJ5oz6kc7Gwwjy/AG0ZyKHLH/XuTT4yfcW/9bNxfLLlIQ2AND1ZaXBTwyQjeP1CD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeGM6G5NIjarWr9ZFKowTYq1wzangq6+RQUaR9qSQiA=;
 b=fSRtQQTlD3q1M0pBK3tppiWyeT7+kFBpjzaNEfnm8CFDNpEUZEjNNKzfmw46ZrfuyW7/+nHnFBnmehqNWHCsTux42/t9RygTfiM3XfPqr1pcn2J5XaS41M5tMHL/JMljUp73oFC+f3JM4Q9lpgzGZxVCTuH3yrO2KgwYkHrBgsU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7008.namprd04.prod.outlook.com (2603:10b6:208:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 7 Apr
 2021 12:29:12 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 12:29:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [null_blk] de3510e52b: blktests.block.014.fail
Thread-Topic: [null_blk] de3510e52b: blktests.block.014.fail
Thread-Index: AQHXK6mdYy0b2r7TZEO50jg8+Qg5bg==
Date:   Wed, 7 Apr 2021 12:29:11 +0000
Message-ID: <BL0PR04MB651491ED14D710890187B3D1E7759@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210407085942.GF22260@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f060:aa0a:9ee0:dfa8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbfbdbb-4fd4-4cbd-3037-08d8f9c0bfcc
x-ms-traffictypediagnostic: MN2PR04MB7008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB700865770EAD7BEB1ADB6FCFE7759@MN2PR04MB7008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhgOCQsM3NwL4AQuAuqkLPP3Ooz8XNEh+nruArK4hD1aMeme1EBPiIeYNcD+kAzGf1McLkkBCtwYO7MiGTtaKUupCLts/70YsdOTz9zRZ1nz+h6UQC73hLzXH9KJPdxDoDqUJZwzLgJOnVLtVf8GKyK8PMp8tO0e6xC1X2lRRLWtThvm3z7E5h1fhWwZGFcVf9VWHlXezhgUQDEHb3tef9r+9/a7jbkhHSHA7BV1MPLomZbi7dMb+dwfZcpEHijLqTQWCtZ1i9pO8Pv9TYW4WQDqhMn9ECfuKpQwRWJi9zOnmuWQBLw/q+MVZdjW9EeBmII6rJEiKx2hP7DwIiJncIvH3DCOoQab4f1NG5x1FMexxJKA/v7r4+mGBCx3DmiYUDaEX94prZQ5B6847eszZc+rRFP29h1LgPXLq5IcOvoQgVAGS6m1FhZu3iWYzXEz/6iRw9MPKfOPUy61byFZ08lDsjpKAEi+wZ0soTuvnE60HI2TGyY9IEgj0DITyhS00269dimLDYGavz/P4TGDqt5EbtmcjEThqKsoqDcel9z0BKEjzJBdhUQ+nFtc2dT7+0ufbhJqb9O7EeMANpoGOSr05HrgnZpRpuN4rexuuSPHvkOkQ7nPSinWmRJoGRCBKfiwsDH2tVltrZDfWDORqSaQL1OXsbrXrRvJloa1waxmEilIq9xjzu/2W21BOdKicQFpXaBCTnS0eiqyPrpfLTZ9qJZwnXlV6xYl8DSPdAOiM0it7fk9IwnrHVrUIZZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(76116006)(66446008)(966005)(6916009)(66556008)(66476007)(66946007)(91956017)(9686003)(64756008)(86362001)(478600001)(7696005)(8936002)(8676002)(6506007)(55016002)(53546011)(38100700001)(186003)(83380400001)(71200400001)(5660300002)(316002)(52536014)(4326008)(33656002)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6uuMpsD5bNyrjKCq6K81Z6siD/ZNqESqNe7f6L5ZKAqrmBHviylq5Lrtk+7J?=
 =?us-ascii?Q?n6MovftWP9qQ+xYistmzfbPahdlZEZgs3MVJ8ucm7RPz1D/uhwS4WwZm8NUe?=
 =?us-ascii?Q?n+TFbMv9p7kBlTNEND7/1BESosdmmJoBRfuDHeuj996e5GTUejOyDgrqkbII?=
 =?us-ascii?Q?P0WUFO4h0SjRAqzF2UJlecnIOmG/KqP3+LWQHSPi8RYCkKjq+fcVjm9KgGFz?=
 =?us-ascii?Q?Aibr+vAK+QnG9jpS0nYNrErpyfTl+HgBgtf3CTUOkpdtgZXOTNqzmqm2sXgy?=
 =?us-ascii?Q?PPE71WBixdsAqgzDK7cQJB7YxATYGNRdjMxywm4dXGTrgXOOQgHEHtjiojz5?=
 =?us-ascii?Q?zWPvaQhYSuYIkxa6MIIUGZa4aNA94i9UPoK/yLiPEDelah39w7M7ShVzFuIP?=
 =?us-ascii?Q?K5ib7Dl8V4Q0+C+W6+bg6TJt4+70OgG1vwcKjwexX1/k/VNAyy9VRsPGxHS5?=
 =?us-ascii?Q?cOb0OfL71BLKD9XHa+ergdrkSgXN6/d4e1icIhkDcfDhxP9/LEKed2osAPNQ?=
 =?us-ascii?Q?cmTls7huv1ddIr6iqza8/C6Cb2hE21X5wDWxYho3zPtiJA8ysyGVe4+eDx+E?=
 =?us-ascii?Q?cQXpthz85SjcdoqvpZc2wY5xHz/DRNuMBU4RKSGKQHeFN9Wr1RNgx7QePpaA?=
 =?us-ascii?Q?FfNN+cH9RP0IiUvPX9bbDTl1+9EdHoeaVuR7i56V3nLtHwA6mnRLLV7b7qjJ?=
 =?us-ascii?Q?RLlUzEtEAu2t5PLxyeWSWnH1fRmnFQHAcoST4cvn+mSxCcPohDh3O7zkS/WX?=
 =?us-ascii?Q?AfComgbJzvZFKqyR7qzlW6f0gjjTs2WFPWdEbUEGExTeBBFDkECblmpHySAn?=
 =?us-ascii?Q?OcMioYeSw0t3g4pqg+6JgUS4ZYrz/Fg27BKZoh4sLqkpzTh/05ylNgf+CE4Y?=
 =?us-ascii?Q?jOJan/69j19zApDhTThOziyCntSdk4LTyLZdZSxgc5VxKvSWNaRROBvVUemU?=
 =?us-ascii?Q?sFnn/59a0Wz56nZZEnjbY5IfhpvQkDt9uDzqIwkKhwBJLyygH/zSkskAOz4I?=
 =?us-ascii?Q?mydDpvO8bBpvJH9Af50bJ5Nk8nODwXpzg6EpBsugwz7VG47EuDniOebB8hL9?=
 =?us-ascii?Q?H0S00ttAJNjGKlZjT3z5KJIR63G1OTUelZmkiN5Gtf+d8URdtBQ6AV0DW7Mz?=
 =?us-ascii?Q?sRdKu8ZrFF8jSz1Q/4oFYZeiBcvXPUbz7HF41tlefcZ27YiFieoKHu74FDEi?=
 =?us-ascii?Q?oJQ9cXLGcWs5e0TRGXGYwrBfCnydNT6OIueDeKwyMkgw6BKlRAtX1GHd4jUz?=
 =?us-ascii?Q?EFZYw1J1ox7+RaL0pdBDKnHpoJoQ8OMMcS41wy68f1e2lu45i6LHVQ2nj9z7?=
 =?us-ascii?Q?0iQjXXwd/onXAlwRIshZ7q27pVssIwJGCEeAB5QRhXjvkMgHhaPcN6MJ71zW?=
 =?us-ascii?Q?OTgWWub8fxR2aZEJmXx37NPP4IDz2PPHvezf4Qqf/jsJ6F5YMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfbdbb-4fd4-4cbd-3037-08d8f9c0bfcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 12:29:11.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xroX0J5+snuS4bVCUROvTEOrGFboxwJjqAha0d3iShj2q1zKs/HP2lJpMhQV0PnXphwCTPUn3keIUwPVz12cqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/07 18:02, kernel test robot wrote:=0A=
> =0A=
> =0A=
> Greeting,=0A=
> =0A=
> FYI, we noticed the following commit (built with gcc-9):=0A=
> =0A=
> commit: de3510e52b0a398261271455562458003b8eea62 ("null_blk: fix command =
timeout completion handling")=0A=
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master=0A=
> =0A=
> =0A=
> in testcase: blktests=0A=
> version: blktests-x86_64-a210761-1_20210124=0A=
> with following parameters:=0A=
> =0A=
> 	disk: 1SSD=0A=
> 	test: nvme-group-00=0A=
> 	ucode: 0x11=0A=
> =0A=
> =0A=
> =0A=
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz wit=
h 80G memory=0A=
> =0A=
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):=0A=
> =0A=
> =0A=
> =0A=
> If you fix the issue, kindly add following tag=0A=
> Reported-by: kernel test robot <oliver.sang@intel.com>=0A=
> =0A=
> =0A=
> block/014 (run null-blk with blk-mq and timeout injection configured)=0A=
> block/014 (run null-blk with blk-mq and timeout injection configured) [fa=
iled]=0A=
>     runtime  ...  71.624s=0A=
>     --- tests/block/014.out     2021-01-24 06:04:08.000000000 +0000=0A=
>     +++ /mnt/nvme-group-00/nodev/block/014.out.bad      2021-04-06 09:21:=
25.133971868 +0000=0A=
>     @@ -1,2 +1,377 @@=0A=
>      Running block/014=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>     ...=0A=
>     (Run 'diff -u tests/block/014.out /mnt/nvme-group-00/nodev/block/014.=
out.bad' to see the entire diff)=0A=
=0A=
This is not a kernel bug. It is a problem with blktest. Before my patch, th=
e=0A=
timeout error was not propagated back to the user. It is now and causes dd =
to=0A=
fail. blktest seeing dd failing reports the test as failed. On the kernel s=
ide,=0A=
all is good, the reqs are completed as expected.=0A=
=0A=
Note that the timeout error is reported back as is, using BLK_STS_TIMEOUT w=
hich=0A=
becomes ETIMEDOUT, hence the "Connection timed out" error message. May be w=
e=0A=
should use the more traditional EIO ? Jens ?=0A=
=0A=
In any case, I will send a patch to fix blktest block/014.=0A=
=0A=
=0A=
> =0A=
> =0A=
> =0A=
> To reproduce:=0A=
> =0A=
>         git clone https://github.com/intel/lkp-tests.git=0A=
>         cd lkp-tests=0A=
>         bin/lkp install                job.yaml  # job file is attached i=
n this email=0A=
>         bin/lkp split-job --compatible job.yaml=0A=
>         bin/lkp run                    compatible-job.yaml=0A=
> =0A=
> =0A=
> =0A=
> ---=0A=
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Ce=
nter=0A=
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corpora=
tion=0A=
> =0A=
> Thanks,=0A=
> Oliver Sang=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
