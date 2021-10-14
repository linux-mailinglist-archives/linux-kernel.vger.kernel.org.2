Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA342CF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJNAbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhJNAbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634171387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NbKviyVjAGHpJsTY9YMRcseM4r7JqRNYBE2w/RGvYI=;
        b=bnIgPwr+EfQzmKZaxZ1DKo86Cnt5OSaDnXKFhCcm2xoXbHFIg2BFDpVJheu0RLzK4M812A
        fiRWNqs71L4k/uAkgeZz8umWPoTSHujCi1EtRMaEhHnA6iMzwU+3sN8i3wj87uXb7/2fLK
        ACTOKgNY3BZ1GEv/TyeobUlRvrJMTew=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-WafYkfX9ObODxr_fogBmbA-1; Wed, 13 Oct 2021 20:29:46 -0400
X-MC-Unique: WafYkfX9ObODxr_fogBmbA-1
Received: by mail-qt1-f199.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso3359082qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 17:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NbKviyVjAGHpJsTY9YMRcseM4r7JqRNYBE2w/RGvYI=;
        b=NSFhcTHpNo4z0N2BEY+QZJkpufsUZzVKxnxEJgZVheXj8AkA7YQ3/XP8tMfhbOcdyY
         VGv/SLQcMJFJhFULO+KRbKnR8b19Ud/JMkNeOjdHu+P0Ac1JBhLfOAD+FYZSrC05zcYJ
         7jSCwzaIGmmHWnd5c4hQkzAhFpIxpsuo+REtBPXvC4yJGnX0e6MfZ/McFtGp3YHWiXGc
         aIYhbFN3asVBns7eqMKYTH4V6HuSLKe0X2lWLhApX9Aj3ozgKoj/W4cD8LvdRbtCYE/i
         I63zITEkh7PhjhkKGKCCtq+zhli3puq8z6H1DgyjNQkGYFZf/QdPjY/A7r0cwFDf6AxU
         oYmg==
X-Gm-Message-State: AOAM531GIKttiCVbEINIFtktAP3fjUl7S0YyE7DIzH3/L687/eW6S8H2
        99iVHHMH7syxPawKcHn8Qzn6NdMUSTRz+ogF286voy2oj+pXpt3xfFUFmJyimn0zX2ZT/rzNqQ4
        hmAt2u8mPUHf6m/xHDxelv/UF
X-Received: by 2002:a05:622a:4d2:: with SMTP id q18mr3028927qtx.84.1634171386059;
        Wed, 13 Oct 2021 17:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVACw6Q+Bf+KRmLJVeXEJvTVKunw0eo0+N1Y08lNYbQoCAUE2k8n1Z/txG89ZKqIF/2iP2xg==
X-Received: by 2002:a05:622a:4d2:: with SMTP id q18mr3028899qtx.84.1634171385863;
        Wed, 13 Oct 2021 17:29:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id w17sm720171qts.53.2021.10.13.17.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:29:45 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:29:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/4] vmlinux.lds.h: Have ORC lookup cover entire _etext -
 _stext
Message-ID: <20211014002941.3ywwcfhf53bpw5xp@treble>
References: <20211013175742.1197608-1-keescook@chromium.org>
 <20211013175742.1197608-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013175742.1197608-5-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:57:42AM -0700, Kees Cook wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> When using -ffunction-sections to place each function in its own text
> section (so it can be randomized at load time in the future FGKASLR
> series), the linker will place most of the functions into separate .text.*
> sections. SIZEOF(.text) won't work here for calculating the ORC lookup
> table size, so the total text size must be calculated to include .text
> AND all .text.* sections.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> [ alobakin: move it to vmlinux.lds.h and make arch-indep ]
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

