Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA5307458
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhA1LDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:03:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:57350 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhA1LDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:03:14 -0500
IronPort-SDR: 7JjdeQuKJ6Xoq7YoTmsC3sqT5A5HXCj031UyXYWE+PvIuPJBoAdtANfilKeWeg4YJybXYvcSRh
 fh+E5qf2Mhtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159987851"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="159987851"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 03:01:28 -0800
IronPort-SDR: K0tKeK4UfSNJkw/XjLaLthlwZzyhhclERSL+T8p80z6yNHYhnmq5Dvu9sc2E2mJqaMmZ/uqeLz
 /Yo+ak94yk0w==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="369811507"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 03:01:25 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Jan 2021 13:01:22 +0200
Date:   Thu, 28 Jan 2021 13:01:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH V2 01/12] thunderbolt: dma_port: Check
 'dma_port_flash_write_block()'s return value
Message-ID: <20210128110122.GQ2542@lahna.fi.intel.com>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210127112554.3770172-2-lee.jones@linaro.org>
 <20210128085233.GE4774@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128085233.GE4774@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:52:33AM +0000, Lee Jones wrote:
> ... and take the error path if it fails.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/thunderbolt/dma_port.c: In function ‘dma_port_flash_write_block’:
>  drivers/thunderbolt/dma_port.c:331:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied, thanks!
