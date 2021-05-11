Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF38A379C36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhEKBoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhEKBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:44:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8ADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:43:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g14so20959336edy.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEU2XINPvxpif27cloGyU3+maD+1yosQV8skN3ngj+c=;
        b=qebFkT5WoXwc0JDSy73J/CT/GiXF0CG4nWFbLQfsalTDTv1rnAW3qQ9TfEHxAxyLpp
         iRs9hHawnTzm0KY9y908SSWxYAMQoDpMi0sxUsrWcRdBWzv6JXLV5osZniXxGxi/L3Dq
         entDR12h5kB1EJdGVx6etkzL08KkdcHJhdXH7+nJ3XxhYGu0yahZkhmLOfgMbUo4Ace6
         tvNdxwIBuoAi3EPH6+0eFzwRIEgJgSSuuK2KgfeS44NQjkkzfvYB5vV5ZhlatxBT7OT1
         av9xkMrlj3WyDgThY+3LjLD0Qdoh1mROSz7/evYHa3XtxYX0UTQadY+83mNQPAj5KfJq
         BpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEU2XINPvxpif27cloGyU3+maD+1yosQV8skN3ngj+c=;
        b=EWroFq738+9rAQmoVHOpoQ7jKH43G3q4CH3UdX2EPTCIOWeu6QyS/Orcme2Cce9+ML
         tMJnLeG880riNr2thK/CcjJdebADK+5wITnFXP9A+ME8luYkHs/L4Wy8u1EQc9Jp2HAJ
         VXwPUO9rTs96PabzLbn0r0CTPOoMA9GowJ0dxBUGhZ5Uvyf1nwKdi6f14x7n278rOb1w
         Nysfid+SIVkfj/XGNzeB5bKLvoXU9ISBvptk0K9rMNYVh7x18MyAJfCiDbIwWB7tW18L
         h+nKKdZSUCsoeth0p7YZ1/M7QCI2Rl0RW7UBEe4UgQLv78o2WUpXzIplzwERdz/GO+mx
         4gkw==
X-Gm-Message-State: AOAM53177cSVprKvf8eV/jacsmUKgeFih+Ct3XP2aUdA41NH4p02Skfc
        VxVRhHIRFnXlMDm+ppIUKbCnBTyNC/DGprZ7/jVD
X-Google-Smtp-Source: ABdhPJzlZfrvrng9EKXKYI2ccD1ACNjUAx6WBrA4muVbPpFgoo+d7uP3vIzMNuW/aJocugCvTLH7zJH+jLeg1BmiR0M=
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr33179453edb.196.1620697383831;
 Mon, 10 May 2021 18:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1619339737-4824-1-git-send-email-jrdr.linux@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:42:53 -0400
Message-ID: <CAHC9VhRs8rtCfi6jZVPZTvu0uOG5BzBHCjoeg9AXRXkt_ume7A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Corrected comment to match kernel-doc comment
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 4:35 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Minor documentation update.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
