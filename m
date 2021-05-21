Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6938CEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEUUTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEUUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:19:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F57C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:18:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f18so2049114ejq.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sMdTl7u0R0AzpRROFQwhFdSjTOMMFcRx94kc22Y28o=;
        b=KBwXDQvVFhheTgrWzG4kP9Rqr3ASbkirq9pvYHtdhIDHOcYsoRXci61prRjuuR5qYN
         neV9Tg/xUQ7uNM/XsT98FqSHBAOcH6k63NLHwsSgwwPLRQBFaGWcS+qXeHL6KBPWWwAv
         qrl92HuciQccPP6cFbPdwG+jbQ7mB3YO4WHVl6OK0SoNXDnMeLw77jMerf1bClmu5bJp
         FzSnJ3n6H3miRWbKg0B8p34vpXhO+4dmzRNtNKOhkchID+9i/VfOX94wePZrYI+3k5ZX
         9knGiEul/3zhmVZO7qQiDciI4R9JitypXNd11L9/BDVdwQtlqTMjOkqSS5uHgIxwb1xe
         t97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sMdTl7u0R0AzpRROFQwhFdSjTOMMFcRx94kc22Y28o=;
        b=bYIj+5bncUGjM4jll4uhC+Sev6/nBg6GNDN/2TYz1Pmr5S0W0fdP9Js1TxL2gTWfCk
         MWZ0uYxDTaZYfX7mIa+NZVtDcqhzeMXood3x7QZ8zA355ZepB46jQIy9Nyrcl6egzKSh
         JNtCsyoEmFY3/KQ4+rTZCNY1sRsw73YmNXuuP6TL8ni5dCbBxdYKVfcAYzPuNIszTAoo
         vpn8G4XuERkCX2Af50qqd3zZsT9IDlTimHaPfQgpX0gbSPtODRDRwJpdmnHQPtczqGUU
         KC9OF6gI6c2wz+PFcqXtJDIQZR0l/ULewNtVWUhZzCyhMdbVCk/EDPG50IK9XGEKsVsa
         6YPw==
X-Gm-Message-State: AOAM530FE0VtxVNlYcM/xP4OqUsKJoycy1P9laB754FiyCmZsmMv0xl1
        dz2TjfPMt/bmO/xtgkCrRZD++5JLYyn94tdQVefS
X-Google-Smtp-Source: ABdhPJw+G1I83fqGMRZamYvqeG7k+f1/mkcz+tjl2Betw7xDYJDnseTY8KipUGd/G662GERvU4IPtcvi4R2iw5KPRzE=
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr11894237ejx.431.1621628296848;
 Fri, 21 May 2021 13:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-4-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:18:05 -0400
Message-ID: <CAHC9VhS_+fqSzA7CXOd5VOAb+kfED+mgoiWF9Z6wc=_n933vrg@mail.gmail.com>
Subject: Re: [PATCH v26 03/25] LSM: provide lsm name and id slot mappings
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Provide interfaces to map LSM slot numbers and LSM names.
> Update the LSM registration code to save this information.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  4 ++++
>  security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
