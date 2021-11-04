Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0174B444DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhKDEVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhKDEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:21:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E1C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 21:18:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v23so7374881ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 21:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90++hVL9ksldtHiu9rwvekCenPGcU9OqcBPl5dZt7as=;
        b=eZot60q+nad9YtjcjnPXRTfV8JNqaKl5KHVlr0uAk1mmT49CsV8ecATGG4ZidkpmM3
         pa6z25Z1oCnrk3nMzjXbxoC6MSI3hxq6rq6vXZX1TiB9ntHffkcWMIIXqioPW7EEvwDN
         GxmqSVVJ+hoCX1gCLfow5fGKoChJGcH2sP4PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90++hVL9ksldtHiu9rwvekCenPGcU9OqcBPl5dZt7as=;
        b=2AT5xki6H2lLx+tSxdCZ0Eu/Rk3tdRYh/g0McnRy7vgqMCxqnFoVuLt0O5r6gUahDS
         SL748QydvbL+4uvmO3MBP0AMn9gSVdl/nur4eaYkKc1VRLC194yceI/5hTjiOxZZvTGZ
         upGfRvbA3pwhDkqWpTZ6SDfzvUfawIg9feukAWj4Pe1VpJ+3u2pkfoPn76CLV6pWnjZM
         CkvyLK+NHUXEWyJUh7vFFRXDeP+WtqSVNjtca4NJP05RcmAwPVrspQoF2hSnyGIWGc1C
         6E8i+wgAGH7/haszBE4gtKkJL600EV703naznA/VuSXkD05FqdwrRmV+DWo3KWu5EzIF
         +D8A==
X-Gm-Message-State: AOAM532q76gZyrNJCEM+1jf8btgOMYwJYfZFnXHdHrDHJB3kjLpD4jW3
        7K7hyuptcgkm/I6C0oNOExG/z6/i2MeSpW6J
X-Google-Smtp-Source: ABdhPJyfKYdj+S2z1XJXUPqCJaX/ojvsl69h/nIoIKtWbH/4NPqBRhCXth/IpwHqIghHyrht+qboVQ==
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr21667848ljp.346.1635999511900;
        Wed, 03 Nov 2021 21:18:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w6sm373724ljj.11.2021.11.03.21.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 21:18:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bi35so9376150lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 21:18:30 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr45032464lfc.173.1635999510361;
 Wed, 03 Nov 2021 21:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211104031554.GA34798@roeck-us.net>
In-Reply-To: <20211104031554.GA34798@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 21:18:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
Message-ID: <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
Subject: Re: parisc build failures in mainline kernel
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ab27e005cfeed125"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ab27e005cfeed125
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 3, 2021 at 8:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> the mainline kernel fails to build almost all 'parisc' images.

All with CONFIG_SMP?

Does this silly patch fix it?

                 Linus

--000000000000ab27e005cfeed125
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kvkfue9u0>
X-Attachment-Id: f_kvkfue9u0

IGFyY2gvcGFyaXNjL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmggfCAzICsrKwogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvcGFyaXNjL2luY2x1ZGUv
YXNtL3RocmVhZF9pbmZvLmggYi9hcmNoL3BhcmlzYy9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5o
CmluZGV4IDc1NjU3YzJjNTRlMS4uMWE1ODc5NWY3ODVjIDEwMDY0NAotLS0gYS9hcmNoL3Bhcmlz
Yy9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oCisrKyBiL2FyY2gvcGFyaXNjL2luY2x1ZGUvYXNt
L3RocmVhZF9pbmZvLmgKQEAgLTksNiArOSw5IEBACiBzdHJ1Y3QgdGhyZWFkX2luZm8gewogCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7CQkvKiB0aHJlYWRfaW5mbyBmbGFncyAoc2VlIFRJRl8qKSAqLwog
CWludCBwcmVlbXB0X2NvdW50OwkJLyogMD1wcmVtcHRhYmxlLCA8MD1CVUc7IHdpbGwgYWxzbyBz
ZXJ2ZSBhcyBiaC1jb3VudGVyICovCisjaWZkZWYgQ09ORklHX1NNUAorCXVuc2lnbmVkIGludCBj
cHU7CisjZW5kaWYKIH07CiAKICNkZWZpbmUgSU5JVF9USFJFQURfSU5GTyh0c2spCQkJXAo=
--000000000000ab27e005cfeed125--
