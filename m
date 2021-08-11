Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E549F3E8944
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHKEZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhHKEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:25:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44090C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:25:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t128so2755672oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M1sSmgNNoQtvHtZ8PDHG8m3seC8ac1MZGKZ0FeNvlRE=;
        b=QjfTC2HgE2XYDjQKSruFloDLhFtwBgKdO4NJ6MdiAKvtLwie8egxASVNDwDSfzVyv2
         q6mWjvHWSb7ckfpuJSiEw/heccYf1aZLWU/1Tbhqg3QhOcadFbV2J9g1hvE1reVygIPr
         LS0N9RRDRp4FTw6qpgYlkcjrAw2qPUl+pAUZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M1sSmgNNoQtvHtZ8PDHG8m3seC8ac1MZGKZ0FeNvlRE=;
        b=Fzrup4bkZO+znLuAg84QXssxxJBrcukqwAUxn6BQVCSmvl5K0YU+JKaCREgQkQWwlf
         M+Ckr5MtXyKNJP4FxNaF/mDTtAaiZZJdy///lr+TZfKPG1VGy8vlYkofRoxCZcgrr2YZ
         wmfVBpAhyxx2Dm4C2QgeZVeBqlW/LiNl0zSum2C78FLNgjqbZkxSjJc7H3Dyp7vdetMJ
         eT6qVpJD2wVhQlnZM9DJEylhy1e1XgPpalbanu63wv9Cjsigqwg+BtRE3nvpJLYDELE5
         tWojlzo+tze87TGSBCppSbUaTs+hUb4icZJnqt5IWqnwTTvyVzOqrKvxBGuvcMrBwxIO
         6ZEA==
X-Gm-Message-State: AOAM533/TJowhLAzpTGRkihOQCBhMDvwNCCNCbSJdzWzaPUgysQAJhpJ
        8xGeM54qHZ3KBZBiOzWaDmAWUj7UyrAe33ZUVO80kA==
X-Google-Smtp-Source: ABdhPJzObOIuMfn0reOOJWy5m+iJuxp3aHw0B9qKARNxTS22IDkTolDzUwIP41OajjreV0Rx6cLTjTp9cAj7k2M+Dkg=
X-Received: by 2002:a54:468d:: with SMTP id k13mr6077146oic.125.1628655901625;
 Tue, 10 Aug 2021 21:25:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 21:25:01 -0700
MIME-Version: 1.0
In-Reply-To: <YRMHjmEG3l4SolTi@builder.lan>
References: <1628180254-758-1-git-send-email-deesin@codeaurora.org>
 <CAE-0n5203g4CkF5WP1fQYU57fntXbdyVBsMsTKU_xPkgvbt+7Q@mail.gmail.com>
 <bf2b00c5-0826-00d2-ca95-b4ae6a030211@codeaurora.org> <CAE-0n53ojhs+RMpsYtVjsrYbb_PRdkJOvxFhiTtJPMUDuoP_eA@mail.gmail.com>
 <8009f5a1458468dbf0b7b20dd166911c@codeaurora.org> <CAE-0n53TCo1UTVi3e18N5hF3+Y_bLiqgH1o5PEua7F9-bog_gQ@mail.gmail.com>
 <YRMHjmEG3l4SolTi@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 21:25:01 -0700
Message-ID: <CAE-0n51+t6ATCcDgfKeMyh0f0p0=otnUmBjChViX-r3qJYfhZg@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-08-10 16:11:10)
> On Tue 10 Aug 14:18 CDT 2021, Stephen Boyd wrote:
>
> > Quoting Sibi Sankar (2021-08-10 10:24:32)
> > > On 2021-08-09 23:28, Stephen Boyd wrote:
> > > > Quoting Deepak Kumar Singh (2021-08-09 04:05:08)
> > > >>
> > > >> On 8/6/2021 1:10 AM, Stephen Boyd wrote:
> > > >> > Quoting Deepak Kumar Singh (2021-08-05 09:17:33)
> > > >> >> Some use cases require SMP2P interrupts to wake up the host
> > > >> >> from suspend.
> > > >> > Please elaborate on this point so we understand what sort of scenarios
> > > >> > want to wakeup from suspend.
> > > >>
> > > >> Once such scenario is where WiFi/modem crashes and notifies crash to
> > > >> local host through smp2p
> > > >>
> > > >> if local host is in suspend it should wake up to handle the crash and
> > > >> reboot the WiFi/modem.
> > > >
> > > > Does anything go wrong if the firmware crashes during suspend and the
> > > > local host doesn't handle it until it wakes for some other reason? I'd
> > > > like to understand if the crash handling can be delayed/combined with
> > > > another wakeup.
> > >
> > > If the modem firmware crashes
> > > during suspend, the system comes
> > > out of xo-shutdown and AFAIK stays
> > > there until we handle the interrupt.
> > >
> >
> > So you're saying we waste power if we don't wakeup the AP and leave the
> > SoC in a shallow low power state? That would be good to have indicated
> > in the code via a comment and in the commit text so we know that we want
> > to handle the wakeup by default.
>
> Sounds like in a system without autosleep (or userspace equivalent) it
> would be desirable to leave the SoC in this lower state than to wake up
> the system handle the crash and then just idle?
>
> But leaving the system in this state will result in you missing your
> important phone calls...
>

Yes I think we should just add a comment to the code and commit text and
move on.
