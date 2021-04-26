Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178F336AA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhDZC1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhDZC1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:27:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 19:26:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x20so55649535lfu.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1qgDuOhLAaHXjSPToieLq7qwnKF4PfG1eM9sUMQTOhA=;
        b=L5buu2algsgTwOy1cmshepe5VaUV/9ooABo4ukmwQHRUB4Uhw37tTU3CBH8qFtnVi6
         TyI6gdfEwVpT2OjO1biaVh2K63OPIV+BQjMiWmTuMeB5Hr3YtzgPnaqZEvpgQ9uqsHWa
         75PwAOQmqGjqQNQUAeOKhi5zP2J4dNlkDCMTBc007txu9wuuj09KdbXd2thfNsdBNWRS
         nOTi674AQXWYWEqQp5p8E+WWL873WnSL+vnOmmU8LeSp+2UBGplus3RgeCzlrTexn5Dz
         7xBD/WvHliNbOECh4HPjJwE0hbX24f64ItReok+8zUqB8RTq0Y9ODbw3Eo+ZZNVzPR0m
         N2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1qgDuOhLAaHXjSPToieLq7qwnKF4PfG1eM9sUMQTOhA=;
        b=PKYyGFbyI+vRG9dg+bVx10PjjfLGksmZuF0kEhAWwawPSOACZKkS/w+jjr7/Vh5Tei
         RlwjlSc4qSRLJFNNFD8chm8gGFwPkDkVeeYqkZyJsxbTCgrCVYsOVoD0wEW0jcJC/At0
         N/2K2Kn1lhLqqh9AECYzIGZJ8AsYplMyUq2opq3wHbWp90IqJCCjS8o0lJLZPWy3bCZi
         UIyvC546lLGh+h2T9UZzw7FmMzJMJiYFcBnpUabTqQaowlpe1jpI0znckr8sN2TdlONG
         zgtGKzBlrpIG4yv8rJrRdpAvBg3eLLXdV9slNQ2pMShILf6QHKJCANVljkj4h+6RhA0f
         p23A==
X-Gm-Message-State: AOAM5329I3pbRmGyAHScFY+T1gDzYHgAWbm+B+wdibVXQRiao+Nt7NNi
        chrPUyMhqCrz2PWq39U6yj7epfQOL9ssIKSHX4pq9ekrR2A=
X-Google-Smtp-Source: ABdhPJwR6mfChWWUxgD+86kP7XNCrZIE37vCuWpFIBvT+orO1pkUeGyzIHaZXsExBK2E4MOGBVsdvsgKBk1njRhrGU8=
X-Received: by 2002:ac2:4a87:: with SMTP id l7mr11377758lfp.586.1619404004257;
 Sun, 25 Apr 2021 19:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
In-Reply-To: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Mon, 26 Apr 2021 03:26:33 +0100
Message-ID: <CANVEwpY2WhSZ39xC-xrC6Z-KwnUt5t7HPp8HbTBwEW91H0yTYw@mail.gmail.com>
Subject: Re: Linux 5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 at 22:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Thanks to everybody who made last week very calm indeed, which just
> makes me feel much happier about the final 5.12 release.
>
> Both the shortlog (appended) and the diffstat are absolutely tiny, and
> it's mainly just a random collection of small fixes in various areas:
> arm64 devicetree files, some x86 perf event fixes (and a couple of
> tooling ones), various minor driver fixes (amd and i915 gpu fixes
> stand out, but honestly, that's not because they are big, but because
> the rest is even smaller), a couple of small reverts, and a few
> locking fixes (one kvm serialization fix, one memory ordering fix for
> rwlocks).
>

Not yet visible at https://www.kernel.org/

=C4=B8en
