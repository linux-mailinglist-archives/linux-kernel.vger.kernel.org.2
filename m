Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07076447529
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhKGTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhKGTLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:11:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03ABC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 11:08:21 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t11so25250037ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 11:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEYuptCy/u7zd4SM33EXC2GTO9b/KGbJ6EnW1ChbNf8=;
        b=gsc/XJ2/4Q6xX5CZAzPp01tuxW9d4wUcDBof9eCKPmkbCIm/nbGQy0jw3LGI6Aon0m
         TDFaZ6iyWYETIN1qNEfgHJ82d3lKTDQmjblbzvd0gb8DJMYnWWp+mY3lHR4eFZh3gxeO
         TvRyIJMqvXpgtu5iRVGz93QMOKNdWpwz/hBLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEYuptCy/u7zd4SM33EXC2GTO9b/KGbJ6EnW1ChbNf8=;
        b=rnYwaXH/hbTrmbt5Y1hEzHuayh3MWmziyobpmy1wdzi/ZoydCiRqNnoa5j7I4YsLVD
         3pqkJmw/RBM1+xbRWYS0Gc2xCpTowKsfV47Kq1qdz99U+nIWMhjzhqHwMiPToFxgmU4b
         V1Gt7NODvAuC740qq3nKSPgslvTtm8e0RXCr6tjywp7bGpLUGsiclnopdRnnhN2J33qm
         n5wr1U1MzZpM9LUKUcM1LSsmGFOCweZn92rpmObA7Qk+x1NKyy80fpGrgHRmjKoaio0U
         l3+QK6wqNOMGq7CdNJ62T9wNti+3V+tn9XUtcVxebl3CfycOR1+n0F0hnrRqeLW6IPSW
         bMWQ==
X-Gm-Message-State: AOAM532ubm6YfDw18hwTI25ah1IEre+0uHAIO2+FOjIcBZo+Hed7uHhm
        ZfwsMsua6AKtRs5ZCHOgqKE6Jj/tYwYI2r6LDVY=
X-Google-Smtp-Source: ABdhPJwxAOs1yzp9pHEYNA270Rvf7TMA9N+waLsERHfX+0QULVZxnRMMrG85SQbGTejsF1luoovxKA==
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr21807934ljc.210.1636312099775;
        Sun, 07 Nov 2021 11:08:19 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y1sm1547454lfd.204.2021.11.07.11.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 11:08:19 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v15so18127899ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 11:08:18 -0800 (PST)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr49805043ljp.68.1636312098628;
 Sun, 07 Nov 2021 11:08:18 -0800 (PST)
MIME-Version: 1.0
References: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
In-Reply-To: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Nov 2021 11:08:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
Message-ID: <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.16-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> As requested by Jessica, I'm stepping in to help with modules
> maintenance. This is my my first pull request, so if there are any
> issues with it please let me know so I can fix things for the next
> time around to make it even smoother for you.

Well, I want to see what I'm getting.

That's what "git request-pull" is all about - it does most of the
formatting particularly if you have a tag with the explanations
already like you seem to have.

That very much includes a diffstat and a shortlog, so that I see that
"yes, what I got is actually what you intended for me to get" (and so
that I can do a first quick scan of "this is what's coming" before I
even do the pull - sometimes I use that to judge whether I should do
the pull now,. or leave it for later when I have more time to go
through something).

                 Linus
