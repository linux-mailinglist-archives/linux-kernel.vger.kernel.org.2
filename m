Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431433BA60B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhGBWto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhGBWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:49:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35043C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 15:47:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t17so20890127lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i96gpHGmTqGyzL1pRnwYPnBFinTz4+ocAC93WptRIao=;
        b=hp1aHE8ygjAGHlmTsQeB3xMJAGF+yLnZeuFihIhiI5Bc0Bb1qlcnAU2lE6/h8MXc4Z
         Z+9940FafwWiyXs2NhVd9WoxXmtmwvH4iCtbYSH9fV5b5cfh27i3NRTYi+e+wUuHVdLV
         vJsVZLg1nx9Z20Qatfa5yOWxl41UD9//VJcXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i96gpHGmTqGyzL1pRnwYPnBFinTz4+ocAC93WptRIao=;
        b=dQae20+Yj/nESAuCHT/7v/hsfjz2nLlt5EKPkPyn1GCIbK1jHp2YZ+MTmnyAlFNkcC
         GngPjaibnB1Fs0P0VwxMn4BDLaK/jtpmdddSqruJDiOgCZcsJBPOnPmuXsrt3o2qXm/B
         3/3GE9igL1UsuBMzIaRVf8L6wnAYx7Zio81YwZYta54jQ+FMRng1X+pOx/V+h05saIjK
         UgJg/+P4KC2EOOtg50BtOHuTpE/hK/SaHJ8DLG8Cvbfjxj+KJTbn2SsUs/QHaSdU+c+b
         CwCYX3mWnYW5PFHPlFimKusyoFwYrBxNMzks2udGX0XEB/KmK4roQYtwBEDIlJ6COpeI
         IRTw==
X-Gm-Message-State: AOAM5316wTPL2YvtbbqVoLxesMIYKC5ALnpRhg+crY9b/436spP19A9X
        FhS4AGH0WmSbA+qY0GtjTicBb8aOxoI78xg5P9Y=
X-Google-Smtp-Source: ABdhPJx2HqYbVJCkg4SLGT/I2tPlERqoFLUypAY4BMu/wCYxcPUfUxIdJnOlKlr7XbJlmeI2KvPpcQ==
X-Received: by 2002:a05:6512:23a9:: with SMTP id c41mr1314844lfv.171.1625266022428;
        Fri, 02 Jul 2021 15:47:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s16sm494677lji.131.2021.07.02.15.47.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 15:47:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id p24so15437928ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 15:47:01 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr1260817ljn.507.1625266021672;
 Fri, 02 Jul 2021 15:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <e118d4b2fb924156f791564483336e7125276c47.camel@HansenPartnership.com>
In-Reply-To: <e118d4b2fb924156f791564483336e7125276c47.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 15:46:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiErhCUj8tGjcZS9mA7Efnv4JO1aMg06GfSqL8nacG4xA@mail.gmail.com>
Message-ID: <CAHk-=wiErhCUj8tGjcZS9mA7Efnv4JO1aMg06GfSqL8nacG4xA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.13+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:11 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This series consists of the usual driver updates (ufs, ibmvfc,
> megaraid_sas, lpfc, elx, mpi3mr, qedi, iscsi, storvsc, mpt3sas) with
> elx and mpi3mr being new drivers.  The major core change is a rework to
> drop the status byte handling macros and the old bit shifted
> definitions and the rest of the updates are minor fixes.

Grr. I noticed this too late.

Why do we have that

        default y

for "config FC_APPID".

That makes absolutely zero sense to me. Not only don't we do "default
y" for new features _anyway_, but something like this is certainly
much too specialized to warrant it.

To make matters worse, it actually asks for this stupid thing *TWICE*.
Even if you say no the first time, it will then later on ask about
BLK_CGROUP_FC_APPID, and if you make the mistake to say 'y' on that
second try to push this feature, that will then do a "select FC_APPID"
to turn it on.

So honestly, it feels like

 (a) the "default y" is just completely wrong in all ways

 (b) this "config FC_APPID" shouldn't be a question AT ALL

IOW, it should likely purely be enabled by that 'select' for people
who decide they want BLK_CGROUP_FC_APPID (which properly defaults to
'n').

Pls advise. Or just send me a patch to fix it. Because the current
situation is most definitely not ok.

            Linus
