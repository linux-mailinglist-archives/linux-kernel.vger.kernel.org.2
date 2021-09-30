Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335641DC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbhI3OYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:24:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:41168 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348066AbhI3OYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:24:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="247737537"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="247737537"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 07:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="479960681"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2021 07:22:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 07:22:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 30 Sep 2021 07:22:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 30 Sep 2021 07:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDkUzbEbTwfSBrSAZ0uYAMcxVyW9ZeQmS1Y+Qbh5HpxjFdCN5HrDDK5RfQoss5qNZyXZw2zrmKR+bS/BhZM1F7Bh2vdqnoHpi4eb6e0hOp0UBXDpfC3LiYOPRWmr2zGgq4d1Fr9pBKj8zDbRtBKk87OJKN7tiSfTYG+sECuoRLLy6O+Oi9CKMMNMvlyT/Te/vRdRlFM0RIeQJE1aj47cBbKBplcO/wirfKChGEDX8yai4suliBAv5jYexicGzEXohK38vczmNjFfGEkMMfkLw7CIU574zy8JkMTkOR6MPWyTmnE4cu4AvbwWFTzv2vjdAdHqkakohuAzhtB7wYDQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EGtknXKWs4wm0DFSxrg1qn8+9oPqtIQB5G2ZpPze/Ro=;
 b=m2YB9LXyxIiHcgQshOV3CXA/fGDag3id7aYW2fjXuPXv9bh/imqL6HSI0kXnUD7JSoxBm41UltVElwelazGiGO0ViM4fwo643iZoC9NZuedTi2KzDti5hKD7jzkonymGnwAsYF2Un03NfHw1MrmBQWxwanYcmBw1YilPgIEaATBxj846+im4REGLwjI13eocPSg/jzpK+lkDoNNdE7PXO3c6EF54Zaj9zclIMqCJDuOXiTK6eXw6ADmx81a5vtiq0UTQVR1hp61pyTJMotEygJCF850yHrMoez6akk6JrChvbRKoCqDMTtrnSLzPzwgVw+jQK14isj5ujNpxHI348w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGtknXKWs4wm0DFSxrg1qn8+9oPqtIQB5G2ZpPze/Ro=;
 b=iOJPUxAvHTxsORm/0u3H8BrLjqRvo0aGTym8vgNEfyFzoMPiH1Vj84rdX8ful6lPtvKolaOduVgoWlK39c9VQnDX4bcB3xChXHWAO1d3qO0OVWbT/O9zWEJbBnzIDScayI4y3Duk4mxwvikuDpfcbhjXtFSaLIJKHsFVrBJ63+Q=
