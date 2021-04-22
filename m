Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8D36783F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDVEJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:09:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4813 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhDVEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619064529; x=1650600529;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rn6+tJIPyvELwjZr2JeRgZfuUTs0F8hudBUgmGlJjWM=;
  b=ksY5Mi6c0JYL3DpXtod10kYikmQWaR7K84o3vSkUd8dOGzdkWNpSm5gl
   Ao/iUjmWSgq38q4SLCkMDQucKDdKlQUiMhQzPInEC79vwS5Ju9qWEoQ3g
   jREaMZfPsApYcsY5uvNxZUQragtFavvU2lD749tQ/+AYFW/2tOEN3t8DL
   kwMRROd//qNT5TO4Ikw2Tdr/kFLlxAE3Yx0x3oAnd4uqHpndv7rzj91vN
   773uEaAm6uAwCcfXuztAtx+dtET2ImP9j11nutaYelg1L1dkv3MwPmATX
   r2aFNYX7G6VwmF9W+9l/MpSxgbdKK8q0UIvDPmKujVmoohok7yvJ/ETJk
   A==;
IronPort-SDR: USrXF+lAYRUtp5dShKqyJCi+tQJWA++Ccie0HquRqJEbas72sUjFApfv4HQA7Kn7loGmRRyXdA
 6SNY3n4HJii0ZQODRtIp4oJKDTCM3RL722CxrXKtqjgI8ewGxNujRAWIaUkT92Y2lxFBeQXQO6
 eRhY2JlCD3JN4c+KuhLVEins+6WAi3wp9E4GtGFCROC7N7siAu+rLYC02xc9ZTis2syI1gp1BE
 HYCp0rgx+51NOFZGH20GW6Yj7yCHE8vM4u1ASMeJCQNPjNMcnbUaCY+45traAji1Tzau2ZNrIa
 cEQ=
