Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111AE30EFA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhBDJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:26:01 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23550 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234589AbhBDJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:25:55 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1149MGL6014112;
        Thu, 4 Feb 2021 01:25:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Ldzg+ygKV1HHHnrEWQPWEDL3l23j0xxC9l2U3ZBim6M=;
 b=A1J+DbIDG4hlentwuSb9E5aKC7HtFMcEy6D+9Tq+aFGE/jz2F/TMWFDx7vgACxynAeBE
 Vza+2YEcy/pjZKbCweHf7a1QkQIsJbXj977KP0+YIgzWDn4U1NVLMW4JptrhPUS2vsxN
 jRoniNLnhSh56RmHztTy6neoJdJQHF2a7L3XFQopRmpCjClb7pYn61h9UUC3WdWXUiob
 QcrqyBSuccSpG5oGq/2vnrNPnknZcN2v6IHPnWVMszleFepiA/BBZolrxZxr/HxL5RMQ
 7j6C5vM435AsomNYfFc1ruOPFhChtkbMD23kN8jBzNIsxaMY+lYEwNchk/vdjKfnACPV 2Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36fgekwuf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 01:25:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6TyK+Qp1HnQ30E1eIJ11W7cb0CNcbBTtk9romkL18dKuBkA5VAx0AX9hfheIyGPfYIujzNtzmetgzRCzsGJ9fdomUrFVbla1zo1BcujkFJavt2MWPaWYVjRiq49eK8fJQdM9uheeHBYmHIut61+BZBhgt3DohEV91aiFunK2/6UbR67iXWsBnR6CdPNRtGPJD/5foMh2JunmEUkw8RF1HfwS688ZqV+/KZMP4gOALsvPrU8oz+22eJYPN3AEc0/YcFGzG6U3+Cv48kdlCnl7NyKw/uMeNcLPz4wmexqPQ49TR+sY7QYbikO7aP33EZbbZPlXpo9YZHaT7cwS9A6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldzg+ygKV1HHHnrEWQPWEDL3l23j0xxC9l2U3ZBim6M=;
 b=kpQfMFVXMA+12ZM2mFSaJaiPSynSNXACwUSSgFPN/MC83BGJbelztjURyth+tVgmyXevfziLkU1ZFCmQ5/+CohI0i7e3vBt/wOmjmfIAGgmSgbxFVmN5kL7Qd5/WiOBdFXiXbzo3NBPQN+l10Wm77XwQerXEZlVfWu/6iw+udtrH+2ZLSWeVRG9BVBPhpa2yeJZMyQ/OGv78ObDF7i4QoRg4wRbDV/flT+BkvtP8f7/gy/EnBMA3gJRZp2V6eTts2WLUJyY0anZjrG6pp78+w2azvWoH5iSR4WX2XxAZC9lM3RWxb7EHRTZVVJlznvjw29UmoGIN6TiHxBY0nMtLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldzg+ygKV1HHHnrEWQPWEDL3l23j0xxC9l2U3ZBim6M=;
 b=nS//+CUJ2Cs7BR/+GRU0qrnam0jHPb832xod7AtL03V9ywDsU1eGYRJA6nGPRbnm/W7j49SmCo7y5YedfXKYfVFsOVjYjXgiTIEfSJrTnDjjCFQ/EW1BwMXzOCjvMxDfaZHghRww3FRvdEb4ogFZ57hw5bDOOozIBEwLtuliEPw=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5863.namprd07.prod.outlook.com (2603:10b6:a03:134::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 09:25:06 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 09:25:06 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
Thread-Topic: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
Thread-Index: AQHW+h1/B1gGPc5PZ0+sFJQAxZIcPqpGZqMAgAACpSCAASESgIAAL77A
Date:   Thu, 4 Feb 2021 09:25:06 +0000
Message-ID: <BYAPR07MB5381A2E0731A9B982FD28B51DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210203111239.18313-1-colin.king@canonical.com>
 <20210203130440.GV2696@kadam>
 <BYAPR07MB5381361C15E436BE54D25C93DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
 <YBuUnyFPvPNhkXEu@kroah.com>
