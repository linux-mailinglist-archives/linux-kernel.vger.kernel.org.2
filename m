Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DAF33EEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCQK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:59:31 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:39694 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCQK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=12654; q=dns/txt;
  s=iport; t=1615978758; x=1617188358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BIfT7AbEVFE/RJchNr9LMS+jb6t19XauqcE8iTPipNA=;
  b=BqyphX9dKEU30dmfQ6vQQZqV2LTGPbuNsoZO65G/y0p+tJXKVmpCytCq
   /ZaUFNyHtbtkEBc7OXwic2tBWu5g1yyXNQsf4Zt3PgzrWe31ZkMKzlZgk
   v9PrsA8nRisVZblyfTWdB7nfAyTggCFSecNTk6I55vyPQxXjjPLm6XXHn
   M=;
X-IPAS-Result: =?us-ascii?q?A0DzBAAD4FFgkIkNJK1agQmDI1F9WjYxCogAA4U5iEMDm?=
 =?us-ascii?q?S2CUwNUCwEBAQ0BASASAgQBAYEWAYM5AoF2AiU4EwIDAQEBAwIDAQEBAQUBA?=
 =?us-ascii?q?QECAQYEFAEBAQEBAYYLCCUNhkQBAQEBAgEnEwYBATcBBAsCAQgOAwICAQEBH?=
 =?us-ascii?q?hAyHQgCBA4FCIJoAYJVAw4hAaB5AooedYEBM4MEAQEGhQQYghQJgTmCdopNJ?=
 =?us-ascii?q?hyBSkKBEUOCWD6EQQKDSYIrgjkLB1MoEwETEFhQgRmQV4MTpk8KIYJjiVKTG?=
 =?us-ascii?q?INAgTuJJQSVerdTAgQCBAUCDgEBBoFrIYFZcBWDJAlHFwINjC2Bfg0JgzQZh?=
 =?us-ascii?q?nGDaHMCNgIGCgEBAwl8jnMBgQ4BAQ?=
IronPort-PHdr: A9a23:/cEYZxPjRF/AlJQ4lyol6nfxWUAX047cNxMJ6pchl7NFe7ii+JKnJ
 kHE+PFxlzfhR4jX6/tYzeHRtvOoVW8B5MOHt3YPONxJWgQegMob1wonHIaeCEL9IfKrCk5yH
 MlLWFJ/uX3uN09TFZXkalHSq2H05jkXSV3zMANvLbHzHYjfx828y+G1/cjVZANFzDqwaL9/N
 lO4twLU48IXmoBlbK02z0ihnw==
