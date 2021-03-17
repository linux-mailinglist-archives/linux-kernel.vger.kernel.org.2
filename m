Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1256833F71C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhCQRd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhCQRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:32:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D21C06174A;
        Wed, 17 Mar 2021 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=M2U69fnHtSDeQy8UM59zhzg/Vai3uTHHXB9W3I5zXPg=; b=gBs8YaMxW+u/Tsz1jBGmoQpZsZ
        jPW07LUYgAwo3GS74aRF+JVVxN2JW7QMAeBUcVDI0EHjNfP+jbHaORzfLlgNviDrVBSrXhKeu3qpf
        ZMm2Gw7QXAf1hO7JKLnhEiFvncqd6lXeJa9qaYQLjYVXDIj+kjlc9h6QaxOnD2R6Rdjo/roAjiBNj
        DAyNTSC/isoGJoji7buiqtrej7vcHGo4DPh77d0SeJHIlCMUrJSyE+sTKLhxrJucrHeWIEtlkdSyh
        VAVZ117uCMZmTh3w32DiTfc1To3BcP0W4UuoBuTIAYpikXzpMKPCbXutWMKvBMKJ9BaKObQKUuheK
        peq9IHwA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa2Q-001fTl-TX; Wed, 17 Mar 2021 17:32:56 +0000
Subject: Re: [PATCH] devicetree: bindings: clock: Minor typo fix in the file
 armada3700-tbg-clock.txt
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20210317100840.2449462-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <546989ea-c6b2-42e4-46b2-d7de5d208728@infradead.org>
Date:   Wed, 17 Mar 2021 10:32:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317100840.2449462-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 3:08 AM, Bhaskar Chowdhury wrote:
> 
> s/provde/provide/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Bhaskar,

Did you send this one to "robh+dt@kernel.org"?
AFAICT, it was sent to "dt@kernel.org", which bounces.

If you used "robh+dt@kernel.org", it appears that 'get send-email' has a problem with that.

thanks.

> ---
>  .../devicetree/bindings/clock/armada3700-tbg-clock.txt          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
> index 0ba1d83ff363..ed1df32c577a 100644
> --- a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
> @@ -1,6 +1,6 @@
>  * Time Base Generator Clock bindings for Marvell Armada 37xx SoCs
> 
> -Marvell Armada 37xx SoCs provde Time Base Generator clocks which are
> +Marvell Armada 37xx SoCs provide Time Base Generator clocks which are
>  used as parent clocks for the peripheral clocks.
> 
>  The TBG clock consumer should specify the desired clock by having the
> --


-- 
~Randy

