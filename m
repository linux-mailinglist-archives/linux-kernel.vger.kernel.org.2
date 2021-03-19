Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BA34237B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCSRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhCSRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616175421;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPoEAPJcZtBPa2hGBhjHmOpRECP1X15O+ra4sz3CfJ0=;
        b=fZgOMJgcTuVW834euNBI3Hzo8KkQ7qgPKzWK5ZsSLrMxu//60c3ykllkoHvWlFor1krQaW
        cmzkMQzD7T0Sxn0i+S+45awd3+HDtr75a2ZxAYMvMZUvEt5ReViGv1k+mXDeF/1Gr/geNX
        gnJY/AflH4mHCfsnyTyjjJWa9rF+U3M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-LTqYc_HSOJ29JoozHuZ4IA-1; Fri, 19 Mar 2021 13:36:59 -0400
X-MC-Unique: LTqYc_HSOJ29JoozHuZ4IA-1
Received: by mail-qk1-f197.google.com with SMTP id 130so34495348qkm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=gPoEAPJcZtBPa2hGBhjHmOpRECP1X15O+ra4sz3CfJ0=;
        b=kXz6V4+KsVGwHdm/VK03W0RNI0kUbM/yOaUXcHrpHBHt1I33+oc9Ugyh/vw7olHdEq
         xckM+4XYY7gtJbI2jM9RjwmvEswHGzEPkRLsbuShKntu2dJptC05KaX8LlFWwh6Z8gss
         LuJQV/HRl8zDlqMoBnI9oY/Ncn8daKeWwyiT2Z+nQNOE1dNjQProoBWB4ts3sn+SDYfp
         JLF0tRxpScJQ1tbaaX+TIK7q2/jQIKIok5/84keO23BvhgbT0MzmNoXQbK9Jj5TIUso7
         nbPYxL8fVxSLvzrLle1EwmP1a2ha/QB/LAm7nSLnCBuhICTmZc1N3Q65Efsvc5qXLduF
         ZpSg==
X-Gm-Message-State: AOAM533BcJy1l7fAjTaDOy6HHgBMjWptv+wOd+cnifRSOgqAdjtTdi8X
        t9bRlqAUBlCyTHe7DQlTMuvPhcpl8KmWTh65FM+NvenxTSFPfNdyfBT+pYDNQg0ESEO50YGUK/y
        6O+LO6w7O0Ehxrt34iu5ntTV+
X-Received: by 2002:ad4:46a6:: with SMTP id br6mr10361010qvb.61.1616175419291;
        Fri, 19 Mar 2021 10:36:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypAyV+kC37U9VAtNPMOlC2K7/EVvRqkJVrhf8sltJXxZWMrqv//uKkWUNAJx8/U7Bpv3IKmg==
X-Received: by 2002:ad4:46a6:: with SMTP id br6mr10360992qvb.61.1616175419117;
        Fri, 19 Mar 2021 10:36:59 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t6sm4209571qti.2.2021.03.19.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:36:58 -0700 (PDT)
Message-ID: <02765161a07745603e737d427b90d779549a13a5.camel@redhat.com>
Subject: Re: [PATCH 14/19] drm/nouveau/dispnv50/headc57d: Make local
 function 'headc57d_olut' static
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Fri, 19 Mar 2021 13:36:57 -0400
In-Reply-To: <20210319082428.3294591-15-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
         <20210319082428.3294591-15-lee.jones@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2021-03-19 at 08:24 +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous
> prototype for ‘headc57d_olut’ [-Wmissing-prototypes]
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> index fd51527b56b83..bdcfd240d61c8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> @@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size,
> void __iomem *mem)
>         writew(readw(mem - 4), mem + 4);
>  }
>  
> -bool
> +static bool
>  headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
>  {
>         if (size != 0 && size != 256 && size != 1024)

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

