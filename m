Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F742364E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhJFDdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237168AbhJFDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klvfB+c7Wo6KIpJwCuQq3+3jeJR2aoZYpNscnzsRBpk=;
        b=FTGWk0aQdPsN1rRGz6o359vLrcv6NHBlnGqcms8Dx2gpkc2lF3Dt4qEjSHSn4cq5nNG7SE
        OCoSgDnAA3nINK17LrgV0mmGUvAPgYtNLw23F4zBveEsxrERs8o05vmG3O74RcV3CX8scw
        JhMm8dkpFnBu8VUHTOWbjhaAcmyFKn8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-rJe6Nf_oO6uFj9XA6PHpFA-1; Tue, 05 Oct 2021 23:31:49 -0400
X-MC-Unique: rJe6Nf_oO6uFj9XA6PHpFA-1
Received: by mail-qk1-f200.google.com with SMTP id h2-20020a05620a400200b0045e87af96ebso1171783qko.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klvfB+c7Wo6KIpJwCuQq3+3jeJR2aoZYpNscnzsRBpk=;
        b=d7y8glkSTI57vpTnSBO58992vhBLehUVceg6abzDzGxDklijH8k3/Kgew2APwRF9QY
         y5wgz57jQ+UB/gGmJDyVWYgoqRsdPCRMpf4L3ecz45GJlJSvrjR9dUIqERd5ortfmJRr
         ZaGY+nJ3cevbEdi84ohpgaEyUMRAbQmCKkPMeaAi8xJRjjpE2EwBsNLdA2VW6DAIUDoy
         XA9aWdmqZFNLZSrL4Z+QvZGBzP6MCMpqduDEuRwlLuCHxKI+ienUTFAA5LHiHxOZzjA+
         3KJGXmbF2uLjUqPi4D9E6ON6+RQ2T1PqCA8034/34bKaAU+PM5RIMzCWPQD72h5YgJMB
         kqtw==
X-Gm-Message-State: AOAM532I/f2L72bgt8Vj4zCC2JWTgLqeQ6ho7AFuhQeiZC8aJWwD/aVC
        zvhkThfebq3fE8v5efz/jTc0+Ll6LJ71DBxqsJjImM55jcgkC9n3KV1yzHsrM9QgQ+Vxvn18jeN
        Rg+gbnc97yW6JPV+3FPQapfwP
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr27130780qvb.58.1633491109035;
        Tue, 05 Oct 2021 20:31:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ51LcW+PGg8/N2ibZ65de7tUVyCn7EJP78U0da/Hdc+K9Wr4qZ3/pkogDkVkmVCVNtTWrAw==
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr27130763qvb.58.1633491108843;
        Tue, 05 Oct 2021 20:31:48 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id b14sm11013513qkl.81.2021.10.05.20.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:31:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:31:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 11/15] x86, relocs: Ignore __typeid__ relocations
Message-ID: <20211006033145.vcj3ohkekv5rexpo@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:27AM -0700, Sami Tolvanen wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> The __typeid__* symbols aren't actually relocations, so they can be
> ignored during relocation generation.

Then what are they?  It would be good to add that information here.

-- 
Josh

