Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3664456D04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhKSKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:12:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:52930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhKSKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:12:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="215105875"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="215105875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 02:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="473495723"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 02:09:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 02:09:53 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 02:09:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 19 Nov 2021 02:09:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 19 Nov 2021 02:09:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGgYPUN7l0V1WJH851RpWSZCpNN+WE960aE2HwV4urDUwIzQPDkOID4bm/8A6ordllPifJGSbN5wsZcIcr4sA0Et7yt6DY0ACTBVAk5ElwxBbB1I5WFEEpjanTm7hq4MKdcBWH9gp9ngHvGMzSVKTy0fp7eCY9etvSrRp/fQcsqh7cgUPDFfioONzpDg4fOrBYHRSqkk0Q1ryiez3fh48A8+cnyANoA86zPtEK58fR/K0EkP22ZyNk0Wnnq44fCc+IOipGpShUlXSF2MbFK3pG2nCZLf4fD3UeWXzwb9HePVmFvw7e+juI+3ZZvnCYUbhX0xYs10dirfl1A9BiUHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODQiWmQkSi9jF04FDeuP582X8bZTsgJPZmxm/rzTlHw=;
 b=Aq2PCJp1Shyjo/tHwHtpQEsLVYFyZ82cc/GUFOhV+y/V8XX33a0uSxTlJ0O8i8dQEEk5r1YAgFesNL4N/rW5jK4A3jePqO5XacVOeThJ/1eVOeKwqUVjbBvolrZCVMsmC31+DIdYTBvTcDjLdyuw5MgM3nnmEml/OOv8RJqEcMlLhdpsaXOceNNuiak/qpbPA+JV80P9erS/FhDqF2YHSl+2wdrT/1YzggI+trYj2mdItV57sc8er6YkBI5FmfHbqoSZ6cL9KYT2GuOl0Z/5wOfOdzazuYTQBwDOXLc0BXy/udDBhhgOVs0NXXexrgcaqnaTAj9FU8C1qjVrx6kzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODQiWmQkSi9jF04FDeuP582X8bZTsgJPZmxm/rzTlHw=;
 b=Pqs7vaD8OMcZuJprB2BZhiyNJsxwEaVtyOBc5gEBsoK/81YjjfU4b/9CDwOUuwrqdtpFABlCMChKOOFCjmn3GzOnd3cdbsvH7aJbGm+1fP6p7aN7SHfwo8WkU5YFi/zuBJk+SfB+Goziho12AWcACb6a2y0w55w7PgvhV7yVOIs=
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by PH0PR11MB5174.namprd11.prod.outlook.com (2603:10b6:510:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Fri, 19 Nov
 2021 10:09:37 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420%3]) with mapi id 15.20.4690.027; Fri, 19 Nov 2021
 10:09:37 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        "fnstml-lkp@cn.fujitsu.com" <fnstml-lkp@cn.fujitsu.com>