In-Reply-To: <YBuUnyFPvPNhkXEu@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGI1MjM1OWItNjZjYS0xMWViLTg3N2EtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGRiNTIzNTlkLTY2Y2EtMTFlYi04NzdhLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTg3NCIgdD0iMTMyNTY5MDQzMDI0MDc2NzE5IiBoPSJ6MEpFZGVrUXRSb2VDVHBMYzBNeE1rcnh4cEE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d038874b-4bd1-47a2-002f-08d8c8eec2b4
x-ms-traffictypediagnostic: BYAPR07MB5863:
x-microsoft-antispam-prvs: <BYAPR07MB586302D009F2AE81439F177FDDB39@BYAPR07MB5863.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6n5U6ufK6Pl1z4Kc3rAWD+yn5yxa6Mm71fDmGRoIgFlEcR3SYanB3GVFcKP056bcP/YY2dGkShI/n+p3arcVDMY/6z6/+U6JbwuhhbZmEm9a2+FWGpkqgf2Y8INa87AjxF9gQSNYeE3+zvI4Vdzix2M4unKR8sxL4vryF5vt7qlCj3ukOl78kkI0k+dmtjRqMZEi0PIn8uDw0ski8E5QA2ENazrllSCEao6eJHfbIjud01Ran8Iywo/ebZjq+SSfJt3wNsWJtGYVDW79P0xsPlp/6BKcu0trJ0dcS1x8XPBXbDU6wEDo3rYUaWqXavKE33v3a/PLSDdhWt96Z2TikjV1FVMQtycrHIMeFDfrRbIFs8RNh1chQk81Q7K+EAZZHBR1YYcxyL9A5QDERBYPbmywTrLqhaUt15ngsObJ8YpIzpLVVFW3GuxRVcF1fZkj2OHuwqhMaL/bJ4AXWpHK4kdh0CQomqYbCBJ1W46C2O0W+4f0NKUtsgnWKDrGtBI4JiR8fYylAfZbaad+bg/EkEY24dp57GmQ3QyBFQMsHWCmy8FXHokOgN3H0Hrv3PupaOxBVxEo2bKdVMUbN47rBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(396003)(366004)(346002)(36092001)(54906003)(186003)(2906002)(316002)(33656002)(71200400001)(66556008)(64756008)(66446008)(83380400001)(8936002)(9686003)(6506007)(55016002)(478600001)(26005)(86362001)(7696005)(8676002)(52536014)(5660300002)(6916009)(66946007)(4326008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C2RqC7inpyVLdMeXfdApbpua2MzZyZyIXKtp1ESXmujpQcTURSO7pB0bbtVj?=
 =?us-ascii?Q?oqLEVEDl4nKwqLIKSjLuYDxDv2EhT6SBxjfjvBbHbf5JeH8b4zIz3TN70bMf?=
 =?us-ascii?Q?vEVsraV0ecQwuBs4EUQao+uH/xvTocwTfPHJ3ynHFOwNLofXIFVm2MHvSwCM?=
 =?us-ascii?Q?/L8nS3JwOePwpKRBEkfQTg4zwSK8jerQfS6kutJapStreAAGKpnZqNip/Fdw?=
 =?us-ascii?Q?TEFFlJl/fcxUGK+yeQkrrQFbuHMJgqiGKZtPHN1uJ5u4KEBs3yL8/bLhnS/9?=
 =?us-ascii?Q?QKXK+o+iHgoUmZf79Q+QKtahhAjOYP6uJwPZYvnwiFfSTXgYT23MSKb07f/G?=
 =?us-ascii?Q?B/t373FQxCQtCCTaAqa7X9qKbxTs6wjTcn3MtKTQehWhCJVQR4q62Oz40Xku?=
 =?us-ascii?Q?Fo5qUFbUiBZvF5rc1TyaNsxAjmRm5BNHHkppkmCX5hNd7ov+2saBoQD8tIo+?=
 =?us-ascii?Q?3nwF1kiiTvzyAyz8wrFB/anc7W2JLgzv/5SsNqf2c+UHpJyzYgAWKArEq0B4?=
 =?us-ascii?Q?92I0Ios/JxdflRZzvR/TWEJ9AavGs0vU7nbYYZJgmz4lT8/L2Uqg8+NU7OQv?=
 =?us-ascii?Q?kTMcHn94qNPsZroZkS9tjtOQeXQzuDSn2ljiwvfpyOhYOXVJ04QtyMyx21sG?=
 =?us-ascii?Q?UuDij1N5ZDYR0vuRccLkRc23Fc1xSb4ssJWmNB8Qc71GhfHglhiHbF4lbZXl?=
 =?us-ascii?Q?0CDtKdlgGXbIxmtywablBgvOH/ANkP42tuKDNxuqSxoTwYwZ0SQ5iDhhKE2q?=
 =?us-ascii?Q?susxmVof/zj+qasJIkTb4o0zyetEu/YJT0CyxJSaV+OEXjwbCKXJxq9sTpde?=
 =?us-ascii?Q?M5Qj0PvMsFqB1DeijaNDGH+1CV8481ivN4lPFe4uy9a7GC9szQoqLJdye+Ev?=
 =?us-ascii?Q?VN4ehleEt9y/dOY6TzPV8eunb84jqTBSOMRifjIOao5RW3QKf71rX+2SDcN+?=
 =?us-ascii?Q?24TXu1xX3V5E2DARXf6PdSFhDg7FkB3IPpzB8j8wsdIo8IzizUBABNNNOdrP?=
 =?us-ascii?Q?tlRWu2RPCa7s+VI4hliwXWxU/R6G9rW+sM1aDTwJ1qI5dK0gpWjagdb47O1Z?=
 =?us-ascii?Q?oasnkc48?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d038874b-4bd1-47a2-002f-08d8c8eec2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:25:06.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voOi5ifqOMCBz5lU5cDrOMs16BSTpPUf+apt7uTBsW1N7Nu16zuYbd9fOpBHGyrNAqa7HfJrtlXRjZgEHFPotuBpwXdepBlbFVmHV72SQbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5863
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=986
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've sent the patch that remove this one and others similar printk from dri=
ver.

>
>
>On Thu, Feb 04, 2021 at 05:07:16AM +0000, Pawel Laszczak wrote:
>> Hi Dan,
>>
>> >> From: Colin Ian King <colin.king@canonical.com>
>> >>
>> >> There is a spelling mistake in a literal string. Fix it.
>> >>
>> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> >> ---
>> >>  drivers/usb/cdns3/cdnsp-ep0.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-=
ep0.c
>> >> index e2b1bcb3f80e..e30931ebc870 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>> >> @@ -45,7 +45,7 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_devi=
ce *pdev,
>> >>  {
>> >>  	int ret;
>> >>
>> >> -	trace_cdnsp_ep0_request("delagete");
>> >> +	trace_cdnsp_ep0_request("delegate");
>> >>
>> >
>> >This printk is useless and should just be deleted.  Use ftrace instead.
>>
>> Maybe this printk is redundant but it's more comfortable in use.
>> To debug I can simply enable cdns-dev events (echo cdnsp-dev:* > set_eve=
nt)
>> and I will get the full  picture of what the driver is doing.
>>
>> Otherwise, I must remember which function I need to add to set_ftrace_fi=
lter.
>> Of course, by default I can simply add all cdnsp* functions (echo cdnsp*=
 > set_ftrace_filter) but it
>> increases the trace log and makes it a little more difficult to analyze.
>>
>> So maybe in some cases we shouldn't complain for such printk ?
>>
>> It's my private opinion and not necessarily correct :)
>
>Please don't have duplicate tracepoints for something like "this
>function is now called", it's redundant.
>

Thanks,
Pawel Laszczak
