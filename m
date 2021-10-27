Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23F43C8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhJ0Lh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:37:58 -0400
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:56480
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230336AbhJ0Lhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:37:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3J/xWgFR0Pv6UAsrqJEWkE/6gLdlsRPSC6moGRH85qBQTLzq0OZLCgoS7t6OYSgzpcW51lRC3efUtgHyxGn0YjXrPw68kbnFftSIxg6fmXeQvkRYCneDCLIWEu617W+mdrz5cnTciWnY6OtRFWuukJEpAWTSLqAoqoSdP656LuPw8zivBn4nIIYFHJh2MKGh/vFtd58abvN8d/I8dBihbm+T4Lq+WNrTcwVbdsScRmNXE0+1W+EfVzlfwveWeWJ+kdgWgw4CA+m8jjwHBEYak4Na6Dxt0JQ1gqm1KdoCxCNm095+UfpFbuSPVLAYheagUqqUET5oROSPzVVR701EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xfX9ZOo4Zf9MURh+btr6AWOLIMVv/wTFyBVPKPzt1k=;
 b=gX0iXw4F9t4H8n35BpRtKoVl2nSTSTI5koS77+c4UpYOJ2lI/TX8AUq2NRYwxlb9vegQoRxKKON08eVwXkyo17WOg65+PoA4NhuK7bd84rdKuKbJopt8vcLq7NHhJM4wafmc3aVNxvpCv2kGvT2SUhU/gTJYzEdbkraUfxoDqoZ8nw/ZJpP3hLbhiclQkltw5A0PY19swEJelq4PCa6PAkVyqpSR6MFT3Yn1TbI5lGzDJCUhuVSnkMoH/C/smpypFPTHIBtfp8RJnmJkYq6nkyeOqe9pGguKkL0FIqM2I90/8CS8wgqRUEOZvgO00B6/5ZDvGRUCLQqX3rTRXM+4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xfX9ZOo4Zf9MURh+btr6AWOLIMVv/wTFyBVPKPzt1k=;
 b=qO3FyJvqk9ZvF8eTIJ0EzWi/2bDMALqbsDIAUmmiNBv7dQ/KGE5zguSvMO2H5yE12BjTjCGsAkYDf2iqaLndhxpGeHKYaLZRN2soxPJD98ixzXW1X/iJq0Snaallg1q+Ocz3tN+rdKE3V8Ox85qqLrTGbF0ZoSTjz5jaMvY6quM=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB0655.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:60::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Wed, 27 Oct 2021 11:35:25 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 11:35:25 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/cxl: suspected null pointer dereference in core/bus.c
