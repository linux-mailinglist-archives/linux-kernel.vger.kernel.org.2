Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01F3A0DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhFIHlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:41:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:4080 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhFIHlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:41:49 -0400
IronPort-SDR: lPjvnVmCPt9swgK553Hb395krJfGfCYgpf8jDLSYhHqoJwwZqK4l02/mogdh3IVKvDc1L95XMP
 fNeFuF+FE0Tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226388873"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="226388873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 00:39:54 -0700
IronPort-SDR: AYtn74xIwP8My0IIMbt5vdLIRcpsAeU0Wcq1r9Tv+oWPyUlWLIDCE17iGrDeZRwr9pshWLHezV
 EL0X2dzYoaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552588883"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:39:51 -0700
Cc:     baolu.lu@linux.intel.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, dwmw2@infradead.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: fix kernel-doc syntax in file header
To:     Aditya Srivastava <yashsri421@gmail.com>, will@kernel.org
References: <20210523143245.19040-1-yashsri421@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cb50b161-5a72-7eb6-f912-3583ebd75d33@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523143245.19040-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 10:32 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/iommu/intel/pasid.c follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc:
> warning: Function parameter or member 'fmt' not described in 'pr_fmt'
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava<yashsri421@gmail.com>

Queued for v5.14. Thanks!

Best regards,
baolu
