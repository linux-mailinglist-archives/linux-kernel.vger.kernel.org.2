Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9F457E91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhKTNEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKTNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E870BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so9618453wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSadVuxStPsrx9ryZlsMPd6bTbU3U7t173CVaj0Be2c=;
        b=JaGk2+huh2HHWPw4ERW9uErKiwX/8C1+AWlR+QESmo0MLigZQUQzzkO4gmipqrilDx
         JRGB+sgG421aW/kfST77n3KfIQ/nnguc4w9IoIn0QyxEIs0OmnX0zxze+LbVFuYTuZgC
         i+U0Ibm2S+SNYmjm1d3vizE44Op5+IpLh7gYlDYnAR7/FD3CazydoHzz4IaI+Osk3LZt
         6cW/L5dUQFuO2WW+NXUM3gsC+Re4xUX7QgIOQhnL2xm70vlYeSs5CelSOeUJtHTWG5ks
         g/ZzAzRq0URpz3LqipFxY8+GMeCIhx3ZWBX+HlUxNySWbZ/W1H9/osjriGZgh3AVwpAf
         H/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSadVuxStPsrx9ryZlsMPd6bTbU3U7t173CVaj0Be2c=;
        b=XcMIH4Teu2GOmivI9xB+FkoLiVm9aVrSwUcaCUV3qcPQ8AkhPLyT3UNKgY+XyGDXkK
         rhWSvmhImFHmOvaXZuJaRY33O7ee7kZZnLdSk0vas24zlxDPN8tW41Hx+/hxG6f7ae6w
         yqyth2va50snzZLs772LtI2FSVwF7VNAVeZtNtBzWiq/DVwuw2Y7cs1mxNwcc50aRhWh
         ZS3Jxab7c6rluNqBYYBaxI94chP7Fm0BpWXsjwmy0XXZAgSzrvNUZhsGzJ6OSYe+0o/V
         UiuYzYJPmJ685bDb2a2jvB1sMJ40LtuzyiFuO7Uvts/paJr31pmlA1Whufw0+m/Ld2WP
         7QPw==
X-Gm-Message-State: AOAM531XBxpFBYEDSOv53GYockUZq9sC3a16GWYBTfLHoRw4YUXDtHoZ
        gsB3k+54HX5pvncTS1CKqvMJunQG3Fpsgg==
X-Google-Smtp-Source: ABdhPJyvzzqW5crGex4i+q6D+NlT5BWb2tmNjRyFFqHLUYVVOdaH9HUMjMOrBIwRomNJTCGMVs/KPA==
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr9957047wmq.74.1637413276544;
        Sat, 20 Nov 2021 05:01:16 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:16 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 00/20] Add memberof(), split headers, and simplify code
Date:   Sat, 20 Nov 2021 14:00:43 +0100
Message-Id: <20211120130104.185699-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I splitted some macros into separate headers,
to be able to use them
without pulling too many deps.

I also simplified some of themr
to be implemented in terms of the others
and to remove some unnecessary explicit casts.

And I added memberof(),
which gives name to a typical construction
to get the member of a struct
without needing a variable of that type.


