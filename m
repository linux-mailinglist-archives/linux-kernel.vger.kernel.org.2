Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6916A44089D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJ3Lr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJ3Lr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:47:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E6C061570;
        Sat, 30 Oct 2021 04:44:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j2so26387889lfg.3;
        Sat, 30 Oct 2021 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2Zff269gpFMGO4oJzwm2RkZTLLsA1HaBdPOKQxR7ig=;
        b=mRrYXbHOUsUiNTKM/TxfnpM/qFackavuXxVPk/xVYmh4lqbniwtY+xjN4nuAZ1tOUh
         04Ka7Vz2N4vkNTo2F21MQY6FHDpFcGb/9aV70z2A/Idv4qLs3hYxU9jBpxDrBg/8t4rE
         9dTl74zzzTkAoGnCn4eB1EFRVlNgoaJ9d4aevhDtfOlkt4UkqFTgAa0leSlVCpJKxgVW
         MT33vv1O50I4e6Z7Ld30HtH+dfE4aAHVWO6EKUOBX46t/0zl4ZpGPzf1BlSG7rqTS6Lq
         GLEqvC/b0XNPweBTS2UaRto8L2RlpnuR7sGrqWuhedtwOZnINHnbMvQhbf37b1nkbtDF
         c2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2Zff269gpFMGO4oJzwm2RkZTLLsA1HaBdPOKQxR7ig=;
        b=QYUBWrkePJyXQCzUOpmk0HjenIaYUASIkzX01dyranCG8fwlZzPSLR8MtAYlC13DUY
         Z2SqK60anqwGsPdnn20PTc3F9xIb+h+5T8bK5FOAIJ7K8/EkjgWA6uxVi1QwXBhDj4dy
         H8nLxnbmsR7tMFwdmBLwz4d7R66KH5x4kAcAEAxfK5vMpaAaIHtky3KAxqa+B64+YIfY
         Irm43x8CNojqHNz2/6wtkTPc+/I3qOKuW6sWV+xgRrZ1IoBmdYFfybDmzh9C948IpZuo
         weHTz7msAZUybVNYFvoON4g6+x3R9W2+3VnEjLLFjGGjLYGJ4po473YfM6+gD/Vk2Z8s
         yVtQ==
X-Gm-Message-State: AOAM531s2jMq1+EqvItV2klm3Y2lHYPBTbFcRyBRA0k753H+AujAenUW
        LP2EDfMNIE6EH0mBjEFzXxUM+MxizeXM9/m3YCs=
X-Google-Smtp-Source: ABdhPJwddF4ZU43dJdeF3PbTyMQvTGhrXqALX5yQ2mBaCnQhQ0wNJJnkPUznhx6eLMVnw67xIMSgyO1tlvrOVrcdoXs=
X-Received: by 2002:a05:6512:260e:: with SMTP id bt14mr16427171lfb.129.1635594294870;
 Sat, 30 Oct 2021 04:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211030091706.25470-1-pauk.denis@gmail.com> <CAHp75Ve_dvc-33y5U3fgN-ZTGibcyO3dO7WxC_ZaPkNSh8kd0w@mail.gmail.com>
In-Reply-To: <CAHp75Ve_dvc-33y5U3fgN-ZTGibcyO3dO7WxC_ZaPkNSh8kd0w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Oct 2021 14:44:18 +0300
Message-ID: <CAHp75VfRY6nS=YcFstW_Bt+_+Zz366vh8=mfjat4kfTOBH0e3w@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Update ASUS WMI supported boards
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 2:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Oct 30, 2021 at 12:17 PM Denis Pauk <pauk.denis@gmail.com> wrote:


> > Could you please review?
>
> I'll look at it later.

I briefly looked into it and found some subtle changes that might be
incorporated. However, I will send the full review if there will be a
new version (of the series) for sure. Let Guenter make his comment on
this first.

-- 
With Best Regards,
Andy Shevchenko
