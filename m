Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04F35B8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhDLDao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:30:44 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:6634 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235234AbhDLDaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:30:39 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C3APig030903;
        Sun, 11 Apr 2021 20:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=f2ux9IVY4sLPpUovBz65KKOt4uZdoA61h61C8QTTFI4=;
 b=fhrM4E/BtnmLBae2CbgH/7v81vC2w1nEpFhZSmmK83zgjh6k0SksvaWqEiCm030zd3p1
 Nz4RC/q5qNeLwky6rIRSdaZI0CXSuPIYBcQC1vfRbUzEZSfYc31IcMfjA1rEZcgMmmgI
 yYtc75rUzLRSn2Irpn6/tVRT0QmW8WLPUy2nygpQFa6FAvf8EKnTeOAKeGle24348KjJ
 FCaYcaSsqivmU1+OMjXcSiomJTjJzAD2ad0aOsrDtJ6g4oI+f/pbbeVMfmckVUwa5lsC
 lx5wu+HZg/iwatwWF9W3yfGXziS7CYvcRauTFDXH6t7a5kD1BR+F7xsoqaokVjxC7fWT 8Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37u7m0m074-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Apr 2021 20:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9WpOACIO4Jntt7ltAeYWFixd2Iim5/AFlLZcxmDHwvuW0K0tLZ6DIseWuUeZqokYXq6dbaiCOj0jF9hC3KeHqoUyE90jR6sMRQRMUje7pgXRwWpSDWgeW0/KEaFimH1kK4x0gKRs6U6ihcTZAC0iC7S1UzNku3j8UkakY87R7Y83Ly8kAskegHuwiSA+7mqwSQAROWXEie57S0IszZFBHGNwykOByW3l38wDWpJoVHgQLsTLN3qKL5LpPt1xS+/8cpsHwUAlHKeCJoZ2JjRGO9Ehqmw66HpWMWMQMGeNrCMxvYjah+heuLjGhkP6DgY8mSlhlrjhDkgQd3vTAXJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2ux9IVY4sLPpUovBz65KKOt4uZdoA61h61C8QTTFI4=;
 b=ni8W4EC/kFbnwkfekZLEuEodfh+Zzj9vgxRhVR3d3CLZBSlgFOSYN0NiVuHU/8depLNUCxy2ZucGchDkmQrlKIckN/di5MorcKQuMYg1VVHCTeDX8IDv24ZaFTpLaVsJVncM8cm2qkKbSbbQbrMdTxliVL1Of9nVN65psd0u9u1KBv+7elAMuNJzZlHa9rGENsn6VWekhQqad585pwNv/KLSeQCmfV/qWC+CV6JuOnpMrX666nXRWiZtoLAS8Q69ogAVq/O7cgs/nBaf2uyWKhTCtOIwple2eNKb9GZMtcSBPAzByRM9f8K+B1H69XCuLCkBD2Wfu4Bf4XPCEhTMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2ux9IVY4sLPpUovBz65KKOt4uZdoA61h61C8QTTFI4=;
 b=dGeSPIvnXyzNbBuTHV5q6sh6PCU6N1HMmKrweKQDQXYA9cqLGXP6kVDuvadT7uJOJUvCKvfteeYKbWHpVAw57KHCJI/nJ9hf2tf5wEJXpHCoVcitYxU53YWP2sUFeW+XRKEIh0fTOFy8JaXLJLxT6R5wVW/9/fFkyu3rBnX3ieM=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4328.namprd07.prod.outlook.com (2603:10b6:a02:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 03:30:17 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 03:30:17 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2] usb: cdnsp: Fixes issue with Configure Endpoint
 command
Thread-Topic: [PATCH v2] usb: cdnsp: Fixes issue with Configure Endpoint
 command
Thread-Index: AQHXK3hy7gOZ6buWoUCjwtaNarDR9Kqs+OcAgANHeNA=
Date:   Mon, 12 Apr 2021 03:30:17 +0000
Message-ID: <BYAPR07MB5381A83C23875BBBE77CF277DD709@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210407063629.43685-1-pawell@gli-login.cadence.com>
 <20210410012208.GA28768@b29397-desktop>
