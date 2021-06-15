Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC83A89BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFOTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:49:04 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:19424
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229749AbhFOTtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh6UTyqySrRVVopN0pdmqqEPocTGHSfiUiITOCkbfSWP1y64DuRezfRCj9xL6CYEnW7n7xPphJn0z0OtALz0PCbDkaInZXj/K+FxGvGPVzN5vU8YkdppL7xSKRZUPla/ukWFSpPbokwbGd9/TrME9LW8pD/aaFYwzXDXRCxOKj7r+24Dee2F1R6q2eHQSw+I4MhkwFwMq6FEx62XMNjQisWlZ2rcVbbXmGnQ1nZ0eYPOQCncyW/Mxd/K3UZOD3PQGqy8SJCgW9LDVAxK/lKTb4uy9g9xAsklRw/sOMItz7ePHkosiUVqmO3743V1p8CRbuzJG3Wy8K29s87NlmuDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9EM92vgiDFS19T58d6oW1VvwvvVT4TuwaU4pT8Xw7U=;
 b=iiJ/g8lcz9PokKjyp2b2hsqwuezSFiMGKa0TFpBLXoWuRSUzBqvoXh+amHjz7ZlYwnR/xsSyMbAQKGUXHjDowyLqtXTk4SuM4YshvQmc6xG6yI7GbHITkeUhJutn0xfvxA7MxRfSHTfq6w3570gzTe5nwa56DXSq6kZT5ld3zkTJxcad6KtnrFMCYMdz8QFaBE3LVOJ3URoaZbltCszAxTQHkHgDfPmsCQjEJyyxciSNiXVpCraTaPBm1ZmMeSnqisLAPpamJ2rhA/CtuqxmTvS0IXZjSWfUMmRu0F3vtELo7HYL4n5g9kFYrThPftKB7MsDBnybYHaa9TVRWLM8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9EM92vgiDFS19T58d6oW1VvwvvVT4TuwaU4pT8Xw7U=;
 b=jtx5jXgR5O8MHiTxPjTgrYmfGaZkNaYgQkIUllYMsn9HKCyVFUM4b5t7hIrwMh8KDm1j2lbmdhcQMFKrAzUmvnGxLGrKKEeQNB1PBJ425p3JlZCy9ivjdYC+FeKHvVIs/eGM7Iu727IKJcVxGXD/zzYzFhhrptDO0TdQD3PmlPE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4390.namprd05.prod.outlook.com (2603:10b6:a02:f1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.14; Tue, 15 Jun
 2021 19:46:56 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 19:46:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Thread-Topic: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Thread-Index: AQHXYeW3GskVSozHUEKdFx/6mi7fQKsVYLiAgAASnICAAAdEgA==
Date:   Tue, 15 Jun 2021 19:46:56 +0000
Message-ID: <78F1F2EF-E5A9-4836-B7F0-9F269DC32B03@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-6-namit@vmware.com>
 <1913c012-e6c0-1d5e-01b3-5f6da367c6bd@arm.com>
 <7549686F-1F53-475D-950C-8F44A2165475@vmware.com>
 <4343ee2f-896f-e8cc-0c63-31c7e98467f2@arm.com>
In-Reply-To: <4343ee2f-896f-e8cc-0c63-31c7e98467f2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 483f89f2-be1b-4edd-cdc7-08d930365523
x-ms-traffictypediagnostic: BYAPR05MB4390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4390E9476B75637CEC9FEC04D0309@BYAPR05MB4390.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KO2tIdu5ZnQ6AbrmkOlJrPeoredVXhig5AVuD5trrBHCb4DUjJzT6hSFKDDc5L+LNomb/HffhFO9Smb10K4YQ6/jmVGNUAVSuCoPQEkpUKciSgPx4al36oE3jF5rsZZucZDbw8X4cnI9pxJOSVVUcRIzmovj4Z5JEZhVxLhqUdGa5uIPKnENqyBZJe1i7WfR/dcOfs3ySLcPdAs57M5y1M0TjA+APcHKIer6cEXnM6/WuE0wrwQ+FJOVskr401hr8MCMr04MLh5PzYm+XealdG6C7Z6ndjm0Qf13AASTdZlV9jRsHfIjyuvN9n5QAHgARUiVDN5t7bN6D+yADj2H6MpFOTOHH9/cFJSYzDGxQP4rlr0a8q2r24fwkF3t7QdeQRI3+/Np9ND2SnBo7fURx8zuCZRzNef3OvtTEw4zsaiS3K9cw9Rrsv8kED0tjbye0JNfPb/0DnrpACszrIaW9JPPkJ84jKIHhuruACFY0+FBpNpRop3/muPq0TVTinHFor1XZ1pZg6FyqVM0UNUG0wMfZv0zDkn9WKaBoqPzKC7LkHA6QTaGfDECNXEeZFJN9MqtS9zZMim9omSlEly1xGz/lcuXjqderOWKVczPciy6JJMRC79KUb6hGCVsLEyRNt7Wk/COGQ9MmsYZtPvqAN5BHC3A06QQO3xdeLsdcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(8936002)(2906002)(6512007)(5660300002)(186003)(6916009)(66446008)(33656002)(71200400001)(66476007)(64756008)(316002)(54906003)(478600001)(76116006)(86362001)(66616009)(83380400001)(26005)(38100700002)(66946007)(8676002)(6506007)(36756003)(6486002)(99936003)(66556008)(4326008)(2616005)(122000001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU1XdEtyTkpmMXhtNFh3OGdZOGhPTkRlU2thcm8wTkd4bmh5TkRIcld0cEV3?=
 =?utf-8?B?b1psR0l1SVB6WlNRZWVsMXk4MTNMc2J3VHlUMklXNkUwQktiWkMxRFhlMVB5?=
 =?utf-8?B?OG9rT0g4ZDZ0U2ZJeGlXaTVXSEs5Tm90ME9QSFp4dkN1VStjWHBwTEw2bGlK?=
 =?utf-8?B?cVp5QVpISDhKQW9hbnB1amNOSGZPN1FTTW5qK0JRN3M0SjRuQklSbjQxVDdV?=
 =?utf-8?B?NHc0SGRQUzV4N25wODB5dk5RV0QzVDBUN08wWWhtMmVWNThwMUJGMWFucFNJ?=
 =?utf-8?B?eUhQNEd0WmRGUjk5eFNDZ2h1aStTbmp2YmlKMDRZMlZ5aFVNdXB5ZEFjZzVi?=
 =?utf-8?B?RUc3WlFBNFdqMEs5R0ZLclhWVzUrK1lFSHBXamZuRDFBSHhyL1VzbEtuZGNo?=
 =?utf-8?B?K21TMDRmL3o1M0ZQY05BcVRvblNiQlBjQ2NIQUJ5VlMycGwxUmlQOVhvZTBN?=
 =?utf-8?B?a2g0dmtYRWdLMVZ1MlZ0MG10QlNxeUNvV1hIelJ3anBSVDl4YkVoa3JVbGVB?=
 =?utf-8?B?T2E5MWZ1NDl3ZlpoSzVrSHpTTmQzMzQ3dXJFNUJZR3U2Y3RhKy9aVFhuTWc4?=
 =?utf-8?B?WUUyOG8ydUJoNzE1bzlUWTJybEpxT2tML2pZaUFQR0dFYmxCemt0QWlBQjI5?=
 =?utf-8?B?ZEhrZnFvYkQwaDJWWlE3UUVCQ1RKYWdOMThoWE01UVUvME4vVU9MS1Arb3RJ?=
 =?utf-8?B?TFNnNW81R0dMeGVmWWVMaXRTdGkrOFlWYzJ6S0RoZG5HdElIbnk1YmNEby9z?=
 =?utf-8?B?aWMxRHFrMVZQcU9qUXpsRThvdXZWUzFJSmVjZFdHRG5CbjhFVE1wWVFSak15?=
 =?utf-8?B?STlEY0VBeVNGVkVQVk00UFdQQzZYK1N5b0toNURCNjlmcFpQM0JkZmRwckpj?=
 =?utf-8?B?cFQ5SzNUNXVnekZJZ1diUFBrNG95OUVtQVhQSi9ZcWhqSDA5OTlRa3ZDdWFR?=
 =?utf-8?B?MmVBN1hhV3d3Qmo2bVpOYzBIWUQ1N3lCbmk3b3Q5d3MwbWRkazFnbVFsaFFP?=
 =?utf-8?B?dDFMR1k4elc5QThqRmdOR0FFamhOTEhVbVJSNlJvTDQrTE1Hd0NYNG12dkZH?=
 =?utf-8?B?L3o0ZVRrak50NjZROXhvTmQ3K25keXMxM0UzSkx1YzdIcTI4bE1WcGhUQmMx?=
 =?utf-8?B?WmI0R2I3RXpwL3hGL3pnQWM3bWdIcmRaUXRwdlJtU1NNTmVMRmkvbnNMN2tL?=
 =?utf-8?B?QUVyNENTeFhpWnBrVU1SSzdYcHFEbGhMOTNLL2RmajFBOVRNYW8xcUhOdTl5?=
 =?utf-8?B?SG5UbEpHWTMrdm1PUzVmVlBORTYyNmJzSUhueXcyc1ZCYWx0U3gwM0JpSjBm?=
 =?utf-8?B?ZjV4Y1FLVVdpbEtZK0pyNDFqUnF3NHhxSklSMjBzUVZYLzN3dkg5Rmo3aHRS?=
 =?utf-8?B?SzdBTDF5WEtoWnhPbHBTWTBwUm9YWGJlSHhYbzVKTUM1SzJBZFZpUVZMV1dx?=
 =?utf-8?B?WWhPaHp0RHh0MEwvc241MisvT3RUNEdaLzZmMEJXRyttb21JbzNRZjVEV1JG?=
 =?utf-8?B?VDJsQ0l6RXc2U3dWSjRBaU0ySzRHdjhNa0tyN2xZanl3cS9jdVN3aDgyclBw?=
 =?utf-8?B?RXBONHNmTStSaldlYjV2ZUJRT3V6Mk9tZTN4dURwZ1UxYlBQdmNhVVN3NUlt?=
 =?utf-8?B?ZlhsakE3TXgxb1BBVktWaStrc016NzhhTWQvUnlOalZoY1lhV0czeHpIVzJB?=
 =?utf-8?B?UVJKL1FYbzBGUERUU0tOaFlpNktOL0NPNDZLdnhQWmpmQmNyY1VORnNucWpO?=
 =?utf-8?Q?dBPRe8/frWAOzbJV5KEJMlBvaPuyJc+smJhjAxp?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D3AC930A-CADE-477D-8C75-428E23EB75AC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483f89f2-be1b-4edd-cdc7-08d930365523
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 19:46:56.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEX2jPpzgYSkl2J5nY+HP5VJ0P+r5BS27bxQ6sPo9DznTn4AdKaKR2U+dMO1EQHz+Dfo3ggFAaIJtXu8UnJsVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D3AC930A-CADE-477D-8C75-428E23EB75AC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 15, 2021, at 12:20 PM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>=20
> On 2021-06-15 19:14, Nadav Amit wrote:
>>> On Jun 15, 2021, at 5:55 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>>>=20
>>> On 2021-06-07 19:25, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> AMD's IOMMU can flush efficiently (i.e., in a single flush) any =
range.
>>>> This is in contrast, for instnace, to Intel IOMMUs that have a =
limit on
>>>> the number of pages that can be flushed in a single flush.  In =
addition,
>>>> AMD's IOMMU do not care about the page-size, so changes of the page =
size
>>>> do not need to trigger a TLB flush.
>>>> So in most cases, a TLB flush due to disjoint range or page-size =
changes
>>>> are not needed for AMD. Yet, vIOMMUs require the hypervisor to
>>>> synchronize the virtualized IOMMU's PTEs with the physical ones. =
This
>>>> process induce overheads, so it is better not to cause unnecessary
>>>> flushes, i.e., flushes of PTEs that were not modified.
>>>> Implement and use amd_iommu_iotlb_gather_add_page() and use it =
instead
>>>> of the generic iommu_iotlb_gather_add_page(). Ignore page-size =
changes
>>>> and disjoint regions unless "non-present cache" feature is reported =
by
>>>> the IOMMU capabilities, as this is an indication we are running on =
a
>>>> physical IOMMU. A similar indication is used by VT-d (see "caching
>>>> mode"). The new logic retains the same flushing behavior that we =
had
>>>> before the introduction of page-selective IOTLB flushes for AMD.
>>>> On virtualized environments, check if the newly flushed region and =
the
>>>> gathered one are disjoint and flush if it is. Also check whether =
the new
>>>> region would cause IOTLB invalidation of large region that would =
include
>>>> unmodified PTE. The latter check is done according to the "order" =
of the
>>>> IOTLB flush.
>>>=20
>>> If it helps,
>>>=20
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Thanks!
>>> I wonder if it might be more effective to defer the alignment-based =
splitting part to amd_iommu_iotlb_sync() itself, but that could be =
investigated as another follow-up.
>> Note that the alignment-based splitting is only used for virtualized =
AMD IOMMUs, so it has no impact for most users.
>> Right now, the performance is kind of bad on VMs since AMD=E2=80=99s =
IOMMU driver does a full IOTLB flush whenever it unmaps more than a =
single page. So, although your idea makes sense, I do not know exactly =
how to implement it right now, and regardless it is likely to provide =
much lower performance improvements than those that avoiding full IOTLB =
flushes would.
>> Having said that, if I figure out a way to implement it, I would give =
it a try (although I am admittedly afraid of a complicated logic that =
might cause subtle, mostly undetectable bugs).
>=20
> I was mainly thinking that when you observe a change in "order" and =
sync to avoid over-invalidating adjacent pages, those pages may still be =
part of the current unmap and you've just not seen them added yet. Hence =
simply gathering contiguous pages regardless of alignment, then breaking =
the total range down into appropriately-aligned commands in the sync =
once you know you've seen everything, seems like it might allow issuing =
fewer commands overall. But I haven't quite grasped the alignment rules =
either, so possibly this is moot anyway.

Thanks for explaining. I think that what you propose makes sense. We =
might already flush more than needed in certain cases (e.g., patterns in =
which pages are added before and after the gathered range). I doubt =
these cases actually happen, and the tradeoff between being precise in =
what you flush (more flushes) and not causing the hypervisor to check =
unchanged mappings (synchronization cost) is less obvious.

I will see if I can change __domain_flush_pages() to your liking, and =
see whether it can be part of this series.


--Apple-Mail=_D3AC930A-CADE-477D-8C75-428E23EB75AC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmDJA68ACgkQHaAqSaba
D1ppFA/+PZX6IFGbVMRM4NhYUXXnENYbW86s9gQuy/TF6//KEgjisBO8Ew8ZAq0A
0qi1DYTlACT8T17/YNJ+S6pqaGRpd6Hov64WeMM3/G04kkRevhrZOLzeuF58FIRx
wub7sArMPcNNMRm7GP/ySI7ehkiWVeqIWr+vyHOtiz944WBH7yGfAVbp7SjIzy8j
e4yc7s3/VLrFuSNIGG8YpyyzN6QUWiL6PqFEvdSwymZgvkuKV+CA5bt3GG2R4yhX
3gDO869TlJazkQqUC28HzqXKh7CuFwP5BYfmu3VSn6ydw7F0oJHQ9IlxYwXPkddz
cVYUdwROPj0JxtyIPqVdwENJeXoj2Wx8F0hD623bhR4HSp+YMGRI+9U8KsgdR/rW
G2yfb5OCCukx1JJGeGKtfFa+MBuTXXFwAFhaas79roxKNq4MhRw6QixL3Oi8w0bU
uJr1MFUTWJ/IqaXPleTM9qo6bdg+w/WhFGZ8CAaIgpYVPETe3pO0YKF2IPaXecT8
Kbzha0kOyDV50+4ejVVUSG6C5PFSsJI1mJXKCH4QUtiBs3nD0TIXs1GYJFBy37nN
epwF44+ssFM0XsHXAiKYgnjTdK3IXL0tpY1UKDdWqzK6gGCeTDDxWvtsci4nmCQ+
E/Rif/OigC3GEUpRU6xPG730OSwBJOsS3XTT7ikNXMgCSLlr8Ew=
=4duN
-----END PGP SIGNATURE-----

--Apple-Mail=_D3AC930A-CADE-477D-8C75-428E23EB75AC--
