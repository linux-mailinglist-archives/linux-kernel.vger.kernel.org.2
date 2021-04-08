Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077C357D24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhDHHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:19:03 -0400
Received: from 8bytes.org ([81.169.241.247]:33988 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHHTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:19:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EA26C426; Thu,  8 Apr 2021 09:18:49 +0200 (CEST)
Date:   Thu, 8 Apr 2021 09:18:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Message-ID: <YG6uWFAS6GCWJPGO@8bytes.org>
References: <20210323210619.513069-1-namit@vmware.com>
 <YG2C42UdIEsWex2L@8bytes.org>
 <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

On Wed, Apr 07, 2021 at 05:57:31PM +0000, Nadav Amit wrote:
> I tested it on real bare-metal hardware. I ran some basic I/O workloads
> with the IOMMU enabled, checkers enabled/disabled, and so on.
> 
> However, I only tested the IOMMU-flushes and I did not test that the
> device-IOTLB flush work, since I did not have the hardware for that.
> 
> If you can refer me to the old patches, I will have a look and see
> whether I can see a difference in the logic or test them. If you want
> me to run different tests - let me know. If you want me to remove
> the device-IOTLB invalidations logic - that is also fine with me.

Here is the patch-set, it is from 2010 and against a very old version of
the AMD IOMMU driver:

	https://lore.kernel.org/lkml/1265898797-32183-1-git-send-email-joerg.roedel@amd.com/

Regards,

	Joerg
