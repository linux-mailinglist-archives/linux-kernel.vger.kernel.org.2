Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3D459731
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhKVWQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:16:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhKVWQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637619227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+R9BINaX+51Qr2T4l6sCMbvLwjW2/vrLNYAwc3Z9lU=;
        b=Yz0rrADwAF/pU/Kxj+e1rDuIJBis+Wwtr9V43RsGs8TeOsbv7zrHzvjhnwXYxaBgu/67ZU
        f9GvHonL3z3J93DX8cS8CcpmE8NB6hRk96xU3JCY6qiqvT4MFJA265ZCQNtAzEXaMndJ73
        JH+ZjR2W8VJa/SCYhD8ihde9F13FMnk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-Na6IQFvYMEKTaYcpc9RNbQ-1; Mon, 22 Nov 2021 17:13:46 -0500
X-MC-Unique: Na6IQFvYMEKTaYcpc9RNbQ-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso15963668qkp.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=S+R9BINaX+51Qr2T4l6sCMbvLwjW2/vrLNYAwc3Z9lU=;
        b=XhZdb9WhpBTAzkZ5aBnZKlBLyBMEJsZMIeHFJCSEDCTkkw6T+mtxbjsTrxvY14kOZu
         2oUfYTnZ/f+hdyZffXDuy5Rwk8i4DKPsyTXzVnZv3yCMXmzdEXl1susO/oWGLHYLhUGI
         JCA/jFCXq/hsk9WJvZRxQq7GWV6YLxrDX4JUxfAn9n6lJcil8u6QuXozAmVnBvDRbVCa
         6vUC27ryeIH4RgrL7jSdEhnm0hifSzFYIVKzcSEY+vZSEB6wGW/RhuZg65UE+VoXdhAk
         +0679neM+8kA/njSp3XO9U0El9mULswT7Z/3QhJ+1mqoQwP9+YWOTsedFxnZFbjY3LGQ
         MELg==
X-Gm-Message-State: AOAM531IYc+gk4bCMp7ttUOfBw9TbZdshr6VH5ZbGIcF384aNow8oQCN
        tI9C0UqqcXq4RHQ6D5hq9Z8ZnBEwPSdEubkA6T30/p8K/UZNk3O8GUj/X3YTBlBVJhhN8k9fbPF
        1VaKVXKmKObYVMm+1TNSM5JP4
X-Received: by 2002:a05:620a:2686:: with SMTP id c6mr124707qkp.223.1637619225702;
        Mon, 22 Nov 2021 14:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjge0K0A/nuJhOKxTMumEKKOBE3aDs/sL07dbK3PKluKwLUOKRHtkgUX+iQF2cQOqBhIFyMQ==
X-Received: by 2002:a05:620a:2686:: with SMTP id c6mr124688qkp.223.1637619225558;
        Mon, 22 Nov 2021 14:13:45 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-249-157.bstnma.fios.verizon.net. [96.230.249.157])
        by smtp.gmail.com with ESMTPSA id t15sm5265046qta.45.2021.11.22.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:13:45 -0800 (PST)
Message-ID: <60cfa0c45da408f1c87fc0e85bba389339ea9109.camel@redhat.com>
Subject: Re: [PATCH] drm/selftest: fix potential memleak in error branch
From:   Lyude Paul <lyude@redhat.com>
To:     Bernard Zhao <bernard@vivo.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Nov 2021 17:13:43 -0500
In-Reply-To: <20211117014834.36999-1-bernard@vivo.com>
References: <20211117014834.36999-1-bernard@vivo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder what vivo's interested in this for!

Anyway:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do you need me to push this to drm-misc-next for you?

On Tue, 2021-11-16 at 17:48 -0800, Bernard Zhao wrote:
> This patch try to fix the potential memleak in error branch.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> index 6b4759ed6bfd..dbac073ed385 100644
> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -131,8 +131,10 @@ sideband_msg_req_encode_decode(struct
> drm_dp_sideband_msg_req_body *in)
>                 return false;
>  
>         txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> -       if (!txmsg)
> -               return false;
> +       if (!txmsg) {
> +               result = false;
> +               goto out;
> +       }
>  
>         drm_dp_encode_sideband_req(in, txmsg);
>         ret = drm_dp_decode_sideband_req(txmsg, out);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

