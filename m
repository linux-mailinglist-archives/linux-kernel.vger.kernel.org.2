Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC940A423
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhINDIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:08:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44714 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237372AbhINDIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:08:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DNXwuG005121;
        Tue, 14 Sep 2021 03:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sRuKzM/aapHMsW0if+AxFrsI/AggFXR9gvvFkEDPhKk=;
 b=FXMcxKjlJg3ppURBEDR/YzX15+N/m3Z11k3pvoyl2RfeCmTYmMWZ/cgvVYkGi2XcWKC2
 Ag9TUzfw0MWAJZZs434uZGf3ORwZtT5YLxFxFT5WoHwyOdIF9FbjWaOfjmjbzOq7HN2q
 TNbCC66zzyFjRuIJCvTf0tjIJ09N7ev6wqT/uJbjzmX34kOnjwXFb96C+BseSVDYe6TK
 Uj1b3gI1Kmavr+D15XcyvhJTohC28WlEnaihR13BCmbFRcx7b0D6iQ5EWwoFA3r8rINE
 TgaqJ5ynNOQN+OuGkY12cPd7hFdg+AxdsirZ8pBivJxYHOYgwhKu5U7oqe9tWhJceehu 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sRuKzM/aapHMsW0if+AxFrsI/AggFXR9gvvFkEDPhKk=;
 b=Bid/bdfo0dtmBO7ygJjyHWYAcmuvba7lbLi+FWq1EtQ3oeIxB7GV0W6gy2IiKqMqMUzh
 3kBFXxwehu7KdcML3ugkf1K3TNesIeua/Bu0FfHEzKCMt1/ifdK67CN+6Z4s+kUWzIPV
 wUnVkxAU7iHen66IOUjfq4nI/K/06akc0bd2eCVg8UTptRkmJfIJcOVEIq4sS7RVORpk
 SALa23YnswfNbHScIGgGbJgaDBHWZVRuau70T4SnVhISkHEGBqojvEwoDhsh+0fMHybv
 WcG3ZM5EB1kYEcjjOVhMn4H/lpYZqGS99fKLQitnylhQzyx9FHPYHv+CGnZGC/ewMmaC 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1ka94ug8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 03:07:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E36UNb053827;
        Tue, 14 Sep 2021 03:07:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3b0jgcdqey-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 03:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3kJW5wUW090OVu8Q1Py0UFAlQA/a+8LA0Z30bjPX80KD9Iy8BtH1IMUC+5lI/5orLRiGeUsYHA1uNbA+OMBNedW5PjU3TR1BDobSGuHwD32grgaBMFe0yk69FynLElsjXeEF7OMo9BnWAUX24kVcwzKRsLX3/8r/3VuXxYl0mwsj+lDhTLfx5gtK/3feOudoeq9AiPQPEP77vAW3JM8v5PHyiDx68bXVp7ew0AoeojpFPd6y7zfV6aW0TUeTL3ZfM+WeEpsfL+XiX+NcPIqaL5oTvnlCqAZa4QysF9E1rHz7SJNKq+x0mger5Rl+i0XYzZcpFTv1aJQsy6bUSXOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sRuKzM/aapHMsW0if+AxFrsI/AggFXR9gvvFkEDPhKk=;
 b=l2IgFfmPlx+la2mbgF/sRpNltJppf40dirOCZAnILx4EC0gOEbVt8XmSpFWpDGY9ctNC1ZPXXeT/kggJyiOhFwTt+V7jXhlnSqOJgv/R1awo3eRaMc3KKIr0NQdkXCt+QKqLO3IZTp+snvUc3TMX8ShhJNBr5Nvz0mIpNLZHIydMlfx+sh28vRgjYsxpyz7ZOaJhPTQ3LFR/1DWq4t3V73Bm9RGzKeM1evEk7Ps2jtK3kDGo9Xk3Dz1s/Do0CwlSh2660akxofdkE9v8Tc72LoRU4ZIcK+xl2GBOJigf1n3c/wjgjCg8+ne/aBK5egk6YDoOW2tXKzWctcLMeJm2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRuKzM/aapHMsW0if+AxFrsI/AggFXR9gvvFkEDPhKk=;
 b=oURMy4oS9kTgLFLyJEvbh7BPJm2uGRWtr+FtoF49c/d61cpcFrEdv2j36Ynvdv/H0Hy0CCd8EZWPTob1Waf6wDpovuASenPGUDfpYWuAPPNhnybyV/bC+kK0DFyp3ShY/fOIMZowYVmSC4N18s9SaPIlnbVgFnTwo54KmquHMXw=
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 03:07:03 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe%5]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 03:07:03 +0000
From:   Wengang Wang <wen.gang.wang@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
CC:     Chenyuan Mi <cymi20@fudan.edu.cn>,
        akpm <akpm@linux-foundation.org>, Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
