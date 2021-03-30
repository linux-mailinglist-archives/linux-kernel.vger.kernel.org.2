Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2434E469
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhC3J2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:28:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:52474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhC3J1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:27:55 -0400
IronPort-SDR: FmLwIWdrycTjtCGU48IKsjORO2j0lFl9HMDPjOR7XdhzhS/TxZ6OQKXMa26uuXxEV32dhLd0WL
 +CJ4NH6Hrh0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191827894"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="191827894"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:27:54 -0700
IronPort-SDR: NGyOk8Pq9GPJhyqKTMQnUVP/6Dn72a+jzNfj+ktA4nZvcWxCojhA9KpIYddOf8eQt9FOO3u2W0
 zrhd909dW+og==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="445133425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:27:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lRAf7-00HHy7-4R; Tue, 30 Mar 2021 12:27:49 +0300
Date:   Tue, 30 Mar 2021 12:27:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joe Perches <joe@perches.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] misc/pvpanic: fix return value check in
 pvpanic_pci_probe()
Message-ID: <YGLvFTWjEAOfs3db@smile.fi.intel.com>
References: <20210330013659.916-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330013659.916-1-linqiheng@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:36:59AM +0800, Qiheng Lin wrote:
> In case of error, the function pci_iomap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Error path there is broken completely, this is only one place you fix, but I
suggest to switch to devm*, pcim* APIs instead,


-- 
With Best Regards,
Andy Shevchenko


