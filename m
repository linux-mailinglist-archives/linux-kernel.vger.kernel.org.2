Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEB38DE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 02:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhEXAtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 20:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhEXAtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 20:49:41 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 17:48:14 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so4034257ooq.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgHdI5lskBzQnFk3xTRhcif2ctUBxuiUcbVE733gEr8=;
        b=ZIs3NVVJWysGgYsZGra4RfHIaEnA0lVtrkwsDxyw+Rqo1E9GWIQVy6qgnY/Ec36Ehf
         Ct0+dhJvJoFqSSfbsFlJQjd+FfJNR50tvR4d0ujGnvh/R5ct63SH2SAJWCn7d3R8aTYe
         R1O0Ltgi/0RUQxHtwHmuyBwD/q2z8e4ECHohz+DbzO6NzBynwE8/AZ+X3/+dYWOwfxWm
         yIA/PNty3XtwjLtLuacuW5CHtYjubp+VMF3dNvg6A3X3QFx3P+av4XhucPQCpvXSkdHl
         y3eKmh/AABQB8z8IevvJ74ZJQuNUCItYmIrrY9r0OFHsKIk96Ntj5iw05og9PD024ZRS
         oHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LgHdI5lskBzQnFk3xTRhcif2ctUBxuiUcbVE733gEr8=;
        b=CYDI5RYIoEHiluRflPZppedD8I6x6QHNiAUK64ndvTWixa4kg4a3Tqddln8sMtFpiQ
         HjaUXkdk6Em6UplB/f0GvUEmGpYzzmXv3sgPWDlNhZZ1dvZiwTGgRZeQEJ1HXzFf5o/r
         DScs7Nz/AAwsy2O8u4vG10y8GLa3GDWUNR1kemo5ruOBXk4LSkieYwySSpgdI1SqurJ5
         zUJirMw2VGp0mNCvRZ5gje6taivOkypyzkK9Dncl8rwkomAcW6xKOeMe12yaBR/3VuIy
         GYu6bIU+NDNJKQAWz0XJhqj6vToMsibicgU4UGlaVLz8JOOlf1seZ3WuU5i4pR7UF96v
         U+KA==
X-Gm-Message-State: AOAM530Eb8QqK0jj291Wh1c1q2DeXhZsmOI1KMrvO7Hz6goknp+NbPnu
        WONTu3NiO7o7N43VNF6SSefK7hbSRq8=
X-Google-Smtp-Source: ABdhPJxPPj9qUfByHMsPKClKscnlD5mVFNMbL+0hmAMiyEuGT891qPBd5QcEy95NFOR3yHm3I7b6Uw==
X-Received: by 2002:a4a:d89a:: with SMTP id b26mr14219433oov.11.1621817292972;
        Sun, 23 May 2021 17:48:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2sm2750743otp.77.2021.05.23.17.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 17:48:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 23 May 2021 17:48:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc3
Message-ID: <20210524004811.GA1714622@roeck-us.net>
References: <CAHk-=wiUwtRp+jjCMd9x8O90iD_YHVBQzJoKCsT9e06L7qob3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUwtRp+jjCMd9x8O90iD_YHVBQzJoKCsT9e06L7qob3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 11:57:20AM -1000, Linus Torvalds wrote:
> Hmm. rc3 is when usually the other shoe drops, and we start having a
> lot more fixes for fallout from the merge window.
> 
> Not so this time. It's been a very calm rc3 week, and at least in pure
> number of commits this is the smallest rc3 we've had in the 5.x
> series.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