Thread-Topic: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
Thread-Index: AQHXpJ+H0ttR42xfTUiCjMce85OD7KuaYEsAgAEsHACAAHAfAIAAh6mAgAD9XQCABVEWgIAAD0wA
Date:   Tue, 14 Sep 2021 03:07:03 +0000
Message-ID: <F7DF85D2-0EB1-45F0-A4AD-124FF8ACE684@oracle.com>
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
 <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
 <6018AF95-3613-4D43-A3E6-7BAA0E0BE009@oracle.com>
 <c48fb54e-0dd9-42c7-f53d-2ea58fb97255@linux.alibaba.com>
 <CED0D2AD-7905-490E-8D36-50D192CD9BF1@oracle.com>
 <ee86ea1a-0348-e975-3c67-8d574eaadbe3@linux.alibaba.com>
 <70C24A61-6E9C-43D8-BB43-1D56A8081E19@oracle.com>
 <7545fe52-98f2-e845-c40d-706fada8252f@linux.alibaba.com>
In-Reply-To: <7545fe52-98f2-e845-c40d-706fada8252f@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e799dae-79e0-417b-c1e8-08d9772cba27
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR10MB4508A2B377EC62EE659C356DCFDA9@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x2H5/zhxyB+8MnFy3NmVHoi0lbsdz6tbsaGv5u0qwojeycGiAQDC09ZDUqeDVLBOiAHd4G05TCt5W+gqHYfsKs4h/A0GwTAcu1pR7eOwhCS3T6k9ogbpczn3sYmNRM0nVlvcIIioJtRPaH2IugZO49r7pwjzXACSizAFmSS2xj9wO3cn6Qe6ZblEhHiNbkuwafeeVMM6AKXw3GINS7U1RhBIBdw9bfWlVEIFJQr5L2arG6y7054fEt9b328Mfz0D+bMB5rLj/4pOyVauMy8A4lmSnr07GNZSY349AooyeZSF4aVJ3wpsypgKkYfohdnvUHGiKCOrHA1MEfMwsef1jyGWuZOAR0JPpmJpwz67ww9xOkH0uu9GDv/5tFxNH9aNjBQLAdtAS4pKeKVTS4taIu6rKIBYtQQh0XYI9ugEZS1oE02tMsl+DrOY4C7ILSAbO6EGsbzNPPovOghUdit9AHOYF3EqLj9PdYnDMRYWksp2gv2pISazZtLmNQQr4//Gx4nLgo6cKzO8MhorokG+iz2HJjyLstzhQjN+phq9iEJMSu7enVCdZbi5BsS53/zJaR4WXWgP/PiffIGG6QWJQtb3bwNtZgoQIVSOb4QdzKUcl2sicUK7OnLU53EnrmbH3vwSOTHmyUPw8ujD0Y0kOvLP/r2RZNP5U4cOWvrFmK10NQddHvTjhotlx2Wssutqc/vpGHkSxTPFFRE76e9p7taEh8aLpZjJkSHFrz2rPciXgoaxuOzAK4z5wea5FYL8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(4326008)(186003)(122000001)(6512007)(2906002)(38070700005)(5660300002)(36756003)(83380400001)(6486002)(91956017)(76116006)(64756008)(38100700002)(71200400001)(8676002)(107886003)(86362001)(6916009)(316002)(8936002)(6506007)(26005)(53546011)(54906003)(66946007)(478600001)(33656002)(66476007)(66446008)(66556008)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pJcWh3cHlYNVNHekV4RXZwbUd5SFJNaDNJTXphN1N2SndjNGV1a3pQcWtT?=
 =?utf-8?B?VjZUY3F1VGg4UXpqaENsTUtvbG1TanNacmc3Q2ozbkN1bEVpRnFvSnNmOFRx?=
 =?utf-8?B?L2xBQkw3ckhNczRGUlg4SG9HWTVhbUxXYUVrUW9FNkpoSkMzOEM3cnNJNDdV?=
 =?utf-8?B?LzNleWkwUVBUMG0xMmxIczNMb0tqb0lwV2lOT3EvRWx2SXpMSm9xQldPUld0?=
 =?utf-8?B?NEgyV21naldFb1RHTWtJM1o3Y1RKZksvcHllZi85clZSdStFZHFoSjBmSnVD?=
 =?utf-8?B?dVVZOHpDVzZLQkVRQm1wMzgxcnBBZ1hoVFFOaW9ZMUdhNFVHYWJHb3JLcEQz?=
 =?utf-8?B?ZHloa25sV1dmREIxRldnSmRFbTNtK3AxR2oxWU90elE2ZXNGTXhtcmFHb2Vw?=
 =?utf-8?B?ZFJITFo3b05tc1FWOER5NkhIc011YmZ5TG1GRG9BYVo2N2dIRXlITzMvNTNS?=
 =?utf-8?B?QkFCWk1NVG9uc3dMamkxV212ODBLM1lYYzRiT0VKNUVnSUY5b3ZYOGRrVXVT?=
 =?utf-8?B?b1E5RGt1RmZidmJla3FubHJyTXF5RStuQ2hWUzh4a3NxVGJjQU52NjQxbzBp?=
 =?utf-8?B?TWZIbGVySWtURytLcStIZEVDc0VqWk9WSGdmUWEyOW9POGNmTHlLZTBNYXkx?=
 =?utf-8?B?N1BHVDdhTkJCRCs5RVZYdlQ3Zks3eEJoOE5acEFFWHZpemR2ZEhvUS8yaXlO?=
 =?utf-8?B?aEgwMVpZYUtUTElONTdHSStaeUhMbjF2bEJBZ01iWTV1VlB5bmM0YXhabVlt?=
 =?utf-8?B?cUF6Ukd1aU1hT3NENnc5RmlFcUplWmpnTVNhQWZZVnh5T1Uyb05OaEtiNVVI?=
 =?utf-8?B?UWZjUm05V20yeHorT0xmWVM2cHBFT1B5M3hQbk5VbHFRczJPTGhIUnE5azgr?=
 =?utf-8?B?bmRJTlFIS2lncGFZY0hXcXM0R3VKR0k1Q0F2UDBKWnNRNnJrTjRuVmRDODlt?=
 =?utf-8?B?bGtXc0dxZ3V5bFI2QmRsMm9kRnpXOVJ5TU5NM3pFVm10cmtxQW1kOUh1T3NU?=
 =?utf-8?B?QW9MQ1dRNXJxb21MZ1BpclFPSkZLbUZuRVQxOTRsbHpZd0lHcjRLWVhOb0U0?=
 =?utf-8?B?NE9sWVN6dXFUbU9NbFNwZW5WeUhVSk9RZzRjbjBmL1dGVXVtdDhpSHZaTGpn?=
 =?utf-8?B?WG5sS1oyRmJVVCtYTHRyaFYzTHorR0dsNngwZEZmM09CVW9mb1Z0aUVmMjdS?=
 =?utf-8?B?SzRxU092Vm9RWXBFeXdoR2lBZVlHbTJZakhCbzh6OTZRN1Q4UjY3U2NaMGNY?=
 =?utf-8?B?WWtTUVNsRnkxUDlSQXNBanZybGRzSGtSbG5ud2pOOHFwT1V5MUNNZklhRkZS?=
 =?utf-8?B?eGRRZCtHWi9pNklCYzRKK1VJV2N1S2x5YnNLY0tvZGNDSklvK2ZueFFTY2Rq?=
 =?utf-8?B?VFBaQ05CNnFEWWIydjQ0RDJSMXJFU21sMUE4T3ZQWDZxOVY2bTArRWFpSDZK?=
 =?utf-8?B?c3hod1ZaelgveW1UbHhNQ1hnelkvYkNjY1BmOUlldVJEc0pUN2U0QjVrOVht?=
 =?utf-8?B?REJpZ2s2d0JJbHVrZ1pKM0JpVDlUT1pjNU8wam9iaGowN1YyWEs1KzEwdUlw?=
 =?utf-8?B?M1RYbmRvdjZxeXFEelg2U3EvR3NyakFUVVBBMlNHcWE3T1QrQTJoNzRmUzRX?=
 =?utf-8?B?VHZRTWVxYnVmUG1mTkZodDVhNW0zSzJVRi95YUpOaUNCQXgwUlAwWW5iM3JG?=
 =?utf-8?B?cFB6blArbm9mL0xYVkZKaVdkWWNVeUduclF6TTJvRU5OeXlTZEFzeUhZTzlm?=
 =?utf-8?Q?D7TCqvIoswssYaYmWuj83HVOz/qHsVUI6p6g0mx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B037D07203ADA244BF26662F4C7DDE32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e799dae-79e0-417b-c1e8-08d9772cba27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 03:07:03.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSicCO/dkwe1NUxsUbTz6AEX0YJ9lwS4NQoRBza1dJocrdV/WEM8DaeEXZCj1ind0WnHiFJr6s+Ae2QFY71rr4T/+IcU1h0rVIcG83Sdlqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140016
