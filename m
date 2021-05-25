Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4027390830
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhEYR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:59:12 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:21966 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhEYR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1621965461; x=1622570261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g7V8roswXcWoIbsYTOxXC2ufukBcsgyshrwTm2QNwcM=;
  b=0SX2j3yAD0n+57HNPiMM/0bo0Frc0oi3k3Qmjs1QFeqlpqQkvtBwlcsM
   AXcaX5VgsWAizsJINPO7pdlzF4Vt1dOhFS5HoA7ivICDgLDZpUFzv2pwr
   CmLoRKsmHujmTVMaG6G5682PFoBOThPK2x4J34jCIPYpUo5JwQonigmDo
   I=;
IronPort-SDR: mm2UPgNW0M8nfn29PmaVEh9/4mhWgwI6ShMAHuKlpF0dkYtAbjKcjh45K+sNPAl/8Gv0vQEQks
 paw173eXbxcVpGOvzvDeVo98jk4OJB6TJc5bHoo7aJ2r9RLksGK1wos8EX+/d7S4I5bOV61yzL
 nC7NKjh1nDrXGyPoyerFODbtODpNwM4QtNMh5hKg+GiaSby53ehwRR31YH8fdsuLkB1TicVI9q
 oVq8qfayrECVpbo8Qlh3yBFMtSrR4K0RpRY64UA5t+j362YjAh9Enh7GQQ60It+HB56yTIBNV5
 9+U=
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 17:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxIXhqnVSydSyr49r+J4D2u0vKo6L1OWEiA7yeHY9C/b9tb9312wOMwu0PYBmdVYrwMILu9r3ml7hOPW1aG5sAs7+V7N5HvcVTvaDKoAow7u3m6/BpExdAAH37XgMPq9XJjPtX1V6T5KLrV2SdJfkvbQTNZPf/oAc6ja8IrjXRSrssfDHTMNHcQs1JuVQi3WZAOqxn0bi5BYLClck+OdlBy3cERy9yiK4SbuSG2GaOhwcEFOnwIB74+nWtZXy91xhdds5UcQo5dBDVMRjmlu45O4GTYqOD7bMa2lfLcOZ3NKCpG8jMFnpXiU5ebIjC9MO5fwAaGoiSJMuLKPNoh5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7V8roswXcWoIbsYTOxXC2ufukBcsgyshrwTm2QNwcM=;
 b=AncitjjCLr9rV6w6d1CxljtIsWJ5+NB1tf02oB2+fNds+029SpJ8dzqWBdPzqWhUkcYU7p5LYUjkcfY6OOXRhfAQtNYH5H7fKy6PvYRUZs/xLDJnJobBZOdHE5jpih2a2+L7LmBkr1hOXKt56AF5oDHJquShX1cqEW3L8AcQqqXCGL3V7ro5oDP5WVQWATE21uXBgo4rpHJePYHFIHUOsWTKH9frvJPN/B8NAFnoDUIKZX1mJyFr6dzgxzz7FutGCOuUq1MSIIPl3BSofHUI0uDirxUSolePv8F4xgfbFM/j8G+4iYUulDyVyJLQJfzfZz2hSBMgVJ2pAQmQvVY9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com (2603:10b6:4:7f::24)
 by DM6PR02MB6892.namprd02.prod.outlook.com (2603:10b6:5:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 17:57:34 +0000
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800]) by DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:57:34 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Arm64 crash while online/offline memory sections
Thread-Topic: Arm64 crash while online/offline memory sections
Thread-Index: AddRetGCwamVTZ1PQ4mClPUkiBXM1gAAXfkAAASqPiA=
Date:   Tue, 25 May 2021 17:57:34 +0000
Message-ID: <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
In-Reply-To: <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [163.116.135.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd543bb1-9def-4d67-cc8e-08d91fa69320
x-ms-traffictypediagnostic: DM6PR02MB6892:
x-microsoft-antispam-prvs: <DM6PR02MB68926212D0082EDB0990EA0CF2259@DM6PR02MB6892.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mm7d0lahqlNpseUBSfIGxHM5SQAT5+IflgpLr5ckJ8hoKReTRUV2zsk3/9KWpQKFEpxBbMxZVAfSM1gPi+T8NbMZVj+d8IT+FPPRZOkMn0zty3pxn5dLrKbPzI7FG/YBy6nejVEJ0xZ2G/3IrTsFAreT2T39i60sw+8xH8hVl8PWBpS7vaCPaqrI8/46gnSGLjULkxVeNe80/Ka0plSTI+i63D20BgejyQUrZSxezjAERJ51jMLxjPzzoZ86nifc0poP1kGrBpmjcsKyJJx9M7HDr4d3ELU189lB1lMge1ko3t6gKqYfMCcadDuxsE1EHQGoQm8SWm6aLBRksCZu95max63yP6H9Kfq6BKWmmGyZkgRczYi5hFY3D+6EoP/V1yeM4B/+4OM8eb8F7oivBOeX6aoWIQjHPxQNlF+C1jhWiI0IHWc/im9xYlU5t2ZyDu1XUNzyhZ0i3Hfqfv4ev2mlzokjMG4eBqDVDECsX2DezeDP+HH4hM4KZgsPVyL3i0/mrdiwO21vGfJR8xRUMlVHIzul0yb9cVU4ftZcUToXkJ5qavU5eP32jL5iS1IMwimXKvK0bZ15YfvwJNa7iLgB4f0IH1XHn7t7gTsTQYuPW0Oz1TQN332YYkDx8NPrGqO0pKTlVT/e1N6zjTsQq5eCpjdroU1b+QzFTOcjUwBgXNFlH2KTtPKduXAeC1MoLhawlZyzS3dTC3sQ+RTOsdSmMmv6qszmWheP7vvcgY8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3557.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(66946007)(33656002)(66556008)(66446008)(186003)(64756008)(9686003)(66476007)(52536014)(5660300002)(26005)(6506007)(4326008)(55016002)(122000001)(8936002)(478600001)(8676002)(316002)(76116006)(110136005)(558084003)(7696005)(71200400001)(2906002)(38100700002)(86362001)(54906003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytnZU1VUlROb2phWDNtT2NCd2c1bjNjK1UwWi9PTkNwQzVHUEUyZ2ZFUXZY?=
 =?utf-8?B?UWI4eGJHZmRMY3RTcEhnbE8rVUt3T2dueUZqQW52dXI4ZktpeVdxVUVmaTIx?=
 =?utf-8?B?NEVKT2JNbEtHb2RLWWlXSk43WW9MUE5KZGtyUE5JUEhvRitmY1EvVmQyNzRn?=
 =?utf-8?B?aDNRVTRzWW81bzFSVDRjOVZpTEhXTWp3b3k2WXE5UmIxOFdsTW82WGpSeXV1?=
 =?utf-8?B?YzFpeHNqQi9ENzB5THRuTDl3Ym52MDR4MkZGVUxNYmNYRWhUTG42akRtY3V0?=
 =?utf-8?B?Y0VMSURQN2M5b3o0NHBnUmNsa0tjbTN0ZGhybnovdWZEeUFDVnczcUMxV3RW?=
 =?utf-8?B?Q2pVanRiWmRzdzFIaHJYZXNmb3NSMDA4WVFUbXNMeVFBTktBMnFWWWtXclg1?=
 =?utf-8?B?R1lhODdDY2tta2Q4K1JlQlJnVjNwWnhTQnFwYmFDYjZLVGhkODlLSktlMmhX?=
 =?utf-8?B?QUF5ZEFRdUtHWi9KMnhPVFhrYW9WRktJeEJuRXZrc2Z5V0p5TXFKM09kVWhq?=
 =?utf-8?B?NS9pT25vOEJXVjhLM2wvQ2pwQ2pNTDdBVENjZ1VPVW8wNGZBaEM1T2t4T2p3?=
 =?utf-8?B?Rm1uSzYvNkZzUFhwTkQzeU9NOTJSL2w5N2kxZDIwYllGT0xrV2lpSkt5RnZW?=
 =?utf-8?B?YlJmR0gydEZOTkswelQ2YWcxNitQclVCNTF3bWtOMUZtQStzSE90M0dvNy9y?=
 =?utf-8?B?bWgwUEdiMDgrQ1VTK3c0bFdqTkNQU0FlOFVZbnhjZmRUOFVjb0tFOXhUMFJ5?=
 =?utf-8?B?UVd6TUhPM2RpL2RaR2lXZVFPc040WklNYmJRdDVGLzNFU25PV3ZqLzg3MjNC?=
 =?utf-8?B?NERSK0FpYWxaWkN6YVRQVVExODRlUldUWUlwNnowSXRHYzZvR0ZRQUp3RnJ3?=
 =?utf-8?B?NWhwUFR2K05aL3V5Wi9XT0xRYXdCMXlWZklsR2U3RzFXK0s2RTRhalJCUFJz?=
 =?utf-8?B?WGM5TWRTakdNeTg0UnNQTGNncEFSUUc3TUlOZ2VXenBTVFhUZ0VOMDlIbnJv?=
 =?utf-8?B?c0l1RGZlTFB2a0Ura1RuK2ZEYmFFKytKUXVaYy84b0MwSzcyYjNzeHVlTytL?=
 =?utf-8?B?UGY4blF1Q3dxTmdRRHRnQU5zQ3dRc0xPRTFiNWlwY2J3cGFOMTA0OVNiTnhH?=
 =?utf-8?B?VG53MUpxMTRtQ0VGajlwZ1ExdGNwc0NsKzFGMkZtVUFUbGtuMEJqOWZGRSsv?=
 =?utf-8?B?ekFGcmZWTXNscmtRWWt4YllSY0hRdGxMMndISzQ3RUtDWWZTaVJnbmQ0UXVa?=
 =?utf-8?B?amIycE1zaE5EcmVkdUxOMkQ2YWJXMEpDTjJkZ1ZVQ245VXpZVUltSVN2VGJp?=
 =?utf-8?Q?qEwmTtKpl0?=
x-ms-exchange-antispam-messagedata-1: WuMj0gnI+GghF0Yh6ByHmwAlrIUV9hl1UxMTMFj0HSTLJ3IOlvk2Uh2lU0dJwMw8e7ulvOr3XkHJoMUD853u9HUsHu1NQfVNBBWG/brhekqZt9iuqGhdhf8UI3AYn8XRZIEmM4lL5l9EQzD8otWllYmNpI5u9VabpQPlO9eEo5UFvVW4Z8DmwH+30GJgIYVXzAlXauky3B9MmOaXoSXZhI3mjRvsSb4hSk+HUpTDqCAqytb9mn/q+vUFamZ2PWyC+gqoenb/p1sGMy7oIjVzQLxygBD+8IUwuu6zlPjn79uWjUpX486NKQBFVkHhrN2fQqFfydFtVowlhx4mzXzjDnD4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd543bb1-9def-4d67-cc8e-08d91fa69320
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 17:57:34.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdADga+OIth7LKP+pKJxHLm4nY4ITLODcWPyl8FHS9kMNKqzSlY/j5FcmU8Z+RldiObunaytJX3yMoisfmURdPztqSaNYSCoi6xcBEWGm3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEbyB3ZSBrbm93IHdoaWNoIHBhdGNoIGluIHBhcnRpY3VsYXIgaXMgcHJvYmxlbWF0aWM/DQoN
Ck9rYXksIHRoZSB3aW5uZXIgaXMgIm1tLG1lbW9yeV9ob3RwbHVnOiBBbGxvY2F0ZSBtZW1tYXAg
ZnJvbSB0aGUgYWRkZWQgbWVtb3J5IHJhbmdlIi4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbW0vMjAyMTA0MjExMDI3MDEuMjUwNTEtNS1vc2FsdmFkb3JAc3VzZS5kZS8NCg0KVGhh
dCBhbmQgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcyBhcmUgdGhlIG1pbmltYWwgSSBoYXZlIHRvIHJl
dmVydCB0byBmaXggdGhlIGNyYXNoLg0K
