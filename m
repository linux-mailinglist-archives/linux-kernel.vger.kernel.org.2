Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4F3A0DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhFIHk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:40:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:35878 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhFIHkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:40:53 -0400
IronPort-SDR: U/aD8rpYH2ed20DY3VHHuoDngzMq1E4lDIH1da7b6mDAkOx0U2u9um3+tASiHY5vSulWEDvs7w
 2A0WTk1ZGKNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192132376"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192132376"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 00:38:58 -0700
IronPort-SDR: aymcSzkjsK4Lz0m+QUTmT6eeeCYEHc3zyaPEi7uTXFauEozHlNq4DdtHuYu8BdtzN1usKgamJn
 CU2VCD9sUJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552588612"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:38:55 -0700
Cc:     baolu.lu@linux.intel.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove redundant assignment to variable agaw
To:     Colin King <colin.king@canonical.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
References: <20210416171826.64091-1-colin.king@canonical.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b83cb027-2944-2477-c0d2-78f57cf6c6cf@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:37:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416171826.64091-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:18 AM, Colin King wrote:
> From: Colin Ian King<colin.king@canonical.com>
> 
> The variable agaw is initialized with a value that is never
> read and it is being updated later with a new value as a
> counter in a for-loop. The initialization is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King<colin.king@canonical.com>

Queued for v5.14. Thanks!

Best regards,
baolu
