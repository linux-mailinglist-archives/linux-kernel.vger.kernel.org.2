Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B562F374A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEEVhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:37:20 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2173C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:36:22 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so813200ook.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASAFrRhfZJAuuXnQhdECK4EYYJ/yx+VALPvwUOZmAng=;
        b=UQBHTsd6dg9T9ke2XtND1OEHjTbMAHZKOcRejHpqEkMSA8VvGdCvXaQGA0oYPvPM/H
         IdVmCvc7MkHi/KbghU0uHk3a84VU0iKhuiP68j0brUhHUzXja+rBoRkhtEDX03qHQT89
         BQFo0ZNcb7AKkDMh70spnFD4OratrHFB529oTYyaPONcr2nFshI8y65e2KClv4t54ww0
         fFDfkcI3daK1Ce0Xs7cSVsEkFkATmSBXuCEZT5rm5gse/+w6wWXGkUXHCjEF5pN8uayC
         wYK/dNpfQTKjf84PaRY3TRnKjheJeTlFUde8V87wlOf9yOX07fD/3xnv4qGQFFXhth5V
         e/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=ASAFrRhfZJAuuXnQhdECK4EYYJ/yx+VALPvwUOZmAng=;
        b=XVYXnFdOPP0IjlspKBoDlKUlldq1Cwt9imjqqDhPW+xyNonIUYCSXfPZHlurQG9xA0
         R0Qq37o16xRbCYQLy49sb2j/IlOCPfdbinQ3Eyz4gLjjMF9CBzeiwFsfTBGkFDnv2r+e
         UcWZ/WGDtPQOXi5EQAlb9N8MGTVwLYMVcinf80Vx4gwq+8ZixO5ct1FgC6v1Tla1d7ag
         +RaEV2HgqFyd+uQUy498RRSVP5+ZV9SL6BHnjXH86uIm02XhfUTTbszODlZnAnn8ECe5
         5HVosE6U39La0gJu/uz1ugWLl9VSG1V8Qkjrn2QoeomF751DAsSrmt08Q+n7u2YGAIwZ
         qacw==
X-Gm-Message-State: AOAM533TifcxPHEXUDmp6xXmPV0DCTvB3sBJv3L9Ij3M3Dn4BDfs2XOK
        kfjlqNhCSdCYBx2EwHlgQw==
X-Google-Smtp-Source: ABdhPJxxFnf49bCzAFbvFQy7xseUReJLt8NvGBpmITnbB674TY/XkjhWPo8QtadLHlcNI2L6SbGNBw==
X-Received: by 2002:a4a:8247:: with SMTP id t7mr546769oog.53.1620250581982;
        Wed, 05 May 2021 14:36:21 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id d19sm127738oop.26.2021.05.05.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:36:21 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8197:ac24:85b7:5284])
        by serve.minyard.net (Postfix) with ESMTPSA id 8BBDC1801D9;
        Wed,  5 May 2021 21:36:20 +0000 (UTC)
Date:   Wed, 5 May 2021 16:36:19 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Ryan O'Leary <ryanoleary@google.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ipmi/watchdog: Add WDIOC_GETTIMELEFT ioctl
Message-ID: <20210505213619.GS18645@minyard.net>
Reply-To: minyard@acm.org
References: <20210317001036.1097763-1-ryanoleary@google.com>
 <CAKVu-U=Om6CQF7DVkzp487=R_a77Qbi_grKQ7J-HPVZ_QR7DfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKVu-U=Om6CQF7DVkzp487=R_a77Qbi_grKQ7J-HPVZ_QR7DfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 01:59:49PM -0700, Ryan O'Leary wrote:
> Hi, please let me know if there's anything missing for review.

Only my negligence.

Unfortunately I can't add anything to my next tree at the moment, I have
to wait until the merge window closes.

Anyway, on the patch, if you look at the definition of msg_wait, it
says:

/*
 * We use a mutex to make sure that only one thing can send a set a
 * message at one time.  The mutex is claimed when a message is sent
 * and freed when both the send and receive messages are free.
 */

So if you use msg_wait, you need to grab that mutex, or bad things can
happen.