In-Reply-To: <20210410012208.GA28768@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjQwYTczZmQtOWIzZi0xMWViLTg3ODctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY0MGE3M2ZmLTliM2YtMTFlYi04Nzg3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzY0OCIgdD0iMTMyNjI2NzE4MTM4NzUzMjExIiBoPSI1RXZ0MU1YQi9VQXA4aE10QXB5K1lDVno5S009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce7e749-1920-4142-a0df-08d8fd634af7
x-ms-traffictypediagnostic: BYAPR07MB4328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB432899CA9FA0CD3931351F6ADD709@BYAPR07MB4328.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkIFjrAgLWkDvOx03msb8PhgMU1FfkgKUdbZ8YMzMcWhVV+Kfu8HheS8UN3Bgyd6ylAIyoxGVtYYF3junUH1Pl3TlAmohgjLIOgvzrr+o6J9sIP72I1fUnuU2WtfOSwDLcWfDQdJ1+tDwmuvbM/ByEDydCQGv3ioOEBaouzAbxCxrRl4x/Odd1f5sSrQZ1Bj8VEnfuaDcDFrOEh/4A4TnmzfLlImWzVG4QnfYHbXWUIH1U57rlmvUIZuzcQuUAk3s1v/jOy3HDN5gHeqxjXEmB+wsDcOxGhd3vl5RMzpF3LAKsYrrVW/cU9nKPI4b7ZLtFEa/qrzzK8qV/vNWHMsVjrdvSlzhJNOUhHX+Tybx2bMasLIPfe8RhJMt0pJ1tR+6T3IOMHZgO2SqV6G7f3i9so2IsLWh7YpuVOBSVGspdyaRlDj8Z9+UCwR3PphhFJEBBvGQMR9eiea+MabqtuHzAEiVXG5EQ6LeAtBeXJMa4NYPNBn9rk2r0cWTDbu4b1SpUVVKW5sxZS/mGniMy56gDwJNMsZGCjRRQua3orA3fPzZmKXkzEucqdxWe4bSYDX8hGa4OcwMxGp/JnGivnsyl0OOjJgQnvw8pkpH/kazd8GukNWCCEdhsrZpTN69054/TH8Za/UJUpz5F9NyZpHgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36092001)(66446008)(186003)(66556008)(5660300002)(55016002)(66476007)(71200400001)(9686003)(107886003)(86362001)(6916009)(2906002)(4326008)(64756008)(478600001)(52536014)(8676002)(33656002)(66946007)(8936002)(83380400001)(316002)(54906003)(76116006)(38100700002)(26005)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HxsgTsdbcBiUed91PjX93FrthDiijk99EPABMYqv718JoOvZCTXRA3g4BXeJ?=
 =?us-ascii?Q?C5Ge37uYLnC1ejsq88FRBCrA74yK1Hp82ldvcoZiGXlgRqA5qqEazym/CrBr?=
 =?us-ascii?Q?pELKr4lcgkw6nzMz6cpQ0cOyfPmb9+fq6f8oc3WIjAKMjN3vKJjr1sDH5rsg?=
 =?us-ascii?Q?Im0oGyEmLeNfM8tWERomNUngWni1In0ViSK5uo+31W5ACk1oJeNshUvtyJ9S?=
 =?us-ascii?Q?Hn/X3qtbtPQD/fDve3Pk0ZIfbmQZPth63hAruL3mVvdFu2cPugWHVk8ONkeF?=
 =?us-ascii?Q?50RvU46Q9iRi/I/pk0vvupxtxTDSIZdwu8O2K1rgZYtGLXSsZOsVibwTI0gI?=
 =?us-ascii?Q?gXM+vokuZxnMd9pMpHWh8Xm1k4YJAjBjnDnH7/BMI/UeDGKCSUAI3qhSNWJF?=
 =?us-ascii?Q?+MW43VwHvB9SGYWBoQuK7q8p4d3j9jroVVBxec3cCAI035ipWno2NNws/JXD?=
 =?us-ascii?Q?OHh/MDvbZTTVFQYWib2jwLO+Q85853iSTv0dpfdiPGV1GvZgwtWPxBD9cwl5?=
 =?us-ascii?Q?6XLmdTT0jZlCnvf9fZqcYetclj78FdWARe7mG97t6h5G7XzHqyOKiCAH23h1?=
 =?us-ascii?Q?MjBWrvKo+uaa57lgwIWfpcHiRf5N3qyENr0NRxr9+eN1H6OmfwUpZ1A9QE0M?=
 =?us-ascii?Q?UU6/eHjq0DvZsQ2CxorNqVDqBbPkCKZDlXV3Z29oogUseA/V4klSAohBLQ6C?=
 =?us-ascii?Q?ZhocesRDBdwnmCYCSbdqSDE7HEe2aZaVAHpS5D32JDhtYa/06KtsA5nkl8pt?=
 =?us-ascii?Q?SjMih0PpDv+csA432q5WTU/VhdxWEVusrkFzz2grGOwPP1bdh5+nSBkbwCGT?=
 =?us-ascii?Q?Fyg9QkSmGKRBDsOSEVeXee8elH2Lm9ZdvWSo8XP6rZik9utvgGDx6keUawcB?=
 =?us-ascii?Q?yZb5YO7HpcyfKCoR6wHgGWJcFMA9VemKjo4GKpe01G8KXISenzPQrS/bub0D?=
 =?us-ascii?Q?HxBXJKKqi2NlhARTYqz9aBy5X8ufJhzsBDUd6inelqXdn/f4mMqtB7l/EB8Q?=
 =?us-ascii?Q?bELSh85K1CYIfHfl0PAbSdyrJJN08ak43FqHJ1CTayMvOsJgri/dd8FjSHqZ?=
 =?us-ascii?Q?fU1O09VwaQ85AoaQuoOq7opVY9C9e4P3b0im2+2P7SgsVCEYKzbB05KLo9uq?=
 =?us-ascii?Q?0FVt7EgHV0IDo1P2xcqgFRybraKCXZZ3wGdg5kyyZF5k8fBA+uYwnqDwBT9t?=
 =?us-ascii?Q?pInx4iA/p2OKu4kg4rYEPt8qzNQ6v4XyS73TsmNO5DtSV+6DB9Oj+L8HJBhK?=
 =?us-ascii?Q?j154LhJLYBXwiWjnyhnDYe9WaZhiiFxbC8DNW38BB5ZRYHGp13zVVgNkIpvy?=
 =?us-ascii?Q?8Ng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce7e749-1920-4142-a0df-08d8fd634af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 03:30:17.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmBdTgkcG5nogEpcuNLrgH5fSHNl53cblFju4CitkdqZjIJ1u5YStWSU6G98fNt2on/oZckl58yC1b5fI1Tmw70Woxi1iwk4mVbfT+WE1iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4328
