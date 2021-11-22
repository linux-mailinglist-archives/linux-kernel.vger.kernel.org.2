Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D9459607
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhKVU1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhKVU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:27:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:24:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so82076978edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3WZ0Qj4q+RYV0nm2GyZtHQb4u72VKp4+ZBrVzMs47Q=;
        b=bNtnNf5V/e3L2dzeLYd8um1MXrTQnV63nZbog5PSPcyE6+uY/BANjAOWc8poUDfw/R
         ofBZRMCQZUEPew6xeUDbpnofq9JUfeWxK3ZFn3FE3rXFb7JCL8TGP20V8V0LGIIb3CVH
         LZJcwaCeLSK/yVZpOCTnpyILgs6mXTic+bev4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3WZ0Qj4q+RYV0nm2GyZtHQb4u72VKp4+ZBrVzMs47Q=;
        b=e2hV6hMwn8mh/OXxg/azA3dVo1v3P8hHfucEnvhLi12xuVK9DUfqtrxCeeu6JTtk5U
         gVmyVnTVEHzGHDeBxfZ3s2zrVnl8zJ7aAseeKVKoLNkllNoT7vMx477kk58t2GzU4MQ5
         4vT3TmuQimyOFtvBNaKXzdzOXwYDnJnYcfhZmzDGXi/H7XopNelkMYvb3NlweF6ugn1U
         TrdFbwveZEH3CzoVgDdDlwGT8NPgGX+clXukk3WcVQuC9IP7CTwp8yiPueLfjBC+Nlo+
         gW/fOIZLUKxyK3dhx3Hxc3vBbh0f8rlmraJYp9rY7zxemECT6P0w77s1JLBPriaJBVvW
         C3IQ==
X-Gm-Message-State: AOAM533OSngsL9jx7LhKdUqVeB+wGGajaZm9D2u/WtTO/cBVwvanFKjM
        3g4lIbBfIa3cTz4JGVMjfZTMFMmqEDEorSee
X-Google-Smtp-Source: ABdhPJzrNcJzhXyjo12z057PsrYChtQPKvcJul1VMRAccN1HdsN8sO2yvxYyJc6DQwEhj+ChLClHHQ==
X-Received: by 2002:a50:f18a:: with SMTP id x10mr70089459edl.193.1637612639042;
        Mon, 22 Nov 2021 12:23:59 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id aq14sm3898059ejc.23.2021.11.22.12.23.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 12:23:58 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id c4so34882905wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:23:58 -0800 (PST)
X-Received: by 2002:adf:d082:: with SMTP id y2mr41030841wrh.214.1637612638214;
 Mon, 22 Nov 2021 12:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20211122201352.1754061-1-linux@roeck-us.net>
In-Reply-To: <20211122201352.1754061-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Nov 2021 12:23:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUajzA9rDmxGzH209bQ_VGz3RfOgb85BYkBDSEM1HpPg@mail.gmail.com>
Message-ID: <CAHk-=wjUajzA9rDmxGzH209bQ_VGz3RfOgb85BYkBDSEM1HpPg@mail.gmail.com>
Subject: Re: [PATCH] fs: ntfs: Mark NTFS_RW as BROKEN for PPC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 12:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The Kconfig language does not support "depends on XXX if YYY",
> so this is the next best choice.

Ugh. This is hard to read, and it will get much worse if we then end
up making the conditional more complicated if we actually want to
introduce some page size logic..

>  config NTFS_RW
>         bool "NTFS write support"
> +       depends on BROKEN || !PPC
>         depends on NTFS_FS
>         help
>           This enables the partial, but safe, write support in the NTFS driver.

How about we do a

  config DISABLE_NTFS_RW
        bool
        default y if PPC

and then in NTFS_RW we just do

        depends on !DISABLE_NTFS_RW

which at least makes each case easy, and makes it much clearer if we
extend that DISABLE_NTFS_RW condition later.

                 Linus
