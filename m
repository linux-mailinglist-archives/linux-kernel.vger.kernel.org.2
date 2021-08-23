Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029AB3F46C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhHWIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhHWIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:45:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:44:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so519567edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUE9OJKkP1QI+2yCSiJZEjjQO84qj2H/zJA5KUoRH1k=;
        b=JakRxGtZy/y0fP4/Rc73Qh66wozPZY8cqRojRoCax28Q26tDizOEkWQGWP2Paim/if
         YXkJ0U7XR5bGysagH61PZcWIsAjDUtFJGUxfh2wHdJZDpoAwab6IPRZNA1w8uexpRL8X
         kJjdL31aIWmhO681NsZX6GC0xsyg/1pH9fPnG9YgQBT4csXMXMMGfq2F0QKJRDvxPcdy
         3Jv/tPSwWxbTaDodMWurRl6FiQwbpglKvvbQQfZ8RHTx+tL2ql3Ju8aigBR6ticb8s/J
         Z92e/dOr+feH9nC/GLIarXoQnA2ejC6vYNTVMO2Uw6imWZZLW2PNUuIhJiVqLmv/R2PM
         ULWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUE9OJKkP1QI+2yCSiJZEjjQO84qj2H/zJA5KUoRH1k=;
        b=O10+wfRu1bbZm06nMEbs3t8OxcbMt4IBxctJPKFVBXqdq2zsaWsENDdJFfAO5elj32
         BbF31bgvLQJrJhV1sfWWUW/SgNG14VRjDUzmkwprbDQwzGt5+ZcutG0lxg2KHX1qmahy
         EFrOgaSULQKcsA1xUH8m+Koq0Hf1CCmBeJmpAj933BT8a0WA56dXrZlwxFAwVVXF5ebx
         PuGOiQoF1Y2YctfxG+nk7SRHCzMDPzcH1yromVKlMUQ1PBmGkdPUwhcUNj0bI0s6SJ3r
         rEk5YBEh7vG337JzcW2yc9Xng7y3o0Yq7b5VW3cv0AuX88rTrb6/QxaR+nOKCCBUBoHH
         +I9g==
X-Gm-Message-State: AOAM53130oQRE6lDyDOXkhtj+MNnugh9LZV1SZMkyf5uqlsJ93rorpgI
        Inkj7Az/9DQ1m9oz93AxMyA=
X-Google-Smtp-Source: ABdhPJxBKK4cWjt69sE+zbI8RQCEjnmVzTDIEQwFz/b/TTJwzxr3ULHHkeqxXGufz2PMXpW88+UaMQ==
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr36864790edv.128.1629708271883;
        Mon, 23 Aug 2021 01:44:31 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id x13sm7003546ejv.64.2021.08.23.01.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 01:44:31 -0700 (PDT)
Date:   Mon, 23 Aug 2021 14:14:26 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/21 09:48PM, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:836:54: warning: cast to restricted __be32
> 
> dhpch->cookie is be32, change it's type.
> 
> Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index f6d1f6029ec3..f65d94bfa286 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -649,7 +649,7 @@ struct dhcpMessage {
>  	u_int8_t chaddr[16];
>  	u_int8_t sname[64];
>  	u_int8_t file[128];
> -	u_int32_t cookie;
> +	__be32 cookie;
>  	u_int8_t options[308]; /* 312 - cookie */
>  };
>  
> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
>  					struct dhcpMessage *dhcph =
>  						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> +					u32 cookie = be32_to_cpu(dhcph->cookie);
>  
>  					if (cookie == DHCP_MAGIC) { /*  match magic word */
>  						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
> -- 
> 2.32.0
> 

David Laight suggested to use get_unaligned_be32, I am not sure if it's
the right thing to do because as far as I understand get_unaligned_be32
byteshifts the argument.

Can someone please confirm if this change is okay?

Thanks,
Aakash Hemadri.
