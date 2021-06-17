Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44E63AAA45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQEnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhFQEnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623904865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRH1mIv3BE8eD5JB0vSdN7Y05iQZJajr4cyJmYooT0M=;
        b=EtrtZYlf85o/BTTTK0H5T54Mgz44XMId3wXMYhAkAam8jfDSTYj7NLKYdlAcId0vx0fDlO
        gXqYeq/rmln7gZszeMzf/ob3OvOHa0zNGB4c+8PxqV4gVAIthYzj8Dbmts0OybHx868oEz
        MT03WzxfsgDpeO7Ud5QEQcw2UOOkgfQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-OnBDP6xrM-2VtKsSYEGG7A-1; Thu, 17 Jun 2021 00:41:03 -0400
X-MC-Unique: OnBDP6xrM-2VtKsSYEGG7A-1
Received: by mail-qv1-f69.google.com with SMTP id jm5-20020ad45ec50000b0290219dc9a1ab8so1195527qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRH1mIv3BE8eD5JB0vSdN7Y05iQZJajr4cyJmYooT0M=;
        b=qYkqSrHWTDx0KGKAV33CUR62l0snV8KKAh9fujPSBY82+1eMf4vvtvWiEnwe+spvsS
         WLpn4Ck3Ssm8AyzEIqs0f1tI41vKcjveN6ca45vWph8TUfwXdndT+ZFede/gBwsr/Lhh
         RpCeVQuiKjYCYM4sxHq6S04ovEahMA0dcVoVDR0REhpu++22InfkY/6R5LRgdWjaUqfm
         hll7I4XvTLoAYqix1T4WKdgDR23Iqk2+m9jC8ty2F4F8PHkwTLMPgKvfoEPEbXJPmFpc
         jqDcc8LkhP7hy/kY/js73whFxGLrsia9qMsSIqdfdpCf9BCsEZNyvp99j2t0R5QHAlZg
         qjpQ==
X-Gm-Message-State: AOAM533p0bFL+/pX7vzby4atTT1+lhF/7efacYW6GbZ14W7l5avi2dDL
        AvyCf85fSAr4QDOQv6TL4x8fBTULyHXKvy4w6DYiYsuR1f/Rtr1UndMXEbb3R9Ry/rqVlstEPag
        I/GIH5YAviKIB+TTV8FdI0lWF
X-Received: by 2002:a37:a389:: with SMTP id m131mr1852458qke.134.1623904862694;
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy/rnTImZkYqGlwtbUgW/jE8SgnPZVG2s9z6nNoS60Q0zHIRP2wQA0sGlLTIxkcaBzfQbNYA==
X-Received: by 2002:a37:a389:: with SMTP id m131mr1852440qke.134.1623904862501;
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id w8sm967908qkp.136.2021.06.16.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:41:02 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:41:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 10/13] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <20210617044100.swsgkyio5wwdl2ic@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209763886.436794.6585363781863933939.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162209763886.436794.6585363781863933939.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:40:39PM +0900, Masami Hiramatsu wrote:
> This changes x86/kretprobe stack frame on kretprobe_trampoline
> a bit, which now push the kretprobe_trampoline as a fake return
> address at the bottom of the stack frame. With this fix, the ORC
> unwinder will see the kretprobe_trampoline as a return address.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

