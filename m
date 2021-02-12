Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F1319B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBLIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBLIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:24:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D91C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:24:10 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a22so10553634ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4QtRP7t8Cqt7Zt0AmnpBiTpw0QsRRYsCTiIBHf9N+0A=;
        b=rVogwN5qGXKHZw8jS8KeHozl1/d1t7cbJm5keBbB1liAdxUF4/orhzCcSoBKp3WjWG
         HqHTbQUdLkmJTkh2da/AZSLEr9BTF7I3VVPO6Jb6XPcwox6Np69iyk4PsM/6199zqAED
         jIZw5+Xj24j3inqJxZYbTSSPYg8fe/7nSgX98xUYC629YxIQNTlTTgxMxTsKqIe5hvqw
         dXm7+O3gg4o4OABeWyfzADBxDo1XUzAm96axWnwdq92npgnjux7b6NBC+i9JiRgmg0Cl
         AoVguj1asIsC6gredLH2SOyaPDTeu9+UQnZv4au1UF4IREvA1i3XqIwV6LnPQk6LQq7l
         TZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4QtRP7t8Cqt7Zt0AmnpBiTpw0QsRRYsCTiIBHf9N+0A=;
        b=J8gPVa0o8IyaP42Wp6YzXLYk3w7QZKGELDUdTkfytr84HXiErMwTHcbfV2SgT4GbGD
         xtxfI7isOLP7MvzXjbR8HJpztG4/UV+RaVh3EALzZsr8CVWJFV2Cdmt9TRZ8p54wqhTE
         5XyrGqeQvwJAGGg7fYLxVpWsziCqNQ7hWwjLbpC/yJNXYXtmSKH+Fq5WDTog0hBuqK/f
         k//23fXQ64YzCCSYN9aquxrHRNdGQSEkU+Cosg1Wgycv7krOlbNZyB2VNx0Hed7DJwAB
         j6owJHE2xWjq0jxesG5I2VOCX1nNtdzF1RSUw0uPHYmp8xFs+67jwJWhXBWm0xz+guT6
         YrAA==
X-Gm-Message-State: AOAM530WG2zx0jLMuYnC7s1PyT6RQ8DHgDefvGzUIr4CXDpSW/7LCKdO
        UCJgSpdia8dOodyeYzjOhwszmBx9BioXLJDKRq6IZw==
X-Google-Smtp-Source: ABdhPJzquUd4ZWErN3S/4cnERxh6F+nJs7jN3KlfXXxGcEQ6JrbmiYABGJcLHhMWvsSJIoytqcDddlQIcZMpRAkowWY=
X-Received: by 2002:a2e:a403:: with SMTP id p3mr1054267ljn.368.1613118248643;
 Fri, 12 Feb 2021 00:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20210130162954.918803-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210130162954.918803-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 09:23:57 +0100
Message-ID: <CACRpkda8EK+Y7mtcO3VZ2iL6fO_dNP-wzTbVSPvPL+Y0hG7g7g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: npcm7xx: Fix alignment of table header comment
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:30 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> Make it so that each column label is in the column that it is supposed
> to refer to.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied, sorry for delay.

Yours,
Linus Walleij
