Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17BB4167B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbhIWVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhIWVwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:52:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E97661152;
        Thu, 23 Sep 2021 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632433851;
        bh=G33CELDjpkIi7/i+uSBAnuvjXvPt234/sYyyXuqZrI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkZoG+0vEIqOypwkpQR8BTY8ITWbpIDNzfdC9qV1Pr48wxfdh+QKa1AwxlMeVhzDY
         syAvS70GO0Pewf6cCUDNZFtBSf0H5UVv0/p0MJRapqMNhVU6Epzd3PaTgNNYbedU4d
         xFdWheJpNjs8xsJIeZ59I5K4h/5J4uI2BXhV7rLA/qFb+us7nE0IHjGXXeolcfaLly
         vI+tPFsYps4kb1WRuYYI0/5O5rd5A4Akp4ycO1HcZNRCZZEKAVswqYxQ3/FDeJ2GgF
         MGxVLv17ZhHdrhpoUku43f8Y4qFvnODKOlYRHXUvW9T7IhwEyzVpFDRMX1OcjmpLrp
         F6HzVHtZUb1jA==
Date:   Thu, 23 Sep 2021 14:50:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sanket Goswami <Sanket.Goswami@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based
 on the APU
Message-ID: <YUz2t+bdes2I+gMK@archlinux-ax161>
References: <20210916124002.2529-1-Sanket.Goswami@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916124002.2529-1-Sanket.Goswami@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 06:10:02PM +0530, Sanket Goswami wrote:
> IdleMask is the metric used by the PM firmware to know the status of each
> of the Hardware IP blocks monitored by the PM firmware.
> 
> Knowing this value is key to get the information of s2idle suspend/resume
> status. This value is mapped to PMC scratch registers, retrieve them
> accordingly based on the CPU family and the underlying firmware support.
> 
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>

This patch as commit f6045de1f532 ("platform/x86: amd-pmc: Export
Idlemask values based on the APU") in -next causes the following errors
when CONFIG_DEBUG_FS is disabled:

drivers/platform/x86/amd-pmc.c:424:2: error: implicit declaration of function 'amd_pmc_idlemask_read' [-Werror,-Wimplicit-function-declaration]
        amd_pmc_idlemask_read(pdev, dev, NULL);
        ^
drivers/platform/x86/amd-pmc.c:424:2: note: did you mean 'amd_pmc_reg_read'?
drivers/platform/x86/amd-pmc.c:131:19: note: 'amd_pmc_reg_read' declared here
static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
                  ^
drivers/platform/x86/amd-pmc.c:448:2: error: implicit declaration of function 'amd_pmc_idlemask_read' [-Werror,-Wimplicit-function-declaration]
        amd_pmc_idlemask_read(pdev, dev, NULL);
        ^
drivers/platform/x86/amd-pmc.c:536:2: error: implicit declaration of function 'amd_pmc_get_smu_version' [-Werror,-Wimplicit-function-declaration]
        amd_pmc_get_smu_version(dev);
        ^
3 errors generated.

Should these functions be stubbed or should there be a different fix?

Cheers,
Nathan
