Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DBA30CC10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhBBTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:43:05 -0500
Received: from 8bytes.org ([81.169.241.247]:54002 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233291AbhBBNxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:53:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2451B3E6; Tue,  2 Feb 2021 14:53:07 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:53:05 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
Message-ID: <20210202135305.GW32671@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:40:56PM +0800, Lu Baolu wrote:
> +	case ACPI_DMAR_TYPE_SATC:
> +		satc = container_of(header, struct acpi_dmar_satc, header);
> +		pr_info("SATC flags: 0x%x\n", satc->flags);
> +		break;

Did the pr_info() slip through or is there a real purpose for having
this information in the kernel log?

