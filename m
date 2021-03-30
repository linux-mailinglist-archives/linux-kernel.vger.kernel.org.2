Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A734E018
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 06:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhC3E0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 00:26:20 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:5458 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229465AbhC3E0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 00:26:17 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U4KA5D029743;
        Mon, 29 Mar 2021 21:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cG65oYWDtqkYztVJFLmJE1cwqJ2COJLhxqwP6SuUG54=;
 b=iZpawmaGV9IGUu4dvsdPHruO3PfRYtIluzQcaVQm/HVbapZIll5gQS7iPV0HOVpjX2/p
 sLCp2V6mHdeDwP9RnBjF8s07Rj3k9Mtr8kCew+5JpXSSfhq/PwpLvCPPMi1xMzoIZrzQ
 sUKdZ6iVY8EGvdYmXu66uDl2jDzxk4eWtI6Gg6DukAbD84bdHobaWKmWOpJmQ4Tfvxgj
 kaCjiBHrQNZpv5EhS9/4E22HEj0vOEIf6batlbltBNFinFLVorKthsczP1eJyQGHNpo9
 3PV7NKCbsFkaGcOyc4euGJEQztQUfj9pX0AxQbznUKSzON/mR5Nz2ysjqTe3oY2zAIUb uQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37knh6922w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 21:26:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4o4yydSeBwyGbLGMu1wxNHYFzP6wJqXShN5yCxS/tSQEi1edQJGbDoPbYzx9O3u7cjl/c0c2YVa14nPJYyT+IsZ7Y33YNWbqERMahqoIjXxRkL7Ygqt6V+EqwrnnQ84e/7+IEJndxaQHfZXsq6B/0ZfcS22MEM26OeJwUxTsjBANk2QR7umXoUyhUDQQql6GK7/7g6ps5rJ39i7rAzXGhx9JVBUtpvCw9fvCYTXcLm88iqQHxPaThYa4FNUMwvyrphhOoB0ZQRFtaZx0L5Ry7DB6gSg9F3OMr8CRFq3wou0Vegjd78n+aIzmRxXQ+XjKUrvNDcNrHKn/H+8LKHaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG65oYWDtqkYztVJFLmJE1cwqJ2COJLhxqwP6SuUG54=;
 b=gxSvIzzGwJ8qYRFA3VTRXFJW+Oc1gznwgiB1cxhEAeW70o4eseb0tZC+FW9F5MeU8STnfwcZ7ObVjYi0+5TfoqkaShrgjN/EyjX9qPunX5HFqiGaOeDCzTIfOb/UjiU0lmbdG+wjDKAQd6GWmv1L1JfTgJt2pcuCb2+eG9zEWhpAfA1jYq9K11r9gfqDucB4lxNPh2yxlWP2rdi2ss3CYQ0BUmnFLtn57UJUokKlv0h1qFANIRWzKeDjUUtV044qtqPnq9AgbPZRlCXAzDDXvUMKEZH3I3rZ+S+/3b0dEJuNb8+KjY4peQEGLugZ3yePLYguNKsoRdBaaomsRqFFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG65oYWDtqkYztVJFLmJE1cwqJ2COJLhxqwP6SuUG54=;
 b=ZeNPbbR5dIonKhwQv0CiCwJUuEbHa1J/HdZ+nkaSihxdo2H57LxkTAbmMIhbHlgsx06qLCE7HIZtacfJP4BLkMCo4B8T7oHayES4epOztHQ5n15SnTW/VAFTbir5FgVkz8leuhU5yC9IHH8LyXG4PiVuXRosJArHcKB0i2In89Q=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5766.namprd07.prod.outlook.com (2603:10b6:a03:9a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 04:26:10 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 04:26:10 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdnsp: Fixes issue with Configure Endpoint command
Thread-Topic: [PATCH] usb: cdnsp: Fixes issue with Configure Endpoint command
Thread-Index: AQHXHuHlWR6DFE1h2U6zYwJk4ihkfqqXCamAgATvxhA=
Date:   Tue, 30 Mar 2021 04:26:10 +0000
Message-ID: <BYAPR07MB53814609AA96C16D6432761DDD7D9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210322060902.11197-1-pawell@gli-login.cadence.com>
 <20210327005417.GB28870@b29397-desktop>
In-Reply-To: <20210327005417.GB28870@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMGMxYWJkYzMtOTExMC0xMWViLTg3ODctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDBjMWFiZGM0LTkxMTAtMTFlYi04Nzg3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDI2OSIgdD0iMTMyNjE1NTE5Njg0MTUzNzg3IiBoPSJSbjVvRUxSMldLamc4TW1ObVlqUk9VUm5nUFk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca70b12-bd8e-40e7-a7a1-08d8f333f235
x-ms-traffictypediagnostic: BYAPR07MB5766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB576638D12B324F29438731E0DD7D9@BYAPR07MB5766.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bVccTlUr45Csc0pjds9eIK4p5CMXZAyq7kpI/Nq5QLlv9gJa+g3GcJjHdQJKzdJb7sTo91MKzBonxSEb2/2US1yigh0+zTs9ww9ge6R+WWfGI644fr01hoT/ltrzWz88he/WeCw4KpWblIe6lkbNygRnNNsLYp/HKwLZdkWrQRSYKcQsxEJZaohL3KeJ/rrkF+QKGBpFAaDKdBuJwloEfrXXO+FekpVLK6i/7oTj85dDW+tcwJJ4GvnVEvryFC7nFO47d15TLZopxCpj23bG/AxIw5mhQ3scKWizZbhvpuwx4BX6zB74uaUoHrEgYzDJdTpuP++OkTujbUnWVjksCgdl0vOqZf1unuQZkjvrqxXaFiF2DtnkQvMb1KdMW+Jg7bjZOsZ0bi8IYYTEpgxDfB6sA5KIwfJvAnDmbJAyN9NU6ObGvnZhSdLg9r9hjddoQNAT2Aofmp4n8QgILf0tlXxuuUvO/cg846F6eV3fDimN6lK9iV0vXvy+WRWCAwQcrH2sOHPE98B0f1oF4MBNay8YY3/NBenijB5DzcphPQ0AXtEqf4a4hTmmW5ttX6A91hmQPeiebW5I9SKU4ZkUH3AYdQqEfvniIH92d5vjSanGS/VUc+8iVGddr3egivVNS9fDzEmz49eqSwyd66Z5wB5ZvyQWpB44m6SjJoSPnBTH7tKWcH7tI13WHFOOWLl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(36092001)(55016002)(107886003)(8676002)(33656002)(4326008)(71200400001)(64756008)(66446008)(8936002)(86362001)(6916009)(9686003)(2906002)(66476007)(52536014)(478600001)(5660300002)(6506007)(26005)(316002)(186003)(54906003)(83380400001)(76116006)(7696005)(66946007)(38100700001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IK/fq7UB1ZlgDEAnRWVRbcIq6rxGk0RrRPvvndF/VLN1gF9V2QeaOXC/hSbJ?=
 =?us-ascii?Q?qfjdbrabx8lqsTCFENzK3H31aoXyseSLQVl04n9yoJA2uSqlx4/A5fYaqO49?=
 =?us-ascii?Q?ENtHhidpMnCQWvKUOONUbu1Q1arqGV5A18NDr3Yj4zAcEo6jPDCUGtfUxqJS?=
 =?us-ascii?Q?YP7ujnxt9QzkI3FhmSvOoTc74FTbqn12icLRoO1RWTTbS45FmLQiPT7BxdO4?=
 =?us-ascii?Q?g1wLgV/DBGPyysrG43YenWrVDHrjr2qMlDyTug0oiS91AUtLyAppt3ihTbN2?=
 =?us-ascii?Q?vFcaA4qKnHvevacGIU6TzetAFgdTX+GD5X+w35eqwdN+9NwuoVGFyXghPLta?=
 =?us-ascii?Q?RKLkLusFEVt4FyMiL/9y3NEMRI6XJQDZq15pnqgJut9PAR3dceKPReQ1NQ+f?=
 =?us-ascii?Q?mVjyRWUr4e92l0iawpoKuxMBKIUw8r9fQEAxWZowAuiagJhf1VcAWezWnqCU?=
 =?us-ascii?Q?wysDJKSTdcCdb6khelZuGtRWDiZg9suN2vbn3RHUdSeRvp16t7c900/lCj9h?=
 =?us-ascii?Q?jFJEcyBwUSCwhwcSDm8QPGOBwTRzfvp4xuN9bEZ5WxONWxk/8NRJBriwjEG5?=
 =?us-ascii?Q?ATsdrxZFLx1bqf7aJvH3G4LbyVNzRAsZb1eLp9OJ3lpxl7G1x6HCibBg/90t?=
 =?us-ascii?Q?H8GfUJmUP6Z48dP/PyU3R4j4NDOzKy4OTf5gWWYzioDWunt19vT5J8BmxUvj?=
 =?us-ascii?Q?s0Rsl0BVXu5KZ04qOR+gjwyAhmBrnlb1y9eE7sKcqZs4DtrGqV8X7y5tUvcr?=
 =?us-ascii?Q?yvG2P+app9mSNr1zmUgMvGbz26gtzGtAuIbJk78X9QHOZL9OOP9hXDKJ/bIl?=
 =?us-ascii?Q?LqZc/uDoJNJc3hblorRDpaXH2IlmUwhtuVM+NOSPJn/thfRXVO7KKcFRdxjd?=
 =?us-ascii?Q?B91Si6ArWsEY2DIu15cGOheyqD/vhi28+ow8ESOOLAzIEylJKUR3++mW2vBK?=
 =?us-ascii?Q?3RIVRHIw21zMbvL6+k2j//xa71OI+R4S0p740yyRXYv6/04M1MZj7mZkOQLn?=
 =?us-ascii?Q?AV2If6XMOESHwu8vQWurHSZqo9LWeyaRCxDvgk/nNgDZo/EPisLKybNm1H5L?=
 =?us-ascii?Q?tG2uXHTY0zZVZFYnMnLF/Wa4dwkoP6hysrE+2vyA6q1z1KAD8cOeC5ZAgf1N?=
 =?us-ascii?Q?W4SeXB3yh0FDGVm0FGV+78EEmS5ZZ+f3sfVmouboSkCcD3wabGoNmkI7LUGC?=
 =?us-ascii?Q?bMRN/JjuDL6Uez19+MEI88Ctk6B/N8lGkWihvdNVdHzqIMMOHPOxMtX0mfO6?=
 =?us-ascii?Q?m8yhD4jM6CLAd2+O52+zZiZxJlsZkG5NISE0cbGTY8jHmc9Mw2NLhTrW661c?=
 =?us-ascii?Q?Na7h0UU3OxZy5cq1kRYWuA3d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca70b12-bd8e-40e7-a7a1-08d8f333f235
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 04:26:10.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MXFDr2iCn99jKg7hZQ3Gji1YnUQtzZJhGxVFip4aZfw92EZM62rHAg99YAoHFrnNu2wVYlOUbreN8OUijg+mTqZV7KTP9ndgo2pf0H0C7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5766
X-Proofpoint-ORIG-GUID: nfZ0rQaLD0szzATjiLSQKjKpK7n0pZT_
X-Proofpoint-GUID: nfZ0rQaLD0szzATjiLSQKjKpK7n0pZT_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_01:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=732 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>
>On 21-03-22 07:09:02, Pawel Laszczak wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> Patch adds flag EP_UNCONFIGURED to detect whether endpoint was
>> unconfigured. This flag is set in cdnsp_reset_device after Reset Device
>> command. Among others this command disables all non control endpoints.
>> Flag is used in cdnsp_gadget_ep_disable to protect controller against
>> invoking Configure Endpoint command on disabled endpoint. Lack of this
>> protection in some cases caused that Configure Endpoint command complete=
d
>> with Context State Error code completion.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP =
DRD Driver")
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++-----
>>  drivers/usb/cdns3/cdnsp-gadget.h | 11 ++++++-----
>>  2 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-=
gadget.c
>> index d7d4bdd57f46..de17cc4ad91a 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -727,7 +727,7 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
>>  	 * are in Disabled state.
>>  	 */
>>  	for (i =3D 1; i < CDNSP_ENDPOINTS_NUM; ++i)
>> -		pdev->eps[i].ep_state |=3D EP_STOPPED;
>> +		pdev->eps[i].ep_state |=3D EP_STOPPED | EP_UNCONFIGURED;
>>
>>  	trace_cdnsp_handle_cmd_reset_dev(slot_ctx);
>>
>> @@ -942,6 +942,7 @@ static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
>>
>>  	pep =3D to_cdnsp_ep(ep);
>>  	pdev =3D pep->pdev;
>> +	pep->ep_state &=3D ~EP_UNCONFIGURED;
>>
>>  	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
>>  			  "%s is already enabled\n", pep->name))
>> @@ -1023,9 +1024,13 @@ static int cdnsp_gadget_ep_disable(struct usb_ep =
*ep)
>>  		goto finish;
>>  	}
>>
>> -	cdnsp_cmd_stop_ep(pdev, pep);
>>  	pep->ep_state |=3D EP_DIS_IN_RROGRESS;
>> -	cdnsp_cmd_flush_ep(pdev, pep);
>> +
>> +	/* Endpoint was unconfigured by Reset Device command. */
>> +	if (!(pep->ep_state & EP_UNCONFIGURED)) {
>> +		cdnsp_cmd_stop_ep(pdev, pep);
>> +		cdnsp_cmd_flush_ep(pdev, pep);
>> +	}
>>
>>  	/* Remove all queued USB requests. */
>>  	while (!list_empty(&pep->pending_list)) {
>> @@ -1036,6 +1041,7 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *=
ep)
>>  	cdnsp_invalidate_ep_events(pdev, pep);
>>
>>  	pep->ep_state &=3D ~EP_DIS_IN_RROGRESS;
>> +
>
>Useless blank line
>
>>  	drop_flag =3D cdnsp_get_endpoint_flag(pep->endpoint.desc);
>>  	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
>>  	ctrl_ctx->drop_flags =3D cpu_to_le32(drop_flag);
>> @@ -1043,10 +1049,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep=
 *ep)
