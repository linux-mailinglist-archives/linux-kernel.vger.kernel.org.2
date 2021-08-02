Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EB3DDF94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhHBSuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:50:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F5C06175F;
        Mon,  2 Aug 2021 11:49:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y200so21464571iof.1;
        Mon, 02 Aug 2021 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KwPFt5nXWmeiN4/P7xLvVyS/JI/l5lEzYIZjkJflIm4=;
        b=s01K5kEzKYzllT1d+wwQNeLL3I7NUnHrbUmUo9rQw94dlbG7QAgTwpNQ4pQ5IqRXX2
         D2w/TajMbBrA+6Z0fe3m5zSFT9/Yxd+n70rgWSbOsPAzsf7mMAA+6pYDfgfLgLou8SiM
         CLTlM3xxJaaj26iDnCCzNHEe7FWxEfGmifJWwol5cniDLevl2/gsXncFcx7DL7yJE9+E
         FQa27dYs9s4iU58148DKMM+sr/O+H9bl1tyY4Wa+iH3OXm1HwKHTMHOT7dsfJzeSzSmV
         YMfPY6PeE2xGjTRx2aMC56wAI0OqZdrHDbF/vjIzev0SZl3DO+DaYyoLEppEvimTOkqM
         7brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KwPFt5nXWmeiN4/P7xLvVyS/JI/l5lEzYIZjkJflIm4=;
        b=FSU+jYgtYDC2qG8p1e/GuZNYt2Q/WkBVSaVd8SwQ5rb2j+DHgzb1aCUOjCTYHL+BAB
         BOSt7oS95HO/wXyegVrOXzzskP47HQgXStGwOIkYqNgoNLiQSA2O3s4UL0pE6Gv4NPc0
         z6Oe7q6qWT5+OTMIEswEnEiEUhXCIaZMZB6FufKtHCjYBpMgiGBdEDbJk+epi8pgmzAg
         H1U7USbr7pM0ChEtERbY0tSAR5NbFtRtf+qTmQvND5awbZtaPcYa93FHubJAEtgDPaPO
         42WrLmPLWJCcaSt2gskMcpeLabioKrGoSrZy7HmXNv9hg8FqFMjGgs1mv6KC5diCrb21
         YL5g==
X-Gm-Message-State: AOAM530ZWyd2sGZaPVt2ul7r8QW/1SNHB82jrXQe/fDdq9jx7VrBMLhR
        4NA9INTMhnKbHnu5Px2eBH05NvXFjp8sdP2CswI=
X-Google-Smtp-Source: ABdhPJwmZjYXTsSaUqzsza7/ZJFeqnsoYKXOCeUHHesYOaS7iqKTpnbKQD/UOXZGWiIXslJUb1z4jpnlsznmxGhsD7E=
X-Received: by 2002:a02:ca19:: with SMTP id i25mr16098037jak.78.1627930195443;
 Mon, 02 Aug 2021 11:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210730235304.3179882-1-rajatja@google.com> <YQgKIok9DOTgmyvw@lahna>
In-Reply-To: <YQgKIok9DOTgmyvw@lahna>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 2 Aug 2021 11:49:44 -0700
Message-ID: <CAA93t1pR4_-H0pPa0xeVa2b7xv995Q37hGAFNCQ4y2vWyRN23g@mail.gmail.com>
Subject: Re: [PATCH v3] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 8:07 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rajat,
>
> On Fri, Jul 30, 2021 at 04:53:04PM -0700, Rajat Jain wrote:
> > For security, we would like to monitor and track when the thunderbolt
> > devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> > "authorized" attribute changes). Currently the userspace gets a udev
> > change notification when there is a change, but the state may have
> > changed (again) by the time we look at the authorized attribute in
> > sysfs. So an authorization event may go unnoticed. Thus make it easier
> > by informing the actual change (new value of authorized attribute) in
> > the udev change notification.
> >
> > The change is included as a key value "authorized=<val>" where <val>
> > is the new value of sysfs attribute "authorized", and is described at
> > Documentation/ABI/testing/sysfs-bus-thunderbolt under
> > /sys/bus/thunderbolt/devices/.../authorized
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> I did some tiny changes to the title, commit message and the comment and
> applied to thunderbolt.git/next, thanks!

Thank you!

Rajat
