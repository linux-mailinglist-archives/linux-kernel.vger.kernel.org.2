Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFD457708
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhKSTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhKSTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:32:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE29C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:29:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so46956593edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcWMNc6Vpg51MXv4sgBrEJhLBETGzdtE97VuddJjcLc=;
        b=FoqppIpL9PH09xZ/j3XRcFrAQH3P0pqGLDIX7HSq0Xb+Hc2SihFt3aREYLVVwJb8hC
         mEgrdLC0kruoIuxf4cZZ8bCv46sqpNNq5K5EHHZjXw229OrWvjZq3zdA8xjhX9kWpgEy
         FbvD/p21wbE87Ilb/jZhIM5LtilfTq122kZ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcWMNc6Vpg51MXv4sgBrEJhLBETGzdtE97VuddJjcLc=;
        b=cfzd0R6IQMAPHgJN2IV/llKvLn9UlbCW/db4RBBM7bteAPl+S1rfrvA/CHb8fSQx6V
         KWKBnQ6f6c2xySXwQRlpCYyPEDQeP47iBmAuYe5rEcu25MtZ3c7VAgyPg1WXv0RX66WV
         dCf7u5T68YnuGuSjIATKI558FVcJmoSWOQqsIL0JOOlksgsoUG8I0WXXQSXrIZZN52mr
         J6Xa4/gXui9anEtZ0W3zAhvvSrPm9okzzeWpjCSUdSMqyp0YRc87isu4l8jRfgMFwgMf
         m9KId91ZJvdCDd0sVK8YgjB21Bj0BjoWdwVX2nWfj8iSajLlKGTzVDdvurV1n5WeG2iV
         Dt1w==
X-Gm-Message-State: AOAM532HLWrF87pdjB3dBJjbKkYZaPvxZimqOCJ5nwGPXxaXCxYUmMO7
        uE9ywnJFbePBHqV5viFv2eBFtRl5pZGynDpq
X-Google-Smtp-Source: ABdhPJy+X47qwEwv/tFR3RKSX9j7q1RdBJD1EwAN5MpzoXi5PNlifgQd5+UME137BRcwldOXZbsKMg==
X-Received: by 2002:aa7:c04a:: with SMTP id k10mr27921051edo.308.1637350180974;
        Fri, 19 Nov 2021 11:29:40 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id j4sm331207edk.64.2021.11.19.11.29.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 11:29:40 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id r8so19826003wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:29:40 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr10758365wrj.325.1637350180007;
 Fri, 19 Nov 2021 11:29:40 -0800 (PST)
MIME-Version: 1.0
References: <0a508ff31bbfa9cd73c24713c54a29ac459e3254.camel@HansenPartnership.com>
In-Reply-To: <0a508ff31bbfa9cd73c24713c54a29ac459e3254.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Nov 2021 11:29:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiTXOy3EJ4Eb++umuCgiDufJxrNZ9Z17_NhdORKZGbSA@mail.gmail.com>
Message-ID: <CAHk-=wjiTXOy3EJ4Eb++umuCgiDufJxrNZ9Z17_NhdORKZGbSA@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc1
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:20 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Six fixes, five in drivers (ufs, qla2xxx, iscsi) and one core change to
> fix a regression in user space device state setting, which is used by
> the iscsi daemons to effect device recovery.

Language nit.

One of the few correct uses of "to effect" - but perhaps best avoided
just because even native speakers get it wrong. And we have a lot of
non-native speakers too.

It might have been clearer to just say "to start device recovery" or
perhaps just "as part of device recovery". Just to avoid confusion
with "affect". Which it obviously _also_ does.

I kept your wording, but this is just a note that maybe commit
messages should strive to generally use fairly basic English language
and try to avoid things that are known to trip people up.

            Linus
