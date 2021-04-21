Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9993675B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbhDUXbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhDUXbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:31:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A7CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:30:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d27so12431885lfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfng25zJItPwonk/16QDahcdv3lFLWQTZdeD4FnlrPA=;
        b=EWnqJhWR9CggmWI9C3DTym+AVFW9ZM7lBo3zWt7gIyZspveSj3rM88Iopci5H0H+Js
         BpA0XwqE2yAky3TlPVTerQsJCc+dwKK1RI3qHXcXI09gXJhFk79yr/O7SK+nUtpI+s3T
         7k18Pzno9kl353SFVh63tvtgfUn9J/DLo2CfHD2e4w+NShLtQvyFSoEMv2wW8Bpozw6D
         FpyRBluu65Asvwq+iVVnEYnvXcqD0NN1herp7Imv0FgNUeBponT9ZiKqf/tmYfXwhivl
         xj3lN3pABcT9+wOsPDrQeOHMo4mdZOFzbBc6l9Nw9tg0vDQlZJPXf4BII0ikAGfzVDUo
         nTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfng25zJItPwonk/16QDahcdv3lFLWQTZdeD4FnlrPA=;
        b=AUMHTXWJidexfRoJlcwjQyiGjwmpRoAtyYNYzKAT3nWXvhlcS/PkfG4s9nSLGpRCmE
         fHpRu89Y18+q+5x1t8k/W0yfjCUz6dQbZCYpveVBxf7ZaD6dqUWPR5HpGWuojLgFHXb+
         EUbx+KaSivNdYI4G++8ACVtqFsjIlDby8AbzB8prDkVSiiMHsDhvYZPnumBAIxfZtte7
         ZbLc+PksfQ6MOCLWEmIgaa82jwX7mc+TmSl38BtgeQq3pgLj5BSn5xuyhN9v2gKYFmee
         4da2mUHBMUO7v773FEnXXA5ljHPVEuqYnCgOFOsKoaxFIgrF8PiinGrQyZa4wUPQjGFm
         P75w==
X-Gm-Message-State: AOAM532vTPYnsrtCgpjOV8SM3xRNlL3kW/CsTQAtTJz/EP99mwd+1H2j
        n3SR6iTXcsq2xvbYGNCbycCxnXYsrw/er1I5VHZomA==
X-Google-Smtp-Source: ABdhPJxrO+YEJszKy+Nh7e98l38n69FZcUU+FnTfnoB/EI3vgType9bOjpHym3j3GSUcc4RGsgOrYLsHuWhu+QzJ600=
X-Received: by 2002:a19:c38c:: with SMTP id t134mr444435lff.29.1619047828483;
 Wed, 21 Apr 2021 16:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 01:30:17 +0200
Message-ID: <CACRpkdbw_sF2FO0jjq47KStUjvhKvWRLF_sZHGpRFuB72-13zg@mail.gmail.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 3:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

>   Revert "pinctrl: axp209: Fix NULL pointer dereference after
>     allocation"

There is nothing wrong with this patch that I can see.
It's pretty trivial to inspect.

>   Revert "gpio: aspeed: fix a potential NULL pointer dereference"

I don't see the problem with this either.

There seem to be legit code coming out of umn.edu as well.
To me it seems like students getting assigned to fix random
NULL pointer dereferences, seems unfair that their first
contributions should be punished for what some researcher did.

But I would personally like to discuss the ethics of this
study with the headmaster of this university.

Yours,
Linus Walleij
