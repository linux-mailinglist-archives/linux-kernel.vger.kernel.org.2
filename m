Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE390340315
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCRKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:24:34 -0400
Received: from 8bytes.org ([81.169.241.247]:59666 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhCRKYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:24:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C33B72D8; Thu, 18 Mar 2021 11:24:20 +0100 (CET)
Date:   Thu, 18 Mar 2021 11:24:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, yian.chen@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH] iommu/vt-d: Disable SVM when ATS/PRI/PASID are not
 enabled in the device
Message-ID: <YFMqU2Rp+9CYVX6s@8bytes.org>
References: <20210314201534.918-1-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314201534.918-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 01:15:34PM -0700, Kyung Min Park wrote:
> Currently, the Intel VT-d supports Shared Virtual Memory (SVM) only when
> IO page fault is supported. Otherwise, shared memory pages can not be
> swapped out and need to be pinned. The device needs the Address Translation
> Service (ATS), Page Request Interface (PRI) and Process Address Space
> Identifier (PASID) capabilities to be enabled to support IO page fault.
> 
> Disable SVM when ATS, PRI and PASID are not enabled in the device.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>

Applied, thanks.
