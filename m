Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00984359F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhDINJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:09:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:09:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139D8wK7114598;
        Fri, 9 Apr 2021 13:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=35eQh5b5SGZYBz9Rg6ClTXrPt2VGMwGlCzXUBvhHVp8=;
 b=r7TRREDwHKbrb6ZnJbSWNFjttkitU1Yd0S3M6ZdCACFbR01OstPpLFpccO0eiym3IL8j
 e0TT3KAX8ND9T7mcRINGIDp1qMJ1RXPPGU2amLD/RqjpKGcwwGHWmfAJNMjFCuaRiaS8
 2UvQYI3mSQw+a25YZWp53uGVp2WTZUeVF+Os1VHWTcIEXl4pB5I8/kSW4G9ElA3swIng
 IxJ/4KKDU1zvTMzOBkwtHKWu/PCeSs3iIPnxnGBphH2Gc1UDdPNGQ5BH8QHMnGnPDXhF
 5Z4IuZnURyx3dDudAQpgS1c1F6XPbL4tRQvIKxgxPoErulUl4bJTC3LMl9vApyqcEz36 vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas9brd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 13:08:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139D0BEY150246;
        Fri, 9 Apr 2021 13:08:57 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by userp3030.oracle.com with ESMTP id 37rvbh11xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 13:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9LPNYyfzrd1qsHtC6rLAqTJVaz2GemS4CJC5RiLJZ2WMlFapYW77fE/GTLdkJ6961Uc6mqeuPFlG3jsJcUTj+TvzPVMBR4K0i3rc4sNE59Dx9UdMjuA3r/RNEn9/Dp7gZ/ZVYovflpKN62CgZFH3buOsCPiCx6R2jKEztW9RZo1ciyBFu0JP0mwaAd0o5iYSweUS5FDEkbn7NPqgIpPnIpJj0Cwk8M96fY4b9roourK3+4CA1I3c4aePinROh/QZElwqD1+FOQOm7GFA5l2p69bWTx1J+UysKM491/WCSnMA1uOTzTxKQ/lxo1rcZ/m+UVmL3of50TurZKxHyctuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35eQh5b5SGZYBz9Rg6ClTXrPt2VGMwGlCzXUBvhHVp8=;
 b=mGzNUdgqfVhQ8vUwpGMCNF00qmfnnLnOwDbetITOy8drCpPLv18qYydiDDogeoj7LHafBo+WinjhqSxtA4pH9n8K0CUzxhOqJoiNh9Q0n0+uiqWo7+/09AYNE+6YctCaANvbs99WHe5O9mTxzyU8Ah0eOHvpahRiu93B+HQTli2lCARJu4GYCX2PaE3WblzPIQSnhHksGVAM4wL/hH7i/rqyFlCklYHA5aAWL8KFdOHdW6PYKMSY7f1aOMG1jEprKUuEn/E33G53qx72UzcuTlWdiqv8gOGyWEK50CCO7PaiMwGCWVKJ7Fx74W7yTJyWMcbU5dA+MGBMmH2H42gtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35eQh5b5SGZYBz9Rg6ClTXrPt2VGMwGlCzXUBvhHVp8=;
 b=hWICtCAAkS1RauLtPV1uoC4bdo7F3QME9I7bv2e5LT/N6PR3nxbcTqAVULj3YeJ5TXYs/HzVBgUhAFGFvgiV/M4pzL8pbpBpJXVywr8xehAq+tFVjWD7K2juimyvyx5/XNVmPzTNUnKrDcpEJk9uz6UamV8SLTRT8paxVbr48NQ=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 13:08:55 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::30ab:21d5:9541:b36e]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::30ab:21d5:9541:b36e%3]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 13:08:55 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     Alexandre CHARTRE <alexandre.chartre@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC:     "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jarkko@kernel.org" <jarkko@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "jethro@fortanix.com" <jethro@fortanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/traps: call cond_local_irq_disable before
 returning from exc_general_protection and math_error
Thread-Topic: [PATCH 1/2] x86/traps: call cond_local_irq_disable before
 returning from exc_general_protection and math_error