The next step after this patch set
is another one removing all redefinitions
(at least all that are possible,
since these headers can't be included everywhere)
of these macros,
by including these new tiny headers.
Since these headers are so tiny and bring no dependencies,
they should break anything.

It was hard for me to get this working
because the order of includes _matters a lot_,
and which headers you include _matters_ even outside of uapi.
So I think this should help fix that,
by allowing headers to pull exactly what they want,
without all of the stuff that came with
<linux/compiler.h>
<linux/compiler_types.h>
<linux/stddef.h>.

I already have much of the next patch set ready,
and it removes hundreds of redefinitions of these macros,
which should be a good thing.


Then,
when there are (almost) no redefinitions of these macros,
I'll prepare a 3rd patch set that
explicitly includes these tiny headers
wherever these macros were already in use,
to allow for removal of other bigger headers
(although I won't remove anything,
to avoid silently breaking anything).


And then,
a 4th patch set will
attempt to find all uses of these macros
that were not even named
(i.e., hard-coded sizeof divisions).


Hope this is clear and
that you like these changes.


Cheers,
Alex


Alejandro Colomar (20):
  linux/stddef.h, linux/offsetof.h: Split offsetof() into a separate
    header
  linux/stddef.h, linux/sizeof_field.h: Split sizeof_field() into a
    separate header
  linux/stddef.h, linux/offsetofend.h: Split offsetofend() into a
    separate header
  linux/stddef.h, linux/NULL.h: Split NULL into a separate header
  linux/container_of.h, linux/typeof_member.h: Split typeof_member()
    into a separate header
  linux/kernel.h, linux/array_size.h: Split ARRAY_SIZE() into a separate
    header
  linux/memberof.h: Add memberof(T, m) macro
  Implement container_of_safe() in terms of container_of()
  Implement offsetof(), sizeof_member(), typeof_member(), and
    container_of() in terms of memberof()
  linux/container_of.h: Remove unnecessary cast
  linux/container_of.h: Cosmetic
  linux/must_be.h: Add must_be() to improve readability of
    BUILD_BUG_ON_ZERO()
  linux/build_bug.h, linux/must_be.h: Move BUILD_BUG_ON_ZERO to
    <linux/must_be.h>
  linux/compiler_types.h, linux/same_type.h: Split __same_type() to a
    separate header
  linux/compiler.h: Implement __must_be_array() in terms of __must_be()
  linux/compiler.h, linux/array_size.h: Move __must_be_array() into
    <linux/array_size.h>
  linux/array_size.h: Add __is_array(a) to help readability
  linux/power_of_2.h: Add __IS_POWER_OF_2(n) and __IS_POWER_OF_2_OR_0(n)
    macros
  linux/build_bug.h, linux/power_of_2.h: Move
    [__]BUILD_BUG_ON_NOT_POWER_OF_2() to <linux/power_of_2.h>
  linux/power_of_2.h: Implement [__]BUILD_BUG_ON_NOT_POWER_OF_2() in
    terms of __IS_POWER_OF_2[_OR_0]()

 drivers/gpu/drm/i915/i915_utils.h           |  3 ++
 drivers/net/can/usb/etas_es58x/es58x_core.h |  3 ++
 include/linux/NULL.h                        | 10 +++++++
 include/linux/array_size.h                  | 21 ++++++++++++++
 include/linux/build_bug.h                   | 20 ++-----------
 include/linux/compiler.h                    |  3 --
 include/linux/compiler_types.h              |  7 +++--
 include/linux/container_of.h                | 25 ++++++++--------
 include/linux/kernel.h                      |  9 ++----
 include/linux/memberof.h                    | 12 ++++++++
 include/linux/must_be.h                     | 21 ++++++++++++++
 include/linux/offsetof.h                    | 19 ++++++++++++
 include/linux/offsetofend.h                 | 19 ++++++++++++
 include/linux/overflow.h                    |  3 ++
 include/linux/power_of_2.h                  | 17 +++++++++++
 include/linux/same_type.h                   | 10 +++++++
 include/linux/sizeof_field.h                | 18 ++++++++++++
 include/linux/stddef.h                      | 32 ++++-----------------
 include/linux/typeof_member.h               | 12 ++++++++
 19 files changed, 197 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/NULL.h
 create mode 100644 include/linux/array_size.h
 create mode 100644 include/linux/memberof.h
 create mode 100644 include/linux/must_be.h
 create mode 100644 include/linux/offsetof.h
 create mode 100644 include/linux/offsetofend.h
 create mode 100644 include/linux/power_of_2.h
 create mode 100644 include/linux/same_type.h
 create mode 100644 include/linux/sizeof_field.h
 create mode 100644 include/linux/typeof_member.h

-- 
2.33.1

