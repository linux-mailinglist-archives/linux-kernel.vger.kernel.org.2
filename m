Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2A407A79
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhIKVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhIKVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:14:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 14:13:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m21-20020a17090a859500b00197688449c4so3845921pjn.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x7fpDGw7GwVxQp66PXDuzsoBUpylAYb3JWyjRp5J7bA=;
        b=j8MhOril6UuQD8Rm7ZcorSAYsn9MIcMd3B0rm8iUvCP8l4U+W9XBsqnhER/jZHKX1M
         FNkVhTMGe4zkY0UYA/paa7vXwI8lTo96zVDQlbCjhT1WnHN6bmMrz68UyGR5+Bizk1c8
         PYWJA/zUgVdetjZ+K02dqvhxCkH6//z+SLFf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7fpDGw7GwVxQp66PXDuzsoBUpylAYb3JWyjRp5J7bA=;
        b=Kb1MvJVrLSGq/FObw6JmD8Cam9L0zctB2BZhkU4FWMfXW5aw9nVjgnILeam/C+7Zqn
         /Qp0r5rlrMEIEmvdCAohjZsJ/8kMdL5N++66XjdLClCtcb4Sl8ZdREjB2DyZrWeklt0c
         XjkfnhYWs1m52GTfzoX6pSk1pKW61pRqWYvjqHPYXwJrq4TZUFnw7z0RWQccOM91YsSK
         Ir7wOFFkTaqZ7vVN0lOaw8I2xu2BzLydERelSWhFv8csSZFA21DqcUjmaw7xqKbWLOi/
         zxS3C8lC4tvnt+uCDgcUJs1qxh5muIg/RP4SQiJdR0FdohRnVLQpGk36zYSCtmU8jK2o
         H04Q==
X-Gm-Message-State: AOAM531OLVHcx3ZmchT0j8GFZwNVWc4gTPQhoSUzt4Ut4iZ6RPc8pNUh
        0zWi/iy5iUSNuTJFVgFWBeLo5g==
X-Google-Smtp-Source: ABdhPJwqImrX1GBKXDqZhHLxGt/0ugV0SZHAIErQAwWMWTIL/Y3tVutkA62Bs1Cvl2xun+/qiQ/XKA==
X-Received: by 2002:a17:902:bcc6:b0:12d:bd30:bc4d with SMTP id o6-20020a170902bcc600b0012dbd30bc4dmr3737613pls.18.1631394818207;
        Sat, 11 Sep 2021 14:13:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm2641047pfu.36.2021.09.11.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 14:13:37 -0700 (PDT)
Date:   Sat, 11 Sep 2021 14:13:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: deduplicate the spectre_v2_user documentation
Message-ID: <202109111413.D988175207@keescook>
References: <20201104234047.GA18850@redhat.com>
 <20201105001406.13005-1-aarcange@redhat.com>
 <20201105001406.13005-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105001406.13005-2-aarcange@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:14:06PM -0500, Andrea Arcangeli wrote:
> This would need updating to make prctl be the new default, but it's
> simpler to delete it and refer to the dup.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

I'll take this too.

-Kees

> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 51 +------------------
>  1 file changed, 2 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index 19b897cb1d45..ab7d402c1677 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -593,61 +593,14 @@ kernel command line.
>  		Not specifying this option is equivalent to
>  		spectre_v2=auto.
>  
> -For user space mitigation:
> -
> -        spectre_v2_user=
> -
> -		[X86] Control mitigation of Spectre variant 2
> -		(indirect branch speculation) vulnerability between
> -		user space tasks
> -
> -		on
> -			Unconditionally enable mitigations. Is
> -			enforced by spectre_v2=on
> -
> -		off
> -			Unconditionally disable mitigations. Is
> -			enforced by spectre_v2=off
> -
> -		prctl
> -			Indirect branch speculation is enabled,
> -			but mitigation can be enabled via prctl
> -			per thread. The mitigation control state
> -			is inherited on fork.
> -
> -		prctl,ibpb
> -			Like "prctl" above, but only STIBP is
> -			controlled per thread. IBPB is issued
> -			always when switching between different user
> -			space processes.
> -
> -		seccomp
> -			Same as "prctl" above, but all seccomp
> -			threads will enable the mitigation unless
> -			they explicitly opt out.
> -
> -		seccomp,ibpb
> -			Like "seccomp" above, but only STIBP is
> -			controlled per thread. IBPB is issued
> -			always when switching between different
> -			user space processes.
> -
> -		auto
> -			Kernel selects the mitigation depending on
> -			the available CPU features and vulnerability.
> -
> -		Default mitigation:
> -		If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl"
> -
> -		Not specifying this option is equivalent to
> -		spectre_v2_user=auto.
> -
>  		In general the kernel by default selects
>  		reasonable mitigations for the current CPU. To
>  		disable Spectre variant 2 mitigations, boot with
>  		spectre_v2=off. Spectre variant 1 mitigations
>  		cannot be disabled.
>  
> +For spectre_v2_user see :doc:`/admin-guide/kernel-parameters`.
> +
>  Mitigation selection guide
>  --------------------------
>  
> 

-- 
Kees Cook
