Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656FD33A7F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCNUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhCNUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:21:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB90C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:21:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s17so13799581ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=KhQ8GQxemSKjASj94bgK9DXuv0kgFGsdClfGRmeqb+w=;
        b=dMXp6S+xwIo7qP43hDz1KOxUK23QlXQC8lOseG8YAKVLaZg2QtX2z3Aq+wqZwyh021
         WHFMGrVl8mVdp8TTB97gVZ0ORswGNaiiSaJfjaZfvq/CDBdqfS3t4YK6pkr8klGfD4Ol
         nDbvnzmqQad3kg7iIox5KpBbRdOxU/IQi848E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=KhQ8GQxemSKjASj94bgK9DXuv0kgFGsdClfGRmeqb+w=;
        b=AGUXWHHl0mJ55H9RotgmCSEJsr56d7mg4CRuOW53d3Ejkerzd3lhE+m2ZppAFsIRah
         siekMsPGCtKgbMQ5wyxlKmM8udBvwzHxni5vxPmWG2lxHdwqI66fK3zwEufVwLfiZs1y
         5+t9qk0rCfIhoXQqoTGTl6P9sHqHSDnwJ3jRhOfZRaYZHwGuVTIF3TrLp4kELXz9OflA
         roQFzhpia6JVS5PKOmQnWjKMgG9FmnEUJ2/xDB6ObuTpbyTNGc6FOpK1u+zDnHa9CWiu
         HYUvEL2btyNR/aSPXYxK1+34nAFfIq5bEi0BJ5V11E6B9bCq9k6Vd8rqyOrGCoqN9Bm0
         oTfw==
X-Gm-Message-State: AOAM533K2QyEpkKnLOMN+qU13Ko30gIc0iMGGM5genj20rJSnslcNfTx
        ja3OmH9GIKGgHoUaobdJip3Bjg==
X-Google-Smtp-Source: ABdhPJyaVF0NfVWRWlYfaHfhZnBf7kwTVOPbbgbemIDf5TMA56r32ijF7G9Bw0rI3WwN2lhtP8cgeQ==
X-Received: by 2002:a2e:85d9:: with SMTP id h25mr2316715ljj.81.1615753302434;
        Sun, 14 Mar 2021 13:21:42 -0700 (PDT)
Received: from cloudflare.com (83.31.58.229.ipv4.supernova.orange.pl. [83.31.58.229])
        by smtp.gmail.com with ESMTPSA id h23sm2439198lfm.299.2021.03.14.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 13:21:41 -0700 (PDT)
References: <20210312200834.370667-1-alobakin@pm.me>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Guillaume Nault <gnault@redhat.com>, wenxu <wenxu@ucloud.cn>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Matteo Croce <mcroce@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] flow_dissector: fix byteorder of dissected ICMP ID
In-reply-to: <20210312200834.370667-1-alobakin@pm.me>
Date:   Sun, 14 Mar 2021 21:21:40 +0100
Message-ID: <87wnu932qz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 09:08 PM CET, Alexander Lobakin wrote:
> flow_dissector_key_icmp::id is of type u16 (CPU byteorder),
> ICMP header has its ID field in network byteorder obviously.
> Sparse says:
>
> net/core/flow_dissector.c:178:43: warning: restricted __be16 degrades to integer
>
> Convert ID value to CPU byteorder when storing it into
> flow_dissector_key_icmp.
>
> Fixes: 5dec597e5cd0 ("flow_dissector: extract more ICMP information")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  net/core/flow_dissector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2ef2224b3bff..a96a4f5de0ce 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -176,7 +176,7 @@ void skb_flow_get_icmp_tci(const struct sk_buff *skb,
>  	 * avoid confusion with packets without such field
>  	 */
>  	if (icmp_has_id(ih->type))
> -		key_icmp->id = ih->un.echo.id ? : 1;
> +		key_icmp->id = ih->un.echo.id ? ntohs(ih->un.echo.id) : 1;
>  	else
>  		key_icmp->id = 0;
>  }

Smells like a breaking change for existing consumers of this value.

How about we change the type of flow_dissector_key_icmp{}.id to __be16
instead to make sparse happy?
