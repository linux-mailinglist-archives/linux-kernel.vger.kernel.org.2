Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566373AA43F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhFPTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:25:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:40834 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhFPTZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:25:55 -0400
IronPort-SDR: u2ivJz13Fynjjpgg/VXtoaQ6BWb9JcR1J5glfE6tYW/HFU/xSxl1ea2J5CA6tqATZavkfxfTU2
 gWgMnEMaXt9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206279947"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206279947"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:23:48 -0700
IronPort-SDR: DlVfeRYHCSg5VabfCq99nDFMqhcmgB+jIQizUDZbgb59FWG2ZcSRTpxx+XzjVNv4n6MZ90cBbN
 RtndJhTc6ufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="442984178"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2021 12:23:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 12:23:48 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 16 Jun 2021 12:23:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 16 Jun 2021 12:23:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 16 Jun 2021 12:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4QZtL7ctO+DZmw+pA0AeF8LLVnaqcZoor5otgdjTDLLQo9blyO7n2TP4LArcdNZ83MHt3+D6Hy3+Q09FeT/HySyVeuR8r8+R/krq0TR2iYC6lrJigmDpakIlLrTxInSswsV+LpmvA7mrqujkZRSoHWs+QBePN/rRTFSD6w70PMqYA980pKbmsyQ7qaKU0ROHjTxngB5ERMP9ZEcLCIUzEOo/5KgDm59paDxf1+DnMaUqwmJxvQfC/YKjcqy/20qLgDn0XSeNT1Ru06hfZxhNtNOw9XiAw8R7kmXNIqIQYYCeG92EcSPR3vNcdlXnTfKiBV4REOWYp1457dRlggNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFsrI8mYvk34rkLUQFGvMwHVc+hDiPB0q5qXtcwuY5E=;
 b=PRNvw3DzfVgZoZpxt/Zij9crOaL2c2tKQKm3TCtwAytHxRq75yh5hf16CMxUrjapCYvoNf7IhEyofO0I31exNeeslKqMyMyozGOZiprN98xshGeOJneIFfyD2P5KtKTFVJmSfEib0N/eQv+m1XxlPYbGT734zmvTcDaCbS0Jb7T3a2NMw9ekrzpgSqZTHKLyRQUd1KbD4CoLYNtLXD/8Yl7zjYEZTeClaHexlvnjaRK3BbubaycE36H+7lxb3pKo1kDRtG+U8o0QyCEEQwSXFial/f5gk3ZchfnA2wZTUzzHpqEO1/LnfNX3AHL1yXzUhQeJty3bmlz5kDuUHoeJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFsrI8mYvk34rkLUQFGvMwHVc+hDiPB0q5qXtcwuY5E=;
 b=HpHrIirfy7q6b5bHid+LMF17BfbR+8ZfZ6whXfwOer97dVS3QaLg9Kivi3J2C7h67UIH9Zgu2xDUaKlqHCXM/zOhgzWPSK7ScLtAuHK44QZcaw+rPLD3d+5bIk0ojwI0e2qwgAq7uTi9FeKQ1V9rJzJtyhEOc5is9wi3xOWyyN8=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 19:23:46 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 19:23:45 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgIAAA/+AgAAGI4A=
