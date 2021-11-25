Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C581645D31E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhKYCXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbhKYCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:21:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E0C07E5E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 17:59:33 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z18so5651448iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 17:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAcNp4X6jrDsjulE8ZaiSIsC+nB87S5IJV/WQip3ae4=;
        b=ooMulXAP1oM/coKQycRncXg51FQ4J/+ur3ZpoJ9NsAXf9xiRDLmkutjQ/HJ0362f1s
         Dd4evX/VDBnyv4HBLqwcb+kh0l5d4prZWANC3oQPJLfH/oPyToeiRz+ph/rmoBNzSk48
         kY2NlGA3OKNLQQVtnIBTzZwNt2oi51EKiSOuLxwE1in9nXrBIAk6KXAV4da6N1ZzMxlS
         yHuOd1fLdTWoGBB5iyIVaVQOw8RX0mkD6Snff+UFdBfxemAUAaDrdRWuKKzdH6zZcEMU
         QLMBIogBCLHrHnZvtUW7piya2ook11d4jyZ4tfbBW6EJrNZPAuu0e4Id30MGWkARGV9y
         lxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAcNp4X6jrDsjulE8ZaiSIsC+nB87S5IJV/WQip3ae4=;
        b=YQ8k5pfAAfR5Z//PDO8ZfjyVjU6/9WaE/Z6XCQ4v+WuQR9BSL788F8S/I1GdsQ79kG
         NgmvvoJFDpJeiIL6Zxr5j8P9xzWqlHsocOVl1B+qVKeWjk++Yyz4ZSilX1WU0NHtxLdW
         B9LrEZm19C5ogqKaR8KiwpG7X7zboTFG+Vc1SmWYAOfF8tg0T3nX/c08FOblgfHQxs7s
         fFR8J5p/DPdP8CTpQ6vot8b5WrHkkgiPgviGO4LAQvYvDnqrxhT/N7Ljb0HtWgDViCFW
         /+H7fJwS9tLM+LJezMUDbfkNaGusRw8Jps60Y52wHRB++MN6c90AMqWtG3HbrV7vkt6o
         Zeng==
X-Gm-Message-State: AOAM531bhNdkNv1tiAcdpaXNSK6+1s1tQdIknmWfo+8VXd9Vs7qWnJ3+
        pgHzFo4JDOmpjoV9qC4beGw=
X-Google-Smtp-Source: ABdhPJyE+3cWE663pil3AVAZQkRGm+KmLuLmJZk20sNXZsdgdOxx0VTXdFKlaw8NswukaGyS7e1t3g==
X-Received: by 2002:a05:6638:2bb:: with SMTP id d27mr24995364jaq.66.1637805573366;
        Wed, 24 Nov 2021 17:59:33 -0800 (PST)
Received: from localhost.localdomain (mobile-130-126-255-38.near.illinois.edu. [130.126.255.38])
        by smtp.googlemail.com with ESMTPSA id y11sm775014ioy.19.2021.11.24.17.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 17:59:33 -0800 (PST)
Message-ID: <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
X-Google-Original-Message-ID: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com> (raw)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     edumazet@google.com, Johannes Berg <johannes@sipsolutions.net>
Cc:     alexanderduyck@fb.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        lkp@intel.com, peterz@infradead.org, x86@kernel.org,
        goldstein.w.n@gmail.com
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad'
Date:   Wed, 24 Nov 2021 19:58:57 -0600
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

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

Hi, I'm not sure if this is intentional or not, but I noticed that the output
of 'csum_partial' is different after this patch. I figured that the checksum
algorithm is fixed so just wanted mention it incase its a bug. If not sorry
for the spam.

Example on x86_64:

Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
len : 11
sum : 0

csum_partial new : 2480936615
csum_partial HEAD: 2472089390
