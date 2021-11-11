Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AD44CE66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKKAjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:39:43 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43667 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKKAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636591012; x=1668127012;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Mlx9yQkjH91a0lLxfdUhXXf6peTiEqhXQMWq513Kl8E=;
  b=X/rjfS0CbzL2NwxZunP2BuEvRSmGh8If4p930gJC8zzej2YbXmvX9UIr
   wRkYjf7OPNgJJ8c5I/7MkRe9gOjtcorMXr1Uf0S3YT06ij1KyNcKTJ4Cu
   PezNDkq6uXmqJVzUv0p/k1x7To7YT6xFBTsno3vrAf3PDK6GHj/AfMonI
   5yFYYIeflyqtAamY9pESh+iqGvE1PkUbXtNszJikz6jt4hv0xaKaOMaQv
   u2orLb9ETqwUeFKSrPHBPdZ6llMZcJjRy1n/Au0aZagIhMvZygz65EYs8
   Of22KxjWafQgI0/qoLcnuJ06bwy9+hAZdNnp/RKcPnEA0NhCWcK5Ax4NQ
   w==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="184300195"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 08:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYfreunnquXj97KZzExwTdfT6fW++jDcNRdbB9099tL8F/1YqZIggRKD5vx2mt3UiCa191a+GU+KZkxm7V1C5HBvASX7traXEJHWLMRu/muZmWwShpHpO4s67EJDL2wWzx3YQjtCEzDCARHBObZ00CM1Hkd+FfRPhdpdxg7qmQRmyVfnmomRWzhSiIzOYdW65W/GyLQj8XVq3bi9cb6HMs1f59I2KaX0aZ7vJbNpi1ZFCAN0CqXmxr5VDTnjpyNxlRPI61I2dyE1VjAD3S0s8VzVWiH2uo72F6/62e/hWg3KWj8uQfpsDROquLSAFpoFoWEKSVbt9pKQ3/xVYUBeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybkiEenvTFgnl7Yg8ESH28vf1JzwPpIliBQwYSZ/kq8=;
 b=jp5CEKj7luTu48cEK/47Gz2QjJ0/p0kD/pzEQ8s/v+lqEF+8yxJTqnyuBoQhVBuwh4zY9OkTb7ovMd0636Iy0FnrPjalVgAc44FV1OWqvuZSJnpIF7gzkdFMm0kjE9apXdtAbYD3jGIRg30HaIxqojRXkEaWA8B1VQpxHOP0tt8bnGPg+fAlVCtfNMQ+4TowWby8tq+PB2ETO/DXumvRYSE8RvnXy+9j+JhvF4MGdBFpHoPc6/vNfTiXMPFiuRvcIiSZQXzjwFKePjPFILKu8urAt0s7ERK6jWGN8N9aGybHA+/evZi79X6A3gDvjDHd2hhNPsxkHDj8hhLh/7+eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybkiEenvTFgnl7Yg8ESH28vf1JzwPpIliBQwYSZ/kq8=;
 b=pdRoysYTpsEi0cthZTqJqJKUJDoXyj/5n1Wm7eIYbzy1JisaPT1mqgB0oIZrcs+kvTdTg3JDm9rXeDsm+voZSvYjwMa6jUSsMCs8aK6HbzeyszC0MQT6UnUOfdtrU4ITEKs937oGhOyVITh2Uu0h7SX5Ghek5MCJDhdFSyX+Wik=
Received: from CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 00:36:50 +0000
Received: from CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::a563:b049:4d85:6b35]) by CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::a563:b049:4d85:6b35%3]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 00:36:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: block/blk-ia-ranges.c:119: warning: expecting prototype for
 disk_register_ia_ranges(). Prototype was for
 disk_register_independent_access_ranges() instead
Thread-Topic: block/blk-ia-ranges.c:119: warning: expecting prototype for
 disk_register_ia_ranges(). Prototype was for
 disk_register_independent_access_ranges() instead
