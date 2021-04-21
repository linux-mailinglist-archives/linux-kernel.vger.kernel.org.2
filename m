Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22E36714D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbhDUR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbhDUR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:27:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4679C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:27:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so38443599wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5rB5hdeendPXtZ8kWukMNJqwT+C7isho8ILaV2Ei6o=;
        b=Fju+oMaW0JZE6NP+ZWRAXWvRXIbNMJ9AkdGWpnEpT9MFfQHRXAG+fvbY6kVNCuMvmv
         LojzxCPUkXSZnjVfw3UvD7H4ysLctuaUpYoHZ/9dwKF5gzsUpBpIPzwOVx7YB7ZzREFS
         lkcuBdEi6ByJEScWZxyesm7cbHU2sFimUGBSnsQTWP2JecS3Y2ig6fPqejI1iGujBQNq
         OFhCdy8aLJe/HGzUTxD2HQV0nZcpLpRH64kdNBmgML8Zphob/Xf6HbNgTUZ9kGUerWpb
         2SZZFRJuzVDmvASSSVdqdSbg//3smMc1lo3PZ7NQaF3noICRnSBSfeo4lk742ndCMj0o
         +e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5rB5hdeendPXtZ8kWukMNJqwT+C7isho8ILaV2Ei6o=;
        b=bnuIAeYOlCdrqOt6ggYwwOKxpsUsJdjxbB22VfGWwC2kxk5Mda3/AXn6ekDew7hrWZ
         Dzb1Camjr33riv5Fx+qsPL2ZcoHYV2AeK8V8E7KiO2O8LQScTAnW1I+ZL1IRqON6HPM5
         bAwxegwm3kzOS4ifdtT19euL/nFOelM1YA4eAL6n7NepYUCHcqWlwYpxL0l2ClpYmOwk
         KOAmEz2ms3j9kp4lSlpGO1I6Gcy8QjuAcFg+TQHyTwr/mEnx3rG6rNhc4tCUP2zGxMsG
         vMl+XOBdIKocd0h4Dg+p9rh4711uo4QH8Osa0W7t1ss9ghEPwT/QOanxR03ugJQy7z6l
         u1eQ==
X-Gm-Message-State: AOAM530DZx2pWfMXR3oPGLr4C99qPKtHSeXqpvdv8+b1+3glRfFhzR33
        L1VlMlkxyYz+5Hpxenm/ptdycQ==
X-Google-Smtp-Source: ABdhPJzJkAvQ2xZ2smIGZxg2awxu3YJLjsW5vTvBTIz7iwmQHISbAOifURiuXOjt6TiYzZyHioknTA==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr6127292wrv.333.1619026037338;
        Wed, 21 Apr 2021 10:27:17 -0700 (PDT)
Received: from snaipe-arista.infra.corp.arista.io (188-141-36-148.dynamic.upc.ie. [188.141.36.148])
        by smtp.gmail.com with ESMTPSA id m15sm110805wrx.32.2021.04.21.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:27:17 -0700 (PDT)
From:   Snaipe <snaipe@arista.com>
To:     gscrivan@redhat.com
Cc:     alexander@mihalicyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        ebiederm@xmission.com, geofft@ldpreload.com, jcsible@cert.org,
        josh@joshtriplett.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mic@digikod.net,
        mpatel@redhat.com, ptikhomirov@virtuozzo.com, sargun@sargun.me,
        serge@hallyn.com, stgraber@ubuntu.com, vgoyal@redhat.com,
        watl@google.com, Snaipe <snaipe@arista.com>
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated user namespaces
Date:   Wed, 21 Apr 2021 19:27:14 +0200
Message-Id: <20210421172714.912119-1-snaipe@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87ft6act3c.fsf@redhat.com>
References: <87ft6act3c.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Giuseppe Scrivano" <gscrivan@redhat.com> writes:
>>> >> instead of a prctl, I've added a new mode to /proc/PID/setgroups that
>>> >> allows setgroups in a userns locking the current gids.
>>> >> 
>>> >> What do you think about using /proc/PID/setgroups instead of a new
>>> >> prctl()?
>>> >
>>> > It's better than not having it, but two concerns -
>>> >
>>> > 1. some userspace, especially testsuites, could become confused by the fact
>>> > that they can't drop groups no matter how hard they try, since these will all
>>> > still show up as regular groups.
>>> 
>>> I forgot to send a link to a second patch :-) that completes the feature:
>>> https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2
>>> 
>>> When the new mode is used, the gids that are not known in the userns do
>>> not show up in userspace.
>>
>> Ah, right - and of course those gids better not be mapped into the namespace :)
>>
>> But so, this is the patch you said you agreed was not worth the extra
>> complexity?
>
> yes, these two patches are what looked too complex at that time.  The
> problem still exists though, we could perhaps reconsider if the
> extra-complexity is acceptable to address it.

Hey Folks, sorry for necro-bumping, but I've found this discussion
while searching for this specific issue, and it seems like the most
recent relevant discussion on the matter. I'd like to chime in with
our personal experience.

We have a tool[1] that allows unprivileged use of namespaces
(when using a userns, which is the default).

The primary use-case of said tool is lightweight containerization,
but we're also using it for other mundane usages, like a better
substitute for fakeroot to build and package privileged software
(e.g. sudo or ping, which needs to be installed with special
capabilities) unprivileged, or to copy file trees that are owned by
the user or sub-ids.

For the first use-case, it's always safe to drop unmapped groups,
because the target rootfs is always owned by the user or its sub-ids.

For the other use-cases, this is more problematic, as you're all
well-aware of. Our position right now is that the tool will always
allow setgroups in user namespace, and that it's not safe to use on
systems that rely on negative access groups.

I think that something that's not mentioned is that if a user setgroups
to a fixed list of subgids, dropping all unmapped gids, they don't just
gain the ability to access these negative-access files, they also lose
legitimate access to files that their unmapped groups allow them to
access. This is fine for our first use-case, but a bit surprising for
the second one -- and since setgroups never lets us keep unmapped gids,
we have no way to keep these desired groups.

From a first glance, a sysctl that explicitly controls that would not
address the above problem, but keeping around the original group list
of the owner of the user ns would have the desired semantics.

Giuseppe's patch seems to address this use case, which would personally
make me very happy.

[1]: https://github.com/aristanetworks/bst

-- 
Snaipe
