Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE91406CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhIJNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:21:25 -0400
Received: from mx0a-000eb902.pphosted.com ([205.220.165.212]:2722 "EHLO
        mx0a-000eb902.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233538AbhIJNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:21:19 -0400
X-Greylist: delayed 1932 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 09:21:18 EDT
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A8Su23007917;
        Fri, 10 Sep 2021 07:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pps1; bh=OHzS48zYi6W03Cf/rsDZH7YoxMNKJU+ufGxP0vKH0u0=;
 b=mkIcsiMZoDJLceeD3s/RkxARuZ+DtN5Rvj90sP+S4ALnzDlNeDVXSCQmERRofcqtAyCH
 kUw67jPlN8cwabrp0CMBbSDZtAto7SmsOB1syGUeVFhp/fhDhTqHUJkxZlAIi4YsAj0q
 oWRiWh7aNgBYzSNYNJWQKZXrBi3ei14AMPmhX/a2Q54v6dnSUake2WsutdgukiEAW866
 BOV/amqqlEVxKQzIxW+Tx1kQ3NB8QYjnJEhZIP8bVejBw/SHwlY9JZFI9i1GXQHAAtHi
 od/i6ROjYYc564cIRNYGPde1SSPHsFkHKQAhw8lp/D94SPHS/yrbPO5Oq/ymqUmRHaL1 Ew== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-000eb902.pphosted.com with ESMTP id 3aytfv1739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 07:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4tpowfN9oi+VPr8UvVsEoJiT7QvyTlae5rumUzrBzU8e0Un/S+RZkJDaJ5sM6tQTH9o8XjmcpX3Azj5ZJ5FS5R9WMSNShdSHiuJUEB1iUvSkOfFXhi7nMbKseKx9D6iwWmrj7KwMU+tMITTGtPmd7SvhkpnI0Hc3JWi1gHHZJJqFBgB1cWzIWNshbGEPStiIqXhYmo2VIrENjxqDOrpNKroFaMS/yXP4E/Thwiux7SfjQqpVaMZgK8M0vshlTEMEO3gRxPbvuRm+5ERcC1JqoGVdXaIilQ61DkX24xlw3jepHLAXjUkKrsjUQGMz4k1pdOXWyl0gZfm5zHCtbdFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OHzS48zYi6W03Cf/rsDZH7YoxMNKJU+ufGxP0vKH0u0=;
 b=XW5AdclpEm4JdF64VjgEH9hpHp9KlRJvWmsCMzYKoAPk4no8qT2GPF6XAvxv5gAUW30Q+1aaS29W6CCmoF3G8FOadxVNDlUx5f8HL4vb9ZIoANAFahksFBnhgS5f0BIwnO4dmp7/8uJeenegYGh2NMhhs1wtbhsnyvLfUkAUufZ56TOsXgeEsKbX1quZdbZ1R4O/njAOz/UH6P8ShonzCUNxZ3sGfhMCEfCF+4QqubBkkSXXsYE1XUIQgSJ9GxMkc835jq3IUjyxzAweLrZ3bmAVfiSrw8d8u6Q8wMgdOdfzsBIPGkM2T86eFncxWPX7dPdG2Qj/yapBoSaAZDmvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.132.76.132) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHzS48zYi6W03Cf/rsDZH7YoxMNKJU+ufGxP0vKH0u0=;
 b=mE1jPLfnSbskgj+5r/kqkCKskgPg3p1AMp/LWa4NfT18mJXePs0w+iS0X6SwMX9MqRsVTb+/i77wESoc+h/yx0Ie4PG/exkn/5CoGv37QYK290b1PWRMMI3BpyLSDFKdBbQilY3Yv0rLg+nCV5uEgoVf6lU4hhM8UysEh07Jb17TB8YhkLlSkbPLxg5SBOihddLwOgO1sPcQ+/YjZeqCisNLDRIXnDqzp1hp7o1Qir+35r52HFp/Iu9rCU8pp+jvIekDwV5B0ItwKOCdu7Xkew/avxXAphUcvZ089yBb0i0tYoIzTLZKG3/8nX6u/ZDBQCEEvGNRKSIH0d1OC/i8ow==
Received: from DM5PR07CA0134.namprd07.prod.outlook.com (2603:10b6:3:13e::24)
 by BYAPR04MB5335.namprd04.prod.outlook.com (2603:10b6:a03:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 12:47:48 +0000
Received: from DM6NAM10FT019.eop-nam10.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::ab) by DM5PR07CA0134.outlook.office365.com
 (2603:10b6:3:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 12:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.132.76.132)
 smtp.mailfrom=garmin.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 185.132.76.132 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.132.76.132; helo=garmin.com;
