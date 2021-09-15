Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820E840CF43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhIOWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhIOWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:20:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:19:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e16so4047379pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NM8i/UdoQZLwyBLW2erL7u2GZQeN1E2oMNEHemsAuX4=;
        b=FyuEZKOXvPe58EtcdQq58xV1eadbZcmFX9ED9Yw4+hjeUb5d9gVDG+0pshyFRcYNBg
         F5h+RU7/TORme7In6WWZsQWfsRW7oDlLqh2btmvtHnbwJ5Szb6OUxg5cTu3ykbMHR1tb
         IZn8VVlpmoTiAZJEr+/G1RRmxidolo+UenstSKH9xjXYG0BpmCmLhyvRw2PERUt8N+Ic
         VRgfkjaD2U8yGSGTWcEp2++VHbSOArXh5sL+aKWZYRzCTzmtwwAUdU6cCmXAbN1FT9Nc
         Un77475qDgUD/kiX5VnE+MD7Hx1JpQb+m8oy6GTSUJZeNyP2721q1EnDTOJpFMBhz1mh
         5tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NM8i/UdoQZLwyBLW2erL7u2GZQeN1E2oMNEHemsAuX4=;
        b=g/g8WB7MHN3ii9ET4qF0AsTj2QAVZ5yQbk27j+cq8Mp+bwODbyu4uKVFRS9/RTDLt7
         dSWWGjPJHIlsia64IPSj8mZtqDfiegsnpNEP7RZqukC3dv0tQDXs15AbztzujLEmkFiO
         fYAejO4avFH7yYuGbU//ndq8N88KbJRQikBej2CbsMK+Lsy1ldUVroil9BFQ+ZqSLKnr
         K6t5n14ZzZsWF/HtT0AbwEmRjZVFQxa30NbnzIX2JNyTwolcndvQTs2L/d5gmNTKc7ev
         dHCiRE3NI9eHPjSi7YfqrX5uMMpOYwolZc0jasi51zzSyi8oQPE+bsqd027fZehKGuy4
         8pxQ==
X-Gm-Message-State: AOAM532KTO874KhCie6EaFiyWARkxo4V+/74UdUmG8fmMR0lLjj7+aVo
        LK3uapc+Y8lesaU/WCtVYskqI7lwnXo=
X-Google-Smtp-Source: ABdhPJyC6ZnCIxzN/BpQYg+AJh8tbXpVco/GdbwV2YdSbLpq2Agq1dKzrAkq9S5hCOby1GCJObM47Q==
X-Received: by 2002:aa7:8d58:0:b0:439:d68:b405 with SMTP id s24-20020aa78d58000000b004390d68b405mr1931114pfe.2.1631744376163;
        Wed, 15 Sep 2021 15:19:36 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9b0:7226:558a:f377? ([2001:df0:0:200c:9b0:7226:558a:f377])
        by smtp.gmail.com with ESMTPSA id pc3sm5620593pjb.0.2021.09.15.15.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 15:19:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] m68k: update ->thread.esp0 before calling
 syscall_trace() in ret_from_signal
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
 <YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a0dad440-03bd-cac6-6eee-22a1fdd2f825@gmail.com>
Date:   Thu, 16 Sep 2021 10:19:31 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On 26/07/21 5:19 am, Al Viro wrote:
> We get there when sigreturn has performed obscene acts on kernel stack;
> in particular, the location of pt_regs has shifted.  We are about to call
> syscall_trace(), which might stop for tracer.  If that happens, we'd better
> have task_pt_regs() returning correct result...
>
> Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looking good also, and should go to -stable.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
>   arch/m68k/kernel/entry.S | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 9dd76fbb7c6b..ff9e842cec0f 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -186,6 +186,8 @@ ENTRY(ret_from_signal)
>   	movel	%curptr@(TASK_STACK),%a1
>   	tstb	%a1@(TINFO_FLAGS+2)
>   	jge	1f
> +	lea	%sp@(SWITCH_STACK_SIZE),%a1
> +	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
>   	jbsr	syscall_trace
>   1:	RESTORE_SWITCH_STACK
>   	addql	#4,%sp
