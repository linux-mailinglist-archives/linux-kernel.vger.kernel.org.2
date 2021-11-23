Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1245A3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhKWNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:41:17 -0500
Received: from mail-psaapc01hn2216.outbound.protection.outlook.com ([52.100.0.216]:41056
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233815AbhKWNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:41:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLZ4ZWo0CEsgFx7HP2zKBXa2ud+8fB3tEdbzppZYcrt6PIqddmjLO+xuMmE9jOyjeF6K2IGpBu5OlgheE8hsdgml45A++bvPgk1G8Vd4v+UFwyy/VvvsPHNvf9zxORxz06Hp1SwMoJYU1VArLnFBkh9BJOaznqjXjiIY8L0RzI4EQA8w9p92ptGhaFpbzWBmW7jXk5YSazgW233TsfwMUADwQMTrVqCD/kgT+qDa9sxGBFKp98Pb0OnYtS58zvG0qSriZyawyDVqDHc0MJitL/o1QPI4gsuQQZ4UXJFU+fZwZ3asNymQDCwtIRpBLFP2i1+jym7K0jdRlPqEvxcOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGQKLD8INIJ+tWOJIACzg74npVh0uGxA6mmtUGixmSs=;
 b=UCojuPVRKUCtYeVxSCTcamF+pa9uipjkgY+JU9oBc9MphUOv/h9GCW6CECiE/8jMj0ReSsloGqZwl3tW2upG6yZoYTt13nDZzFvy9bbZIUwRa1Dfw3Zrp3zTW3EHksSK5YjAHEiY4E02+c2DnbnZtn7cAONMTHZvcU/7fbujK2gmEEuAx7W23GaekgrLKBA5b/CoboW8F31WwFdbs5kKT+gRc08ZALpqF8G3E59OGN88XQ9vUd9qwpeMV6CzistCEhzUEp2m1Rw90Sn+Gyfn0ZpqtI1Si4Iekg7KHOF/p0rnyivbeYH/eDkHeYbWGkz40Ajqh/TW3sdw4Am9IGRYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGQKLD8INIJ+tWOJIACzg74npVh0uGxA6mmtUGixmSs=;
 b=r44bshuAwdiHSxczY5zz39lEiBQtVxJ9cn3fvGIL0AlVc1S1+bmUdvC77RGz37GSnswABbjs9yGS5SmW2+i3j3MA3HLQHVWLO5nMDhGL5QGkIsUr7xsfuXffyZ9D82mqJuLiPtpusEJnt86zlIYxt6mIQuNsZMSaDjPS9zwonuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com (2603:1096:203:7e::13)
 by HK0PR02MB3153.apcprd02.prod.outlook.com (2603:1096:203:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 13:38:01 +0000
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397]) by HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 13:38:01 +0000
From:   Mingjie Zhang <superzmj@fibocom.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingjie Zhang <superzmj@fibocom.com>
Subject: [PATCH v3] USB: serial: option: add Fibocom FM101-GL variants
Date:   Tue, 23 Nov 2021 21:37:57 +0800
Message-Id: <20211123133757.37475-1-superzmj@fibocom.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To HK0PR02MB3379.apcprd02.prod.outlook.com
 (2603:1096:203:7e::13)