>>
>>  	cdnsp_endpoint_zero(pdev, pep);
>>
>> -	ret =3D cdnsp_update_eps_configuration(pdev, pep);
>> +	if (!(pep->ep_state & EP_UNCONFIGURED))
>> +		ret =3D cdnsp_update_eps_configuration(pdev, pep);
>> +
>>  	cdnsp_free_endpoint_rings(pdev, pep);
>>
>> -	pep->ep_state &=3D ~EP_ENABLED;
>> +	pep->ep_state &=3D ~(EP_ENABLED | EP_UNCONFIGURED);
>>  	pep->ep_state |=3D EP_STOPPED;
>>
>>  finish:
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-=
gadget.h
>> index 6bbb26548c04..e628bd539e23 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -830,11 +830,12 @@ struct cdnsp_ep {
>>  	unsigned int ep_state;
>>  #define EP_ENABLED		BIT(0)
>>  #define EP_DIS_IN_RROGRESS	BIT(1)
>> -#define EP_HALTED		BIT(2)
>> -#define EP_STOPPED		BIT(3)
>> -#define EP_WEDGE		BIT(4)
>> -#define EP0_HALTED_STATUS	BIT(5)
>> -#define EP_HAS_STREAMS		BIT(6)
>> +#define EP_UNCONFIGURED		BIT(2)
>
>Why add new flag as BIT(2), it causes many changes in this patch?

In my feeling, EP_UNCONFIGURED is more associates with the first 2 flags, s=
o I've decided=20
put it after BIT(1). =20

>
>> +#define EP_HALTED		BIT(3)
>> +#define EP_STOPPED		BIT(4)
>> +#define EP_WEDGE		BIT(5)
>> +#define EP0_HALTED_STATUS	BIT(6)
>> +#define EP_HAS_STREAMS		BIT(7)
>>
>>  	bool skip;
>>  };
>> --
>> 2.25.1
>>
>
>--
>
>Thanks,
>Peter Chen

