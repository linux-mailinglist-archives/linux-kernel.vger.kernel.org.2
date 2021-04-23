Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F153694DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhDWOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhDWOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:37:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:36:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 4so17999604lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGVMK1LPh9iIc+XnF1YdK9uGnLn1GjuOH4C0X7AWW18=;
        b=ibnNxKI5LWvzWd65BU2zvJQ3lZMkhb1LLEARrXo8fh/Rbz/rfSC6mIwVjEdsykK89c
         NejtsnaccVOuASPeR9gGFE5MPQzHaHKRgP5Y/pz0cOECwfTI0q8/0miB8rvnra9ZOCZ/
         ng1jnduShfGZAfZyFIY5f0GV9vDniT6Xx7XqgmFTLL7DqonI8SYoqhkDjdN5jfba7u7P
         PvQxVkNETEmcUxzBXMmpliJQJ97BhmLTKtJ+gTKzXfdKmCjPyMCQVNqlf/QSI6u/3aEi
         hksfL1C3NTyGLoxH+em122rqRRn3Wtx8Qdyo4zc0DE13g71NRdPskvQx8eSfOG4kIHrI
         AcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGVMK1LPh9iIc+XnF1YdK9uGnLn1GjuOH4C0X7AWW18=;
        b=Bg99GebDAWESOQhGTuen6iEm6Pu0tKkpv4iHjOVktk2HeU7T3dDBvjFybwFEhWsn4d
         Y1H2bM9RvtGF1605DAfI9HBZ6icJCIU/lhZ/KaPvy7UgOJH3A650Qt4QAwNlywgAdkFm
         Ws4pjzpGnVSr9w+p/81kAjnnCLBEGPxQ9GC9oMzV8yYt3SJ8qqG5sXo0uJAZXJIG6WQ3
         anXVnzkuGzRR6j0RliIBWZWb6C5arwM9kfwM5RPHFRwlW3voJaPUSa0oZB+6IpqecO6Z
         U0TV/y3BTehDv06bqNz+htstUs5a8zZPPRI63kKYDgUV8rKUR/9StrkoAMWdfBYch214
         wklQ==
X-Gm-Message-State: AOAM531naBdt1CfOAcw3tBQ4wES3gGEPiCvgtdI1lgcJ/AG9DDa+e3Mn
        CJByCe+w5fXgpx6y0nrzFOuIFUk4tRE9ob+q+pk7MA==
X-Google-Smtp-Source: ABdhPJyP6Uu0qWuAegZYZDUSEd9xuSqzExELRiyoT5S0n936RRLzfq/8QcEhnek3SSimkfoYPYC2HuOLBQSjzbhGPSQ=
X-Received: by 2002:a19:7e97:: with SMTP id z145mr3212097lfc.280.1619188608499;
 Fri, 23 Apr 2021 07:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <87ft6act3c.fsf@redhat.com> <20210421172714.912119-1-snaipe@arista.com>
 <87h7jyvfsm.fsf@redhat.com>
In-Reply-To: <87h7jyvfsm.fsf@redhat.com>
From:   =?UTF-8?B?RnJhbmtsaW4g4oCcU25haXBl4oCdIE1hdGhpZXU=?= 
        <snaipe@arista.com>
Date:   Fri, 23 Apr 2021 16:36:12 +0200
Message-ID: <CAK8sBDOfVKvv4V-0wzz6ZAsi0Gs6pPVDHhxg++RLgcdA5mmF3g@mail.gmail.com>
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Alexander Mihalicyn <alexander@mihalicyn.com>,
        christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        ebiederm@xmission.com, geofft@ldpreload.com, jcsible@cert.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mic@digikod.net,
        mpatel@redhat.com, ptikhomirov@virtuozzo.com,
        Sargun Dhillon <sargun@sargun.me>, serge@hallyn.com,
        stgraber@ubuntu.com, vgoyal@redhat.com, Wat Lim <watl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:18 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> thanks for the feedback.  We are still facing the issue with rootless
> Podman, and these patches (listed here so you won't need to dig into archives):
>
> https://github.com/giuseppe/linux/commit/7e0701b389c497472d11fab8570c153a414050af
> https://github.com/giuseppe/linux/commit/1c5fe726346b216293a527719e64f34e6297f0c2
>
> would solve the issue for us as well and we can use setgroups within a
> user namespace in a safe way.
>
> Any comments on this approach?  Could we move forward with it?
>

I rebased and built your changes on top of v5.10, patched our tool to
burn "shadow" into /proc/self/setgroups, and it's working beautifully:

    $ id
    uid=1000(snaipe) gid=1000(snaipe) groups=1000(snaipe),998(wheel)

    $ bst grep . /proc/self/uid_map /proc/self/gid_map /proc/self/setgroups
    /proc/self/uid_map:         0       1000          1
    /proc/self/uid_map:         1     100000      65536
    /proc/self/gid_map:         0       1000          1
    /proc/self/gid_map:         1     100000      65536
    /proc/self/setgroups:shadow

    $ ls -l
    total 8
    drwxr-xr-x 2 root wheel 4096 Apr 23 14:18 allowed
    drwx---r-x 2 root wheel 4096 Apr 23 14:18 denied

    $ bst sh -c 'id; ls allowed denied'
    uid=0(root) gid=0(root) groups=0(root)
    allowed:
    ls: cannot open directory 'denied': Permission denied

    $ bst --groups 1 sh -c 'id; ls allowed denied'
    uid=0(root) gid=0(root) groups=0(root),1(daemon)
    allowed:
    ls: cannot open directory 'denied': Permission denied

-- 
Snaipe
