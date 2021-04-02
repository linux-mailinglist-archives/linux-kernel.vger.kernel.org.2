Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88689352F47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhDBSa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhDBSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:30:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:30:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 185so359548ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fd4bMjqdJVQY7WdvNzf537+kyv6aKgG3pUKdkj2W0jg=;
        b=lS7xhv6mEzmWu7RcqImAJ+niLv96E8/IxTKjh397sB+imF1G18bxi7d3hfYIUMYwj6
         FTTjp8Vn+Lz2YB/GLFFfAmRT4zfaWXfJNHm3sWQ4NYCL9i0+Mwm0RcEDszUii0II2/Wp
         nX8xZSNi4rVJW6daqtiDy5qGjGmwY9oXzWlt5zmD35cyw0dQMLdc3HH+yRB/OIdOEl41
         X5OQZDdGjvvR7gJs3TuLikVZbhnlEmUvTlcNH+1hfQECGJWa/AlFYnuOFvzx3a06AwIR
         s5q1Cf2G8hbRCLDC6kuNjPMOq1qLlcQERQkZQ2rMVbAxBq19uf+6DcbnJ4TSg91+2EYD
         k9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fd4bMjqdJVQY7WdvNzf537+kyv6aKgG3pUKdkj2W0jg=;
        b=lVV318jo7nAdf0+6uqUPcRduUAHeDM5GMWUDeteosdcjMaKe0L7k5PT+WA88qAz7NT
         NOjZLaYjXJEB52fkT20t9jj95CmiYR3SGar6PBKh0OyaLwG6lhiyjwZJ2xelcNuFTty7
         HjNY+Z/LS8atOwzo7IKhNLliStJt0TVlKaAOSm2Oudm8E/VZSKBag0TpwVVpHqU3xmV6
         Svlqb3fmR7q+I5uDa5xiIilcqOGhusONVvj86RLAjnCcXQU312bxgTgRrqSEWZLzwBPv
         wJ+JL5FRc6T1G5n3thz2N11ZwfpeEaXZrGucYfjzJUsSrDX3eJJtT9lBL3a3Ek0CIgFg
         r8kA==
X-Gm-Message-State: AOAM533l3msEdpD9GYi9ufv0f68e86aNO41W6wjDTufNGj/VCBAkiKfy
        UvGl4LkiG8ibIgZ++QGed7jjn4mS4Lr9mMOt8QVfZO/L
X-Google-Smtp-Source: ABdhPJyYIGoFDj41JOGFosnpJFgBwrP4/PPcpwXN4ggNPPjnZNICXAnXy9CZldDxQxvVgRCFVhYJU/SnkatZSjN1DR8=
X-Received: by 2002:a25:4c89:: with SMTP id z131mr21406764yba.40.1617388209192;
 Fri, 02 Apr 2021 11:30:09 -0700 (PDT)
MIME-Version: 1.0
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Fri, 2 Apr 2021 19:29:32 +0100
Message-ID: <CAAMvbhGzj3mTbNoLf55ZF5hdEFwRg5xj1J+g5jP-BW+Hn9kn=Q@mail.gmail.com>
Subject: Compiling Linux kernel into a build directory
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, when one builds the linux kernel, it places .o files all
over the source code tree.
Is there a way to have the linux kernel build, but place all the .o
files into a separate build folder?
Similar to how cmake or ninja work when building C source code.

One possible advantage of this approach is one can then put the build
folder on a ram disk / tmpfs   and be able to compile and test much
quicker.

Kind Regards

James
