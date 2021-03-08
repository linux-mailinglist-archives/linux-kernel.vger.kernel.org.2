Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1881B3308E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhCHHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:38:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:19590 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhCHHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:37:56 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1287VYRJ026232;
        Sun, 7 Mar 2021 23:37:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=nPZpZVOE3rH0rGPpvunPGg27qMUOxEkJsASasZ+WE7A=;
 b=pDgcseqMU3jgaaDaUGQ4q6hmn6jZn1+i6npkADkAEi0ZGerqoKg+6RWz4/SAodIneXvD
 QuJPjnF8qvn/g3K/A/cA77CqSIas6hU79nRqHdADjTsFhxtiv2cD8k/Zep11yfskXhz6
 hzvOJ+76vIkpLtlHqmRS9xC6pjbG9SEL8yYwFo4fQDQ0EPVP8AxIjBYe+Sw6vB5DNxn+
 7uoOyWMdGrcoSYJgvv+GopOjs/9wPKGyD0m7Gv5wzdGWP9bjqNKdrLUMsptIeOykEFMU
 S3p8b8MgXEdNvUntEOIRKUoXYcBVG/8VQQmUyGxrVJ/FyEYssse/TpL/yFTstBUhSaXN eg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762v4eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 23:37:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIcL+mQpAZKMLgZh/+b2+yytvaAFAy6h27IPguBeowSU7xAMJjpLR9J78GBvnFxK4UaXZzbdK5kLT3Rs8g5xgmUrHgkUe3NfE38xdt6NwR3t1vnFBMR9FWMwhvSq3u9D9ZgNVPqcp6vAbyP9y0s0LNPxUKpRkUVOP89fnpxc7QHhWcghlUfhizAZXy1/NJv3fAAMquNGXN/EkfRM8zGXUjMFgitjmXozar9hif2KxiQWzk1WJihDjX41QXMMBZRIV8VMXtEFJ4IfVwTB0PUMmBPMxQDJto2fmJsk/iR3OFIfcBOghq9sZI4GgN9E/GQW69/xN0N6TbOQZ2zzo7hwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPZpZVOE3rH0rGPpvunPGg27qMUOxEkJsASasZ+WE7A=;
 b=X0NCDsg38hkNRKLHJ2Z3WAqxJY6EAnOmDF5UibC3WSja5rewb3JKuL8aConhTYrCKdx60WVq8/JIJRaJJ6bALJhGPGPpr6pQ3QaCA+Koqew6/h3KLGdsrCsjsR61ZUjWzkQxSns/Jzbht5Wm3HYPPLn5h7rPH+lBd3YR+BY/Wc5OjsOREjwEFWToH43dAXnCdINc1jZ/N7eoGj1tes9YHaQPOEyNfxOQd9pVYMaKzMtHz2qcyblTCP2UFnZMWIki8UYJGcKgfDLNmmrVL1Or4ILRZJWxUJqqqEU+unO5iL1q/tT/yhth0qaPXUkccQlbtnIMKjPD9YiWelCey4rG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPZpZVOE3rH0rGPpvunPGg27qMUOxEkJsASasZ+WE7A=;
 b=65HAL7/F+kirVV1lGRHos3H3hC3IXXJYGT6ByhkekSC9KQn1kNd4ATbT8N7kee17G4LB05A7B1haV2rHLhd16qqdbh3i41wLmE0loDoxyozPMEAU2kHaYxMLyAUdVx6WGioP2c3BPk16AsoNzZnPNOVHbY5EDieuR6zlB63Sqww=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB6165.namprd07.prod.outlook.com (2603:10b6:a03:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Mon, 8 Mar
 2021 07:37:51 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:37:51 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Thread-Topic: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Thread-Index: AQHXEX36kpOSDnFNj0uigU/bo5a6J6p2I1IAgAOT4fA=
Date:   Mon, 8 Mar 2021 07:37:51 +0000
Message-ID: <BYAPR07MB53816230488971799AFC5E8BDD939@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210305051059.31623-1-pawell@gli-login.cadence.com>
 <20210306005342.GA1119@b29397-desktop>
In-Reply-To: <20210306005342.GA1119@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmRiNGRmYTQtN2ZlMS0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJkYjRkZmE1LTdmZTEtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTcxMiIgdD0iMTMyNTk2NjI2Njg2NzQ4MDA4IiBoPSJSUHIvb3gwMDZiYkp0eWRXYlRnRDVyNUJ3Vm89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19f30ac-f548-481e-66e1-08d8e2051429
x-ms-traffictypediagnostic: BYAPR07MB6165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB6165F2EBFAE27E3751751B86DD939@BYAPR07MB6165.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuSW5HTFlJ5VOVu1e3aAWGsxhs3xeSBbPNTbmiYqPVzuvjwmJ41DFNQjCA2adk+GSN3IAQpR+pa1HhJdpmFG0ooJgBQ8tnCu7Cq3uaq1qR7KxO0MS2AR8f1c+JT1bp4x4CqldjQe1yLryOPjd+EdGlodfUyL56yWxpwjFr4HFK8GheucFUjq5v/sxTCbl2lNncS2N/gNbULfNzTnx1OxS/akQNnDR754xVpx9NUwwwJhOkqT4u8k/jM6T5g0GepQ2M9kbnj7jDknyZYZNlQ71EE35RAigRkDYrdtxzLPgIjHXDlZpBY3pnbskZkBxswO1Ow71pyx4KkfaF7mOI2q9rPaulNf8yxBWTyBEC/rJIIb27JpRsSczjIk59bS8APjHMoVKkPalKGe6UH4tPL0sN0wqe+jVx8oeGfzVSb5jYx6eDVAvHU4PEezFIYtOf9N8mBm3riUlhzp8kogp4yHgxYJsG9e87VjVOWg9tQgN6MCHYzeip46YvR5LON7MYVlMdBN9oMitmHxIsz23JnX80gPfLM2NWCxtg4iksET0EKMHPb4aQHnN2hjA/Hh+JG2VaCGcnoHKgD+c1NesyiTWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(36092001)(478600001)(8676002)(33656002)(26005)(86362001)(64756008)(316002)(54906003)(83380400001)(186003)(6916009)(4326008)(6506007)(71200400001)(5660300002)(107886003)(7696005)(52536014)(8936002)(9686003)(55016002)(66946007)(76116006)(66556008)(66446008)(2906002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8lSR0LEyShjS146/9RQMBXnG5J8q8qe5X32n7GFmy26w+gHvcunbLB9Dx/NJ?=
 =?us-ascii?Q?lOOKX6gZSp7lKk6CEj2FdpunDyMiII9A0jsCgqHu6CbTzF7qQStB8P7CkFXs?=
 =?us-ascii?Q?KnUQVjSaphWq1XNbBw9rF3vqPZML4AbT4DSukWft+I3249TdxjL/2iKde4Nj?=
 =?us-ascii?Q?gvB9yHk79dTT/PKHmCjrzRsP7YEYQX984su7ll2z6TzICNEf28WvERETabQ6?=
 =?us-ascii?Q?jmcgCIrQSFYcdKqB3gnF6u1RAicgZHlHbqS516jhVtNUao9QbXx1nUo4X2bH?=
 =?us-ascii?Q?p9wfDjakSMM3OJurK8bw/Tqp3jUn1pjVw/hfCTV7N7Jyf3hWLHZeR+n6cEHe?=
 =?us-ascii?Q?tqlVRAAwNvNynF8wPg8q8raSiwUaky5FZLDExOhTKxZSxdXj2+u7m6+jCBXs?=
 =?us-ascii?Q?Uu+PagF4/G24KYoO8oOnDNr85wHBy9+o4d9SuoXea1g7nbVYjRRCZOH0cdng?=
 =?us-ascii?Q?AXscTiYqk4foAQM1ZFuQg5XykrjzkxauBlIptfrmszhgZxeuc3VIWMMjgl8G?=
 =?us-ascii?Q?ezmVZxsDXtlZZdYFhJMTPHsmd/ci9o+WbY4f8uU8BaxMJnbM/QBNEBvyfrBj?=
 =?us-ascii?Q?JwS6lMWMstyeFrGlLs0jTkZeS+x9348PFmFwrzau0h7kyuY4+SqToN6u4Glt?=
 =?us-ascii?Q?oofq9LyLrNRWNO8WgzrZMvtUgZoxLEySHWqCxjnS5/jzh3Bu6OCBtXgmFBc9?=
 =?us-ascii?Q?gZSWbq23RzNG2jwnj84NpWovR3nE2a4/n8n1C32XTpCnJBoiN8LXdtGZgAxx?=
 =?us-ascii?Q?yagGcO6AF6sHYEtO5IdlI+q+aE+ssmElbXLVcQZ3N1wBd2XYJdXdQeJtD2eg?=
 =?us-ascii?Q?0gz2yWA9vaeGakh/Mxlg43VZRlN+q0AbfpNE7fMwcsIARcMO89iwhLUjiABl?=
 =?us-ascii?Q?V1SNtSAgJfGprztACN2cA7jlb1CzR1zEcu5igvEVNlOyfPRIh1WClRX/KbIc?=
 =?us-ascii?Q?fSiCB9ASaIB0bjNupyb1hzGATFGcuZmU4E9Is//6NAL0f+l4k7/Z6sAc6znb?=
 =?us-ascii?Q?jiSph3/wGbIytqEfLQwDtRC/1X3cbnaB75u13KjJCG0sTc+Pla8g7VMP4oBq?=
 =?us-ascii?Q?Ck/EpXHv5ATeGeHDCiK0GiC8yP8a3/P+nmC3Ehw3DDcb4Nfxe00xfarodyop?=
 =?us-ascii?Q?NjfyD3vI07uKZW6u0Hnvo0xbUkwFwmD8m040pURcVHpSyK0eW3PvwN9k5cIP?=
 =?us-ascii?Q?qblS1J7FC3SniqojnuaUrqvoVCOrfy+RIHzBkxI8+crINPP6GQ6vhiULZVev?=
 =?us-ascii?Q?5yvhDBDRTYO7QrU0kZrwUlgItf1aMl7FAw26rwt8UBMecaQ4BorGvCDyGHfN?=
 =?us-ascii?Q?HhnhBnuTclt4lHWK/ckhr1bO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19f30ac-f548-481e-66e1-08d8e2051429
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:37:51.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oU0bycZezlxThU3f3IDX0lcz1EKFHTjLeXmQ1mNjT7Ijyk9H6+PEKonV2D9OCMi15WoCCwn3h07Fo2uHlQpl0xWyukMbcpQ7qx5INeEfE1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6165
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


You have right. It's the operator priority issue.

I've made  this condition as separate "if" statement as suggested by Greg.

V2 has been posted.

Pawel
>
>
>On 21-03-05 06:10:59, Pawel Laszczak wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> The value "start_cycle ? 0 : 1" in assignment caused
>> implicit truncation whole value to 1 byte.
>> To fix the issue, an explicit casting has been added.
>
>The root cause for this issue should be operator "|" priority higher
>than "? :", I think just add () for start_cycle ? 0 : 1 could fix it.
>Please double confirm it, and change the commit log if necessary
>
>Peter
>>
>> Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence =
USBSSP DRD Driver")
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-ring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ri=
ng.c
>> index f9170d177a89..d35bc4490216 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -2197,7 +2197,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device=
 *pdev,
>>  	 * inverted in the first TDs isoc TRB.
>>  	 */
>>  	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
>> -		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
>> +		(u32)(start_cycle ? 0 : 1) | TRB_SIA | TRB_TBC(burst_count);
>>
>>  	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
>>  	for (i =3D 0; i < trbs_per_td; i++) {
>> --
>> 2.25.1
>>

--

Thanks,
Pawel Laszczak

