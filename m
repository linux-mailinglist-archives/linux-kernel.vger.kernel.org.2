Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1436361E89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhDPLYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:24:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:60361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPLYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:24:15 -0400
IronPort-SDR: CX2UtKabqx/ThLARiBrF5DsL6Nk+/G/zP/JIA+Eqbe/KW6X9zy33mO/E6wVN0zfevpgFnqjrz4
 RZUi1bRlkOMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="256340963"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="256340963"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 04:23:50 -0700
IronPort-SDR: o7c4eS4/Y4o1QRqIVSMMB5UDax1ntltuDQEbP/gd9zJkeAiRFsgaex5lM/jbNbT9I/k5STWouX
 YN+5BJ5dFETQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="419086794"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2021 04:23:46 -0700
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
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: add property for coresight
 component name
In-Reply-To: <1618560476-28908-3-git-send-email-taozha@codeaurora.org>
References: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
 <1618560476-28908-3-git-send-email-taozha@codeaurora.org>
Date:   Fri, 16 Apr 2021 14:23:45 +0300
Message-ID: <87fszqfp6m.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao Zhang <taozha@codeaurora.org> writes:

> Add property "coresight-name" for coresight component name. This
> allows coresight driver to read device name from device entries.
>
> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d711676..0e980ce 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -103,6 +103,8 @@ its hardware characteristcs.
>  	  powers down the coresight component also powers down and loses its
>  	  context. This property is currently only used for the ETM 4.x driver.
>  
> +	* coresight-name: the name of the coresight devices.

Which devices? Also, is it a common practice to extend device tree
definitions based on arbitrary driver needs, or should there be some
sort of a discussion first?

Regards,
--
Alex
