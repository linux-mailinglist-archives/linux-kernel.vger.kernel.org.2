Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBBA360AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhDONmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:42:19 -0400
Received: from 8bytes.org ([81.169.241.247]:35006 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232795AbhDONmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:42:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 787CA387; Thu, 15 Apr 2021 15:41:52 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:41:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        will@kernel.org, jsnitsel@redhat.com, pmenzel@molgen.mpg.de,
        Jon.Grimm@amd.com
Subject: Re: [PATCH 0/2] iommu/amd: Revert and remove failing PMC test
Message-ID: <YHhCn2a+oi7/y7ZP@8bytes.org>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:58:46AM -0500, Suravee Suthikulpanit wrote:
> Paul Menzel (1):
>   Revert "iommu/amd: Fix performance counter initialization"
> 
> Suravee Suthikulpanit (1):
>   iommu/amd: Remove performance counter pre-initialization test

Applied, thanks Paul and Suravee.
