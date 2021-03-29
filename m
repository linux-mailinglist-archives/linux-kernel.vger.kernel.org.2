Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4913F34CEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhC2LUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:20:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:42644 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232756AbhC2LUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:20:37 -0400
IronPort-SDR: 9qgv0h0CdeBk2nKlLx6pa8FFfTonH0Q70npkitKMRCdTWvIfy/cT6GF+J/INkxCkLJfrx/Ub2j
 Ct3LIykB+43w==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="252875193"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="252875193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 04:20:35 -0700
IronPort-SDR: 2I84hON4v+DOOSjSljmZJEbCneRUS58o/nIPJIXoubNKhvLOTsnuxwupCLyNv88RpTBoDpmspM
 N1bZOjE4zTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444513440"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2021 04:20:35 -0700
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer to INTEL STRATIX10
 FIRMWARE DRIVERS
To:     trix@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20210327151919.453669-1-trix@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <b29479f6-e6d7-076b-7004-4ecfa0425bd7@linux.intel.com>
Date:   Mon, 29 Mar 2021 06:40:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210327151919.453669-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 3/27/21 10:19 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The Intel stratix 10 is a fpga.  I review fpga's. So I want to help
> in this related subsystem.
> 

Intel Stratix10 service layer driver is not a FPGA.

Intel FPGA SoC is composed of ARM Cortex hard processor system (HPS) and 
Secure Device Manager (SDM). SDM is the hardware which does FPGA 
configuration, remote system update (RSU), crypto service (FCS), warm 
reset and other features.

To meet the whole system security needs and support virtual machine 
requesting communication with SDM, only the secure world of software 
(EL3) can interfaces with SDM. All software entities running on the 
other exception level must channel through the EL3 software whenever it 
needs service from SDM.

Intel Stratix 10 service layer driver, added into Opensource kernel 
mainlines since version 5.0, interfaces with the service provides at EL1 
(FPGA manager, RSU and FPGA crypto service drivers as today) and 
managers secure monitor call (SMC) to communicate with the secure 
monitor software at the secure world (EL3).

Regards,
Richard

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67b104202602..00828de0a7bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9266,6 +9266,7 @@ F:	tools/power/x86/intel-speed-select/
>   
>   INTEL STRATIX10 FIRMWARE DRIVERS
>   M:	Richard Gong <richard.gong@linux.intel.com>
> +R:	Tom Rix <trix@redhat.com >   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> 
