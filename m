Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE23361E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhDPLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:20:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:9412 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPLT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:19:57 -0400
IronPort-SDR: yuk6dktqCJoke4B43c3fxCoq/DA9rQgLYOEHJ0WHRfuPmgH2X8ilnwUlGn3TuXDDLaiL45Q7Z4
 2mQG80zaP8iA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="195052352"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="195052352"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 04:19:32 -0700
IronPort-SDR: BJZDC5Jq+ygLeIOUlN5DHtRSPA54UoNQksLH1UDbp79GVwgghc+S2OVAoPSCFnBDJYUy8lcCQt
 LxOAcsVCbvTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="601439675"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2021 04:19:28 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Tao Zhang <taozha@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Tao Zhang <taozha@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 1/2] coresight: Add support for device names
In-Reply-To: <1618560476-28908-2-git-send-email-taozha@codeaurora.org>
References: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
 <1618560476-28908-2-git-send-email-taozha@codeaurora.org>
Date:   Fri, 16 Apr 2021 14:19:27 +0300
Message-ID: <87im4mfpds.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao Zhang <taozha@codeaurora.org> writes:

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4ba801d..b79c726 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1640,6 +1640,12 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>  	int idx;
>  	char *name = NULL;
>  	struct fwnode_handle **list;
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node) {
> +		if (!of_property_read_string(node, "coresight-name", &name))

Ok, I'm not a device tree expert, but I'm pretty sure the above is a
nop.

Regards,
--
Alex