Received: from garmin.com (185.132.76.132) by
 DM6NAM10FT019.mail.protection.outlook.com (10.13.152.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:47:47 +0000
Received: from souwpa-exmb2.ad.garmin.com (10.66.12.252) by
 ukbwpa-edge00.garmin.com (10.70.4.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 10 Sep 2021 13:47:28 +0100
Received: from CLU-56K1TB3.ad.garmin.com (10.5.84.15) by
 souwpa-exmb2.ad.garmin.com (10.66.12.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 13:47:43 +0100
From:   Razvan Heghedus <Razvan.Heghedus@garmin.com>
CC:     <Razvan.Heghedus@garmin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Johan Hovold <johan@kernel.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: misc: ehset: Workaround for "special" hubs
Date:   Fri, 10 Sep 2021 15:46:10 +0300
Message-ID: <20210910124612.33368-1-Razvan.Heghedus@garmin.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: OLAWPA-EXMB2.ad.garmin.com (10.5.144.24) To
 souwpa-exmb2.ad.garmin.com (10.66.12.252)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a7672e0-99ae-4d27-39b5-08d974593179
X-MS-TrafficTypeDiagnostic: BYAPR04MB5335:
X-Microsoft-Antispam-PRVS: <BYAPR04MB53352DEC2B995CFD454DDD3590D69@BYAPR04MB5335.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7K55xpkvcoDDgdbtqpYb2/xcmScQlqQC7JO33v8E2wpXxNIWAkZ6eslnsAdzDJKVraOe5j6HXu57Wo4bLZhLGOYspd4kRj4x4MUkYFD2YmZPxb291nTArfFd3JmA++eijbK0vTTV4WQ0Wk8Oe9twuIHkWcL4WaU2H/1d6kHeIAlJ5afDcNtUAIE4r52bVrA5aqCtmcCkSmk3S79Z0bggjrE4JHKVNoauAYh0k0t1Aa9QnDZKTHo+cANoXEyiy7QxLdCLg715IgjOTdatm+xhsA6WTaBpgYFy9Kxe3okXX1wVKGJdIY3OGAiH+uf7FTRqIaTMB4koCq5kXNUoonccVG2bQ5vM4kMZr3Z2hoq3VR8EmbWxAS1MDnKgGhwsUMu7ZQRn7D82QdlU/wpJYtnVcMsgtdwU6kiItAAABbOr56GTGJTyuj96HRIzz2PWsBj/brkRvpr8KJiMlc27ePdiXLPdhWBI7So8t49xaiE9ERzrHUUt/MY4sHZJNRdPYbDMavg7VYX3fyQ6Q+IAcvL4AO7kXel/BYZqwrFAB1xyz5LVB1SwKkccCvYrxIfJqrzcVT4hiXWhoz3wgTvmjOwt1u3TYDM2EnBM4g1o00Ajq5OSJH26qi6+0OuSfLTi8DeH4iNnFWFn43O45ME6kvVnWV9Ol4mHa71crQ1sk1lcICFb1c2xUYiNxDXWVtKf4QKxXFSD9/QLdFQwU58WkKhsc8iu9gJIjFRSynuMqPHyi60=
X-Forefront-Antispam-Report: CIP:185.132.76.132;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:garmin.com;PTR:edgetransport.garmin.com;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(8936002)(478600001)(5660300002)(7636003)(426003)(26005)(6666004)(2616005)(8676002)(186003)(356005)(1076003)(109986005)(36756003)(336012)(70206006)(70586007)(86362001)(82740400003)(47076005)(36860700001)(66574015)(54906003)(316002)(7696005)(82310400003)(2906002)(83380400001)(4326008)(266003);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:47:47.7736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7672e0-99ae-4d27-39b5-08d974593179
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[185.132.76.132];Helo=[garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT019.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5335
X-Proofpoint-ORIG-GUID: XxeW7r3qMUO9kjbHrruD7t0D_i1SrlmS
X-Proofpoint-GUID: XxeW7r3qMUO9kjbHrruD7t0D_i1SrlmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-10_04,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109100076
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2.0 spec chapter 11.24.2.13 says that the USB port which is going
under test needs to be put in suspend state before sending the test
command. Many hubs, don't enforce this precondition and they work fine
without this step. But there are some "special" hubs, which requires to
disable the port power before sending the test command.

Because the USB spec mention that the port should be suspended, also
do this step before sending the test command. This could rise the
problem with other hubs which are not compliant with the spec and the
test command will not work if the port is suspend. If such hubs are
found, a similar workaround like the disable part could be implemented
to skip the suspend port command.

Signed-off-by: Razvan Heghedus <Razvan.Heghedus@garmin.com>
---
 drivers/usb/misc/ehset.c | 78 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index f87890f9cd26..169f10efd163 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -18,6 +18,44 @@
 #define TEST_SINGLE_STEP_GET_DEV_DESC          0x0107
 #define TEST_SINGLE_STEP_SET_FEATURE           0x0108

+/* A list of USB hubs which requires to disable the power
+ * to the port before starting the testing procedures.
+ */
+static const struct usb_device_id ehset_hub_list[] =3D {
+       {USB_DEVICE(0x0424, 0x4502)},
+       {USB_DEVICE(0x0424, 0x4913)},
+       {USB_DEVICE(0x0451, 0x8027)},
+       {}
+};
+
+static int ehset_prepare_port_for_testing(struct usb_device *hub_udev, u16=
 portnum)
+{
+       int ret =3D 0;
+       /* The USB2.0 spec chapter 11.24.2.13 says that the USB port which =
is
+        * going under test needs to be put in suspend before sending the
+        * test command. Most hubs don't enforce this precondition, but the=
re
+        * are some hubs which needs to disable the power to the port befor=
e
+        * starting the test.
+        */
+       if (usb_match_id(to_usb_interface(hub_udev->dev.parent), ehset_hub_=
list)) {
+               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEA=
TURE,
+                                          USB_RT_PORT, USB_PORT_FEAT_ENABL=
E,
+                                          portnum, NULL, 0, 1000, GFP_KERN=
EL);
+               /* Wait for the port to be disabled. It's an arbitrary valu=
e
+                * which worked every time.
+                */
+               msleep(100);
+       } else {
+               /* For the hubs which are compliant with the spec,
+                * put the port in SUSPEND.
+                */
+               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATU=
RE,
+                                          USB_RT_PORT, USB_PORT_FEAT_SUSPE=
ND,
+                                          portnum, NULL, 0, 1000, GFP_KERN=
EL);
+       }
+       return ret;
+}
+
 static int ehset_probe(struct usb_interface *intf,
                       const struct usb_device_id *id)
 {
@@ -30,28 +68,36 @@ static int ehset_probe(struct usb_interface *intf,

        switch (test_pid) {
        case TEST_SE0_NAK_PID:
-               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATU=
RE,
-                                          USB_RT_PORT, USB_PORT_FEAT_TEST,
-                                          (USB_TEST_SE0_NAK << 8) | portnu=
m,
-                                          NULL, 0, 1000, GFP_KERNEL);
+               ret =3D ehset_prepare_port_for_testing(hub_udev, portnum);
+               if (!ret)
+                       ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_S=
ET_FEATURE,
+                                                  USB_RT_PORT, USB_PORT_FE=
AT_TEST,
+                                                  (USB_TEST_SE0_NAK << 8) =
| portnum,
+                                                  NULL, 0, 1000, GFP_KERNE=
L);
                break;
        case TEST_J_PID:
-               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATU=
RE,
-                                          USB_RT_PORT, USB_PORT_FEAT_TEST,
-                                          (USB_TEST_J << 8) | portnum, NUL=
L, 0,
-                                          1000, GFP_KERNEL);
+               ret =3D ehset_prepare_port_for_testing(hub_udev, portnum);
+               if (!ret)
+                       ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_S=
ET_FEATURE,
+                                                  USB_RT_PORT, USB_PORT_FE=
AT_TEST,
+                                                  (USB_TEST_J << 8) | port=
num, NULL, 0,
+                                                  1000, GFP_KERNEL);
                break;
        case TEST_K_PID:
-               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATU=
RE,
-                                          USB_RT_PORT, USB_PORT_FEAT_TEST,
-                                          (USB_TEST_K << 8) | portnum, NUL=
L, 0,
-                                          1000, GFP_KERNEL);
+               ret =3D ehset_prepare_port_for_testing(hub_udev, portnum);
+               if (!ret)
+                       ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_S=
ET_FEATURE,
+                                                  USB_RT_PORT, USB_PORT_FE=
AT_TEST,
+                                                  (USB_TEST_K << 8) | port=
num, NULL, 0,
+                                                  1000, GFP_KERNEL);
                break;
        case TEST_PACKET_PID:
