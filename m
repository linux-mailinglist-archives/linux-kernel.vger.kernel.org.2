Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA313C72D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhGMPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhGMPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:15:35 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4371C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:12:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id e14so21897338qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtTNpHN7mGyhuaFK5jDPQ4RVI7P3MwfCQJyWmjN3XOY=;
        b=Dhldyh9lRcWr/Z9wVz5ZZvSNQ4Z1CNpNjGRmdJ17LFoiKWRtJqM+Upck/ou/cIs3Cb
         E/7x/Nx8fby+55gA19Dw/ni+wC01SZqeQgiQPgIpTNbP3NUIQVHiWkrnLkCJCrcJf0FC
         BpYUy/zU6NBvN29kB9eig0ucRMjCqvjHP49kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtTNpHN7mGyhuaFK5jDPQ4RVI7P3MwfCQJyWmjN3XOY=;
        b=QbVXySVlU2oPejgqyCcxDbvKHOWplzs6qfaZilSzXREeJGRvzIY6r17ZxOZ1g1Vrnp
         GgP3G5PN7h5Y/yj/RRPcFrhzjMFkWIFkvJZjvbe5O5zLVIYB4NLKGF0DB10gUIdkVufr
         8IChSGhanczkG91TQsfmOqhGKn1RyszjCf9eyyT6F+jjMwrB40HwrK+ncnA0wVbZpY/A
         Wt0jF0TwtUV4NrSrC9A0QpbIYWsDb/HDK+QBPImEWLiPfhD7QpaK8Dbuai8PxdDeHAJn
         /QzcT9uM7o4ZvvbecpuUKj727PWbelsMNpDAmTOqWssfg9IL2zMinbnXTCrd6J8neiHZ
         nL2A==
X-Gm-Message-State: AOAM532+DiNoEZmkCZsPut/ZBQPA0ss8uldJzRp4eVq0vEBzkYAHcGWs
        e1otOg4hFWdwWx+Qxhn79+GxGO/Bf8ExOg==
X-Google-Smtp-Source: ABdhPJysvgjq+/YXII5RVusdqY3HdkpGaim5lfnF5KJRMVrEr4y7TbiJzt40kABn7mJivb7bE5kSpQ==
X-Received: by 2002:a37:e10c:: with SMTP id c12mr4663755qkm.499.1626189163479;
        Tue, 13 Jul 2021 08:12:43 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id r19sm6908019qtw.59.2021.07.13.08.12.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 08:12:42 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id b13so35335293ybk.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:12:42 -0700 (PDT)
X-Received: by 2002:a25:cc52:: with SMTP id l79mr6350967ybf.476.1626189162123;
 Tue, 13 Jul 2021 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122447.3880803-1-sumit.garg@linaro.org>
 <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
 <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
 <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com> <20210713151032.hvsbufswijxt6uxk@maple.lan>
In-Reply-To: <20210713151032.hvsbufswijxt6uxk@maple.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jul 2021 08:12:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb_utQLP+U9Nv4=PUTdY49acRG03_Pxk31f4dR3673SQ@mail.gmail.com>
Message-ID: <CAD=FV=Wb_utQLP+U9Nv4=PUTdY49acRG03_Pxk31f4dR3673SQ@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 13, 2021 at 8:10 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Jul 13, 2021 at 06:45:52AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jul 13, 2021 at 4:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > > >  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > > >  {
> > > > >         int ret = 0;
> > > > >         unsigned long symbolsize = 0;
> > > > >         unsigned long offset = 0;
> > > > > -#define knt1_size 128          /* must be >= kallsyms table size */
> > > > > -       char *knt1 = NULL;
> > > > > +       static char namebuf[KSYM_NAME_LEN];
> > > >
> > > > I guess this also ends up fixing a bug too, right? My greps show that
> > > > "KSYM_NAME_LEN" is 512
> > >
> > > I can see "KSYM_NAME_LEN" defined as 128 here [1]. Are you looking at
> > > any other header file?
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kallsyms.h#n18
> >
> > Ah ha, it's recent! See commit f2f6175186f4 ("kallsyms: increase
> > maximum kernel symbol length to 512")
>
> Ineed. So recent that I think it hasn't been merged to mainline yet!
>
> This patch is part of the rust patch set. IIUC it is in linux-next for
> wider testing but I'd be surprised if it gets merged to mainline anytime
> soon (and even more amazed if it is merged without being rebased and
> given a new hash value ;-) ).

Ah, good point. Yeah, I should have mentioned that I was looking at
linuxnext. I guess maybe the right compromise is just to mention that
we'll be more robust in case that other #define changes. ;-)

-Doug
