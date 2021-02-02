Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C109530CBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhBBTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:38:16 -0500
Received: from 8bytes.org ([81.169.241.247]:54014 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhBBNzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:55:46 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5FB4B3D4; Tue,  2 Feb 2021 14:55:03 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:55:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/vt-d: Apply SATC policy
Message-ID: <20210202135501.GX32671@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-4-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:40:57PM +0800, Lu Baolu wrote:
> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
> +		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
> +		if (satc->segment == pci_domain_nr(dev->bus) && satcu->atc_required) {

You can safe a level of indentation and make this look nicer if you do:

		if (satc->segment != pci_domain_nr(dev->bus) || !satcu->atc_required)
			continue;


> +			for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
> +				if (to_pci_dev(tmp) == dev)
> +					goto out;
> +		}
> +	}
> +	ret = 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