However, that means that a non-critical operation, grabbing the time
left, can result in blocking a more critical operations, pinging the
watchdog.  So it would be better if you could use another set of
messages for doing this.

-corey

> 
> On Tue, Mar 16, 2021 at 5:11 PM Ryan O'Leary <ryanoleary@google.com> wrote:
> 
> > This is the same ioctl the rest of the watchdogs support. GETTIMELEFT
> > returns the number of seconds in the countdown -- useful for testing
> > whether the watchdog is functioning.
> >
> > Signed-off-by: Ryan O'Leary <ryanoleary@google.com>
> > ---
> >  drivers/char/ipmi/ipmi_watchdog.c | 75 +++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/drivers/char/ipmi/ipmi_watchdog.c
> > b/drivers/char/ipmi/ipmi_watchdog.c
> > index 32c334e34d55..f253c8667395 100644
> > --- a/drivers/char/ipmi/ipmi_watchdog.c
> > +++ b/drivers/char/ipmi/ipmi_watchdog.c
> > @@ -456,6 +456,71 @@ static int ipmi_set_timeout(int do_heartbeat)
> >         return rv;
> >  }
> >
> > +static unsigned int __ipmi_get_timeout(struct ipmi_smi_msg  *smi_msg,
> > +                                      struct ipmi_recv_msg *recv_msg,
> > +                                      int                  *countdown)
> > +{
> > +       struct kernel_ipmi_msg            msg;
> > +       int                               rv = 0;
> > +       struct ipmi_system_interface_addr addr;
> > +
> > +
> > +       addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
> > +       addr.channel = IPMI_BMC_CHANNEL;
> > +       addr.lun = 0;
> > +
> > +       msg.netfn = 0x06;
> > +       msg.cmd = IPMI_WDOG_GET_TIMER;
> > +       msg.data = NULL;
> > +       msg.data_len = 0;
> > +       rv = ipmi_request_supply_msgs(watchdog_user,
> > +                                     (struct ipmi_addr *) &addr,
> > +                                     0,
> > +                                     &msg,
> > +                                     NULL,
> > +                                     smi_msg,
> > +                                     recv_msg,
> > +                                     1);
> > +       if (rv) {
> > +               pr_warn("get timeout error: %d\n", rv);
> > +               return rv;
> > +       }
> > +
> > +       wait_for_completion(&msg_wait);
> > +
> > +       if (recv_msg->msg.data_len < 9) {
> > +               pr_warn("get timeout response size: %d (expected 9)\n",
> > +                       recv_msg->msg.data_len);
> > +               return -EIO;
> > +       }
> > +
> > +       if (recv_msg->msg.data[0] != 0)  {
> > +               pr_warn("get timeout completion code error: %d\n",
> > +                       recv_msg->msg.data[0]);
> > +               return -EIO;
> > +       }
> > +
> > +       *countdown = WDOG_GET_TIMEOUT(recv_msg->msg.data[7],
> > recv_msg->msg.data[8]);
> > +
> > +       return rv;
> > +}
> > +
> > +static int _ipmi_get_timeout(int *countdown)
> > +{
> > +       int rv;
> > +
> > +       if (!watchdog_user)
> > +               return -ENODEV;
> > +
> > +       atomic_set(&msg_tofree, 2);
> > +
> > +       rv = __ipmi_get_timeout(&smi_msg,
> > +                               &recv_msg,
> > +                               countdown);
> > +
> > +       return rv;
> > +}
> > +
> >  static atomic_t panic_done_count = ATOMIC_INIT(0);
> >
> >  static void panic_smi_free(struct ipmi_smi_msg *msg)
> > @@ -729,6 +794,16 @@ static int ipmi_ioctl(struct file *file,
> >                         return -EFAULT;
> >                 return 0;
> >
> > +       case WDIOC_GETTIMELEFT:
> > +               val = 0;
> > +               i = _ipmi_get_timeout(&val);
> > +               if (i)
> > +                       return i;
> > +               i = copy_to_user(argp, &val, sizeof(val));
> > +               if (i)
> > +                       return -EFAULT;
> > +               return 0;
> > +
> >         default:
> >                 return -ENOIOCTLCMD;
> >         }
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >
> >
