Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317F740D1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 04:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhIPCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhIPCv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 22:51:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CECC061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:50:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y17so4484805pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gWv6A3N5Yoof/ABF4bujeBdmvTFTrxpZ3ifZ7Z7xsk=;
        b=hOaKMvo1/kiv6cwd+a/HUqfJVfZUpygDQMkuaQaPCr8xgggvoxG9W40HCfpb0Dca1R
         F4Twq+CxnURmX3R11GkAX0nUXSctb6t/n955g3uVO1rpAM9c+15hDy8k4dfcI6ypMEmR
         8U0TsNriQE2ZXQ+LtPCTxCkpV9k3oHV6e7iaNJggYl9HWb/V5qzCUJI9K1Kv1hQHeNW/
         EaBO+w6Lu5xVoZLOGZYVn99lk+qpzl5A44jWcAOf2AK0DcUmPc5Zs8inZ0393tm5/YM5
         Dlk7J0QJGjossHqDp5gqM7RXkVsyhGxIhNW+3cCoD0E5W0pnkzgsdcOoGi+sDk5xjSK8
         1uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gWv6A3N5Yoof/ABF4bujeBdmvTFTrxpZ3ifZ7Z7xsk=;
        b=qACvCwNyl2ycWHtvbecj1sFDosD1pz9F8SNOtRkqjQpRD+I1iwixUhgdjmDAnnFcYr
         HEF0VOyXWGFQLMSMn1a7RkSlusKvkNehqeaZ323YuIW3RsuOlBjWGUr+ndpqh5KvfpUb
         WlXp+yIY5nI7iI3/hk3iToYbJIrWYJb6ETYIMLYV6WICn84ytwYd+syJEL9S5vlIz7EO
         UYP1TrkLrf12D+B1RePX6Ol5w5XixJMZ5tIQrU1voSuqQ4FEOa0Vcjsu5jMMz5RNuYXq
         t8/+2f6tv/mCFU2PemJ0TkYmRbBQrsoCRo4nFwqx08NAqzuFkR3w6aeVX8LgZzK6JYpQ
         ElUA==
X-Gm-Message-State: AOAM533DDxDcIbuuN+6UhbQ7nGt956NDJPjSixxEn9dY2aNDnvyhbtcj
        SZFRWxmwF27SF1Pb1StYGgLDIS9JymAsow==
X-Google-Smtp-Source: ABdhPJxV8+ZrX5+vnJALG+G80q/GKoPLRMJuxKfW8NGaZHPOiz8uPoILCwbdg4s4drVHgVBGmqkbUA==
X-Received: by 2002:a63:720d:: with SMTP id n13mr2816612pgc.470.1631760637066;
        Wed, 15 Sep 2021 19:50:37 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id b7sm1187467pgs.64.2021.09.15.19.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 19:50:36 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:50:34 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: Remove extra brackets of nla_for_each_attr()
Message-ID: <20210915195034.280bd610@hermes.local>
In-Reply-To: <1631758028-3805500-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1631758028-3805500-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 02:07:08 +0000
Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> It's obvious that '&(rem)' has unneeded brackets.
> Therefore it's better to remove them.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  include/net/netlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 1ceec51..5822e0d 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1920,7 +1920,7 @@ static inline int nla_total_size_64bit(int payload)
>  #define nla_for_each_attr(pos, head, len, rem) \
>  	for (pos = head, rem = len; \
>  	     nla_ok(pos, rem); \
> -	     pos = nla_next(pos, &(rem)))
> +	     pos = nla_next(pos, &rem))
>  
>  /**
>   * nla_for_each_nested - iterate over nested attributes

No.

nla_for_each_attr is a macro and in a macro, there should be
added parenthesis around any use of macro argument to prevent
unintended side effects.
