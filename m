Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107DF39D8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:32:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12466C061766;
        Mon,  7 Jun 2021 02:30:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u7so8312417plq.4;
        Mon, 07 Jun 2021 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2JerVA1VHCTyizXqePnq3qQnv++F/TT5NpQwMNuIAo=;
        b=JGUo/jsLGJSGL19clNMaZPJzD9DG1+PVVGHz7WaaBSUTqCrB7X1ZeTIqNEgp7SUtma
         Yod9Qw+1oEvjvDq/rO3ftHFYe+kAWUHGK1xUT0tCTwkZByUJ/NrCi1a61hZyx2ZIW4r/
         WvGA+AUjybNtTNCdqDDYOQ3wK5F40H1z89jxkHtzghyRYSv2gs9LOk0/zeodXgGsLTqG
         Z9lyBvX4yYOtYifKok1oKuRFstqU12Px70X9iiQyWqgoEtkGSSOGggeLeWKXcrniUMod
         iNe2HNKz1pVur46PlZFahgapovTuN3u7nKyVO6z8TuwzJv9Uu7b9vvkKW3rDfUjVLtt2
         7KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2JerVA1VHCTyizXqePnq3qQnv++F/TT5NpQwMNuIAo=;
        b=SKku1fxqyjbJr56m2hvyT0/cYZK2wZKnvQwoegh0cQRlNpjKG3kwmNWJD8MIHeoJGo
         aWCfYMxPpnTMs0/XoBW9jaiVDiq4/qlDee90UivXHFOqJ9pY0UmYauVMA5uXYF0q5bEX
         Msmz6MuGySHALEzS5GWObcRINCf0wtXDCNYX96kvntTtheIazqWW604DqGsXdetTPBz6
         7Xf8casS5DyZIRef7EQmtEnH2psJDd5TUvwM9YRvUm074Afr2GJEL0Ka0YtCC31DsSMb
         VKZ6jM4KWudzsi8ieFD2onadOkfGK9VQ0IoiII2K0l4fQ1tJgEyzSudDcQw/1KflBD6/
         wf6g==
X-Gm-Message-State: AOAM531AJR0uIH2Oegr6qCZDFfKcCAbMkG5uYNqB4CE336IQdGebqgb3
        mF95pBfk+V+28l9tnWp0yqm6m7Y6BWomLJKdGr/7gXoZDw0=
X-Google-Smtp-Source: ABdhPJxb3LYV/XLgT8301IX0JYp7qKmnU5PoNHx2d9CN4pqEbPUmH921akvsCKwQx5s5ta91uAEVkrGsxGcpM1yw++U=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr31826816pja.181.1623058209193;
 Mon, 07 Jun 2021 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210606200911.32076-1-andy.shevchenko@gmail.com> <YL3lomK79iIuE13f@kuha.fi.intel.com>
In-Reply-To: <YL3lomK79iIuE13f@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Jun 2021 12:29:53 +0300
Message-ID: <CAHp75Ve5Kq4Wn0f2AxcyK3gP8Qs1s5fWvyVDjAyToqMpA5Humg@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 12:23 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Sun, Jun 06, 2021 at 11:09:09PM +0300, Andy Shevchenko wrote:
> > device_get_next_child_node() bumps a reference counting of a returned variable.

...

> >  err_remove_ports:
> > +     fwnode_handle_put(fwnode);
>
> Wouldn't it be more clear to do that in the condition that jumps to
> this lable?

In this case it doesn't matter. As a general pattern, no, because this
will help to keep this in mind in complex error handling ladders. That
said, I prefer my variant unless there is a strong opinion to move it
into the conditional.

> >       for (i = 0; i < pmc->num_ports; i++) {
> >               typec_switch_unregister(pmc->port[i].typec_sw);
> >               typec_mux_unregister(pmc->port[i].typec_mux);


-- 
With Best Regards,
Andy Shevchenko
