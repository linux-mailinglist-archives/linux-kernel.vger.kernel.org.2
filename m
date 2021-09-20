Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE84116B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhITOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhITOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:20:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D2C061574;
        Mon, 20 Sep 2021 07:19:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w64-20020a9d3646000000b0054716b40005so2707097otb.4;
        Mon, 20 Sep 2021 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TGJZKePWk6V5bQ7AolMRjxyNeUDWXB62svjnYHFj36E=;
        b=iuHa0j9MGeSWOUmfIRo5yfOor70np5fxhkWf+ISAvKv/mzz0FvxosqszUoC0fmUvcZ
         6xZq6mSLoLlWoMsQ4HsGq6xiW1mDo1dhz5GOw6qN0zjQyX7laraKP3UUe/agVJqFB+sD
         DMRKABhye9J4vp2vzQfkDWO8KS0m7s5UO+sHeJGwuwnBc6ajHavxEgmKVNZQ888/RyM9
         Ps1V+XeTVk0uZ+Is/AZDvbsxjyMGShR0+JRBj6CdvxEemZfHfB3TiHqNEn7Q0vMLWmg4
         kfOQ5XPnVnhS+/0JQoXvCq5WYXyH9lR4OgO3KITXcV6UNMWyrpbxRF1nmlBP186ov58X
         e1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=TGJZKePWk6V5bQ7AolMRjxyNeUDWXB62svjnYHFj36E=;
        b=rLHkVjbyNxmLp4hXYbD9N/k2JTqH54sUgVGg5IMJqstVe1KKAKcEZ2VSgwJpYphTZ0
         Au+PNpfUUUH7F+ZhQ9CmGfFd4qRaSZpnLj20w4FDv+wkSnys3evTriraAPpyDIYicGLQ
         y3MtKKInBvsKrbNByu1fXLJuYUc3lK0817qazfqTtt98oqA5dt5KvzMVc+uzbOU5iO1r
         wjuXrsTMpikBufTyuLGhuQ/GnYez+unaSZK60o8VOl1poit36LzbQQwC4SM49opwogkX
         xHPfaTz3OGKxBFTAqhR0WrsV9BE3eaVnidWfxs5keB6gYKnsksp+04qa4mJ6ZcOeUiWJ
         rZuA==
X-Gm-Message-State: AOAM531ZaFUcIj7T7ye0HuWY/xu73C1dgRSe8jhxWVb9tLWgPXvPanfc
        Pnzs6Avp1TVPAtpjfOSn1as=
X-Google-Smtp-Source: ABdhPJxWQIKhkU+kxtKlyz0dBj+IR+CIno5/RKXKFs0insDTtKVB0tP7IHhgR5EXvAFp+hCbwxZEnw==
X-Received: by 2002:a9d:3e54:: with SMTP id h20mr4410770otg.236.1632147561267;
        Mon, 20 Sep 2021 07:19:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x28sm484462ote.24.2021.09.20.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:19:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Sep 2021 07:19:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Armin Wolf <W_Armin@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Carlos Alberto Lopez Perez <clopez@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Oechsle <setboolean@icloud.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: dell-smm-hwmon: remove unused variable warning
Message-ID: <20210920141919.GA1639673@roeck-us.net>
References: <20210920121421.93297-1-arnd@kernel.org>
 <20210920123131.6kpv3ffxvm7xeqga@pali>
 <CAK8P3a10NR5CqoTxtjyrx5g6kO-hEkhaw7psEJHSSOZM9S+JXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a10NR5CqoTxtjyrx5g6kO-hEkhaw7psEJHSSOZM9S+JXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 03:14:40PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 20, 2021 at 2:31 PM Pali Rohár <pali@kernel.org> wrote:
> > On Monday 20 September 2021 14:14:16 Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When procfs is disabled
> >
> > ... then the i8k_init_procfs function should not be called as the
> > purpose of I8K code / config option is to export functionality over
> > procfs. So when procfs is disabled then this i8k is noop.
> >
> > Patch which do not allow compilation of I8K when procfs is not enabled
> > is pending here:
> >
> > https://lore.kernel.org/linux-hwmon/20210910071921.16777-1-rdunlap@infradead.org/
> >
> > Ideally please test or review it. As you are not the first one who
> > spotted -Werror problems with i8k and tried to workaround it.
> 
> Ok, I'm now using that version in my randconfig tree, it looks sensible
> and it addresses another problem. I'll let you know if something else
> comes up with that patch applied, but I'm sure it fixes the issue
> I reported. Feel free to add
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> to Randy's patch if you like.
> 
You'd have to reply to the patch. This is in x86 world and I can not apply
it, or at least not without Ack from an x86 maintainer. They went ballistic
on me once for doing that, and I won't do it again.

Guenter
