Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE1344E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCVSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhCVS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:29:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:29:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w37so22795516lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcDkaXELEqJd1neu6XP46Ih5an6aUpGo+m2JsFqgqHo=;
        b=R6PM24j1KIJvAANMMEfiSHd0O0WKB/lu1d0MAaSIB3vdhYP8HYxj3hFlGEobaa/kLw
         sEAUmUPEeeRU2ZovIUzrXv8F8KBx9CnrKTCHopspm5UjpxBlPaQOuY+gOYzzGCOC0DQN
         VPzXToesXtKJKq46pBCsvjzMPAX/U1xoek+ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcDkaXELEqJd1neu6XP46Ih5an6aUpGo+m2JsFqgqHo=;
        b=PMzfUV3pwNRFkgQ+FnhRz2WodaVi1nZoPLG3AWO1mIqh5vhW8b1cvax/EG6GSmMWHe
         QYjbnvqEYPbumuyA2VVYXcL25g/EZoUG1p2oGej+CLgDekoL+ZSVnqkExl5cXh4JxRlP
         rWJswygRlZzmtn7iJb3PQeWhHHjC1pd3HKnHiVRwjXymCY0Ur4AFIxbKFPNLceUteKyh
         c3WRi5D0NexjgjE2N7S7tM8hZdz5Jeh4lAZ3vxd2A1KIE3eDP8gA8dBtTH96CcxQ1KEn
         m39GPGcWsSJkA0GtZI/Fi8EamgyYVf/SizQ+fp77AqUxvMC9xjiMN4+8DnxtBhf7xkTQ
         d9kg==
X-Gm-Message-State: AOAM531SQ5UdLQHJ/uSOxKPTnDK7PEXFHhmMv5VG9qb76sLg0oqOG9/m
        tT/Kwtpsd5iFktEZrIH09N4ZA5i4153Hig==
X-Google-Smtp-Source: ABdhPJyHRQAQWIsplt3ei+1xJ5crCuFSeRpbYRjXbjZ9WaxnpxIZfNE5cnU/S7sfWA2UcNuz9vbKpQ==
X-Received: by 2002:a19:68c:: with SMTP id 134mr370210lfg.155.1616437779004;
        Mon, 22 Mar 2021 11:29:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o1sm1631922lfu.299.2021.03.22.11.29.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 11:29:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x28so22805066lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:29:38 -0700 (PDT)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr331679lfy.377.1616437778161;
 Mon, 22 Mar 2021 11:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whDxybSS63==ycQiNobvamDmoyxQo1JL-31Tup8azbeWw@mail.gmail.com>
 <20210322182336.GA240669@roeck-us.net>
In-Reply-To: <20210322182336.GA240669@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Mar 2021 11:29:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8wLhXomM92Ay-7MiWYskbvvn+fCYMVhg7o-QAEiRtWA@mail.gmail.com>
Message-ID: <CAHk-=wh8wLhXomM92Ay-7MiWYskbvvn+fCYMVhg7o-QAEiRtWA@mail.gmail.com>
Subject: Re: Linux 5.12-rc4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 151 pass: 151 fail: 0
> Qemu test results:
>         total: 437 pass: 437 fail: 0

Thanks,

            Linus