MIME-Version: 1.0
Received: from localhost (124.89.89.114) by HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.8 via Frontend Transport; Tue, 23 Nov 2021 13:38:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923cd906-3f29-40bb-6381-08d9ae8677cb
X-MS-TrafficTypeDiagnostic: HK0PR02MB3153:
X-Microsoft-Antispam-PRVS: <HK0PR02MB3153888EF63FDF0472A7538BCA609@HK0PR02MB3153.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YO3va9OUSwUv0ISxav3YmqynOry+7tlYdb+4rQLyfGN8Atr5oilvztcEY0M0?=
 =?us-ascii?Q?SWWTWX/V8qOYVXpurIuE4tM0g9i3Ktn/UNsp80U4zWi5iIjWI7m1Cmh780DE?=
 =?us-ascii?Q?W/mPgb+I7fOkrXkyMoeXFOpGIIBtTkKA2DVhNyxyrujgXdHpq4FlyO/XYNH0?=
 =?us-ascii?Q?KktJaDY0kGvIiIYxtLZ7lhXuJzSosNYRA7143adTsiPS0BpO9tu88eTE1A4A?=
 =?us-ascii?Q?o743WzUsTyuG0YcyZKn+TH3arBDJqmYQY9nptw97Xng3dwda/97Z+iKvSr9G?=
 =?us-ascii?Q?Dvin+iv6LuUh35QGBxuRn398mHZCs8gTpAo5bTCmJKEehY515A3WSsCFeO0C?=
 =?us-ascii?Q?sZOlizcGAfjkWCGYclsYZgx3VjhtNXwQeOmZFCJ8o+2LrBeodUwFSSP23VND?=
 =?us-ascii?Q?a9wI68tuxuhCWLnJH3kijsx4Xf3aixY6yz23qY2SFsEjVX0C+SHnsd28HfYd?=
 =?us-ascii?Q?dpajgOeGAX2QtLgCBZ/KLWiP0J2723xtvCUCnrFfp5loEgXRbCnxj/16C/3m?=
 =?us-ascii?Q?e6DloZzK7bwaWhy/kGs5NC6z3uSB3EWnaMn1hfJk8H9+MED45uukfpx3czaP?=
 =?us-ascii?Q?+fv2cJVi5XzvjMdZq/PsQrWEmiU9L8vdtULh5/ppif2xRDegdtw+uF1PFQle?=
 =?us-ascii?Q?7iZTtyMKkSPzdTbFRtDYEsQh55h3s0jY6hdylfTcPsq1jMtH9lJ1PjhyZZwT?=
 =?us-ascii?Q?qBY5hp0qKE7oSVv2XrIOO45S3UyOrSI3fuwkw5jG4nP3rGYfO0lwMBsFSG/3?=
 =?us-ascii?Q?SgC/oV/Rv0/q9Uo/uNKhU6GpEwbyYGBKQb7gvabXrZlIDXDyr7DjbqybQnFQ?=
 =?us-ascii?Q?gPDmymY+PGCTPoRIaE0dN/Iwn9Kb7B5ZIJwHs9PKv+S+dKNdaN63CGc2HYP5?=
 =?us-ascii?Q?SmDmmbJAg8nZfDFaFJNvlN8oyrdxpnlTuKyqWwl1XiBYTfuyxwvokeCVL0xR?=
 =?us-ascii?Q?WUwHMJv+cBe+JNh4pTRqvW+wfGvMiHd3DogmuU8ZsNJcwBLZ9PRCsZPfn1aU?=
 =?us-ascii?Q?o9ddqlITimpDg+6+sTugkXbtGDGz9phdr3M+V2yFU8bSKY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:HK0PR02MB3379.apcprd02.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(26005)(956004)(8676002)(38100700002)(2616005)(38350700002)(2906002)(107886003)(6666004)(316002)(36756003)(186003)(66476007)(66556008)(66946007)(6486002)(52116002)(86362001)(4326008)(1076003)(6916009)(8936002)(30864003)(6496006)(5660300002)(83380400001)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFD4RH+xO594/xIDMWd265eVMI5fu6f8aR55Am7GKGnXKSnSNO/e3cAgIXBy?=
 =?us-ascii?Q?aGcf5zAzJfuX+CyEX2rMONtf9g7kp9phXxb9a5OdBBi+uwKFmaJ3Tm70vr2X?=
 =?us-ascii?Q?JXGg6rZvSHyDiJYW2aVePMEpV1Ov5wSSkQQvTFY2S8m8EAqxyz5Wqj2H1C1k?=
 =?us-ascii?Q?mR4xScIH9i2wWiEufoSXmX92VSc1CFfnw7NWc/JX8F1qsGMDdDqqqu3kM+ML?=
 =?us-ascii?Q?9g6zaTZHGpZjYU3aLWoJGwPnbfkd71wkJ7UGybRB1zaVTLGAo97qZeuYGEm6?=
 =?us-ascii?Q?i1giUs6PJh25/vAmmRp4iQUs71szCSrJE4axIziPE7xuCPmVYgVgOWUIEu01?=
 =?us-ascii?Q?RUGwgS5duXijiiYDAe03wUysHjrt5v1Zhw5uZ+lq4xDZc9ULEQnAe6PExsre?=
 =?us-ascii?Q?dkjbFb9EfX4mTeM/7CVxLzT96j83pMpk9d0UUeD4XukVILsi45E55wDRAbqK?=
 =?us-ascii?Q?nYf63MG+W/XExqr7HXBqxyoszagMiFdnmGvUXxaZHZLGJgWHz5JDMIP9cnXb?=
 =?us-ascii?Q?wPZlFZLFUnPGHVBUKUjB/oKSZqIrBqgKuEpwETKkCJqll7Ajk+e/M+fkhHuu?=
 =?us-ascii?Q?j8+b+NTqafuN5ahZuCotkiuPYP8VHYRTRCf8ZLOlcnC8scw+wziJJMC1J3S8?=
 =?us-ascii?Q?4yxTe1tSrZX7Kc6fQePmgrnfcd24cK7gAHT5Y9T3WyzJ3JQmJA3vZwKNFieE?=
 =?us-ascii?Q?mu4Xs5t9H0K2TCB/A6g+gCp4UWv7Dn97RpV5UV5P0nq/JVLKcWcJhMobvJ2P?=
 =?us-ascii?Q?8pJE3CmyI8/KaSou93lsH4CeofLZvBXOGmEoVkklkfkzB85gSnxP7/rKrSuS?=
 =?us-ascii?Q?g6BmBnysAegQrPxbPNd123oQlPLVarF8HN8nMCcsjFsaF9rgSZ50szOva05e?=
 =?us-ascii?Q?BgiQREtYq7j+y6nX6SH8RCVUMf/6snLMpzdqs78TjBuieGKAu1DauNCI2qAZ?=
 =?us-ascii?Q?bAHyCJXr1w2tKZ70507AYSuBOD8WyN1euDl0Ag0UJEGCE9bQ3vXsTBxb3bEs?=
 =?us-ascii?Q?lac5FUczDBIHApN58M/U8p/Jz0np8Z2GQAqJuNUt8nboVL6SPc73Uz3nA7Un?=
 =?us-ascii?Q?hc7NSxeVDvEF2b8ygow02afEgNcA+qTtzDQeNOA4gjFv7MGPhMbEVUCKwUdo?=
 =?us-ascii?Q?CESsdECi1XDgeX2sYUOIxKM0rRl8l04ECwyK3Bfh1eGmawhes9B/wimXdOvv?=
 =?us-ascii?Q?rbaQcno3oZbGnNG07PkMjBE8oZGFMjGFG8UqnvlAbTkd9yIn8eAJPLHtsDjr?=
 =?us-ascii?Q?7FKCUKZ5ZXfhAmuNAnArbMJ/0SdEvzSOQnoJwF9pT8ygb/2XvWsDUP5w6aep?=
 =?us-ascii?Q?uE3NQEU1WwiULDu/oDQ6ObFY9DQQXpNWHknArlHQdWApzg+dC/sAWE5md+zN?=
 =?us-ascii?Q?WUSo4PDWA4gg81tECGsgpo37Da/vw4LW7tmoqbaDSoEZQ0SEvlDYGDas0dPA?=
 =?us-ascii?Q?3Qsjyn6atKjbp7IGd5Z7HLPRe7F+BPd5Q5yoxBQYohrhBk8usBw9F2GsirCQ?=
 =?us-ascii?Q?Wf+p+M0vb097xaBA0DnkudlAtN+ukalWOqo7OaDqwTEGir99RI4+WrrbDemT?=
 =?us-ascii?Q?xZ33/XEiG0gJlYXkpmLcH8UcL5SajDPjwp9iDusVkOBXElBF5BMDMCXFDuwq?=
 =?us-ascii?Q?HLEd0gzFeiwaY/yRsDPXIH0=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923cd906-3f29-40bb-6381-08d9ae8677cb
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 13:38:01.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRwYXTtC+RNyCvo4isGQXV4pjoPdDGk88IQHuxM0W5sIOgfjXdHN13YfYAB+jhrtu7g3O8TSfffw3KmmBQihnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the USB serial option driver support for the Fibocom
FM101-GL Cat.6
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
  MBIM interfaces for /Linux/Chrome OS)
- VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(with adb
  interface for /Linux/Chrome OS)

0x01a2: mbim, tty, tty, diag, gnss
0x01a4: mbim, diag, tty, adb, gnss, gnss

Here are the outputs of lsusb -v and usb-devices:

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#= 86 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=673326ce
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

Bus 002 Device 084: ID 2cb7:01a2 Fibocom Wireless Inc. Fibocom FM101-GL Module
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.20
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x2cb7
  idProduct          0x01a2
  bcdDevice            5.04
  iManufacturer           1 Fibocom Wireless Inc.
  iProduct                2 Fibocom FM101-GL Module
  iSerial                 3 673326ce
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x015d
    bNumInterfaces          6
    bConfigurationValue     1
    iConfiguration          4 MBIM_DUN_DUN_DIAG_NMEA
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              896mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2 Communications
      bFunctionSubClass      14
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass     14
      bInterfaceProtocol      0
      iInterface              5 Fibocom FM101-GL LTE Modem
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1
      CDC MBIM:
        bcdMBIMVersion       1.00
        wMaxControlMessage   4096
        bNumberFilters       32
        bMaxFilterSize       128
        wMaxSegmentSize      2048
        bmNetworkCapabilities 0x20
          8-byte ntb input size
      CDC MBIM Extended:
        bcdMBIMExtendedVersion           1.00
        bMaxOutstandingCommandMessages     64
        wMTU                             1500
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               9
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0
      bInterfaceProtocol      2
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0
      bInterfaceProtocol      2
      iInterface              6 MBIM Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               6
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0f  EP 15 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               2
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     48
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#= 85 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a4 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=673326ce
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

