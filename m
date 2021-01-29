Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07A308473
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 05:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhA2EDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 23:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2EDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:03:39 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69B9C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 20:02:58 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u17so7979324iow.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 20:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28Nl9/dUh35Ow6MunNFQ7OoxHq8VTYU9WPezp2B3FAw=;
        b=qUGyEDJQsMMIKRTpcSPICT2MHDKXEr2cT2xmu4U5sOAeTWuspjvqOcVPv7FtO8rVlO
         +nDHO9plZvmWGkUVqCeB8+vqda+eTPd02LDlU6aZP5N0CmeSpQXXnArD0FOZ1DgKqr6T
         /PZwXdoqAb8zCRSR1bpfbvTiuiaQ2Tg4QXHitYzuS1M7k2xPOSfGexTWYf/3N6DjxVW2
         mQLsXGk/ICv0d9mm3hm8u/9DahjAfJJ7KwG2YKriwSa0UQIFgDyRCuAw0KCGlDTKjELr
         FCyiSIT+g64XCH7qyGWS+sjnNGUgpfaIUckoWkZRqup/9ssyPgoNpWCHmTFskQWxwN92
         Aceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28Nl9/dUh35Ow6MunNFQ7OoxHq8VTYU9WPezp2B3FAw=;
        b=ZXmjLYWrj5I03AoLUd+lg6Io2rGe3RmkHQfRQmYuOEySDgQFDKhLp+2EaEJrY+XUQy
         Lzs4eebQ6fjnHO+/EzLdCgvjwucEYLZzC0Ruk/UFrBoz/Wht2i7MH5EvbvQoStKvYVj4
         Q56osQ1NxGDOcQYQuU2PjHl+yTK8iRN863oPhAjm9gnpAxlACbeZoGllOHSTwR8a3rQe
         rgWYNE3qFQX75crWOJVqsCz2Rv5FicQz+DIpS3XE9c/uGgZbYNRC5iJEbLOuDaeCWA3M
         Tcqai1Omf1VMWCuYlEmzwekYIHVdbDbDijCKgzDKXeJYdRfpiOHQqgItoo7oebzgbAIS
         Zp5w==
X-Gm-Message-State: AOAM532sFbD2V3RkJyUn92A9HJx/lCP1UjhImQxClpBScG6R0JVRR6LO
        cpb12kw6G19hWRC0h8b/42F2oKliuAcZYKtXy0SKig==
X-Google-Smtp-Source: ABdhPJyeqdzmMfVxDIuu0piiaPlAz37NXWbvEzIH5lZNMbUNSeeV9AclYQL5qEX+9IlTb8LzPOw5CxlL4VCbZgL2l9U=
X-Received: by 2002:a5d:940d:: with SMTP id v13mr1974925ion.193.1611892978165;
 Thu, 28 Jan 2021 20:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20210129003029.10672-1-scott.branden@broadcom.com>
In-Reply-To: <20210129003029.10672-1-scott.branden@broadcom.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 28 Jan 2021 20:02:46 -0800
Message-ID: <CAOesGMgzKKjOBHYM=eodZPm0rE=_oF9o_jjBudQ-Ef8gYFFMfg@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] Add Broadcom VK driver
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott,

On Thu, Jan 28, 2021 at 4:30 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
>
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition which has
> now been accepted into the upstream kernel as of v5.10-rc1).
>
> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
>
> Changes from v9:
>  - fix compile if CONFIG_TTY not set
>  - use if-else statement instead of conditional expression in set_q_num
>  - generate bcm_vk_msg_remove call in proper patch
>    (was generated in tty patch when should be in msg patch)

Did I miss something? Greg already applied v9, so any fixes on top
needs to be new patches.


-Olof
