Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53AF324FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhBYMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:41:21 -0500
Received: from mail-eopbgr1310078.outbound.protection.outlook.com ([40.107.131.78]:41464
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231614AbhBYMlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuLijDTzUrrXi5naocCFQLLJRXX7PSMmCSg1D6+bwlCwLfR71CPel7bdQ77HPWY4fdTkh40FRfQL3G080IyGmo11hpmTpTYbxUQSgU1nSQAyG10n+XfkpkyWAPeUxRCq6XBsHqobKOk2+aM8UmcRJRn93Jwmss+k5KBFZW+jenHXzLj2iU3UZA5sq0hkFHjOZDaAqNNf7FzbqYOQz+TpGN7hdlDhGbJzHYgSak2NxnCrMc3he3uWXrud1TzMXEhZYVitLvEAJMMU89CYAI8P+zmC1aTmIdPHjD0eK+cGbogNIcBshpILhZqQvzjjCySeVD0ovZ3mdlrHgsGYg/4V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEsJZMizaJWUCQps1Cm34OXw0ua1satnOCN5mi9S0Mk=;
 b=NyT+4e5D1Il+Yn/vwDjCe7SUTVkcbg+AXpbxLN9T2ggS4iXD+iWJF4RHiFSUm23ht2g6XOtfI8mxodTn+/HABiwadjgEjpIYsn94d92MEjSUAibS+Y3SRkr4HE1q14E3hTbz84SQ73lUCqBX43rbByw5WHL6LnkYCO5RngzYMDo7ZqHWmPni1av+DK0r1m+oaOJaFjZcQ6jW+R2mHZfXRe6J410cV4PLCkIn/XIV4hrTcfGeSYDzHl0CxmGv0jC5GXoEPQmeLnBUzIBwXrqXKa8HMYTg0W7Rg8eYq5aUaHVSHPdnz8xz9qsbYT/96bpiA9c/qBQALNTD3WHeOHE7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEsJZMizaJWUCQps1Cm34OXw0ua1satnOCN5mi9S0Mk=;
 b=jBpGjCzeVES/tn4CCZQlOqvaAR3lRIA2Tq6SXaCvW2VUG5lD+yPP45B+F7KKuKOJeGxViGN/cfTQhFa7B2s9B41sD739Pt53Bsl2CxP2shVGY0uzc+tlwZYrn3+VqzDltxTrm87gCNSXB7VxNtsjAta6atayaFep8y2Ad59+H0E=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4810.jpnprd01.prod.outlook.com (2603:1096:404:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 12:38:07 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101%6]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 12:38:07 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Aili Yao <yaoaili@kingsoft.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAIAAAyEAgAAQYAA=
Date:   Thu, 25 Feb 2021 12:38:06 +0000
Message-ID: <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux> <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
In-Reply-To: <20210225113930.GA7227@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50213421-ae00-4ea5-a762-08d8d98a33c5
x-ms-traffictypediagnostic: TY2PR01MB4810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB481048B9A30E092CFBA2E64AE79E9@TY2PR01MB4810.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPOssu3lcrB6ng08T1esuPZLIM2SOZn7rJTb26YDbxFSJ9SeCUqJ2zfn6NtNl8zT/u5RjyD4vrDmhFz0TXkf4vS8uTcIgJLz9OYfPfnq9qB+I3dtwmqmhqX/nezvX4fdixYOi1Gm7p18anmTvioV86FAQo4s7U/eYDzyt0f8lM1nUOglcEr9jVD53hoTWiqWZ9s5utRtbRyRGB/yCBdh2bBDdm8xY0grlmkllOt3bJjrc3KVCjCxhq3kwJEYLp9cOL5sEpGuEOuSVrMYrqdSSpw6X6oYPPGlsXFwb70rll5v7x2dc++hrMz40F3aGGUhlfuHmUaqWJ2ZUaTnx6coEnqnP+hdnEKmjtRM80iYuqtMoAg3LPfyTai9H1dLu+6OHtgRD//xm4Iw1KQdaFrV3qvg/nD9uwO7GKArak1bCeWLBR7hplPXg+zI2G3poKNPKvJL7MO6FhCkqbp8bnkzDJyHL7aEeTA9R/qQuU22nI05c5wvafVaW9tHSyS63XsknEAtMonaoeY8vZTlmugQ0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(7416002)(6916009)(1076003)(4326008)(2906002)(6512007)(8676002)(71200400001)(6506007)(54906003)(83380400001)(85182001)(5660300002)(86362001)(64756008)(55236004)(186003)(66556008)(9686003)(478600001)(6486002)(8936002)(76116006)(26005)(33656002)(66946007)(66446008)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?eko3dTQxN0gvaGdmTEh4d0MwMGdpYSthQWJ2OGJjRGhjNXpCOUFNYUJm?=
 =?iso-2022-jp?B?Z2x4ZWlEOGlpS0hzeVg4ZXpXSTFka0ZaTDM2RHdIZnhaMjlJTTVHWjhR?=
 =?iso-2022-jp?B?cm1DbHBReUUrTlROeVp5ZGdBOEZ4dlhXQ2dZWllXSFFRWGRISnVhZ3dL?=
 =?iso-2022-jp?B?UlNTd3pwcmFuV0sxWTRvazg4aXRIZzZJWGxUWnJvSmdmQ1B4UU9tWnNH?=
 =?iso-2022-jp?B?Y3paakp3Rzk5V04wWG02MkdhOEE4M1hpajJzenJ4SkJLZGV4U3JRWlk2?=
 =?iso-2022-jp?B?QTd4alJjSXFzUS9SOXlkNTRIUFlLU1pTS1ZHc0p2UkNoUUNETHJYZmsr?=
 =?iso-2022-jp?B?N3ZlWDR1SVMvekJITkJqNGt4MU5nRTlBZnZWRzVlR0M1VVRZS0ZmbVZz?=
 =?iso-2022-jp?B?NFkya3BVRTl0WlJaNm5aZElrUDh3cUFMQy9hWThLMDF4dXRLQmtSOUE0?=
 =?iso-2022-jp?B?YXErc092OE1yU29pdlJ2ckk4TFVKNkJ3RzBCaWU1T0lrdWd2d0cvSlNi?=
 =?iso-2022-jp?B?Ly9NMGpBeG1JVGVWcUd5cy82d25VVXp2WTN2cGowZGRlQ1UyMW5IVUJL?=
 =?iso-2022-jp?B?N2NqQmRqTFc3YytxeDRKNndHcEVzRUd3MFpqdndBWjZ0ZTRvMnZ6Rzc1?=
 =?iso-2022-jp?B?dVNZYmQxYzJPNkZGaC9qVkFJVEZnUGlTak5RVnBEZWYyNkhQN1FDbEVO?=
 =?iso-2022-jp?B?SGFyZjhpcSs4bW8vaysxTFBpeFNFZytlOXVBa3FOcG5aWitxdVBFcEwx?=
 =?iso-2022-jp?B?bW5PelN2WVRCYlg4NUNkMmh5eC9TNzJKSFVIMG94clVQMjV5b3o3TDFS?=
 =?iso-2022-jp?B?ZEZiczJTcDRNVVU1cjdyVWdMZ2Ria05Hd1I1T2lJK3ZGemdPYzZweVNz?=
 =?iso-2022-jp?B?dVFNV2Z4TUgySlFibnFiR29YQnhvQlZyQ2kwb25uRmRiNWVpRDZMdjQ4?=
 =?iso-2022-jp?B?T2xzM3kxdTR0Q2p0SWhuUGo3R2thTS95aXVId21KazQrWTdBdVdWcnRn?=
 =?iso-2022-jp?B?azdxcmh6dGgxa2Vya2JwaHRmcERoUlhvOXh1bDFoUUhvMm9rL0xMOXlL?=
 =?iso-2022-jp?B?ZUN6S2lEVWYzeW9FeU5DeDFURDNLWUVGY0VpV1paS1YzbTF6SVMzTXJY?=
 =?iso-2022-jp?B?eThlR0FuU3ZvT0IrblVuUW5kaU1wcW5ESnAxUG9UQTlrQ0dWVEZKdmox?=
 =?iso-2022-jp?B?ZmRyeFMvZ1JjSGRXVEEwRERFM1AxWHJnWGFOenZNUmNVODNDM1Y3TWVG?=
 =?iso-2022-jp?B?Z29mRmhidjkrYlQ5QjJxMzhzVUthbWwxN3h3VWdNeGlSZnN6NGl5T3lp?=
 =?iso-2022-jp?B?a3NYZGxOYk5lSmMwdE5DL0c2QTZ6ZVJWRytHcVl1aVB3S2w0T2hraHd6?=
 =?iso-2022-jp?B?WE5DTE1QcXU5YlRIcWc0elVRaUgxbytpTm1HMzZ3L21mbHV6Z09mcUY0?=
 =?iso-2022-jp?B?YTcrSmlsRGl4U1B2Mk9iUDZERXRHaUxsZmZSeXBjTE9qM3FQYmRpMTF4?=
 =?iso-2022-jp?B?RjJiMHNmZm1YdTB2UlduNzlHd1ZFemU3SnlxaVFOLzVNVWFJcmJCTEhR?=
 =?iso-2022-jp?B?T2ZGaUZjYTlqb3VxUit6QXQ3M2JHdVorQlpaSGJtbjM1dDc4L25SSHpl?=
 =?iso-2022-jp?B?RDM4OTZmUVVwSExYQ1A5V0hzMTM1akoxUEVZWnBXdWVJRFNaek1aTmgz?=
 =?iso-2022-jp?B?YUxaQUVCOExQR1BsYkY0R3hydzBrdHVhRGJ4V0JDMXgxbGNFdENEY0Ja?=
 =?iso-2022-jp?B?UVFYQnlpcFhYeUdNcDljZlZ3SFNpYjMvMFJWOUcwVzEyQ2ZwT2VRS0Zt?=
 =?iso-2022-jp?B?alhNSTlJZ2J4dTZCaTd2VUMwVlg0VTlwUGw2d3FjWTBoUC9aMzk0V1hL?=
 =?iso-2022-jp?B?VU1PcHFOVHVmVG9lQTVUbHNrTy9CQmdRYVIyTzMwMjNROGZOKzFLMHV6?=
 =?iso-2022-jp?B?MkF1SEhsb1lPcFR3ejJ3aVUvdnlNdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B8CABA62B459814DA766AA44134A6A99@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50213421-ae00-4ea5-a762-08d8d98a33c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 12:38:06.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4XYkkJpDIRWTM3HL3P96DuMxCCCPyFHvjoxz1/Et+VEu88R6frFrH9r5RlQbM1RFw4TJcyr38nZYlXJKRYdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4810
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:39:30PM +0100, Oscar Salvador wrote:
> On Thu, Feb 25, 2021 at 11:28:18AM +0000, HORIGUCHI NAOYA(=1B$BKY8}=1B(B =
=1B$BD>Li=1B(B) wrote:
> > Hi Aili,
> >=20
> > I agree that this set_mce_nospec() is not expected to be called for
> > "already hwpoisoned" page because in the reported case the error
> > page is already contained and no need to resort changing cache mode.
>=20
> Out of curiosity, what is the current behavour now?
> Say we have an ongoing MCE which has marked the page as HWPoison but
> memory_failure did not take any action on the page yet.
> And then, we have another MCE, which ends up there.
> set_mce_nospec might clear _PAGE_PRESENT bit.
>=20
> Does that have any impact on the first MCE?

Hi Oscar,

Thank you for shedding light on this, this race looks worrisome to me.
We call try_to_unmap() inside memory_failure(), where we find affected
ptes by page_vma_mapped_walk() and convert into hwpoison entires in
try_to_unmap_one().  So there seems two racy cases:

  1)
     CPU 0                          CPU 1
     page_vma_mapped_walk
                                    clear _PAGE_PRESENT bit
       // skipped the entry

  2)
     CPU 0                          CPU 1
     page_vma_mapped_walk
       try_to_unmap_one
                                    clear _PAGE_PRESENT bit
         convert the entry
         set_pte_at

In case 1, the affected processes get signals on later access,
so although the info in SIGBUS could be different, that's OK.
And we have no impact in case 2.

Thanks,
Naoya Horiguchi=
