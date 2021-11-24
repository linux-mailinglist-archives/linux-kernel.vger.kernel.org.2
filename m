Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7966745B8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbhKXLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:20:31 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:22425 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240887AbhKXLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637752640; x=1669288640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1llAIjTQ4nAXtit0NIJu+PorD9tWV19dG6JKu6FlgM=;
  b=eOCAWzyBTdgWP52o4GCBlp0DL7uyV3oyrGase0qYGn7+nk466J/UnvO2
   +z0OBdwZwA9Q20Z/jxu9UwtnOnFBux8fSfeiChqf2bPmJC3xTkujJzm+v
   wiCfcU3GgxzLDSEiSj0391i6UK01y4L8EDY9bkznZokzDee0BCy9lmYdM
   qaT3EMg0YxB+0orXke4tfRwTJjlzDACc8qraLeOJLwP+Z2HW8MNf8PDjq
   jHNJrq7OgjDHsB8+HjlGDKy1CSy3eJUXDbhwu+1LQCwliIwhBWe3tIv+C
   bUaXmyy5v4KmIToWCYvvo3tWBkM8fvxNdcFk5cfAUjgDeOkLZnlyjn4xj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="44427822"
X-IronPort-AV: E=Sophos;i="5.87,260,1631545200"; 
   d="scan'208";a="44427822"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 20:17:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOUkO3MIOzT8Yr023UZGZsRZ1cJ0d49IcnJ9CYx16ixUuOF8eNS+sSJaE3gcch24LgL4eZAjPWAbXrmqtbGD2Hc5ghFiNBw1k+b2i0YaPiQYPAShyad1cRfnlnE1ZrTDJvfXsNtsTUSFaIcFBRPBcBHc4MmlBXvsT5ZGX+t5vgB4sMbl5BY6tY3DfUcejRKZniCzqc+i7kqMCxWCHTJDc7q1hAh/TILMFfx3YQIExUHYmKUwcoha4MB0mhWQWofZBkJ3bGLJLurXxRtEo5LHIpuN96VQ2HLW6E6ogCokthqqaRh85uBLRE8YD46a/6ypxvrz5XLEYgeYrpkGMeXCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1llAIjTQ4nAXtit0NIJu+PorD9tWV19dG6JKu6FlgM=;
 b=Kql7KSOmPNVfMvBHyQpkPcAwVfGC1tTxBxdjEXAwOowJE858zYOzuouxGx8Bqmnfqw3vUkq+3qHqAMPdQQKC4OvjSZA8rUtKviLhyB3AqXhO8RoDUM0eoE2W6iG3jBtUFA8Xe7kvCJcnK51Rgx3QEN92Yjbo1JgcyTEaDbx1HhMRlfUg4ioRwIROmhfyEPwzsvqdTqWDRwCTlGO0gdbtlWEheLENaf0OMQUrQkGGJFXOLNi7BbMmodoKz0HAH4DLVQLawU3uhdQZ7JxGWPd8dUKYJmLxJZJ4NKifbRcz2uXTPXodi/qtsT0WSi/uY4dBhmuaJte76U44QiMMHBSaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1llAIjTQ4nAXtit0NIJu+PorD9tWV19dG6JKu6FlgM=;
 b=WTugxhAsLZB3VIcQpcXOKGTJfXNW9jp6v+X4k7OrIMUv/VlP79qOx6si956Ji5Wj/P64lGh9xthh6FwnowouOR2VnSCIuiXwVBsh9WBBtgte6USxNSiN9tO2NOQoiBzOYuzzBGkQVu811C1giC+Cfpoff7wgshZsuFUJdgcsDf4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB4141.jpnprd01.prod.outlook.com (2603:1096:404:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 11:17:12 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%6]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 11:17:12 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'soc@kernel.org'" <soc@kernel.org>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>,
        "'will@kernel.org'" <will@kernel.org>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'olof@lixom.net'" <olof@lixom.net>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About resctrl code rebase
