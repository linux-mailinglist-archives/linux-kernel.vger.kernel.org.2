Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D29B39D916
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFGJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:53:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943DC061766;
        Mon,  7 Jun 2021 02:52:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h12so9842662pfe.2;
        Mon, 07 Jun 2021 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKo/mgGHHTcuIxCxc3MnzY9BgWUhPNqCYcUFlioweBc=;
        b=viDGSPa8x7Qp+lMcvxqJHk74xVNA3/9fURvRNfxbilmAIFgM74/QdumptMEhezWqOp
         pBiXwv/7Og7Y/a1/IM1KkoJwHq+ZUjq8q8YXkes9h6zkVkVXri1tHeW+M6kaHcnfxM9x
         UrgFFKt9oU5geeR2BrR8O97ipzADKFq0NYBuCZE/GU9wDqcuYqH7Hr+gH7OTRnrqbxj7
         oL4KDaJ+RpShlhZz7EuNGpq40KLPdtqed/c7smimp1hJOF4jXPJjw3WZ4HQdxNQ+N+Et
         kagIT/FypvKzD2TQbcDxQ8TEq0txkovYwfqstOlUNftGQ9QsAoNuPeSOeMCLE/WJK5Yd
         62JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKo/mgGHHTcuIxCxc3MnzY9BgWUhPNqCYcUFlioweBc=;
        b=VUD/i63sM+mTjRiafRXisHKWGdoT6OQ5GhQELCqqevbRuceC4EIciRxPDncRvzDQzw
         h0LXiEexMQ1iJbmEtq6j3cytnhBD1oXr8Gb/g0U+DzUTaDYCY0+GcPHBu+zIPDeEIHHl
         yTwjhhbmEjqoyuyj37Z0GpGMh+hRYAQjMPLDYlx0TLS2cRy9XECAbWQ2v/qQL1Ppl83n
         2HjrmLg2cMmqKYdKevz2YppDVQKL1vq8yopxYZodPXJ4L5c3Q5VzgxTkX0K/vm3A4FDj
         d3/gDoxocURFncEAzoToUm0bfpwO8q7IGRigLdN+7qqIgNMbdMt/FlOb9ePWW0+XYXbZ
         Hv0w==
X-Gm-Message-State: AOAM532BpcnWXqqaDKyTZy9Ti+lxYAgeiizOlg8x0vZ/KBmeMFokzD5+
        3wYpbvEt4z0ZBbdzTK+kGSauAUZ+9Od+RrFF86pwKdqAnec=
X-Google-Smtp-Source: ABdhPJyqNB6zJ7ziRYR98dyktkbfd+iKqCcX+LX7tqPp5bzQUWmbLI+XMXu2TNjrr9HIYzC2jTqhvpLMghGfnwab2YA=
X-Received: by 2002:a63:4145:: with SMTP id o66mr17204205pga.4.1623059524342;
 Mon, 07 Jun 2021 02:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
 <YL3lomK79iIuE13f@kuha.fi.intel.com> <CAHp75Ve5Kq4Wn0f2AxcyK3gP8Qs1s5fWvyVDjAyToqMpA5Humg@mail.gmail.com>
 <YL3rkZd/2giR+Qok@kuha.fi.intel.com>
In-Reply-To: <YL3rkZd/2giR+Qok@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Jun 2021 12:51:48 +0300
Message-ID: <CAHp75VdFih-TMWXWXr9vnDJkBDBb7K7yv3rfUP6T0HF2SAMGHw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: intel_pmc_mux: Put fwnode in error
 case during ->probe()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 12:49 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Mon, Jun 07, 2021 at 12:29:53PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 7, 2021 at 12:23 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > On Sun, Jun 06, 2021 at 11:09:09PM +0300, Andy Shevchenko wrote:
> > > > device_get_next_child_node() bumps a reference counting of a returned variable.
> >
> > ...
> >
> > > >  err_remove_ports:
> > > > +     fwnode_handle_put(fwnode);
> > >
> > > Wouldn't it be more clear to do that in the condition that jumps to
> > > this lable?
> >
> > In this case it doesn't matter. As a general pattern, no, because this
> > will help to keep this in mind in complex error handling ladders. That
> > said, I prefer my variant unless there is a strong opinion to move it
> > into the conditional.
>
> Now it looks like you are releasing the mux device fwnode instead of a
> port fwnode because everything else related to the ports is destroyed
> in below loop. That's too confusing.
>
> Just handle it inside the condition, and the whole thing becomes
> clear.

I see your point, okay, I will update in v2.
Thanks for your review!

> > > >       for (i = 0; i < pmc->num_ports; i++) {
> > > >               typec_switch_unregister(pmc->port[i].typec_sw);
> > > >               typec_mux_unregister(pmc->port[i].typec_mux);

-- 
With Best Regards,
Andy Shevchenko