X-Proofpoint-ORIG-GUID: JqFrxKfUQRxCyC25T9KJ5RppvcTLcSiJ
X-Proofpoint-GUID: JqFrxKfUQRxCyC25T9KJ5RppvcTLcSiJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_02:2021-04-09,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=757 malwarescore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 21-04-07 08:36:29, Pawel Laszczak wrote:
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
>
>Pawel, it is a little late for v5.12, I apply it to v5.13-rc1 if you
>don't mind.
>
>Peter

Yes, you can apply it to v5.13-rc1.

Thanks.

r
>>
>> ---
>> Changelog:
>> v2:
>> - removed useless blank line
>> - changed the EP_UNCONFIGURED to limit changes in patch
>>
>>  drivers/usb/cdns3/cdnsp-gadget.c | 17 ++++++++++++-----
>>  drivers/usb/cdns3/cdnsp-gadget.h |  1 +
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-=
gadget.c
>> index d7d4bdd57f46..56707b6b0f57 100644
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
>> @@ -1043,10 +1048,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep=
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
>> index 6bbb26548c04..783ca8ffde00 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -835,6 +835,7 @@ struct cdnsp_ep {
>>  #define EP_WEDGE		BIT(4)
>>  #define EP0_HALTED_STATUS	BIT(5)
>>  #define EP_HAS_STREAMS		BIT(6)
>> +#define EP_UNCONFIGURED		BIT(7)
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

--

Regards,
Pawel Laszczak