Thread-Topic: drivers/cxl: suspected null pointer dereference in core/bus.c
Thread-Index: AdfLJaDBodqHZTJVQG6Of5lGN9neHw==
Date:   Wed, 27 Oct 2021 11:35:25 +0000
Message-ID: <TYCP286MB1188F633AE0B7A52EB6917478A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea5e9ac5-8522-4bf9-3baf-08d9993dde7a
x-ms-traffictypediagnostic: TYCP286MB0655:
x-microsoft-antispam-prvs: <TYCP286MB0655EE162B9E46DB4FD2125E8A859@TYCP286MB0655.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/1vpjhRNHeBgiz3iVFIxJ8DPRwER+lwTPNrP2ziMjxy6g9JZ+JCaRgggQp3dWRX18jsA/wVvuMRznV2+uSEqkhC6P4v8FpVzM69fuXGPFOW37TWiBm+kb0FQ6dMnnU3ODgoUayoHX6zggdNETBZydQza/C5uosxe5Jy6wHGAHMa/7Oq/eEeTC9qbuA2VZGWei2EYq5Y4bb7Nz/bOgivFPBbEWSYBRLe+iZ+v52gi248IwytL9aEIFuyepHxOCLy9/Am046jR7t5dUfqFrozNpIpoWtscIrmJNGxc4XIVbxLSsOU42CMWy3JTjja6SNiDAcj1sWZtEmyD4nxe2poimCIAxvF0nfNNHOcIzWSVKwfiMyUXYmnAUPK9jYal0pEVVeqjbt6qG6UZF1w/fl24j2nNmfZ9Rw8nkFnZafQHYi0BhEnXUMTGFYw6DBnbLd5HOLYbMTxouf/gNcvXtlZGkgBsQxT5ozNKni53VARNr9cGxVPAUFVbTKO8jaFL/XkIHOE66ifVuID7B465NxBBZl8u0oN3XB/ThgQq3Hjis2/R+bw+/WGlbxBkxD5ad4Xi/Xj0kRtEK6HCJcPdYDIBlbxAut/CyxjtQc033AxBhzGcemhS30zs0gZqrry25bqH+/yk5XBk0kH4LV2nDUAwcQ1wEeFj16edjSTUk7SuAaQpFPgF7R0f//rHVbi6HYSVn3xPss4MOyrAQ5RlFd4QcV/XqV9d8qjbj+8e5+K92UEwKbuEo3gk2gIG1n2Exr6ou7qgvx1at3UaZs04/HNZc83QLhj+XQsWOOdaqsd1fY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(4326008)(8676002)(9686003)(2906002)(86362001)(76116006)(122000001)(38100700002)(38070700005)(4744005)(26005)(33656002)(8936002)(186003)(786003)(966005)(7696005)(6506007)(66946007)(5660300002)(66556008)(83380400001)(55016002)(316002)(52536014)(71200400001)(508600001)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YxyZ+tviI+ZRpg6Md4WHlEpd2Bbfr8W/dmOe3pdPWn0XGvD7vU8qiICZRZSs?=
 =?us-ascii?Q?yi83DusVhEI7piumjmNdTEnrO08AU0u9dUGN3Y9sNbWWGah8zeONC7JvNbkv?=
 =?us-ascii?Q?9wyNWUDkBDKRyvOpaJ1U15u30XS7Jf0Oljo+NkjYEXJwC9ZJocZmbzkdSy+a?=
 =?us-ascii?Q?cMCX3Ss1383Dvsw9yC/M4oMgikTnhtECtJEZekjmofmT0PQfTNUkAd34sRQ6?=
 =?us-ascii?Q?T6dRY5XJnEMkuX0Pin+mFxYvgV8Fp2sn+OmEJtZevTEqCUehQH99t/UFLkmE?=
 =?us-ascii?Q?l8/PItRO0LosB14hsAjW1vMnReougW6JAUAWDbe7E24KUqHQqW/nsUmvYVRV?=
 =?us-ascii?Q?6ha3gqpopaPCrnYxpAYnRzbCxMiwC0j2IPtBDz4NDBC8M7W4KjuVFbS1qQ+v?=
 =?us-ascii?Q?/F9yXFEUncIS8ub8yvSHIwAQfpHgHoFsZ4Kwd2n1wKgfCzQ1HgKNmJwN0wdT?=
 =?us-ascii?Q?gCknBR6Yd8tP42Tg2wcF+so16ikwcPlxSGtWshz2+fGL5IWtx4S+6FNTiF/J?=
 =?us-ascii?Q?Lno2z8ylFaQX7UOOlflp8qT0zW/EqEMHk9P5RmDT8pgQ3OeSM5/4oh/qybYv?=
 =?us-ascii?Q?Yi8XNfdtlzzAiZdXireh7yHT5pWUtrrZ0xayD8x3kBZZVVKZ6WrKY9nlN1Ll?=
 =?us-ascii?Q?h37OJ3i+uBq9yl8iS+pPmMFJITIqH0TnEJx5a21YIQH5IvfB6ZO5CZ4xPqDt?=
 =?us-ascii?Q?KOGy8SaNbrJc+l8iAy6U+XI21UVlEaRRk+Z+jaStwGWNLPJpDG8cflEKMbFP?=
 =?us-ascii?Q?UUfy41YoobsZLrbgYsMVBDjSr/WFbSoQ3Z4Lp+rVXoTm/VA+gLkUB9bX/JXf?=
 =?us-ascii?Q?oMxHFn0V/+MDYWXWjkfffVXAnBMYH8qj3VkuTcuke4vmNybi+xaZMh9Y71P4?=
 =?us-ascii?Q?eItqG0CdGS6m7Jr9jmWA6q8NQi1IbJNDbwNIZIeesfWB+bzmv0FuQoVfwrEW?=
 =?us-ascii?Q?tSN43hvO217L7YKE1c9MItVkhUumSMPJJud1YsGj0MP5wW2wg4Pr5118tkuE?=
 =?us-ascii?Q?UWz+++GdzaYcKw7vb4zwEj1QVAw+TIDD336XR2nNpRzRnlk+9aJYcTSxfUzb?=
 =?us-ascii?Q?jJFvHVjysbQtfk5KtWCA7tLLZmY/xRqeeQp6Dtsgb/y0G71Lf9AVhvCFpm54?=
 =?us-ascii?Q?hPFqtpCZCw8zVwTF+ccdz4gMeImd9elcpp2ukAW20ap+d5jBa1bLu0u067Az?=
 =?us-ascii?Q?ZTZpMbLXC5RajGUWthvfqpKxw0YKiF6kteAVnqoM4hmaGmvZk6LJsAOlOxnb?=
 =?us-ascii?Q?DytdTAWNKHsUMA8N7MgIq3+R4o+HYGBbkkonsjdPKd8Ay9LphmN5tLNWpV+h?=
 =?us-ascii?Q?ZDah6oUuwPebug0rEzbF29iBgPWrxLuJtYALwbTzLmR3qjEWHcOf7I48gTje?=
 =?us-ascii?Q?RXs6h0yopWV2B3dU5pZUXz7SdSRbFHFPhjZrq8F0BUhyFLyb9VmOc0HTjcOD?=
 =?us-ascii?Q?EslGOHuycQS2vhp9Fq2X7ztCYp2DnyUUOpV2AAP8Kr8bdt0fRGHyAlFTE969?=
 =?us-ascii?Q?ema+PTi9iVz6/qLGj1dijKWAsLO2rWAW3OJKhwy0OF4ZtsgC6jHgafCQH1q8?=
 =?us-ascii?Q?VNUr8YLG5nvmcQjG7l5lkQJ5uwtX4IOU574sb7Y6jGyZEARHW5N/LIRqhLKv?=
 =?us-ascii?Q?GOBmqs9f8OJ8YI3QgSnhjKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e9ac5-8522-4bf9-3baf-08d9993dde7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 11:35:25.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw4sJj1vS8zuHXDI7xgjzjXYPK6pkKI+HqHSXMjBiIatCKl5ntkk3QSUMN0rBCe9L4N9EFtChOi9rSxFttLu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/cxl/core/bus.c#L98

We notice that in multiple call sites, the return pointer of to_cxl_decoder=
 is not null-checked, could it be a potential null-pointer-dereference prob=
lem?

This is detected by our experimental static analysis tool, it could be fals=
e positive, we manually check and report those we think may be true issues.=
 Would you like to have a look at them?

Thanks so much,
Chengfeng
