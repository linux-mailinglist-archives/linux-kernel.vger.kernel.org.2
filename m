Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA06C3CBBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGPSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:46:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:40862 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhGPSql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:46:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="232619639"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="232619639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:43:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="497102536"
Received: from mohalshu-mobl2.amr.corp.intel.com (HELO [10.212.40.103]) ([10.212.40.103])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 11:43:45 -0700
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <050073c4-5ea0-183d-5bd0-7df388fcce33@linux.intel.com>
Date:   Fri, 16 Jul 2021 13:43:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,
Going back to this initial patch, I have a doubt based on Andy Shevchenko's comment on an update [1]

> The function device_add_properties() is going to be removed.
> Replacing it with software node API equivalents.

The replacement pattern takes this one line:

> -	ret = device_add_properties(sdw_dev, props);

which gets replaced by

> +	fwnode = fwnode_create_software_node(props, NULL);
> +	if (IS_ERR(fwnode)) {
> +		return PTR_ERR(fwnode);
>  	}
>  
> +	ret = device_add_software_node(sdw_dev, to_software_node(fwnode));
> +
> +	fwnode_handle_put(fwnode);

is the fwnode_handle_put() actually required here? This seems to work fine in our tests but I wasn't able to find in the code a matching _get().

Thanks for any pointers/comments!
-Pierre

[1] https://github.com/thesofproject/linux/pull/3041#discussion_r671450168

