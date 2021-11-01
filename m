Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980AF441718
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhKAJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhKAJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:28:37 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDBC0432D8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:21:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o83so24069840oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avgfemLqJtyA6u13YQ3VnRdUdzB18P1IGLg3Iu+4bvg=;
        b=U9pqCePJtRJr2pKg3xhl49HKL7jZIAgQUolh/tAAuVebFLy50g9lJtl1iHKavD5BwQ
         4GU4hjwcz60FmwRK7x2TrqrNXcdBMvxHs6bbagCx1X/sn8MYymXJIUFymTIMTFZhZrMk
         QJhk9e1G8YKGXwTpn6O0f2wD4xFaHc2UMKVqlhYb1ubkDk+F67hbiY0YsS9hxgPuADmc
         7a8ED/BRo1AlsUJOGtSEbpEnu2lUMOfIQv3WvPlY9O/qGe1YYOAAXmRce+fRhe7C3JTO
         pJBchj4jr0bBVv1ReFU2er3cUUx9Fmjp8Q3M6OALn7EudrDLe+nL9fQb2KihwZENk8x6
         XE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avgfemLqJtyA6u13YQ3VnRdUdzB18P1IGLg3Iu+4bvg=;
        b=aKkOkc8Wu7chmHc7D4+j6xHKdWKivS9pOxmQYM+6Sp3ajEPcgUa9eZ9TbwL+WekyyI
         181bjQV1pGO2U1f6EfKgx24ibqK9KQIYpWE0eGKOsEjLbT9UT0/bXDBRQkHp8lrL9647
         47RS23lKzPBRnNfVfPwjBWwdBPQwn/jpNNCbrfAe/hAE0LqTPkJ2OZg1fXnQfgGS6lDV
         yruYJ1tGOHyosgCvMFfzoO1IWZfPdMO7gJ1XeBY8dBpi3jNwFpTqM1zq054gyVZ7Wx0t
         jhetlyJmqzctCnUcwx2ujB8MMOhWgeOfcPXKoP47lRYbu2SWfcVzM67VFQfPyiD9p45N
         aSYw==
X-Gm-Message-State: AOAM5334MzXlGhokyQ6ldfdgwh/WyXGFIAeOTqWts5Y4UObq5QeY1hRX
        2puWHdst25YkNym8atpI2kL8qH/VkSLDoRydIDM=
X-Google-Smtp-Source: ABdhPJz4vJ3sI385kQe1dlUHxvlZldRrvb2ZLUh3WZVAT9MkX6ImVdbTIwt9JFLyQ5fVZB9ayStEsXniOEltmyOcpZQ=
X-Received: by 2002:aca:ab14:: with SMTP id u20mr24508455oie.114.1635758465317;
 Mon, 01 Nov 2021 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
 <1635490280-8798-2-git-send-email-zhenguo6858@gmail.com> <B5B678EA-303B-4F16-AD89-EE7C31AFC4ED@chromium.org>
In-Reply-To: <B5B678EA-303B-4F16-AD89-EE7C31AFC4ED@chromium.org>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Mon, 1 Nov 2021 17:19:09 +0800
Message-ID: <CAGGV+3KNBx8TVndbq6mz_3EQ89XxS-OS=osFYEQacCMp=9r6mA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pstore: Add pstore back-end choice method in kconfig
To:     Kees Cook <keescook@chromium.org>
Cc:     nianfu.bai@unisoc.com, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kees Cook,

Thank you very much for your reply.

I had tested Kconfig,

1: "Persistent store support"  set Y, it will build in kernel ,pstore
device select one device only,default is ram.it can be select block
device
   because only one device as backend,so select choice ,it should be reason=
able=E3=80=82

2: "Persistent store support"  set m. it will build modules,we can
select one or all pstore devices.

-----------------------------------test result as follows:
1.1:  build in

<*>   Persistent store support            // select build in
<*>     DEFLATE (ZLIB) compression
< >     LZO compression
< >     LZ4 compression
< >     LZ4HC compression
[ ]     842 compression
[ ]     zstd compression
  Default pstore compression algorithm (deflate)  --->
 [*]     Log kernel console messages