Received: from CO1PR11MB5153.namprd11.prod.outlook.com (2603:10b6:303:95::13)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 14:22:34 +0000
Received: from CO1PR11MB5153.namprd11.prod.outlook.com
 ([fe80::a5c2:7128:bc50:48e]) by CO1PR11MB5153.namprd11.prod.outlook.com
 ([fe80::a5c2:7128:bc50:48e%7]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 14:22:34 +0000
From:   "Campin, Mike" <mike.campin@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Thread-Topic: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Thread-Index: AQHXr3CNIZf6JLtKZEGHiZHWrUBtB6u7c/OAgAAAuICAADcqAIAADMSAgADzYNA=
Date:   Thu, 30 Sep 2021 14:22:34 +0000
Message-ID: <CO1PR11MB5153C703BC0E0112CE7F65B2F3AA9@CO1PR11MB5153.namprd11.prod.outlook.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210929123437.721991dc@jacob-builder> <20210929193953.GX964074@nvidia.com>
 <20210929155720.794b6e65@jacob-builder> <20210929234301.GC964074@nvidia.com>
In-Reply-To: <20210929234301.GC964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d09a029-5e1f-4c73-bd2b-08d9841dbf03
x-ms-traffictypediagnostic: CO1PR11MB5137:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5137C78B0E99E5BE6CF34367F3AA9@CO1PR11MB5137.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mjo/cI0R9udDkXZCKiHQeuaSknpVkKW9aDUC3VBkwdmh5RPV7hfAWvZiIDSmy2Y6RjslLULrNoOFCX97hXNCYlRZHP+u+ebksHWSoqS/1p42joQBksdEJoQDrx8YoEmY0G2KVKHT52OC/O8MBSHX288RY5F5RjJzErR2g0EAfAYBRG83efPok0k6v2eVAwMTpfJIv3Uwe+k0TRAuRc/k31z6PDQKQ7Yyc0cRZ8oc67DRPoxl5PSM2L/dqrdmDGQYKb/Iar4t2jGyViCpVkBPvqwkkxSNN8edMmO4hBliG7LAbMo6qeuogpUhfZI8ux4KkzeGQv1AgZFEt6rgrFxesn9issh6ZQC+CA0A6VcsCGx/LE/btpFMqM8qhUJ9A4ohYEaORWcB2DoQjceK+MCef+XvUl8oC7fXsf32ptULN+/aTjqc+sthb72Avp5QglHZ1SZ7lzJ+PecQrwqSfQZ2WwQQoCWANbWMywQfxoiyMmj2NVN32mAba814PgVPRuvSlKwQwQAIE/yUulsygxsDxRizmX8T2R86sUrQIL8ECOj2DX3DZjRJ/rghRdrILASuW2kq0C1IeUQXznbz6n8eghxhBNzKa65FWnjaSzKycVMw/RnxQJCZih7KgtiJpFxiXDm3HKW1eXZyYcknS4q/sEZUvuHRZT9ZmQIdilOwRIqAvzFQfuZFDjpElGEuzUghMK28t1C+26mxy6XuO11wBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(316002)(2906002)(83380400001)(52536014)(4326008)(86362001)(53546011)(6506007)(66946007)(71200400001)(38100700002)(508600001)(122000001)(8676002)(8936002)(38070700005)(33656002)(55016002)(5660300002)(26005)(66446008)(64756008)(7696005)(9686003)(66556008)(186003)(54906003)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1MXJ5neITbkwNm9IQUa4VCy9PTfegirfwiuaS60mT52zoyKDqr+qajWeHY0?=
 =?us-ascii?Q?dOeF1OENCCRwix64qdCf71Ly8ELFZajln9Q5KX9FjKe0Txonsl6fyouZiCZa?=
 =?us-ascii?Q?aSpgfPMnPwaxBhFhaG8PfG1917wz4+dC0qQbDNQq2PdlovCUK3aVIXwMPUi5?=
 =?us-ascii?Q?j/wysm3mZTX+pYz8XlSTc9hpe8n4mhoe3hkj4J3TQudcvZrOz2KQCDPOo3jv?=
 =?us-ascii?Q?1F9IWCZreMDe6RDIFjo9vaYJ60uH+2mNUBS+70mPMTQo93ttAqzqrYQd95rZ?=
 =?us-ascii?Q?rFbZTwu89zuSu8gvHq6TBnMvmdRhTfPg4xH8orjiJjMhBbYJ1nWlfaTk3FWe?=
 =?us-ascii?Q?rsO0MGKGQiDnQ7VZQ1ldhuP2NUOD5thUlxcgKfWqqL4/J13/u3NTHGwvDXJq?=
 =?us-ascii?Q?irXCH1mnc8f+9AsLmzJk3UrKbNMObusm1gk4q8JTT3dOiMJZKZuOze3t+dsf?=
 =?us-ascii?Q?f+x37GjJaAmDWDdtFszOJIAa50jfXiD96SCM8VmqHa4A/I3MleJdzyZBQLJP?=
 =?us-ascii?Q?gs9wcZYIQihqdXbdZwi/cnjT9CPt+dFFK1AdIDQ448a0y9Wmmfe4qRqo05bF?=
 =?us-ascii?Q?zWEq/Dt3B1abfpq2BN0zAWw+784nu0v8uQF9JxgWrlEEG+BLIA5mTfEQrG+T?=
 =?us-ascii?Q?M24BR5xPF4Lz6qkUDphOhQVxT5K6CXl5uCFQTrxOEAqDprHiAhfn0O+mLJLf?=
 =?us-ascii?Q?Ci3qgKYi3NBGq/qeLlOAmoEJPJauEPAsx0eASrV6ndtaeXdcEHEUcDhlIsqz?=
 =?us-ascii?Q?sM+1EJ9IgE/5TWPjMVXTY3+hJl98hvEZgEhDl41bCk6xsfWC3olZE+wFJVFb?=
 =?us-ascii?Q?sjf1oM0ac9RHbu0CG6so9B+85ZmlwzpUvTVo0vUZhxtOTmJLwNZZknepiKES?=
 =?us-ascii?Q?42ntECdjTTyaTMgSTd3edMjlzpXKCb8PzR/TvqYXS7+pw+XkXQczQ3mnJ+3A?=
 =?us-ascii?Q?ld1neNcQO6exZGza1t8o0yt7zZ+ngXaDPgVSAScIj677Qzienu1VujcaYNXL?=
 =?us-ascii?Q?AQkcvyu4x7WPnbo4g3Grjv9YAjG2De5oxAYGAZ2vQPts+Teflw1VzCyhzoYK?=
 =?us-ascii?Q?bG5LMKeHmdyTeOssPc4KxtryGylfEl8JhM+rSFSf0EjPGJJV8/DFfIUqOQ2x?=
 =?us-ascii?Q?vslW56dcfcltKHG/n1F3EIAdf/MZoxbmfaQFGufmkgL4hZJtXrgY4tyqYfYW?=
 =?us-ascii?Q?4tl4bzrg/kuxBLLZLXG+YTF+0ftLeaEAJrp/OclKs+/LuUpYvYHYCz/OR0lj?=
 =?us-ascii?Q?f5NuaA/m4ZaL27UwVp1aQhF0NQBCUWN+0OIkYDyzwkpoOPqf7Q3BPa+Gn+gl?=
 =?us-ascii?Q?ws034tJ9MFWuVLaQsiHPNTun?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d09a029-5e1f-4c73-bd2b-08d9841dbf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 14:22:34.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxxJwDBpFw/eUaGmuifgJbfQMRavdgHnExT4QQbWNHBgbhCeHkK4zrPCDh/9eKz41LMI7QynU2a0y0c77pESUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need support for mixed user PASID, kernel PASID and non-PASID use cases i=
n the driver.

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Wednesday, September 29, 2021 4:43 PM
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org; LKML <linux-kernel@vger.kernel.org>; =
Joerg Roedel <joro@8bytes.org>; Christoph Hellwig <hch@infradead.org>; Tian=
, Kevin <kevin.tian@intel.com>; Luck, Tony <tony.luck@intel.com>; Jiang, Da=
ve <dave.jiang@intel.com>; Raj, Ashok <ashok.raj@intel.com>; Kumar, Sanjay =
K <sanjay.k.kumar@intel.com>; Campin, Mike <mike.campin@intel.com>; Thomas =
Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA

On Wed, Sep 29, 2021 at 03:57:20PM -0700, Jacob Pan wrote:
> Hi Jason,
>=20
> On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrot=
e:
>=20
> > On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
> > =20
> > > For #2, it seems we can store the kernel PASID in struct device.=20
> > > This will preserve the DMA API interface while making it PASID capabl=
e.
> > > Essentially, each PASID capable device would have two special=20
> > > global
> > > PASIDs:=20
> > > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > > 	- PASID 1 (randomly selected) for in-kernel DMA request w/ PASID
> >=20
> > This seems reasonable, I had the same thought. Basically just have=20
> > the driver issue some trivial call:
> >   pci_enable_pasid_dma(pdev, &pasid)
> That would work, but I guess it needs to be an iommu_ call instead of pci=
_?

Which ever makes sense..  The API should take in a struct pci_device and re=
turn a PCI PASID - at least as a wrapper around a more generic immu api.

> I think your suggestion is more precise, in case the driver does not=20
> want to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).

Since it is odd, and it may create overhead, I would do it only when asked =
to do it

> > Having multiple RID's pointing at the same IO page table is=20
> > something we expect iommufd to require so the whole thing should=20
> > ideally fall out naturally.

> That would be the equivalent of attaching multiple devices to the same=20
> IOMMU domain. right?

Effectively..

Jason
