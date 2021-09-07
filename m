Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A31402C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbhIGQJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:09:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:31931 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245639AbhIGQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:09:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="200445740"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="200445740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:06:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="512893461"
Received: from mrburno-mobl.amr.corp.intel.com (HELO [10.212.10.81]) ([10.212.10.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:06:12 -0700
Subject: Re: [PATCH v2] soundwire: debugfs: use controller id and link_id for
 debugfs
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <53297f34-2353-868d-617b-d9339223799c@linux.intel.com>
Date:   Tue, 7 Sep 2021 10:44:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/21 5:53 AM, Srinivas Kandagatla wrote:
> link_id can be zero and if we have multiple controller instances
> in a system like Qualcomm debugfs will end-up with duplicate namespace
> resulting in incorrect debugfs entries.
> 
> Using bus-id and link-id combination should give a unique debugfs directory
> entry and should fix below warning too.
> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"
> 
> Fixes: bf03473d5bcc ("soundwire: add debugfs support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> Changes since v1:
> 	Added Link ID along with bus id.
> 
>  drivers/soundwire/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index b6cad0d59b7b..49900cd207bc 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -19,7 +19,7 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
>  		return;
>  
>  	/* create the debugfs master-N */
> -	snprintf(name, sizeof(name), "master-%d", bus->link_id);
> +	snprintf(name, sizeof(name), "master-%d-%d", bus->id, bus->link_id);
>  	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
>  }
>  
> 
