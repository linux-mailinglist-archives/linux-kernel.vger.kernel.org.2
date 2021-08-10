Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893C73E5095
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhHJBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:19:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:21850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234504AbhHJBTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:19:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214843328"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="214843328"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 18:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="570626562"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2021 18:19:23 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 9 Aug 2021 18:19:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 9 Aug 2021 18:19:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 18:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh/2DOqI2mqOLX6yLAq5gCkC+9yLd9xRifC4BZdqNGxqTi1ICTMjAGQbdUqvB5hg+iPEPHIPBHZ6ed97FwkTQiIBLbkjHI8N5ISFGNz+Ky5sHcscflFmObiEX1W0DRo6LQgkn+sG19iV28girj3mgmXFkd5qYdl5w7ealLRbfa/GdbCozduS7cxN+ue6UDt0NrRCJn45Zr7mVam2mUSUGDY9Q0GarIQK+stMl/purFZdR/32Vtkiz2Zsaa3bCn7c0xAuubjrNbbUQdUvtlahBdcBmrK2F99VFUX1jEObcOP4xpcbenaefNDp+aSoRCYjvmdHLURR1QmwfpYg6H0HEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acs73Nyx5iZZjuDmr+wEsBPr0DfhDiDpOvFry1obR1w=;
 b=YbAm9euCtcV2M7JarmZSYlzUUs8j9T4mBA2j5deHnYoqBMhJaOUCti1xDWNfI+Tj1MYdE4QikRjVuWDnaC225snMhP+6wtkdflfa2MoMbbacENvD3B3B+2MHUGawgIO5Ftw3JQtKiDGi5Y4GmmxKkvHWR2i60SbwS/qukbuaxlryys399+2RmBRZ89f9qxSKdbanQhXCszgX0ytY82U1EY7pCF7k4yUcDmZoLNs5MzwuE6CkJ5YdpDfRLH3sFEnEauI5Y97UDuukH5jBVMZ7pg4uJoqZH61FJDcby+h0jlnRiJyG6EZl84BIyCLRFalfmwOC0sQyOihdddXu3uX7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acs73Nyx5iZZjuDmr+wEsBPr0DfhDiDpOvFry1obR1w=;
 b=YmYNfuXcY5FMRXXbZHs5pXgJmn3XiV//BEdT+/GbqFvHHtp7Sm+MV0Cqd9XHnSN5RpwltH3w+c8tm+9ttDXuoY9tQgv7tmMNwNghtQemk5Uf8cnJEHO01zG9yL12hDgwwu3F243Air9yXHXiBmIZTOWHjFCOxBDzOwru99xVQ6g=
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 01:19:21 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6167:48e3:2224:34f0]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6167:48e3:2224:34f0%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 01:19:20 +0000
From:   "Mi, Dapeng1" <dapeng1.mi@intel.com>
To:     David Stevens <stevensd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Subject: RE: [PATCH v2 3/9] dma-iommu: bounce buffers for untrusted devices
Thread-Topic: [PATCH v2 3/9] dma-iommu: bounce buffers for untrusted devices
Thread-Index: AQHXiq7FHkuycoFz8kmla4X1afl8DKtr8YEA
Date:   Tue, 10 Aug 2021 01:19:20 +0000
Message-ID: <PH0PR11MB48241565DC7BF06AD01301D3CDF79@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20210806103423.3341285-1-stevensd@google.com>
 <20210806103423.3341285-4-stevensd@google.com>
