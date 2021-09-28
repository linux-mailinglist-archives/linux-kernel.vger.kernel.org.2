Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A841AD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhI1K45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:56:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:1511 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240283AbhI1K4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:56:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224707453"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="224707453"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:55:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="562185231"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:55:12 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 Sep 2021 13:55:09 +0300
Date:   Tue, 28 Sep 2021 13:55:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86: intel_scu_ipc: Increase virtual
 timeout to 10s
Message-ID: <YVL0jSa1TTgDA4q+@lahna>
References: <20210928101932.2543937-1-pmalani@chromium.org>
 <20210928101932.2543937-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928101932.2543937-3-pmalani@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:19:32AM -0700, Prashant Malani wrote:
> Commit a7d53dbbc70a ("platform/x86: intel_scu_ipc: Increase virtual
> timeout from 3 to 5 seconds") states that the recommended timeout range
> is 5-10 seconds. Adjust the timeout value to the higher of those i.e 10
> seconds, to account for situations where the 5 seconds is insufficient
> for disconnect command success.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
