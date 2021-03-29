Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5534D6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhC2SRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhC2SRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:17:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC1C061574;
        Mon, 29 Mar 2021 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=w3n6ycLm4n1SSQiOYkwgaV89Fzkl7RLAkF0UMWzZ4G8=; b=fczFwQn+vQmCM2aZFnLhYBGEcH
        +8PH+ZyVcqWv8pyDuJOSRivWTXdTA7tIOUPwlQc/+9Vh5psUQTFY+49M5B+p4eTfzkul/u2g/ZhTj
        26Yj3N+ZvF/ZdI8qBVOHO2hZY7A7X/M6Z4vK2iKSJdhEooHLpVCGvUyi8zEzTRtBwGFOuB1q4qVFJ
        YFdN8Ou1eY9j/x7p+JiDSq2XvsU5vq9GzSX32cp+m+GttY1BtXz4HploGBaGGyhilOJQ3E6oamMji
        biLUzthJWb4Ziy2hQPk6OhZd1ZFMgS3siRlJIclt5xLDYkfRnVhcHEz2w3vsraXCWzjzjN2Dl9ovH
        XbHF78ng==;
Received: from [2601:1c0:6280:3f0::4557]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQwQc-0010mF-Mx; Mon, 29 Mar 2021 18:16:04 +0000
Subject: Re: [PATCH] usb: dwc3: st: fix incorrect kernel-doc comment syntax in
 file
To:     Aditya Srivastava <yashsri421@gmail.com>,
        patrice.chotard@foss.st.com
Cc:     lukas.bulwahn@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329132014.24304-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfdf5685-30f6-4fad-f9e8-8605dce3668d@infradead.org>
Date:   Mon, 29 Mar 2021 11:15:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329132014.24304-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 6:20 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/usb/dwc3/dwc3-st.c follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> "warning: expecting prototype for dwc3(). Prototype was for CLKRST_CTRL() instead"
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> * Applies perfectly on next-20210326
> 
>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index b06b7092b1a2..166b5bde45cb 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -/**
> +/*
>   * dwc3-st.c Support for dwc3 platform devices on ST Microelectronics platforms
>   *
>   * This is a small driver for the dwc3 to provide the glue logic
> 


-- 
~Randy