Date:   Wed, 16 Jun 2021 19:23:45 +0000
Message-ID: <16681A30-59EA-4E35-8A51-CCD403026C92@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
In-Reply-To: <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17743f6-a6ac-4da2-efde-08d930fc42c2
x-ms-traffictypediagnostic: PH0PR11MB5159:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB51594B7ABB3AD468386CD466D80F9@PH0PR11MB5159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bff2n29fBNtvgMFUBTfyGyOP/VD9l4iuM0WRyO6sGarwV4SnL0mmtvGBEFSJ6RO/w9nQIuAZ3gGw0omrt1X1V+SObMheLoxdezHA6fcfsmyHLNJYtV8lSPyuQJNYmpMImFY9PgzPdeb0X+NFl1+fedP6cji7fhqmb5TwRKkW3QvpXGX11TMaKt0t3WwTAd/L6lQ+uEDlyMzHvABhRXPihREdvGBTADcqzYAprGEIezq6fVIGwR9LBT6AG0xL3UJUvGY5XfVmfPMGMqXS7trnjE9EFv4fwzbKZxQ2HjP6OR9k3Y8NBMPKnWhhUaLjCHyeursBeiIUTVSy9bHt6cix5X03KeUz/HNbV2XomAwZg1pY15zktQGU6G7t3q6zOz6kIgZsK6JIyb3MJcIJccDsedmScm2uRS9eo29eXfJV7Um+LhcoNNMe8xlHtfmOs+JCiW8t8XE66pSoLWcy+QbINb8bHlBfbmghiJjcacpQmdNGW0UTRgt3a1+hWC+GJCSiFbJhN1L9TuXBvgAZt9IqyI1OBYXzPYwN4xJ6XqllYGOdFGQVRQkxJ8wLsvmTRhRR8eY2D1jkYaMdt475kwci3AMMi+iMAxHEe0z3BpS/Ccgt9wCtzT9GU+z1WbMrXIoLSSEGJ+w+JkrBecZZIeM3V75AJY6g2iCVPaxKqMJM5/qA1+ttiOPgfV/5EkdHqD6DvPV2VKzT8jXnBfxmL2A5h3AQtscbEzsGwkwZxiWiFM2HPaJ3YfFTPObY2md14tUFMqf8eRn1Mdb83hSFyFc/Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(4744005)(5660300002)(37006003)(4326008)(53546011)(66446008)(66556008)(26005)(36756003)(6506007)(54906003)(186003)(6636002)(6512007)(316002)(6862004)(478600001)(2616005)(8676002)(8936002)(64756008)(6486002)(71200400001)(38100700002)(966005)(2906002)(33656002)(66946007)(76116006)(66476007)(86362001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQjWyg2pxchaRQbJVGrCWoaFUGT8ZJo7D8U2KBKkfeMXiT80Agb70+GdSbGV?=
 =?us-ascii?Q?WER3wGvI+sKfkK+AQxfkGXWTTo02O7Xizul6tBPVTGMXMqKZXvUK9VzaPpoP?=
 =?us-ascii?Q?NGc56llxVqet4/SiJ3YyggepFEgsrWJEmMYa2QTyNW9m1jFLzBaNmjMPKWJh?=
 =?us-ascii?Q?Pb9Gy8gUAln0wPgFIM7iDLnOwuplR/hcLoh4KoX0nNgn1r60W3D/AlV+xCvY?=
 =?us-ascii?Q?nCNy37WSMxNC+6Ip5Jn3UUylJXeC6/7cUx0HtgamxmM3cX1nn23pnRtxw97U?=
 =?us-ascii?Q?V3Ejy7JT5xEMH1CNG6RgE4SVL42Ej/mwINEew7+RRwb+Z7647d99Xrg1ImI1?=
 =?us-ascii?Q?107IfE2J+xfHWJ4MF4TOjVO/HGOITvEO9L7vK26vKNxS4pF8dUCjnPKwlxga?=
 =?us-ascii?Q?OHkFMLP93ALPLKjeiWf/r5mvbaVTnhiWmFJ8YgIapltUvpM0c0CoU0hfOC2/?=
 =?us-ascii?Q?OQVQ2RviyisiTC0T9s0QeGvQlUAIJkA6xGJJQL7yMpdLph3N1X1vWHnyoqEr?=
 =?us-ascii?Q?VgBMcorER8fx98aed1YLQoJXb/cTLzF8/hMbMUt8T4Zc+9wfBDP2m+ooB/8J?=
 =?us-ascii?Q?ceT3Y187bvRJqyRGtvy/QgdXHVVhK4NGEd7eIbO9//ccumwBY6WtUIIQxkY+?=
 =?us-ascii?Q?fd/wQrSOz3skGIhILCWXfglXrCD0OarvDEOpY23QoFUTtP3TO/rxPS+4+t4i?=
 =?us-ascii?Q?ha5GYZ5no8cN+sNCR3P7bAPdcAGuhwaXuI69DX+FYHCw6VuqqedYTwCs3H9o?=
 =?us-ascii?Q?gbyx8CB8y3AbSxpZi7xexmDvGmiVzCHpcK+3tYlxJUPXjX1PxJC87G3O5WfB?=
 =?us-ascii?Q?hXI2SjRmUXq5cazOY87ukqWV8Xi2pj6UJe06VZQ0o7Qkj6yt5E0RWOGoDzdC?=
 =?us-ascii?Q?38YhZE4PAjg5Z3jWd53fjXKwtSsuENKilZ88JpnNd3afXCFiQ0iJgemFSn6X?=
 =?us-ascii?Q?BrDp7ug6TRCCPwilB7wP6oPxXPex16LrJa7w2lLCBppc9qIzn9teTpvC0zYK?=
 =?us-ascii?Q?IxPj9Sdc/NWvXdSv2BpZh5k8q5IAK0NgRaaWsVf7uPTY8Doh819JAGp+DHb6?=
 =?us-ascii?Q?vkpFvZ0kMHz6BO6QLFcs7so0TdMEGr3yGZX0D8dr0LHrSibPB92D3kc9jMbs?=
 =?us-ascii?Q?I3xWuVfc3upEflttKHzZevpU6k+5i52TXbqeuS3LUmcalc+nyOKZTAmyYPZC?=
 =?us-ascii?Q?gRe85deNgJlFcUBDk0so9d+SZE8cDrDgmFAuARo/F93YGFV4v4OsOsEgEXmE?=
 =?us-ascii?Q?u4X5Wv3sLQkOoETgElJItBPZRxHgUqdw6d1jsuLRqKPCMg9QCvbwobisUUZR?=
 =?us-ascii?Q?VMMgnMHTIHbGfpKVMwl7ZSRoWpPQk89muoLRlKtdEHkKRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E26C6885EA67A64BB1184CAE899D01E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17743f6-a6ac-4da2-efde-08d930fc42c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 19:23:45.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Py21TIHS1woROw7l0RNjL5EA537x3K7XpORNGqGdlwnzAdNVMMXteA4//XXQhJp3rQB4tQ4f0tI4fuV7+ka8PN+wLr6lh87WdVB6w28R9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2021, at 12:01, Hansen, Dave <dave.hansen@intel.com> wrote:
> On 6/16/21 11:47 AM, Bae, Chang Seok wrote:
>> Reading XINUSE via XGETBV is cheap but not free. I don't know spending a
>> hundred cycles for this WARN is big deal but this is one of the most
>> performance-critical paths.
> Is XGETBV(1) really a hundred cycles?  That seems absurdly high for a
> non-serializing register read.

This was checked to convince the benefit intended by PATCH25 --
https://lore.kernel.org/lkml/20210523193259.26200-26-chang.seok.bae@intel.c=
om/=20

> If you're really worried, let's put it under X86_FEATURE_DEBUG_FPU or
> something.

Yes. I will also make sure to include comments for this.

Thanks,
Chang=
