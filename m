Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE93A9CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFPNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhFPNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:54:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E0C0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:52:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q25so2275720pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VozsCG34N+zg6xWc2EdM6N9UtXiLzWiPDlKE1T01qD8=;
        b=RM/yH+l97AcJD0c88YYjnisneTB8PqyPSWJybvmCapob5up+5FdIVgkTd1oMAhqEtc
         FK3e4DGrNxhA86UeYaWJuKKQRfNP9oclNNTdRIJadzA6uy5fd7m7Ac2admXWqZf2TuF4
         d7DYSxBx5ymW5Jdz8NTYPqQ76iosjYLG4C17YYIhS4x+FYroEe6GCEfmjaxKXuQ63tzJ
         3PAtQpH1NDeyy7Pjxb0EQKpVlq5g8bG0WhYFE/fZc19sk9EEnycMcPZKw57lRlRdUxIN
         llaG+k1ncUCky/IVb6Dr7JpEdv57c/nILbBVLgCvhSaFf4bPVCxBZODvaO+ndftxF71Q
         LogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=VozsCG34N+zg6xWc2EdM6N9UtXiLzWiPDlKE1T01qD8=;
        b=uVu2lVqLDJAybj+/1/PW6tZmb11DECOW+hUcBIf6rPPQp4XR0bUOcnRrlUUSVdoqQj
         xN/+xhxWZVsRk5Q+fkv2m7w2VZ4C9VYetSK/NvoFIxCgsG0/gMLy3syMFzjcy3znPjWx
         mqeP3FuI1YblT1NUt0B3DhJUui0cJRHT8FYNivuX/qNwRr3WeSLXWy3pNUJ2cHd+GLZC
         rjfot/vCcpmThdatQdQVl33siijmHKiEZiHzO6U1v/bzEGSd/BXZyXT0zSQKs5TlqhMp
         C6bTgcvk3nYFrLiMGZmS5RJkvqBlkhUd9rRWDcRiiubjH5HmNYsPdXfGYW1ZfFfZa7ur
         5Jxw==
X-Gm-Message-State: AOAM532gE+rXrxmW4+NH5Af1GYp2tR7RsuK0KVtbWsWjpjaU4EJCz+Lw
        EwTpmylv0rcPejjH7mgT6q7+rgFB5pgdEw==
X-Google-Smtp-Source: ABdhPJx3IXQ5qoIgQ/w8ZBD8jeialqo6NKQuXUPwixazluSdr0Kl0TfbBaU8SUEwZV+RW0KWZ7tJbw==
X-Received: by 2002:a05:6a00:a89:b029:2ee:da59:e89c with SMTP id b9-20020a056a000a89b02902eeda59e89cmr9686789pfl.17.1623851535470;
        Wed, 16 Jun 2021 06:52:15 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 20sm2389772pfi.170.2021.06.16.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 06:52:14 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
References: <20210614235635.887365-1-punitagrawal@gmail.com>
        <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
        <YMmggRL/htxFK2VY@alley> <YMmmhDQSX7gLmnN9@alley>
        <87im2ent74.fsf@jogness.linutronix.de> <YMnBQW2pInXyW3vv@alley>
Date:   Wed, 16 Jun 2021 22:52:12 +0900
In-Reply-To: <YMnBQW2pInXyW3vv@alley> (Petr Mladek's message of "Wed, 16 Jun
        2021 11:15:45 +0200")
Message-ID: <87sg1hsyr7.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Apologies for the delayed response.

Petr Mladek <pmladek@suse.com> writes:

> On Wed 2021-06-16 09:57:11, John Ogness wrote:
>> On 2021-06-16, Petr Mladek <pmladek@suse.com> wrote:
>> >>> Petr, as this is causing trouble for the -rt patchset, please
>> >>> consider if this could make it to Linus before v5.13 release.
>> >
>> > Punit, John, would you mind when I queue this change for-5.14?  It
>> > seems that, you, RT-guys already handled this, so it will not help
>> > much if I sent it now. It does not look appropriate to send just a
>> > single cosmetic fix few days before rc7.
>> 
>> Since this cosmetic problem was introduced during the 5.13 merge window,
>> it would help if it is fixed before the 5.13 release. Obviously this is
>> not a reason to have an rc7. But if there is going to be an rc7, I think
>> this fix should be included.
>
> OK, I have committed the patch into printk/linux.git, branch
> for-5.13-fixup.
>
> I am going to send the pull request later this week, most likely
> tomorrow.

Thanks for picking this up.

It's good to have to the patch go in early, but 5.14 would also be fine.

Punit

[...]

