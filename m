Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B7C3C72FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhGMPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhGMPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:19:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE2C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:16:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 21so19942728pfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=91peoSJ0PBLVlMtyFoEBCQE1ene1ra9TecasmLqGkDo=;
        b=Ujt0jnll95O35CTZEOpWcg4yfWcMuQuwe0SasFzttpPg4VRQzqgbhKARVA6XdzjTgO
         RuWANCnmV9eNyw3fjXCCtgr9pO9qPj3OrU9LpQQNDQeCCjiPUbcTVbbk+3oUrAozo4YO
         DMrHCYLuQjh3HH7Vxu4il0tuw3Yx/+pvSjQ1gQD7yqm/kpmpk7Zgch+hwNiRWMq1nt+w
         iImDrLFKZJIAuDDnn6nMBASlpJ43aNW6gzvOt5TBgUbVI8gNG8QUzg9O5tSWHtf3/GsK
         BBdbf0P3GEVMiExnDZ4CUpa9Qazrt/k2ouwzXmQI4M+FAmbN08BV/6tVuCfQy2zDzEmK
         xx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=91peoSJ0PBLVlMtyFoEBCQE1ene1ra9TecasmLqGkDo=;
        b=REjRiTfSllG3N16eJAnnDDbyaUgZdbsIOJKiBOi6focZ6iZbta/8kvwSZjgb8kjcpw
         RtZE+CfbUB6Sw8Nvh0PuvKz+6UpVMeKInkxq3p3ZTjFLnMUUu/2WmQk6UelEeU89goN5
         0PAIWK96w+/b8sHU6EmaubokBEknmvJ+BbNXnnXvIvFfzRiIhIIcO7bu1wMoT1vRObv8
         kn05tpEALCQ81n1hgBKS0fn6XFFdpIP3UIIUNnhcJI8nzmP7Q3d7RcjSUaGi//gKmOuO
         6yHPvU1xjzIIEL8s1g8F7QjwwlnbduIJHdKlRq3vYbuN9IBAVUjJVPqN2o5L0CduK7SG
         kIwA==
X-Gm-Message-State: AOAM532E4y3D6+GVv5ji9OivHF2vY7vFBM39mDGVLmNrUwGbAHFaigJ7
        PAd1WxFa6Ee577GtlMO3drn+Ga9QWgvSGQ==
X-Google-Smtp-Source: ABdhPJxg5dN+rerGopytXEj4MtB9aUJVnLId/gt3Xt7NImr2eQDKjnIC+d7AwADKzbuTL0jJf907tg==
X-Received: by 2002:a65:568c:: with SMTP id v12mr4866454pgs.88.1626189411737;
        Tue, 13 Jul 2021 08:16:51 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local ([50.53.47.17])
        by smtp.gmail.com with ESMTPSA id g12sm3381550pjk.25.2021.07.13.08.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 08:16:51 -0700 (PDT)
Subject: Re: [PATCH] i40e: Fix error handling code of label err_set_queues
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Catherine Sullivan <catherine.sullivan@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210713122028.463450-1-mudongliangabcd@gmail.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <58d854d9-a371-7689-d396-de1c26b34bfa@pensando.io>
Date:   Tue, 13 Jul 2021 08:16:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713122028.463450-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 5:20 AM, Dongliang Mu wrote:
> If i40e_up_complete fails in i40e_vsi_open, it goes to err_up_complete.
> The label err_set_queues has an issue: if the else branch is executed,
> there is no need to execute i40e_vsi_request_irq.

This is unnecessary: if the else branch is executed then control will 
goto err_setup_rx, skipping over i40e_up_complete().

sln

>
> Fix this by adding a condition of i40e_vsi_free_irq.
>
> Reported-by: Dongliang Mu (mudongliangabcd@gmail.com)
> Fixes: 9c04cfcd4aad ("i40e: Fix error handling in i40e_vsi_open")
> Fixes: c22e3c6c7912 ("i40e: prep vsi_open logic for non-netdev cases")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 861e59a350bd..ae54468c7001 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8720,7 +8720,8 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
>   err_up_complete:
>   	i40e_down(vsi);
>   err_set_queues:
> -	i40e_vsi_free_irq(vsi);
> +	if ((vsi->netdev) || (vsi->type == I40E_VSI_FDIR))
> +		i40e_vsi_free_irq(vsi);
>   err_setup_rx:
>   	i40e_vsi_free_rx_resources(vsi);
>   err_setup_tx:

