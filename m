Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A8456119
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhKRRF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhKRRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:05:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:02:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u18so12881519wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRn/yZxnwMFU2U+8Psu2GvW7uVIFDIKc5oBI81gRRKw=;
        b=J6OZNkOaGT+iEXFI3Ni6XNFd0khb5fQqBSXVta5rimsruQrEO8BZHX3RBgK+KppNPb
         OQt85+Kf1nwpphapUKabF7v9DgBXz0B3VRcHwT9SsWfd4xA+Itwj99vPALPAU6nzO7Uk
         L5eeZeQnednvID9lIwdUvdHR1a4uWAvRGqHFnhrpnm19QqJajP7SMWgC0Sy7xGQkCovT
         C7/gITvywMNWWOCjI2u+qRligm+vXyeCX6s0V8a3aWlo26gqtA/y6duTWOUTTJ1lBpX6
         MF1JqZ+msCOOQY9QeHD6N1AZxDGA0Ifi5Kx48QjgJyKsOLAtN3iIXqR2IuGIKT8SO8Gr
         Tglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRn/yZxnwMFU2U+8Psu2GvW7uVIFDIKc5oBI81gRRKw=;
        b=mV4J/oKQGMXwMqTQBAeS4ELjeViUbcmrWpiEn2ThwHDX19WzCDxtvmaQyyUZ/QYF2n
         0ecoFjoq15x3eUD7purRysb3teqihkaf+Y1VRBQ7bACdEyj5MnbSSIHrfxHx4JZHufMN
         JGmzM9sNX5/tWIvtS5qUsMr1Y9WFywi29E+Fc003MPUlvyFEL5c5E2GegwxunkdVt6v1
         FK0jz0WNnS3RFzaMMmZvwno0PpnvV8VWyaO+NHQGCXHdsPUe7YCDjtGfQUwSqdASxnbT
         J6/Cp3LLZFSF0uJWPFxSdSWMl0B7zQk+bSd96rabEBSjRBUGKMIcO6+U0EjApf+BGHow
         9lew==
X-Gm-Message-State: AOAM533gSR5iRpoMRcRPMSA+QRW5KD9gCmqscxO5D1ZUmWvqP/KEtaNd
        qQ26G0mblQOh79f8QcaxlE8sJ2m5iyD9MvLeQL2U/hjkrR1APg==
X-Google-Smtp-Source: ABdhPJz+YEMnsujLur7xZhT2XZqy9sbf1fR/5FUW8bnfqEiuEseOdGGlp/GxFkNpRUpLDteOMUT59Q1bvqFrHdAsfXs=
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr33241259wrm.60.1637254975566;
 Thu, 18 Nov 2021 09:02:55 -0800 (PST)
MIME-Version: 1.0
References: <202111180219.YkyoBMpf-lkp@intel.com> <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net> <21f86e2bc817b6ec0c7a9194a4fefb1d55e3040b.camel@sipsolutions.net>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
In-Reply-To: <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 18 Nov 2021 09:02:43 -0800
Message-ID: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 8:57 AM Eric Dumazet <edumazet@google.com> wrote:

>
> Unless fixups can be handled, the signature of the function needs to
> be different.
>
> In UM, we would need to provide a number of bytes that can be read.

We can make this a bit less ugly  of course.

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5ec35626945b6db2f7f41c6d46d5e422810eac46..7a3c4e7e05c4b21566e1ee3813a071509a9d54ff
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -21,6 +21,25 @@ static inline unsigned short from32to16(unsigned a)
        return b;
 }

+
+static inline unsigned long load_partial_long(const void *buff, int len)
+{
+#ifndef CONFIG_DCACHE_WORD_ACCESS
+               union {
+                       unsigned long   ulval;
+                       u8              bytes[sizeof(long)];
+               } v;
+
+               v.ulval = 0;
+               memcpy(v.bytes, buff, len);
+               return v.ulval;
+#else
+               unsigned int shift = (sizeof(long) - len) * BITS_PER_BYTE;
+
+               return (load_unaligned_zeropad(buff) << shift) >> shift;
+#endif
+}
+
 /*
  * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
@@ -91,11 +110,9 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
                        : "memory");
                buff += 8;
        }
-       if (len & 7) {
-               unsigned int shift = (8 - (len & 7)) * 8;
-               unsigned long trail;
-
-               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
+       len &= 7;
+       if (len) {
+               unsigned long trail = load_partial_long(buff, len);

                asm("addq %[trail],%[res]\n\t"
                    "adcq $0,%[res]"