In-Reply-To: <20210806103423.3341285-4-stevensd@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf9f05f7-f4c6-4e01-2a1e-08d95b9ce1aa
x-ms-traffictypediagnostic: PH0PR11MB4840:
x-microsoft-antispam-prvs: <PH0PR11MB4840DF4F8D9CBA4A2FEA6D68CDF79@PH0PR11MB4840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +meJjYn8AsAXLQ8FQ+C8fbWLCjkbC0rvu5F78KMmYfOY3u0lgtztT3el3cf7LVECKtctBdRfv8sdCZdUTeD336eojX4VXF27WQL71mRs6G0S/xjAVJiRP/H67RmT4bIW0c7lGB2eLAbhkhSsRqiDC2jMlX8mF6s40+y1RGnnOAry0yu50e3yPOIjrocDjfwo03dWJ07Rh1usfP9LOkzSClpkjVXzoQdD5HRLV0HYwjytHstPVPOUj9nePmJk+8SwYLZBLCgtiHug3wWkK1eHwqjvZReVyCykaERbBljFjfScJCKxTgLyX4+BHEx6NMtI3tn2a6h2cXO3E6M5idq6ZvzS0poo7gm+ucY65Ey21qPE3i0LuYIgjGbOHghpMskCzmUH/89apOhiPWmJkaGQNLOb0mklTKIjQFDENdT76BLvQDgzXrl4gO99Ro4H9x/M73vRvz1Y7UsdgG7dUX86Z1Q4onJoS59Vqoz122Frw+28GgiCx1NtEDJPQhPIIilBjYFlFSWaqOrZ2Z+07XjVx5b3t3ICOIksz8HQ5puNATfjrqEYY5p0Fi1WKGt7MtU8JOxRrG/ZIv9N2CAigSFxTnDOvdH3fholkuOts87+njuQojtQkyoVzGU4oW+7KIZbRC5ORms6ElPciPE+HL5cF/r7qiTubhDE5hCAmr6OSQo+DpNVbXcxWqXZND/sJBdQLUUDRkk3lukKBKLLC4CmoORw+4fU7ysEPbvCb1QjNbBDURjycNSFfumcBxlWe+53DnXzRUbxX1nIO7FlhPY5JejiLrb0gVhB2GxSjCaGg2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(26005)(38100700002)(9686003)(7696005)(508600001)(53546011)(54906003)(6506007)(66946007)(122000001)(76116006)(66556008)(110136005)(66476007)(38070700005)(66446008)(2906002)(186003)(64756008)(966005)(30864003)(4326008)(71200400001)(83380400001)(55016002)(8936002)(8676002)(52536014)(33656002)(86362001)(5660300002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AUAyNTGhU2c05m0jhzIlJTKwCF1vP4NQt77O0VW96iaoOSG+YZDLcsNJ/PQy?=
 =?us-ascii?Q?K4jncCZzRvR9MH1/3Kpmw/AhYHo+JvAekRCnDHVValw981Gi2W2dMlhaGs9h?=
 =?us-ascii?Q?7yUFrCgHllt2e4gH+GfqtAV6dWcakK0WHGHPN5QR2K9Urq5cOhLDPz5HB0hz?=
 =?us-ascii?Q?rhorYTcvbhsrFF3J56mHZr8QNpBI9BeuK2bv+Hr8OuBjIYYHZ89lGcU9w5QR?=
 =?us-ascii?Q?n3EciNPTpCCD7eMP78YvDHXyzP6eU8DlU6A4ty8xxFRuqmFf67JN1ZdEfQ2R?=
 =?us-ascii?Q?ZA/qJl9O3ZXZU/yqz+OcTSDz+PwqHDCcDuJLw4+TeL021kgC5UkCgOMjOGLf?=
 =?us-ascii?Q?l+mlPwWFsDm+KPGM94CPwbJshv6bQIeLEcmrTiriNx1bLHVNWwxhT9hE4jdX?=
 =?us-ascii?Q?AxLe/2EuCRbVt2pUHw9pru2zT5B/xBiL9jEjlrsOgbOKKD/cGdm884XT0+sb?=
 =?us-ascii?Q?jld0nJMbVItVlgrWJE76FG5ggsil3sPoWhYgMQ4ZaghYvyX1oOh5gCgn94pB?=
 =?us-ascii?Q?7CKqvkl+KnydBnUv06YKjU0NPXu011Tavv/a7BZvbTzOJnTZYc/Izej+dolh?=
 =?us-ascii?Q?NtmKteSh2xOmovhJLpHngVdUtyvyh2uIyMMBTXL4GDHcUyJ6sqiC1xRGnnRs?=
 =?us-ascii?Q?xGIo99M4F8KnUqMohNEiR8EZlb0gA2wu+3vHedMMVpqq1n3+oE2zk4k9z/pQ?=
 =?us-ascii?Q?SlqeCWhZVZVoq+Fz/yGeYZNciY3WHe2lBwSdTu3i1/WyRxZtZqmob+PHSmO8?=
 =?us-ascii?Q?Bbd/fe2t+nSm+i/f48ElbUoPD9fRW7WANuwPl/f1fnR4MG2i30AFILDwo9Mg?=
 =?us-ascii?Q?7NdMaB+ygF7s1LFqpPcJr8DvgSsq1dfXRdcRloSuFkvLq1urTEab5Hy4vIFf?=
 =?us-ascii?Q?BTnCAaz2xzUPod5zNrrVio5zqNwyjQN7jTR/kkguFXYFqrN7Majz4UG8ApA/?=
 =?us-ascii?Q?vHRwPBiT+jl38kH7QtFtfZophe8mrMTckJwK5WLdABSPDw4EAU0hO+O2h3mi?=
 =?us-ascii?Q?1CUwak836qSLECMRig6VHYe28ibJGXM8gvlsdOEnzrjCsyHmF/lGlbA2dQnm?=
 =?us-ascii?Q?QzTWA01ELhfuEmEASa3SHCmtW6CniAsgQDaligHOGnD8kt1RIwg7FImYAgTU?=
 =?us-ascii?Q?pQoVPQZI/y66XSYMFVLjpoxOE5yzswh6ekGgkSsDulqArrTd1/YBVt1p4eeQ?=
 =?us-ascii?Q?H6q161N+ROx5sLDIUEjy9/xVSfXdI9wHs24JKfflY9/IVOAxvi9S0yeZmJNe?=
 =?us-ascii?Q?52L41CaC34YcgV46yULfC1CZrrWhPKqipCxNhClRQ3eSpRqz8OeOvds3Uxsd?=
 =?us-ascii?Q?tpGZ1Rgmyzx1ZCQcW2kVSVqK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9f05f7-f4c6-4e01-2a1e-08d95b9ce1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 01:19:20.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0kJJobikz5LY4CT5EBl57H2a1N6YU9/ahYzeaMQePyjiMenMcAg6plnZma+a4eoclr1QhdPAoTpvxvC3m0taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I like this patch set and this is crucial for reducing the significant vIOM=
MU performance. It looks you totally rewrite the IOMMU mapping/unmapping pa=
rt and use the dynamically allocated memory from buddy system as bounce buf=
fer instead of using the legacy SWIOTLB bounce buffer. As I know, some lega=
cy devices' DMA could not access the memory larger than 32-bit memory space=
 and the dynamically allocated memory address could exceed the 32-bit memor=
y space. Is it a problem?

Thx,
Dapeng Mi

-----Original Message-----
From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of David S=
tevens
Sent: Friday, August 6, 2021 6:34 PM
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org; Sergey Senozhatsky <senozhatsky@chromium.=
org>; iommu@lists.linux-foundation.org; David Stevens <stevensd@chromium.or=
g>; Will Deacon <will@kernel.org>; Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/9] dma-iommu: bounce buffers for untrusted devices

