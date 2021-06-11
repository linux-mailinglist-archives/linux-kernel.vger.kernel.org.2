Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18B3A3E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFKI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhFKI5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9233A613CB;
        Fri, 11 Jun 2021 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401723;
        bh=wTPeKGSJ+sckHUbyFNhE1pwSgmTAYz8kMgTK6zGybT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSPVw1Iq7VwywfesLSVUh3g20r4nlm80xNKdvmQ0tJA0osmrLshzTR89czAT4O1sg
         QHPJpeFL6E7ceTyX40TmDZqvfw56Qmv61B/n1okkfq5J7JJXQ3gyYdJnLBrs4nm9qY
         B5yjV6zmot0msGw5i7cu76LEsr9HaIga1pW1e3aA=
Date:   Fri, 11 Jun 2021 10:55:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] nvmem: qcom-spmi-sdam: add missing
 MODULE_DEVICE_TABLE
Message-ID: <YMMk+DbxzxAxxNCq@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:41AM +0100, Srinivas Kandagatla wrote:
> Fix module loading by adding missing MODULE_DEVICE_TABLE.
> 
> Fixes: 40ce9798794f ("nvmem: add QTI SDAM driver")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/qcom-spmi-sdam.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
> index 4fcb63507ecd..8499892044b7 100644
> --- a/drivers/nvmem/qcom-spmi-sdam.c
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -166,6 +166,7 @@ static const struct of_device_id sdam_match_table[] = {
>  	{ .compatible = "qcom,spmi-sdam" },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, sdam_match_table);
>  
>  static struct platform_driver sdam_driver = {
>  	.driver = {
> -- 
> 2.21.0
> 

Same comment as patch 1/9
