Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDD371712
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhECOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:50:40 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:55886 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhECOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:50:36 -0400
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143ElxiX015118;
        Mon, 3 May 2021 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=tc+C1aZr2VHl5tZH1Jw6Gu0lP5vZClqO4CzeiqCqRUQ=;
 b=EqHMucpKONYbWxGkbcp/wBwUUvgU+x8EX3je2YjpYBanuJ4uQfGo+4WzPqT0bxoZ6CXE
 l/Xcdv5S524nQKxijFzSNRsKMMAHlyLZ9eINjU0nGE3HYASE4MgUY9/9GN/OmLJQtzqk
 StqLMU7BP5Q22BDOU4Y7w+iRdLxSVGS7FXhztJCJO2OdICPf2Fkp+GUyB2DS2d24cnRZ
 dwkColxzC9az50mwUh6Xw9W/E47kITmkpH2V9kCryTAY3sHaH/6uaEoErZIKPu68POOO
 q8ifTOLGneYt8VY0qe6CBByoeW6dt1+ZFmAK5lcqHOl3s7xPCWgcr2AoCuYws5WZ7Nhk Xg== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
        by mx08-001d1705.pphosted.com with ESMTP id 3897hurv6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:48:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INXtFMkQSGxgO9IYTRcFVhQE4wBgUTkTdmxCwdkylVmdQxUa3gGZzArxuZY4rR9VlcdBPSrCuEG7JdKZKqoohKnvUpNTwfbJJbSEMsXBwCdI442K6dk5VpE6VlQtzP+5OuRj4XkxSbesxlQOcC2RrzHoysgbY5t39O0wvG3+fJtEBBvhITO0pxKChnnhcXbzeZpXZHbE5HD6CC1sFp/hd+C2PVrnooUMkgWohwzi2dVjz9ioWJIuXo4Z1BpXq/N9ViHDIqmLjXvqVmc0NQXQJ95r8gZhR6Y3o++IJMIYTpKu22sBfyhvo7f1Fi8h1N36dMQACmR05lvsmdXpOKHzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc+C1aZr2VHl5tZH1Jw6Gu0lP5vZClqO4CzeiqCqRUQ=;
 b=Mc/paqA/aNjeI4L67lJ+cd7nn+Sf25ubLNResptbBU3J/WUF3VF4N9Iw2ZB1jANru7oEu7g3L2gWBDNK+u4xKITHb72NfE90PA2Zm5ayAFMlMvcL87wRTFf9BrQr2eBnZCrMbVh2zQUplEXts85AgAQbHkWIBVvX0xaHyPSBeWi76JYDnjAlyzNHl4fxo1USKz0lB4Wx3/BRsGv7qx9ZFfa7gX7V1BVRRPOSXrP3LUPt8cpKG53Unl24z7njsovL9WCnn3nWDq9BASpo/pfhWQMHyKF7teclG0rIcTnAw/RFuu4GKMWJo1hvM0BrdttN0Ofmsye0lMLvjejKMuwLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1636.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Mon, 3 May
 2021 14:48:33 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:48:33 +0000
From:   <Peter.Enderborg@sony.com>
To:     <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>
CC:     <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <ast@kernel.org>,
        <christian.brauner@ubuntu.com>, <dave@stgolabs.net>,
        <walken@google.com>, <jannh@google.com>, <christophe.leroy@c-s.fr>,
        <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Topic: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Index: wQHXPcxKtEu4vBDankanfcyX4+Z7rarR2y0A
Date:   Mon, 3 May 2021 14:48:33 +0000
Message-ID: <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
 <20210430142223.25500-2-peter.enderborg@sony.com>
 <m14kfnzmsp.fsf@fess.ebiederm.org>
 <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
 <20210501091104.418765bd@oasis.local.home>
 <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
In-Reply-To: <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: efficios.com; dkim=none (message not signed)
 header.d=none;efficios.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a401f4-ff00-4327-e6f8-08d90e428681
