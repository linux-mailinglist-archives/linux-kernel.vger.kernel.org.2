Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A361637F9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhEMOuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhEMOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:48:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:47:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q10so21523780qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZDQfjbf6pJwb9J7spXEzSQhqTL+LF0JVwTse/mbpog4=;
        b=Q6GqQN+d8kwn0Il9bL670Hp0G0mSUhPw57BiBZWhQPpUBlU05noP3iWjSlMEZCR7fZ
         0g3pej3wy8Sn0Oo0ajUy1bx6jFGqhdBFJgHSLmd8oFbO9wqSVgWyZQu3Hmi+Xy0nLsL2
         eG60abftiHxfE/dYgSExCG47cETQJwqD5P7fYnF9SScMnE53qTsScEBcNSb/N8aiZ5qP
         m0S7Fh/09GYmKxbpatIYDwlGRvIB8JqUu+RXjCeWb0nGmCCYdGvq13OHdy5SYO9Qt8+I
         /K2W8TbN6M5ayEyyKZ50x5NAECtm8Yp/EZ0pqBYKtg5n3K9+KSnbnyO4bzzcLTWHIP4b
         +Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZDQfjbf6pJwb9J7spXEzSQhqTL+LF0JVwTse/mbpog4=;
        b=M/1llY0bNbvIG0juYGvo1GO3a+rNwkagUSBXMupsGa2DF1zJD5hPPE1shCK+noJEM1
         pqu4CHsjGQI8ib+L28s0NHLN3v7c4ccZX801JwEfVDUYO8oWYhncTvU5/TSfkYhkIgzH
         FkoMJ8qwRAs5Q8EzwYKX0lXeJ5L3sBtciZE7ExIMwoXlVAXWZN1RcBiRwklmM30/6Fo8
         uke8sc4DALDniTN1J4DaSDT3D6QkNvHsKaicfKtEtXd/PLHpmN9B2tqGNjrDNXvSrNCM
         JiHOMqGXqEafgdGU+piNHZCpRT08c4qdHr4iftDf996/oXHaFkycgRFGwLFOQg8SyBKx
         rYNA==
X-Gm-Message-State: AOAM533gV/B+8D3gjTam/N6+Lut6OMWD/ahS4qAsLQpQiwmbXEiBqYyu
        6IvV7kiZzwoPwfkJS/qOsk7qRb7PuOo=
X-Google-Smtp-Source: ABdhPJwhhbbAagqK5owF1WpIBmbdgd69cNi7cXERhY2errLzcoMFdxFWoZHFCHYinYulN2ASIw+24Q==
X-Received: by 2002:a05:620a:e05:: with SMTP id y5mr38950089qkm.250.1620917237966;
        Thu, 13 May 2021 07:47:17 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c20sm2708301qtg.84.2021.05.13.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 07:47:17 -0700 (PDT)
Date:   Thu, 13 May 2021 07:47:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Max =?iso-8859-1?Q?G=F6rner?= <max@familie-goerner.eu>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: Bug Report: 2cc7b6 exposes violations of type limits
Message-ID: <YJ079LaADbsxWnbu@yury-ThinkPad>
References: <YJz5+i5Nb1iyqY5c@solactive.solactive>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJz5+i5Nb1iyqY5c@solactive.solactive>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC: LKML]

On Thu, May 13, 2021 at 12:05:46PM +0200, Max Görner wrote:
> Dear Mr Norov, dear Mr Morton,
> 
> with this e-mail I want to report a bug in the kernel to you. I am approaching
> both of you because you are the author and the maintainer, respectively.
> 
> I am the maintainer of a community fork of a WIFI driver (rtl88x2bu,
> https://github.com/cilynx/rtl88x2bu/tree/5.8.7.1_35809.20191129_COEX20191120-7777).
> Usually new kernel versions introduce new incompatibilities which break the
> compilation. I then add a new `#if LINUX_VERSION_CODE` branch in which I fix
> things.
> 
> I am proud to say that the driver compiles with `-O3 -Wall -Werror` with only a
> modest number of `-Wno-...` directives. I usually compile with
> `-O2 -Wall -Werror`, though.
> 
> In the merge window for Linux Kernel v5.13 Mr Norov added commit
> 2cc7b6a44ac21d31b398b03f4845c53152070416 which looks fairly innocent to me.
> However, it exposes some information to GCC, allowing GCC to deduce that some
> comparisons do not make sense. Now GCC complains that there are tests whether
> an `unsigned long` is `< 0`.
> 
> However, these problems appear only when I try to compile the WIFI driver, not
> when compiling the kernel itself. I suspect that the problems would appear if
> the kernel would be compiled with `-Wall -Werror`, but I do not know how to do
> that. I attached the error messages in a separate file.
> 
> I think having type limit violations in the code is bad in itself. It also
> breaks some external code (my driver). With this bug report I want to kindly
> ask you if you could fix these type limit violations.
> 
> 
> Thank you very much.
> 
> 
> Best regards
> 
> Max Görner

> make ARCH=x86_64 CROSS_COMPILE= -C /home/mgoerner/Werkbank/Hobbys/Linux-Kernel/linux M=/home/mgoerner/Werkbank/Hobbys/rtl88x2bu  modules
> make[1]: Verzeichnis „/home/mgoerner/Werkbank/Hobbys/Linux-Kernel/linux“ wird betreten
>   CC [M]  /home/mgoerner/Werkbank/Hobbys/rtl88x2bu/core/rtw_cmd.o
> In file included from ./include/linux/bits.h:22,
>                  from ./include/linux/bitops.h:6,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:12,
>                  from /home/mgoerner/Werkbank/Hobbys/rtl88x2bu/include/basic_types.h:76,
>                  from /home/mgoerner/Werkbank/Hobbys/rtl88x2bu/include/drv_types.h:26,
>                  from /home/mgoerner/Werkbank/Hobbys/rtl88x2bu/core/rtw_cmd.c:17:
> ./include/asm-generic/bitops/find.h: In function ‘find_first_bit’:
> ./include/linux/bits.h:25:28: error: comparison of unsigned expression in ‘< 0’ is always false [-Werror=type-limits]
>    25 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>       |                            ^

[...]

Kernel disables -Werror=type-limits in scripts/Makefile.extrawarn. It
looks missed -Wno-type-limits in your scripts.
