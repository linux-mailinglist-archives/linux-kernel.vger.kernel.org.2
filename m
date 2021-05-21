Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70D038CEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhEUUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEUUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:21:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B06C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id et19so25177402ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=aG3bBjgVeg6slH6NXO/4ixHXPGXGELFb98HmduPBE+sk25y//o2bRRKcaARiDg1p7r
         Ozu6MToPEGXm2IsakqX3NYJXJMtB2pgtfkj0HRlt/O3XV6FPK+ZmafBVMw397fb3siBV
         Ym6c6OhgQ/BbBPgcaUrSg/ObB813tXqU6lqYivpVGYTSEyEAHMHc+9ExoYvMQSqhYrcp
         qObmfIZLSwbX29/TiIs9l7krP5U/BWdae6GVoJKcyPw1I+PrcjPYoDRf4JWY0JWBa5z2
         ArQYV3pvf/0S/Vh55fioWORYr/OIioK3LtSKT9AZIiY9Sd3ggrtQ9uqaKsfmhj95+znj
         hpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=Tu+IDqVxqm/cYcmM7Mrkrt4GO8grwsJaPlYirGrLTERdJVbrqwlO5woU5hi6WlKsKL
         a95KhDwDNN5I+nH40M5dKoa0umvhfCwNFNo+fY7yRLDlrr4crMRweWNEYW8qT2YZDd2T
         kQrdvuUVLv25vv3RCNvipwIU1DXolekTNS6uDhljGdln13nZiIfaw2cb+xOW9xfemZzM
         3Y7Y5skanpPC/tSxc0HiqMjWXSWAnCFlcQDblmB7TYqsagXzaVjK5IPsaPf4sTwCbBw8
         av0G1gZBvbkTcuP8wgFETzv2wX3SKqGAOXlzyn6LaItmxUYNZlt+/C/rucgnDCCgSQ1V
         U11Q==
X-Gm-Message-State: AOAM533otCHJFL818oxoY3jTunQs9WYK2JU+C9wcO9TngjgzE7h6TDIK
        yLAvGRmzwReAWJ3cXq8yB0nXCUQLfbo98pox+2IVw6GeRA==
X-Google-Smtp-Source: ABdhPJz6RI+DFTaAZKp1yYFkI36BapBPZgGOSGg8oZyqUJOh8WRI4wf9Oyp08Zz6Th80x+gDaI37+ox3yh/PXrCSCRM=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr12367624ejc.178.1621628377771;
 Fri, 21 May 2021 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-22-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-22-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:19:26 -0400
Message-ID: <CAHC9VhSmAUg-mVrHpmgr3bF_+MeFd3p6W9N3b_kptzEY5YrsiA@mail.gmail.com>
Subject: Re: [PATCH v26 21/25] audit: add support for non-syscall auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> To: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)

At some point I suspect we will need to add filtering for these
"local" records, but that is a problem for another day.

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
