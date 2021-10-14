Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFE42E349
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhJNVgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJNVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:36:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD195C061755
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:34:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so29860631edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoPu0jnNDwspHFj/KwTjXTK5IovBXrFnYnRM3qY9AfI=;
        b=a6KNglUwuPfv6oIfTS0ZYiZ4KlAFHaiXh7LKObdDfk5CWQzJWVBf4zQfr+h2DcJC+q
         /6GC8MY8aeLSG9gRqlIj5iz++B4UI0/XaeMbc1vyyC9cmgmj1Ga6sYbPgi13jZB/PdGw
         EjaDJ6X3eS1fm/ZL1GEQ8kxsLVPysO+XqTkMqqpFK6X+OPSHu9t9dspGa0ODwtJrnwYa
         2JCH5e8jK6dlNwBA2rh7BCfstK7WIld8g4LPRuxYNWh6XAQpRoLFqbqi+PtyK5d/X2pq
         MYKYgIXToadW9qIHhG8Z1QRBqXaqWeEHOjtwPhK/AqNf065c7fPuruiSGzVXxkmlA/rG
         NEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoPu0jnNDwspHFj/KwTjXTK5IovBXrFnYnRM3qY9AfI=;
        b=nGu6xbYr0awhX9IDWK2xH81kwX7Zks87Tym5nafyuXQG/Ja6fQ0OmoomK4Ir08SJXm
         bIgwYy9mmKL4q154JTCGvr/NfE81OPyBl/R5/t6tmAv6TpXOVWJua/F6azZzO62l3s03
         S9LvjyC4U0rP7DG8+FgPEHWtaYkY3tkaosiyYRuBJgTJ8CxyOkyWGAK3SgkRC1ZRQtoF
         yex6poq0HO2f7ZZOWD2QoHUgLtJWsq27i4xeBxZ80U0IVqiiXfdRD0m2CYfbHb85AZ9G
         FTyVighRIctlxK2oS81ENCw8HfoIBGFMfH6Fp7Mr5lvVUIcOMTyaAsQ+bFcJFNb9vQbf
         0APA==
X-Gm-Message-State: AOAM530Wc2mywnOipL25JOaDQJpP/iMmz0ljm4vhVqp+9brqfdknKKqk
        zhre7ZgMQUrHOnGZyf7bylDY+HvJ//0/6yGQZ6XD
X-Google-Smtp-Source: ABdhPJwdxSsmYhKsafUPIKuDs91ExUIKE/+rIIpYnPbV6xJvCFR8GllgoKtB9zmq6jGKXojYL90idam79iMgX4lDJwQ=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr12249192edb.370.1634247239018;
 Thu, 14 Oct 2021 14:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com>
In-Reply-To: <20211012165614.2873369-1-tkjos@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Oct 2021 17:33:48 -0400
Message-ID: <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] binder: use cred instead of task for security context
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:56 PM Todd Kjos <tkjos@google.com> wrote:
>
> This series fixes the possible use of an incorrect security context
> when checking selinux permissions, getting a security ID, or lookup
> up the euid.
>
> The previous behavior was to save the group_leader 'struct task_struct'
> in binder_open() and using that to obtain security IDs or euids.
>
> This has been shown to be unreliable, so this series instead saves the
> 'struct cred' of the task that called binder_open(). This cred is used
> for these lookups instead of the task.

Hi Todd,

I just merged all three patches into selinux/next, thanks for your
help patience on this patchset.  Ultimately I merged these patches
into selinux/next as opposed to selinux/stable-5.15 because I felt
that a couple of weeks in -next before going to Linus would be a good
thing.  I'm also not certain how widespread binder is outside of
Android so I figured the practical difference between next and
stable-5.15 is likely very small.  Regardless, all of your Fixes and
stable tags remain in the patches so as soon as they go up to Linus
during the next merge window the stable folks will be notified.

-- 
paul moore
www.paul-moore.com
