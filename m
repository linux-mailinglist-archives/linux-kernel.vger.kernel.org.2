Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3A4445A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhKCQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhKCQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:17:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12944C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:14:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x16-20020a17090a789000b001a69735b339so1771781pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gcc0EUM1EauKNq+43vPpaFdtVYVD7iAXZHWErocDtp0=;
        b=GerNQsh9cv7fbDFjWov4KivBQdKjB2oHp6+hu5L0IzSuHrFf7yC9nsNjEK4mKa1thg
         lIef1g1Q5waG3Bo27dyQD9IGceZ5FdA0UnVr/ZFrZRZrTE5L/cCOMJ3+Ap+sF3V9itpe
         xd7YTDezqpu5NUNKOUXH5YXvAc+giJbRz+574=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gcc0EUM1EauKNq+43vPpaFdtVYVD7iAXZHWErocDtp0=;
        b=k1Tlz/OiPlrXWgw0OzIRf4D49mDWCpsuiVwEdzZhJJENHErsas/lsPkvmGnuWTMua9
         x6vrK/rSqRETSI6YWqwydqG3Z5jw/vd0kGrGpsRGlygKgOYGaGPFoZZTD8caaxktHx/2
         Vl3WmOv19T13TPJ6l0dv/s85dT9maoZdIbZTSdl0mmUBQuPqHjiFjdpzQAAL1PM5YOKB
         yhLKUn3SKFcZgZJiCoNnHwa52Jj4M1IpRhYwms41vFJPg/TvvkyG7qgFYiRD+80WUwQL
         EymCvTbchd/UyaXaaJgDnCGK0cGeFHWIM288S9R8xFZvMpP4b+SuUBFL7gMZ9PVBoN+V
         WZSg==
X-Gm-Message-State: AOAM531luDqd8T5CzhTkgT+DxEesTTrgs55Ywamn8DD5FxA/8DU72Xgx
        3M6Ob1ulybtRl2KUFKRW/dEorNTdj6jBoQ==
X-Google-Smtp-Source: ABdhPJwfVfLAFqcLr/+fzW2AVuq4++yVTWfgk5KQYqUOGtMy5pycxzm1sypp4lVosI+3B8C3SbUzIg==
X-Received: by 2002:a17:90b:124d:: with SMTP id gx13mr15668790pjb.106.1635956088496;
        Wed, 03 Nov 2021 09:14:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u33sm3296082pfg.0.2021.11.03.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:14:48 -0700 (PDT)
Date:   Wed, 3 Nov 2021 09:14:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: selftests: seccomp_bpf failure on 5.15
Message-ID: <202111030838.CB201E4@keescook>
References: <YXrN+Hnl9pSOsWlA@arighi-desktop>
 <202110280955.B18CB67@keescook>
 <878rydm56l.fsf@disp2133>
 <202110281136.5CE65399A7@keescook>
 <8735okls76.fsf@disp2133>
 <202110290755.451B036CE9@keescook>
 <87y2665sf8.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2665sf8.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 01:22:19PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Oct 28, 2021 at 05:06:53PM -0500, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > On Thu, Oct 28, 2021 at 12:26:26PM -0500, Eric W. Biederman wrote:
> >> 
> >> Is it a problem that the debugger can see the signal if the process does
> >> not?
> >
> > Right, I'm trying to understand that too. However, my neighbor just lost
> > power. :|
> >
> > What I was in the middle of checking was what ptrace "sees" going
> > through a fatal SIGSYS; my initial debugging attempts were weird.
> 
> Kees have you regained power and had a chance to see my SA_IMMUTABLE
> patch?

Apologies; I got busy with other stuff, but I've tested this now. It's
happy and I see the expected behaviors again. Note that I used the patch
with this change:

-#define SA_IMMUTABLE           0x008000000
+#define SA_IMMUTABLE           0x00800000

Tested-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
