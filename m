Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6D367B81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhDVHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:53:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhDVHxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:53:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05A9CAC7D;
        Thu, 22 Apr 2021 07:52:30 +0000 (UTC)
Date:   Thu, 22 Apr 2021 09:52:28 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 039/190] Revert "iommu: Fix reference count leak in
 iommu_group_alloc."
Message-ID: <YIErPGXVW1masuNW@suse.de>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-40-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-40-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Apr 21, 2021 at 02:58:34PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 7cc31613734c4870ae32f5265d576ef296621343.

I reviewed this fix again and it looks still valid and correct to me.
There is no need for a revert.

Thanks,

	Joerg

