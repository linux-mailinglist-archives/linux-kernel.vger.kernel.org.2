Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A98319CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBLKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:48:04 -0500
Received: from 8bytes.org ([81.169.241.247]:55630 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhBLKsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:48:02 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 38751310; Fri, 12 Feb 2021 11:47:21 +0100 (CET)
Date:   Fri, 12 Feb 2021 11:47:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        will@kernel.org
Subject: Re: [PATCH] iommu/amd: Fix performance counter initialization
Message-ID: <20210212104717.GF7302@8bytes.org>
References: <20210208122712.5048-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208122712.5048-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:27:12AM -0600, Suravee Suthikulpanit wrote:
>  drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)

Applied, thanks.