-               ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATU=
RE,
-                                          USB_RT_PORT, USB_PORT_FEAT_TEST,
-                                          (USB_TEST_PACKET << 8) | portnum=
,
-                                          NULL, 0, 1000, GFP_KERNEL);
+               ret =3D ehset_prepare_port_for_testing(hub_udev, portnum);
+               if (!ret)
+                       ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_S=
ET_FEATURE,
+                                                  USB_RT_PORT, USB_PORT_FE=
AT_TEST,
+                                                  (USB_TEST_PACKET << 8) |=
 portnum,
+                                                  NULL, 0, 1000, GFP_KERNE=
L);
                break;
        case TEST_HS_HOST_PORT_SUSPEND_RESUME:
                /* Test: wait for 15secs -> suspend -> 15secs delay -> resu=
me */
--
2.33.0

Handelsregister beim Amtsgericht W=C3=BCrzburg / Commercial Register W=C3=
=BCrzburg HRB 11347
Gesch=C3=A4ftsf=C3=BChrer / Managing Directors: Johannes Angenvoort, Mike W=
iegers, Andrew Etkind

This Email, including any attachment/s, is confidential and intended only f=
or the individuals or company named above. If you are not the intended reci=
pient, please do not read, copy, use or disclose the contents of this commu=
nication to others. Please notify the sender that you have received this e-=
mail in error, by calling the phone number indicated or by Email, and delet=
e the Email, including any attachment, subsequently. The information contai=
ned in this Email may be subject to professional secrecy (e. g. of auditor,=
 tax or legal advisor), other privilege or otherwise be protected by work p=
roduct immunity or other legal rules. Thank you.
