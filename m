Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0646443339
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhKBQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhKBQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:42:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B8C0797B1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:19:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d27so16199127wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CpUJOmzAX/8URtDkwbVdkTj3rb0UDdNphvTprVMTsPc=;
        b=A1vwiunFsjHUdX4UhJsd2VuGwcx8879Ito38Bw5Z+CDChY+JvT6+9VdPKIagndQl68
         Og88/XHn4hWv7jPsWEI8vrmL1C/Hc/2mEQ9VdWVEzqdeb3+ZFzYdkKzk8M76yHKf2DGq
         uwGggZzG2onxTwiykA04zouRFH1h+4GfgWU5TC5C2w6RuDpXckcllrNcKsv8M5Mq6Cyp
         X1nmFXPBJO0zVR0TYc5IJ9txNp7kPo+wePNybRPcMKR8W05pyGzsbaxtBE51gquTAzRf
         uFYRs799Vw3j55o5AyaNmxeBvPuUOyKR4QUA0Y04elwgeoKZTwVuBp5mU67wB9ifnjqJ
         Lb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpUJOmzAX/8URtDkwbVdkTj3rb0UDdNphvTprVMTsPc=;
        b=lIvdjRcXNOoWunEMAtRPCX1fxok0IrCShmlQYh5MRdd0wpXfhI4kgbS+gcuSmS5EXB
         RznjyVJUGjLRTVJo/WrtJdCPjG9Pu5Uorud6TtA6Fj7y4RvHbbeT/pfdezu8HkIAzHB7
         +EiBpQZaErHBCmjgTyAVkAF419p82eBViqhSGUzpdHQ5UBiyssAuTiv2xpM9zFS8SWU7
         zNxPdPXCx9D2gqLh4lgSTcTRLsTvcAKIwkPzXDEVzvv7FSEpW6YIkA/wKuiuhwwxTjM0
         VHqIAnBslJHAxfmyWua755NLoCb/jLf7HvV0pApkHvVwMgATnXa0Nw/HUgjisYd/sqkl
         YBFg==
X-Gm-Message-State: AOAM5305ckLvNIjNUC5szsdwI1qYgBSEgOK0E0KwRaw3/TmPG3my4WAq
        yiaFiUYHYO3Y78CU1/BGf1WZ3g==
X-Google-Smtp-Source: ABdhPJw22Mzzh+DNq9uyjKZ8BMu4fdbemenrQaeiEJsRrbU74XvHd0S+P3XM7QQdIkcWoYevFjDbpQ==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr49212985wri.398.1635869976925;
        Tue, 02 Nov 2021 09:19:36 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n184sm1327774wme.2.2021.11.02.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:19:36 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:19:34 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v3] kdb: Adopt scheduler's task classification
Message-ID: <20211102161934.664jrypn5rxaszae@maple.lan>
References: <20211101174344.3220974-1-daniel.thompson@linaro.org>
 <CAD=FV=VVV4n4sDziWRbY517Eb8mRJVxwH+ggxf37FXfYKiTJ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VVV4n4sDziWRbY517Eb8mRJVxwH+ggxf37FXfYKiTJ6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 12:56:13PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 1, 2021 at 10:44 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> > index 1f9f0e47aeda..3368a2d15d73 100644
> > --- a/kernel/debug/kdb/kdb_bt.c
> > +++ b/kernel/debug/kdb/kdb_bt.c
> > @@ -74,7 +74,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
> >   */
> >
> >  static int
> > -kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> > +kdb_bt1(struct task_struct *p, const char *mask, bool btaprompt)
> 
> (Copied from v1 review):
> 
> In the comment above this function there is still a reference to
> "DRSTCZEUIMA". Update that?

/me slaps head

Sorry. This patch really doesn't seem to have been my finest hour.
Really thought I'd got it right at v3 (even threw in extra manual
testing for good measure).

Will fix... immediately.


> > @@ -2271,37 +2271,30 @@ static int kdb_cpu(int argc, const char **argv)
> >  void kdb_ps_suppressed(void)
> >  {
> >         int idle = 0, daemon = 0;
> > -       unsigned long mask_I = kdb_task_state_string("I"),
> > -                     mask_M = kdb_task_state_string("M");
> >         unsigned long cpu;
> >         const struct task_struct *p, *g;
> >         for_each_online_cpu(cpu) {
> >                 p = kdb_curr_task(cpu);
> > -               if (kdb_task_state(p, mask_I))
> > +               if (kdb_task_state(p, "-"))
> >                         ++idle;
> >         }
> >         for_each_process_thread(g, p) {
> > -               if (kdb_task_state(p, mask_M))
> > +               if (kdb_task_state(p, "ims"))
> >                         ++daemon;
> >         }
> >         if (idle || daemon) {
> >                 if (idle)
> > -                       kdb_printf("%d idle process%s (state I)%s\n",
> > +                       kdb_printf("%d idle process%s (state -)%s\n",
> >                                    idle, idle == 1 ? "" : "es",
> >                                    daemon ? " and " : "");
> >                 if (daemon)
> > -                       kdb_printf("%d sleeping system daemon (state M) "
> > +                       kdb_printf("%d sleeping system daemon (state [ism]) "
> 
> super nitty: elsewhere you use "ims", not "ism". Can you be consistent
> and change the above to "ims"?

Ack.


>  @@ -2742,8 +2743,8 @@ static kdbtab_t maintab[] = {
> >         },
> >         {       .name = "bta",
> >                 .func = kdb_bt,
> > -               .usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
> > -               .help = "Backtrace all processes matching state flag",
> > +               .usage = "[<state_chars>|A]",
> > +               .help = "Backtrace all processes matching whose state matches",
> 
> "matching whose state matches" sounds odd. Clean it up and use the
> saved chars to document "A":
> 
> .help = "Backtrace all processes whose state matches (A=all)",

Turns out we don't have enough characters to document A on an 80
character terminal (some of the other help text is too long as well but
I'll put that on the list for later).

Will settle for "Backtrace all processes whose state matches" and leave
it at that.

Will also updates the .usage for ps which doesn't use the <state_chars>.


Daniel.