X-Proofpoint-GUID: -ftZSXkMITcQ0SGRm3umR7U-TgjKerdu
X-Proofpoint-ORIG-GUID: -ftZSXkMITcQ0SGRm3umR7U-TgjKerdu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEzLCAyMDIxLCBhdCA3OjEyIFBNLCBKb3NlcGggUWkgPGpvc2VwaC5xaUBs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDkvMTEvMjEgMTowMCBB
TSwgV2VuZ2FuZyBXYW5nIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBTZXAgOSwgMjAyMSwgYXQg
Njo1MyBQTSwgSm9zZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+IHdyb3RlOg0K
Pj4+IA0KPj4+IA0KPj4+IA0KPj4+IE9uIDkvMTAvMjEgMTo0OCBBTSwgV2VuZ2FuZyBXYW5nIHdy
b3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+IE9uIFNlcCA5LCAyMDIxLCBhdCA0OjA3IEFNLCBKb3Nl
cGggUWkgPGpvc2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbTxtYWlsdG86am9zZXBoLnFpQGxpbnV4
LmFsaWJhYmEuY29tPj4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBIaSBXZW5nYW5nLA0KPj4+PiANCj4+
Pj4gT24gOS85LzIxIDE6MTIgQU0sIFdlbmdhbmcgV2FuZyB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+
IA0KPj4+PiBTb3JyeSBmb3IgbGF0ZSBpbnZvbHZpbmcsIGJ1dCB0aGlzIGRvZXNu4oCZdCBsb29r
IHJpZ2h0IHRvIG1lLg0KPj4+PiANCj4+Pj4gT24gU2VwIDgsIDIwMjEsIGF0IDM6NTEgQU0sIEpv
c2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPG1haWx0bzpqb3NlcGgucWlAbGlu
dXguYWxpYmFiYS5jb20+PiB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+PiANCj4+Pj4gT24gOS84
LzIxIDY6MjAgUE0sIENoZW55dWFuIE1pIHdyb3RlOg0KPj4+PiBUaGUgcmVmZXJlbmNlIGNvdW50
aW5nIGlzc3VlIGhhcHBlbnMgaW4gdHdvIGV4Y2VwdGlvbiBoYW5kbGluZyBwYXRocw0KPj4+PiBv
ZiBvY2ZzMl9yZXBsYXlfdHJ1bmNhdGVfcmVjb3JkcygpLiBXaGVuIGV4ZWN1dGluZyB0aGVzZSB0
d28gZXhjZXB0aW9uDQo+Pj4+IGhhbmRsaW5nIHBhdGhzLCB0aGUgZnVuY3Rpb24gZm9yZ2V0cyB0
byBkZWNyZWFzZSB0aGUgcmVmY291bnQgb2YgaGFuZGxlDQo+Pj4+IGluY3JlYXNlZCBieSBvY2Zz
Ml9zdGFydF90cmFucygpLCBjYXVzaW5nIGEgcmVmY291bnQgbGVhay4NCj4+Pj4gDQo+Pj4+IEZp
eCB0aGlzIGlzc3VlIGJ5IHVzaW5nIG9jZnMyX2NvbW1pdF90cmFucygpIHRvIGRlY3JlYXNlIHRo
ZSByZWZjb3VudA0KPj4+PiBvZiBoYW5kbGUgaW4gdHdvIGhhbmRsaW5nIHBhdGhzLg0KPj4+PiAN
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbnl1YW4gTWkgPGN5bWkyMEBmdWRhbi5lZHUuY248bWFp
bHRvOmN5bWkyMEBmdWRhbi5lZHUuY24+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBYaXl1IFlhbmcg
PHhpeXV5YW5nMTlAZnVkYW4uZWR1LmNuPG1haWx0bzp4aXl1eWFuZzE5QGZ1ZGFuLmVkdS5jbj4+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFhpbiBUYW4gPHRhbnhpbi5jdGZAZ21haWwuY29tPG1haWx0
bzp0YW54aW4uY3RmQGdtYWlsLmNvbT4+DQo+Pj4+IA0KPj4+PiBSZXZpZXdlZC1ieTogSm9zZXBo
IFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb208bWFpbHRvOmpvc2VwaC5xaUBsaW51eC5h
bGliYWJhLmNvbT4+DQo+Pj4+IC0tLQ0KPj4+PiBmcy9vY2ZzMi9hbGxvYy5jIHwgMiArKw0KPj4+
PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0
IGEvZnMvb2NmczIvYWxsb2MuYyBiL2ZzL29jZnMyL2FsbG9jLmMNCj4+Pj4gaW5kZXggZjFjYzgy
NThkMzRhLi5iMDVmZGU3ZWRjM2EgMTAwNjQ0DQo+Pj4+IC0tLSBhL2ZzL29jZnMyL2FsbG9jLmMN
Cj4+Pj4gKysrIGIvZnMvb2NmczIvYWxsb2MuYw0KPj4+PiBAQCAtNTk0MCw2ICs1OTQwLDcgQEAg
c3RhdGljIGludCBvY2ZzMl9yZXBsYXlfdHJ1bmNhdGVfcmVjb3JkcyhzdHJ1Y3Qgb2NmczJfc3Vw
ZXIgKm9zYiwNCj4+Pj4gc3RhdHVzID0gb2NmczJfam91cm5hbF9hY2Nlc3NfZGkoaGFuZGxlLCBJ
Tk9ERV9DQUNIRSh0bF9pbm9kZSksIHRsX2JoLA0KPj4+PiBPQ0ZTMl9KT1VSTkFMX0FDQ0VTU19X
UklURSk7DQo+Pj4+IGlmIChzdGF0dXMgPCAwKSB7DQo+Pj4+ICsgb2NmczJfY29tbWl0X3RyYW5z
KG9zYiwgaGFuZGxlKTsNCj4+Pj4gbWxvZ19lcnJubyhzdGF0dXMpOw0KPj4+PiBnb3RvIGJhaWw7
DQo+Pj4+IH0NCj4+Pj4gQEAgLTU5NjQsNiArNTk2NSw3IEBAIHN0YXRpYyBpbnQgb2NmczJfcmVw
bGF5X3RydW5jYXRlX3JlY29yZHMoc3RydWN0IG9jZnMyX3N1cGVyICpvc2IsDQo+Pj4+ICAgIGRh
dGFfYWxsb2NfYmgsIHN0YXJ0X2JsaywNCj4+Pj4gICAgbnVtX2NsdXN0ZXJzKTsNCj4+Pj4gaWYg
KHN0YXR1cyA8IDApIHsNCj4+Pj4gKyBvY2ZzMl9jb21taXRfdHJhbnMob3NiLCBoYW5kbGUpOw0K
Pj4+PiANCj4+Pj4gQXMgYSB0cmFuc2FjdGlvbiwgc3R1ZmYgZXhwZWN0ZWQgdG8gYmUgaW4gdGhl
IHNhbWUgaGFuZGxlIHNob3VsZCBiZSB0cmVhdGVkIGFzIGF0b21pYy4NCj4+Pj4gSGVyZSB0aGUg
c3R1ZmYgaW5jbHVkZXMgdGhlIHRsX2JoIGFuZCBvdGhlciBtZXRhZGF0YSBibG9jayB3aGljaCB3
aWxsIGJlIG1vZGlmaWVkIGluIG9jZnMyX2ZyZWVfY2x1c3RlcnMoKS4NCj4+Pj4gQ29taW5nIGhl
cmUsIHNvbWUgb2YgcmVsYXRlZCBtZXRhIGJsb2NrcyBtYXkgYmUgaW4gdGhlIGhhbmRsZSBidXQg
b3RoZXJzIGFyZSBub3QgZHVlIHRvIHRoZSBlcnJvciBoYXBwZW5lZC4NCj4+Pj4gSWYgeW91IGRv
IGEgY29tbWl0LCBwYXJ0aWFsIG1ldGEgYmxvY2tzIGFyZSBjb21taXR0ZWQgdG8gbG9nLiDigJQg
dGhhdCBicmVha3MgdGhlIGF0b21pYyBpZGVhLCBpdCB3aWxsIGNhdXNlIEZTIGluY29uc2lzdGVu
Y3kuDQo+Pj4+IFNvIHdoYXTigJlzIHJlYXNvbiB5b3Ugd2FudCB0byBjb21taXQgdGhlIG1ldGEg
YmxvY2sgY2hhbmdlcywgd2hpY2ggaXMgbm90IGFsbCBvZiBleHBlY3RlZCwgaW4gdGhpcyBoYW5k
bGUgdG8gam91cm5hbCBsb2c/DQo+Pj4+IA0KPj4+PiBEbyB5b3UgcmVhbGx5IHNlZSBhIGhpdCBv
biB0aGUgZmFpbHVyZT8gb3IganVzdCB5b3UgZGV0ZWN0ZWQgdGhlIHJlZmNvdW50IGxlYWsgYnkg
Y29kZSByZXZpZXc/DQo+Pj4+IA0KPj4+PiBZb3UgbWF5IHdhbnQgdG8gbG9vayBhdCBvY2ZzMl9q
b3VybmFsX2RpcnR5KCkgZm9yIHRoZSBlcnJvciBoYW5kbGluZyBwYXJ0Lg0KPj4+PiANCj4+Pj4g
DQo+Pj4+IEZvciB0aGUgZmlyc3QgZXJyb3IgaGFuZGxpbmcsIHNpbmNlIHdlIGRvbid0IGNhbGwg
b2NmczJfam91cm5hbF9kaXJ0eSgpDQo+Pj4+IHlldCwgc28gd29uJ3QgYmUgYSBwcm9ibGVtLg0K
Pj4+PiBGb3IgdGhlIHNlY29uZCBlcnJvciBoYW5kbGluZywgSSB0aGluayB3ZSBkb24ndCBoYXZl
IGEgYmV0dGVyIHdheS4gTG9vaw0KPj4+PiBhdCBvdGhlciBjYWxsZXJzIG9mIG9jZnMyX2ZyZWVf
Y2x1c3RlcnMoKSwgd2Ugc2ltcGx5IGlnbm9yZSB0aGUgZXJyb3INCj4+Pj4gY29kZS4NCj4+Pj4g
QW55d2F5LCB3ZSBzaG91bGQgY29tbWl0IHRyYW5zYWN0aW9uIGlmIHN0YXJ0cywgb3RoZXJ3aXNl
IGpvdXJuYWwgd2lsbA0KPj4+PiBiZSBhYm5vcm1hbC4NCj4+Pj4gDQo+Pj4+IEkgZG9uJ3QgdGhp
bmsgc28uIElmIGVycm9yIGhhcHBlbmVkLCB3ZSBzaG91bGQgZmFpbCBvY2ZzMiwgcmF0aGVyIHRo
YW4gZG8gYSBwYXJ0aWFsIGNvbW1pdHRpbmcuDQo+Pj4+IA0KPj4+IA0KPj4+IFVtbS4uLiBub3Qg
ZXhhY3RseS4uLg0KPj4+IFRha2Ugb2NmczJfZnJlZV9jbHVzdGVycygpIGZvciBleGFtcGxlLCB3
aGVuIGl0IGZhaWxzIGluIGNhc2Ugb2YgRUlPIG9yDQo+Pj4gRU5PTUVNLCB3ZSBjYW4ndCBqdXN0
IGFib3J0IGpvdXJuYWwgaW4gc3VjaCBjYXNlcywgYmVjYXVzZSBpdCBpcyBub3Qgc28NCj4+PiBz
ZXJpb3VzLCBvbmx5IGEgYml0IGJsb2NrcyBzdGlsbCBvY2N1cGllZCBhbmQgdGhleSB3aWxsIHJl
Y292ZXJ5IGR1cmluZw0KPj4+IHRoZSBuZXh0IG1vdW50LiANCj4+IA0KPj4gU28gYXJlIHlvdSBz
dXJlIGEgcGFydGlhbCBqb3VybmFsIGNvbW1pdG1lbnQgd29u4oCZdCBjYXVzZSBGUyBpbmNvbnNp
c3RlbmN5PyBhbnkgcHJvb2YgZm9yIHRoYXQ/DQo+PiBQcm9ibGVtIGlzIG5vdCBqdXN0IGlmIHdl
IGNhbiB0cnkgdG8gZnJlZSB0aGUgYmxvY2tzIGFnYWluIG9yIG5vdC4gVGhlIHByb2JsZW0gaXMg
RlMgaW4gaW5jb25zaXN0ZW50IHN0YXRlLg0KPj4gDQo+PiBJIGRpZG7igJl0IGxvb2sgaW50byBv
Y2ZzMl9mcmVlX2NsdXN0ZXJzKCkgZnVydGhlciwgYnV0IGNhbiBpbWFnZSB0aGlzIGNhc2U6DQo+
PiANCj4+IDEpIFdlIGFyZSBnb2luZyB0byBmcmVlIHNvbWUgY2x1c3RlcnMvYmxvY2tzLiANCj4+
IDIpIFdlIG1heSBuZWVkIGEgbmV3IChub3QgbWVyZ2luZyBpbnRvIGV4aXN0aW5nKSByZWNvcmQg
dG8gcmVtZW1iZXIgdGhlIG5ldyBmcmVlIGV4dGVudC4gDQo+PiAzKSBUaGUgbmV3IHJlY29yZCBu
ZWVkcyB0byBiZSBpbnNlcnRlZCBpbnRvIGZyZWUgZXh0ZW50IHRyZWUuDQo+PiA0KSB0aGUgYmxv
Y2sgKGJsb2NrIEEpIHdoZXJlIHRoZSBuZXcgcmVjb3JkIHRvIGJlIGluc2VydGVkIGNvdWxkIGJl
IGFscmVhZHkgZnVsbCB0aHVzIG5vIHNwYWNlIGZvciB0aGUgbmV3IHJlY29yZC4NCj4+IDUpIHRo
ZW4gd2UgbmVlZCBhdCBsZWFzdCBhIG5ldyBibG9jayAoYmxvY2sgQikgdG8gc3RvcmUgdGhlIG5l
dyByZWNvcmQuICh0byBtYWludGFpbiB0aGUgZnJlZSBibG9jayBidHJlZSwgbWF5YmUgYW5vdGhl
ciBibG9jaywgYmxvY2sgQyBpcyBuZWVkZWQgdG9vKS4NCj4+IDYpIFNvIHdlIG5lZWQgdG8gc2F2
ZSB0aGUgcG9pbnRlciAoYmxvY2sgbnVtYmVyKSBvZiBibG9jayBCIGluIGJsb2NrIEEgYW5kIHN0
b3JlIHRoZSBuZXcgcmVjb3JkIGluIGJsb2NrIEIuDQo+PiA3KSBJbiB0aGlzIGNhc2Ugd2UgbmVl
ZCB0byBtYWtlIHN1cmUgYmxvY2sgQSBhbmQgYmxvY2sgQiBlaXRoZXIgYm90aCBpbiBqb3VybmFs
IGxvZywgb3Igbm9uZSBvZiB0aGVtIGluIGpvdXJuYWwgbG9nLiAgV2UgZG9u4oCZdCBhbGxvdyBi
bG9jayBBIGlzIGluIGpvdXJuYWwgYm90IGJsb2NrIEIgaXMgbm90LCByaWdodD8NCj4+IA0KPj4g
Z28gYmFjayB0byBxdWVzdGlvbiwgICBFcnJvciBjb3VsZCBhZnRlciBibG9jayBCIGlzIGFkZGVk
IHRvIGpvdXJuYWwgaGFuZGxlIGJ1dCBiZWZvcmUgYmxvY2sgQSBpcyBhZGRlZC4gSW4gY2FzZSB3
ZSBkbyBhIGpvdXJuYWwgY29tbWl0IHdoZW4gaGl0dGluZyB0aGF0IGVycm9yLCB3ZSBhcmUgY29t
bWl0dGluZyBibG9jayBCIHRvIGpvdXJuYWwgYnV0IGxlYXZpbmcgYmxvY2sgQSBub3QgaW4uDQo+
PiBJZiBwYW5pYyBoYXBwZW5lZCwgYmxvY2sgQSBjb3VsZCBuZXZlciBoYXMgdGhlIHBvaW50ZXIg
cG9pbnRpbmcgdG8gYmxvY2sgQi4gVGhlIHJlc3VsdCBpcyBibG9jayBCIGlzIHBlcm1hbmVudGx5
IGxvc3QgKHdlIGNhbiBuZXZlciByZXVzZSB0aGlzIGJsb2NrIGFnYWluKS4gDQo+PiBPciBpZiB3
ZSBhZGQgYmxvY2sgQSB0byBqb3VybmFsIGZpcnN0IGJlZm9yZSBhZGRpbmcgYmxvY2sgQiBhbmQg
ZXJyb3IgaGFwcGVucyBBZnRlciBibG9jayBBIGlzIGFkZGVkIGFuZCBiZWZvcmUgYmxvY2sgQiBp
cyBhZGRlZC4gIFRoZW4gd2UgaGF2ZSB0aGUgcG9pbnRlciBwb2ludGluZyB0byBibG9jayBCIGlu
IGJsb2NrIEEgYWZ0ZXIgcGFuaWMsIGJ1dCBibG9jayBCIGRvZXNu4oCZdCBjb250YWluIHZhbGlk
IGNvbnRlbnRzLiBUaGUgcmVzdWx0IGlzIHRoYXQgd2Ugd2lsbCBoaXQgcHJvYmxlbSB3aGVuIHZp
c2l0aW5nIGJsb2NrIEIgYXMgYSB2YWxpZCBidHJlZSBibG9jay4NCj4+IA0KPj4gDQo+Pj4gVGhh
dCdzIHdoeSB3ZSBoYXZlICJlcnJvcnM9Y29udGludWUiIGluIG1vc3QgZmlsZXN5c3RlbXMsIHdl
IHNob3VsZCBhbHdheXMNCj4+PiBjb25zaWRlciB0aGUgYnVzaW5lc3MgY29udGludWl0eSBmaXJz
dC4NCj4+PiBBbHNvIHlvdSBjYW4gbG9vayBhdCBleHQ0X2ZyZWVfYmxvY2tzKCkgZm9yIHJlZmVy
ZW5jZS4NCj4+IA0KPj4gT0NGUzIgZG9lc27igJl0IHN1cHBvcnQgRVJST1JTX0NPTlQsIG9yIHRv
IHNheSBpdCBqdXN0IGlnbm9yZSB0aGF0IG9wdGlvbi4gIE5vIG1hdHRlciBFUlJPUlNfQ09OVCBp
cyBzdXBwb3J0ZWQgb3Igbm90IGJ5IE9DRlMyLA0KPj4gVGhlIGtleSBpcyBub3QgdG8gbGVhdmUg
dGhlIEZTIGluIGluY29uc2lzdGVudCBzdGF0ZS4NCj4+IA0KPiANCj4gSSBkaWRuJ3Qgc2F5IGl0
IHdvbid0IGNhdXNlIGluY29uc2lzdGVuY3ksIGJ1dCAiZG9uJ3QgaGF2ZSBhIGJldHRlciB3YXki
Lg0KPiBJSVVDLCBvY2ZzMl9mcmVlX2NsdXN0ZXIoKSBtYWlubHkgY2xlYXJzIHRoZSBiaXRtYXAg
YW5kIG1hcmsgdGhlbSBmcmVlIGFnYWluLg0KPiBTbyB0aGUgbG9zdCBzcGFjZSBpcyBzb21lIHdo
YXQgYSBjb3N0IGZvciAicGxlYXNlIGRvbid0IGFib3J0IGJ1c2luZXNzIGlmDQo+IGVycm9yIGhh
cHBlbnMgYnV0IG5vdCBiZSBzbyBzZXJpb3VzIi4gSSB0aGluayB0aGF0J3Mgd2h5IG90aGVyIGNh
bGxlcnMgd2lsbA0KPiBhbHNvIGNvbW1pdCB0cmFuc2FjdGlvbiBldmVuIG9jZnMyX2ZyZWVfY2x1
c3RlcigpIGZhaWxzLg0KPiANCg0KSG0uLiBPSywgc2VlbXMgaXQgbmVlZHMgYSBiaWcgZWZmb3J0
IHRvIOKAnGhhdmUgYSBiZXR0ZXIgd2F54oCdLg0KQW5kIE1heWJlIGZyZWVpbmcgYmxvY2tzIGlz
IG5vdCDigJxzbyBzZXJpb3Vz4oCdLCBJIGxldCBpdCBnby4NCg0KdGhhbmtzLA0Kd2VuZ2FuZw0K
DQo=