Bus 002 Device 085: ID 2cb7:01a4 Fibocom Wireless Inc. Fibocom FM101-GL Module
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.20
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x2cb7
  idProduct          0x01a4
  bcdDevice            5.04
  iManufacturer           1 Fibocom Wireless Inc.
  iProduct                2 Fibocom FM101-GL Module
  iSerial                 3 673326ce
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0180
    bNumInterfaces          7
    bConfigurationValue     1
    iConfiguration          4 MBIM_DIAG_DUN_ADB_GNSS_GNSS
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              896mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2 Communications
      bFunctionSubClass      14
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass     14
      bInterfaceProtocol      0
      iInterface              5 Fibocom FM101-GL LTE Modem
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1
      CDC MBIM:
        bcdMBIMVersion       1.00
        wMaxControlMessage   4096
        bNumberFilters       32
        bMaxFilterSize       128
        wMaxSegmentSize      2048
        bmNetworkCapabilities 0x20
          8-byte ntb input size
      CDC MBIM Extended:
        bcdMBIMExtendedVersion           1.00
        bMaxOutstandingCommandMessages     64
        wMTU                             1500
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               9
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0
      bInterfaceProtocol      2
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0
      bInterfaceProtocol      2
      iInterface              6 MBIM Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               6
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0f  EP 15 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               2
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     48
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass     66
      bInterfaceProtocol      1
      iInterface              8 ADB Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol     64
      iInterface              0
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0

Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
---
Changes in v3:
  - Add the usb device infomation
  - Make the entry in sort order (VID,PID)

Changes in v2:
  - Add the description of the corresponding interface
  - Blacklist the adb interface
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..4858a28388c1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2077,6 +2077,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
-- 
2.25.1