From: David Stevens <stevensd@chromium.org>

Add support for dynamic bounce buffers to the dma-api for use with subgranu=
le IOMMU mappings with untrusted devices. Bounce buffer management is split=
 into two parts. First, there is a buffer manager that is responsible for a=
llocating and tracking buffers. Second, there is a layer that uses the mana=
ged buffers as bounce buffers. It is responsible for managing the IOMMU map=
ping and for syncing between the original and bounce buffers.

For now, buffer management is very simple - every mapping allocates a new b=
ounce buffer.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/Makefile            |   2 +-
 drivers/iommu/dma-iommu.c         |  70 +++++-
 drivers/iommu/io-bounce-buffers.c | 358 ++++++++++++++++++++++++++++++  dr=
ivers/iommu/io-bounce-buffers.h |  46 ++++  drivers/iommu/io-buffer-manager=
.c | 212 ++++++++++++++++++  drivers/iommu/io-buffer-manager.h |  43 ++++
 6 files changed, 728 insertions(+), 3 deletions(-)  create mode 100644 dri=
vers/iommu/io-bounce-buffers.c  create mode 100644 drivers/iommu/io-bounce-=
buffers.h  create mode 100644 drivers/iommu/io-buffer-manager.c  create mod=
e 100644 drivers/iommu/io-buffer-manager.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile index c0fb0ba8=
8143..4edaf7adc082 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) +=3D iommu-debugfs.o
-obj-$(CONFIG_IOMMU_DMA) +=3D dma-iommu.o
+obj-$(CONFIG_IOMMU_DMA) +=3D dma-iommu.o io-bounce-buffers.o=20
+io-buffer-manager.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) +=3D io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) +=3D io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) +=3D io-pgtable-arm.o diff --git a/dri=
vers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c index 055ccda5eba1..908e=
b6fb7dc3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -24,6 +24,8 @@
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
=20
+#include "io-bounce-buffers.h"
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -44,6 +46,7 @@ struct iommu_dma_cookie {
 		dma_addr_t		msi_iova;
 	};
 	struct list_head		msi_page_list;
+	struct io_bounce_buffers	*bounce_buffers;
=20
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
@@ -81,6 +84,14 @@ static inline size_t cookie_msi_granule(struct iommu_dma=
_cookie *cookie)
 	return PAGE_SIZE;
 }
=20
+static struct io_bounce_buffers *dev_to_io_bounce_buffers(struct device=20
+*dev) {
+	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
+
+	return cookie->bounce_buffers;
+}
+
 static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type ty=