Thread-Index: AQHXLJx4F8D3pWsG5k2DleQLVEvPwqqr5fgAgABDpaA=
Date:   Fri, 9 Apr 2021 13:08:55 +0000
Message-ID: <SJ0PR10MB46233EBF34A06C00E040E327FD739@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
 <20435165-ad96-ef85-5b3a-9ca88cac64f1@oracle.com>
In-Reply-To: <20435165-ad96-ef85-5b3a-9ca88cac64f1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [108.168.44.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472c133b-77ce-4c21-767a-08d8fb58a183
x-ms-traffictypediagnostic: BY5PR10MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB419470768D8A77C0E6FB5D75FD739@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBMk8fF9dAtMK2RLaie0VOvK0s9guv9HedzRD7/o2IXZPSuiFbELI7QxyOvAZOETo5hbXdYCLf25EaFjLEsfzVDn9/20KM/yGT1DC9zKqeQF9kmzzHz+dnOoKqO4lPdIlckyl45o6mgKlWuVehY839C/B5d4q5q+So/zi0MqQAP12Ct1ssiTMZUIs89zFpVfdTDC2UjdANdV4J0ZVKqpt8uqw0Z4mz4+GeUOZexPx42UFNKfV2KR02uOcqqIKPPcl5PNF2qMboP9jlX2nJ+pW+NpMrfCD/LUPt85+60I/1vEOSGzAZKULfgr8ujj9Imj13nCbbL/gQBxf0LpsIySlSxO07XbdjeL2a943mF2hjuUBATAyswF5C5XOMK68WBkdoe02q3GSeRDvPqpU9pbMSeJ6kOWpFnZvarQU09+s9+9RklwXBG/qNsz3bDEF8f9fsMWkkSzn+1owNT64IzZin3xV+1eEeOWHZREdJ4SPp6t2gxv1MSeQsbMj1QuUbF4HVl+EkVWUDmoRGHZUyYCcH653MouIiwQLyy6TUdaZD04SjRqlBuzDZqOch3yA3IcEC4yDJXVktMcKHu4JF1E01rR3kAQAGuktAwdNTzTKX8QHS514FedBi32bfUJXum17UFNeWJwJd20SjQHD6lZPOuEYZMV7Lz9N/6arX+CJ5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(5660300002)(38100700001)(83380400001)(478600001)(66446008)(7696005)(66946007)(33656002)(66476007)(66556008)(64756008)(76116006)(52536014)(8676002)(7416002)(4326008)(71200400001)(26005)(186003)(6506007)(316002)(2906002)(54906003)(8936002)(9686003)(55016002)(44832011)(110136005)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eW83WThnWndqd21aSEwvR0tyd1RTSnBkcGUvSjdMTGJUMUdKS3NLMUU2ekNL?=
 =?utf-8?B?bDJEeVF2S3pzdW1HWVFPbUtEcWk3OFpHbGY5N2xjUVV5VWtNQmhQYUdHMTZ4?=
 =?utf-8?B?U3Q0NW53clNKOE9qSHJiYzd6U2t1M1Ntdmg2TU9MbHc0cWI5SUdqaVphbEll?=
 =?utf-8?B?eEZONnkvclQzM05QTEJ5SFE0VVYrUVZkT242SWhON0NwVlhhZ2MvaGdsYndB?=
 =?utf-8?B?dUtEK0l4K3h6UjV1bmJDVVd3eUlkYWJYSFFzM1hhcWw3NlNjd0pWMjRsMXVm?=
 =?utf-8?B?VkVvSldwbzkxUnhLdFRqaS9tRTBSYllxWmFmVVd6Y2toTWR2Vis3cTdlSUY1?=
 =?utf-8?B?MDRYRkxUUHVKb0N0VXovdUQ1WlFIdGtFcmRCOFVlL29WTGpDK2JlSjNlalk1?=
 =?utf-8?B?clRIMjR6cFVCL2Y2amNCbHpHU0xDUHozQmtDVW5IS3MyUi9aUGd6VkZDcUdi?=
 =?utf-8?B?dGZWWk93VmJTWXdUNFozQlcxQnZKdXBidUE2QldxS240cWRpblRGZkplQVlW?=
 =?utf-8?B?TFhpeVRFQ3ZjNnduTklXcHk1ZE9BUzFkSHUrMm9LdWRremIzK2hUOGFxU2s3?=
 =?utf-8?B?eWw1SFlhMzJCVUh6bS91d1hhZXB3eThianp1cC9MWFNGeU1ocllGLzFGQjRN?=
 =?utf-8?B?ZDl2b0g3SVhGalRNQ0NIRkp3cm4raE95WGJCUnhObzdiSFFlSFpBaHIrN3J2?=
 =?utf-8?B?YkdUU0pOK0Mwc2h1aEVUa0xQMU9EY3NuYTM4ek5aVlA3UE01VW5mbkZkMHlk?=
 =?utf-8?B?TlZaNVBOaG1HWUFYNDloT002YVhKSVNKdzZXeERvVGpKMStrSTQ4TnFuR2tP?=
 =?utf-8?B?Y1B0VnU4aDJxaFRsOThqcXJ5SkJOYWZlV0N5TG9xdmR1aTJKTXNHT3lqb0tK?=
 =?utf-8?B?Y2NpbUNGZEtLOHorSHJwRzlROC92cnZPNkx0WGhaS1JvM3JkdXcvYjN3bGJs?=
 =?utf-8?B?MGN6M1o5L3Baa0U5NStnNWhCSXd6SHkvNDFNRGNBQ3dJMGZ6U3UyRTVVN0FK?=
 =?utf-8?B?TlVaRGNFUndxL1R5aHZFcUpFS3ZhT211VHdWbVJ3SVBPWmdPQWZHRmJETW0v?=
 =?utf-8?B?dFVUMWZ6a0NrWnRnQStlZG8yMzRzRDcvcmY5T3FtWVZ1Nmd1NU1nQzVFc0VV?=
 =?utf-8?B?RWY5TFdrMnhrQk5DaFNad1VsTlZjcUtmb2lNSDVPZ3p3V0VhS1FFTXVDeHBG?=
 =?utf-8?B?MXVKKzk4UTQxcXNRMmZUVDdadTNQZ2k1aVhoejlMcEltbURGSlNJbk53VkYy?=
 =?utf-8?B?dE10ZzZITDlkdWNSeHJrbCs4NXV6UkxTelhKa3pyeEp5WG1nMnUwOFhHbSs5?=
 =?utf-8?B?RStKSSsyNFpJb3BvbW9pZ3p0UkhML09qeDMrdnF5VDhVZ2FOWWhsUlh3RVAr?=
 =?utf-8?B?cERiUVV6WEo0SVBkcGZnekdRdnRKOFBucW1XeUJyZmtJS1l3RTdOQmphcWR2?=
 =?utf-8?B?L2pTWGJSdVBwc2JDbVU1TkZnSk51MVo0cXdCV1llZ3VEMThYNk9zR0Q2YzE4?=
 =?utf-8?B?ZlB0SU5VSW5jRWsvdU5PZ2xZbWdlWFlZYzFqS1B0bmtRQ2xJajFrdVgxSkJj?=
 =?utf-8?B?L2w0Tjd1bkZyZEJSUm8yNG5tR3RKVzhxSVNySGx0b0dJbk1UaDgxTFpsYm5N?=
 =?utf-8?B?UnRnQ25oRUV0R2RTOUlMcVcwUVYvaGIxSjRwNTgrczA1SXVHWDBoenVncHdI?=
 =?utf-8?B?VDJMajV2SUo4KzJPaE5jenJmcVVYWlMyV0xidWJBNmJkU3FNTjFsOU5KalZ1?=
 =?utf-8?Q?9iZBn4jLr3YgcglFiVjy15tMXNQ/IvpIIdLo/sE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472c133b-77ce-4c21-767a-08d8fb58a183
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 13:08:55.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9I8Z0UOMb20ciOrGvLKmeIM1H7AXGGbneKWNWXVyNnsL8ChVNUwJ5/tgiSSdcVXTf1Orgj6lc7AyxWvA6/unSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=851 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090096
X-Proofpoint-GUID: xXRd_1-XMyvknc6STk3hpl6lvBrVlU2t
X-Proofpoint-ORIG-GUID: xXRd_1-XMyvknc6STk3hpl6lvBrVlU2t
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=988 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kcmUgQ0hBUlRSRSA8
YWxleGFuZHJlLmNoYXJ0cmVAb3JhY2xlLmNvbT4NCj4gU2VudDogQXByaWwgOSwgMjAyMSA1OjA2
IEFNDQo+IFRvOiBUaG9tYXMgVGFpIDx0aG9tYXMudGFpQG9yYWNsZS5jb20+OyB0Z2x4QGxpbnV0
cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsgeDg2QGtlcm5lbC5v
cmcNCj4gQ2M6IHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb207IGx1dG9AYW1hY2FwaXRh
bC5uZXQ7DQo+IGphcmtrb0BrZXJuZWwub3JnOyBicEBzdXNlLmRlOyBqZXRocm9AZm9ydGFuaXgu
Y29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDEvMl0geDg2L3RyYXBzOiBjYWxsIGNvbmRfbG9jYWxfaXJxX2Rpc2FibGUgYmVmb3JlDQo+
IHJldHVybmluZyBmcm9tIGV4Y19nZW5lcmFsX3Byb3RlY3Rpb24gYW5kIG1hdGhfZXJyb3INCj4g
DQo+IA0KPiBPbiA0LzgvMjEgNzoyOCBQTSwgVGhvbWFzIFRhaSB3cm90ZToNCj4gPiBUaGlzIGZp
eGVzIGNvbW1pdCAzMzQ4NzJhMDkxOTggKCJ4ODYvdHJhcHM6IEF0dGVtcHQgdG8gZml4dXANCj4g
ZXhjZXB0aW9ucw0KPiA+IGluIHZEU08gYmVmb3JlIHNpZ25hbGluZyIpIHdoaWNoIGFkZGVkIHJl
dHVybiBzdGF0ZW1lbnRzIHdpdGhvdXQNCj4gY2FsbGluZw0KPiA+IGNvbmRfbG9jYWxfaXJxX2Rp
c2FibGUoKS4gQWNjb3JkaW5nIHRvIGNvbW1pdCBjYTRjNmE5ODU4YzINCj4gPiAoIng4Ni90cmFw
czogTWFrZSBpbnRlcnJ1cHQgZW5hYmxlL2Rpc2FibGUgc3ltbWV0cmljIGluIEMgY29kZSIpLA0K
PiA+IGNvbmRfbG9jYWxfaXJxX2Rpc2FibGUoKSBpcyBuZWVkZWQgYmVjYXVzZSB0aGUgQVNNIHJl
dHVybiBjb2RlIG5vDQo+ID4gbG9uZ2VyIGRpc2FibGVzIGludGVycnVwdHMuIEZvbGxvdyB0aGUg
ZXhpc3RpbmcgY29kZSBhcyBhbiBleGFtcGxlIHRvDQo+ID4gdXNlICJnb3RvIGV4aXQiIGluc3Rl
YWQgb2YgInJldHVybiIgc3RhdGVtZW50Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFz
IFRhaSA8dGhvbWFzLnRhaUBvcmFjbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC94ODYva2Vy
bmVsL3RyYXBzLmMgfCA0ICsrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBDaGFy
dHJlIDxhbGV4YW5kcmUuY2hhcnRyZUBvcmFjbGUuY29tPg0KDQpUaGFuayB5b3UgQWxleC4NCg0K
VGhvbWFzDQoNCj4gDQo+IEFuZCBpdCBpcyBwcm9iYWJseSB3b3J0aCBhZGRpbmcgYSAnRml4ZXM6
JyB0YWc6DQo+IA0KPiBGaXhlczogMzM0ODcyYTA5MTk4ICgieDg2L3RyYXBzOiBBdHRlbXB0IHRv
IGZpeHVwIGV4Y2VwdGlvbnMgaW4gdkRTTw0KPiBiZWZvcmUgc2lnbmFsaW5nIikNCj4gDQo+IGFs
ZXguDQo=
