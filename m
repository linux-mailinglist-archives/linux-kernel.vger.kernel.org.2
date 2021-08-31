Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F03FC0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhHaCyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHaCyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:54:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:53:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y34so35387369lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SeYApWq5p7n4wZLvEDL4MvNDOHrzTG68S/LXRGbX0D0=;
        b=I4brZGJK2h3tDxuXff8kChntsAY6fQSGPSPcDRYXV2LwlXnM2EFwqT1WPP1+pNYm/s
         r7O5SisCVPWNhWxW4EWA85MnjworX87qN0gCPa5GF800mhiCzJ2HL46wPnSvA50iktnp
         31M6WvF6NUARGBkqpEF+CrarzfoZqaaMn/sqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SeYApWq5p7n4wZLvEDL4MvNDOHrzTG68S/LXRGbX0D0=;
        b=adRPBIFpkotXuMAtuPitFP9Fhk+IJHkom3WVvkKojTfOWhZhmm8FjA8oBWOIp+eF84
         NqsJybw8v9pPosQE/Y7OBAu96zVFV06dIQb3HWu7h7Eno6w0kFOz+WN37mG1wtEsa+gL
         pnU70ffkCyhucrv3ZL6ms/RT3WAMmCGGzW+R4i3DRyla3gCQqyjKBCMMq0DAvAPV+sP3
         OSoaGTyyPy9D+Y6g/QjR6T+eHDBJQqUHkUjT3taz4iszpI26Vmx0ZQuW68mdEivTM63g
         aNxw3WBJJs3SNh+TnwwswDYJuhPdiAFtZAImKKdYaPrGNYOSguZHk49gTuapyTOZaMaD
         Cb0A==
X-Gm-Message-State: AOAM530k0ZGXjOExR3+tTXinfG2aUAYjiudHROacziDZ5rCjDxF2j0pc
        20eIYAZ8hpYze1BEIBSYWc+FqQgMaa/Y40txN+4=
X-Google-Smtp-Source: ABdhPJyxhFBVYUxrfx9IQ/rSASpp+6IUe/4Sd0jo3Bog9WsNaF1o+ZIMWxP/n76cKkhYu1fROEz+JA==
X-Received: by 2002:a19:6742:: with SMTP id e2mr19929168lfj.507.1630378427528;
        Mon, 30 Aug 2021 19:53:47 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l3sm1133634lfk.245.2021.08.30.19.53.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 19:53:46 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w4so29211161ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:53:46 -0700 (PDT)
X-Received: by 2002:a05:651c:1144:: with SMTP id h4mr22432285ljo.48.1630378426484;
 Mon, 30 Aug 2021 19:53:46 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 19:53:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
Message-ID: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bugzilla for this, but let's just move it to reguilar email,
unless some of you want to track it that way.

The bugzilla entry says

  "When reboot=EF=BC=8C the capslock key of thinkpad x1 starts blinking"

which sounds like there's an oops that just isn't showing, quite
possibly because the console has already been shut down.

I didn't test this out, and would sincerely hope that somebody else is
willing to follow up on it since I'm in the busiest part of the merge
window.

           Linus

On Mon, Aug 30, 2021 at 7:19 PM <bugzilla-daemon@bugzilla.kernel.org> wrote=
:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214201
