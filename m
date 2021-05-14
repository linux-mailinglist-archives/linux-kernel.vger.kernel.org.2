Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764753810B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhENT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhENTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:25:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DFC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:24:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gv8-20020a17090b11c8b029015d47d8ecbbso347866pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zYWopn37Ev0Ztgo7qbckFoeWWV5RAzUDbw0Dfbjdlw=;
        b=CMZSonsnXKB5rfp654jW6UBkcZJpQvr4Hl3h/Sqp9c5xOeKlo+X+kqqWm3C/Otq38b
         Gby1KIQVxuvRvD6LivosEWOYnU+tAsjc0470WhZAINAdTPN3hksm4E8lMmzXHsMnhdIr
         dMg9q2OAFM5nEax3IUS56gN67MKdcrw2ETr6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zYWopn37Ev0Ztgo7qbckFoeWWV5RAzUDbw0Dfbjdlw=;
        b=G+/WCNnuLHuWqwCQFyqwsQzKmlx7IgacCag6ShbbSj3PVhX+6nIfUB2PqqGUXeopxC
         2Gh0fv3TjGgXPurklR4VFSj1p6LnGERn4AoClqcRaOxMwFMEoSNPAnUypTApRx4Bz/5h
         rLJ3+EL8R9hYkUMtfRXZJDcUnTLAVxD3Mv6FEmcTgqD33HPF2y7k3Rm86xEl0fuLmq87
         9836V+ZPzkbRJoUSmKkIidTI/tV0mwl+T0VK2TV/RUJDN7lZf5TNBayup+GNz5FVJ3RT
         0edaMmtg6i9BofQ3RlCsrKaODYhUenkTCHJOtk+GpT6RKUbTokPsI8jXCVukXalzjv0n
         4x6g==
X-Gm-Message-State: AOAM531Au7C7SbfJEDnrprvKQEJqhHKzcZRqr9LmibQyi2aVsg2HtdKn
        RkIYr+050RcBhplKVYUO5bL1Bw==
X-Google-Smtp-Source: ABdhPJxHMA/6v53f/nn/W7fZz/vDZdmjMu55VCA8wxeCxUw6+Ip7YnJ5TAlxokdAusW4aKY8IvIw/Q==
X-Received: by 2002:a17:90a:1c02:: with SMTP id s2mr20301156pjs.172.1621020280425;
        Fri, 14 May 2021 12:24:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm4983512pff.96.2021.05.14.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:24:39 -0700 (PDT)
Date:   Fri, 14 May 2021 12:24:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v26 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Message-ID: <202105141224.942DE93@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-18-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-18-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:07:59PM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seem good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
