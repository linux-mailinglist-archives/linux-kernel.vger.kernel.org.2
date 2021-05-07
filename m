Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5EC3761EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhEGI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:27:04 -0400
Received: from mail-dm6nam08on2072.outbound.protection.outlook.com ([40.107.102.72]:41537
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236175AbhEGI06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHWJRtseG9q0m/ITknvfKEBbnTqJwZHz01utG0gUDfOZLlzm4tJtOlF7pN55ZJaslXpXCpmi3sFIg6ixao8zAdSrbjPCjcTfEj7NFrt9KTEOX0J7qFj/1RkVwrBcHaV3kQwb8Pz/VQWK1Q/26e3OeHhuo3W1Hk/hE4F779PYHWc33F/Lcu3/7R/esewjCl2KW1r5dtcBm/3BBE3z/jcyjbO+Q6kT14mG00hxj9ntHJ4xZnMjmq/qkHYg3g/YsrwMOFrNFqHct5jiW+zsTzwuIBIXRSQF/RgvzmgIKh7VfJPDuBbP9GVAtlQIhDxtAx0aDf3Q1gUCirjCXmtf0yrEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZ4PDa2x4GR/BqCrzN1imhuJ8YpYKWyTARerSc1dV4=;
 b=AMdc4GFiRi2PTOvv9u7h2NSP4s2Lrymf1mr2fWC72oP0kH3qjYhj4HKXGjOmq8GV3IiM+GLu2sa3ZpAeatNrfTH8pb5QonAyoilyHlyv6yqMDk4E0nAeW21UVRsSkrp9QWX5kN35VDX1GEtiRW91omEtrzt3ld5kuRuIxhW8m98rwAfPxJXK3TPUZqvld3xkwUA14P3kgwnX6KELVa6WDGkpO8x7eTkwFdhL5djeJegMBsnGtrItS9aldYEg4K/4gvgBoeavVafyvyq6aRm1SvthAqExCrZCbHFM+7c+HZH4xY5Hd9tbhCzJI+ksUIyQrIBz6em2zTL2Iw1cv/OMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZ4PDa2x4GR/BqCrzN1imhuJ8YpYKWyTARerSc1dV4=;
 b=JZOEdQMVOuPwNDp6CC2/puEV6tx4Gg8E+Gc7PgQeqVkREfozJCmcZPxvTqYczBJgAMIoKX2hPPCzsuxMtzOJNs3ZFoLMsWR4Fe8otv/fwzsR3Q8GKEz1MmWFz0V4eDLTDBpwfdHzgau2hQdI1WMGKjbGuAV9YM+Msnhe7UXgRI0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2144.namprd11.prod.outlook.com
 (2603:10b6:301:51::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 08:25:55 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 08:25:55 +0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: Concern about Documentation/usb/linux-cdc-acm.inf and
 Documentation/usb/linux.inf
Message-ID: <9d7bb262-1d0d-0961-7211-157c99add96c@windriver.com>
Date:   Fri, 7 May 2021 16:25:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 08:25:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1caf9829-f547-42f2-e088-08d91131bc07
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2144:
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2144D0B8EA1AA20CA6A245DD8F579@MWHPR1101MB2144.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Vm92GMntjW3zgh51/Jsv3wqbs+FAh+7oX8ys+8x9UGSJj9PIaztdPWEwdoP+kEMm1fbLrmH1mwockk77UbGjQqYYDIVRc5DujfCtilBkz0bkZfgskwnD5WQQ6wCImbnWZAZ0k311a8LB/+RDYZv4FtPo43Kt/hGjy2oDzhBqhnDCqywPDi8vgOn2yPjh9pOp1jNXa3OQEziOr0i46B+qe19IevTKhXkiGJbvwX6gl++8HxCk133nTM926FP8B9Sani4e11TdjtESRShVasGT3qx/pLLPWAcWZayBJzl+hRF6kXelUyzmyB67PrDyd+cxcImknvyIxd2fvfmJvD99cU5nmRhvVXIEjkunCWUo5/Ueba/c7UScrZss7PqUJy5rG532MByYHb7U2I6rGdsoO26nbUC/92Q1EZT3TZyAW7mCckK1UXA0cBC4ujSvunY/MAn5gcvpJ9m4bwJYcpIkPfCohODZscXIrPSEObWQbefsU8l4ulgrTjO2SWNjmimgqPlvxm40guD3zb78Jhx6uFQXQuIo8SQonAjsZVh+9b3aVRUMlgJrkl6MbaLP8KaLDmgxJ4JSFaCLc9+7tYtdkD6WkgyiNis3MluExUavRomG2e8dZ4sK2IUdaxLPkHXYUXA+Fbk/cDms90shenkOQyIPls6gXm/VLXU3G35LQLvmQ7B1wk6wGqjY6NSFYn52zUcwogvJyfQWBl2lD1nl4KC9oPcf8X3w+E1nDhg5vVuzKxEOrefm/DdXJv47rlV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(376002)(396003)(136003)(316002)(8936002)(6486002)(8676002)(110136005)(31696002)(6706004)(16576012)(38350700002)(38100700002)(86362001)(31686004)(2906002)(52116002)(956004)(36756003)(2616005)(16526019)(558084003)(186003)(5660300002)(66556008)(66476007)(6666004)(66946007)(478600001)(26005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MDJaMnNpYjVhTjhRbzA5a2ZIZGZ3QjM0c3gvZjZtbXZVeUdPMXlvbTBUQjFh?=
 =?utf-8?B?SnFmMC9tZ0pFbVdreXJZcFJ1eUZrcVNzdVJhSTd0K1NvclViRHFyQ3JMbUVX?=
 =?utf-8?B?R25JbEdQMXZQcEZNMDlxa3plQjNNRlJxb05MS2lmZ2V5Z011OWV2aTZGbFVi?=
 =?utf-8?B?b2pxdWdNY2JLT3BtVytJMFN6QzBlcktwWnpKT1BCM2VYOU5UVXk3TURZRXBk?=
 =?utf-8?B?UlpvRE9RM1pnbHU2eXh2UFdyMG1aYVJGcEJLaFF5U1RvYU1GbkFpNExWeWFs?=
 =?utf-8?B?V2RGenArWXdWaEVML1lBMzFhaFE5Wlp3RzJrcEtkTXVwdUdMMlB2U1J2UFNu?=
 =?utf-8?B?NlQrd3hlT2Q0SzZLRlFoQ3c0Sy8rS21wWnNJd1BQcHdhTjVNM1grYy9tUnRM?=
 =?utf-8?B?d0xoczZmVVVsR2VnS0FINUh1aTNNS05mNXJWaDZBTURpV3RiK1R2dE1GbW5q?=
 =?utf-8?B?N2JLSi9MRlIrbWtDVjJrVlVuemUyWmQwWmZhM1paZ0NQT0dlWitkOHNudUFH?=
 =?utf-8?B?NnJoQkZkRWxNZ21HOUlJMTlEZmlWYm0xemppeU93c0ZMSk8zQitJU3ZHYzJ1?=
 =?utf-8?B?NncvdUdCSG5ULzA4N1hCWHVacVNUMnhGZ1JaYmpyTDh2U05xSi9vd2cwcVhX?=
 =?utf-8?B?STMyRzBYZ3pGckhhZXlWcktwOEZnNWJmV00zNDZPUHpWaWRsdmRTcGhIb0Y1?=
 =?utf-8?B?RGdmS2FPTi9KVDNQdzJDV3dGY3FqTTVMVG9lOHVwYnVvR0J5d3FlZDE2UEVa?=
 =?utf-8?B?TSsycVNiakg5MGJxRlhMR0FnS0xXRzNURlgzWDJjdzNTYlhLc2hyR0JTd0Rt?=
 =?utf-8?B?U0xUNUIyQ0ZIRTdZRGRuTk04a0Q2VXFncE14c1E0d0ZvemhCemdiVU5ieTZR?=
 =?utf-8?B?OVJrS3ZnQzdjL2tDSXZYSi9FcUxrWlQ2QTljdnJoa1k4TC9GOXhHbW0xaHR5?=
 =?utf-8?B?MkZOS1k5eEdBb1JmYUJrSk53V2Z5MHZrTDk0eW1IMTBXcFZtK2dId2g4NmI0?=
 =?utf-8?B?cSt0QXlqbWRhUTg2dmdiMFBJREJLbTNyTWc5VjFIVFVkbEV5OGpSZkNMa0NX?=
 =?utf-8?B?MjFlS0FFZ3BoOUN4SVovVFNtZGZ4S1hUV2dNRkFnTUtOS1FlRmhudXIyS3FR?=
 =?utf-8?B?VksyZXcwNDg0cXkrM0RTc25zSXh4TkxZVzIvV00wNjNBS1drWVhpbjVQbnhy?=
 =?utf-8?B?ejdPUlBBbzg4cFE2NkorU05zMUorT1kzNEdsdDlQbFcrQ3dteU1GdStVVUdj?=
 =?utf-8?B?MnpONFAvRzNSc013Ny9ieWdmN243a2ZZR1E2VG1QMkRibUI2bWpjT2YxK3dr?=
 =?utf-8?B?RmpYemJNcUducUh3WjFKL3Y5bjNXMFpmbUgxRmVJcXFPSk9MOVNEMWIxVG1J?=
 =?utf-8?B?c0x0NkNxTnpkTjVXanN1Sjk0THlsSllhSWJaSk5zZWV5djRnWW5lbFBRSXNo?=
 =?utf-8?B?YkljNm5CK2RJOEpuTXFaMkVxNUZZN2dRU01ob3FjV1U5WWI1YXk0akZhOGZS?=
 =?utf-8?B?eTlIMk40OHVuak4xbXZXb2kzczNxc2pHV1ZpK0ZXSm5idSt0N1Vzb2ZCeW9p?=
 =?utf-8?B?Zmp0N1JzMklORVdzS2JqNEFUSWJibThJakdjRlF0bExzekZZRFZZbGJzM0xz?=
 =?utf-8?B?M0xhQ0JFbmpHR2pMSlU5RXpydXA3cDZmdUQvWjFmdU9uOTROcE5mczF3bXl5?=
 =?utf-8?B?cENRTjZhQWJFVFNzL0hNNllhSktORUlKTy9aNjJsaU95QjhsQXVmbDRyS0dt?=
 =?utf-8?Q?PKCvdiaLzUsOs/kbVESb1wlrrJmbcT/RFUQp2+I?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf9829-f547-42f2-e088-08d91131bc07
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 08:25:55.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nf4FRRRsy+A5S+9QSO1njvKOZ1fuNMc5I553oeGe89tJxO4LD4UTq2xkEQeU5c9C2+QgRhSiY7NOCny2Mrm2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

MLPL is found in Documentation/usb/linux-cdc-acm.inf and Documentation/usb/linux.inf.

Does this conflict with GPLv2? Anything else we need to know when using these as opensource software?

Thanks,
Zhe
