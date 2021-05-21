Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D816738CEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhEUUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhEUUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:19:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A13C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:18:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s22so32003694ejv.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRq3a79BTOfjNk8E8ggTZT/+wBIRKwD0NpYc594HzrI=;
        b=UH99zw+vtI7dopQApmvoMsy3tQTx8crrO5RdqATQKJeGjj9X9HW4DJr6L/KgJhmb52
         EbOrdP18PpptzmqaEHEVLWqQhtg2ig/nDIcYozVDVoiohObZZKY2YB9gIDMb0e7q4k2h
         IyQ2rdNQeDvuIuqW3YsOBLk0SDrGifHMGI8nFYhawD6A9zoZrDJzuKUgo9StDPYvvOHn
         Wc3hBFqw6dMMK+mCL3rTZ8a91vq1n7VyeMMm3rb1q0C+d+WDIMRK4GgKT2KiSDlUh0oG
         yuLQrav2371H6hx0/zqlPYxLPg3J12q4NvDSVYEZDNY2gSA8spZfahSOykEClF02T37Y
         5fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRq3a79BTOfjNk8E8ggTZT/+wBIRKwD0NpYc594HzrI=;
        b=HnzTZGRjvzW9P6ngdbnITbjontn37jX6yKfRMIN7xMPaQTUQC5cJqr21ZW+9y66Sgz
         psw3SEgAaUPKFoVhpL8gxSqYxGrZQ9x8SuKg2AVHytNFQvOoskzUiIW8+mSP56JXwHZ0
         rP090XwAkeV/wBvtRih7X1KDeiBSmK/Hj7dGIGYILEbA/K4Mh1mnwf/qwTYGKXjvkjKA
         uagnbMX6cb2L0cqNyMsv6AtHodERUi/FtSVL+e650WBJmJxrUCAiNRGZvKP155W1Pius
         AtnAUSjD1x3D6dKR8yq1bhARtuzSMWetSslfZfdLgN2wfLn0acIY+1a1bttJQy31+qOi
         d1ww==
X-Gm-Message-State: AOAM532G3JNV7w7zUpIbEleHmBXGJbAxj8X+xuDW//uxp0Ux9NwcRT2U
        ClAfzBARIIuCg100TBkdhh+DAL1fCKLti2tV54ZQ
X-Google-Smtp-Source: ABdhPJxLHNN51avk7YeEqYnny9tixz6B4/nVEaokiaEMktyaFuLHwTU/FmzSQ8cmk+6m7bv1Outbe1fzb6k8sZfbRLA=
X-Received: by 2002:a17:906:8389:: with SMTP id p9mr12291163ejx.106.1621628302546;
 Fri, 21 May 2021 13:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-8-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:18:11 -0400
Message-ID: <CAHC9VhR_eDyfUUH=0PyJ06R739yFJLgxGsi5i9My3PXaPEskNA@mail.gmail.com>
Subject: Re: [PATCH v26 07/25] LSM: Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_secctx_to_secid interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its callers to do the same.
>
> The security module hook is unchanged, still passing back a secid.
> The infrastructure passes the correct entry from the lsmblob.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/linux/security.h          | 26 ++++++++++++++++++--
>  kernel/cred.c                     |  4 +---
>  net/netfilter/nft_meta.c          | 10 ++++----
>  net/netfilter/xt_SECMARK.c        |  7 +++++-
>  net/netlabel/netlabel_unlabeled.c | 23 +++++++++++-------
>  security/security.c               | 40 ++++++++++++++++++++++++++-----
>  6 files changed, 85 insertions(+), 25 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