Thread-Index: AQHX1pLh/OcFO9cl4UOxGBmgdydizQ==
Date:   Thu, 11 Nov 2021 00:36:49 +0000
Message-ID: <CH2PR04MB7078397EB865AB49A5643D8CE7949@CH2PR04MB7078.namprd04.prod.outlook.com>
References: <202111110829.XuUWn4Km-lkp@intel.com>
 <f5ec9cf3-8d7a-4142-dee6-cfbf5bd81129@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c5c9b5f-afad-47dd-9e69-08d9a4ab59ae
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-microsoft-antispam-prvs: <CH2PR04MB69811CEFB44BB3EE86D83E83E7949@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwQkd9zhOz3VzrouPx6z0NcZkorel1N/uzMLTjldkBUN4OC9HqJeM6cXVA6kAKKQLvSduvlEMDcBi5cgyuG11dp7F3LhWpqyZSe6o0L83PX3Q21SPD5ZIrX6PZMfyDwTatoTseP2i3TcGBYO3yYliL6YLMhrlxmzgxf2/lVbkLwyI0sDOhD59Ae0+jiKiVz8OuOhVKfPAtMegiAoxaHACa4rbHGlNh6WyQflq1a9P2e6bMJgQqQLvQTjPYvF1gwxUukAPqX/bdkEo4yTQT/r7F+IDGY/MxX5aLjx2dq+VQeDBwXqtAav3PfNzVdZNKY3sF6o782OqbE6BQgTic2TGSB9hA248N+6qcurE22BJ405UC8J1+rfINscCHUwafXkODuWPzbvc1T3/gURxrCUAs3IzJtSddRYcr2RhNHbkQ1BJtEfWJZKByPWe/QduaVrOEX4SzX+cX1jcQ9mvCwAuBdZnCv/bjrHtnzIRGyIW1728X6wzg3cQoLdKtBUc9MgxzOFOCoszyOiw+xujmng8FxlutMkySHbAN8G4QF4FEI59kWCwvJ1+Pj6luZYKwmfSknX3cM0lgBhKogkZMAZ27/VzFgKXeCtNjMTUPn0VMjLFU9zP4eUYYT567QofSf3u9FbN0iMbyErFBwqIpi5kxidWrzYaDf5fM4A8e0C0fL62KrNyCVdhTFCahRYMLrL/Ch9O/htv88bIThkSjMNkidWnYS60qe4MM9GVq4SP45cGI0Pm9jD/S3F+KC1yZzUZPcAfZnaClvmIqAnbZ35lAk1HZMMjRDteN3aEgpWp0i9OAMp/3Nxa6BBrZA0MTYehM8cmxCrFfXVabrjSpicYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB7078.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7696005)(64756008)(316002)(6506007)(53546011)(33656002)(38070700005)(82960400001)(52536014)(5660300002)(86362001)(76116006)(91956017)(71200400001)(8676002)(186003)(2906002)(83380400001)(110136005)(122000001)(8936002)(966005)(9686003)(54906003)(66946007)(4326008)(66476007)(55016002)(66446008)(38100700002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qeKcCa7mVlOmxqUXZvtixCkqA0kIIUNX40FviJ5l36m08VrpDYf6SB4AFsdL?=
 =?us-ascii?Q?L6Mz7RhI5ffrIWAEKj5Hibt0nYkeALi+XB7wXtuUdxv+MTUeUw1DWxvj+hh6?=
 =?us-ascii?Q?2xWmRLUrB/AlRf4WSQqD7QuiZcSpuWeDlgZWLJzgIYvxEhIXrmlfxZCetmFa?=
 =?us-ascii?Q?HlGADBj69vLdkSxuO02deSdbEyC74GI9uNYMZq9ZjolUbZoURGShNzQeQyLK?=
 =?us-ascii?Q?rQStBh7fQSVf+XVGEvm18oVnsX08HLFcJKQ/m9Il8RcUH6GpmS1VhuQsowjO?=
 =?us-ascii?Q?0G4UAowIwVch5YKr004YHy8pO2FXdGhdX3g3DLzvf+GoapZJJLh3NaaLtt9C?=
 =?us-ascii?Q?ytQ4DtN8HuFeGZBgkx9LqfwEUjBOHuHn39w6x+6UlNBMxGtjl/XUOXaeylK1?=
 =?us-ascii?Q?jEBv61kQaKTU0qKY21UwaF2dEhhQ9NrkLTEE9usVZhlrJD/UkPXaK4SndADB?=
 =?us-ascii?Q?N3//BOX2D3hDjqc9V3TjhO4vNmYIFpLs73h190OFD/8VxoATjewnk79v97j1?=
 =?us-ascii?Q?OO6LGe56v2a9qRtqrVQYNJsuF3PQiwkYePRZlir5Fc1E/8yLT/moEsIGKFtw?=
 =?us-ascii?Q?o7MsFmBsQ95kyBqYh58qeFvqNJn8FCAsRrC7VS0UQcCZBTC5MqdEtPAMbkav?=
 =?us-ascii?Q?cDiPWNTJvtW2SGKxbkrNiiZwk7mDJtNkurwDwY+voLTjExUErAfuivRXliHy?=
 =?us-ascii?Q?edmf8QAGVIHA0kFea6f0Dp5KMfzBx9Fx8LYfchwJNoiOe5q1fbWsEEmuvGbP?=
 =?us-ascii?Q?7hluuj1fZ+W/pIen6c7cz+GDmjKcnXtT1EY1dhaGPgy9Y8EbLpcVhbHsKyay?=
 =?us-ascii?Q?AONR3BISLi3ylfv6GsOVs3VE4qLVpZyR6FzpKbCGiZepj+/vFs3pU/tn6dzh?=
 =?us-ascii?Q?8tZEw5UYTRweE++MCTAUozAE9lshh7tyKdhaLvzTtYJ1M485/D6VZODHoF+X?=
 =?us-ascii?Q?wX3ohw8wbUn4NOb6e8THdeRmbijqEMj6xUlMTsECyFyjG27ioHpScOcMWFx9?=
 =?us-ascii?Q?AOD6DnGostNrfHFfLuJR3oUfI/X7JYS2CoERfl4UbXDbflpLAFbVBDHWQxIj?=
 =?us-ascii?Q?z3IA/YMAhc9a+2ejDYORPNrQSF0vO6EtxE28lAW2BLCr0m1IlWTUrbXOUCjZ?=
 =?us-ascii?Q?O3kNPT4H8t4Gu/seOjL1DjtA5C3e8esV2dAJBk0L9Rdl87OAyH4e+TX+ncIO?=
 =?us-ascii?Q?a/wyeP8aJsQVaWromkt95OEGGTvGZWRc7bOZE98IcJdaNkTGnQoA1wYeI6cu?=
 =?us-ascii?Q?sYCz84eDdMbe7FUzeQWeDltKAF7rVJ6K+dHbTarAa3ulv0hWDUQPs/ffshS3?=
 =?us-ascii?Q?BuIdXJu/cjSf6YjyGkED+XuzA9xdcWOX192fK2SXgBTX7/T8sLbeQ26BDd5t?=
 =?us-ascii?Q?cxkRLqjoOIMc8NRJFh5jjSHsnzC4D1p0lOJKdAG59EKEZsQnGSJl1j3cQEI2?=
 =?us-ascii?Q?FnIPAbw+4tv1ykYMd9vaKEen/65DYRrauJoK8aNOwzkJMUNNTRnKJM2eTdUP?=
 =?us-ascii?Q?j66M/+1xcQOtZ4hexOiPcZBrzK1ksKA6OzM/5kwnle7DsOhFq51JBIOR9kdS?=
 =?us-ascii?Q?k67HkX0GgbNDqUSLeb4wWv+dzmDITNhqAQdeEiKSw2HfcV9M/Vhzf6o7KhJZ?=
 =?us-ascii?Q?3X3VgiS6kpb9Yu9p5L2I1phc6fs8sJUC67YoQR8rGssFPNgMsAJcgNZzvE2/?=
 =?us-ascii?Q?5KblXNe2kzAb8PW2vBjcsnHE/+GWBIW7wHMOiONn89JqhQUf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB7078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5c9b5f-afad-47dd-9e69-08d9a4ab59ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 00:36:49.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXNQIAeJ6UIJQ6fCXL+ZvYXIOv/QhjeA/837So2GgCNriI+BzEPELb3P3ny5OXLrvvYu3EFUwUTA8fJgnGlp/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/11 9:35, Jens Axboe wrote:=0A=
> On 11/10/21 5:26 PM, kernel test robot wrote:=0A=
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master=0A=
>> head:   881007522c8fcc3785c75432dbb149ca1b78e106=0A=
>> commit: a2247f19ee1c5ad75ef095cdfb909a3244b88aa8 block: Add independent =
access ranges support=0A=
>> date:   2 weeks ago=0A=
>> config: m68k-randconfig-r036-20211027 (attached as .config)=0A=
>> compiler: m68k-linux-gcc (GCC) 11.2.0=0A=
>> reproduce (this is a W=3D1 build):=0A=
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross=0A=
>>         chmod +x ~/bin/make.cross=0A=
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3Da2247f19ee1c5ad75ef095cdfb909a3244b88aa8=0A=
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git=0A=
>>         git fetch --no-tags linus master=0A=
>>         git checkout a2247f19ee1c5ad75ef095cdfb909a3244b88aa8=0A=
>>         # save the attached .config to linux build tree=0A=
>>         mkdir build_dir=0A=
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash=0A=
>>=0A=
>> If you fix the issue, kindly add following tag as appropriate=0A=
>> Reported-by: kernel test robot <lkp@intel.com>=0A=
>>=0A=
>> All warnings (new ones prefixed by >>):=0A=
>>=0A=
>>>> block/blk-ia-ranges.c:119: warning: expecting prototype for disk_regis=
ter_ia_ranges(). Prototype was for disk_register_independent_access_ranges(=
) instead=0A=
> =0A=
> Thanks, fixed here:=0A=
> =0A=
> https://git.kernel.dk/cgit/linux-block/commit/?h=3Dblock-5.16&id=3D68636e=
242d45453d48a7d30a18a49f80d4ae08c0=0A=
> =0A=
=0A=
I was about to hit send for a fix patch :)=0A=
Thanks Jens.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
