Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FC32D2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbhCDM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhCDM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:27:06 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED27C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 04:26:26 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BA31A447; Thu,  4 Mar 2021 13:26:24 +0100 (CET)
Date:   Thu, 4 Mar 2021 13:26:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <20210304122623.GD26414@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225062654.2864322-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
> When the first level page table is used for IOVA translation, it only
> supports Read-Only and Read-Write permissions. The Write-Only permission
> is not supported as the PRESENT bit (implying Read permission) should
> always set. When using second level, we still give separate permissions
> that allows WriteOnly which seems inconsistent and awkward. There is no
> use case we can think off, hence remove that configuration to make it
> consistent.

No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?

