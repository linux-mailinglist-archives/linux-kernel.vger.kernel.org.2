Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62B42439F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJFRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbhJFRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:02:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FABAC061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:00:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z15so2340137qvj.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fxSi8PqelwXGAM49ee3GDsiOvmrlfsT7dixC4BvaXM=;
        b=DKI6N9arBNA5oyVG0LDMFRu1ic1bKetEFLPqkbH9XNMMZ+LVAfHnPxcnamhx0DqrS8
         nQjiwOCxkisKYxsbtnFKeeEbV2+g6TKqX8Wywj8U7UR0wr9v5m7lchTwPk8weCA5HRb6
         ocOn5uy2BrK8JXUUQFe1gzNbN4MSLankSnEAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fxSi8PqelwXGAM49ee3GDsiOvmrlfsT7dixC4BvaXM=;
        b=q8FU6GvyHeyMhrXJYHi93BenvkKfF0hpM9PEmBCzUQiBpgbh8bY+5oHRyHZYmQyRz4
         lwjk8VFqI/Qu62pG1tGjBxsG50moPKtsA/xtaSA/KX0gm/sSEykyQpGP18iifmb6LsfD
         qjigV++HonFsOBjvXHn+MliXj4AIYni3OOmCh8e6KBXSAaoFmMzEKwPjp6eE0cqm/qg/
         wTvKSiRS5BBsc1zPt15Skj7BvCGjCLr3AJfy/aJvb4ZaeAMHIYnYabxHOkn+w6/562WV
         zYqU6OSwlN7L84Ywf3Wi8kRqBBU5erc24v6oqdSLvofirIkPxiDbe4hBjwO1sPa0s5/k
         INBg==
X-Gm-Message-State: AOAM53319U4gnDSMZoIDdNovgKYR+LaGx2b6nrQsEBHtpB05PCQu85mN
        Jo+ZqJsG0UhILrP7GTD4zi+q5g==
X-Google-Smtp-Source: ABdhPJzPYxfIoYs7SZ8Pytg71GoZRSSALKsxoy4g2ZYi2Cf3Cs43GAGXQv4b6ifdDRPegOEgAna+Mg==
X-Received: by 2002:ad4:574c:: with SMTP id q12mr4186418qvx.47.1633539627372;
        Wed, 06 Oct 2021 10:00:27 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id v3sm11898770qkd.20.2021.10.06.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 10:00:26 -0700 (PDT)
Date:   Wed, 6 Oct 2021 13:00:25 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: submitting-patches: make section on linking
 more explicit
Message-ID: <20211006170025.qw3glxvocczfuhar@meerkat.local>
References: <7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 06:37:38PM +0200, Thorsten Leemhuis wrote:
> +Add 'Link:' tags with URLs pointing to related discussions and rationale
> +behind the change whenever that makes sense. If your patch for example
> +fixes a bug, add a tag with a URL referencing the report in the mailing
> +list archives or a bug tracker; if the patch follows from a mailing list
> +discussion, point to it. When linking to mailing list archives, use the
> +https://lkml.kernel.org/r/ redirector with a ``Message-Id``, to ensure

We shouldn't be using "lkml.kernel.org" because that domain name can create
confusion that this is only valid for messages sent to "the LKML"
(linux-kernel@vger.kernel.org). The convention has been to use
https://lore.kernel.org/r/msgid for this reason. I would also reword that a
bit:

    ... or a bug tracker; if the patch was discussed on a mailing list, you
    may point to it using the lore.kernel.org message archiver service. To
    create the link URL, use the contents of the ``Message-Id`` header of the
    patch message without the surrounding angle brackets. For example::

    Link: https://lore.kernel.org/r/git-send-email.555-1234@example.org

    Please check the link to make sure that it is actually working and points
    to the relevant message.

-K
