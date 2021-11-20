Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A0457F75
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhKTQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhKTQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:20:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BB2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:17:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so56193855edv.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIHORpqV9ipTaDZ8o+mkE19LUxqdJUFqfTh/b2ftStc=;
        b=N9JwhtGnkcPmqOinzye3/hLoYuZcTJsZB2iLqpDa520MuG8c/9897oHnUZ7Bd26dCX
         tZlhyyRnvfHJStd9vJOjsp8oSlsyuJXabkMSz3fj2KMO6LpwgWxMrGONb2kKoD73LSKV
         I+5Zgox1OVTwn1gBvWwyGVtdtgyFSLamvyVab2tIEyzrLH/1VIDrh6pKNSXH0ijfChfU
         XtyS4Ns7FgQhqW0Q/zn46jpy76aEyumY2B3SQUINScmswhTCjaeNhsspyYw+n4dcQ6nr
         evgAzlt6/HbRs5w52CsgvUluvWcEdnnUjcXDYNuoINYfSw4CRVVXTFSQ0sCdpBhTEe8I
         B8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIHORpqV9ipTaDZ8o+mkE19LUxqdJUFqfTh/b2ftStc=;
        b=0Urdw9RLlvO9GvWW2877sNGlQ0E3hJKJy1HKyn6G7ph5wxW9v/IpiDbiWMRXCeUnx0
         blDrSmyAPRnBA/Z/rzVNCDE8xStRAodS2rOywQrwahTItvA0lOMf9dltbvdnyOEeaR6C
         QDug7wFJXhb4aW8+rHmIT5lOfXCQfQVyQ64cf2VZeM4eOWLlH6HqoPSSLrdzJ3fH4yCl
         MABMpaA/w+AITSVKay7Cpm+YXc0PwYIGMSkXqWqNBcr0mPtx3blGbI7MVJzg45CLHnYt
         w7q7PQNFXYOFwyL6gXYFWIPtYKHlKUq2bbaUSJW0xLZFKEq0T6kWKZ9zNuewE5vEpTLZ
         mqAg==
X-Gm-Message-State: AOAM530cfwpGgvZrc7F47Gytjp74fMtLTKW9eZ+lnjZleB9ENzy4Xc3w
        QZu5vu9TJnBsQmeeXxoKSCkCEWCMRA5z+HJPTpCb/vkO99GOTw==
X-Google-Smtp-Source: ABdhPJxRsJ+VrpZMEcQV0W3f1Wap8B02tFhpzBqIuE6oz4vnPFTgu83LHDWYq5DrmvPO5rvCQAKyZDBmgdSU7ZfF3pw=
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr39643842edb.240.1637425044507;
 Sat, 20 Nov 2021 08:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-3-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-3-alx.manpages@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Nov 2021 18:16:48 +0200
Message-ID: <CAHp75Vc_Z783zBwDsUxMxoTrhYAgdFdGerh4F8kWitVdywLF0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] linux/stddef.h, linux/sizeof_field.h: Split
 sizeof_field() into a separate header
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 3:03 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Include <linux/sizeof_field.h> from <linux/stddef.h> for compatibility.

Why? What is this change supposed to solve?

-- 
With Best Regards,
Andy Shevchenko
