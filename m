Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9663896C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhESTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:32:41 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:28337
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232079AbhESTci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIFctp8fDSYwMFBUfMUncK7st9IZ0mL4TDRu1kLNp95U3c2tF/rmitZD5o/kYg4jBoRnw8Eiffd9GRlgRpTpuKac5xZsvsrF4vE8UDYQWtH5lyds4Zut2Ng4ktAYziPbaIMs5cOPl8Rd208JU1Y0XSGfK8F1DpFxSQuJLt3EjW7XcJvYtJzGq56BLS8PkeW1OJe7fYh1MtfmzSRxvMzVeuAXQQ0lLetwQuf4GRIZk7rdbxCU61t4c5wQQrA0tSUcqJFNlidpm2EYgKG51KGpb3kBPuYHdxy9x952z5RnQzmq18hZCxBxB7m8nYsul3I+6eJV/S3StJyQ7CFGFw1RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL4YB/YHwwqcOtGIJAsc2IwxMwuSrDI2lZwTjXDgZOg=;
 b=nXnj3HpHXgW7x0+EB9+m9hUGmRfTN+suPAp7Ro2OU0wTUhj4rXk7PzdM3WyYpy8ZlcXIemolEAQt/6uqtltMerlghqmzOq9Ic4rP5XxE7IDQibIHjiOHu5X0VsZzwRBsa3vBdbabxgq8dp3uS3jty5KfB7Vh49M0gEQEEeki7Z8sjMP3ouJGyuZBUUteC96o3IrEzcn0WoGGPouSLEPtVZ6aCBQVj+KRzPyDPcS+qtz91BUl/l6K2iDL+Fe4F8BTYoGaux0UgL+SubX0aRWiXv/yEcMsaqfxALdZnylVsRx/XotXMKlcW/yjQn4xH/s1nNlHHdyW8P2XyuJVI9dAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL4YB/YHwwqcOtGIJAsc2IwxMwuSrDI2lZwTjXDgZOg=;
 b=WtMiJ1fbY8gyAx4UmImOnEAgdyOL0InrnkRMgYm7qOBbnMj1mQnUQP7dvLObbLQwxTjzBPTRygMWAC3s6mp5pBVSdxAbIyLgaCbWTNvSZxzuAg1vMlGssVtAPqBkyIM0cLoyn0W43UEua/1QiWCJPFdDFGROwrTYC/WlQOh7ZDM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB5478.namprd05.prod.outlook.com (2603:10b6:a03:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.14; Wed, 19 May
 2021 19:31:16 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4150.019; Wed, 19 May 2021
 19:31:16 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [smp]  a32a4d8a81:  netperf.Throughput_tps -2.1% regression
Thread-Topic: [smp]  a32a4d8a81:  netperf.Throughput_tps -2.1% regression
Thread-Index: AQHXTLjYaZT7B2vV3EiePfaz1IztJKrrHQgAgAAF5ICAAA6zgA==
Date:   Wed, 19 May 2021 19:31:16 +0000
Message-ID: <CDFF26F9-A748-403C-86B2-4511DD6B1833@vmware.com>
References: <20210519142742.GA5275@xsang-OptiPlex-9020>
 <16A4D949-D82D-4034-B5A4-DE4DADE15884@vmware.com>
 <20210519183839.GH21560@worktop.programming.kicks-ass.net>
In-Reply-To: <20210519183839.GH21560@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 319d48c2-dd63-44c4-4b56-08d91afcab82
x-ms-traffictypediagnostic: BYAPR05MB5478:
x-microsoft-antispam-prvs: <BYAPR05MB54786A5E962E04FDB278CECDD02B9@BYAPR05MB5478.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +m7NZHdbQeiPqB+Va5vudpFErIfenvcK84tkxAEV52NBG8HxZ1Kncw+Y4rj5ffXgH8hXRrErIvX1keG6tIlrimH/kSfPwFlOFKAHVax9wAO0aUkGsZCzFTrQP6ENqNTVFwxBfj2T7R506JlNd64qni9QS66LHQYki1QHgBTjmEEekBFg+0cEcaNrhzxQ4OuEHLgA8ktcmgBYJKrgO77INv5oepOfAF6MFmOldQs7H2hi67Fbd1wgWz5kliqt3oSNSFy9SoaAI0pKcrS97FOAJJdpToidmfxBLNNqaLAwVQJ0HFlEB7FtJGI5yRajhuabmpyq9QUXDQxUZzeFajgu1lVGKlke8U+ioMaPyIiAw8Rx/7khqxMw7qjd9by+IlzYDN1v945mkpdo/Qw76H8BRGQciRp9YM+hjb0iMhdm00NUJaRGIZ53XLn+weycMsW1g8hHSxRyFGQVvV55MoAURfqQP9YOU/6fTvpVdihJ1C86udcOj0fhiH5emTWUs+chanSoL68VedTF4Z69xqfwCmQbyMdpy+S19Z3Bn70KefegUBF3oL0whBnxZftmF5AI+k4XUBrq35pqUcpL/jegGGNaK2ElYSpVH2qlRQy1Z6S3py53vH0TFR+9LhHPz3FviF5DqFNLS6lT4qyxU8DBfGCb/Txw//Gn+syNX7M+fcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(86362001)(186003)(54906003)(2906002)(7416002)(6916009)(71200400001)(6486002)(316002)(6512007)(36756003)(66446008)(6506007)(53546011)(2616005)(33656002)(4326008)(478600001)(38100700002)(122000001)(66946007)(5660300002)(8676002)(26005)(8936002)(66616009)(66476007)(64756008)(66556008)(76116006)(99936003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eVMyV2s3VGlvQ1dHRFIxUlRFQmgvcGdVTi9oMElyTEdzY3hpWVNVaENTZ3RL?=
 =?utf-8?B?eHlqU24xLzRtWmJOdnhTem1ielUzc1F3MHVQSEtkd2Z4Y2dCVDJEMTdmU1Rl?=
 =?utf-8?B?VmNCVkxwN1lBTG56d0NUU3EwcWRiWHgrRlcrOURWQnZFY1BLN0JJRGs5UmFO?=
 =?utf-8?B?S1pxSnh1bEQxSTFnUUU5Q3MxckNERHlZNXpCOGFWbEJ0dWYraHk3cFptNnhZ?=
 =?utf-8?B?OGhoWnhYN1lLZHZGa3Jma2s4U2pYSVVtVWFVKzZ0MDIyMWgwSTVidFJULzF5?=
 =?utf-8?B?Wlo3SnhjNmJKK05ZM2c4eng0YU01ZGlsRDdab1VwNG1CL2p0SUNickJYMUdx?=
 =?utf-8?B?VjRoTE5uNlRhMHgzVjJ6ZkxNTE5Cb01odFRwZ0FwYjNJVUsvakFWdmcyUXMw?=
 =?utf-8?B?NTEzK1A5Z1ltMm84SGxkSDVMQUcwSzY0Ly9vSFlIQTBwMnh4aGNBNlpnN3BE?=
 =?utf-8?B?VkJtTzN2MVhDL0hvelBLb29GRWNvYVkyYjVieW00cFhzc1RKUGg1clFGVE1J?=
 =?utf-8?B?YW1TWnpjNHJxV2xlRk1IdFdaS05ZbTFodDlpNDlxK3YzekZ6WVhPVWdVUmlG?=
 =?utf-8?B?SFJqMnl4Y0lnSW83c2hRNXJyaVQ3L1JyeS9hdmcxbnlPK2gvWEpaOW1oeld3?=
 =?utf-8?B?ZkZXb1BZNUJPcTdVRkxtdG16dUMxeEkycUZFVXdKSisrRWVOZmtTbVU3cEFx?=
 =?utf-8?B?dDZvNStXbENoczhKVXFkSm9uWlduMm1kS21RMXlYVHZ1QURhUSs1L3VjT3Nz?=
 =?utf-8?B?UWhYMlhiaVd0SE5kMHk1L3FjaTAyRlh3dkdwVlJpTzQxUkNqWlo4UURIUUxI?=
 =?utf-8?B?V3B1VW5GWTF2SzM4WHJnUXJ3L05uZHg4QjR4ZWtPUnVnRWcxMUE5Qmh5RUo3?=
 =?utf-8?B?b3Ridk01Y3ZLQjhqQU13amN4S21NVHc0Yy9YK0Ziakorc0t4VEZtWld4VlJ4?=
 =?utf-8?B?eW5YYkx2bHRORFpXcGVzTnhKb2piWlc1bXRWM0R3bWh2bFNvdWZpM1FyUE9V?=
 =?utf-8?B?dGU4UjBjQ20xZ1Y1NmNxS2FQTWhtQmJyYndSN2pHZzQ3em1ra3BjVG5jLzlQ?=
 =?utf-8?B?b215U20rd05zc08xbDRtSGVhWHJFU3dsQkF1T09uckFTc29hM2gvVlhLcUNW?=
 =?utf-8?B?K2hYYXd1Tzkwa0djcW0vaVcrMWFnTkRrbGRiVmpVUkdvbWtSc3hMbnpsODFp?=
 =?utf-8?B?ODVJdytXMlJoRVpRY0lLb1IybTNTSDZkajRpOHdpajJNVzNpN2VHUk1ySmRv?=
 =?utf-8?B?WFV1NHVrNjIxQ2dPOTNnZmlHL2dOSU9tZFNNd1NteUtBY0U1L3NIUzF0dzZu?=
 =?utf-8?B?UVMxbDNZMjhiOGs5RmtSd2RaVVdlZVJmWllKMUxWMkpERHM0ZGg0MFhJR1Fh?=
 =?utf-8?B?Wjg3Y1FqY2E2L0xBVEJIWEFGOGdTUTZJcEs3YUIrWXpuWitxRFJ4Z3M2Q1N3?=
 =?utf-8?B?dkNFODVVM1dvWU9tbS8rTVdOZWtERVpselp4U3YrUk0vc2pqQmkyZlZpY3Vm?=
 =?utf-8?B?OHJ6Q2NObEFCOXEvcXhSRUh3QkRsVE5JRkwyZDh3QkluVTdRbXVhZkRBcE1i?=
 =?utf-8?B?OFMyU0hoVitZRW5yak1Ra1MxbXIxdFdhSmd1MUhiNytlaUcvdjhEQzFVSGNr?=
 =?utf-8?B?OWlwdWJxcG93YjR5VklVb0ZUSEZ2akN4TmNsbE5ZZVNPQnZYQWhFL2gwNHcy?=
 =?utf-8?B?RldWQTA5cCtZbzBMdFRPL1FxcXJwTDA4Zi9oSVJDeU10TEFnZjFSMFR2MEhF?=
 =?utf-8?Q?M0i662iH0NmPXJseijZjoixPIqvkaobvlvUi7wz?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        boundary="Apple-Mail=_47B24B75-12F4-455D-953C-9FC49F9C7AD0";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319d48c2-dd63-44c4-4b56-08d91afcab82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 19:31:16.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnmMQkS2vUtDch9SPESZ0U95Nvu866wUobKBTw7Vr1ebF02Nelt++hNeVas64OkEnnQ/5malN89kShxEg94Wdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_47B24B75-12F4-455D-953C-9FC49F9C7AD0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 19, 2021, at 11:38 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, May 19, 2021 at 06:17:35PM +0000, Nadav Amit wrote:
>>>     1287 =C2=B1 42%     +75.3%       2256 =C2=B1 14%  =
interrupts.CPU111.CAL:Function_call_interrupts
>>>     1326 =C2=B1 43%     +71.0%       2267 =C2=B1 13%  =
interrupts.CPU119.CAL:Function_call_interrupts
>>>     1300 =C2=B1 45%     +75.9%       2287 =C2=B1 37%  =
interrupts.CPU120.CAL:Function_call_interrupts
>>>     1299 =C2=B1 45%     +60.1%       2081 =C2=B1 28%  =
interrupts.CPU128.CAL:Function_call_interrupts
>>>     1305 =C2=B1 45%     +61.7%       2110 =C2=B1 29%  =
interrupts.CPU131.CAL:Function_call_interrupts
>>>     1299 =C2=B1 45%     +61.8%       2102 =C2=B1 28%  =
interrupts.CPU139.CAL:Function_call_interrupts
>>>    66.67 =C2=B1133%     -97.2%       1.83 =C2=B1155%  =
interrupts.CPU14.TLB:TLB_shootdowns
>>>     1299 =C2=B1 45%    +107.8%       2700 =C2=B1 33%  =
interrupts.CPU142.CAL:Function_call_interrupts
>>>   301.83 =C2=B1128%     -95.6%      13.17 =C2=B1140%  =
interrupts.CPU149.RES:Rescheduling_interrupts
>>>   389.17 =C2=B1 89%     -73.5%     103.17 =C2=B1 35%  =
interrupts.CPU164.NMI:Non-maskable_interrupts
>>>   389.17 =C2=B1 89%     -73.5%     103.17 =C2=B1 35%  =
interrupts.CPU164.PMI:Performance_monitoring_interrupts
>>>     1299 =C2=B1 45%     +60.2%       2081 =C2=B1 28%  =
interrupts.CPU35.CAL:Function_call_interrupts
>>>     1244 =C2=B1 50%     +66.8%       2076 =C2=B1 27%  =
interrupts.CPU45.CAL:Function_call_interrupts
>>>     1300 =C2=B1 44%     +59.5%       2075 =C2=B1 28%  =
interrupts.CPU46.CAL:Function_call_interrupts
>>>     1.50 =C2=B1 63%   +1422.2%      22.83 =C2=B1167%  =
interrupts.CPU47.RES:Rescheduling_interrupts
>>>   467.33 =C2=B1 85%     -64.6%     165.67 =C2=B1 74%  =
interrupts.CPU58.NMI:Non-maskable_interrupts
>>>   467.33 =C2=B1 85%     -64.6%     165.67 =C2=B1 74%  =
interrupts.CPU58.PMI:Performance_monitoring_interrupts
>>>   306.67 =C2=B1 75%     -59.9%     122.83 =C2=B1 16%  =
interrupts.CPU68.NMI:Non-maskable_interrupts
>>>   306.67 =C2=B1 75%     -59.9%     122.83 =C2=B1 16%  =
interrupts.CPU68.PMI:Performance_monitoring_interrupts
>>>     1131 =C2=B1 27%     +61.2%       1822 =C2=B1 35%  =
interrupts.CPU85.CAL:Function_call_interrupts
>>>     1180 =C2=B1 31%     +79.6%       2119 =C2=B1 24%  =
interrupts.CPU86.CAL:Function_call_interrupts
>>>=20
>=20
> It looks to be sending *waay* more call IPIs, did we mess up the mask =
or
> loose an optimization somewhere?
>=20
> I'll go read the commit again=E2=80=A6

As you know, I did mess up by calling =
arch_send_call_function_single_ipi()
instead of smp_call_function_single(), which could explain the extra =
IPIs.
But that was resolved by your subsequent patch.

For me, what stands out is the time in C1 spent after the patch.

I will try to reproduce the issue to figure it out, since so far I could
not find an error in the code.


--Apple-Mail=_47B24B75-12F4-455D-953C-9FC49F9C7AD0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmClZ4MACgkQHaAqSaba
D1q+qQ/5ASUnZGF2Piy5f1+ULAa19WtBFWgf5jL434a1fh+z/6KLpXj4HFMLrCaN
+i1GKT8kCfGl7UcIJS3xhd8s0A1F5390BJ/SIESSM7Me64o67SzsUoh057iC66B/
YkeTArgmPGjz9MAARxxoXRNPdMwx9dgDft5NgS5U8X2Qe1c+RzLKLXGwnNQB6waL
H30nFmWBdTDVLxpy4FvODs8TIK5kywCW9a/kb6rq6KHDFynBnJVfR8IZIFpHMxQ4
nJmSMVZqcYwkLQZLFWMS8yxul/D3pGKyW5nGdJFNbSAnqikhCtUPatuR3NBCcPBI
VUzB1XqPcbPMG/X42PCpsWSDYg2i5msbd5f5+MbZ4b0S2z0Rv4F1ySsWd+LpW/Si
K7ET0MntsuwuftQ2itPNJKovnWu8ynXy89eiw1SYiuS7nmnqOrC23P+I0nyDktSg
QhUt2gJj0VgiFc9xkCRS06v0H2iO+DtF//YT4HszMFJxw8S4cqdA059IxtdkH2ny
RmR3xqqlcgggXXZh4rFPMoiJJe7oxXiF7zhYWERxWzQL4ak4UDCkHorjU02ax4GL
Oz0J0Mjg2AeIkFrtt+aBh/b5qb8lGRDA8OJAKxcaXr9F9yYnv3VO8zXG4RIWdNBm
bLTXT2wTRMFa8CKNeVsBA+CHWPMl6oH6tOS0qWGJZrkznCTDDh0=
=xXQB
-----END PGP SIGNATURE-----

--Apple-Mail=_47B24B75-12F4-455D-953C-9FC49F9C7AD0--
