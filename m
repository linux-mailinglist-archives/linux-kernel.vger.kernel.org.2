Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D64003F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350254AbhICRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbhICRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:12:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64596C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:11:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c206so11248858ybb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSSitICnTkYgvRAGn0Mr0hVlFHSRUgJ2BvlCPOUBJV0=;
        b=IWtyT/TCv8r/pfqYvN3L/qmmMftnIpFlaT3A0Hmysh+l7FaXuWAOdhHaciQ00gN0aM
         sGEj6thBxRzs7oKWs8dJBELKfxNFA/agOBSsoui8ttE+a2PmEhRyCtCIEQgW9WMt0YlR
         Vbd0t/7KfaC0vhKbAqlFaAUkJrVItYD+mXx2lm31+helUSEq5gp+EoRyLMi+Pves4Y94
         Dg7zwZ20NBcUH6UtK3hS8CAnWeI4Kfo34tZdhgOdWSrBJeyn9L/65q+9R/52u2zsgh7S
         6y5Mj7KDBcbLhy2zNihd0kbcQK6b3Wp/0IVAN3rnirdpBNELJEjqJWxhhqQue2HdW1z9
         T+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSSitICnTkYgvRAGn0Mr0hVlFHSRUgJ2BvlCPOUBJV0=;
        b=kpBt1qcOSEgZ37OUfIgoW6eZHUCzgmRJntpcdkte3Jh8+axw5VF0ep+wJJhsBrMrWT
         MwBI3a3fgNcIh4RmPGb10Oq2WyhLBkmMvHP4qrnmn584hkY1qOFzCn0bRK9o8RiphwwD
         5P8s7OB1kp9006b7NWVas9Apfr9ijsmSOOolgdjnkwrMDDL0pgNU81zuUch/sIkswAk4
         Bm/IAhlMrJdOTtPqxmT8pVZffYt4jRlfADxYLec3p0YP47dvADUSaZDcTLj/UTVmqCtg
         BOW5pmhoZXgvJqzoaP/krJQmmyX3AOaSuq1ltt84iz11GqZnde8j+w65LOHC0DJHTw4v
         DFbA==
X-Gm-Message-State: AOAM530uhhY/eSUn9u4KCgHMmN9zm1igq0j1THdF67+oGZMCwruROQsF
        XBNe7OU18NDjNTb3/ImINKALb//7DVXb0yMjq0ltcw==
X-Google-Smtp-Source: ABdhPJzGmV99Yficvf8951wooAlG/eHdCljFJIXkrb3PHMfOKZSAkOMme80hM9h98sQXZ4G2XeFE1JOhBXqK5VJEFzk=
X-Received: by 2002:a25:b94:: with SMTP id 142mr7122ybl.508.1630689062450;
 Fri, 03 Sep 2021 10:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-3-saravanak@google.com> <CAPDyKFr7z6W3ghoAmTVKHaM8saycbhYyBcDXaTuT_Daz+djx2A@mail.gmail.com>
In-Reply-To: <CAPDyKFr7z6W3ghoAmTVKHaM8saycbhYyBcDXaTuT_Daz+djx2A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Sep 2021 10:10:26 -0700
Message-ID: <CAGETcx_SAy02LA_zkn1KhGEYq+fhPrWaLONMmneoy88YSKw1QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: bus: simple-pm-bus: Add support for
 probing simple bus only devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 2:15 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> >
> > The OF platform code sets up simple bus only devices (i.e. devices that
> > won't match with any other driver) to get probed by the simple-pm-bus to
> > keep fw_devlink from blocking probe() or sync_state() [1] callbacks of
> > other devices. There's no need to populate the child devices since the
> > OF platform code would do that anyway, so return early for these simple
> > bus only devices.
>
> This looks like a neat solution to our problem. Although, a few comments below.
>
> >
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/bus/simple-pm-bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> > index 01a3d0cd08ed..91d52021b7f9 100644
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -19,6 +19,13 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
> >         const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
> >         struct device_node *np = pdev->dev.of_node;
> >
> > +       /*
> > +        * These are transparent bus devices (not simple-pm-bus matches) that
> > +        * get populated automatically.  So, don't need to do anything more.
> > +        */
> > +       if (pdev->driver_override)
> > +               return 0;
>
> You need the same kind of check in simple_pm_bus_remove(), to avoid
> pm_runtime_disable(). At least for consistency.

Ack.

>
> > +
> >         dev_dbg(&pdev->dev, "%s\n", __func__);
> >
> >         pm_runtime_enable(&pdev->dev);
> > --
> > 2.33.0.153.gba50c8fa24-goog
> >
>
> It also looks like we should flip the order of the patches in the
> series, to keep things bisectable.

Sorry I didn't get this. I'm not causing any compilation issues. Why
does this matter for bisecting?

-Saravana
