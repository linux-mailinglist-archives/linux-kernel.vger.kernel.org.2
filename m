Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358893AA376
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhFPStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:49:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:14422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhFPStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:49:39 -0400
IronPort-SDR: U+XkDnJZ3Y2OGI7gqVVEwpZaA/gSnd/uVQ9bebvoo7VfHi9I+HoOzvCQ83BHjVNWp7qfB5fa22
 NPb0Oa1jXIiA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="227742129"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227742129"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 11:47:33 -0700
IronPort-SDR: 3ddGjk9+YOyCb4pUACY+/a9G/DGMgacn1l8tQY7vkXiQqtAQuGyDuQ+D1Docg/a8pwODOBalwl
 OPoKd7S/r6Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="442974677"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2021 11:47:32 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 11:47:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 16 Jun 2021 11:47:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 16 Jun 2021 11:47:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjYajc2sWyAkbpO1MFH8jjrzFhp1Dm3glGMx20I2FZGDZxK9FPVj8Ag8g9WUHOLdkL0DaFTKCjlS49GnLj2z2y3aJQlqTo9rJgGRMxWIao2n8RwNFDc95Ul1MZHPoa0V5ARV/PUT2cWivaNxcAo++RmgrK+hqbNYNQskqjhuhgn5f0vA3VXVPh4pzFpy1IcSkeor3sNaH5jaotCmMY7AB21oiv23tsnpupmFCCazg/kKECyq3kADPBYCcTKAoLQ3DvsIASE3PUB2H1JaylnHFFHr/hLRA3CYZBZM8wY1285s7WDESRjfhb9+B11iZvZHWsofZnisq0Oq+umdk9jViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fwlXIAArRz7zoG9L1A4eUR/cEsrLjohgp8KiDBLhhU=;
 b=lGnAkIlHdlPAZOZsKNnBbzvWXGCQyhkNyWXAiAxo/iW3yPq46gByOTgIc3rPjQNKnkOP90/1Zvxqw9W2wyhTh2ipGOj0h087q9mLnRTbk1mPRzdO+rgdjT068Dr9nSLC6ws64OaY/5urZQZ7fLOgokbAw6cgN1KcN45Fql26j+9AIwXwF8cdwXkN+3IICGeZsrMeovBRyMjUNQdlFUNgqzKsSOqQucUySqPiuRMIPe0qgTk/g0b/NrGYgToWYIqSWGLmTU+NTm93kS/RLQD6fa4elboYczjf3+F+7L5OPzwMuNpMWzIbX/aDOaKFKJgtZ2MFczcu2PQPJAbKszsCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fwlXIAArRz7zoG9L1A4eUR/cEsrLjohgp8KiDBLhhU=;
 b=RGHp1lI2E75OrIfVqPTh5nAvoQA2lpOB9yUusRriRZN6fDJVPXVqwd+DLmvK2iaiULsUo0WsCAyPsF+EM4w6GqrSZgT/kKaxwOHXHRabmR8ZeSP91H0ThXR860U+NTghNEgMC8yrCjbvncEa9JqemPaqoq39VIvINx5/wo6NJ+Q=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 18:47:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 18:47:29 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgA==