pe)  {
 	struct iommu_dma_cookie *cookie;
@@ -160,6 +171,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
=20
+	if (cookie->bounce_buffers)
+		io_bounce_buffers_destroy(cookie->bounce_buffers);
+
 	if (cookie->type =3D=3D IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
 		put_iova_domain(&cookie->iovad);
=20
@@ -333,6 +347,7 @@ static int iommu_dma_init_domain(struct iommu_domain *d=
omain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	int ret;
=20
 	if (!cookie || cookie->type !=3D IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -380,7 +395,16 @@ static int iommu_dma_init_domain(struct iommu_domain *=
domain, dma_addr_t base,
 	if (!dev)
 		return 0;
=20
-	return iova_reserve_iommu_regions(dev, domain);
+	ret =3D iova_reserve_iommu_regions(dev, domain);
+
+	if (ret =3D=3D 0 && dev_is_untrusted(dev)) {
+		cookie->bounce_buffers =3D
+			io_bounce_buffers_init(dev, domain, iovad);
+		if (IS_ERR(cookie->bounce_buffers))
+			ret =3D PTR_ERR(cookie->bounce_buffers);
+	}
+
+	return ret;
 }
=20
 /**
@@ -710,8 +734,13 @@ static void iommu_dma_free_noncontiguous(struct device=
 *dev, size_t size,  static void iommu_dma_sync_single_for_cpu(struct devic=
e *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)  {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
 	phys_addr_t phys;
=20
+	if (bounce && io_bounce_buffers_sync_single(bounce, dma_handle,
+						    size, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
=20
@@ -722,8 +751,13 @@ static void iommu_dma_sync_single_for_cpu(struct devic=
e *dev,  static void iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)  {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
 	phys_addr_t phys;
=20
+	if (bounce && io_bounce_buffers_sync_single(bounce, dma_handle,
+						    size, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
=20
@@ -735,9 +769,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *d=
ev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
 	struct scatterlist *sg;
 	int i;
=20
+	if (bounce && io_bounce_buffers_sync_sg(bounce, sgl, nelems, dir, true))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
=20
@@ -749,9 +787,14 @@ static void iommu_dma_sync_sg_for_device(struct device=
 *dev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
 {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
 	struct scatterlist *sg;
 	int i;
=20
+	if (bounce && io_bounce_buffers_sync_sg(bounce, sgl,
+						nelems, dir, false))
+		return;
+
 	if (dev_is_dma_coherent(dev))
 		return;
=20
@@ -763,11 +806,19 @@ static dma_addr_t iommu_dma_map_page(struct device *d=
ev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
 	phys_addr_t phys =3D page_to_phys(page) + offset;
 	bool coherent =3D dev_is_dma_coherent(dev);
 	int prot =3D dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
=20
+	if (cookie->bounce_buffers &&
+	    io_bounce_buffers_map_page(cookie->bounce_buffers, dev, page,
+				       offset, size, prot, dir, attrs,
+				       &dma_handle))
+		return dma_handle;
+
 	dma_handle =3D __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle !=3D DMA_MAPPING_ERROR)
@@ -778,6 +829,12 @@ static dma_addr_t iommu_dma_map_page(struct device *de=
v, struct page *page,  static void iommu_dma_unmap_page(struct device *dev,=
 dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)  {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
+
+	if (bounce &&
+	    io_bounce_buffers_unmap_page(bounce, dma_handle, size, dir, attrs))
+		return;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap(dev, dma_handle, size); @@ -876,12 +933,17 @@ static in=
t iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len =3D 0;
 	unsigned long mask =3D dma_get_seg_boundary(dev);
-	int i;
+	int i, ret;
=20
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return 0;
=20
+	if (cookie->bounce_buffers &&
+	    io_bounce_buffers_map_sg(cookie->bounce_buffers, dev, sg, nents,
+				     prot, dir, attrs, &ret))
+		return ret;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
=20
@@ -947,10 +1009,14 @@ static int iommu_dma_map_sg(struct device *dev, stru=
ct scatterlist *sg,  static void iommu_dma_unmap_sg(struct device *dev, str=
uct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)  {
+	struct io_bounce_buffers *bounce =3D dev_to_io_bounce_buffers(dev);
 	dma_addr_t start, end;
 	struct scatterlist *tmp;
 	int i;
=20
+	if (bounce && io_bounce_buffers_unmap_sg(bounce, sg, nents, dir, attrs))
+		return;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
=20
diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-bu=
ffers.c
new file mode 100644
index 000000000000..78b4440b58c8
--- /dev/null
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Dynamic IOMMU mapped bounce buffers.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#include <linux/dma-iommu.h>
+#include <linux/dma-map-ops.h>
+#include <linux/highmem.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "io-buffer-manager.h"
+#include "io-bounce-buffers.h"
+
+struct io_bounce_buffers {
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	unsigned int nid;
+	struct io_buffer_manager manager;
+};
+
+bool io_bounce_buffers_release_buffer_cb(struct io_buffer_manager *manager=
,
+					 dma_addr_t iova, size_t size)
+{
+	struct io_bounce_buffers *buffers =3D
+		container_of(manager, struct io_bounce_buffers, manager);
+	return iommu_unmap(buffers->domain, iova, size) >=3D size; }
+
+struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
+						 struct iommu_domain *domain,
+						 struct iova_domain *iovad)
+{
+	int ret;
+	struct io_bounce_buffers *buffers;
+
+	buffers =3D kzalloc(sizeof(*buffers), GFP_KERNEL);
+	if (!buffers)
+		return ERR_PTR(-ENOMEM);
+
+	ret =3D io_buffer_manager_init(&buffers->manager);
+	if (ret) {
+		kfree(buffers);
+		return ERR_PTR(ret);
+	}
+
+	buffers->domain =3D domain;
+	buffers->iovad =3D iovad;
+	buffers->nid =3D dev_to_node(dev);
+
+	return buffers;
+}
+
+void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers) {
+	kfree(buffers);
+}
+
+static bool should_sync_buffer(enum dma_data_direction dir, bool=20
+sync_for_cpu) {
+	return dir =3D=3D DMA_BIDIRECTIONAL ||
+	       (dir =3D=3D DMA_FROM_DEVICE && sync_for_cpu) ||
+	       (dir =3D=3D DMA_TO_DEVICE && !sync_for_cpu); }
+
+static void io_bounce_buffers_do_sync(struct io_bounce_buffers *buffers,
+				      struct page **bounce_buffer,
+				      size_t bounce_offset, struct page *orig,
+				      size_t orig_offset, size_t size,
+				      enum dma_data_direction dir, int prot,
+				      bool sync_for_cpu)
+{
+	bool needs_bounce_sync =3D should_sync_buffer(dir, sync_for_cpu);
+	char *orig_lowmem_ptr;
+	bool dma_is_coherent =3D prot & IOMMU_CACHE;
+
+	if (dma_is_coherent && !needs_bounce_sync)
+		return;
+
+	orig_lowmem_ptr =3D PageHighMem(orig) ? NULL : page_to_virt(orig);
+
+	while (size) {
+		size_t copy_len, bounce_page_offset;
+		struct page *bounce_page;
+
+		bounce_page =3D bounce_buffer[bounce_offset / PAGE_SIZE];
+		bounce_page_offset =3D bounce_offset % PAGE_SIZE;
+
+		copy_len =3D size;
+		if (copy_len + bounce_page_offset > PAGE_SIZE)
+			copy_len =3D PAGE_SIZE - bounce_page_offset;
+
+		if (!dma_is_coherent && sync_for_cpu) {
+			phys_addr_t paddr =3D page_to_phys(bounce_page);
+
+			arch_sync_dma_for_cpu(paddr + bounce_page_offset,
+					      copy_len, dir);
+		}
+
+		if (needs_bounce_sync) {
+			char *bounce_page_ptr =3D kmap_local_page(bounce_page);
+			char *bounce_ptr =3D bounce_page_ptr + bounce_page_offset;
+
+			if (!orig_lowmem_ptr) {
+				size_t remaining =3D copy_len;
+				size_t offset =3D orig_offset % PAGE_SIZE;
+				size_t orig_page_idx =3D orig_offset / PAGE_SIZE;
+
+				while (remaining) {
+					char *orig_ptr;
+					size_t sz =3D min(remaining,
+							PAGE_SIZE - offset);
+
+					orig_ptr =3D kmap_local_page(
+						nth_page(orig, orig_page_idx));
+					if (sync_for_cpu) {
+						memcpy(orig_ptr + offset,
+						       bounce_ptr, sz);
+					} else {
+						memcpy(bounce_ptr,
+						       orig_ptr + offset, sz);
+					}
+					kunmap_local(orig_ptr);
+
+					remaining -=3D sz;
+					orig_page_idx +=3D 1;
+					bounce_ptr +=3D sz;
+					offset =3D 0;
+				}
+			} else if (sync_for_cpu) {
+				memcpy(orig_lowmem_ptr + orig_offset,
+				       bounce_ptr, copy_len);
+			} else {
+				memcpy(bounce_ptr,
+				       orig_lowmem_ptr + orig_offset, copy_len);
+			}
+
+			kunmap_local(bounce_page_ptr);
+		}
+
+		if (!dma_is_coherent && !sync_for_cpu) {
+			phys_addr_t paddr =3D page_to_phys(bounce_page);
+
+			arch_sync_dma_for_device(paddr + bounce_page_offset,
+						 copy_len, dir);
+		}
+
+		bounce_offset +=3D copy_len;
+		orig_offset +=3D copy_len;
+		size -=3D copy_len;
+	}
+}
+
+bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
+				   dma_addr_t dma_handle, size_t size,
+				   enum dma_data_direction dir,
+				   bool sync_for_cpu)
+{
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	size_t offset;
+	int prot;
+
+	if (!io_buffer_manager_find_buffer(&buffers->manager, dma_handle, &info,
+					   &orig_buffer, &prot))
+		return false;
+
+	offset =3D dma_handle - info.iova;
+	io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
+				  orig_buffer, offset, size, dir, prot,
+				  sync_for_cpu);
+	return true;
+}
+
+static void __io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+					struct scatterlist *sgl, int nents,
+					struct page **bounce_buffer,
+					enum dma_data_direction dir, int prot,
+					bool sync_for_cpu)
+{
+	size_t bounce_offset =3D 0;
+	struct scatterlist *iter;
+	int i;
+
+	for_each_sg(sgl, iter, nents, i) {
+		io_bounce_buffers_do_sync(buffers, bounce_buffer, bounce_offset,
+					  sg_page(iter), iter->offset,
+					  iter->length, dir, prot,
+					  sync_for_cpu);
+		bounce_offset +=3D iter->length;
+	}
+}
+
+bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+			       struct scatterlist *sgl, int nents,
+			       enum dma_data_direction dir, bool sync_for_cpu) {
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	int prot;
+
+	if (!io_buffer_manager_find_buffer(&buffers->manager,
+					   sg_dma_address(sgl), &info,
+					   &orig_buffer, &prot))
+		return false;
+
+	// In the non bounce buffer case, iommu_dma_map_sg syncs before setting
+	// up the new mapping's dma address. This check handles false positives
+	// in find_buffer caused by sgl being reused for a non bounce buffer
+	// case after being used with a bounce buffer.
+	if (orig_buffer !=3D sgl)
+		return false;
+
+	__io_bounce_buffers_sync_sg(buffers, sgl, nents, info.bounce_buffer,
+				    dir, prot, sync_for_cpu);
+
+	return true;
+}
+
+bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
+				  dma_addr_t handle, size_t size,
+				  enum dma_data_direction dir,
+				  unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		io_bounce_buffers_sync_single(buffers, handle, size, dir, true);
+
+	return io_buffer_manager_release_buffer(&buffers->manager,
+						buffers->domain, handle, true);
+}
+
+bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
+				struct scatterlist *sgl, int nents,
+				enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		io_bounce_buffers_sync_sg(buffers, sgl, nents, dir, true);
+
+	return io_buffer_manager_release_buffer(
+		&buffers->manager, buffers->domain, sg_dma_address(sgl), true); }
+
+static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers=
,
+					 struct io_bounce_buffer_info *info,
+					 int prot)
+{
+	unsigned int count =3D info->size >> PAGE_SHIFT;
+	struct sg_table sgt;
+	size_t mapped;
+
+	if (sg_alloc_table_from_pages(&sgt, info->bounce_buffer, count, 0,
+				      info->size, GFP_ATOMIC))
+		return false;
+
+	mapped =3D iommu_map_sg_atomic(buffers->domain, info->iova, sgt.sgl,
+				     sgt.orig_nents, prot);
+
+	sg_free_table(&sgt);
+	return mapped >=3D info->size;
+}
+
+bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
+				struct device *dev, struct page *page,
+				unsigned long offset, size_t size, int prot,
+				enum dma_data_direction dir,
+				unsigned long attrs, dma_addr_t *handle) {
+	bool skip_cpu_sync =3D attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	struct io_bounce_buffer_info info;
+	bool force_bounce =3D iova_offset(buffers->iovad, offset | size);
+
+	if (!force_bounce)
+		return false;
+
+	*handle =3D DMA_MAPPING_ERROR;
+	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, page,
+					    offset + size, prot, buffers->nid,
+					    &info))
+		return true;
+
+	if (!skip_cpu_sync)
+		io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
+					  page, offset, size, dir, prot, false);
+
+	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
+		io_buffer_manager_release_buffer(
+			&buffers->manager, buffers->domain, info.iova, false);
+		return true;
+	}
+
+	*handle =3D info.iova + offset;
+	return true;
+}
+
+bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
+			      struct device *dev, struct scatterlist *sgl,
+			      int nents, int prot, enum dma_data_direction dir,
+			      unsigned long attrs, int *out_nents) {
+	struct io_bounce_buffer_info info;
+	struct scatterlist *iter;
+	size_t size =3D 0;
+	bool skip_cpu_sync =3D attrs & DMA_ATTR_SKIP_CPU_SYNC;
+	dma_addr_t seg_iova;
+	int i;
+	bool force_bounce =3D false;
+
+	for_each_sg(sgl, iter, nents, i) {
+		size +=3D iter->length;
+		force_bounce |=3D iova_offset(buffers->iovad,
+					    iter->offset | iter->length);
+	}
+
+	if (!force_bounce)
+		return false;
+
+	*out_nents =3D 0;
+	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, sgl, size,
+					    prot, buffers->nid, &info))
+		return true;
+
+	if (!skip_cpu_sync)
+		__io_bounce_buffers_sync_sg(buffers, sgl, nents,
+					    info.bounce_buffer, dir, prot,
+					    false);
+
+	if (!io_bounce_buffers_map_buffer(buffers, &info, prot)) {
+		io_buffer_manager_release_buffer(
+			&buffers->manager, buffers->domain, info.iova, false);
+		return true;
+	}
+
+	i =3D 0;
+	seg_iova =3D info.iova;
+	while (size > 0) {
+		size_t seg_size =3D min_t(size_t, size,
+					dma_get_max_seg_size(dev));
+
+		sg_dma_len(sgl) =3D seg_size;
+		sg_dma_address(sgl) =3D seg_iova;
+
+		sgl =3D sg_next(sgl);
+		size -=3D seg_size;
+		seg_iova +=3D seg_size;
+		i++;
+	}
+
+	if (sgl) {
+		sg_dma_address(sgl) =3D DMA_MAPPING_ERROR;
+		sg_dma_len(sgl) =3D 0;
+	}
+
+	*out_nents =3D i;
+	return true;
+}
diff --git a/drivers/iommu/io-bounce-buffers.h b/drivers/iommu/io-bounce-bu=
ffers.h
new file mode 100644
index 000000000000..6d132a27646c
--- /dev/null
+++ b/drivers/iommu/io-bounce-buffers.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#ifndef _LINUX_IO_BOUNCE_BUFFERS_H
+#define _LINUX_IO_BOUNCE_BUFFERS_H
+
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+
+struct io_bounce_buffers;
+
+struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
+						 struct iommu_domain *domain,
+						 struct iova_domain *iovad);
+void io_bounce_buffers_destroy(struct io_bounce_buffers *buffers);
+
+bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
+				   dma_addr_t dma_handle, size_t size,
+				   enum dma_data_direction dir,
+				   bool sync_for_cpu);
+bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
+			       struct scatterlist *sgl, int nents,
+			       enum dma_data_direction dir, bool sync_for_cpu);
+
+bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
+				struct device *dev, struct page *page,
+				unsigned long offset, size_t size, int prot,
+				enum dma_data_direction dir,
+				unsigned long attrs, dma_addr_t *handle); bool=20
+io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
+			      struct device *dev, struct scatterlist *sgl,
+			      int nents, int prot, enum dma_data_direction dir,
+			      unsigned long attrs, int *out_nents);
+
+bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
+				  dma_addr_t handle, size_t size,
+				  enum dma_data_direction dir,
+				  unsigned long attrs);
+bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
+				struct scatterlist *sgl, int nents,
+				enum dma_data_direction dir,
+				unsigned long attrs);
+
+#endif /* _LINUX_IO_BOUNCE_BUFFERS_H */
diff --git a/drivers/iommu/io-buffer-manager.c b/drivers/iommu/io-buffer-ma=
nager.c
new file mode 100644
index 000000000000..24e95a2faa37
--- /dev/null
+++ b/drivers/iommu/io-buffer-manager.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Manager which allocates and tracks bounce buffers and their IOVAs.=20
+Does
+ * not actually manage the IOMMU mapping nor do the bounce copies.
+ *
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#include "io-buffer-manager.h"
+
+#include <linux/slab.h>
+
+struct io_buffer_node {
+	struct rb_node node;
+	struct io_bounce_buffer_info info;
+	void *orig_buffer;
+	int prot;
+};
+
+static void io_buffer_manager_free_pages(struct page **pages, int=20
+count) {
+	while (count--)
+		__free_page(pages[count]);
+	kfree(pages);
+}
+
+static struct page **io_buffer_manager_alloc_pages(int count, unsigned=20
+int nid) {
+	struct page **pages;
+	unsigned int i;
+
+	pages =3D kmalloc_array(count, sizeof(*pages), GFP_ATOMIC);
+	if (!pages)
+		return NULL;
+
+	// The IOMMU can map highmem pages, but try to allocate non-highmem
+	// pages first to make accessing the buffer cheaper.
+	for (i =3D 0; i < count; i++) {
+		pages[i] =3D alloc_pages_node(
+			nid,
+			GFP_ATOMIC | __GFP_ZERO | __GFP_NORETRY | __GFP_NOWARN,
+			0);
+		if (!pages[i]) {
+			pages[i] =3D alloc_pages_node(
+				nid, GFP_ATOMIC | __GFP_ZERO | __GFP_HIGHMEM,
+				0);
+			if (!pages[i]) {
+				io_buffer_manager_free_pages(pages, i);
+				return NULL;
+			}
+		}
+	}
+
+	return pages;
+}
+
+struct io_buffer_node *find_fallback_node(struct rb_root *root,=20
+dma_addr_t iova) {
+	struct rb_node *node =3D root->rb_node;
+
+	while (node) {
+		struct io_buffer_node *cur =3D
+			container_of(node, struct io_buffer_node, node);
+
+		if (iova < cur->info.iova)
+			node =3D node->rb_left;
+		else if (iova >=3D cur->info.iova + cur->info.size)
+			node =3D node->rb_right;
+		else
+			return cur;
+	}
+	return NULL;
+}
+
+bool insert_fallback_node(struct rb_root *root, struct io_buffer_node=20
+*node) {
+	struct rb_node **new =3D &(root->rb_node), *parent =3D NULL;
+	dma_addr_t node_end =3D node->info.iova + node->info.size;
+
+	while (*new) {
+		struct io_buffer_node *cur =3D
+			container_of(*new, struct io_buffer_node, node);
+		dma_addr_t cur_end =3D cur->info.iova + cur->info.size;
+
+		parent =3D *new;
+		if (node_end <=3D cur->info.iova)
+			new =3D &((*new)->rb_left);
+		else if (node->info.iova >=3D cur_end)
+			new =3D &((*new)->rb_right);
+		else {
+			pr_crit("IOVA collision new=3D[%llx,%llx) old=3D[%llx,%llx)\n",
+				node->info.iova, node_end, cur->info.iova,
+				cur_end);
+			return false;
+		}
+	}
+
+	rb_link_node(&node->node, parent, new);
+	rb_insert_color(&node->node, root);
+	return true;
+}
+
+bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
+				    struct device *dev, void *orig_buffer,
+				    size_t size, int prot, unsigned int nid,
+				    struct io_bounce_buffer_info *info) {
+	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
+	struct io_buffer_node *node;
+	unsigned long flags;
+
+	node =3D kzalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		return false;
+
+	size =3D PAGE_ALIGN(size);
+	node->info.iova =3D
+		__iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!node->info.iova)
+		goto free_node;
+
+	node->info.bounce_buffer =3D
+		io_buffer_manager_alloc_pages(size >> PAGE_SHIFT, nid);
+	if (!node->info.bounce_buffer)
+		goto free_iova;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	if (!insert_fallback_node(&manager->fallback_buffers, node))
+		goto fallback_lock_unlock;
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	node->orig_buffer =3D orig_buffer;
+	node->prot =3D prot;
+	node->info.size =3D size;
+
+	*info =3D node->info;
+
+	return true;
+
+fallback_lock_unlock:
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+free_iova:
+	__iommu_dma_free_iova(domain->iova_cookie, node->info.iova, size,=20
+NULL);
+free_node:
+	kfree(node);
+	return false;
+}
+
+bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
+				   dma_addr_t handle,
+				   struct io_bounce_buffer_info *info,
+				   void **orig_buffer, int *prot)
+{
+	struct io_buffer_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	node =3D find_fallback_node(&manager->fallback_buffers, handle);
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	if (!node)
+		return false;
+
+	*info =3D node->info;
+	*orig_buffer =3D node->orig_buffer;
+	*prot =3D node->prot;
+	return true;
+}
+
+bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
+				      struct iommu_domain *domain,
+				      dma_addr_t handle, bool inited) {
+	struct io_buffer_node *node;
+	unsigned long flags;
+	bool free_buffer;
+
+	spin_lock_irqsave(&manager->fallback_lock, flags);
+	node =3D find_fallback_node(&manager->fallback_buffers, handle);
+	if (node)
+		rb_erase(&node->node, &manager->fallback_buffers);
+	spin_unlock_irqrestore(&manager->fallback_lock, flags);
+
+	if (!node)
+		return false;
+
+	if (inited)
+		free_buffer =3D io_bounce_buffers_release_buffer_cb(
+			manager, node->info.iova, node->info.size);
+	else
+		free_buffer =3D true;
+
+	if (free_buffer) {
+		io_buffer_manager_free_pages(node->info.bounce_buffer,
+					     node->info.size >> PAGE_SHIFT);
+		__iommu_dma_free_iova(domain->iova_cookie, node->info.iova,
+				      node->info.size, NULL);
+	} else {
+		pr_warn("Bounce buffer release failed; leaking buffer\n");
+	}
+
+	kfree(node);
+	return true;
+}
+
+int io_buffer_manager_init(struct io_buffer_manager *manager) {
+	manager->fallback_buffers =3D RB_ROOT;
+	spin_lock_init(&manager->fallback_lock);
+
+	return 0;
+}
diff --git a/drivers/iommu/io-buffer-manager.h b/drivers/iommu/io-buffer-ma=
nager.h
new file mode 100644
index 000000000000..aae560cc8512
--- /dev/null
+++ b/drivers/iommu/io-buffer-manager.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google, Inc.
+ */
+
+#ifndef _LINUX_IO_BUFFER_MANAGER_H
+#define _LINUX_IO_BUFFER_MANAGER_H
+
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+#include <linux/spinlock.h>
+
+struct io_buffer_manager {
+	spinlock_t fallback_lock;
+	struct rb_root fallback_buffers;
+};
+
+struct io_bounce_buffer_info {
+	struct page **bounce_buffer;
+	dma_addr_t iova;
+	size_t size;
+};
+
+bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
+				    struct device *dev, void *orig_buffer,
+				    size_t size, int prot, unsigned int nid,
+				    struct io_bounce_buffer_info *info);
+
+bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
+				   dma_addr_t handle,
+				   struct io_bounce_buffer_info *info,
+				   void **orig_buffer, int *prot);
+
+bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
+				      struct iommu_domain *domain,
+				      dma_addr_t handle, bool inited);
+
+int io_buffer_manager_init(struct io_buffer_manager *manager);
+
+bool io_bounce_buffers_release_buffer_cb(struct io_buffer_manager *manager=
,
+					 dma_addr_t iova, size_t size);
+
+#endif /* _LINUX_IO_BUFFER_MANAGER_H */
--
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