Thread-Topic: About resctrl code rebase
Thread-Index: AQHXn1NwTLwp8TDbHk+k0EwVJVXXBKwTCk0w
Date:   Wed, 24 Nov 2021 11:17:12 +0000
Message-ID: <TYAPR01MB6330F3B97D23A214FB4DA7C48B619@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6330CE3CB67CF8F602D44D098BCD9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <97164928-e2d7-fd3f-e063-9174b028ed65@arm.com>
In-Reply-To: <97164928-e2d7-fd3f-e063-9174b028ed65@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9OGMyMjNmMDItZmJiZS00N2JkLWJhYjctZmY2?=
 =?iso-2022-jp?B?ZjVkYTk5ZGI5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMjRUMTE6MTQ6NDFaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b7e6138-af1e-4582-21c7-08d9af3bf687
x-ms-traffictypediagnostic: TYAPR01MB4141:
x-microsoft-antispam-prvs: <TYAPR01MB41417522B2A5BC52DB3A63198B619@TYAPR01MB4141.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lq0fgngB7JO9XpNDNTWC3zFASU9Nt6/Mp1OcxSZuqM3sSsNCDbqdwlffHc1SVkW8GW4+7vVzuROFgc9EVu1Yt8Tb+9b9yRxcw7xdcxElCy3YBhc4OeANgAvX1frxGL+9vu985oGxzKZBtQaPB98a5TaMtpWUbxpsFRgkdZL3sBjBsnxsxjfsBp/bDetKnz+PEjbZG8iArOxW/c9EJ7cNTOoKdan4tuejpyE1pyIOJNrWuN9H33dwp6PuDyke6EQBYHwicQDR6N1WZ2mwFu3BQzIMTq9eTCJtY09/+mujtEvf+ua79T23xJO+vbm/+dtylpVqZkVqXJ66WJODyzGAIgjiT7pPnEd+jTz6Mfii6FqWzqFE09L1NnTnXo5xMCMmk1y2vNBL/uVKPLiZzSJ1l7stt9MHm0mukqXNwv+MYiPDaLkKZK6BMR05rtVvgDNrHwt0UI1ujPqgTQ5F/gNqNKqj1/xUezXS1H0GdGKJqHO8xv2yMutQz3AzNp81YTR73l4C49f3+2El314EqWRVqFr6Ry3Ro6o8GE/Dvob8cnqe4vjqP3WxjaqJL7aXSafS0gw21R0C9+URe5kUIUU7aFGCocKMS1C92q9yhStvNw3EcbsdGGB7dRKt/XTyEGIPOvumpSKXVnhmHtG/f8WZa74lfHi7PAkyTM1K5h/+sxjgl7kowQfuSajQwrYhQc1HZvs4hdt6yH05BkacUzTtMLGMPAl/rikgluqmXhyfp+DVJSTnfwo7F/ZjaumWNlv2oE7S8BmCZ3NL3Ifb6Xaw+LGkZY+rDpdF8FXXPKlACe/p8izubzNAPmIBoVrARneLzrqwlisoV4bwsqJW++5Ejg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(71200400001)(7696005)(26005)(4326008)(508600001)(8676002)(6506007)(6916009)(76116006)(83380400001)(38100700002)(3480700007)(85182001)(52536014)(38070700005)(66476007)(8936002)(122000001)(186003)(66946007)(316002)(33656002)(86362001)(2906002)(966005)(9686003)(66556008)(64756008)(66446008)(54906003)(107886003)(5660300002)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eGo0TmJjeTBONXkxNWRSTHk2ZDNTUHNXK2NEYW1uNWVnclYyWm1jdUl1?=
 =?iso-2022-jp?B?T1RuVWw3aXBuZzJJOGZ0a0N5ZWMwTjhNRnVrWnZoZEs0ZnJSR3g4MVFQ?=
 =?iso-2022-jp?B?VkxpcTZOZ2lPLzI2UERVb09hTURiS3NRSjcxazRveEZWZFp2cjJBVFRK?=
 =?iso-2022-jp?B?Y2tSSnBhRlRxNi9YU1FvMDNqblVETmxJRmhaN0NOSnJRTGk5NE9iQW9C?=
 =?iso-2022-jp?B?YlVaN1J0R1dZSkFrcWVZRkptQnBmQmZWd2ovemV2STAyVjJyTUFlNU9r?=
 =?iso-2022-jp?B?eDVSYXlvcURvMUVGdytiaGNXc1JsSmhKQ08zY1pyM1BlejdVTWVma0ZU?=
 =?iso-2022-jp?B?N2x5Wkd3U3pKbEZnVVBwV0FIOSs4U3RYUkN4SmhXRUphQklGY2RHUVFC?=
 =?iso-2022-jp?B?VXZOcFhXWWxTTG1vZjkzTFdzTEVJRVJhVnFGUmJvVi8xRUF0NG51YWQv?=
 =?iso-2022-jp?B?U0IrMkk2NUZQOEtaRk9LeldVbFppSDFTUmNPcmZGMkZ3L3BxaUUyeTFT?=
 =?iso-2022-jp?B?WVpsakVLa3JWMDh1ZDBhMzVvQm52WmpxbE04OGpaL01MZ2dLSmlva1Ex?=
 =?iso-2022-jp?B?SnkyUTI0OEdEcUNzczZTcjhUWndGV1RvR3dsbFU4UXdzSUdoMVg1K3lS?=
 =?iso-2022-jp?B?V3d6dGJQSXJiZktrY3FKa29tWEpFbFRObnZ5NjVKNVpRYWlGdXltWFBP?=
 =?iso-2022-jp?B?Q3Q4czBuMCtuUW5RcmsxT2sxdHZGMnNZKzFTWHp4SnY4ajZPejZrS1Iz?=
 =?iso-2022-jp?B?ZmVHanJiRG01MWJ6UEd0WHRZRUo0ZjFxeWhjUGU3bGdKdGh4RXVKR3N1?=
 =?iso-2022-jp?B?T0FydTlSanB4RlBQTCtDNnZYOGtUdnpQcHJ4elhKcnB6WXBCYmd5cUNo?=
 =?iso-2022-jp?B?bTlwOGVHVHlGR1dDenB2VDE4UG5pT0pDQWtndjFrRVczK0tPUlNMV0hI?=
 =?iso-2022-jp?B?cXdsTGh2QVhveUcxT1lPc08zTndHa1hWYndYY281aE9ZeWM1ckhNRWZN?=
 =?iso-2022-jp?B?UzZjc21hN3ZrQ1BRQ0dlaFJkMGZ0V3N3NVlMR2lPZUF3eUZxTlhVOUtw?=
 =?iso-2022-jp?B?Y0RhQzRJWFBGdmxiQi9oK3VFcmg0S3M0T3JDSGE2WjdEZmxKZG41T2ZU?=
 =?iso-2022-jp?B?cVlyZ043ZllVSUJOMEt1MzF1U1YzUkMyNlEvQ1JJTjFTT2ZPYkFBakJi?=
 =?iso-2022-jp?B?aEE2SVZ3NnkxR3BEeXM5d0RFRVpYLyt5Z3VkZ3lwTnZEUk1URDhzMERY?=
 =?iso-2022-jp?B?b3hOUUsxS2cvc0NiV0hGeUYzb0g3NG0yNlhzQ2FWVW5WUkQ4dWZIQUxy?=
 =?iso-2022-jp?B?akZwTzJOb3VLNjM5aEhhNnE3cWpWMGJUZStIZ3hDY2UxcnlWZWIxTUVi?=
 =?iso-2022-jp?B?c2JON0NYWTZwaGNCd1JrZktGWUU2bGkzTWVLV2xOSEdMKzRKTm9qekg1?=
 =?iso-2022-jp?B?NnI1RTZrS2xHYllvRDlZNjJzZVRRS2xuaFIvcVI5a0RBS29vK0hKRjB0?=
 =?iso-2022-jp?B?L3lWaHU1eVQ0bzhHdE9yVGhrSklJSkRkTWVTMm9ZTko1Yjl2QUtQK2w1?=
 =?iso-2022-jp?B?U0ZHL0VRL1kzVkN4VG01T0dWY040QUZSWUxWRTYxVDd6cmlYb21ibzVv?=
 =?iso-2022-jp?B?WCt1MmRyVHZaMkpZRUFTeHBORS9OOWVsS3JSZUR4SFN4ek1HZTJxMVIy?=
 =?iso-2022-jp?B?N3gzdWM4T002c3hRUDJPT2ZiUlcyMGdteVVScUQ3V0tZQ2VzUStuTnMr?=
 =?iso-2022-jp?B?VXZrcStBcTBmclR0K0xRdUZua25jODd5ZkF6dnFnelhDbDZ2akFpVnB3?=
 =?iso-2022-jp?B?dVJiZHQ0TDJ5a3JJdk4yZ21mR3dXcUxPTTBmMWY1bzVFM3BkQlpyNksv?=
 =?iso-2022-jp?B?aXI2WFlnUUxFUkZaUSsvZW5OSytscW42TzZsZXYvYXI4cHhPVC9HTHRz?=
 =?iso-2022-jp?B?WFdJYlh0T3JNT2hmZTZwSDBwNUZiUTVvaXNURzZFRlVqMC9pNnA3Tmd6?=
 =?iso-2022-jp?B?clgwZUFWK3ljKzN6NWtjSStoMGdKSFByQ2JPSWxyREtlVG9oanRlY01G?=
 =?iso-2022-jp?B?NlZZOUo2NG4yVGRFVHVwYVdKRWV0SUthTUJwQXl0cFhCbjJHQkpRUy8y?=
 =?iso-2022-jp?B?KzgwOHlLN3ZNUFFpNXl0MkxIVndrRE40TmxDOTlSZE92MGUzVmcxWUxq?=
 =?iso-2022-jp?B?RmRSZURKZE1BRjNoNzI0S2RCQ0hvYjZ4dW0rVDJmQ2FKTWNSQ2xSWitp?=
 =?iso-2022-jp?B?SFlSRkljMnNUeXR4cXBIdnZ4V1pTTUp1K2NpZ1lsYmlQM2tlUjBSZ1A2?=
 =?iso-2022-jp?B?dis4SVpRVU12WWJ6eVN1YitZWFg2YzR4cFkveEJvUXcyWWEzSmpIYVBP?=
 =?iso-2022-jp?B?STJKa2R5TUdWb2M2MEl1eDRyeVRBczNyeTUxSTJ1WGtOL05BQ1pYMFB0?=
 =?iso-2022-jp?B?OGxwbElBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7e6138-af1e-4582-21c7-08d9af3bf687
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 11:17:12.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubIU8V4AU1KNF4HJKEfyPkZfAA7fg5+YoLj8scT0QJLhRi4NjxfVgLMJvGh6zh5kS4xdJXu959VN8I3lAxTPr4Tr+x61d5had3tu9qQ9J+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James
=20
> On 01/09/2021 09:35, tan.shaopeng@fujitsu.com wrote:
> >> As you known, Fujitsu is implementing a feature that add A64FX's
> >> cache control function into resctrl.
>=20
> >> Fujitsu will implement this feature base on your rebased code. I
> >> think the commit of refactoring arch/x86 implementation of resctrl
> >> has been merged into the x86/cache branch.
> >> https://lore.kernel.org/lkml/162871088112.395.12879267279872673224.ti
> >> p-bot2@tip-bot2/
>=20
> I'm afraid this was only a small part of it.
>=20
> I've also posted the next series here:
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /
>=20
> and there are a couple more after that.

When will you post patches v3? And are there any other patches after this?=
=20
=20
> >> I would like to know whether you have rebased these codes that move
> >> the common parts of multiple architectures to somewhere.
> >> And where is the rebase code?
> >> In addition, when will you release the latest MPAM patch?
>=20
> I will keep posting 'the next part' of the x86 changes once the earlier p=
art is
> reviewed.
> (please help!)
>=20
> I can't push the latest branch until the ACPI spec is published, but I ho=
pe that
> will happen this month.

Could you tell me when you are planning to push the rebase code?
Is there anything I can do for you?

Best regards,
Tan shaopeng