Subject: kernel-selftests/lkdtm: USERCOPY_STACK_FRAME_TO fail
Thread-Topic: kernel-selftests/lkdtm: USERCOPY_STACK_FRAME_TO fail
Thread-Index: AQHX3SulU3HBBE2rF0qjDo0wAWWSAw==
Date:   Fri, 19 Nov 2021 10:09:37 +0000
Message-ID: <PH0PR11MB4792B019A284AF4695F24EF4C59C9@PH0PR11MB4792.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8540067c-3ec6-ba30-4024-b298b42f50da
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b80c03-acc4-4ce8-01ae-08d9ab44b16d
x-ms-traffictypediagnostic: PH0PR11MB5174:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5174BB9FAFD95FB7F036E383C59C9@PH0PR11MB5174.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+jUBPC0gGpj0QP/NQLUbq8zehtSvcJzdp9seCWzGqPNG1E5Tm0DQeWxZdFT9BJcO89ymoF4Apnm7TyjKzNFf7oQjWYjZmLlKckX8sXWF81zTPQupkO7++ulDkCpOAdayH9H62e5ROw7qncJlTlDPsDi9fA4lWBaiffr48g4MTNpE5rbgcGlqMTruCBQBKXOBEIs1uWn3RlGuTtsitWUF4jht7aUet+wLSVXVq7tWQwEbXXXuchWtOLj9H88fBI8TXQhJq5wE31gBvGm8Ff9OKEio/VSHUKzmp6GR0SLSTyPxr7QV3KThahrHBjU1fOJwklN+2NkKIcXaMQHHV29QDjpN/5T++PXWBzlcJUKrkyrZzCjKjDHYk/4tj/Ei/HdzqgJE8Wgt0o2woUrwl4EMvKybNP/kujCe4F6+nF5as7o639r74NDbqSAwIe2TMHoDedii+Im8G2/f3gvbVhSBoirTCJHSWEPf9d9XArTAFGuw2wH0u4jDwzbjgq93MCBBMqy0OoxeFnZxJDD9s2XnXPqulYAe/fbZWDG3c70SUPaULX8L9Qwupr6M0x12HHq4xq5K1rgFkE1/0D8jlbjt99Y1wWZxGea5k7KIqdD2Gz8+uSveWyZLmYSPT3p8bJIqSbAlPwBLBKb61Wr5dAQmh/Ub5OpCL2sYTpWQ2Ja+U/1LeqWFcZwKFLM/q3DATQZjgsCW3jyjvppBr5a39l8ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(64756008)(8936002)(66476007)(8676002)(122000001)(86362001)(66556008)(38100700002)(6506007)(52536014)(2906002)(9686003)(4326008)(66446008)(38070700005)(71200400001)(76116006)(54906003)(26005)(508600001)(110136005)(55016002)(82960400001)(33656002)(186003)(91956017)(66946007)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yvuwUYEU70/MG2R5wA8XDSBNUtFHm2VsON5yCsAQHCb8JGVQJLTEDw2phQ?=
 =?iso-8859-1?Q?d5V57NQCf9wvQ68nPNJ+4hPQO5bXNp6rKP1/hdTJuEaOZkz10iRNtu4r4m?=
 =?iso-8859-1?Q?kT58sZ9PiMauWphh1wXJYAyv0kAfNjNvgXNwKUwwet23nc4Eg8EQlHyiFE?=
 =?iso-8859-1?Q?3ozBm8HO7ASsfqmv+nny9/9/7YXP0LZ2xJzjv/WhE8OOdtbzCiw+IJij8N?=
 =?iso-8859-1?Q?VXUAN7f8CFsQWpXXlMh+oKiHgmsi6R/68qnCdtIyhYJ5RX24d+n47mgvEK?=
 =?iso-8859-1?Q?EDjHO5DOEj4gcsxhV6SIMcLpwAPEs4J3EZx47I5u2l2FgT8N3G5ScVMMs7?=
 =?iso-8859-1?Q?k94lxh6PsscstBgtIX3wPGNQT0XCnOkCup1jjb1SpPPCjipzed/1jbnmCn?=
 =?iso-8859-1?Q?dtXXW9vO1rXR7W4yg4snYwkGSzcAYHzyszUXwzDMUKtB1aO542Fn4eAUis?=
 =?iso-8859-1?Q?rI+lGzn4fbYF3uBkk9X1vwz6b7wmSF1qyvWV9IF8uDGhPE+6E5RtmwIueP?=
 =?iso-8859-1?Q?OMcy0rZrfYJPdvBGnLiB6brAFEOrsHSzJ3+Wvdx2xNx2LIO2tFcz+BYWvl?=
 =?iso-8859-1?Q?/BOckbH8cwe+iavUiOyms26nYvI72XRYtOnupz6d1ju1IlyRDfR3T0u+8S?=
 =?iso-8859-1?Q?6DigbkAVseF4twiL4pL21y/vHwMb7gZkIAkct7RhAe6uXFuWBIeFPYdhfF?=
 =?iso-8859-1?Q?60Ok4y+hJzwDB2bVnHmAuH6ufbd7CyfuEmShaQP6Q0GRARJNTuQcgv0YoE?=
 =?iso-8859-1?Q?Bbp2wRmeiZrZzvnpu/GcIM2wH5gl3OaRRH5SfRK8mESsR2ExQVBIOU4Oj0?=
 =?iso-8859-1?Q?kHtyY7bEqOTjLhmWD7h50cgkXOe2eICeduf0sXbzzHQnRixCFC24DBWNKE?=
 =?iso-8859-1?Q?6I+v3xWj9uKnFtrDUYmTdvK6ONr92J8rUl5ruKiS63l/jCBlETqS8SCzyE?=
 =?iso-8859-1?Q?eZBqfbk5zIy3Vw8D5aemN4iBOPWTNLYXyIbSRj5677+6aURlKZIAEKhHfp?=
 =?iso-8859-1?Q?V/f4v9cVrNDvDucM3RvzHMmp6LKHu6pHJ4sTslX+J12CNh97bMDK8/0J+A?=
 =?iso-8859-1?Q?Ng3/wTN4Mn/bcbUROJ2YWj4w4sf12qgffqz2YYY7u5McIDsLq2P3US/I9l?=
 =?iso-8859-1?Q?+Rikae5kiTNmYTUle4u8AzpZ0QN6Tq8wSt/9zvOKMx2EoOp8QSKRNfdQqt?=
 =?iso-8859-1?Q?sRWR6JrJqvQewN/aMFRv4bMPqj8N+Ib4BWob/MULkBylhP4uwsmnOnkhBb?=
 =?iso-8859-1?Q?M849x5RZ9lIHPwsxSn9xj6e7VVmqUvDqZRZ7DcAw1sB7QQZaYJf9soDS7E?=
 =?iso-8859-1?Q?2/6dXBpOejT6XiaaKI36mFXx9+CG3C2I8thYJ9BnAdlgSsUtNIQZszw+HN?=
 =?iso-8859-1?Q?nyLGr8wv0dnw3dpHnhL9hD1oclBZtj5VDbYt0Ac4L5C/bttDAmROJy7WxW?=
 =?iso-8859-1?Q?/vzOov022F841sErORzbGIF74jTtfaXd5DvsPJnNkACLMzIZsjv2xTKRAz?=
 =?iso-8859-1?Q?rqlBBkkAl3ksxQMLVOdI0MdVXmo2WAnaji0JmgujqJbKonoQGPwfPMVwRt?=
 =?iso-8859-1?Q?YgfYt3ryFPeRUNO8sn+cN0ZG69zimZBTq64kGYyJ1mDknXOb3a81Ccp0h+?=
 =?iso-8859-1?Q?dfzZ5fWRP2q3X6mRaWyFlEr6M31gmmMSVSbLtrhq7IHXqGKSc9H7N7Cw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b80c03-acc4-4ce8-01ae-08d9ab44b16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 10:09:37.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imYRa8Z3diiXsEEaHHdSy/SHpT3kJsbtiWXlWkHytqehpcb7ZrwJfQvYXi+x8MHKmkyS4lKZi/l838NaslW//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5174
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,=0A=
  LKP test try to test kernel selftests/lkdtm.=0A=
  But I got some error like following:=0A=
