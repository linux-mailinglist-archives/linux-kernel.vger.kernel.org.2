Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDA30EBBD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBDFIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:08:09 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56240 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhBDFIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:08:06 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1144qFMm018797;
        Wed, 3 Feb 2021 21:07:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TX1+83ph9V79ek3QMDReZhxRLaEpuGX0JinoVpihayE=;
 b=k09nLJzDMwQCOd88BYY8J0PfXmzUEXKtAso4oq5+H36T3fggnpQOE6w522HUH2xgy4rQ
 ro3lmFC8VhHyjxAQMk+ZHvV7gwMLdTH326ASEq5lcywn64xi7xrV6NDxLrobXFWErPXA
 3AlULbGTVv6xzn1a2YwbFrbWKTqPdTzH8H3pAfTnMetNbN13IcCkU/bmmg9ACFHY3pMN
 1DoEpeDnjuH4iWcBxbGS8bz/gaAiI67D8UXUAAe4e/KxfsDdBVb7lAooK0fjzxK4KQDo
 8r5lylHb2zRv17daRsMc7l6HSQHvYxibZr8sxxv8E8xAEeoyFIF2YYZsNYQysMA9oEzw aA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36fgekw5vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 21:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH4Lwt9H17NLQgqLqR/I+QWL7lVfSi8Nc+QbHCR0Hd76LkvriQh9eQ3kaZLmrloFu0EHrBn9zq0CnI3eXhvZGj7Qdt0qLyWdF8Vfc1mMvzH+BTEVflLDUJJNfzO4Tb5DghP4Ud7StF9Ey46dK5CTAfdHRpUe0BnfXnDMSXt3OxY2udR0dEc+Bi2kGoClIcASSH3lde/nlf6jDZ2OH+LcQAkQTry7ruj5zvt5E5S9pz6arZX8GKYfSmWBZppYqxQ5TNoXiEvs+OFT73txGruBY91lpOOxD+Zcja/sSRO5XX8QpaECuiQdJkpwmLkfUucwAFJDiC5n/3zlG/posZp0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX1+83ph9V79ek3QMDReZhxRLaEpuGX0JinoVpihayE=;
 b=h2yqxAaeU8op8krBj4d54yvU2CB+ij3nThJgRgyOWZRT49RcZ6UaCwZfb6HQN6VU+l57Z9/eJLbAU59NTApMmSOFPhuP2TlFqzpCbL/Cs7ROhhOVh4IQox/szmuj7JwN9GlnniwmQUmkzNXlePHr3lClTHbh8sU3ZJ31MNgB4sDQFrPAICnlreJPclrKVvor2dNhD0POOoAF+ZJ6gBhHiAhx9Rh6+L0opQ0TKeGeYhZB6mgaMxhX1OY3V1IMdUraul06a2vxMZYTErS9tvz1F6U4KNBLKEGfo+9cDQZ2LlxcJCOKDi7U8HUjqZo+VcgJMX3NWq2vQpN4P9I1qCleCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX1+83ph9V79ek3QMDReZhxRLaEpuGX0JinoVpihayE=;
 b=1+pbi26tzd0Yb0we2E+UpdBRmIMfQrwy3pODP1HUC5YoYyHQ6sQzUsc2B4bdRKfB5Gnyw7itvNoVBgD34G/HWJSJ0cbzB8aV4N54Izl0QYaTn+wzn0dfH9s+Eb8fr8LaIJZ1v/N9UxFOO62C9Gp3Aabvwx8XdEul3qcbQGXQ03s=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5384.namprd07.prod.outlook.com (2603:10b6:a03:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 4 Feb
 2021 05:07:16 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 05:07:16 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
Thread-Topic: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
Thread-Index: AQHW+h1/B1gGPc5PZ0+sFJQAxZIcPqpGZqMAgAACpSA=
Date:   Thu, 4 Feb 2021 05:07:16 +0000
Message-ID: <BYAPR07MB5381361C15E436BE54D25C93DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210203111239.18313-1-colin.king@canonical.com>
 <20210203130440.GV2696@kadam>
In-Reply-To: <20210203130440.GV2696@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDYxYjBhNzItNjZhNi0xMWViLTg3N2EtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQ2MWIwYTczLTY2YTYtMTFlYi04NzdhLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTUzMiIgdD0iMTMyNTY4ODg4MzE4MzExNjA5IiBoPSI1VnEwR3NLMkRYNG1lbkUvQWRLWDVxb0R3YkU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90196068-65eb-4853-95ca-08d8c8cabdba
x-ms-traffictypediagnostic: BYAPR07MB5384:
x-microsoft-antispam-prvs: <BYAPR07MB53843B7AF338D002CC31B6FBDDB39@BYAPR07MB5384.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkejv/aeFx8aPuUJJHcr2+yai8d219zp8g1UKqtGPzd9VnTMwOZWhGhi+zKtG28rnsGdp3zRlY+MChaSe+t1ljTGiC+XGDlpC6hobJVNxfX9TB6TZHjKf5OCPeTxRceTK3LsIF48mB1+zQeSqBpy37S+FnYdgFsiIuRERy7+5AA9VOhznEQDLhLsBtcGujYacWI/J49yLbc9eRQb4T47FQaidIvL6Uuv3wyjC5TNsgNxeoQ2z40mm/esW2sEPtJrXYNpCdJR7RIYoMtGHU3raOTkWWNV9JG3u9oLz6fmjpfK3h7hE7Ep+KzM8rk9dggGRBrvPBdM/wAhFogaxqfbdat5bIsI8oilAJo2DXtLREdpADylEsxSlHK1LT9wyisenvKwlviEG8Nw6qe6d5Vz8U5jLEcgBRzNDG1GTGd5rgfDuzOeVWymdnfQodmJdFtCsW3vml2b8lIIsuhAq9cEJZ3a/D0zu2CJYCglVeYa9zUahPDMOq5zEgp7ooK7Wt/El24pAhi69GUHuG41RNddXRkLfD/KNj5oos85rZAbqVkm8dwmgT5yAJ3a0nuBT8DwhB2zPsFdsMtBhRvzIyTRJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(36092001)(9686003)(33656002)(54906003)(55016002)(5660300002)(7696005)(186003)(66446008)(64756008)(110136005)(2906002)(83380400001)(478600001)(8676002)(71200400001)(66556008)(52536014)(316002)(66946007)(86362001)(76116006)(6506007)(26005)(4326008)(66476007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H6AqLAthkYzQQcOPVqnYCpUvLL4exAuoyaU+W70XsZqw4gZaKiq6gWkgrQWE?=
 =?us-ascii?Q?CNs9//WTgUegX6TS0otpaGhydfkazRfZw4ifwlXPJZvNNi2RIxM/m8Bb3g9d?=
 =?us-ascii?Q?tgkhJ2Ei6bcZMYMnaGTfZIYVUhiOBV5RxZOBtZ5H7EvJMtYK6Ivb54bFJeoA?=
 =?us-ascii?Q?V9MZgIZ4uBd6OSjTGohYgi0l8QkSVhd9JhC8bUD0hoBAueZqAxAQivcyD1ob?=
 =?us-ascii?Q?DZLDzlc4+8gXer9dnRmMvckxqbZlTr6IkflwIIy8hNOmEoeYBQMh6iPjzpVj?=
 =?us-ascii?Q?13DYlYia7brCmE+j8ubZd+zvyOM6stdjb1PlddT1ZJc5ysgUBUYNnuT6I0rn?=
 =?us-ascii?Q?IgYff0dcvp/DqE8bdLZuMplvIDlSMP3laA5cx2hBgMto82ERnj8DXAjkn06W?=
 =?us-ascii?Q?bjYDjYIcASRDiDKN6IMTGMggHaoGQNHueiTnlWMirZHUG40f5RJiHMjpFpI6?=
 =?us-ascii?Q?1pdZWuLBGvD+3jY/AaIyG6m20Gxt3Co8t/VlElIfO7ia84LZYNPomTNcVtyH?=
 =?us-ascii?Q?ykQ0ADgAdOt7T9Q7WKIEJuyDjlSv7uI7b3TqvhL5x+oQJVQZFRSTBdAbT4rG?=
 =?us-ascii?Q?KzfIqO66h5gQlecYWx5YJeiX5/szdw5byx2t8Q8pGqL3UXJTNHjXQDtn1g3Q?=
 =?us-ascii?Q?G5pu7pYEom6pCDjTPgq+LPV2xZ0iQO0TGE5UvLcHhXeuFb7UxfEu6ZYQkg0A?=
 =?us-ascii?Q?nG4fZXDfUUs+VZxwCLEkFMgchAMMFLACbS6ASF3cqhToAr48Ig24wf64Vmns?=
 =?us-ascii?Q?ZZt27It+f1+awfWsFaEYIXEYrOaF4/rMNpQddVHoscxUwbjmC5UY0HZAp4Mn?=
 =?us-ascii?Q?Tn8J8mqcQPr3ZyogPzr9jCj2y4z2yZTdli4HYQ4SAyx+B98RRvKs8cWo7X5d?=
 =?us-ascii?Q?3ua0vgjdcPCD+VpdB7K8Uwud1bWIT8ZsndB4Rg3suIpxgb+g1gvHXNHGCqri?=
 =?us-ascii?Q?D0eIUtzN9C8gCXjepTjZVbJm/p/CFOW8e7kUHaA4OkB7LSiX++dNmh4m/wMX?=
 =?us-ascii?Q?NLvNd96wfQe3G1+ID6+iSMIJngtKS0TmDScE7MhLF2dfvZMOKTQigZdZwcui?=
 =?us-ascii?Q?gBkSrjIp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90196068-65eb-4853-95ca-08d8c8cabdba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 05:07:16.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoyBJ6UD7RWx3utGxk6tf5u6c5Uw7q1FXvS9wPJoYAypd96Y1ES+aD7hms3sM0DO9dcH4pj45S5t+QJ5fuANC0mkn7qbfDeqMRzF/6Cm3So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5384
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_02:2021-02-03,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in a literal string. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-ep0.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0=
.c
>> index e2b1bcb3f80e..e30931ebc870 100644
>> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>> @@ -45,7 +45,7 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device =
*pdev,
>>  {
>>  	int ret;
>>
>> -	trace_cdnsp_ep0_request("delagete");
>> +	trace_cdnsp_ep0_request("delegate");
>>
>
>This printk is useless and should just be deleted.  Use ftrace instead.

Maybe this printk is redundant but it's more comfortable in use.
To debug I can simply enable cdns-dev events (echo cdnsp-dev:* > set_event)
and I will get the full  picture of what the driver is doing.

Otherwise, I must remember which function I need to add to set_ftrace_filte=
r.
Of course, by default I can simply add all cdnsp* functions (echo cdnsp* > =
set_ftrace_filter) but it
increases the trace log and makes it a little more difficult to analyze.

So maybe in some cases we shouldn't complain for such printk ?

It's my private opinion and not necessarily correct :)

Thanks,
Pawel Laszczak

>
>regards,
>dan carpenter

