Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547D8351EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbhDAStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:49:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:38799 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240125AbhDAS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:29:22 -0400
IronPort-SDR: +weMuVD8KWBfuzvQKX0VUdX4QPaj0gcMewtXIgHpcRRmQrdDFLs+HT47mjIq3bBx3liWMRBI6k
 8emv8/2Ujhww==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179810980"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179810980"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:20 -0700
IronPort-SDR: 72C3Wd8VzEv1rKIMk9QywCU1PmokvTgQL5VxGjUpjtLwURP/BE+pIcIeNiUySjKOgaFl60ueS4
 4yj/m7NdYN6Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439265752"
Received: from mooreale-mobl.amr.corp.intel.com (HELO [10.255.229.43]) ([10.255.229.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:16 -0700
Subject: Re: [PATCH] soundwire: intel_init: test link->cdns
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
References: <20210331010250.14151-1-yung-chuan.liao@linux.intel.com>
 <YGV0a+ZnTh7A8DD0@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6dae2b2d-b482-4e29-4543-62126780725c@linux.intel.com>
Date:   Thu, 1 Apr 2021 09:31:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGV0a+ZnTh7A8DD0@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 2:21 AM, Vinod Koul wrote:
> On 31-03-21, 09:02, Bard Liao wrote:
>> intel_link_probe() could return error and dev_get_drvdata() will return
>> null in such case. So we have to test link->cdns after
>> link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
>> Otherwise, we will meet the "kernel NULL pointer dereference" error.
> 
> This fails to apply for me

probably a dependency on the auxiliary bus transition?