Date:   Wed, 16 Jun 2021 18:47:29 +0000
Message-ID: <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
In-Reply-To: <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8749bd25-05b6-42c4-853c-08d930f731c5
x-ms-traffictypediagnostic: PH0PR11MB4936:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4936987D86986B61E3715239D80F9@PH0PR11MB4936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPiu2saI5UDhzPkPU7Bes+gHe5cphn410osZaKWzE9mGJNq+qyaL2n3Kk04ApOssumWuUEaSOXyu+eoFI8E2N9XZlPPqYsduBNyqa/CasgrugP0g8k1Z4lBy0FPbj6bEPQQoo3UY3UF4WxwZOvbaGUum7hkxEPbQGbP38tdrZOBc77BogbW60CVj6raHtMpLG2SngQVBxhndLDkvIjQes/ar7EW7J03h/j3LZ7RScjb/EmISl+pmQv0MZzYRWG+tJC+GUF8wOe2TQyiVq/uvDD2vUJmkw5b1gpBdIcsZuk1xPh0hGlYGxCESsdy6eDMc/8u1qyU+g1frktJrjqlThkqmPXyotMSwQRIi6SQTnEVPX/c2soC4uDWrekDNXHQgZ9l+IlGDr60S1sDq0FCjx/TsdBzcEEQHi/N/SCJ3tEIllduwbe6wdJ5Y0Th3IBp7xG10GfMLJRnQbyENLpzAf7ElFbpX3xf8e+LAn8LQbOH7hNzSHEQQwoNPJGMbH0qZmKT48FnJB6HAvCex+BUokOzBaKXwr562IajJzzDWP5ze2ymb8yG139RhWWkX6oEWNGkstB7S3ej65dNeR6lZizUEptUIEgH3gfgKk0ggEJJddAySM6Fex5Pn1k4S92GeIqaom2Hj00/jTVspKcJdnNpDHjh6bRTnPJtwnwtk0bUxRiqFTVo9fUqrr9iqadwW/0g/4qobmdkJWwBiz3M4ZB4NDGZ8egKNbnlegLc+rUkIO/ByXEHHI9j29WHyF10q8dpusocp+NKQnH8E9i2cQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(966005)(71200400001)(2906002)(2616005)(4326008)(316002)(26005)(110136005)(6636002)(478600001)(66446008)(54906003)(86362001)(53546011)(8676002)(6506007)(5660300002)(186003)(8936002)(6512007)(6486002)(36756003)(122000001)(76116006)(66946007)(66556008)(66476007)(38100700002)(64756008)(83380400001)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Z7bMezFsWDg+rLKUC+TDLqioKeNeQAZj6Pi0ZENujzcO2gYvmj4Nw5PFFyq?=
 =?us-ascii?Q?7LSo9N0xIkzh0Y9RAfiv3jad3vfVatRTgMVP4wLVCCtwUZjOp3Td2HOxX/R3?=
 =?us-ascii?Q?dzxmZEyAcXnokwsf1UUzWxcjFFsFOGTlM6LyuW8v4pEfE1wKtiZ7qlmn6dxm?=
 =?us-ascii?Q?kBCXxnveLEnJJ1k+F2I6uhg2ipHtwK0ng3ztXnzvqF3vMPS3o1wqJEYwN+/7?=
 =?us-ascii?Q?5Ib5w4Yh4zkDjYCucirbbb9Uj9suFRf1slmp0qTjQclsMI+NoVFKBilpPbom?=
 =?us-ascii?Q?x4sOlRlN00KyWI5KRBby6CldJUw5AHZcK9EXwfFIOyOvDTTuHa3IMX8CBzkc?=
 =?us-ascii?Q?eCZb6Q5ZylF5ezLFRpNBAG6D5jnV49b74bY5wLPKG65plkbHb7ToPCN27Hfj?=
 =?us-ascii?Q?Dpu4+G9A+LXUY2y1HKKknM8EpKoWTfNK0DORaiXSOjGZHAaXGjbnWaNaZJRT?=
 =?us-ascii?Q?LUGv4srrzGecl9QrOYu31osZWlDsZbBRdwEGKBGguA7C0Nk3CYg+nsz42yNE?=
 =?us-ascii?Q?aejDd4O7JmhS965S7ZpGFywXahq4LX7HxqgYytNJwmR5lkO3hBdlo6qiVzax?=
 =?us-ascii?Q?abEQryCL34hWwy3qA7GWwMEcr4Amnq13LYonaEcGDHWGMC14+jJ+xrxuwACq?=
 =?us-ascii?Q?yqnBfQDmRWqnEVUSwtj6NTWpQmyoy7wdrPtqsWRUhyQe5A5GnnV5B3WPAIsY?=
 =?us-ascii?Q?HtrXsGL+nR6huiq2opU5FDyClfygFEaJpUu7zGOj7xGKf4zgPYZoZCv/GeCm?=
 =?us-ascii?Q?XBtzJVXV1KDfA3v0d6HdJn63xR2Az9QNMJT7OnpjIEdajStNqhz0CQViQYbP?=
 =?us-ascii?Q?T0eShNOW53N0wXhX5jCnbZ4xBbz5Sp4LY5247Vf2nUGZFsKIMWuxyM8+Og9o?=
 =?us-ascii?Q?irZwYFcE+/7nqjqBgwugR+evZiT3HkrdVw9WQ7nlrtgq5OiI/zhDe7cq6gTa?=
 =?us-ascii?Q?gm69Tcof7HTm0+kemoFoJrOmzTFDllBg3Fsag3u7xySvz6KKAU0OnBOBpf73?=
 =?us-ascii?Q?XZ5xdbHIrMRsFBgQSvmRhFWQD0xdaDuw78CpPLlMt8EPaDQbbrF/Rn8fhVQe?=
 =?us-ascii?Q?vCSFNN7KNzE4tsJlTrLGjU1t8Ob0NuZrgoXVxd3fgt6B1sO/86p9ORuviy6+?=
 =?us-ascii?Q?TRc4MqJAmRRceZrniOHVmLFeTUPWczd3BB1In4zY1yYD3FUPIpRdlqrsxPfr?=
 =?us-ascii?Q?wcGjJOnu7wt5TwkmznwOspUH+A+cv547UtMs9wUjci3kYRMqf4t6C4hNrtwR?=
 =?us-ascii?Q?D5dasPqkxY+SH1TlSTWsHvRUrThAqO2CaLY3g/3j+mAGvRRYN313E3GaEDTi?=
 =?us-ascii?Q?qmA+tJgzJJoYyfI6CayXB6V3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7930AA0178BC443B0B59EAB48360D1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8749bd25-05b6-42c4-853c-08d930f731c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 18:47:29.8255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KWaxOUVWMduR21lC/LnwpEjOdmtEKLEvUVRUzSZjJqXKpmyxcMrpOS0RcGVx6/kSzaOpJcK77cIZet+t4AKlzh/OzWRkOo7PSBViuqKYrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2021, at 11:12, Andy Lutomirski <luto@kernel.org> wrote:
