Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB004458BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhKVKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:03:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61582 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhKVKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637575217; x=1669111217;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bLMEIH0glh/IFDOumUI8zgRN8rrwdS/T1Ry4cPqarO4=;
  b=McosBCPN9KqBdgj4Y/+tfYYlN2x58MCxFTNLPSynIULyFPSwFrsDwPn+
   Soz/OlFh2W3wsyxbhPO9mK2gaQhODQm64tAhWMDh0+6eMJV3w+EjN2Db8
   pf4t0QR/AS6VCnjGDEjkqFevSACIKormR5IkywD/35dROx1CPZIzrcJzX
   R5TWLN0UoEMQOE+R4glGRwihgyuyfGCRhyeTL8q2SJk/JbTZY4JViaDnZ
   c+f0+OxRCgyGFQOejgLSj4EJQkkEuZuENDsutcsAlcXrIoxsagpMa30J+
   UIu0Yii4PEJmQ5bJZkn/tjrUNx7Em1dCz1beTVRhYc5j9aup9JNOpof7o
   g==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631548800"; 
   d="scan'208";a="185290435"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2021 18:00:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmeJ4Dsvu+dqQ23v6f8PCtxtySiBAgqKkq40xqtBpw2oxMHvN3IfNEMRNo+xueWrNu2EKD3zOyMqYy3qqNMBZwwOR6EPxYuVifAiQ/at/bHOuOOXEpfwiAxsKLZmsuY4JaWiTyOQ95Vzb8mFlERGLLM8BM5MP6rq/pJz+troJv1GvMDDTi6hPUmTCFDGQsK4b2OoJL0ckH9kXotNKt2U+EkU/zUO0TT/9r3nZ99+kSdGs1ny1fYY2dMa8oAbuIPB3iwWP1feS62heeYSMfFGFEfGAFbbn9QJEBPc5h/Qqi2mN2l5GbJWEMLeyxMxgMf8BYVYRYGKXvZX3b2XZNywKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v01hXn3+0bogwQfFwgP71vykCRB/43LEqi42B/Zzk+8=;
 b=IFiscTGGoGdzSqm8oQnrpRpXEkhoe0jlKVnxpWFILhafI8VC92pTWdy8Z6Y9a9vEQTt6kt+g7nIIGVe9YwjBonRMjIXADDOAf8GYRFfx0ibeNWPUrDo37OyCLUZpjk58qL1OmKFl9uUyrwnXTXciojtB+/NnMcileEJ9yXo3eq942RY3Xshux3g8KcZvIuxZPtAPC74JYSPmO5s2d0Hwp5wT7aRWtkkAgyBiMOhB9RdHwYy/ndOazx8gTVVExhpZlZvwLkdFid8bi/sLsyBQ7CdlRTNKw2TYI0ANlCfpdPZDfkmddAHWMPqvC2aIUJngx0U64veY++DqE14QmZjjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v01hXn3+0bogwQfFwgP71vykCRB/43LEqi42B/Zzk+8=;
 b=GFmJKF/m/jtiw7zVmcUPMSQ/z+DovGbMAXTxwXui/dLj3cl7UEaXt+JblfHXu/EsYHI90GF0OTlYsP1jbqX1MhGYNrQDK17mygDWMcSlWmn6h3b0+pHKkBXRtdHEuG/oCpK420aFIw70x7BcIFnAUuhllQ0CJnyV6FoFjD1aKKw=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7384.namprd04.prod.outlook.com (2603:10b6:510:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 10:00:14 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca%4]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 10:00:14 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ning Sun <ning.sun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "tboot-devel@lists.sourceforge.net" 
        <tboot-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH] docs: x86: remove vendor specific kernel parameter from
 example
Thread-Topic: [PATCH] docs: x86: remove vendor specific kernel parameter from
 example