[*]     Log user space messages
<*>     Choice pstore device (Log panic/oops to a RAM buffer)  --->
// default select ram.you can select block device
[
(X) Log panic/oops to a RAM buffer)
( ) Log panic/oops to a block device
]

defconfig:

CONFIG_PSTORE=3Dy
CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=3Dy
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
CONFIG_PSTORE_CONSOLE=3Dy
CONFIG_PSTORE_PMSG=3Dy
CONFIG_PSTORE_RAM=3Dy
# CONFIG_PSTORE_BLK is not set


2.1  select "Persistent store support" is M, default pstore is ram.

<M>   Persistent store support
<M>     DEFLATE (ZLIB) compression
< >     LZO compression
< >     LZ4 compression
< >     LZ4HC compression
[ ]     842 compression
[ ]     zstd compression
 Default pstore compression algorithm (deflate)  --->
[*]     Log kernel console messages
[*]     Log user space messages
Choice pstore device
<M> Log panic/oops to a RAM buffer              // ram device
< > Log panic/oops to a block device

2.2  select "Persistent store support" is M, select block device

<M>   Persistent store support
<M>     DEFLATE (ZLIB) compression
< >     LZO compression
< >     LZ4 compression
< >     LZ4HC compression
[ ]     842 compression
[ ]     zstd compression
 Default pstore compression algorithm (deflate)  --->
[*]     Log kernel console messages
[*]     Log user space messages
Choice pstore device
< > Log panic/oops to a RAM buffer
<M> Log panic/oops to a block device
()    block device identifier (NEW)
(64)  Size in Kbytes of kmsg dump log to store (NEW)
(2)   Maximum kmsg dump reason to store (NEW)
(64)  Size in Kbytes of pmsg to store (NEW)
(64)  Size in Kbytes of console log to store (NEW)

2.3  select "Persistent store support" is M, it can select all pstore devic=
e

<M>   Persistent store support
<M>     DEFLATE (ZLIB) compression
< >     LZO compression
< >     LZ4 compression
< >     LZ4HC compression
[ ]     842 compression
[ ]     zstd compression
 Default pstore compression algorithm (deflate)  --->
[*]     Log kernel console messages
[*]     Log user space messages
Choice pstore device
<M> Log panic/oops to a RAM buffer            // ram set M
<M> Log panic/oops to a block device          // block set M
()    block device identifier (NEW)
(64)  Size in Kbytes of kmsg dump log to store (NEW)
(2)   Maximum kmsg dump reason to store (NEW)
(64)  Size in Kbytes of pmsg to store (NEW)
(64)  Size in Kbytes of console log to store (NEW)

defconfig

-CONFIG_PSTORE=3Dy
-CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
+CONFIG_PSTORE=3Dm
+CONFIG_PSTORE_DEFLATE_COMPRESS=3Dm
 # CONFIG_PSTORE_LZO_COMPRESS is not set
 # CONFIG_PSTORE_LZ4_COMPRESS is not set
 # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
@@ -5536,8 +5536,14 @@ CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
 CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
 CONFIG_PSTORE_CONSOLE=3Dy
 CONFIG_PSTORE_PMSG=3Dy
-CONFIG_PSTORE_RAM=3Dy
-# CONFIG_PSTORE_BLK is not set
+CONFIG_PSTORE_RAM=3Dm
+CONFIG_PSTORE_BLK=3Dm
+CONFIG_PSTORE_ZONE=3Dm
+CONFIG_PSTORE_BLK_BLKDEV=3D""
+CONFIG_PSTORE_BLK_KMSG_SIZE=3D64
+CONFIG_PSTORE_BLK_MAX_REASON=3D2
+CONFIG_PSTORE_BLK_PMSG_SIZE=3D64
+CONFIG_PSTORE_BLK_CONSOLE_SIZE=3D64

Thanks!
=E6=8C=AF=E5=9B=BD
