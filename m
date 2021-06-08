Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7139EE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFHF4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:56:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:56664 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHF4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:56:51 -0400
IronPort-SDR: Hs2RwJze40EZd9qz4eXD0UgXztL5MXxfxFD07GU0gfn+s/iQiHh0paoA9Fa4Drk7HInW77thhu
 /zutLbC9Zwag==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="290406722"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="290406722"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 22:54:59 -0700
IronPort-SDR: oVrZR4Lqh7doaAw3HR6n8TezLpUGtXCJX9858EI+F1FbEDTUCvnYDZhkhQnq3k2p1/ANTIKnXz
 3XcPpvnnqXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="637528760"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2021 22:54:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 22:54:58 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 22:54:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 7 Jun 2021 22:54:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 7 Jun 2021 22:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgkXnmcQ8s25Y3qvAfriIhh0QelL+R0o7DHhrDIX4Ig4de6LQnj3vI0V8dC3FXCgY97t/lwo0vko0FL43LuKdYZ9IgfFxz6V8CEOMpe811zygD/CndzGfbpxTS002fzXX8cicGv8yQeouseCXJomM0XtFYZIehHioeiCLQF6xmwh7fmW4Wr6STuQJHeY9EIsaEcXDqDH+H9vRKsbpOUF9OBikShhxekp7ycqALSwUqECdg0BL8H6s+TPayLfrz54JiFJLkUp+SQQhKuSmIu6BR9jO2/tBMmJP7NIxQK3UtmaTnbcuniRReasyjL5KqfqEfg1T8z3/RCDBC2TqJxgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz7N/pQ52nZ0mJ/XvwJYxqTk7ZMhnXnroF44Krf2DOU=;
 b=JE1cttPUQGj81U5s1DfYEWP1MraFbA0GwJXaUpCHm5f+nk9g4xYTElmwbNwhfxh7N6KS4tBNX6v/wXpoKFMV6g0jB3lqoywv9vZzDwypUPFUQ64OVKlwYfZuvXQUXwDF327yaIglFFesUhJXmNqxv3LKq/pCz5xMHXDL031i9I1eOsVJJ1bcyy0KQs/WQZcZD7q6jT6lv94OYIFGqxTc8lcHudp+42otuwGoRh04XVasWCfEPSqON4lIxKXXy9eQknPadPuGlmQ5TstIvdon/bcK9m4mpS0whvdJnMbDx/bWwKfSYzJ2gV3HeVdWcmsGFjWSI01ZM1DF674hTKe7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz7N/pQ52nZ0mJ/XvwJYxqTk7ZMhnXnroF44Krf2DOU=;
 b=G7gyLrLCrroQZnaQROzIACgvaKZ78HgU5BxXnB0vKirym/SAZyo76Z9/dzgMeFHWn8Gp8osVYXgJ1YK016bSv0zUg6BHGaQ33OyYcq6SsSGoGp9uXUh3ZCwLARnDXVvEi2hVzFU47xnRDbr5SrfmxjuoDwF9LQPlaTDVOzQ/iBU=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB2583.namprd11.prod.outlook.com (2603:10b6:a02:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 05:54:56 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 05:54:56 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: Recall: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel
 Keem Bay SoC Timer
Thread-Topic: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXXCrPaznG0+N4kU61YwcmhegwVA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 8 Jun 2021 05:54:56 +0000
Message-ID: <BYAPR11MB3128587838EBBC3584DDBAD0F1379@BYAPR11MB3128.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.179.4.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69ea5281-2cf7-4367-0682-08d92a41f1d7
x-ms-traffictypediagnostic: BYAPR11MB2583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2583D6FD07AF99E81413D670F1379@BYAPR11MB2583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lna2CctL7Pj24hwbmI3BOZOL5gzYprpeVQ3j6Wd9I6frDIXy9op8DeUy9fSqOGCPJ8OaPXB0TLZyAphNaT3dASKNH4m7v6AUVTSzd+VqQaCz0PXVZwc2UNefWvqNaAGBIYc0YIs3PNLoIdfWwkd5QyqAD3e+PKgZmVcE/0rT1ZI3vUqeG7dhGE094q3l3SO1udbE3RvgcjdQeDAK7gcM85GQQoCl7p/gQQ3cGleKCL74mArM60r1GtSm8klS5kwVmpIuqRGjNOu3Osit98P03vWAFBEjxTiNoYeeHtr9qPNlCJ713hgVBP2WycvIxwQlGMp01nwsv9L5WY4p2xnIvlHLDIufVgo54BE5BpCNMfdSf+26qV0V3ARQyaDqBD66DmfKlLCbXNM5xTDmB6ouBfkEmHX0NUlHyaZPTyAReWpe14C8vzPg7jIpm9y3Ms4LxfG06EwJnoRYQG6vv278ZtkCKbKVecirmFLcUSAza5vXl71HpHHz8OiJQwOSotUd8lnjf+0bzW4kLmB+lMZBvmxDSiEMJ9Ly5ZqSCT6sjjTLLenpxYez7mh6LCkXg4+jN1x1XzB3mx0dkjSZby2u3iy7ZZunFA2GgLVWaHQZUVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(2906002)(33656002)(54906003)(9686003)(316002)(26005)(4326008)(122000001)(64756008)(8676002)(55016002)(83380400001)(66476007)(6506007)(186003)(5660300002)(66946007)(86362001)(76116006)(52536014)(558084003)(8936002)(6916009)(66556008)(38100700002)(7696005)(71200400001)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: Luw+FOzdy1sAXpIIJBR41g+vdEoK0VLaZnASnRIzql4Y9dOkn/HNjIsI7bNzjMfwciUz5COn4y3L/6aKHxdTdrdWN6k2bgU2IfdyNuzi5Byoi/bwH5Y7IENt8CHmLtkm2xt5N3S6lF347OWHGRA5SuKVq9davKB3NEgtxnT/luHFI7K9CwQxdKEC+1ofG1agyedOUIkPW0mbQgOzCSIE9v/U6qVu6a/04xlR1cqwea+z8Ex6bKHy8AED6zpkfmGNO6XM9B+DyxNbUTjtv88Km5wrIGxpfSwHOC/lUILJEDEHBRnzHrlsN7Bh84tkXqFa9mbYDwvA0TTZt4Oyk+jlAcEyELG5CEREP849DmnKD37bV+P4R+eGa5YPt4xbRYczn7CjeCsoTZ+bCXNW6Fb8J2ZH0VaLBVZAg1WdYN9xKBqg3Bo34MoaSo4juhXtxbXp75u9F8IR7JqCHdqSlJ/tQk+TT5ND8fvfT1RZM24XXy2Emh47d55xRO3pTttQZBjUjECvoEySbKDxm8wiDPOApj4n1QxHo62kqskn9YzZ/lvgyjgh+apm8IEqbxj8dLwPyKeWymRri+2ANtDVgQK0j9+VkEz1CxAyH5F1HJvPBuTJ3WSkPvgrhPPw0x6V6y8YFwIBJHAx/9ow7wfctidXDVXEQBj1DB3qe9qo0UEytYOVMpmESRzQHvg+UY1xdt9hqtz6nA+FihnTfaxoqGMZcdqU8fANjme4zfEhj8JerXQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ea5281-2cf7-4367-0682-08d92a41f1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 05:54:56.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKJzi+WmufpS11pPDEeuNJNIYzHfey5pDIABGVjGzRmK2A417x6mAmy2sUDKnwqTloWBwr1E00+0orK5iAQ17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sanil, Shruthi would like to recall the message, "[PATCH v3 1/2] dt-binding=
s: timer: Add bindings for Intel Keem Bay SoC Timer".=
