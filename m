Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968093CD001
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhGSIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:24:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:53499 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhGSIYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:24:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="232785434"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="232785434"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 01:43:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="468349775"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 01:43:00 -0700
Subject: Re: [kbuild-all] Re: [linux-chenxing:mstar_v5_14_rebase_i2_drm
 257/349] drivers/clk/mstar/clk-msc313-mux.c:27:2: error: implicit declaration
 of function 'regmap_field_read'; did you mean 'regmap_field_write'?
To:     Daniel Palmer <daniel@0x0f.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202107190200.Z2RoQoYz-lkp@intel.com>
 <CAFr9PXng3dVVeHm8Xcy3i7MfjnPOM8ewCtGAWWUcgBZcM+RJqw@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <4280701c-4051-89a5-c280-4765193d518e@intel.com>
Date:   Mon, 19 Jul 2021 16:42:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXng3dVVeHm8Xcy3i7MfjnPOM8ewCtGAWWUcgBZcM+RJqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 1:17 PM, Daniel Palmer wrote:
> On Mon, 19 Jul 2021 at 03:52, kernel test robot <lkp@intel.com> wrote:
>> tree:   git://github.com/linux-chenxing/linux.git mstar_v5_14_rebase_i2_drm
> Is it possible to stop this bot from building branches that don't make
> any sense?

Hi Daniel,

Thanks for the advice, we'll stop testing such 'rebase' branches.

Best Regards,
Rong Chen


> This branch for example was a work branch for reverse engineering the
> display hardware and has a lot of junk in it.
>
> Cheers,
>
> Daniel