IronPort-HdrOrdr: A9a23:DGBNc6BKpVyUgQblHejdtceALOonbusQ8zAX/mhLY1h8btGYm8
 eynP4SyB/zj3IrVGs9nM2bUZPgfVr1zrQwxYUKJ7+tUE3duGWuJJx/9oeK+VPdMgXE3Kpm2a
 9kGpIQNPTZB1J3lNu/xQG+HcopztXvytHWuc715R5WPGZXQotn6Bp0DRveN0VwShVPC5ZRLu
 vj2uNsoT28dXMLKvmhDn4eUOTZ4/HNnpTqYRkJbiRXqTWmpzWu9bL8Dlykzg4TOgk/j4sK3E
 rkt0jC5qulu+ym0RO07Q/uxrlfhdeJ8Ko5OOWikc4QQw+c7zqARIMkYLGauSBwnefH0idXrP
 DpgzMNe/t+8GnQeGbdm2qs5yDF3Cw143HvjX+06EGT2/DRfz4xB8pfiY8xSHKwgCBM0KAeoc
 B29lmUuJZNARTLkD6V3am0azhRikG2rXA++NRj6UB3bIoEZLdd6awZ8U9Fea1wZB7S1YE9HO
 FiSPzb/fZdGGnqFkzxg28H+q3JYl0DWjO9BmQSsM2c1DZb2FpjyVED+cAZlnAcsLogVpht/Y
 3/Q+dVvYALavVTQbN2Be8HT8fyIHfKWwjwPGWbJkmiPL0bOkjKt4X87NwOlaOXUa1N6KF3tI
 XKUVteu2J3UVnpE9ey0JpC9Q2IZ2mhQzL3yIV764JisrPxAJrnWBfzDWwGoo+FmbEyE8fbU/
 G8NNZ9GPn4N1bjHo5PwknwQJ9XJX4CUNAEu9oyVl6Uy/i7bbHCh6j+SrL+NbDtGTErVifUGX
 0YRgX+I81G8wSqVxbD8V7sckKoXna60YN7EaDc8eRW4pMKLJdwvg8cjkn84smKLDZFo7EnZU
 cWGsK/roqL4U2NuUrY5WRgPRRQSmxP5q/7bn9MrQgWd0XucbgCvN2bcXtI3GSOIwJ+S8++Kn
 8am31HvYaMa7CAzyErDNyqdkiAiWEImX6MR5AA3rGY6dz9YZM+BJY+UKl3HQHGfiYFwTpCmS
 NmUkspV0XfHjThheGZl5QSHvjYbMQ5qhysO9RopXXWsli8qckjSmAAZSOnVdeajG8VNmFpr2
 w015VaobKb3R6zNGM0gY0DQSxxQVXSJIgDMSOoS8F/nKvxdAR5UGGQ7Abq+y0bSy7N7EUdhm
 voMCuOX+rEa2At4Exw4+LN7E5+cHmbcgZWbH132LcNSVjuizJUzfKBYLa13i+qTmY6hssZMD
 3DfFIpU15T7tiqyR+YnyuDH306xpMoevfQFqgnbqu74ALfFKSY0a4BBPNa55BjKZTntfIKS/
 uWf0uPICr/EP5B4X3Zml81fC11omIji/XmxVns63W5xmc2BZPpUR9bbqBeJ9GX9G7/QfmUlJ
 1/kNIupOO1dmH8cMSPx62SbzlNLHro0CSLZvBtrZBfpqQpsrRvW5HdTDvTzXlCmAwkM92crj
 JpfI1rpLTafoN/dc0bfCxUulIvidSUNUMu9gj7GPU3c10hh2LSVun5r4bguP4qGAmMtQHwMV
 6Q/2lG8/DJUzCK2LQaB6gzSF4mIHQU+TBn5qePZofQAAKle6Vf51K8KGa6a6IYR66fG7kcxy
 wKrO2gjquSbW7/1w/Rtzcgff4L/GajXM+oAAWDXeRP6Me3PFyQgq2spM6/5Q2HPQeTegAdn8
 lCc0dVc8FIzj8lh4cz2jKpSqP2rlk++mEuqA1PhxrowMy+/GzfHUtaKgXXjZVdQClLPhGz/L
 H42Pnd0G64/SNM1pbCHlpBZ91CG9AfSY7sMidlQPJgy4KA7u4omSRMYBAnEm46hnT8xopdrM
 WE5Mk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,256,1610409600"; 
   d="scan'208";a="704138938"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Mar 2021 10:59:17 +0000