X-IronPort-AV: E=Sophos;i="5.82,241,1613404800"; 
   d="scan'208";a="166348761"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2021 12:08:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIUYe7ralCwfv0KPsSLfKKvsTYIk8flQADO2kTH+PM/YvwKhFqTL9S7nHqzglcQoj/A9lDkSo287/a5n+r7ULtm55juAIc6CmV29gGojXOuLrHOH83HcjkKG4JGEcw/Ym43qBk+VkU1c1UhnI8l4p1lRNJEWgBLzmw8eNGs7/braqG7mIL56fq1p6nAQaLxfC8o8b2/QnjHPAbh6oVWdanP8DULUvn1uMOiS4Ly8lPIACWtpogfiMhnvZWZO6FfW9VAUuh399LLE27f0LAjU5Vl4iiXU2mx9HQ6YesqeYh9/z47meM6Of21/U19W3vrNk9FGVQDLid6JrJvPC1bhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhgSqXaILd5Cs8irDLFdJW1JZz6VBUVEQtNAMVXBfVk=;
 b=oDisPy/v5jW4r1hvQ6H/QUDaXhtDXPflYuCCgoVfFIj6kOUW6B3ymQ35x3QL24G+lMFA8JoCHpB9u7moL05LiJjkuhQjjFdBx2WEtCLluxpuKOV8W7P/rhDyfd4tBrd3N7E0Gj3nhQOj6Zhn3ocNDZX7ed3JeZu/x/QC5PQflgA6vxYn5E/16jVuxH+adQwvapAm0H2gGati67+pgOvCqo0QndKBI6nRhO9X6tpaiaCLHLb+pAxdt7MgS3gn+z+cN0mkIv24ENbNr34KwTmSLEAkH2mgrt81GWO+aiX06Dv39xGG1FPnnzcvttfpBh8w0Xgqpmmpex5Xd9fjMzgQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhgSqXaILd5Cs8irDLFdJW1JZz6VBUVEQtNAMVXBfVk=;
 b=Y9vZZULhFf0lwn2+RE/7LV+XcPOy9fWjg6g6UuefkKJve26lvFQTvcz2tHtyrurN0Y5ZhkEm28h/9Ggwu1xanb2+MfEbYFAPyOIajyryoh7d7DPiZ6LyCLuWVNWocvwoQd9uM6KVfLMq8lP2qIzOEdhgKcmSg87/OUGZTt6CvOk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4980.namprd04.prod.outlook.com (2603:10b6:208:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 04:08:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 04:08:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Oliver Sang <oliver.sang@intel.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>, Beibei Si <beibei.si@intel.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [null_blk] de3510e52b: blktests.block.014.fail
Thread-Topic: [null_blk] de3510e52b: blktests.block.014.fail
Thread-Index: AQHXK6mdYy0b2r7TZEO50jg8+Qg5bg==
Date:   Thu, 22 Apr 2021 04:08:09 +0000
Message-ID: <BL0PR04MB6514B70E428937AD90679F3EE7469@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210407085942.GF22260@xsang-OptiPlex-9020>
 <BL0PR04MB651491ED14D710890187B3D1E7759@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210422032959.GA31382@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:165:d3a4:4d5e:855d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a109128-3885-4d48-d19b-08d905443dba
x-ms-traffictypediagnostic: BL0PR04MB4980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB498087108EA732B46B8E919BE7469@BL0PR04MB4980.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkvjuWdzh/qZb2QwVrM8of3MWZaUB8xnsrCfZACdz7DPBgw3JLvKNeHDYNI35JHZ2Pvw21eSdW16Qry3wy0Q/vfQBfPpNBzfApqg7FR+8VMBan18+1FJAqIPmWd7yYTAGQx9+lwjXsvVmjPrMELzQlln58frnq2ML+cxoRfuuPtGknys1iIPvu98FqlsX/CNYkGYQJZLsqc7kwgQSM5jaJh0jLNLl3WNavilNGyzowgCU64X8gBL6U1oInaaqwHbx2KYtCTTqFqwTlUN6fbEZITZ38rFvVBq7ri2OrzozCdQ8eVMg17d3jdNWO8DWx456oRF+g7fxgOF0eb9X25tzmCH1ObG97q7WYM0+gGeG5791Wpq1ryVUSPnDihDUTqA4sQelMQb6IBa3MkCobdJokI1fOiTVOeZNMUU3Bq6ACF1LPh3E8O4Spzm+bEv5QbVOH0sv91CxlyTDZOdF7WJmszn8CPME6ofZxNboipgxyUYs3FoaPNv6KGpaTD0H3uiZUJqBn2AZ1zMzoGRsaS218QtBOm0F9URqFIe4JhNwRmNFLHgPiHkQmdfo4DyQlGGUj0tYlxmhd1DvPKx3cCIdn4BLhoc9MyjuZOqdBRZ8iBD7cGTrC8WYpctJySTV+LOkG8ihABljAbrDE0Nz8yA7uSXJC7uy6DAN5iZ7ndz5qA4DfR/xe4819KnqkH/AdIG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(6506007)(53546011)(4326008)(186003)(71200400001)(64756008)(5660300002)(66476007)(2906002)(6916009)(52536014)(478600001)(66946007)(38100700002)(316002)(66446008)(966005)(76116006)(122000001)(54906003)(55016002)(66556008)(86362001)(9686003)(33656002)(7696005)(8676002)(8936002)(83380400001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9nK4TVNJ3koYat11O5Dcw33AWh56+E2MHBqVTc4GtH+mo3GyKWbG6eLEDn5c?=
 =?us-ascii?Q?oZ+5Ojip8eiERnLocXWLL5yZBVqCoOjkqD4p+DsoJNIfIu/R+isgSG7xuMTR?=
 =?us-ascii?Q?qZzTGrDF5oKp4abqm6TqDeeZNFcym4lxcFZk/q83oHkl2atMpVawN+kxHwHB?=
 =?us-ascii?Q?vl1E5f4xSEKB1EIDELmCiPrXbqs500qAL++gpcorynTo9XcdtPwl+ZlXR7ry?=
 =?us-ascii?Q?ZwgklrGb2tLDdA2UjoCzx8BfrTAC1C+KQWrwES68yGRIW7cnMwxC6go67R2R?=
 =?us-ascii?Q?lMU5rKmsRofK4/8C40OaHHquSmpOZtFPFD7SGBdCTtsO5ZbCb7//uleyLa1i?=
 =?us-ascii?Q?9VZXIUwFR6PD6UwcYJ2n8vT4gu8R//Qcy7k3FKx0E4bjBHpXQYMF6DZZx1bL?=
 =?us-ascii?Q?fW8M5MjEEjHI5Rv17Rc9+irU39dddv5tsSsD1rtKPlaN7IYnKCjMXSsMuYJA?=
 =?us-ascii?Q?oIUeaQA+pNB6AxaU/c3yJIHpeexB5os1TYtFjxXjqHWWlJHUTt1vJ1NrCs8h?=
 =?us-ascii?Q?ny4G40SIgmCwBkRgtHtJ9rsU3OlhQlEKcrdP1ZO54L90DZ6AtyhqBBG3H9zd?=
 =?us-ascii?Q?Z534qy/Lsizmv9eHZno5mp3X5wDqwmDRfWZ392ak6Rvbc/s2RYOrdbIUfjWs?=
 =?us-ascii?Q?WHzaG3Og4q1kzwwHodPkCLbDqWWJQ4qB2ICFyHWSAC2Nflnj8aOQVDGRErdO?=
 =?us-ascii?Q?YKPKCDXOf/qm0Vv087Mc29hU6FQIPosfHAuU2gzKDdVRlVO3CFqJqNd33yCV?=
 =?us-ascii?Q?u0uhLlO4r8rvJPAw25Yak16A1Bngmg2DbZ4n3h5Lt35qc2y/qi9hpyqIbL2q?=
 =?us-ascii?Q?k/wN/5t7YuqMrDkwABWMMHGXhpjyrbn4akbw53+hu1SWVokoGU4391axzwFa?=
 =?us-ascii?Q?8Tgk+zNa72Rf62OdLeEwy54U54Ju6pj2Ko5bx3yWQLrO/jR4xmlNRVRNxb/P?=
 =?us-ascii?Q?4wpZI63luw9arsmq0LQ3MZJC8z/f10yLqLEGeBav2mQ3ecWhd3z9L4doWA7o?=
 =?us-ascii?Q?kP27HZBHZC6zyOYWmNPgJ8lX9tp8Fe0glwyzbemZyhfZVv5M8ZgR7ORrjBAJ?=
 =?us-ascii?Q?RpNpqLqcXbQEQhf3MPhy2mLAui1bUfd/ireLoSHYABpKxznZGULpvjDjRGt8?=
 =?us-ascii?Q?6bJDfkHXLerV2IhYA3ItNBY+3q/wvvQx0BFPqsZaIBxr+2/wLcVDM0mMauSz?=
 =?us-ascii?Q?o2dPWUFAIWoiWW+umEcKg5vhFHZf6ZfMVgNgKcUGX2QCItgqmDXnkJ1M7Kam?=
 =?us-ascii?Q?b8lVqbr4nwGwwSbK7nigvUh8SUi90VmBRDQaIwvEPnA/zbh7xQLw59zLgdF8?=
 =?us-ascii?Q?Iggd4gE2yzGS6AsJaRfn+XxF2o95eBTu5Q5qMpbMNsNycax8Z/t4T8TZI8FB?=
 =?us-ascii?Q?pBebUVrAs+56/fMhCSTRw518grwobs6ib3hf8FbWSZiYqXQEtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a109128-3885-4d48-d19b-08d905443dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 04:08:09.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsKuS+WMcYs5iQXwBb/aT6heZOyYNu8yRoPrDL6ouycQib/YnpPn41153sJEJ0mqAOc0fd96Gi8Nu+ZqH8Ea4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4980
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/22 12:12, Oliver Sang wrote:=0A=
> hi, Damien Le Moal,=0A=
> =0A=
> On Wed, Apr 07, 2021 at 12:29:11PM +0000, Damien Le Moal wrote:=0A=
>> On 2021/04/07 18:02, kernel test robot wrote:=0A=
>>>=0A=
>>>=0A=
>>> Greeting,=0A=
>>>=0A=
>>> FYI, we noticed the following commit (built with gcc-9):=0A=
>>>=0A=
>>> commit: de3510e52b0a398261271455562458003b8eea62 ("null_blk: fix comman=
d timeout completion handling")=0A=
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master=
=0A=
>>>=0A=
>>>=0A=
>>> in testcase: blktests=0A=
>>> version: blktests-x86_64-a210761-1_20210124=0A=
>>> with following parameters:=0A=
>>>=0A=
>>> 	disk: 1SSD=0A=
>>> 	test: nvme-group-00=0A=
>>> 	ucode: 0x11=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz w=
ith 80G memory=0A=
>>>=0A=
>>> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>> If you fix the issue, kindly add following tag=0A=
>>> Reported-by: kernel test robot <oliver.sang@intel.com>=0A=
>>>=0A=
>>>=0A=
>>> block/014 (run null-blk with blk-mq and timeout injection configured)=
=0A=
>>> block/014 (run null-blk with blk-mq and timeout injection configured) [=
failed]=0A=
>>>     runtime  ...  71.624s=0A=
>>>     --- tests/block/014.out     2021-01-24 06:04:08.000000000 +0000=0A=
>>>     +++ /mnt/nvme-group-00/nodev/block/014.out.bad      2021-04-06 09:2=
1:25.133971868 +0000=0A=
>>>     @@ -1,2 +1,377 @@=0A=
>>>      Running block/014=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     +dd: error reading '/dev/nullb0': Connection timed out=0A=
>>>     ...=0A=
>>>     (Run 'diff -u tests/block/014.out /mnt/nvme-group-00/nodev/block/01=
4.out.bad' to see the entire diff)=0A=
>>=0A=
>> This is not a kernel bug. It is a problem with blktest. Before my patch,=
 the=0A=
>> timeout error was not propagated back to the user. It is now and causes =
dd to=0A=
>> fail. blktest seeing dd failing reports the test as failed. On the kerne=
l side,=0A=
>> all is good, the reqs are completed as expected.=0A=
>>=0A=
>> Note that the timeout error is reported back as is, using BLK_STS_TIMEOU=
T which=0A=
>> becomes ETIMEDOUT, hence the "Connection timed out" error message. May b=
e we=0A=
>> should use the more traditional EIO ? Jens ?=0A=
>>=0A=
>> In any case, I will send a patch to fix blktest block/014.=0A=
> =0A=
> Thanks for information!=0A=
> we checked the latest blktest repo (https://github.com/osandov/blktests)=
=0A=
> but didn't find the fix. did we miss something?=0A=
> =0A=
> when patch upstreamed, we could retest and confirm the fix. Thanks=0A=
=0A=
I posted the patch:=0A=
=0A=
https://www.spinics.net/lists/linux-block/msg66855.html=0A=
=0A=
But I have not received any feedback from Omar yet (added on CC)=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
