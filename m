Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35124417779
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347099AbhIXP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhIXP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:27:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521AC061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:26:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lp9-20020a17090b4a8900b0019ea2b54b61so442368pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MFsXEmVyTegWQH6W88YQhCSi/9+3lbq3dBNBziZp+Dk=;
        b=dBuBDyVpQXHImVg5rYV1FEdH2wEdXzT9u1NW4PbHEA0Fn7b4tNBB60JsQbdMuAHmBo
         zmwctt+UzrWdVDgHqv76IBJ7S4YE8ChQuebBl9+Ul8UrsPEvjL1+5GFRVeb0mQrYkUsa
         1VbBymQzRXCzL2A4Gwu1b/vV3dIi2SIVQ10SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MFsXEmVyTegWQH6W88YQhCSi/9+3lbq3dBNBziZp+Dk=;
        b=E7U4u7QRma/lWuWnQ7L+fuHinNKTj9XprUUDxmySRNbDWIOHbO/whNT14N37p2OQge
         gEM1iOaci0yE/HblTtSRcVwwtc9vHWT6AAz+0s8lLXuzlSXOqMisbZ++9F771hxEXI0m
         ZsiSVgymvHiANDepIDeD/Ioy3/MrwhOFBNsRf+6hTZjeFcAKSMfPO+ZlXFn9nyX3mdL/
         /VM3g5G3GSw5EcW5KBcfAOpU0XAMVRCjIfpFlIte4mqTBMfM+iFTAcYJY+FpELUv2cU+
         hBAVPfcwGWSAeYfeuEzb6aeS6wiNHvrK8s9AVKIP0+nzSvFcia27JRSA+cG+wPCQ4lUj
         06Rg==
X-Gm-Message-State: AOAM531z23hzfZAqVXIwN+jGVmNueg1Hc5aKD1NqxMweScdlaWrqx5FG
        eRQG2Zk2B9ujAcAZ5BnFEY91/g==
X-Google-Smtp-Source: ABdhPJyxRi7Ak+F9An1oBXL8/KlJq5fERwKh4kRN1IsbglsNdz7gd30ahoQaaexWy3Ji4mH1O7JY9A==
X-Received: by 2002:a17:90b:1b0f:: with SMTP id nu15mr2912364pjb.181.1632497171999;
        Fri, 24 Sep 2021 08:26:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm9361281pfh.168.2021.09.24.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:26:11 -0700 (PDT)
Date:   Fri, 24 Sep 2021 08:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/6] ptrace: Remove the unnecessary arguments from
 arch_ptrace_stop
Message-ID: <202109240824.2B4C0B7EC@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87lf3mx290.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf3mx290.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:10:03PM -0500, Eric W. Biederman wrote:
> 
> Both arch_ptrace_stop_needed and arch_ptrace_stop are called with an
> exit_code and a siginfo structure.  Neither argument is used by any of
> the implementations so just remove the unneeded arguments.
> 
> The two arechitectures that implement arch_ptrace_stop are ia64 and
> sparc.  Both architectures flush their register stacks before a
> ptrace_stack so that all of the register information can be accessed
> by debuggers.
> 
> As the question of if a register stack needs to be flushed is
> independent of why ptrace is stopping not needing arguments make sense.
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yeah, this is a no-op change. No one is using the arguments, as you say.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
