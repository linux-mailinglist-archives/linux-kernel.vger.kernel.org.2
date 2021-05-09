Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75D3777E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEIR5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 13:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhEIR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 13:57:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B611C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 10:56:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p4so12086248pfo.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=udo6/j0jGdw95A7jASH0giURmHp5K6dK+lFQZ5YaJMI=;
        b=JL29Vnge3Oaut+Mk+DbWy1HapeD5i6UanRapnwwkg54ztn8Vit/4Dxp2kMMJ5cDWtE
         yBSeh4/vgg0UvwW1y9yK4W8krJSaAalA0tKPl6tZFHDB4ztYKvmL16YpcZpASSmpobkL
         QAuVNPfiVzgZ3vs0LQIQggAcplTXwxW2ZGXgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=udo6/j0jGdw95A7jASH0giURmHp5K6dK+lFQZ5YaJMI=;
        b=Apc0B9rb60dU2IwlJC1U6An9ESPvk0qqZ5h1lniCd5qPC3MY+HdOm9VBeeZzjJnPYx
         eI0crGuSmL1nSoX75CDUHRi/o2/Tgvi3ZQkJCEmZ2Dv6KBN/7hfrYXF9EYw+iYRCozCn
         x69NzpQmjHvErnGClnqei0q7IRp7LPd1JaQWsSVjl+N64MSHXKrU2QDF3zECeK8lYV2L
         91Rv9PlNHUugUKUTgFk5NapeRSFU3EO/YsY0uVcrP9Qk6JMg1vfbiiD0/1eV8snKsmUr
         sy1o+M/MR3HTycdQ1SeTZF8K+L1U36o7mJ+nj3VpZuSXYmvd47s4yzYJ+b9StNyQWiWu
         nZPg==
X-Gm-Message-State: AOAM532LroSeoo+PJ5kfgwiNgHUoweg2EhwnzFDhG/HIYLzv+ohVwVLa
        ZhN350yj5gY+zf0nTNJr9HgAyg==
X-Google-Smtp-Source: ABdhPJweaCKlqas5FhJrre3dey3Iam7lvjB+buaz/gToGtX0ZBZ6DqV4yk4whhFW30HYyHLVV1JB1A==
X-Received: by 2002:a63:34c:: with SMTP id 73mr21282190pgd.431.1620583006145;
        Sun, 09 May 2021 10:56:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm9291461pfc.186.2021.05.09.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:56:45 -0700 (PDT)
Date:   Sun, 9 May 2021 10:56:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        tech-board@lists.linux-foundation.org
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
Message-ID: <202105090945.2B5129E9@keescook>
References: <202105051005.49BFABCE@keescook>
 <CAK8Kejr8bggXruciJT=JW3mk2z=WxYrtN+HBouPq4E2FU=6GrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8Kejr8bggXruciJT=JW3mk2z=WxYrtN+HBouPq4E2FU=6GrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 08:30:21PM -0500, Kangjie Lu wrote:
> We again extend our apologies to the Linux Kernel Community for the
> concerns and extra work caused by our inappropriately designed
> "hypocrite commits" project. We also want to express our appreciation
> for the thoughtful report released by the Linux Technical Advisory
> Board (TAB)  on May 5, 2021
> (https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/ ), and
> the willingness of the Linux Foundation to meet with us on May 6,
> 2021.

Awesome; thank you for the apology, and thanks for working with us on
sorting this all out.

> The University of Minnesota team has reviewed the TAB findings and
> want to confirm that the findings are comprehensive with an exception
> discussed below.
> 
> One email address missing is a visiting student in the team who used
> the account “Wenjia Zhao <driverfuzzing@gmail.com>” to send four
> patches for bugs found by a tool:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=29945&state=*&q=&archive=both&delegate=.
> None of those patches were accepted or merged.

Ah-ha; thanks for pointing this out!

For my own reference, here's the public-inbox search:
https://lore.kernel.org/lkml/?q=f%3A%22Wenjia+Zhao%22

> All Minnesota patches submitted before August 9, 2020 were part of
> previous bug-finding research projects and submitted in good faith and
> intended to address bugs in the Linux Kernel. The four patches

Yes, and speaking for myself and the larger community: thank you for
this work! There are a lot of bugs, and while exploring new ways to
find bugs is certainly useful, it's the _fixing_ of them that is the
most important thing for Linux. (Best, of course, is discovering and
removing entire bug _classes_, of course.)

There is a lot of research done on the Linux code base, but only a
small set of researchers actually take the extra time and effort to
send patches. So, thank you (and them) for doing that.

It sounds like we're now all on the same page about creating spaces
to further support mentoring (both internally within your group and
externally in public for all interested researchers) to help with both
patch submission process and technical improvements. This will be an
ongoing process, and as plans solidify on our side in the coming weeks
we'll keep you in the loop.

> Furthermore, we want to state unequivocally that no other Linux
> components or any other open software systems were affected by the
> 'hypocrite commits' case study or by any of our other research
> projects. Our “hypocrite commit” work was limited to the Linux Kernel
> only and consisted of only the four patches (one is valid) submitted
> between August 9, 2020 and August 21, 2020.

Thanks for this clarification, too. We had fielded several questions
about this, and I'm sure they weren't the only folks wondering. :)

> We reiterate our apology, and we rededicate ourselves to educating our
> faculty and students in conducting research that is not only of the
> highest technical quality, but also follows the highest ethical
> standards.

Thank you again. I think we all have a good opportunity here to make
the best of the situation and come out the other side for the better.

-Kees

-- 
Kees Cook
