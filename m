Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E738D41AD63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhI1K5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:57:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:36550 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240238AbhI1K5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:57:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="204822824"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="204822824"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:55:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="520409501"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:55:50 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 Sep 2021 13:55:47 +0300
Date:   Tue, 28 Sep 2021 13:55:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 3/3] platform/x86: intel_scu_ipc: Update timeout value in
 comment
Message-ID: <YVL0s/HiQMits8M6@lahna>
References: <20210928101932.2543937-1-pmalani@chromium.org>
 <20210928101932.2543937-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928101932.2543937-4-pmalani@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:19:34AM -0700, Prashant Malani wrote:
> The comment decribing the IPC timeout hadn't been updated when the
> actual timeout was changed from 3 to 5 seconds in
> commit a7d53dbbc70a ("platform/x86: intel_scu_ipc: Increase virtual
> timeout from 3 to 5 seconds") .
> 
> Since the value is anyway updated to 10s now, take this opportunity to
> update the value in the comment too.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
