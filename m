Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40B367D91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhDVJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235362AbhDVJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619083091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1baHM7nEka/Zfb1PwxTxoIZrmYwNdCkYeX0BTAU5Ho=;
        b=UR79NFdDTdJiOT+7hZUv4016evwQQekZIUsnXHLRnojkq6FoegNmN0sZrUTR6OC1xhk8dD
        VXKL0/akt2tiWoLQlc2XjgOz2M8HY+9D1CWSjmMGiik0sjAiVHxcRAx/8f4aH69y7eQHzC
        9tDUuR4g9o3yYAvTF0pPrYBJI5xdY08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-owvUNEI3Moi9N-EP2QcMeQ-1; Thu, 22 Apr 2021 05:18:07 -0400
X-MC-Unique: owvUNEI3Moi9N-EP2QcMeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97FAD343A7;
        Thu, 22 Apr 2021 09:18:04 +0000 (UTC)
Received: from localhost (ovpn-113-147.ams2.redhat.com [10.36.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C151A60938;
        Thu, 22 Apr 2021 09:18:02 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Snaipe <snaipe@arista.com>
Cc:     alexander@mihalicyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        ebiederm@xmission.com, geofft@ldpreload.com, jcsible@cert.org,
        josh@joshtriplett.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mic@digikod.net,
        mpatel@redhat.com, ptikhomirov@virtuozzo.com, sargun@sargun.me,
        serge@hallyn.com, stgraber@ubuntu.com, vgoyal@redhat.com,
        watl@google.com
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
References: <87ft6act3c.fsf@redhat.com>
        <20210421172714.912119-1-snaipe@arista.com>
Date:   Thu, 22 Apr 2021 11:18:01 +0200
In-Reply-To: <20210421172714.912119-1-snaipe@arista.com> (snaipe@arista.com's
        message of "Wed, 21 Apr 2021 19:27:14 +0200")
Message-ID: <87h7jyvfsm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Snaipe <snaipe@arista.com> writes:

> "Giuseppe Scrivano" <gscrivan@redhat.com> writes:
>>>> >> instead of a prctl, I've added a new mode to /proc/PID/setgroups that
>>>> >> allows setgroups in a userns locking the current gids.
>>>> >> 
>>>> >> What do you think about using /proc/PID/setgroups instead of a new
>>>> >> prctl()?
>>>> >
>>>> > It's better than not having it, but two concerns -
>>>> >
>>>> > 1. some userspace, especially testsuites, could become confused by the fact
>>>> > that they can't drop groups no matter how hard they try, since these will all
>>>> > still show up as regular groups.
>>>> 
>>>> I forgot to send a link to a second patch :-) that completes the feature:
>>>> https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2
>>>> 
>>>> When the new mode is used, the gids that are not known in the userns do
>>>> not show up in userspace.
>>>
>>> Ah, right - and of course those gids better not be mapped into the namespace :)
>>>
>>> But so, this is the patch you said you agreed was not worth the extra
>>> complexity?
>>
>> yes, these two patches are what looked too complex at that time.  The
>> problem still exists though, we could perhaps reconsider if the
>> extra-complexity is acceptable to address it.
>
> Hey Folks, sorry for necro-bumping, but I've found this discussion
> while searching for this specific issue, and it seems like the most
> recent relevant discussion on the matter. I'd like to chime in with
> our personal experience.
>
> We have a tool[1] that allows unprivileged use of namespaces
> (when using a userns, which is the default).
>
> The primary use-case of said tool is lightweight containerization,
> but we're also using it for other mundane usages, like a better
> substitute for fakeroot to build and package privileged software
> (e.g. sudo or ping, which needs to be installed with special
> capabilities) unprivileged, or to copy file trees that are owned by
> the user or sub-ids.
>
> For the first use-case, it's always safe to drop unmapped groups,
> because the target rootfs is always owned by the user or its sub-ids.
>
> For the other use-cases, this is more problematic, as you're all
> well-aware of. Our position right now is that the tool will always
> allow setgroups in user namespace, and that it's not safe to use on
> systems that rely on negative access groups.
>
> I think that something that's not mentioned is that if a user setgroups
> to a fixed list of subgids, dropping all unmapped gids, they don't just
> gain the ability to access these negative-access files, they also lose
> legitimate access to files that their unmapped groups allow them to
> access. This is fine for our first use-case, but a bit surprising for
> the second one -- and since setgroups never lets us keep unmapped gids,
> we have no way to keep these desired groups.
>
> From a first glance, a sysctl that explicitly controls that would not
> address the above problem, but keeping around the original group list
> of the owner of the user ns would have the desired semantics.
>
> Giuseppe's patch seems to address this use case, which would personally
> make me very happy.
>
> [1]: https://github.com/aristanetworks/bst

thanks for the feedback.  We are still facing the issue with rootless
Podman, and these patches (listed here so you won't need to dig into archives):

https://github.com/giuseppe/linux/commit/7e0701b389c497472d11fab8570c153a414050af
https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2

would solve the issue for us as well and we can use setgroups within a
user namespace in a safe way.

Any comments on this approach?  Could we move forward with it?

Regards,
Giuseppe