Received: from mail.cisco.com (xbe-aln-002.cisco.com [173.36.7.17])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 12HAxHxw031766
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Mar 2021 10:59:17 GMT
Received: from xfe-aln-002.cisco.com (173.37.135.122) by xbe-aln-002.cisco.com
 (173.36.7.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Wed, 17 Mar 2021
 05:59:17 -0500
Received: from xfe-aln-005.cisco.com (173.37.135.125) by xfe-aln-002.cisco.com
 (173.37.135.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Wed, 17 Mar 2021
 05:59:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-005.cisco.com (173.37.135.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Wed, 17 Mar 2021 05:59:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU7zL77MUhQ5Qk3oOQtFG49qWh7vzeGg2JKIHMkoBq6DKdbU9xZzD+iu4a71/KvmbY3V8YDFXxmmEguQ64QCNX4Scir5DuRK78A+PDUYGFdfjTRKWf7mLpKupwFfYO4vUo8sEMW2dpvyA3rwIbOFn4r/UcOJgzBVKi0elMzP0iCFSIN3NPIrKa/txRrttn/zjN2cEocYy24B1AOKrBvq1tq//y0kA8QbxDqY+ASjibdb6JJei55N2mMIQ0emQCMGgfe3ZuHmJo5QTKQCsnnj/8Iit+9AmSECrt+gWn4cG45dbvzvo51WTb3MeWWzPYqUvWhCUUUk7c1qIFIgS+zN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syaby9oJYskqvXY0mu6EfsgShIeFBNG+cvfzw5f87IM=;
 b=hqTfevK1Ky6nyNqsDXTyLxaLiZsWhztEk7zbZYaLg0Tyj+stF+ddHEVGKKGyX5o9qe/jje4fUxwwN9yZWru1pjAC0iCf7o83OqKeoGux8fXNlgpXSbWb+wMSpPWUgPXXuwl/cHtGqEe+jx4xLNr22LfsT/iWBwbdvn8Nnp6Vn1I4kKcb62cwe3q546xtbUl/8dKFDVnkMAB4YxLjq3G4+eqkNN+z+NVGyqIbj+cgFv+Nbfaps2j1Ey3PWSMerT3gfQdrQN60GBzAZuRMuQBrv2SYbFUTcjSQSnGDVwdxlrGxXpiZPEptzwGlFS/wEOs5B0zMm8i9gSNKAyDz3FBzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syaby9oJYskqvXY0mu6EfsgShIeFBNG+cvfzw5f87IM=;
 b=fIqAEBqXLkhnmD3fk0iLyO0LRP+ookI69kDjks84CTsZqd3Cuj0pv60Y+iwWBpOF4yBkhkDz0vILnwiNyvTDb0wyLpJdJSCu0lSiLdFL8y3JvyJnTRTKvwKV9oIGs/woxO/haXVOsU7LVpWHVeZviQ04YvvuLHOfWlAdw2F9f1U=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by BYAPR11MB3799.namprd11.prod.outlook.com (2603:10b6:a03:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 10:59:15 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 10:59:15 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf: build reproducibility improvements
Thread-Topic: [PATCH v2] perf: build reproducibility improvements
Thread-Index: AQHXGcE7kgnyH+4E+0m6Z4V0aosUgKqH/vPM
Date:   Wed, 17 Mar 2021 10:59:15 +0000
Message-ID: <BY5PR11MB4024B1E617096A3232435FA1D96A9@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210315164635.119575-1-dzagorui@cisco.com>,<YE+aLdhcXJv5jmKK@krava>
In-Reply-To: <YE+aLdhcXJv5jmKK@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61ca457-32ef-4dde-c313-08d8e933b488
x-ms-traffictypediagnostic: BYAPR11MB3799:
x-microsoft-antispam-prvs: <BYAPR11MB37998E14AE73EFD6D7C9B994D96A9@BYAPR11MB3799.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qiQGKayvReU52RGDX7aFYp4H+inInDWzwpUkdpKcTqglyY9QdVmYI+QJT0urHFgI1LxjKWONy4v3uecqsgt8CqmxQjb9OZJ4qXTox3Ttwxk9TWtOhSfpCoTovRHttSBS7BDInhoOXWSrXh/tk4NzaI9GIerk2dzQmfhZC2XHa2XD5gnpsJFbJXZk+v2SGlA1XRpxkxVY1ngNKiCAxDv5AcayBuud60mhAcLbCLXJvrBsfXFpJoU46yroJwuv29VxOC+IiPouCNB3Vi/24lsVuO8l3E49h2a2npecHj7dhya1ymBW/b36X4K7Xfd3zpdTSBt1VxE5nXgmk1Sewmy0xejaBhbNA6DS3bU78/ftdkvSW83+T/ZVfj2dUDvTtKOeTzZtWBbi1ZmUFUeYYfSvjwCxBEoyMobxtcXq7AFyQNnz8wFmxOEOmjxyThowd+dJIXubV3hHjpxWzC4gHbbgPsd6k8I5xSfydLhFj4R/pyZwYIKWO/tdynLf8V+X3Ey64r/IZdj2UNH9O6fL1R/o8QMGfU7xc9JkHcnJCg8OTdAA+ag62Dnkl5/IhNMj++B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(478600001)(71200400001)(7696005)(55016002)(86362001)(26005)(66476007)(6506007)(53546011)(64756008)(66946007)(66446008)(66556008)(9686003)(30864003)(5660300002)(186003)(91956017)(8936002)(54906003)(8676002)(316002)(33656002)(66574015)(2906002)(6916009)(83380400001)(52536014)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t/rI5dZglD1Ucuf32n7v32oVaD7nq2JeywCKKvkBOP7RUT69oh9531egTUgy?=
 =?us-ascii?Q?pd2vyRkXAbp3u9lBUvuT8F/KM3WPE3FFnGhCLgXCKvu1d0lT742rS8GOdlxX?=
 =?us-ascii?Q?x2uI+NokoLkgGOME8B6ZWi5XkCS+vN5p2Aal0TNeJi3SjozWjIqhShLTQUEG?=
 =?us-ascii?Q?j+jtFubyTP//uiVTt5Gh2LFzV7jrrrTrt/GaMqp2wtw+XuVfnLSMfmU5mLz+?=
 =?us-ascii?Q?5iWMl9gD07Kp0tqfbvDurWknJ9Wuq/sPGmDkWnXySU3vdSlYj3bPMy17/SF1?=
 =?us-ascii?Q?VxnSxVG3IPztNorejZ+2UW+MAED1r9wfIO2y/yR6PqhP1eOOK1rve/qSllXe?=
 =?us-ascii?Q?pe6loqzohqbC9/RQxa8iWikmpMRcXSD8k1h5r9bFc4ghvDb+bcdXNWJC2/uN?=
 =?us-ascii?Q?PYCTl1p6c1zaUgxt0cWNdW2pC5VEuugzFkcN/mhcj4hwTzjCA0dR87z3hoxP?=
 =?us-ascii?Q?ZwEQdJRT1jMoBNldRfgQPo5PFK5kSn2IWaghRPqQcwyzBNvbYBeaX5E+AuXz?=
 =?us-ascii?Q?K6ViCT8xhC3J9CxrqnQkEGHteuE+oXoNIiXYoZ4yV47GpK+WuHs7Iu+nAUr+?=
 =?us-ascii?Q?lvk9ToJ87iXI2BeJh0l5YbNbdYDyI/AIqDbKabbTI5AAqo9kFP7yznBguYwe?=
 =?us-ascii?Q?NxfRL6Pf5iG824QOrb/29tTyHQduvUb0xxFTGyE2CWCoUpO6xVMC+wAkxUYG?=
 =?us-ascii?Q?8nR/F42L9BKh/CEaUHqEnWwwZgvFuXljdzkFSFmSZ3U7YKsWRQJZ4uXdWO33?=
 =?us-ascii?Q?Lxou4RvQAqrM8kSGh+72OMxjPMw4j7gpC2cOxBtyScMdDw0RPOLLCsN6Efqn?=
 =?us-ascii?Q?B7byCZP/jWCcxuBkdkrO0hvDLrJ4EramLvHDZkMTb6XvZ4Jnxk67KZE4P72Q?=
 =?us-ascii?Q?FBFA4cznxd71MwjY4FMZv8t7VVbyKoaRE+ilf+oSQ6uJk/ZHxtZm864c5Spn?=
 =?us-ascii?Q?BQRMhwjIeVZxnpze+BL2vWILtE0lEl5tssO29Z/b41paSbwZgwZc7Gw2NOnk?=
 =?us-ascii?Q?zi/3JktAoPHrXW3CDheLw9Q4/uCePPFA0l7o4tRm/WxUHTEWrU/kZEQE2Hdv?=
 =?us-ascii?Q?XDoOuIpXEpli0owaGfZ8Ut0JMasX0RGQPqcQJ7Vi28Q/Uu4BNMsnfEO9XrZq?=
 =?us-ascii?Q?DixKkDHdMmwYihbgNzIE+O4FfKDrcqRMxm1x+AAZAvu/zeSxG/yGJK5UCYO1?=
 =?us-ascii?Q?gz+Lu78o40UJX1R82c4jm+J+gxJMjqlwccp1GMWzanDHHW66xFT8E9LgCUpU?=
 =?us-ascii?Q?jaicc6si7zl2mKPp3spcl9hQep5WoJ9HTi7rfzRyOCUNr0orGcn22mWoRf61?=
 =?us-ascii?Q?AWo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ca457-32ef-4dde-c313-08d8e933b488
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 10:59:15.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wj7mufZevsf5ixX9pDcxB08oNbL7NlHeCthxcuJYvPXj5lA5TUYV4SfoR7BAT/Yni/hcl7Ipo5A08w3Fz7jIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3799
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.17, xbe-aln-002.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f6e609673de2..c9e3aae6c47f 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHO=
N_EXT_DEPS) $(LIBTRACEEVENT_D
> >          --quiet build_ext; \
> >        cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> >
> > +_dummy :=3D $(shell [ -d '$(OUTPUT)Documentation' ] || (mkdir -p '$(OU=
TPUT)Documentation' && \
> > +             cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documenta=
tion/'))
> > +
>
> why do we need this? also should be in Documentation make

I added this for case when we build perf with O=3D . Further in runtime per=
f will try to find tips.txt file
in Documentation directory. Documentation has to be in the same location as=
 perf executable. If we
build perf without O=3D option this copying is not needed as Documentation =
is already in the same
location as perf.

> > diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-us=
e.c
> > index 98c6d474aa6f..8b4865c90d5d 100644
> > --- a/tools/perf/tests/python-use.c
> > +++ b/tools/perf/tests/python-use.c
> > @@ -8,16 +8,28 @@
> >  #include <linux/compiler.h>
> >  #include "tests.h"
> >  #include "util/debug.h"
> > +#include <subcmd/exec-cmd.h>
> >
> >  int test__python_use(struct test *test __maybe_unused, int subtest __m=
aybe_unused)
> >  {
> >        char *cmd;
> >        int ret;
> > +     char *exec_path =3D NULL;
> > +     char *pythonpath;
> > +
> > +     exec_path =3D get_exec_abs_path();
> > +     if (exec_path =3D=3D NULL)
> > +             return -1;
> > +
> > +     if (asprintf(&pythonpath, "%spython", exec_path) < 0)
>
> are we sure there's always trailing '/' in exec_path ?

Yes, it should be. /proc/self/exe is a absolute symlink to running executab=
le

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 15 March 2021 19:32
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; mark.rutland@a=
rm.com; alexander.shishkin@linux.intel.com; namhyung@kernel.org; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH v2] perf: build reproducibility improvements

On Mon, Mar 15, 2021 at 09:46:35AM -0700, Denys Zagorui wrote:
> This patch helps to make perf build more reproducible
>
> It seems there is some need to have an ability to invoke
> perf from build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR contains an absolute path to kernel source directory.
> In such case this path can be determined in runtime by using
> /proc/self/exe link. In case of building perf with O=3D
> Documentation/tips.txt can be copied to output directory.
>
> There is also python binding test where PYTHONPATH is used to store
> absolute path to python/perf.so library. This path can be
> also determined in runtime.
>
> bison stores full paths in generated files. This can be
> remapped by using --file-prefix-map option that is available
> starting from version 3.7.1.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/lib/subcmd/exec-cmd.c   | 21 +++++++++++++++++++++
>  tools/lib/subcmd/exec-cmd.h   |  1 +
>  tools/perf/Build              |  1 -
>  tools/perf/Makefile.perf      |  3 +++
>  tools/perf/builtin-report.c   | 21 ++++++++++++++++++---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 14 +++++++++++++-
>  tools/perf/util/Build         | 10 +++++++---
>  8 files changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
> index 33e94fb83986..3116246ec629 100644
> --- a/tools/lib/subcmd/exec-cmd.c
> +++ b/tools/lib/subcmd/exec-cmd.c
> @@ -208,3 +208,24 @@ int execl_cmd(const char *cmd,...)
>       argv[argc] =3D NULL;
>       return execv_cmd(argv);
>  }
> +
> +/* The caller is responsible to free the returned buffer */
> +char *get_exec_abs_path(void)
> +{

we have perf_exe for the whole perf binary, so let's call this perf_exe_pat=
h

> +     int ret;
> +     int i;
> +     char *buf;
> +
> +     buf =3D malloc(PATH_MAX);
> +     ret =3D readlink("/proc/self/exe", buf, PATH_MAX - 1);
> +     if (ret <=3D 0) {
> +             free(buf);
> +             return NULL;
> +     }

you could call perf_exe for this ^^^

> +
> +     for (i =3D ret - 1; buf[i] !=3D '/'; i--);
> +
> +     buf[i + 1] =3D 0;
> +
> +     return buf;
> +}
> diff --git a/tools/lib/subcmd/exec-cmd.h b/tools/lib/subcmd/exec-cmd.h
> index aba591b8d254..9dc98248dadf 100644
> --- a/tools/lib/subcmd/exec-cmd.h
> +++ b/tools/lib/subcmd/exec-cmd.h
> @@ -13,5 +13,6 @@ extern int execl_cmd(const char *cmd, ...);
>  /* get_argv_exec_path and system_path return malloc'd string, caller mus=
t free it */
>  extern char *get_argv_exec_path(void);
>  extern char *system_path(const char *path);
> +extern char *get_exec_abs_path(void);
>
>  #endif /* __SUBCMD_EXEC_CMD_H */
> diff --git a/tools/perf/Build b/tools/perf/Build
> index db61dbe2b543..56d0189f1029 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -45,7 +45,6 @@ CFLAGS_perf.o              +=3D -DPERF_HTML_PATH=3D"BUI=
LD_STR($(htmldir_SQ))"   \
>                             -DPREFIX=3D"BUILD_STR($(prefix_SQ))"
>  CFLAGS_builtin-trace.o          +=3D -DSTRACE_GROUPS_DIR=3D"BUILD_STR($(=
STRACE_GROUPS_DIR_SQ))"
>  CFLAGS_builtin-report.o         +=3D -DTIPDIR=3D"BUILD_STR($(tipdir_SQ))=
"
> -CFLAGS_builtin-report.o         +=3D -DDOCDIR=3D"BUILD_STR($(srcdir_SQ)/=
Documentation)"
>
>  perf-y +=3D util/
>  perf-y +=3D arch/
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6e609673de2..c9e3aae6c47f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_=
EXT_DEPS) $(LIBTRACEEVENT_D
>         --quiet build_ext; \
>       cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>
> +_dummy :=3D $(shell [ -d '$(OUTPUT)Documentation' ] || (mkdir -p '$(OUTP=
UT)Documentation' && \
> +             cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documentati=
on/'))
> +

why do we need this? also should be in Documentation make

>  please_set_SHELL_PATH_to_a_more_modern_shell:
>       $(Q)$$(:)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..d9441055357e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -610,12 +610,27 @@ static int report__browse_hists(struct report *rep)
>       struct perf_session *session =3D rep->session;
>       struct evlist *evlist =3D session->evlist;
>       const char *help =3D perf_tip(system_path(TIPDIR));
> +     char *exec_path;
> +     char *docdir;
>
>       if (help =3D=3D NULL) {
>               /* fallback for people who don't install perf ;-) */
> -             help =3D perf_tip(DOCDIR);
> -             if (help =3D=3D NULL)
> -                     help =3D "Cannot load tips.txt file, please install=
 perf!";
> +             exec_path =3D get_exec_abs_path();
> +             if (exec_path =3D=3D NULL || asprintf(&docdir, "%sDocumenta=
tion", exec_path) < 0) {
> +                     docdir =3D NULL;
> +                     help =3D "Not enough memory or some other internal =
error occurred!";
> +             }
> +
> +             if (docdir !=3D NULL) {
> +                     help =3D perf_tip(docdir);
> +                     if (help =3D=3D NULL)
> +                             help =3D "Cannot load tips.txt file, please=
 install perf!";
> +             }
> +
> +             if (exec_path)
> +                     free(exec_path);
> +             if (docdir)
> +                     free(docdir);
>       }
>
>       switch (use_browser) {
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 650aec19d490..a20098dcdbc4 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
>  CFLAGS_attr.o         +=3D -DBINDIR=3D"BUILD_STR($(bindir_SQ))" -DPYTHON=
=3D"BUILD_STR($(PYTHON_WORD))"
> -CFLAGS_python-use.o   +=3D -DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -=
DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
> +CFLAGS_python-use.o   +=3D -DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.=
c
> index 98c6d474aa6f..8b4865c90d5d 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,16 +8,28 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include <subcmd/exec-cmd.h>
>
>  int test__python_use(struct test *test __maybe_unused, int subtest __may=
be_unused)
>  {
>       char *cmd;
>       int ret;
> +     char *exec_path =3D NULL;
> +     char *pythonpath;
> +
> +     exec_path =3D get_exec_abs_path();
> +     if (exec_path =3D=3D NULL)
> +             return -1;
> +
> +     if (asprintf(&pythonpath, "%spython", exec_path) < 0)

are we sure there's always trailing '/' in exec_path ?

> +             return -1;
>
>       if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); impo=
rt perf\" | %s %s",
> -                  PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null")=
 < 0)
> +                  pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null")=
 < 0)
>               return -1;
>
> +     free(exec_path);
> +     free(pythonpath);
>       pr_debug("python usage test: \"%s\"\n", cmd);
>       ret =3D system(cmd) ? -1 : 0;
>       free(cmd);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e3e12f9d4733..11ad0fdaf71e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -197,6 +197,10 @@ CFLAGS_llvm-utils.o +=3D -DPERF_INCLUDE_DIR=3D"BUILD=
_STR($(perf_include_dir_SQ))"
>  # avoid compiler warnings in 32-bit mode
>  CFLAGS_genelf_debug.o  +=3D -Wno-packed
>
> +ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.=
\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\=3D 371), 1)
> +  BISON_FILE_PREFIX_MAP :=3D --file-prefix-map=3D$(OUTPUT)=3D
> +endif

seems too small for feature detection, but please add it to
Makefile.config and make new variable under .config-detected

thanks,
jirka

> +
>  $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: uti=
l/parse-events.l $(OUTPUT)util/parse-events-bison.c
>       $(call rule_mkdir)
>       $(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex=
.c \
> @@ -204,7 +208,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse=
-events-flex.h: util/parse-
>
>  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: u=
til/parse-events.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/parse-events-bison.c -p parse_events_
>
>  $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPU=
T)util/expr-bison.c
> @@ -214,7 +218,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: =
util/expr.l $(OUTPUT)util/e
>
>  $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/expr-bison.c -p expr_
>
>  $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)u=
til/pmu-bison.c
> @@ -224,7 +228,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: ut=
il/pmu.l $(OUTPUT)util/pmu-
>
>  $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
>
>  FLEX_GE_26 :=3D $(shell expr $(shell $(FLEX) --version | sed -e  's/flex=
 \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\=3D 26)
> --
> 2.26.2.Cisco
>