> On 6/16/21 9:27 AM, Dave Hansen wrote:
>> On 5/23/21 12:32 PM, Chang S. Bae wrote:
>>> @@ -571,6 +612,8 @@ static inline void switch_fpu_finish(struct fpu *ne=
w_fpu)
>>>=20
>>> 	set_thread_flag(TIF_NEED_FPU_LOAD);
>>>=20
>>> +	xfd_switch(old_fpu, new_fpu);
>>=20
>> This seems fragile.
>>=20
>> XSAVE* will decline to write out state for feature i when XFD[i]=3D1 and
>> will instead write out the init state.  That means that, at this point,
>> we switch XFD and yet leave state for feature i in place.
>>=20
>> That means this *MUST* come before any copy_fpregs_to_fpstate() occurs.
>>=20
>> Could we please add some FPU_WARN_ON() checks to ensure that no XSAVE*
>> is ever performed with XINUSE=3D1 *and* XFD armed?

So, xfd_switch() is after copy_fpregs_to_fpstate():
=20
__switch_to()
--> switch_fpu_prepare() --> copy_fpregs_to_fpstate()
--> switch_fpu_finish() --> xfd_switch()
=20
I don't see someone intentionally flip this order.

Reading XINUSE via XGETBV is cheap but not free. I don't know spending a
hundred cycles for this WARN is big deal but this is one of the most
performance-critical paths.

> Wait, really?  I somehow thought that XSAVE* would write out the actual
> state even if XFD=3D1.

No, in section 3.2.6 Extended Feature Disable (XFD) of [1]:

    "If XSAVE, XSAVEC, XSAVEOPT, or XSAVES is saving the state component i,
     the instruction does not generate #NM when XCR0[i] =3D IA32_XFD[i] =3D=
 1;
     instead, it saves bit i of XSTATE_BV field of the XSAVE header as 0 (
     indicating that the state component is in its initialized state). With
     the exception of XSAVE, no data is saved for the state component (XSAV=
E
     saves the initial value of the state component; for XTILEDATA, this is
     all zeroes)."

> This seems like it's asking for some kind of bug.

[1]: Intel Architecture Instruction Set Extensions Programming Reference, h=
ttps://software.intel.com/content/www/us/en/develop/download/intel-architec=
ture-instruction-set-extensions-programming-reference.html=
