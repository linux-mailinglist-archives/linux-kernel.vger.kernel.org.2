Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD2436751
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhJUQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:12:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC2C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:09:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h193so770125pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9F/2GwBSv+wmck4DeHeGUmQJiNkhxnagoawd2JRdH8I=;
        b=aYS4Hl3TAQ6+l8a1NwGwRJW1wfXBykLV8Ng2Ki4cDwOzEV2Bq494FF2RnGdoqzmZru
         h2CA0xmwYI0j1RnrpSzOjCuwxghZRlujRdtN5MJu5Q9ompbrEvzpNz2/MLcIa3J/XVHT
         6ENhFUr4+Cm8aLnVavjthSt3hxefaRSnx2rFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9F/2GwBSv+wmck4DeHeGUmQJiNkhxnagoawd2JRdH8I=;
        b=mfdhR0KO2KqqjBSpcDSUHmM4K6Uuv05OXqSbqROkYnJiP0CnLvQDu9jPKmCNLyqM1F
         tML14vfXUaqU7rJQGfEk9j30Jj4kd7PUDm2HUSpwvZ0Gpj726x2pICg5UXPxExVzUD4z
         9wYfCahNo9AySXNvm6OUOX7DH2bPct7Y0Lxau2fcMhYlsoKOU2Kq+A37VcfB9oTu7RAP
         9NmoCuICR4DnXH5exAMpTJyUMHvZA2hVX8WDP+K/bkNqD7s9AvNpu32XQC+3s7cXzgbZ
         1y8gIgyghZCYJ3bjOctO0Tk0VAKPbvdrtCZNpQDttIBC0QVhb4CjWx8szVgCQ77Q+/N/
         gSVA==
X-Gm-Message-State: AOAM531utVG0Xaaqvy0xptTk205S51G8LuwIAb1rjY3CslM+yZuk1IXA
        COBqysNR+Lu1yrSsE4E2OrFAFA==
X-Google-Smtp-Source: ABdhPJxzbAc2D1JMb8+9E7mH1eq28U/EyWOkUl6R9VQiQguRGvwbTILm2E62IEg+CGS2JEIWYVT7XQ==
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id l14-20020a056a00140e00b00444b07751efmr6469571pfu.61.1634832583972;
        Thu, 21 Oct 2021 09:09:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20sm6226101pjp.48.2021.10.21.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:09:43 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:09:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/20] signal/powerpc: On swapcontext failure force
 SIGSEGV
Message-ID: <202110210909.895B8A5A58@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-7-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:53PM -0500, Eric W. Biederman wrote:
> If the register state may be partial and corrupted instead of calling
> do_exit, call force_sigsegv(SIGSEGV).  Which properly kills the
> process with SIGSEGV and does not let any more userspace code execute,
> instead of just killing one thread of the process and potentially
> confusing everything.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Fixes: 756f1ae8a44e ("PPC32: Rework signal code and add a swapcontext system call.")
> Fixes: 04879b04bf50 ("[PATCH] ppc64: VMX (Altivec) support & signal32 rework, from Ben Herrenschmidt")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

This looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
