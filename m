Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07023F3672
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhHTWae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhHTWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:30:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C8C061575;
        Fri, 20 Aug 2021 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=izXKzWURE6SXRuGkgwQXavYNCbp4aPyrNz1Al+9X7vI=; b=oskR+vO3L/UKRtBOg6l2gmsOYj
        YDAk10Orsa8jcyDN3ZzUH4+cvTTmms3KwaxeilSt8LQ9t4mltrNHw9mSsRp6TzkChNKONYNL3W6ll
        7tlmqEW5KGyLS2SNdZxABRxpjJO/gbmcRemMC+xVJjDiAb1fik4CTWlQjEnPnGZBX7V1Kl4un2cwr
        pSid5fotEslEefRi40I7HopgWWm7qk20VMqrOf7gzh+J/RHlE5fZzbpzMpJ9XxEXRSBNV9jp7v+/E
        nvZ5B/Z4lhgEh/yHhA4l9RXH17mO/4ruTT6azAad1CUfKY5bWJi2sL6uupY7k/SRP4kU7vCg3AXMB
        Q+gBxFdA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHD1O-00CCAZ-ET; Fri, 20 Aug 2021 22:29:54 +0000
Subject: Re: [PATCH v2] clk: zynqmp: fix kernel doc
To:     Rajan Vaja <rajan.vaja@xilinx.com>, mturquette@baylibre.com,
        sboyd@kernel.org, michal.simek@xilinx.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1629445113-32649-1-git-send-email-rajan.vaja@xilinx.com>
 <1629446294-1056-1-git-send-email-rajan.vaja@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd0903a4-6d7a-ab52-7dec-dfd8e978daf7@infradead.org>
Date:   Fri, 20 Aug 2021 15:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1629446294-1056-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 12:58 AM, Rajan Vaja wrote:
> Add missing description of 'custom_type_flag' structure member.
> 
> Fixes: e605fa9c4a0c ("clk: zynqmp: Add support for custom type flags")
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
> Changes in v2:
>   - Updated Fixes tag.
> ---
>   drivers/clk/zynqmp/clk-zynqmp.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
> index 84fa80a..a3cd2f8 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -56,6 +56,7 @@ enum topology_type {
>    * @type:	Type of topology
>    * @flag:	Topology flags
>    * @type_flag:	Topology type specific flag
> + * @custom_type_flag: Topology type specific custome flag

                                                 custom

>    */
>   struct clock_topology {
>   	u32 type;
> 


-- 
~Randy

