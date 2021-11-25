Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451F645DC33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKYOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355582AbhKYOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:20:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A6C061763;
        Thu, 25 Nov 2021 06:16:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gt5so5287484pjb.1;
        Thu, 25 Nov 2021 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbJO0TeFQmYmuVHT0afGRmY2VMRSYyjVVUuSvy6vry4=;
        b=R/+pPmvxZKazNC9VpGI/Ub1tLtIw7hk6dj7F++0F1ffWvwSWysicVwADa6F7MdUkXn
         SkgqZQR2Op9qmzanbxOXGigb4sUJHH5jBmMy2Og3dzlzihUNCX0e3iNYu1lY/3lmg7QF
         3UhFGbu26RbUqmH1ec/2dkmcf9+/YOkmEL25PhuZrMVbI0jASm0ug+iILgdFwyoZqRst
         7hplj1mktAh/69VF22roC6t6LaQonh5BCE65ZL9jgQLU9I5dLFBt9ZgSIjI+Q8JV4k/v
         na6VePuplRi9GhveDMJV+DWLHZrZnvX3TJOwl8RZJp5MOgKoIMcHQYVUQfHaXbmcSyMa
         p1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbJO0TeFQmYmuVHT0afGRmY2VMRSYyjVVUuSvy6vry4=;
        b=6xEx1+Ipb65GNHY4oB0TnQpb52UyVpB/APFITXrzgJ0KlFwg25w7VNC2PtFMnQFRqO
         xECWG8Q84GcOWpivoinzS4Oj4Jl70gKHIZb+yOZPM28lyuhPlFCnN9HvOR50EzBDQy6Y
         fSYQFPaW+xpNtd07cY630qlTAUSo964rfDnJ1KVVh1yysT3qAniQc2TucF+e9idhWm8J
         qTMlwVEH7141TKLZmQUMpVPTI6YjtwuajM5nJ9B/B1WKUMoUuPlQS1zhaYbET1cxJljQ
         ot8HEdS3rrMWJ2HT2vrbm6ExDD3B3jMCQr5a2cvitK9J1MYSJ0LJrLrvOkQf+X+BZvOq
         YAVQ==
X-Gm-Message-State: AOAM533Iwu0Qo7CI05s3E1ZGkjc/YOaCLhYhd1Dmb8h0iQRHcOM4Fz1v
        uC2h/pDUIc3jUuO5/wNw8ss=
X-Google-Smtp-Source: ABdhPJxzsSncFOIq4QNYKLSO5EyeJW+dKGjX7ILl5gnI8yiv/Yl0ERxLCbUEz1Z/VaiKrze7S52NwQ==
X-Received: by 2002:a17:90b:1650:: with SMTP id il16mr7303788pjb.242.1637849812919;
        Thu, 25 Nov 2021 06:16:52 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j1sm3641724pfu.47.2021.11.25.06.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 06:16:52 -0800 (PST)
Subject: Re: [PATCH] docs: admin-guide/blockdev: Use subgraphs in
 node-states-8.dot
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
References: <3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com>
Message-ID: <3c0ffc75-0e0f-1701-267b-1bedb6481b79@gmail.com>
Date:   Thu, 25 Nov 2021 23:16:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 18:38:14 +0900, Akira Yokosawa wrote:
> While node-states-8.dot has two digraphs, dot(1) command can not
> properly handle multiple graphs in a DOT file.
> 
> Use subgraphs and merge them into a single graph.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
> Hi Jon,
> 
> I happened to spot a broken DOT script at the bottom of
> 
>     https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html
> 
> and managed to fix it.

Gentle ping?

        Thanks, Akira

> 
> DRBD DRIVER maintainers,
> If I'm missing something here, please let me know.
> 
>         Thanks, Akira
> --
>  .../blockdev/drbd/node-states-8.dot           | 25 +++++++++++--------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
> index bfa54e1f8016..993f0c152ead 100644
> --- a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
> +++ b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
> @@ -1,13 +1,16 @@
> -digraph node_states {
> -	Secondary -> Primary           [ label = "ioctl_set_state()" ]
> -	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
> -}
> +digraph G {
> +	compound=true;
> +	subgraph node_states {
> +		Secondary -> Primary           [ label = "ioctl_set_state()" ]
> +		Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
> +	}
>  
> -digraph peer_states {
> -	Secondary -> Primary           [ label = "recv state packet" ]
> -	Primary   -> Secondary 	       [ label = "recv state packet" ]
> -	Primary   -> Unknown 	       [ label = "connection lost" ]
> -	Secondary  -> Unknown  	       [ label = "connection lost" ]
> -	Unknown   -> Primary           [ label = "connected" ]
> -	Unknown   -> Secondary         [ label = "connected" ]
> +	subgraph peer_states {
> +		Secondary -> Primary           [ label = "recv state packet" ]
> +		Primary   -> Secondary 	       [ label = "recv state packet" ]
> +		Primary   -> Unknown 	       [ label = "connection lost" ]
> +		Secondary  -> Unknown  	       [ label = "connection lost" ]
> +		Unknown   -> Primary           [ label = "connected" ]
> +		Unknown   -> Secondary         [ label = "connected" ]
> +	}
>  }
> 
> base-commit: 53b606fa29e321352a105978726b975b42b292a4
> 
