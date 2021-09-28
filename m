Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3541AD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhI1K4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:56:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:49172 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240268AbhI1K4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:56:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="247178588"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="247178588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:54:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="437162852"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:54:33 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 Sep 2021 13:54:31 +0300
Date:   Tue, 28 Sep 2021 13:54:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 1/3] platform/x86: intel_scu_ipc: Fix busy loop expiry
 time
Message-ID: <YVL0Z6Y+91XGFkDO@lahna>
References: <20210928101932.2543937-1-pmalani@chromium.org>
 <20210928101932.2543937-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928101932.2543937-2-pmalani@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:19:30AM -0700, Prashant Malani wrote:
> The macro IPC_TIMEOUT is already in jiffies (it is also used like that
> elsewhere in the file when calling wait_for_completion_timeout()). Don’t
> convert it using helper functions for the purposes of calculating the
> busy loop expiry time.
> 
> Fixes: e7b7ab3847c9 (“platform/x86: intel_scu_ipc: Sleeping is fine when polling”)
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
