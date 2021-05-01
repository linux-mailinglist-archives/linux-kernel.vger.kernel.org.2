Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A231370943
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhEAWuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 18:50:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920E7C06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 15:50:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s9so2448576ljj.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyUcLRZ0Rt19UEL/ZLBgHf+f8fvCiwACi2cQWFH2R+4=;
        b=WIQvM5n8kzuO83VPn1XaK4ss2X3KkxUzpwTAcspVwQI3/ZUorcYOqLyFfKnr/9fmxS
         XCr8wo3tGgeIhK1S/ZssUeq3S/LesQ0YbtwC5nlCPPLh3nidZfPMIk8CZUmkHcaGAQ5y
         HZ7KOHdUd0BEvG1AKdeUOnn9e92SM75vQdfgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyUcLRZ0Rt19UEL/ZLBgHf+f8fvCiwACi2cQWFH2R+4=;
        b=PIJ6Wu7vZmtSHmtoxdBd5CYiO3QVYazNMEUGjGaeAfzP4tva/yMjyrZTeya4bXq3aL
         nDM3cS/aW93RwJY9Pr1doih5sv7ZZEjV/nll2iHsH5U2pO+2nPV+xlhC2Z+pWCxE7TG7
         OZLuGLNjvZe7qYRFfNnWFcdg4jrCX8kPRUqPSYKX+6Y5BmVng2YmErlQAT8hoLJ1J1Y0
         cUq/dLt6iebzGgVV2LomCZoPleFLMMK44YOPLX1aKpEeinCD+5+tO8y3sUWLRSV5J+At
         6FaIXrr5rarlEQm0Uy5qpErjJQnlWA8haP+rAp4ZXpTC9EhKjRwUu2nnVpYgfXCxnZBK
         vQDQ==
X-Gm-Message-State: AOAM5302025yfHwFDwUS46P9DOG2oDOM9TnkaBCM81h6jtyyblHS5zXv
        aCwoMMpr1oACMUctKKr6nZ8roIvI4frQBLfH
X-Google-Smtp-Source: ABdhPJznQU1lPbkYJezEYfj9unwrW4CI+TOBWdI82sdvK+1IIActwPT1ml5XsIfQpQdn8btmVTTMFw==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr8179050lji.482.1619909399774;
        Sat, 01 May 2021 15:49:59 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v5sm675650ljc.64.2021.05.01.15.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 15:49:59 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id e12so139225ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 15:49:59 -0700 (PDT)
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr8049801ljg.48.1619909398916;
 Sat, 01 May 2021 15:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
In-Reply-To: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 15:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
Message-ID: <CAHk-=wjBSomE81D=dXN5Z1r_qTLDeKfOzXH4T+mPK6AeSWhW0w@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.13
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 6:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> In addition to loading the kernel module signing key onto the builtin
> keyring, load it onto the IMA keyring as well.

This clashed pretty badly with the other cert changes.

I think the end result looks nice and clean (the cert updates mesh
well with the _intention_ of your code, just not with the
implementation), but you should really double-check that I didn't mess
anything up in the merge and whatever test-case you have for IMA still
works.

I only verified that the kernel module signing key still works for
modules - no IMA test-case.

              Linus
