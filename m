Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D03434FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhJTQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:08:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:12845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhJTQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:08:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="209611249"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="209611249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="527125188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2021 09:00:23 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 09:00:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 09:00:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 09:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SINseYGfNPHoMHGK/gt4Z+wsirNkJtrCgrSiFr05BymRPRtahklwSFsKwnFwcswswr8UNm3m75dCrizR+i3oVfRzC7iBnXOEQbYDaRZME/WM1UoDym26iwS5+2d1Oq7uzZpx2M8wZP7HJz/lCPl33iS9BZ+XPzWWBgWavgMAyvqlDpo6eLC/4qVBewifNCK8ajaLvYbXBgwmc3CoZZJPKyL88YodSA+Z1qYrxTeuL4bQ4WMYzRS04kENJvycWdeskudTRVDg8S4CjNDuRNa1IricAz70VnuPQhDw6kAw/OirWxgcWSuCOecJsNWavJscJIhZRSlupx8wS9vlZ9csiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReiDor2U+GakrQd+Mh1CqxAFCHODBVywwQIYkqVxsRU=;
 b=kTUhJGusl+Ax7XKEf/J0/H3ZAAeW3M+OjS/2r5k3aOTSu2cVKZKoPa9B6a/Chx2GyGa+opBC/5C170ZQQAhG8XinUmDeCYraj1SthGFYwTcfXdsYO+yiHEO6Mo00zmmUzyUqJCs/drN9r/y1zPhF2zaWjUGDmyYB1d3ra1tKk4I33fuCinb60dzdg694XtGLEdhhWlZTXqR2X8SYmjnIp03O4nRn+FVgnS66WG+8fMf54jml+kVYtBT0f/7x8SQstduoCtgNCk6AxBEtG5MaewCfHKkaS4ljNpj+VclVGFF7sXPc2zuqfOsn4tOnOq63CpWJDhTVnGLmXdhN0+hipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReiDor2U+GakrQd+Mh1CqxAFCHODBVywwQIYkqVxsRU=;
 b=DVvQAhmPDRVmpEEDia5/zoq6oNt8Jk9UjtFusxumQWAdtf1FRWvsz7lQVEvExF7T0hHc8YgIpTWhJurl70CpEm0RIeKu1zGxb8gtBxWlQ7NReU0rQFckOCzeHzmuPSwq08fkA+G8pTn+QYrpayVtM6N1ShJ9e8PVqR6vvv5sFH8=
Received: from SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 by SA2PR11MB4841.namprd11.prod.outlook.com (2603:10b6:806:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 16:00:21 +0000
Received: from SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::3d8a:d8b6:947c:f2c3]) by SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::3d8a:d8b6:947c:f2c3%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 16:00:21 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Liao, Bard" <bard.liao@intel.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v3 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using
 compatible IDs
