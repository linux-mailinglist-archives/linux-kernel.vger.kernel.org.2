Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34926443D96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhKCHSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:18:46 -0400
Received: from mail-bn8nam11on2134.outbound.protection.outlook.com ([40.107.236.134]:39777
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKCHSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5l7P8QAWaiTLinRqHkxQzq1N1TXt+Wf48gz51Xax5Mirl1CDRmpqSI4ZsFWrUI7AcF0/vaY4ADpoTvXpzLjdtPAoVOkrwG7rR9KJTMqhM1QDEEuIhXVlfsJ31hmSdAitX2tX13Ic7xna+R2SNkDPewqJPVE7ThCnhyNaJQGwaJ/K77uS8b8AZaz4fOpSw1GTgz+2e1fEYEPV8zO261AUfg4f5+vQ6y2UZbkDh1n9u+eeEoqgTrGbbYieyE5aEXlVTsMC4cJTC5IgwJpMwOw+DFmhnVJIxNJ0/JoHrvm2A/8EOrHXK6aTNHdTp8k8qsNzoiiqy0Yjqp8/7Xueq9O2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1xKt42Gm40pMeu9luO40nysQ0jtv0UNXLTPpGLWnd4=;
 b=XComT5tYAHkY6Qoa6FlKlu0ID9TZDpGsXpQLHSriz0/HNqI0Zf5DypZUawO+dFJcqwthBHkw5htlUcGYtR4bxGguKdRUPZddUGa354Vg7Ieq8i/GKAzyvhF/fz+WKmDTLp7WQLprcA5GkF9DWLWWmqUoGPIp1Om75bckG6qoxCBdwWuYP6iu8HKJWRyCeIMSRH5+KT7lJtsPMgmjiIakQK0PvRrDnxc4ROBLT7u6H7J/LdHVs5iSPq1s6hQrgbK+s7yHKHIgnAKDg3ztYm6zJFPGk7txYnzCmnCC1B+g5NZV1Zm7l6fIQmElNEJJZG1Gyc9XklANkP2R+PGwPlGjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1xKt42Gm40pMeu9luO40nysQ0jtv0UNXLTPpGLWnd4=;
 b=L7yoIdIrSPT+KLbIcEUl9U2h0IVljklsCHbx5aCKBLK6s9pdoheZMDj9pe4AmQY+GwcMA+4TbYOQVkYennsZXoziJhoheOf9wqQrcqYFs9BXirolWnLIAy2cUY33DtGA3o6CYkrCbUgP+D4Kne0EnHe1oO7ig2rjLc0jnxBlFws=
Received: from DM5PR22MB0843.namprd22.prod.outlook.com (2603:10b6:3:13b::14)
 by DM5PR22MB0683.namprd22.prod.outlook.com (2603:10b6:3:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 07:16:02 +0000
Received: from DM5PR22MB0843.namprd22.prod.outlook.com
 ([fe80::65ac:6c37:6af0:5308]) by DM5PR22MB0843.namprd22.prod.outlook.com
 ([fe80::65ac:6c37:6af0:5308%8]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 07:16:02 +0000
From:   "Bello Bravo, Maria Julia" <mbellobr@purdue.edu>
To:     "Bello Bravo, Maria Julia" <mbellobr@purdue.edu>
Subject: =?utf-8?B?UmU6IEdyxJPDqXTDrW7EocWh?=
Thread-Topic: =?utf-8?B?R3LEk8OpdMOtbsShxaE=?=
Thread-Index: AQHX0IHfBKHBvE6cbEeRCcfojHEsh6vxdQ4A
Date:   Wed, 3 Nov 2021 07:16:02 +0000
Message-ID: <0CC5AEE2-6D10-4F92-B4FE-0FA8A021B39B@purdue.edu>
References: <0948504D-4006-4A2A-B55D-D4D45BA91576@purdue.edu>
In-Reply-To: <0948504D-4006-4A2A-B55D-D4D45BA91576@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: purdue.edu; dkim=none (message not signed)
 header.d=none;purdue.edu; dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0393d3a-332c-4cbd-cfc0-08d99e99cb66
x-ms-traffictypediagnostic: DM5PR22MB0683:
x-microsoft-antispam-prvs: <DM5PR22MB0683BD276F6CED73329A86FEB68C9@DM5PR22MB0683.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dU6RHIpphYI/nLZU5fZpGTzQDug+ExxlYPrgr+lzTlGDAk/goUWyyC+yr89TuVUdZlF7gxR/Z7Rv82/8KiyYxOABY0MG5VDGCk2pZ/hk0x6Jzp+ILzDGJwHblYK0W+hvn3NlOLocOV4/G2t+IBDEIwsVGWNMnL33W75Z9bdiNN2/VPxzhXl9T0f/CnApBtBRaef2pFAxxduGqaS3ytqPhSuuBeGrW7AZwiloLe77uRgWY1iaMG1HmvbqChBGhVvmIt4CHBpXdKt1DsIWEifPEZOUtpRXQM0qK4dkwdCP6daFUFrcgGvdWmajZCToBAKTybd04/BO3MDd8ttD3pKWgWdtlFlmABhsYy0pZAXmhGZnY0QuMwTVrwqGlx/OopqGREyqIZmDUMG2gfRmFFjmltroIUtLCB/SAJmfLiRwWFxZl5iqPtK1dxtPem3eVsWkA1XxBBivhsmmT6sAwZa9shQCkUOmz1ATGO/0VnRDSvWeUsnFGNPdmtcz1KV85DFqkEKbWRtIM32BaLkTv4MZyipa2QSCrx1Sl24e2kVJOnzUu7kx8YfDJsr9w8cq0/BDWn4mJva6nDha0DRlkP/A8MpSK2U/rbXcMjENBoYvgJ6DNR7Wo1Q49LkEf0Cd5EqDA3q1fBEYSBjMDX0GWBbbjVT1lcwOS3X0Df11WStRNGBkJTZLR0nJ6Paqqx5UbtOHWOSn+5MK9wCtY85zM4gemsF0xRM52nbgucUExMOc1c4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR22MB0843.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(26005)(66476007)(6486002)(66946007)(5660300002)(66446008)(64756008)(66556008)(8936002)(36756003)(76116006)(38070700005)(38100700002)(2906002)(33656002)(7406005)(6506007)(86362001)(91956017)(224303003)(88732003)(76576003)(122000001)(2616005)(75432002)(6200100001)(558084003)(508600001)(7276002)(7416002)(7366002)(7336002)(6862004)(786003)(316002)(37006003)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnB4MUxtNjhSTXJ1VnIxWGVxMXFOV3A3NGt0b1pTMjh0TVVMNlJMSkhGckcv?=
 =?utf-8?B?UmZ5VmhVSnk2SEtQOGJQV29nK0lIKy9TZ3p6Qm1lODhEWU9ocFJxdDJNWDNK?=
 =?utf-8?B?ZW0yYXJkV0lvUW9EZ1poVGplVm5KcDJITFI4amlxTEQyb0xoRFpVb1hURTVk?=
 =?utf-8?B?OW84VHFCbElFMm10NFFtNXhaRmZQaFlwWlkyYUVnUCtyYTU0NG04MUpESDdZ?=
 =?utf-8?B?dVRDSTkrSUZNN1pud3RpQktRY1dBQjgvZ2JlOTdneGJZVEk5WlBuS3FVUGM5?=
 =?utf-8?B?ZVRRdk5hcDdpeDB1NGpncDFKWGJ3NVpGZit3NHVpQ3JNRjlBbVprTmJjM05i?=
 =?utf-8?B?NWhZenBReDBDT0RyTVMvVi9FOGc0Y1BvRkRDbEkvaXdKSjF3VzcxQ096bTVK?=
 =?utf-8?B?VStRQ0hGWEZxN0FmNjMzamdaNTZkZHh3OFJjeko2WklPQlV0YXc3NTUzSGl0?=
 =?utf-8?B?em9CYXEzd21kenlBaTZrN3BmbE5kZU04MGhMVHd1QXJBYnlIMVUrREltSDBk?=
 =?utf-8?B?ODZJYStXN1dvbFVMMldhTTliWkoyU2lrMDIwcm1FV3ZvbjVDemlyUHFBcWFW?=
 =?utf-8?B?d2FPSmFDZkl0TUE0eEZNSkJaTmxxVWo5QitrczdLS2JMb3dHR3Q0UkN0MDNz?=
 =?utf-8?B?K0xVN1JFbzhqRHk5MUtlL2dvcTlWZUVLNUVkbklvTGNyQ05WUWtMQnYwQ1NM?=
 =?utf-8?B?NVB6UmlqbXdYOUxSSGFCbzdUSDE5SkpVems1NGZoclZwb20zemMwZlVmR3d5?=
 =?utf-8?B?VkI0QUlGMFRMYXI0RzVyL014QStINWJZUEVxR1pDUmZTc2lmQ0ttNlpPUGpW?=
 =?utf-8?B?SkJxZ3dHM3poNVIwRVZ0QU1MYTU0ZGZyVXNhZzJMby9QVDVKc1dIcmR1cnZ0?=
 =?utf-8?B?RFRrcjRkWmVCaHF1UjhWcERERzZ0akdwVnRlbE93WE5TUG5Ja0RuU1hNbmRC?=
 =?utf-8?B?MUY0TkgvcXAxeW1FbjZ1QkwwazdMNEgxazFzckFCZ29kL3pRZnhTNjg5cWYx?=
 =?utf-8?B?NTkySHhrV3FsVUJSM0tkYm9ubmk4TVl6aXRnVHNrVUw4RnZ2ZHpBV1R5QzRP?=
 =?utf-8?B?eVMvQ1dzQmlNWmplalpjUlZJQzI2eGVXZW1XSVhYNWtPNU5EcFpmcW1CMTFC?=
 =?utf-8?B?L1l3U3B3USsyaVQ3YytGV08yd29SYnQ5YXN5SHR4dElwSkF6Q092K3R5Vnc3?=
 =?utf-8?B?ay93c050eEY5Q0RsV25RQlRyTTcvOHlScUljdWxiTTBTVkkrWWhwbEk4aVdX?=
 =?utf-8?B?NnZKbTRHUFBBM3M3ajQ2Z0M5RlJ1SnFCYllGcVVNbTdpdFphUDVweTJSdnBs?=
 =?utf-8?B?V3FMQXRYSUdOUHY2TTIwYlptMlJxdk5jVzY1R0xxYVl2RmROZWE4SnNpM3BM?=
 =?utf-8?B?NC8wMHRJN0JkVWZSK0s5aFM5ZnZjUUhlT2owZnZ4NlVwbjBpazI3YUJFbFF3?=
 =?utf-8?B?ditRSDZjMlJlNE5rQWp1QmcyN2xkeWNGQ2g3VGpQaFNqNzlZVVAzblZpR2hK?=
 =?utf-8?B?aHZIWEpFd0FaZzl2b1M3bU9UNzZKMUhkdzVUZ2VNQm0wSjIvQmdxN3FkZTdB?=
 =?utf-8?B?NXEwQ3o2NXJYQU5pTzkrVU5rZ0NXVERLWlFlWVpMY0NkVkhLL053c0NET1hI?=
 =?utf-8?B?YXE3SW9TRm9PRVpUUmNrOGQ5Sll6c0QzN2Q0ZmJMUVc4VnFyVUVLTUVYUEdv?=
 =?utf-8?B?cVZ6SmNsWU5IV09qL2NCK3Fic2pCdjRsZUFiUDJEYnhOK1VUaUhWMC9NYXE3?=
 =?utf-8?B?RXo3dUpibENERXpyRTY4TWZXeWhEeTdIbnZMbmVxRGhLWkdjS0VFYzA0c05a?=
 =?utf-8?B?WXhQNTM4MVkwSzdwdU9oSEJCOGxwQW9tY0d0R3Y1WEdySmNJWFJWTWYxU1Fs?=
 =?utf-8?B?dGIwWWQ5ZEFJMlZsMjdiSGdTdSs4YTJ5LytEU1l1MkY5UUdOai8vL1IxeHhi?=
 =?utf-8?B?Ry96Vit0NXZhL2hUdnRQRm5LSkgrYS91ZTVzRTZSdzBwOHhEZW5DMXR3WXZG?=
 =?utf-8?B?RkNVR1hGWDVHMW5yOUZvVTR3b2dWeTU4NC9pRnZpcnNPcXVDbS94YzlNMlZu?=
 =?utf-8?B?QUx5T2xNZ1QrWnFQdDQ2TEtWMmQyckQ5OFIya0tKUDNDNDl2VGpFNjJ5enZM?=
 =?utf-8?B?TGoxdHh1QnRmVEgrWDdiUU02bjdLLzh6akF4SXVMckt6UVFmVmVyYkRoVUpk?=
 =?utf-8?Q?QthrKCN7VND0SPGFO2QEm4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <278D4455051D96439F20F218EDC170FC@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR22MB0843.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0393d3a-332c-4cbd-cfc0-08d99e99cb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 07:16:02.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsZ/589XsLDz/kadGbevDHyFYpln+bHmST9A8fZvRXiQMiMi+UwvzdvcsKyClVlVN1uHiHnIIY3U5zGU11QcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzMvMjEsIDg6MTAgQU0sICJCZWxsbyBCcmF2bywgTWFyaWEgSnVsaWEiIDxt
YmVsbG9ickBwdXJkdWUuZWR1PiB3cm90ZToNCg0KICAgIMOtbnbDqXN0bcOpbnQgw75yw7Bwb3PD
oWwhIEFyw6kgw71vdSDDrW50ZXJlxaF0ZWQgPw0KDQoNCg==
