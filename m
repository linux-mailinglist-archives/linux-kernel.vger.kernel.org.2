Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4E392612
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE0EWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:22:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93480C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:21:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gb17so5847551ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VPPRGPjOyChIkhR0J9gnJ7DQP2c3WSK8D4NHGeL7Des=;
        b=PW1P2fETjHG60TpBt5kzEOMNchLmG/CNxl0oSEPVjxMYrWikWHnzfxZBzkfANRB5dM
         5mYe8cM7wN/vak0Y5p+FnQqn7bxYOVQ/0ElZlUDNqsM/1MMOG4zGM6KgoPsNBLg/R/W5
         sQLuYC+Mv9zCCpTxogXnLfQx1lYbUpKTrvTNFxjLy6RCY9shKT7sah3mSR76PnlboCh3
         9fp3BvBK07bMIWH5D2wKV2ReKRVlWNg258mS7EO2JMPh20JbCvj9aDQty54qbUeqZfaX
         rxzC9BVjnoKGCKApX3fBKVUc4CzPN0xUP4umCe7J82txrzcjaxAQYN4K5/r3PoxhC0lQ
         bGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VPPRGPjOyChIkhR0J9gnJ7DQP2c3WSK8D4NHGeL7Des=;
        b=qlb7YJNDwwcVCRqtrmvIzmK2PybHWFZQ5SYuPh2+p83TFnhqhIHvc1TDK+rFlloVx4
         t7Qlx/6uWMqgM32LoVqO8/GwzI4ebTTZsAc4iTosHXzgWCKxYoX7Yzx5kOJvAU5vtjok
         7TYULG/EIMaTeaNmFGDJhoKPazxLES4l7Wpm/EZ9ENcnhLOJ1tWZbI/aR7Ho4PSRTGw5
         XhQgPM/VKMVMytuDEMQjSrGmiL0smhCsnoUFBHL62DJ722q6wPAAeUAbIJbfa4v/VSo+
         vK0aDOvJHxoNP+5JE5xtd3vTQ/8eGMXik0GfGBb1BrFtwspnWBxLCVBHELWC3Dy0eIY7
         VOOQ==
X-Gm-Message-State: AOAM533RZ8m6r6OmISmvt8V7NN0TYU981SUjyjMUZbVtsZBs6PzMmSTe
        EQtFJIgHA0BDszjifIdEsbYqJfgpwznY5otZn8rizxN1OjbqDg==
X-Google-Smtp-Source: ABdhPJwRMw9PRlqlpvO64OkdmeX5yWSzgGIcEtdA/B7Z3LwPUmJeWCIE4CIufEE3Ul+Fed/U48OS6EkZ2TiQRcnb3rU=
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr1685720ejb.160.1622089279164;
 Wed, 26 May 2021 21:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWYOE5vW=Q4wP74vV-TkrZUDFZxLn5OACX4jUC2ysEACQ@mail.gmail.com>
 <YK8dUDlYrq/RRzo7@kroah.com>
In-Reply-To: <YK8dUDlYrq/RRzo7@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 27 May 2021 12:20:53 +0800
Message-ID: <CAD-N9QXxX2Zgg9t7m5GfTq6-qFU1PeVfrwd-AQ90eFRRSpVmOA@mail.gmail.com>
Subject: Re: Suggestion on how to fix "memory leak in snd_ctl_led_register"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:17 PM Greg KH <gregkh@linuxfoundation.org> wrote=
:
>
> On Thu, May 27, 2021 at 10:49:22AM +0800, =E6=85=95=E5=86=AC=E4=BA=AE wro=
te:
> > Hi kernel developers,
> >
> > The root cause of "memory leak in snd_ctl_led_register" [1] is
> > unbalanced refcount operations in the device_add function [2]. This
> > refcount issue causes struct device_private allocated in
> > device_private_init unable to be deallocated, leading to memory leak.
> > The details are as follows:
>
> <snip>
>
> Great, can you just send a patch to us to resolve the issue?  That's the
> easiest way to resolve all of this.

As I said in the last, I think up some fixes, but they are not working
in my local testing. So I have no idea how to fix this bug. Then I ask
for help.

>
> thanks,
>
> greg k-h