Thread-Topic: [PATCH v3 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using
 compatible IDs
Thread-Index: AQHXxL/TUFdht+QtGUCp18D0r9eufKvahpgAgAGG60A=
Date:   Wed, 20 Oct 2021 16:00:21 +0000
Message-ID: <SA2PR11MB489179E750B31875E42AADF397BE9@SA2PR11MB4891.namprd11.prod.outlook.com>
References: <20211019075941.2037787-1-brent.lu@intel.com>
 <20211019075941.2037787-5-brent.lu@intel.com>
 <d432bf1b-5922-f3b8-4ab2-f82aa6bcc3e0@linux.intel.com>
In-Reply-To: <d432bf1b-5922-f3b8-4ab2-f82aa6bcc3e0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df186d78-1c97-4795-c379-08d993e2b8ac
x-ms-traffictypediagnostic: SA2PR11MB4841:
x-microsoft-antispam-prvs: <SA2PR11MB4841B0342799C95CD07AA40897BE9@SA2PR11MB4841.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvDm2mhBEFnfKf/nq77GnMWyrtCqqZUAIcRczz5y6L+xC9BtJfastRxCAk/6J02ofJNX0ZxNtVviXTaDPfvOHdaCqVGnXNZ9cL+L6DIM/RAs7Y94pX4UOUlhBrpPXIU2h8ctNAS6R41ijKBS8nFeQN44VyQVBqHtfMOD93zwjVE1I0P1EiPviUqwhQLkukh+Vegu/AraXOUrrjiNyLwTwn5GKHN6koJvLyKZ5P7SdSWa/kdSleXeCAnXaM1uomx4e5U0l92z8TxNUtK5j8sfTVq+eGnow+fpsG6R5zAwIt4zbbn1r2kGqiSaeJs5QgGzHBIt6H8GIhzvmQwW3RkfJHLv3ILP111Y1kLTkfSPJB+JTs2kTst2yro5uNa9IyqjGXIg4/uR1v5z0aY+fllNXeSmbfNUqxqMvFwu1pb4rELOcxtKVlR5gq/v7ywDS9st6sdMm+7+DCv2mdIphVgBxowmilXnZg7K3249oUN0RhtABi38aIGwQlceNg6LO7G5qFTMxtYf6uUM/yv0vrMhX9a+e/jeK67amMNlfJ3tKrKUmf+HdZUamsrBm7ke8hLUg/nArpcq6JivGssqJ+ShhTCy+dYr/POM/ss9SCl66y8v62PsF3bFqSIKTMN4qfM7/fnRew4PaDMNEU9VNg9/XSkoj4KJw04h9A3i42cozPsRVreuBxF5ORt61ASBpNuc5dqUvwrgPOtLvaeb7cnQAfTBF7lvsyUUDcHhiPRE1zKaJXD/PbNhLGhRd68TpmTtkohyHThgFvJX57jibUK/k5MYj7YG/ERsiHV9LTOXyv3AY9B35ikWOKFM5hzzuvb9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(82960400001)(5660300002)(86362001)(66556008)(508600001)(52536014)(2906002)(66476007)(4744005)(26005)(38070700005)(55016002)(71200400001)(66946007)(66446008)(64756008)(4326008)(7696005)(54906003)(966005)(8936002)(6506007)(316002)(33656002)(76116006)(186003)(122000001)(110136005)(8676002)(9686003)(38100700002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXR5SlFtNnpwVWFnNGFMdUhRVStsYlZ6YUF0UUcvemdRTzJ5YzlCcitybWhi?=
 =?utf-8?B?bU8wNlBqMklrQ3RGaTdIc1VmcVBMaVptTlEyV01IT1NONjBRcEdxRGIxeUZM?=
 =?utf-8?B?ZjRMR1pGaXpLZ2pybVVjcjFCcEpzU2NDSlNERG5BV2xGRm94TTl1NThxcysy?=
 =?utf-8?B?bWQ3UWVVL3lGOUlmTk9uaTRCMmxjRmFUL2NSSXF2Z3M3aDFYb1hnQUlveDFC?=
 =?utf-8?B?VmNaeFUwNzlWejE2V01LTkpoVFZyN21Wa2RQVlEwOUFmQXFhbUVPNmdINkN5?=
 =?utf-8?B?T1I2TmVYbXc3blliTFlxcXQxTWNubWV4UHFDa01YRmNNYVhWcWhrR3grR29q?=
 =?utf-8?B?WDEzQVNHNm1IbkliNFZQTFlJaFYrenRvY2tFNDg0TTNpM0hmYStTZmw3VnlP?=
 =?utf-8?B?RXNUakgydHRvUnk3dUNQbkV5aDE2TUlkdGIvSEw5Y3ppZExvRGVPNVNBU3VF?=
 =?utf-8?B?M1VSemwxaFlTYlhtSlRhUHlvYUsxN2kxcU9RWjcvWVZQVmZkc1VkSi9oV2hy?=
 =?utf-8?B?VzNYNUxLbkRHWnc0MC9UVnpsdlBDanFUa0dWc3VWRzhBdFZaTVRyeHpBOFhh?=
 =?utf-8?B?UjQ4ZTFvSVRtanBDRGh5R1pjVXBya2x2UGxJaHJIWFkxaFVTMTFza0srVzY2?=
 =?utf-8?B?MjVvbnhQSGlGRXdLRFhWZnBrbFMwaG5CbGVTMG1hWlA2Sy9RQ1ZPNjJMY3FS?=
 =?utf-8?B?OGkrTUNkZXE4RU90YVRFOXI2VnhMQ2NiR2FicmwxK2s1cG13eHgvRE1FZDNv?=
 =?utf-8?B?eG5ZNWZPSEllZ2V5VWFnT2NTRkwyMHlUV0NtQWNyV3BpNTZxMTBnQ001Wll0?=
 =?utf-8?B?cWlmd3JabklXeExaT1hRTmxQR00veURqY2pacWNNRTlBTWQ4ajAzZmplYzFk?=
 =?utf-8?B?MjRIZEwwK0d0SWNDem9uWCtaTVVSUndhemdNOXdTU04wZFBWWDF6aXdjUm4v?=
 =?utf-8?B?a3gvdU5uMkRldFBVYjBBYW1UclErQ2RYeXZ2aHQ5YkVpVERTdnNSOStuY0xY?=
 =?utf-8?B?cjBHYlZsNXNkV1BiQjdRMXV1cGxDY2lOK0x6MDBrN2VBNE44OGwwR0NEckZp?=
 =?utf-8?B?ejMzdmpvZkZkNzRVOGlKSEQ2MzZiVnZScm1nQmdZbk45VWE2MnZaelhsT01i?=
 =?utf-8?B?dTZBb1dOUlhnblljTXRhOElpNEhRZTQ2T29BTWJBbkw3NkpqYU9uamFDYTkx?=
 =?utf-8?B?TnNWNTlyMnJaSnBDK1l0Z1ZPYW9LTTBCRHM1TktnN2ZCS1l4K0J6ZllKbVdE?=
 =?utf-8?B?RHJMMTl6S0I1ZnVmNTFXcHgzc1cvUzl1VlBEc0dTNUlZR3hSaHZoT3VSVG5J?=
 =?utf-8?B?U09iZk9JOGFGRkw0R1NiQk1IZWduSEJYVkc4Mmx5SEh4dmxoOFozYlYxbUpW?=
 =?utf-8?B?d1FmU3dMN2dDcmdUWTFwL2dPcEJZVm50amFXaW1CZ0tJTVQ4VTlFQ2tmNGZr?=
 =?utf-8?B?SGRXM1pMbDdVQkprTGk3TW9FOUptNHRqWjhxZFRkMy9mbmtYN3hSMkJ6NWlS?=
 =?utf-8?B?MW1OTGNWaTl2eFhaMlNVUlFYdG9JL1E2VXNpSS92WkdVZmFLV0xRYjE3dFBK?=
 =?utf-8?B?VUNaSkp1ei9XbDM0Qm5TaEFtMTJxem9WTmc4RWJNM08vMklpQWNGdGJxbFha?=
 =?utf-8?B?SEJyMnRJTXBSOCtQWi9JeitTdUJXZ3ZhLzhjbXpBNk5GL005MFJzRWs4NkFN?=
 =?utf-8?B?VVM5bWoyblRXN1RITEhkS0lKSTl3NXI3YmJXb0RaNnFwV1ZMWXA0U0xuL2k1?=
 =?utf-8?B?QUFHWDNKSVJXc2pncE1qQmpJUkFjdEFmOGRnUVVyYW5ydzlmbENNWTJZSHRB?=
 =?utf-8?B?d0FubkpkQmVWYzBvS0U4RnlaQkJLb0NsSVVyUnVYbUQxQ0pGOVpSL1g2YzQ5?=
 =?utf-8?B?MW9OaTU4UkdhMGVFQ0lrMUtkUTNVVGIrT0dlbi80bUk1ZXVGTG9WTHFlL2d3?=
 =?utf-8?B?VzFaOWZYZXFNZ0hUaWRGTk1NbWx4N2NYSVAwc2taNnZDQkVZcmlUSFNqcjVM?=
 =?utf-8?B?RUY3RXBaSld3VWhtR2oyaFAwMDViU2JMakcwdG5Sb0tLa1l5Nk9lRExjb3U1?=
 =?utf-8?B?UkpDZkNPREM0SGNPTTVJaVdmVVJhNExZbUVWU3VhL2oyc1hJQ0RXQVltVi9I?=
 =?utf-8?B?ZXZRZGs1S0todENqWHo2UU9NeXMxN1U4cVlBV0wvVFg4bWM5U1ZLbkJpQ0ZO?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df186d78-1c97-4795-c379-08d993e2b8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 16:00:21.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKBqg7rdlX9aH37N5656I1b5qRCbOb+wHDOosxkLxoe+mNDY+9xjt+5plzUXemlVQK+J80g5Be1K1BjNN09Ycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4841
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gWW91IG5lZWQgdG8gYWRkIHlvdXIgU2lnbmVkLW9mZi1ieSB0YWcgYmVsb3cgbWluZSwg
dGhhdCdzIGEgcmVxdWlyZW1lbnQNCj4gd2hlbiBzZW5kaW5nIHBhdGNoZXMgImZyb20iIHNvbWVv
bmUgZWxzZQ0KPiANCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9j
ZXNzL3N1Ym1pdHRpbmctDQo+IHBhdGNoZXMuaHRtbCNkZXZlbG9wZXItcy1jZXJ0aWZpY2F0ZS1v
Zi1vcmlnaW4tMS0xDQo+IA0KPiBDYW4geW91IHJlLXNlbmQgYSB2NCB3aXRoIHBhdGNoZXMgNCw1
LDYgbW9kaWZpZWQ/DQo+IFRoYW5rcyENCg0KRG9uZS4gVGhhbmtzIGZvciByZW1pbmRpbmcuDQoN
Cg==