Thread-Index: AQHX34e+skOLGRYy/kat5GasLxKkYA==
Date:   Mon, 22 Nov 2021 10:00:14 +0000
Message-ID: <20211122095947.10515-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.33.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a106b31-2026-4e37-721c-08d9ad9ee14f
x-ms-traffictypediagnostic: PH0PR04MB7384:
x-microsoft-antispam-prvs: <PH0PR04MB73844C58774CF0FAEE001D93F29F9@PH0PR04MB7384.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QeSmhmByqZqeMmeaCnPWg8OwVuEAWe3nszwFh/UPqW7b3pyoK+XmHjjuHwEHP780a/VWG5fhWi4u4JHMkOryBv2pvDdt10XctI+itTJiyzkmcOOA870Py4dD2DecMQipL2BAEu/aoKyvMvEWdGTZmLXEu/KfadoDO9VmQz2zTCBapGcjK09+qxoBUW94LBi/P59lJmW8127d/QxVTF8CQBKkTctQkx69V+T3KXX1Z6W4CN9qJoZySUaIGgBhAZuCgMpY+USCOJqFQPy5WXpeQwukk3Lxl4a8k6rw3SHkMjDX6kdvb5moEbIOPwIgY0mbledaNtm7EFAJYn6s4nEopGsYMPU1vH18zapErf+VPqjtsovCqQxy1bcmtUK2RnfItEQvOzif9wf02VbM1tFat1fx7EUJ5IEvQGE23gGCzRArl7cufNfGku9oLLbIBzreSfFjvL/1/VXE1RhCugcBs05nLUJIRE9Sz7+NhDx9egXwPiRWoPW2AJBb2Bc4Ma+1y3XCHrH6fxYF5cauXDsQA5DX4FPJvDduYZwCkSRVSg3nJT57WDgRQNtx4OcKOypaHHIzFK1mGEO+9XG63L4ATd7ShUNlaTUPnOZv4v15LfHg0/8POnLTBPJ2Nc+NtPlZbJkREs7DVQhcxgjv9qFX/wo0/sP+bBZtf06zgHleQBLR+g+a11HM2q8W1LqI6QlQG78bHL9GV/0tPv78z8jT8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(4744005)(71200400001)(66476007)(86362001)(2616005)(8676002)(8936002)(76116006)(186003)(82960400001)(6512007)(6506007)(2906002)(54906003)(38100700002)(66556008)(66446008)(110136005)(122000001)(64756008)(38070700005)(91956017)(7416002)(83380400001)(36756003)(26005)(316002)(5660300002)(4326008)(508600001)(66946007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IIpawc7ywvNemqo5+S8cLITi+hg8BQv5dcBybdkDEP6Ppzlphi8nO06ctD?=
 =?iso-8859-1?Q?r9fGp0bKqkMcHLsPgL68dXShKhSAljpxM9eKII/lpHCNFhiedyTNFRax1F?=
 =?iso-8859-1?Q?P9l5uTtnk1sp96JUYhFZFqyeacEOJid3+nEs6yEkMD03KSXr0MbMkCIL/e?=
 =?iso-8859-1?Q?kb2vl9IlmXmGcbbEqL8LSuImiB1uN1yl9t09qXEv5ueor5RIuun2V0PCMJ?=
 =?iso-8859-1?Q?qHUxz3IxCwJ0e6PbncbzizkhkjSiKGlWkEDWWMuxwAjXsNZDv1b1bZ8/ry?=
 =?iso-8859-1?Q?0BpxTHnUpIgH+N4NV/HoUVweUXsuSyYTuLUKOveR60kouvito/BUBTQnRa?=
 =?iso-8859-1?Q?uHgVGOM8pEcUCLotog2iVkRZ0a/sXF1orIx483AP2SG3DsRHiQ0Iv5yNHg?=
 =?iso-8859-1?Q?G6u2MbEkrHIwJExgRNs2x11kdMHdhVVWw3EZhQRxny8iWmvBDbwlg18e65?=
 =?iso-8859-1?Q?dso5VPoA0iVBCEck+uWDGLRWTo6892XYxaZ7ibSaPG0TDakZsV5tm1k1wZ?=
 =?iso-8859-1?Q?zA03r6nOEukhc6AExDSHlxzbulEypY6UMKGlFFMl7mDaHNO27r2gTKlezY?=
 =?iso-8859-1?Q?oOsjJ3ID07Sh10VYF+0NW6PQwGKt5NNWVfjSegUXMn08EITY1WnPTqWyOT?=
 =?iso-8859-1?Q?2SEzB/4BfS6tBMhViw5ay8eXDq2FtpXhXgM8wMAxJy7ZTzT4iSJG8B/93m?=
 =?iso-8859-1?Q?YKBtdA6a2b6qHu4hYXOAPvmlBgfXheeIq5tKjLB1yNCysyGNqpHLQLIxkz?=
 =?iso-8859-1?Q?XoPuBn0RBD9hSgdqpPfEGHZv2/KTgSn6Y/KpZHxa1Hr6I63Hfjv19d7nSL?=
 =?iso-8859-1?Q?ruLidw9jBIkQDSUPzm29xbF8ZkQDFC8IMoT66+PVaKH4No2GoudPbF9gXw?=
 =?iso-8859-1?Q?HiAumHvZk+4bteolMlMxcU3AnSzkxkwnw5dWo310vWhfn4FHJhhdEMfFMg?=
 =?iso-8859-1?Q?zE9K+gHC76hJl9YzDXchOK7T4YVpS2aHgdJzoWjCe95xPJZh6dkf+pbwE4?=
 =?iso-8859-1?Q?KQCCHxkssiW+aLG7WfB1AoGb77zIPZ+FY4Npk4ldtx0UsgOMjBgARfssvw?=
 =?iso-8859-1?Q?NpTPD+n7SFpkZ999mp1BaB705cU4m5LziHfyuOsf4qR40YeqEfnXbNWVOr?=
 =?iso-8859-1?Q?40Uxa9ZLWCRqUM6rqP3aHF0uyoCa0Mx0hqKn+kRaQYzoHlF/+9JwhpqVY+?=
 =?iso-8859-1?Q?NuaSBQYosApBSA9RftlUSDMr1Qbjxi4mQ6LaWb9Nucx2OJmTbcSbH9wcg9?=
 =?iso-8859-1?Q?5EqJoq47f2HT70wvCJF97vi9tb3DDb+EnHdKaBohPfJB1VqLBOUU6z0Cd1?=
 =?iso-8859-1?Q?xacSBZLL7GWMAJuHZAUPIxu1N+K62qfPzowMFldqVhMSvMb2hm3ijkZL6m?=
 =?iso-8859-1?Q?6O66Pz6IzAQy0rNY7JeI/esmQRk0k14P3zC5NohsPdRsVxRUGXWRcQw/nc?=
 =?iso-8859-1?Q?Ogcc26Q9eoCv0cc9pRIx+BCzCagI4luD4pdVfIHHL3N0LWwsBMMzX17plC?=
 =?iso-8859-1?Q?pZf+4fk5bOWFbpgl7kzbxMAsMNZr/rHBXJczis5NE/vwSV7UBhJL6H/+3b?=
 =?iso-8859-1?Q?D4QTT9BE4qojUiqvJXGsaXOQOfaAmig1kc1mW2zDz0Q1cjjAQiqvH69Eht?=
 =?iso-8859-1?Q?JGMUleKlOoUYbyp+a2jhTr+xgl4HRF+2v8oBsbHYkweDBXghcr1Mbpm6HV?=
 =?iso-8859-1?Q?kKVH+ZjlgiTvomEfB5w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a106b31-2026-4e37-721c-08d9ad9ee14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 10:00:14.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7gvM8QC02zMzkm7glBPgbboHcweTQ7+evu1wYYvqo6XeKEdMgP7sWIjEJhASvXW1l1sVYoGLQtHFlvtTc3CXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

rhgb stands for red hat graphical boot.
This is a kernel parameter which only exists in downstream kernels.

There is no reason to include a vendor specific kernel parameter in
the example, so let's remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 Documentation/x86/intel_txt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/intel_txt.rst b/Documentation/x86/intel_txt.=
rst
index d83c1a2122c9..a5ddc84fe6c6 100644
--- a/Documentation/x86/intel_txt.rst
+++ b/Documentation/x86/intel_txt.rst
@@ -203,7 +203,7 @@ grub.conf needs to be modified as follows::
           root (hd0,0)
                 kernel /tboot.gz logging=3Dserial,vga,memory
                 module /vmlinuz-2.6.29-tip intel_iommu=3Don ro
-                       root=3DLABEL=3D/ rhgb console=3DttyS0,115200 3
+                       root=3DLABEL=3D/ console=3DttyS0,115200 3
                 module /initrd-2.6.29-tip.img
                 module /Q35_SINIT_17.BIN
=20
--=20
2.33.1
