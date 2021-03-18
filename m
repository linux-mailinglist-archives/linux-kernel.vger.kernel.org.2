Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10DB340F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCRVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCRVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:00:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:00:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so8385497eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pk3cp+v6YlZyN4xKQXvj66VAclgfjtmhX2dsPQTgLT4=;
        b=1CDIjzpb7IiRTxYtGRBfOFZnkaeQZcU6tCtsM0u1Hv7Iqky2si+YZIv1GpvZTmGHx9
         l73Hzjl3jQPHml4eynJk8V8cX2tTJAAU9tWt3yBpcgb4MK0TDelTPOXllAC1cruY/eVn
         YA3MfNLd044Dl05/gq82aPk8Cnea81twqoeztdg+VLtUgkN4eQO/Nn1XzeuAtws314p+
         CfEf7szarB+Nip4zvz8MSBXTOTwOh9r6wurzw+c/4OCCagrar71fe2/q5PrJAbeQEanU
         TFHuEQjzb2lseghVOngZxoVDQLEZ6kK9MeosTqYa5TBv9apbbh5EOljOlMFO8tmIneJO
         2iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pk3cp+v6YlZyN4xKQXvj66VAclgfjtmhX2dsPQTgLT4=;
        b=Iv8mdVjB6hhXiYkg7T7FWfpe9osbd8zRZVnHUG48QjxtOBY5devBCRhJAHP+na2gSU
         mXysHJzLRIetY1/CnfXt0iubiPfkfqxymZKQ3lo++G36jBCKRvHfmVvcQjIWuRhVTTFU
         dL/0LNA3Jop597p9lO6KYEd/L4lWSywkxHOFYOOCB0oFYX8cavsVs4zDt/wD2IEEC1/D
         CUen8jYuTA5RVc7yemKevvilnlPmkt2Yf4CatGNlzH9iPtC6ESN1aW3FRRYZ2IKKDs5B
         f/5dvEJXNAGoC/myHUPj9GzLVRNtV2M0/Pm0Y1EuYdBlf/qJ1xLIz+Y2gCsmdoH1Zg+t
         Fjzw==
X-Gm-Message-State: AOAM532cmI8ykTadPO5riSyFduVgJ6uHMMo2OOhhEWAtl8aS6IVs6J+W
        t5ZdD5cloUpYMTOH7NTpyeYFzi8LDcGrtQI91cMUf3g5aV14
X-Google-Smtp-Source: ABdhPJwySEHZUeFxtawcJmXkTYob/X3K5dX1GBxU3hU6zDycCQ1qsniXdD22+aakc14cKlR59nUoFOkSukFSCYqPD88=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr5998738edw.196.1616101209999;
 Thu, 18 Mar 2021 14:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616095045.git.rgb@redhat.com> <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
In-Reply-To: <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 16:59:59 -0400
Message-ID: <CAHC9VhSMKWZGchdKgLfiw_JCyFsKpWmN1y3vcHTiH2+bm3905A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] audit: document /proc/PID/loginuid
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 3:19 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> loginuid through proc")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
