Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D397D31CD93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBPQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:09:12 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:2670 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhBPQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:09:08 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 11:09:07 EST
Received: from pps.filterd (m0118793.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11GFqiVC004388;
        Tue, 16 Feb 2021 10:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acuitybrands.com; h=from : to : cc
 : subject : date : message-id : content-type : mime-version;
 s=pps-01232019; bh=eHlycL4bLEuw5pHn2zhzIttQxMosvXre3CLOcwR3HRc=;
 b=jt44dPNTfYSWuLXyvMbq/uCWNX4yjtBC85VVKjw5UStsjlYIFQK5g8g2sf/+bZrk4BDw
 9y45wLRfYQq+BUgOI+C+TtREzHRBO7jvXhopQ9eTJ9RVoktz6Bm8m74KttALWufer8Ev
 y9kcDbcpR7HP3HVNxax9Q+iRZOdr//F/YeUeBdjppzdLGaWTdKnzfwMHHPAr5oBfsUCw
 9GS7WKozyZOihxkBXXnvikjvcPPlZdzz6hNIuTT7iN62LndV6/M0ByiTDWQsUuy9xgCX
 DMnzW7QyQy+3FAcQB2lhIRqg8h/5jAc/gKZMJJGVeZb6PjrOXkf7qsHIBQyNtmO7Ck4E cA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-002ab301.pphosted.com with ESMTP id 36pccp2j03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 10:59:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJUOh5itv0gnpjOZLAwi28YyPJeokWE6+4/Sx4ro0d5ZHUIviLCYfuhHcRuK/TB5UgsybPZ0nlzcTnr/NhvRsfNKQ7lthFEqrUFFEcnUpjIgef8M2a5lCDyhrZsGzwAiQn7xzKvsMHgUUysK9wF29gfjIXMTzTJ8xJxxIBqCrdT6iVlU3IXpZUkJAe1bleZ804bPMWFJcJhWbMXJQ0q/4BHqCR3rrutMJjLHBB5JuAn5hk6BYL6O1L53p5AeFHBAy2pRM9JQbPPC9vPa/v+Kr1nYe/qH0iUraJLbF8SmRvQKqF/bY3GQtu8yAGRjixr+so9vNXf2VsrlD3CAGC2JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlycL4bLEuw5pHn2zhzIttQxMosvXre3CLOcwR3HRc=;
 b=ctdypAydyeCRG41LhjsOQXJuxdPP6qZXgQ6Sjv0/esPESEdE1bHiiI4NqafvnY+bYqmLJyuE5NCdnBGNR0wW1lhErebTyRXQgH+YoplnWrKK+lQyoatk1EG6UmxQHM8t4at3QXDrfnmnHfeYb6UYAzlzXOuiZZPlFUrNWBYy751R4cKzit/ARL6R6hMGc+rd5qOWmHKfhY1sZATtipoJSgA4FrGMqpe7La1jslEa2vJa/tezRtrIpJ270xuAax6Ywb83CgSNxNt+KzmDHR+8C2rQYIm4E0WL0jCPReuaH88gPhKv+2XckX/AFRuqSXtN2YsYTiUE8LJsZ6rw0AByZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acuitybrands.com; dmarc=pass action=none
 header.from=acuitybrands.com; dkim=pass header.d=acuitybrands.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=acuitybrands.com;
Received: from BN6PR0101MB2995.prod.exchangelabs.com (2603:10b6:405:30::10) by
 BN8PR01MB5476.prod.exchangelabs.com (2603:10b6:408:af::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.31; Tue, 16 Feb 2021 15:59:42 +0000
Received: from BN6PR0101MB2995.prod.exchangelabs.com
 ([fe80::8040:b823:92b7:aa14]) by BN6PR0101MB2995.prod.exchangelabs.com
 ([fe80::8040:b823:92b7:aa14%7]) with mapi id 15.20.3805.033; Tue, 16 Feb 2021
 15:59:42 +0000
From:   Karan Singhal <karan.singhal@acuitybrands.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Singhal <karan.singhal@acuitybrands.com>
Subject: [PATCH v2] USB: serial: cp210x: add IDs for nLight Air Adapter, Acuity Brands, Inc.
Date:   Tue, 16 Feb 2021 11:03:10 -0500
Message-Id: <20210216160310.6144-1-karan.singhal@acuitybrands.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [24.98.66.87]
X-ClientProxiedBy: BN9PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:408:f8::20) To BN6PR0101MB2995.prod.exchangelabs.com
 (2603:10b6:405:30::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.98.66.87) by BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 16 Feb 2021 15:59:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c119c42-a96f-4c6d-a141-08d8d293df82
X-MS-TrafficTypeDiagnostic: BN8PR01MB5476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR01MB54760638FF271409FBDBC7F281879@BN8PR01MB5476.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcA8RT7xHknULqe6FAqohwkmpnz1J7Dx4GzcZe8hPTyg+YtgR7jEzCdVP4We/bb3rfbXtrFl+znIxRGOxnONfLdT3BErfO641sxdoBu4LJnWJHnGMPOWfnu4DaCeIRHFv+M4aTF7ttWNtPL/SdjHnKLRiztMQGAPMTqOi0ocbC+1ig2Kn8VHun/njMHYqBB23Rqxeix0M5WMn/HPsPkp3rxrPZaikupV/qOkoT93x/UdHq7Kb7CF/+adb/uU0T40UGCy2Oe9fin4Lf3Ba8muF+hSmTXGQaKhFue0ZAGRi94d6S6awWCyjHhJDZTLtAbkW300sXuhKOQ1BPhGfnYtGU5N6UFCQyM5/tYcaCuyukPwd/WOjDZMQzqKAE6wJNpqQDuqRit8TXI9Z5hTDq5CRiuDpJtLfSSMhxtwQa3vWXB6QTc7onozwVm2J9ZTxtDocYnlEKJye7FGduiKemvUCDI8XcADJ+yfmoqMz+mjrbxL+5kSErhAVHGrJDrlL8WkIsUVrnUJcaGGGU1ZA2HVQP8329tF9xgYFuAXkoj5Z/6FIwCDie3EnK9eUV7AK8ca5cbkP+Plge1Z2HtRtutSIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR0101MB2995.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(6506007)(66476007)(186003)(4326008)(66556008)(1076003)(44832011)(107886003)(316002)(6512007)(6916009)(2906002)(16526019)(26005)(69590400012)(4744005)(86362001)(8676002)(2616005)(956004)(478600001)(5660300002)(8936002)(6486002)(6666004)(36756003)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UZs0b9pyOHu/ty3ezZczplw2cUmt1ysV5dqWemcxGrSzIxpjgvlarMYy/v9h?=
 =?us-ascii?Q?kovF7+wE34MpsSMEkuQDJgp7J38Q/37Pjm1VfFaMzljNoQM/uktF97sqe5rd?=
 =?us-ascii?Q?g5slpd4egChU4Vpt0ZfaMVi1U2jL2g/vT0O4i7aQ+1ZtM78Ga1Rr8npY1J/5?=
 =?us-ascii?Q?SCb8+fWwlzEhVGtHYcqrDpZR/hS13kC1I47uizkSPgaAm0QteVYpRrFRAnlK?=
 =?us-ascii?Q?ZM5BKao0Kq0/AbJuJVem+AxJqIjw7eTtx8sneMEolEsZU7xMi/an3AISNHfv?=
 =?us-ascii?Q?TpUfoMtme7ZkVNt4F0omMygY9VIjpq2/xNvut9+DTM2hCA2c3RbBfTC+/5vz?=
 =?us-ascii?Q?/+L+Oct9GXbDSMIJDERpEwtaltQfWtqeXiOwTshBCiQZDd4vbSiUDm3z4dND?=
 =?us-ascii?Q?KxdoaSAzar7Qfwl/4ZMqPnl7H1+YknSZYVe0jhTKe3GXk8Kg4o+fIqyWmAIZ?=
 =?us-ascii?Q?oywHxbzAf4q/t8bL5U8jnphyzvAJR0AjY/u7TY2RXbkpk+7FBzsavPaqSXvA?=
 =?us-ascii?Q?IF98NJqHQMlWOtKWW9cqd2CLF8ft8bTuulWPeTZsnOoboqB1DwXOthk9jwbV?=
 =?us-ascii?Q?EsgmceXs/YpXPtVvMNXSHyRBG4gdu1M9e4qcBl6PDfZm8GVJFCKAUpkMcaU3?=
 =?us-ascii?Q?cUjyZdgJjjmowrebNyJiIzBOip7h01FZMGT3f+9SUjUsO89vs4p0Aw6PxgsD?=
 =?us-ascii?Q?LaMbXPVj/xnslNiSo8mFecCI5na/SUhiE3PhhGBNunErvPw+F48XeebTK63C?=
 =?us-ascii?Q?Ef+DTSiem4s43DdnxPzeRvGcj6pxNxE54Fyq2TBmfaC/e1unlJHEH9OwKwvN?=
 =?us-ascii?Q?VqNdF1mhsFZsVD932n9O0SwYVRMroa9pwMUrIgMG3cFYxPoR6LWyZ2W1GO6S?=
 =?us-ascii?Q?lz1Mri+k7jTGb1Kt+CCBzcgooH1ZL/StmRdGFd035OcgLOoR3uAgQD3oBNzl?=
 =?us-ascii?Q?5Xn35TPmgb6qeZNRcpz1nM7ffiMVyQS59M2kx0rq45eekFmr4Lcd8zevlCRQ?=
 =?us-ascii?Q?XpAzVU0EB1rdNLdGsmkKWkkLSi+UoYonN61Amcvu0w1fqJw9p4hzA9jO6VSb?=
 =?us-ascii?Q?2gUTu1MCgOCgFGJ9FF3K/2gw0mJ8+3gv18Jr/9zlXj1/UeYU2JqjyDPEcX7N?=
 =?us-ascii?Q?kV3hz8lu3/7E9ZBtmoSx+i2HXhECUyF1PeVXiC82VleBGJ6l+5w+ymIhGAgy?=
 =?us-ascii?Q?cKcUm021b9wbVSpjw6vNSnwftnpIkta51JWtWBW1u5lCpZvtzyLYvjVQu22b?=
 =?us-ascii?Q?ZyYfZ+A6oQOF5xATIABuy4eDM9P6ns+SzQcW3anGYdLo8arf2eI3/QvHq7db?=
 =?us-ascii?Q?hrsGN4mxHgDE+PmBf7Lv9gy6?=
X-OriginatorOrg: acuitybrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c119c42-a96f-4c6d-a141-08d8d293df82
X-MS-Exchange-CrossTenant-AuthSource: BN6PR0101MB2995.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 15:59:42.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/z2YzG9pvo+vFxDZ51gz99syrQJwE5hv+XXRD/zzNr9v+O1D4LPV4ICmLKXij98O4GGsViegEu397mkeaSp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5476
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=641
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDs of nLight Air Adapter, Acuity Brands, Inc.:
vid: 10c4
pid: 88d8

Signed-off-by: Karan Singhal <karan.singhal@acuitybrands.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..b82bb130710d 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -146,6 +146,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
 	{ USB_DEVICE(0x10C4, 0x88A5) }, /* Planet Innovation Ingeni ZigBee USB Device */
+	{ USB_DEVICE(0x10C4, 0x88D8) }, /* Acuity Brands nLight Air Adapter */
 	{ USB_DEVICE(0x10C4, 0x88FB) }, /* CESINEL MEDCAL STII Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x8938) }, /* CESINEL MEDCAL S II Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x8946) }, /* Ketra N1 Wireless Interface */
-- 
2.17.1

