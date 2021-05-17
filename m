Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285B2382949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhEQKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhEQKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:02:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD23C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:00:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so8274703ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJNE2Pur46fG7uv1+u/9hia0s0ykMd+z602mYJyefV0=;
        b=OB5oeorVRUK/qUfMJ4Da2aMpGfyYHjZ4FYYGvGyGwpRm4qa7VjBTapqx6JfPkNZnJo
         kh9KoWSkonNp5LIpdAMr6fynOYGdD502gC402MuIbqq/4BaUfpDB6d/kK6Yk31aj0zAU
         XrG2yZk8sUOvC4tMiw6O91t8sXSq+J14QfLvibcKFRw1/Pf0GRvEPVBq94E/q2ylu+JC
         f095yq1FaMPAVILQAWTNN7KHTO7ISM60E+AMNCjoyPrKyI+eovwi9zDZs5mPxEvHzJbj
         QXXrJRtktYOfj0CuzcksoT+RHqxyrquKQpTJG2bNSSBeHcZmknWli/LqXRpWBQ2q0gHX
         wIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJNE2Pur46fG7uv1+u/9hia0s0ykMd+z602mYJyefV0=;
        b=i8+rndyQROqa8ZTZX7texqH3nGgKkSZzwzNRSErvYMEFLE44fxWsDfrY09FXVBIfAj
         Cbg/J4NQgzD5FeY22e9uXHB2TURLBtU64CWxsaXOYZxcsEkOSHzZeKo8oSxHg0MFv//g
         EB2cA4viFAajhXsH7V6Jl0i1KC9vBg8ui9W18e9G4kFommppwYIpGSuOAlw5XgxNhQM8
         KeOnnVe71b2mCYZ1lsWcf+u77EJDcTMNiwfbTdmpLGkAtpfUKZY3OZL1UX3Zunz9Gy1Y
         bsM3wHVMNJdg2x/uch1IFQez1qgvUbl/mw7R/F9YuhYmYVcQz86OiRb/boc+3hvsr2N0
         bqUQ==
X-Gm-Message-State: AOAM533qTo8gy5GV7LBuMx/ZCEcnTZ8rEj1Rnos5Dtly4qS9riQxjmM0
        C7u6uxw6BLKZfeb28H8RypvK8w==
X-Google-Smtp-Source: ABdhPJzvNkCj/eQGhuaE+a/oxSpakoRoMQmGWLOV3cAWdjX/6AJDb4DL8uKGBpza2xqt6ky3rcCFJA==
X-Received: by 2002:a17:906:9bf3:: with SMTP id de51mr14450347ejc.394.1621245604338;
        Mon, 17 May 2021 03:00:04 -0700 (PDT)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id n25sm10610092edb.26.2021.05.17.03.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:00:03 -0700 (PDT)
Date:   Mon, 17 May 2021 12:00:03 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/24] net: netronome: nfp: Fix wrong function name in
 comments
Message-ID: <20210517100002.GC17134@netronome.com>
References: <20210517044535.21473-1-shenyang39@huawei.com>
 <20210517044535.21473-18-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517044535.21473-18-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:45:28PM +0800, Yang Shen wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/ethernet/netronome/nfp/ccm_mbox.c:52: warning: expecting prototype for struct nfp_ccm_mbox_skb_cb. Prototype was for struct nfp_ccm_mbox_cmsg_cb instead
>  drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c:35: warning: expecting prototype for struct nfp_tun_pre_run_rule. Prototype was for struct nfp_tun_pre_tun_rule instead
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c:38: warning: expecting prototype for NFFW_INFO_VERSION history(). Prototype was for NFFW_INFO_VERSION_CURRENT() instead
> 
> Cc: Simon Horman <simon.horman@netronome.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

