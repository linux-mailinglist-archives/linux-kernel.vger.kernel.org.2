Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2E364537
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbhDSNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbhDSNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:41:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:40:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u15so9163497plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEYzb8rRhegA9r1XKxsspQ9rFJwcyg5L2UyEin8OE4c=;
        b=ItJ0Wr2Brx0XkXV8dYQOcWQxMHetwGHfb/5o+qpiB7SF+7lm2x3vL4V6R4fTMh23yQ
         62s+l5tK871iHS9uUOwkoi+kQ8qbyNvnd5rTw33FZensKVWia7yCBBsFryePIydDcq4N
         XwLg/ka9XmJ0h4JZj4AZnlVbT5I6LB5JgLNcAG5xlqIWrPA7Zckg5F6SC/3KzISv7meZ
         IdGU1aK5kTjU1QQdZcLMXfmwmprKhr8eZvCi8QTRnsCaiYgiLur1Rg0DV+m9WJB0mk1c
         hHwEVcKl4IgllOv8UxVkL48vKyDopRblpoEjhRwSL5nO4XqqyS+8WqC9YOHnzpqic/JR
         iwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEYzb8rRhegA9r1XKxsspQ9rFJwcyg5L2UyEin8OE4c=;
        b=DCrd1d6iCSYcmBoUKFZMCFJCdu2btXrL2UcOQjEs5i4FtoEHxdIIrU9ZXfyFeGICms
         kZtsIKI2RP+aezeo0WKOfSleNEU9ZA2bJdA7BoYMCsybJG2qsOu+xDl9luIiR1IY3f2R
         o+b+xqQWmV7zxrDATvgOJAeJXUMcO9xyTLjnPaMSwOcoIml7zeKmjVdMFSJxY+KuEkkk
         hCtBiQKChuj8fNNYG5YrN1uHqhCC0MK8vegcDVAkOxmXXXkczguj3Q9vfCnkbxkHhLpB
         wTLi2B8xQd+lKi7MVzV7/LC78AYwxK8XAuBVaZjDp4h5fLSh+V9Q3lTdDdprYx5tv+Qh
         Ck7Q==
X-Gm-Message-State: AOAM5328Qj0lk/l3QbQC6FLUdJcAFCTxMJqBYO4dflF3gb0Oe+Gphm2F
        jIASu8/GQYTcJqhsL92NnlN3arMRvUzJcEJNdFD4Z2P5a07AMA==
X-Google-Smtp-Source: ABdhPJz0DPVCcVLsadbFWTJj28lAVt+mUe3Ff/ZXctWAIE0MJVpgqJliEszlhkteMQ43494J9NQJSM9aXGgFox7Tg6U=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr22979199plq.17.1618839645839; Mon, 19
 Apr 2021 06:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
 <YH1xHDbFyJ1URYYV@smile.fi.intel.com> <CAHUa44GqTNoLbwfqPrWFVLV3=M2d-2hE1uDY=CHpCcZgzMu5Og@mail.gmail.com>
In-Reply-To: <CAHUa44GqTNoLbwfqPrWFVLV3=M2d-2hE1uDY=CHpCcZgzMu5Og@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Apr 2021 16:40:29 +0300
Message-ID: <CAHp75VeP9eXyrpuWpb9smuLUCBmocwfzA1p4NXPNyNfP0i3ngw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 4:30 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Mon, Apr 19, 2021 at 2:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> > > On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Thanks for review, my answer below.
> >
> > > >                 struct optee_msg_param_tmem tmem;
> > > >                 struct optee_msg_param_rmem rmem;
> > > >                 struct optee_msg_param_value value;
> > > > +               uuid_t uuid;
> > >
> > > It's nice to get rid of the cast above, but I'm not that keen on the
> > > change in this struct. This file defines the ABI towards Secure world
> > > and adding dependencies on external complex types is a larger problem
> > > than the cast above in my opinion.
> >
> > I understand.
> >
> > So, the cast is simply wrong there. Can you add a comment above that cast to
> > explain that and make it is marked as FIXME? Because there is no guarantee that
> > internal Linux types can be 1:1 mapped to the ABI of something.
>
> We might as well fix it directly instead. How about storing the
> intermediate result in a proper uuid_t and then export it as:
> export_uuid((u8 *)&msg_arg->params[1].u.uuid, &myuuid);

Still a casting here.
With u64 members you have a (potential) endianness issue (consider
BE-32 platform). Also you never know that a b c translates properly to
byte array.

I would rather see a custom function

optee_import_uuid(param, uuid_t *uuid)
{
  u8 uuid_raw[UUID_SIZE];

  put_unaligned_le64(&uuid_raw[0], param.a); // not sure about endianness
  put_unaligned_le64(&uuid_raw[0], param.b); // ditto

  import_uuid();
}

> > What you need, perhaps, is a middle layer function that will copy u64 data
> > to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
> > variants are not in use?
>
> Does it make any difference? The file isn't shared with user space and
> I need to sync the file manually anyway since OP-TEE doesn't have the
> same include files.

Yes. It gives a hint that these are ABI (that's why I felt free to add
a member to the union. I have no idea that's an ABI). Optionally a
comment suggesting that.

Besides the above mentioned issues.

-- 
With Best Regards,
Andy Shevchenko
