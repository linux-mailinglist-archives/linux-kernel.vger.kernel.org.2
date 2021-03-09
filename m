Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27E6332BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCIQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCIQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:26:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:26:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k9so27989808lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iIF2N5mx4bqyfKzrt6mu82n0gybAtL7U97sj1YlYzw=;
        b=cAVNHnDhUfIzD4OsnlIcSq6KL5qPnoHsu3jpQLPSojCGEtw3kZTJl+8puZPkzlT9qA
         FycwkPC/KyPmGAb0l5wmWvSdSrF4vYTja2UGFFMTCadqbhx0Mb69dOo/8rDwpT9GFfJZ
         gd3QClblnKWBpuOSNbcbSSYbaOAXt2zhKXDmmwxKl0hJoGZ4mQi1ZYPsPhPhf6SucIff
         nCmtWj6O5rVdYXJRhA1UAq3aKHyjDsXa8d0TF+MuQwynqQKFhljZJC6eBkCGBsIKfc8P
         X+hfDaJO2mkH77g9fERwjFDGRe0Zvkdc5lgh0Sl5uHOWOEgDSoDEUbLWmJaftC0oxJIj
         xTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iIF2N5mx4bqyfKzrt6mu82n0gybAtL7U97sj1YlYzw=;
        b=uOZK3dj6tW3/q1XQbHAsHtpkeITuuq+OsZXfSK8893dy7dCJt1G1DJw/t6A+bVbxC6
         oKOinFGgypMZ3UVy/kV/MqzyQw3j0/bUT9BaKocbHJvZSHEbCEJXuKVcVOr7f95R4Cu9
         2QwZYZe6nRWh7g31wtoN+R3Zv9Kc18SDB3bDEObNAhV4tAty8bcdhS7sp46EvS/YGD+P
         d+kUAEG5F9GrJpTht9OL+Mx4kfrZjU+EghUYM6PX/1mexhHGbIFtB4GZxse4fuurTUV3
         lnGFNKj6QNs9bhkem9dloXioXv+hFRfOtjc52YuN44ddXDG9yFBR9ozHNPfQhXR56b0H
         uApw==
X-Gm-Message-State: AOAM532gK4hKPR6NPINLn8Qc63WuIf37neo1Q0JsebVQkVckJbUkMw62
        KKzTNply87s0HonSgAxqkoPPdyY6bxMDqpMUOm6DXQ==
X-Google-Smtp-Source: ABdhPJzD7sHTd+e6DuX7RRQuqBfPQ9+37W3GhUlEVj0TXJ+Fj7+tIi8hz+rW732d5Al78RXUEppy61DVePyLFsBQrBs=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr14776193lfo.529.1615307214450;
 Tue, 09 Mar 2021 08:26:54 -0800 (PST)
MIME-Version: 1.0
References: <202103042009.pJVKOAAK-lkp@intel.com>
In-Reply-To: <202103042009.pJVKOAAK-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Mar 2021 17:26:43 +0100
Message-ID: <CACRpkdbQz3+R8tf=UUm_2yXup1=k-KhCvWWht72D63otT_vL0A@mail.gmail.com>
Subject: Re: drivers/power/supply/z2_battery.c:93:26: warning: variable 'info'
 set but not used
To:     kernel test robot <lkp@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot,

On Thu, Mar 4, 2021 at 1:54 PM kernel test robot <lkp@intel.com> wrote:

> FYI, the error/warning still remains.

FYI I have sent a patch for this ;)
https://lore.kernel.org/linux-pm/20210305100108.2036203-1-linus.walleij@linaro.org/

Yours,
Linus Walleij