=0A=
# [  107.625978] lkdtm: ok: SMEP did not get cleared=0A=
# [  107.625980] lkdtm: trying to clear SMEP with call gadget=0A=
# [  107.625983] lkdtm: ok: SMEP removal was reverted=0A=
# UNSET_SMEP: saw 'pinned CR4 bits changed:': ok=0A=
ok 15 selftests: lkdtm: UNSET_SMEP.sh=0A=
=0A=
# [  108.321689] lkdtm: Performing direct entry SLAB_LINEAR_OVERFLOW=0A=
# =0A=
# [  108.333630] lkdtm: Attempting slab linear overflow ...=0A=
# SLAB_LINEAR_OVERFLOW: missing 'call trace:': [FAIL]=0A=
not ok 19 selftests: lkdtm: SLAB_LINEAR_OVERFLOW.sh # exit=3D1=0A=
=0A=
# READ_AFTER_FREE: missing 'call trace:|Memory correctly poisoned': [FAIL]=
=0A=
not ok 22 selftests: lkdtm: READ_AFTER_FREE.sh # exit=3D1=0A=
=0A=
# READ_BUDDY_AFTER_FREE: missing 'call trace:|Memory correctly poisoned': [=
FAIL]=0A=
not ok 24 selftests: lkdtm: READ_BUDDY_AFTER_FREE.sh # exit=3D1=0A=
=0A=
# USERCOPY_STACK_FRAME_TO: missing 'call trace:': [FAIL]=0A=
not ok 69 selftests: lkdtm: USERCOPY_STACK_FRAME_TO.sh # exit=3D1=0A=
=0A=
# USERCOPY_STACK_FRAME_FROM: missing 'call trace:': [FAIL]=0A=
not ok 70 selftests: lkdtm: USERCOPY_STACK_FRAME_FROM.sh # exit=3D1=0A=
=0A=
# STACKLEAK_ERASING: missing 'OK: the rest of the thread stack is properly =
erased': [FAIL]=0A=
not ok 73 selftests: lkdtm: STACKLEAK_ERASING.sh # exit=3D1=0A=
=0A=
# CFI_FORWARD_PROTO: missing 'call trace:': [FAIL]=0A=
not ok 74 selftests: lkdtm: CFI_FORWARD_PROTO.sh # exit=3D1=0A=
=0A=
# FORTIFIED_SUBOBJECT: missing 'call trace:': [FAIL]=0A=
not ok 77 selftests: lkdtm: FORTIFIED_SUBOBJECT.sh # exit=3D1=0A=
=0A=
Am I missing something special(kconfig, packages etc). ?=0A=
=0A=
My kernel is v5.15 =0A=
=0A=
best regards,=
