Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B238C3D5967
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhGZLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhGZLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:45:13 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F3C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:25:42 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6D7EE2B0; Mon, 26 Jul 2021 14:25:40 +0200 (CEST)
Date:   Mon, 26 Jul 2021 14:25:39 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
        yian.chen@intel.com, sohil.mehta@intel.com,
        ravi.v.shankar@intel.com, ashok.raj@intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Dump DMAR translation structure
Message-ID: <YP6pw9j8i3bGOb13@8bytes.org>
References: <20210722042453.10579-1-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722042453.10579-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 09:24:53PM -0700, Kyung Min Park wrote:
> When the dmar translation fault happens, the kernel prints a single line
> fault reason with corresponding hexadecimal code defined in the Intel VT-d
> specification.
> 
> Currently, when user wants to debug the translation fault in detail,
> debugfs is used for dumping the dmar_translation_struct, which is not
> available when the kernel failed to boot.
> 
> Dump the DMAR translation structure, pagewalk the IO page table and print
> the page table entry when the fault happens.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>

This is too much noise in dmesg for a single dmar fault. Please hide
that additional debug information behind a debug kernel option for the
VT-d driver.

Thanks,
	
	Joerg

