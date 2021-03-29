Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2C34C174
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhC2Bxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:53:49 -0400
Received: from mail-dm6nam10on2121.outbound.protection.outlook.com ([40.107.93.121]:45696
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230305AbhC2BxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar7gtVm439ZOFYG4AlzDZwgz2yZM6R3rKxP3upI/Wmy4LKDtCbXvC1a5VLLeikeLjy/knRR/pB7ENSTLOklxJB4Q/2C4MzSfiErUV6pvSTxA0XCh5Y5AeUlohq/PyJ+iiv2U1XdiS2FHR5HQ4FZsRMOKC1xrsq9ZaWZMNijQtpijaYSoQ8OKzPCIZUaooUBUAm9WrBKT0Fq6xBSc+mj0iYaI2AXfUBheObIS2tKc6SnsIumsd90KZTrJew1HSx24USBZcyEVRQ4OsY+qPYuIlw4yCxIgwyYu5qXizrHTDK2cSPO5p9gN+WR1PCMXlt7APwj/9ny6sZo6Jb+kroCHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eodGl7BL60haiZ5EXZxadmdlrqwUuH8up12unpZpjxg=;
 b=NN9PUmG9YyBB/PDlGFXtvYXR9W1KFS5zpC4e7xMmIXFudw1na9dbkFMolMqW6S8rYSPrTI1jwBkK9sbWp2Q6cbgXlcSMjzq5oPbEOoZZYc8+4oTO2a0OMCXSewAno/OIS6ded6YK4LuCKn+x6ppD79pTpuDMUieKXkfp23A1yIU41UsUx9XL+T5xca3xYu4YPFAIGhhbIhWNCIwwpGi8UMDfRFId6xtbvBxLMMBfwoUdc1BEWv6/MF2OvKyHlFGdopt7/V/5LqS4xDH016upoT77QcjjFruR9VnHDGCN3ul5Vy214WTqesllE1Pi53mEZ03JTw4Tb71C4d18vw9UpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eodGl7BL60haiZ5EXZxadmdlrqwUuH8up12unpZpjxg=;
 b=tivs5CsAXWcYyVF2HqS9ZpC0fjlowYsCCx5MPosCE3vJjyTfIDy1VsSLA4Zwk2nN04nVhZiXNR6y6huXfm92XRu3OzTQKrlvgI54C+HzXyb2Lj1MGfF+J+V1Z2NRSj3Reqv933S6vWTi7B8tHQWHJlkVAcYGTD/VnmZeGQlut+U=
Authentication-Results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MW4PR01MB6226.prod.exchangelabs.com (2603:10b6:303:77::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 01:53:13 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d840:7aa7:58d4:b503]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d840:7aa7:58d4:b503%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 01:53:13 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v2 0/4] Add Ampere's Altra SMPro hwmon driver
Date:   Mon, 29 Mar 2021 08:52:34 +0700
Message-Id: <20210329015238.19474-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [118.69.219.201]
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To MW2PR0102MB3482.prod.exchangelabs.com
 (2603:10b6:302:c::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hcm-sw-17.amperecomputing.com (118.69.219.201) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Mon, 29 Mar 2021 01:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71702f2e-e485-4360-8637-08d8f255696b
X-MS-TrafficTypeDiagnostic: MW4PR01MB6226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB622685C0003A62F49822C27CF27E9@MW4PR01MB6226.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9PdK+pvJFY34PwjkT78YsWJHyxF0395caCLGhzcr3ytI0LwhDON3vNG2OLjwZsWmo+3QQTa3bIafz9mE/q8DPcnpB0YXr5BZsHNFSJMqPyr00OnklCEn7bwghM9jE2hv56mUuegBKKTI+pXDrhbb7QK6VP9FSm6rHlIbF8r/FNn8iZos0IqyeMCG9cGz3gO9njvVAI6v5pBkj1ZMqrBJTnAM2dChUhqeOWisxdYJj+dCxfogHBxVxAJSAgxm030o8LTCfmPPEILfP9PeH019gYBB2kIOxY6GMm3FkcrQWwSYdadO3sYDwmtBR8/6yJPrM/SCjxBoOUQaj5CMzlisTP+R2ZDPQ5HuY22otoUEPxe4igBc/A+ysZvfaRRLMCVHqKg4sGBqpUiMrlw9dBwtxUutcy0ZkrDEtq9ujpprEe5cB+8d4kX8dRByLmASrd2LjCJGBfg2zv91NDR0fmIanr+/Jcq1OKK2iQGVtKklwc0yIimWOQ0St2efLfBcVlmLcWXSD9TGf9wL6jdiELl24BQL9KB3cGjzuEWbSpKsj8sxHudhcaUCP4gGwSS9MZ8yjhv5L2ToRqVRbQCG34279yL+R1gnFgYNv3l/Ru6LfH5knBya4E6OviDFGGzRZP4+fja88LwwCoJ4e7z9sIqfebdxn5x/SG9AyYrmRpLLhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39830400003)(54906003)(6486002)(921005)(7416002)(52116002)(86362001)(6666004)(4326008)(66946007)(316002)(2906002)(8936002)(2616005)(478600001)(26005)(6506007)(66476007)(1076003)(16526019)(186003)(66556008)(107886003)(83380400001)(110136005)(8676002)(6512007)(38100700001)(5660300002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?huTFATCnsk/CT0JsfyFwZiKbeOS3wQ1IuSAWB2VXnWhrG7zbSU/2V+pwdVh5?=
 =?us-ascii?Q?CX1/svZm1cXk6WNLfpwKVAoKkQdYwJLf4pSN3c60qNJ4EWIf2FikvWzk/9mN?=
 =?us-ascii?Q?jIfOOnyoNS8eGWHEOBErCx2F6Lz0Y+HrhM6P6Wd7LGKS5PU/wkJxANCFHpf+?=
 =?us-ascii?Q?F9A64bhjH+jehinsx8exzEWDsQe9+B2My4FPwrzS2iBhHHpZK24hSXo9R4i7?=
 =?us-ascii?Q?ExuzFkqSpYBq8DAu0SDS9PPqYikcxphXyegjdkonUnubO1WSzj9CYKbZ8RUW?=
 =?us-ascii?Q?R9oQsP/CIKRWTRCB/2sO1epUZSqrdXo9dzlQUWVYA8VkmapcXZ6IXhww0c0B?=
 =?us-ascii?Q?HL+EAznVDAMQpBRTutSnns0VJf0s6Rh7sGeE/Kn9OZWEpErvi2PrCuggJgSa?=
 =?us-ascii?Q?QPg9p9X7zG3uuFagH+LPBqOl1r0Mjg4OGKVRWameoDdg3+AUk0jEf/MjLHym?=
 =?us-ascii?Q?qpyTel+XxIp6msMJZnwGQVL4r8NLy46q8Ll9QwchQjsawE6Ois5DvijU3FvB?=
 =?us-ascii?Q?zdCYFYjM64KeBrxI0KZLvoXJm9jjm4XDZNXA7d7vdpeYlsN7xZ9lqhDA0RTg?=
 =?us-ascii?Q?K+1QHuf7oIrOPS517M3JCJ0svbzwKB9rFFhGcMumwa8sXnNGAin73yPwb+ms?=
 =?us-ascii?Q?idAdoreMkR1FCiSoncTdJXwCqW7ksPuhDeH11pJlMMxb7bbN02wmSksvSKAT?=
 =?us-ascii?Q?Jlb5ka8CyNsNvFbGrLhMSUV4HH9WuBsmAuXllG9ELNPBziRIY97SnyIS8FzG?=
 =?us-ascii?Q?wO3jrXrdx2m9L5VnkdbJFkp+n1nyT8QiREP1sf6hd7cxwIQDfHDbmhpYA4nt?=
 =?us-ascii?Q?9Yly/1UK/BPm7mrpefTR6oVrpluA+CI8MB827s79uDhbddauC4wrg5mU5wqA?=
 =?us-ascii?Q?FcpsOHSNlssdMcBLgcalUtSpEm6mOuGtDelHMHV1fnUburoaBaJHqrDfk2BL?=
 =?us-ascii?Q?i7bmZwjQk9WC1T9ibgyyCHlVbyKU2KFhoie6Rc1jObzGOjHUumJFWO27wpVQ?=
 =?us-ascii?Q?Sh+Er/VnQxi4IE/iAk9t0Z55YhbNtr7xiLZNv32SVxnBC8rf5U8eBXhAXvHO?=
 =?us-ascii?Q?41KgH03LGymVLFwq5iQi0/JMgcE5idnNXLcfqSG26sKijv0MB8mXZ5ssY1Y1?=
 =?us-ascii?Q?EhAPaVAoHYs8kXQSPebeHpfBg+iqLstxFYSATTxl1VqBDefcBwALXpmYdGs6?=
 =?us-ascii?Q?mogGaFNCqeazbbEDV+YgXK+//9PQ5TSRVQ4Hb4x3EDhkNTl+ZXca2Lnq7SsF?=
 =?us-ascii?Q?eCrAlYeBYDrezML98nX1PrlDEA/bt7VnTqhryksCls0kiOCCWVffcNwakWWM?=
 =?us-ascii?Q?j9/FIfiSjW2atJvfWhuXO5yZ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71702f2e-e485-4360-8637-08d8f255696b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 01:53:13.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5906qKen07cWkupIznP/w25wmqSvdSDPgBCKGxUXAaxenCn8uVAKeagR3OfNDXV/GsYQqQYxcXhHzFUe3wqlND5q3xXdRoGdDUOKFM20Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6226
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Ampere SMpro hwmon driver. This
driver supports accessing various CPU sensors provided by the SMpro
co-processor including temperature, power, voltages, and current found
on Ampere Altra processor family.

v2:
  + Used 'struct of_device_id's .data attribute [Lee Jones]
  + Removed "virtual" sensors [Guenter]
  + Fixed typo "mili" to "milli", "nanoWatt" to "microWatt" [Guenter]
  + Reported SOC_TDP as "Socket TDP" using max attributes [Guenter]
  + Clarified "highest" meaning in documentation [Guenter]
  + Corrected return error code when host is turn off [Guenter]
  + Reported MEM HOT Threshold for all DIMMs as temp*_crit [Guenter]
  + Removed license info as SPDX-License-Identifier existed [Guenter]
  + Added is_visible() support [Guenter]
  + Used HWMON_CHANNEL_INFO() macro and LABEL attributes [Guenter]
  + Made is_valid_id() return boolean [Guenter]
  + Returned -EPROBE_DEFER when smpro reg inaccessible [Guenter]
  + Removed unnecessary error message when dev register fail [Guenter]
  + Removed Socket TDP sensor [Quan]
  + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
  + Included sensor type and channel in labels [Quan]
  + Refactorized code to fix checkpatch.pl --strict complaint [Quan]

Quan Nguyen (4):
  dt-bindings: mfd: Add bindings for Ampere Altra SMPro drivers
  mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro support
  hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
  docs: hwmon: (smpro-hwmon) Add documentation

 .../bindings/hwmon/ampere,ac01-hwmon.yaml     |  27 +
 .../devicetree/bindings/mfd/ampere,smpro.yaml |  82 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/smpro-hwmon.rst           | 101 ++++
 drivers/hwmon/Kconfig                         |   8 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/smpro-hwmon.c                   | 494 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/simple-mfd-i2c.c                  |   6 +
 9 files changed, 730 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst
 create mode 100644 drivers/hwmon/smpro-hwmon.c

-- 
2.28.0

