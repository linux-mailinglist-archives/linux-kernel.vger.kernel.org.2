Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33DB3DC1BD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhG3X5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:57:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:45656 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhG3X5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:57:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="212911051"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="212911051"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 16:57:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="508505463"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 16:56:59 -0700
Message-ID: <43dbe366ef396a81357c032ea62d8b9543678a3d.camel@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Dump DMAR translation structure
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
        yian.chen@intel.com, sohil.mehta@intel.com,
        ravi.v.shankar@intel.com, ashok.raj@intel.com
Date:   Fri, 30 Jul 2021 16:51:02 -0700
In-Reply-To: <YP6pw9j8i3bGOb13@8bytes.org>
References: <20210722042453.10579-1-kyung.min.park@intel.com>
         <YP6pw9j8i3bGOb13@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Mon, 2021-07-26 at 14:25 +0200, Joerg Roedel wrote:
> On Wed, Jul 21, 2021 at 09:24:53PM -0700, Kyung Min Park wrote:
> > When the dmar translation fault happens, the kernel prints a single
> > line
> > fault reason with corresponding hexadecimal code defined in the
> > Intel VT-d
> > specification.
> > 
> > Currently, when user wants to debug the translation fault in
> > detail,
> > debugfs is used for dumping the dmar_translation_struct, which is
> > not
> > available when the kernel failed to boot.
> > 
> > Dump the DMAR translation structure, pagewalk the IO page table and
> > print
> > the page table entry when the fault happens.
> > 
> > Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> 
> This is too much noise in dmesg for a single dmar fault. Please hide
> that additional debug information behind a debug kernel option for
> the
> VT-d driver.

Sure, let me change in the next version.

