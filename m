Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E13AEC74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhFUPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:35:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE28C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:32:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so30873970lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhnq76ooUUm7QmAimfwToYt+1c8p8xn5OCuByHp0pz8=;
        b=Uutdd5a3TidMnliyw0hwftDBOxT2npgsoNP3TF+B5iMzp3GbotrSzvLHGt/0ursV8j
         TZnES5qZrHg8zsZZY2D/y4a15FKY62F/tpPtVFMSj9WDGWWLnz/vNgPuyZIKyKjCN5KS
         QXrFCXfMBrOHQoC5n+QL3yzvxSxxJSSVBlxfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhnq76ooUUm7QmAimfwToYt+1c8p8xn5OCuByHp0pz8=;
        b=lAwJLcvyyWns8M7yY5SaOz4kXPfR68crn0eCqtn03rd9YOO+4tikq8CtReQNod6ZhA
         WaQ2r1vhYW7pYpgHn9sa1qtx89HkoEY9aIp8qG9YA4RinI9fCFy74rVO1CNTs4tqkFO8
         0yKmuhsFOkk8m3Zlk1LUU3N2DaA4qFkCLYUsvThZfVdDDQzt/Foi0GotTl83uDQhsQuJ
         IQpDGJFMyE9y01jYXyNAt2RBDMLWVRToMnPaoA3xljx3eXQjBQ5hxVb1NoNibBBf+px/
         Aegt6j2LY+VuzCQWzlijBxWiDHIXSv6qHSFBgxgRV7Hl++FB6lRsk/cmQ3AeajveFbJv
         liXg==
X-Gm-Message-State: AOAM531FcFtmsEXz4yKd7KnRHD6YwVxWmkVAyATUf1LKk+JduRfpmteg
        0+fv4wevrSZS/tAIWnqcy+OltbiEWFZSQDfH
X-Google-Smtp-Source: ABdhPJwxZJgyT26Q1cdPT2YbJA6WqJr4iOWPfdRJiJHreKLawpm9By4o/kJbAH7bTEq1RNBa+LwBxg==
X-Received: by 2002:a05:6512:139f:: with SMTP id p31mr13126065lfa.337.1624289562349;
        Mon, 21 Jun 2021 08:32:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h5sm1121333lfp.193.2021.06.21.08.32.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:32:41 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m21so30875914lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:32:41 -0700 (PDT)
X-Received: by 2002:a05:6512:557:: with SMTP id h23mr9653054lfl.253.1624289561362;
 Mon, 21 Jun 2021 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjj38E8hW+unHZ9EaJrS6x+4Tnz0qffjvLcGf70dXkKnQ@mail.gmail.com>
 <20210621133915.GA2892783@roeck-us.net>
In-Reply-To: <20210621133915.GA2892783@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 08:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjg8oww+Bt5EY8a=5M59sv5pPSPMC-tPT+QrWEAAmDkkQ@mail.gmail.com>
Message-ID: <CAHk-=wjg8oww+Bt5EY8a=5M59sv5pPSPMC-tPT+QrWEAAmDkkQ@mail.gmail.com>
Subject: Re: Linux 5.13-rc7
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 6:39 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 151 pass: 151 fail: 0
> Qemu test results:
>         total: 462 pass: 462 fail: 0

Thanks,

              Linus
