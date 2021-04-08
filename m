Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6782D35899D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhDHQYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:24:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:64328 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhDHQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:24:02 -0400
IronPort-SDR: ptbbYuqivCv3P5KGkk2u69wb+jqjy5gu3jF+OAx9ERElfPHoveY23pCQfT2LGDtGwEvJEZS6Nd
 XI/5jf6unESA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193620668"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="193620668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 09:23:50 -0700
IronPort-SDR: zQ8NVGO9Cp+b7nldp4JZA4a/OVNeGAk1jg64DUMQGFfJRHJPvJ1ddcJhaZnQ00MsgtgnuTbeDS
 XajlMa+ld7zQ==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="397145042"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 09:23:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUXRZ-002KgE-G9; Thu, 08 Apr 2021 19:23:45 +0300
Date:   Thu, 8 Apr 2021 19:23:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] defconfig: enable GPIO_SIM
Message-ID: <YG8uEWy6Bh04grM7@smile.fi.intel.com>
References: <20210408155441.12297-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408155441.12297-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:54:41PM +0300, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


