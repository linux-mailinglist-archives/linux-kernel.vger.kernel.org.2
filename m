Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1073F3418
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhHTStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhHTStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:49:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C368C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:49:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 22so11871430qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdUf1AFFmq8vkogFZzhYw8djub7X7CPEGtEw7SwIdK8=;
        b=Cmdhmms2k9zLRdAZjTsQghObPy1K33cXuM3Gf4RkvBwRxflxuW0twNw2pOx33gU9PP
         NCBswM1+O47VjvNHQOxvRoQrRIAcc7Zq3t4+oP+OQwuVxRUZoY8550foGDOxkeCffFXs
         er2xDt7LPKqTfv82R8sW9dwFDXw2dpBMCXQW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdUf1AFFmq8vkogFZzhYw8djub7X7CPEGtEw7SwIdK8=;
        b=am2bk810aYvrfAEmhEJ3NSlQUjMa+9cA9ZcQIJzQf7ssts+OlcCosDLFeefzd3ndIX
         +ezE1kZtBmrvcZHSJS9d29r5Xu5zyoRniAc4exGbfgtjQ3iUsRDn5iOY1N6/NH11IyKy
         4fmLNClF8jw9yOarHb9BugK9B6u9tEs3lA2OfXbFEtF6qMYUjXqfM4Cu5HGOq4eJf6Tp
         XAb/TAAHwVybxtOWi19bkDvRqpvrKAQyAnwJvxig39Gh6XMxROnj9t0PjMkzKc/e1T2m
         2VPM4GQavIc+b5YuFeiPKmrQVO2HLJisyM17nBQzOyFVkU98GPZzAoGXuWZ4qQBkNDMM
         sJ5g==
X-Gm-Message-State: AOAM5303659gv1d4j1MfTqFEnPI2ZDQMlhnhHg4iY0JOpfl12jfmkWuf
        iY2BaiUwqBmtyHdGNqWT59I44g==
X-Google-Smtp-Source: ABdhPJzn8Uz2tHnUy8gV9fGzqXPRy9jbL3k/vX/hp/wFWJsVHz2PO7hwReO6b5o9YUAygHPtd5srpA==
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr10345615qko.392.1629485350480;
        Fri, 20 Aug 2021 11:49:10 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id s69sm3612715qka.102.2021.08.20.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:49:10 -0700 (PDT)
Date:   Fri, 20 Aug 2021 14:49:06 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 2/2] Documentation/process/maintainer-pgp-guide: Replace
 broken link to PGP path finder
Message-ID: <20210820184906.bcypsextkp2rm4e4@nitro.local>
References: <20210812095030.4704-1-sj38.park@gmail.com>
 <20210812095030.4704-2-sj38.park@gmail.com>
 <87fsv4rqfq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsv4rqfq.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:12:09AM -0600, Jonathan Corbet wrote:
> This looks fine to me, but I'd like Konstantin [CC'd] to have a look and
> let me know if he agrees...

Yes, this looks good to me. The entire section needs a more in-depth rewrite,
but I'm not ready for that work yet, and this patch at least removes a dead
link and offers some alternatives.

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Thank you!
-K


> > -Next, open the `PGP pathfinder`_. In the "From" field, paste the key
> > -fingerprint of Linus Torvalds from the output above. In the "To" field,
> > -paste the key-id you found via ``gpg --search`` of the unknown key, and
> > -check the results:
> > -
> > -- `Finding paths to Linus`_
> > +Next, find a trust path from Linus Torvalds to the key-id you found via ``gpg
> > +--search`` of the unknown key.  For this, you can use several tools including
> > +https://github.com/mricon/wotmate,
> > +https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, and
> > +https://the.earth.li/~noodles/pathfind.html.
> >  
> >  If you get a few decent trust paths, then it's a pretty good indication
> >  that it is a valid key. You can add it to your keyring from the
> > @@ -962,6 +961,3 @@ administrators of the PGP Pathfinder service to not be malicious (in
> >  fact, this goes against :ref:`devs_not_infra`). However, if you
> >  do not carefully maintain your own web of trust, then it is a marked
> >  improvement over blindly trusting keyservers.
> > -
> > -.. _`PGP pathfinder`: https://pgp.cs.uu.nl/
> > -.. _`Finding paths to Linus`: https://pgp.cs.uu.nl/paths/79BE3E4300411886/to/C94035C21B4F2AEB.html
