Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA913327C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCINwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:52:06 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37344 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCINve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:51:34 -0500
Received: by mail-ot1-f43.google.com with SMTP id 75so9583977otn.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgb10K1Gc0FxDX0vPOK/aEqzZMS/cfwoTVk/6xq/ckw=;
        b=Mm69O3piwA4Xt6VY5WxRmOF1YUoje99kc9mbZSdnyytsFnDzT+Xij7vLfFdiT7GF3B
         Wk31dqbyNR2s0E9+Za/k8qJsmt/WCPqIvaDf7s2oa1szJWmbx/5abpc8roBvHrvzgDYe
         oLJFl1eUhFzlMbkf+HlZzcwGHD7ZZk0TRMXmABaeBZXSetM3MXkNmHlchos8PMnO8Pte
         ExDB5K34DEEv1pZsbm7NeQFMlF4moZHYpkv4xZ6op6XKHJOVfqU4L0uXJ03dSUWahGJv
         FH1Bqk/bGioDea7HyHqYjvjpoXXAXaOdpwntZrJdU+Y36m2mHLonLSeHRx56blQLNf+c
         0eGw==
X-Gm-Message-State: AOAM532M2xtG5N3I9qtMBgq+qpMX0rRe8EInk4X4nINDU7T5SYxDta3G
        RCap7S6uqdJZvvnQCgqfVIwuf1HBOz5wPPphMZw=
X-Google-Smtp-Source: ABdhPJz+ncJa1jfvhNyl9iaS1QiNBtpHXbZPgQ3tTIsfCLXrZxV4+Nz6LZnJKDoNmC6HMuDNgfoOMAd8E3Ot3sXA7io=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr13616155otr.321.1615297894447;
 Tue, 09 Mar 2021 05:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com> <YEdTGsr6CjUirOsn@smile.fi.intel.com>
In-Reply-To: <YEdTGsr6CjUirOsn@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Mar 2021 14:51:22 +0100
Message-ID: <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
Subject: Re: [PATCH 0/2] software node: Two fixes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:51 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> > Hi,
> >
> > The second one only affects 5.12-rc1.
>
> Rafael, Greg, can this be applied for v5.12-rcX?

Do you have a pointer to this?