x-ms-traffictypediagnostic: AM9P193MB1636:
x-microsoft-antispam-prvs: <AM9P193MB16364B8DBEE050F056E5E463865B9@AM9P193MB1636.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgyfBHLqb+DwTnaQZjpTmqKNfpPloMkIa+V77hqsHk2YXokpfIPadjrcqaA+6ER6I0ZX+1s1GAaKIg4xUEsB0vWkOcAG5c53GfM0OWxLST+7RddcaR35WZjX52ymfblVgtheoKXtINII3JM6V/pt3XfbBP2srw3b4FqetsM3TWQBPaek1vnxORi/4oFmBrr2kzYAeFnZ+w0q452rej9T8bHucWka3ywPSEh3ixzgPuvSe1SciJpduMz091lm7sggutc13LRD3Rv+sxJ04LN8/fNHCbED/inkdmF2fHQPNlk0X42sQ2pLDcrl6MprjMm7RYEbsLgSyBMVXoeM0JS71UtdeidHO1+9aKfGIGvu6NMeX8ZBMYfAfg5u+W32OIg7miNmEzR2ZxnO1wXeOiHDa5oPmyL/+4HyThUG1bYO7syxQyXVq9Y9kJQgLY2d9vBUqoFQIgEOaAqKwCVFY/P2MRlctPQC5ui9E2UlR4Qu70zo5ytto+bkpfdFYZcgd6GUbUylujYPCPymRFnngq8o09Yi554V/9qX6WNmm0rQA8mSNq1Ik2izTfFiGrVkEAeUWbV8nxlALAFGUGqpaSoba4HJoRob7GRqMgmag/s3odVA4blWGe4vVLmtYUuduh/0en26g86HkGXSQHNcbcWYqTeLhopdny5uLnBgtENF6Ehudho5vWg+cCrFD7Wy9MRF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(478600001)(6506007)(91956017)(2616005)(76116006)(110136005)(316002)(54906003)(31686004)(8936002)(66946007)(8676002)(6486002)(66446008)(122000001)(31696002)(64756008)(38100700002)(66556008)(66476007)(53546011)(83380400001)(5660300002)(4326008)(71200400001)(86362001)(6512007)(2906002)(36756003)(7416002)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXBJNWV2TUpTa2tCdGh0ZmVBRjZwbzVmUGRPV3ZpRnIza1dJNTRDSnBpcVJs?=
 =?utf-8?B?RjFIbUs4TFhwcWdqRDJHYUY1ajNhMWlvVGVRUGVXM2hvSmtmUm1EQlREZysx?=
 =?utf-8?B?andpWXVENlE3eUw2WXZ2dllQL1IvUnl3cXhkK1BmWThvYnErOGRjMWtUempD?=
 =?utf-8?B?RnlrcThPN3pRZ0kzNXpoaUk4ZzFRZnRYUXh5SGhpVU5paHVxZ0RaUUFpRGNZ?=
 =?utf-8?B?eTB1eDVmYUtuYlVQSTRJOTRRdDRUZmM5YkZ4eVBWWTdZNEZpYWZYTy9QZVh6?=
 =?utf-8?B?QUZxeUlZaWNXQVovZmVuWE44a1ZqQzkvN2ZHaDcxV2Z0WjB1VzcxRzRDb3Qz?=
 =?utf-8?B?ZGlNUkEraVlGV0ppTVc1eDZ6UUJRS1ZNdG10aThJWVZFNnFEaTBNaXBWSHNF?=
 =?utf-8?B?MG5jUUhad1U5dUJxQUg5RkZRamtmS1JERnNkQzF4VmlwRXhXaDFSRStRUUV1?=
 =?utf-8?B?MG5Xd0doUkwyM2QxV2pjbnROQWRiQlpGSTBuQ2VzYmdoRk40OCsvTTJJelMx?=
 =?utf-8?B?QStkMGVmZmhRdjY0b3M1a3pvUzVCbkN1QVlnd3Q5bzZhTjNjb3dFYmZLUFpN?=
 =?utf-8?B?K3I4aktsU1h0bFI1c2hhUUhtYnVKTnh0TVVMam8yT2JhaXhOSEY2bHNrOUFh?=
 =?utf-8?B?V2M3OWFCYWR1cllvMTZPdnNYdUh1czRDV0V5S0xnWERJaWhKemVqanZnWDVp?=
 =?utf-8?B?R0c5MTUzRTF6VGZ1SlozL0RVMzNOWEliankzSTgydlZyUmVKMXpoNnpqV1RE?=
 =?utf-8?B?ZGV3bGhsa2NVRUlmSHZRTXhVanR6MXZIZEtSTGZxZytYTDJpUUh4Y0Z6bytz?=
 =?utf-8?B?YzBWVWlMeDlLMEt1b3R2WGRQeEUvV2xpQlRqMnBOMVppMnRhN3hXNmNvVlhy?=
 =?utf-8?B?ck5KeGVheERySDh1UjJvd2dYK1VyektCYUNPTlB3cldZSVJOVDY5dVNwUFNZ?=
 =?utf-8?B?RlZoN2FHVDdrVm55VUlZeXVmSGhWMnIzdFE5NEkvdjhIb2NWK2I3dkk4VGNN?=
 =?utf-8?B?eG9FWG9oZ09xTzQ5L1FseGszZHFDMHI3Tm1MV2p5ek44R0VscDdnVzZwZXJx?=
 =?utf-8?B?RTZiVWxBdHBSY2dZU1VraTZqazlyaW04eHBna3RrSFFRdzdjK2xwRDdhMDV0?=
 =?utf-8?B?aC9rQThOK2hVZFAybHJIVVdaalNkMnFsU21qQkNDUzhXT2RMVFBNLzNUL2g0?=
 =?utf-8?B?WURla0xDNDYxWTQ2VG13aVB1THg3MjhaUzlsZDJEbkRqdjJhVzg3MVRSalc0?=
 =?utf-8?B?KytiNkdQTlVhRHR0M3R5TFlXa1dncUI4dSswczRCK0dROS8rVmE2K2pLenlG?=
 =?utf-8?B?MkNoajZKZEh0elZKYzlDS0h3QU5LTEVTU3J1bHN1SlBuM29STm1xTTNQeFV5?=
 =?utf-8?B?eTFwYkRWcXQzSmNMVnVKcDBpSDcrTSs1eGYyME5tNmxyUzFYSEVLanppRFdU?=
 =?utf-8?B?MC9rNHNyQmNuejUwYlNTK3F6bkI1MU1STC94RGVXdWVQT1kzcjAvRmJjODFM?=
 =?utf-8?B?L3hnRkV6NC9wSkx2bURhbUlCU0NqQXkwb1B4N1pjUVV6VHB1bDlGUllrYU1F?=
 =?utf-8?B?MEl2c05PdTRFTURmQ3dqVnZUY05Ud3NkOHhHQ3RBYUtObzBPQ0h4b0Q0NWRw?=
 =?utf-8?B?bEd4SzhYTjlTcFA0YUE2clhhbCt3VWVycnZPVzBjRnI5UzlzSDl0YVFhdDha?=
 =?utf-8?B?Y3ZKY2FST2wxS2l1YWc5dXg1RlFlai9YVmtiRDhoSlQ1L20rcFB3R0p3MFhE?=
 =?utf-8?B?b1NWbFBhYmUrOS9ZYUV6SEpoeGlMV0VjYlJPQ250eTRpbWYyUWdXellFQyt6?=
 =?utf-8?B?MExEVXdKby9SQzVoV0NwQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <07EA2391B99FC141846203A39B86A7FA@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a401f4-ff00-4327-e6f8-08d90e428681
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 14:48:33.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XamugNob3R5128oGNC0Ro7mo6b+dNjYcseA8nEKwz+AvM6qxV2TKYkaTLIvaqpcUoxsfgiDh4I4Zb0MXQIMQlNVhwbwxWC5ltZ/3rRDbvLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1636
X-Proofpoint-ORIG-GUID: xzPTbeZux1_19UkFU500Tk1nf7wc4rtb
X-Proofpoint-GUID: xzPTbeZux1_19UkFU500Tk1nf7wc4rtb
X-Sony-Outbound-GUID: xzPTbeZux1_19UkFU500Tk1nf7wc4rtb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIxIDM6NTAgUE0sIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiAtLS0tLSBPbiBN
YXkgMSwgMjAyMSwgYXQgOToxMSBBTSwgcm9zdGVkdCByb3N0ZWR0QGdvb2RtaXMub3JnIHdyb3Rl
Og0KPg0KPj4gT24gU2F0LCAxIE1heSAyMDIxIDA5OjI5OjQxICswMDAwDQo+PiA8UGV0ZXIuRW5k
ZXJib3JnQHNvbnkuY29tPiB3cm90ZToNCj4+DQo+Pj4gT24gNC8zMC8yMSA3OjQ4IFBNLCBFcmlj
IFcuIEJpZWRlcm1hbiB3cm90ZToNCj4+Pj4gUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJv
cmdAc29ueS5jb20+IHdyaXRlczoNCj4+Pj4gIA0KPj4+Pj4gVGhpcyBpcyB0aGUgcGVlciBmdW5j
dGlvbnMgdG8gdGFza19yZW5hbWUgYW5kIHRhc2tfbmV3dGFzay4NCj4+Pj4+IFdpdGggdGhpcyB3
ZSBnZXQgaG9sZSAibGlmZS1jeWNsZSIgb2YgdGFzayBhbmQgY2FuIGVhc2lseQ0KPj4+Pj4gc2Vl
IHNob3J0IGxpdmllZCB0YXNrIGFuZCB0aGVpciBleGl0IHN0YXR1cy4NCj4+Pj4gVGhpcyBwYXRj
aCBpcyBpbmNvcnJlY3QuICBUaGUgbG9jYXRpb24geW91IGFyZSBkZWFsaW5nIHdpdGggaXMgbm90
IHBhcnQNCj4+Pj4gb2YgdGFzayBleGl0LiAgVGhlIGxvY2F0aW9uIHlvdSBoYXZlIGluc3RydW1l
bnRlZCBpcyBwYXJ0IG9mIHJlYXBpbmcgYQ0KPj4+PiB0YXNrIHdoaWNoIGNhbiBjb21lIGFyYml0
cmFyaWx5IGxvbmcgYWZ0ZXIgdGhlIHRhc2sgZXhpdHMuDQo+Pj4gVGhhdCBpcyB3aGF0IGl0IGFp
bWluZy4gV2hlbiB1c2luZyB0aGlzIGFzIHRvb2wgZm9yIHVzZXJzcGFjZSB5b3UNCj4+PiB3b3Vs
ZCBsaWtlIHRvIGtub3cgd2hlbiB0aGUgdGFzayBpcyBkb25lLiBXaGVuIGl0IG5vIGxvbmdlcg0K
Pj4+IGhvbGRzIGFueSB0aGluZyB0aGF0IG1pZ2h0IGhhdmUgYW55IGltcGFjdC4gSWYgeW91IHRo
aW5rIHRoZQ0KPj4+IGV4aXQgaW1wbHkgc29tZXRoaW5nIG1vcmUgc3BlY2lmaWMgSSBjYW4gY2hh
bmdlIHRoZSBuYW1lLg0KPj4+DQo+Pj4gSSB0aG91Z2h0IGV4aXQgd2FzIGEgZ29vZCBuYW1lLCBp
dCBpcyBpbiBpbiBleGl0LmMuDQo+Pj4NCj4+PiBXaWxsIHRoZSBuYW1lIHRhc2tfZG9uZSwgdGFz
a19maW5pc2hlZCBvciB0YXNrX3JlYXBlZCB3b3JrIGZvciB5b3U/DQo+PiBJIHRoaW5rICJ0YXNr
X3JlYXBlZCIgaXMgcHJvYmFibHkgdGhlIGJlc3QgbmFtZSwgYW5kIHRoZSBtb3N0DQo+PiBkZXNj
cmlwdGl2ZSBvZiB3aGF0IGhhcHBlbmVkLg0KPiBXaGF0IHdvdWxkIGl0IHByb3ZpZGUgdGhhdCBp
cyBub3QgYWxyZWFkeSBhdmFpbGFibGUgdGhyb3VnaCB0aGUgInNjaGVkX3Byb2Nlc3NfZnJlZSIN
Cj4gdHJhY2Vwb2ludCBpbiBkZWxheWVkX3B1dF90YXNrX3N0cnVjdCA/DQoNCkZvciB0YXNrX2V4
aXQgKG9yIHRhc2tfcmVhcGVkKQ0KDQrCoMKgwqDCoMKgwqDCoCBmaWVsZDpwaWRfdCBwaWQ7wqDC
oMKgwqDCoMKgwqAgb2Zmc2V0Ojg7wqDCoMKgwqDCoMKgIHNpemU6NDsgc2lnbmVkOjE7DQrCoMKg
wqDCoMKgwqDCoCBmaWVsZDpzaG9ydCBvb21fc2NvcmVfYWRqO8KgwqDCoMKgwqAgb2Zmc2V0OjEy
O8KgwqDCoMKgwqAgc2l6ZToyOyBzaWduZWQ6MTsNCsKgwqDCoMKgwqDCoMKgIGZpZWxkOmludCBl
eGl0X3NpZ25hbDvCoCBvZmZzZXQ6MTY7wqDCoMKgwqDCoCBzaXplOjQ7IHNpZ25lZDoxOw0KwqDC
oMKgwqDCoMKgwqAgZmllbGQ6aW50IGV4aXRfY29kZTvCoMKgwqAgb2Zmc2V0OjIwO8KgwqDCoMKg
wqAgc2l6ZTo0OyBzaWduZWQ6MTsNCsKgwqDCoMKgwqDCoMKgIGZpZWxkOmludCBleGl0X3N0YXRl
O8KgwqAgb2Zmc2V0OjI0O8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6MTsNCsKgwqDCoMKgwqDC
oMKgIGZpZWxkOl9fZGF0YV9sb2MgY2hhcltdIGNvbW07wqDCoCBvZmZzZXQ6Mjg7wqDCoMKgwqDC
oCBzaXplOjQ7IHNpZ25lZDoxOw0KDQpzY2hlZF9wcm9jZXNzX2ZyZWUNCsKgwqDCoMKgwqDCoMKg
IGZpZWxkOmNoYXIgY29tbVsxNl07wqDCoMKgIG9mZnNldDo4O8KgwqDCoMKgwqDCoCBzaXplOjE2
O8KgwqDCoMKgwqDCoMKgIHNpZ25lZDoxOw0KwqDCoMKgwqDCoMKgwqAgZmllbGQ6cGlkX3QgcGlk
O8KgwqDCoMKgwqDCoMKgIG9mZnNldDoyNDvCoMKgwqDCoMKgIHNpemU6NDsgc2lnbmVkOjE7DQrC
oMKgwqDCoMKgwqDCoCBmaWVsZDppbnQgcHJpbzsgb2Zmc2V0OjI4O8KgwqDCoMKgwqAgc2l6ZTo0
OyBzaWduZWQ6MTsNCg0KU28gaW5mb3JtYXRpb24gYWJvdXQgb29tX3Njb3JlX2FkaiwgYW5kIGl0
J3MgZXhpdCBwYXJhbWV0ZXJzLg0KDQpBbmQgaXQgaXMgYWxzbyBnaXZlcyBpbmZvcm1hdGlvbiBv
biBrZXJuZWwgdGFza3MuIFRoZSB0YXNrIGV4aXQgYWxzbw0KZ2l2ZXMgaW5mb3JtYXRpb24gYWJv
dXQgaXQncyBwYXJlbnQuwqDCoCBzY2hlZF9wcm9jZXNzX2ZyZWUgaXMgImlkbGUiIGFzIHBhcmVu
dC4NCg0KwqDCoMKgwqDCoMKgwqDCoMKgIHNzaGQtNzM5OcKgwqDCoCBbMDAyXSBkLi4uIDI2MjIy
My4yNTgwMTg6IHRhc2tfZXhpdDogcGlkPTc0MDAgb29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFs
PTE3IGV4aXRfY29kZT0wIGV4aXRfc3RhdGU9MHgxMCBjb21tPWxzDQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNzaGQtNzM5NcKgwqDCoCBbMDA3XSAuLnMuIDI2MjIyMy4yNjM0Mjk6IHNjaGVkX3By
b2Nlc3NfZnJlZTogY29tbT1wcyBwaWQ9NzQyOCBwcmlvPTEyMA0KwqDCoMKgwqDCoMKgwqDCoMKg
IDxpZGxlPi0wwqDCoMKgwqDCoMKgIFswMDVdIC4ucy4gMjYyMjIzLjI2MzQ0MDogc2NoZWRfcHJv
Y2Vzc19mcmVlOiBjb21tPWJhc2VuYW1lIHBpZD03NDI3IHByaW89MTIwDQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNzaGQtODAwwqDCoMKgwqAgWzAwN10gZC4uLiAyNjIyMjMuMjYzODQ0OiB0YXNr
X2V4aXQ6IHBpZD03Mzk1IG9vbV9zY29yZV9hZGo9MCBleGl0X3NpZ25hbD0xNyBleGl0X2NvZGU9
NjUyODAgZXhpdF9zdGF0ZT0weDEwIGNvbW09c3NoZA0KwqDCoMKgwqDCoMKgwqDCoCBzeXN0ZW1k
LTHCoMKgwqDCoMKgwqAgWzAwMV0gZC4uLiAyNjIyMjMuMjY0MTI2OiB0YXNrX2V4aXQ6IHBpZD03
Mzk5IG9vbV9zY29yZV9hZGo9MCBleGl0X3NpZ25hbD0xNyBleGl0X2NvZGU9NjUyODAgZXhpdF9z
dGF0ZT0weDEwIGNvbW09c3NoZA0KwqDCoMKgwqDCoMKgwqDCoMKgIDxpZGxlPi0wwqDCoMKgwqDC
oMKgIFswMDJdIC4ucy4gMjYyMjIzLjI2ODQzOTogc2NoZWRfcHJvY2Vzc19mcmVlOiBjb21tPWxz
IHBpZD03NDAwIHByaW89MTIwDQrCoMKgwqDCoMKgwqDCoMKgwqAgPGlkbGU+LTDCoMKgwqDCoMKg
wqAgWzAwN10gLi5zLiAyNjIyMjMuMjcyNDg0OiBzY2hlZF9wcm9jZXNzX2ZyZWU6IGNvbW09c3No
ZCBwaWQ9NzM5NSBwcmlvPTEyMA0KwqDCoMKgwqDCoMKgwqDCoMKgIDxpZGxlPi0wwqDCoMKgwqDC
oMKgIFswMDFdIC4ucy4gMjYyMjIzLjI3MzQ0Njogc2NoZWRfcHJvY2Vzc19mcmVlOiBjb21tPXNz
aGQgcGlkPTczOTkgcHJpbz0xMjANCg0KV2l0aCB0aGUgZXhpdF9zaWduYWwgeW91IGNhbiBhbHNv
IHNlZSB0aGF0IHRoZSBwcm9jZXNzIGlzIGdvbmUsIG5vdCBvbmx5IG9uZSBvZiB0aGUgdGhyZWFk
IHRoYXQgbWlnaHQgbm90IGJlIHRoZSBsYXN0Lg0KDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHQtNzczNMKgwqDCoCBbMDA2XSAuLi4uIDI2Mzk0Ni40Mjc3MDQ6IHRhc2tfbmV3dGFzazog
cGlkPTc3MzYgY29tbT10IGNsb25lX2ZsYWdzPTNkMGYwMCBvb21fc2NvcmVfYWRqPTANCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdC03NzM0wqDCoMKgIFswMDZdIC4uLi4gMjYzOTQ2LjQy
Nzc3ODogdGFza19uZXd0YXNrOiBwaWQ9NzczNyBjb21tPXQgY2xvbmVfZmxhZ3M9M2QwZjAwIG9v
bV9zY29yZV9hZGo9MA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0LTc3MzXCoMKgwqAg
WzAwMF0gLi4uLiAyNjM5NDYuNDI4MTM4OiB0YXNrX25ld3Rhc2s6IHBpZD03NzM4IGNvbW09dCBj
bG9uZV9mbGFncz0zZDBmMDAgb29tX3Njb3JlX2Fkaj0wDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHQtNzczNsKgwqDCoCBbMDAxXSAuLi4uIDI2Mzk0Ni40MjgzODc6IHRhc2tfbmV3dGFz
azogcGlkPTc3MzkgY29tbT10IGNsb25lX2ZsYWdzPTNkMGYwMCBvb21fc2NvcmVfYWRqPTANCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdC03NzM3wqDCoMKgIFswMDJdIC4uLi4gMjYzOTQ2
LjQyODUxNTogdGFza19uZXd0YXNrOiBwaWQ9Nzc0MCBjb21tPXQgY2xvbmVfZmxhZ3M9M2QwZjAw
IG9vbV9zY29yZV9hZGo9MA0KwqDCoMKgwqDCoMKgwqDCoMKgwqAgPC4uLj4tNzc0MMKgwqDCoCBb
MDAyXSBkTi4uIDI2Mzk3OS4yODk2NDc6IHRhc2tfZXhpdDogcGlkPTc3NDAgb29tX3Njb3JlX2Fk
aj0wIGV4aXRfc2lnbmFsPS0xIGV4aXRfY29kZT0xNSBleGl0X3N0YXRlPTB4MTAgY29tbT10DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQtNzczOcKgwqDCoCBbMDAxXSBkTi4uIDI2Mzk3
OS4yODk2NjE6IHRhc2tfZXhpdDogcGlkPTc3Mzkgb29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFs
PS0xIGV4aXRfY29kZT0xNSBleGl0X3N0YXRlPTB4MTAgY29tbT10DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHQtNzczOMKgwqDCoCBbMDAwXSBkTi4uIDI2Mzk3OS4yODk2ODI6IHRhc2tf
ZXhpdDogcGlkPTc3Mzggb29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFsPS0xIGV4aXRfY29kZT0x
NSBleGl0X3N0YXRlPTB4MTAgY29tbT10DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQt
NzczN8KgwqDCoCBbMDAyXSBkTi4uIDI2Mzk3OS4yODk2ODY6IHRhc2tfZXhpdDogcGlkPTc3Mzcg
b29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFsPS0xIGV4aXRfY29kZT0xNSBleGl0X3N0YXRlPTB4
MTAgY29tbT10DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQtNzczNsKgwqDCoCBbMDAx
XSBkTi4uIDI2Mzk3OS4yODk2OTA6IHRhc2tfZXhpdDogcGlkPTc3MzYgb29tX3Njb3JlX2Fkaj0w
IGV4aXRfc2lnbmFsPS0xIGV4aXRfY29kZT0xNSBleGl0X3N0YXRlPTB4MTAgY29tbT10DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQtNzczNcKgwqDCoCBbMDAwXSBkTi4uIDI2Mzk3OS4y
ODk3MDI6IHRhc2tfZXhpdDogcGlkPTc3MzUgb29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFsPS0x
IGV4aXRfY29kZT0xNSBleGl0X3N0YXRlPTB4MTAgY29tbT10DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJhc2gtNzQ1NcKgwqDCoCBbMDA1XSBkLi4uIDI2Mzk3OS4yODk4NTE6IHRhc2tfZXhpdDog
cGlkPTc3MzQgb29tX3Njb3JlX2Fkaj0wIGV4aXRfc2lnbmFsPTE3IGV4aXRfY29kZT0xNSBleGl0
X3N0YXRlPTB4MTAgY29tbT10DQrCoMKgwqDCoMKgwqDCoMKgwqDCoCA8Li4uPi03NDDCoMKgwqDC
oCBbMDA1XSAuLnMuIDI2Mzk3OS4zODQ0Nzc6IHNjaGVkX3Byb2Nlc3NfZnJlZTogY29tbT10IHBp
ZD03NzM0IHByaW89MTIwDQrCoMKgwqDCoMKgwqDCoMKgwqAgPGlkbGU+LTDCoMKgwqDCoMKgwqAg
WzAwMF0gLi5zLiAyNjM5NzkuMzg0NDgxOiBzY2hlZF9wcm9jZXNzX2ZyZWU6IGNvbW09dCBwaWQ9
NzczOCBwcmlvPTEyMA0KwqDCoMKgwqDCoMKgwqDCoMKgIDxpZGxlPi0wwqDCoMKgwqDCoMKgIFsw
MDBdIC4ucy4gMjYzOTc5LjM4NDQ4ODogc2NoZWRfcHJvY2Vzc19mcmVlOiBjb21tPXQgcGlkPTc3
MzUgcHJpbz0xMjANCsKgwqDCoMKgwqDCoMKgwqDCoCA8aWRsZT4tMMKgwqDCoMKgwqDCoCBbMDAx
XSAuLnMuIDI2Mzk3OS4zODU0ODI6IHNjaGVkX3Byb2Nlc3NfZnJlZTogY29tbT10IHBpZD03NzM5
IHByaW89MTIwDQrCoMKgwqDCoMKgwqDCoMKgwqAgPGlkbGU+LTDCoMKgwqDCoMKgwqAgWzAwMV0g
Li5zLiAyNjM5NzkuMzg1NDk2OiBzY2hlZF9wcm9jZXNzX2ZyZWU6IGNvbW09dCBwaWQ9NzczNiBw
cmlvPTEyMA0KwqDCoMKgwqDCoMKgwqDCoMKgIDxpZGxlPi0wwqDCoMKgwqDCoMKgIFswMDJdIC4u
cy4gMjYzOTc5LjQ4OTQ2OTogc2NoZWRfcHJvY2Vzc19mcmVlOiBjb21tPXQgcGlkPTc3NDAgcHJp
bz0xMjANCsKgwqDCoMKgwqDCoMKgwqDCoCA8aWRsZT4tMMKgwqDCoMKgwqDCoCBbMDAyXSAuLnMu
IDI2Mzk3OS40ODk0OTA6IHNjaGVkX3Byb2Nlc3NfZnJlZTogY29tbT10IHBpZD03NzM3IHByaW89
MTIwDQoNCk5vdCBhbHNvIHRoZSBvcmRlci4NCg0KPiBUaGFua3MsDQo+DQo+IE1hdGhpZXUNCj4N
ClRoYW5rcw0KDQpQZXRlcg0K
