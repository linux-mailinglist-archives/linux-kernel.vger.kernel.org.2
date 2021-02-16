Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB831D201
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBPVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:23:12 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF199C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:22:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z68so7113081pgz.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=jaSQPIArooOmOh1NjkVrVfJQ89EqRvkI0359nRutXv4=;
        b=wYjqab4zwpFSBl7MN0fvi0pc/uOQVyYlEmcVoccc8ME7573HvwcVA04uVzAeQ6RI7F
         dmtLneYUq3stkkCiih2y0Fj1J0B3rQyUHQpuFrW/JWC/hqYwTuJxlwuJVr6HqGewVMeg
         NyiUYMYNhywr8fl1r0Zm5kk5a4Be7BqtIUNgP87h5ihJKyb73W++wYg+zWoO7gdGBn0j
         bldsYGcfM8Le1GJqyuAMB+EysFrPEwQ1VzYwM6S+mfRw90ARrnNROJI0ZXeT1mGiRblx
         3mZxjyQUnhaMe/HyE58T7mBF0NwN38CZzu8p0RnsD4wkh6oUQRYi+poo4IgpjwkyQbei
         5pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=jaSQPIArooOmOh1NjkVrVfJQ89EqRvkI0359nRutXv4=;
        b=RUfTQ0EK6/SwZUfgOOz9nOiz2nRuEGBKHReK9i8wzdIif4/AMxC+DXQH1M39UIwc7R
         evXPFCCOhgZwGC7QqzcXCqAwmyK0OoUelZrDaWblJ+U10oRr0I1bLxwlcgmeW3S4R3wa
         jvfBYNij2EAzPFuWUUN7nD5+Gig+X/ngRPEO2CYnKmEeHVoQLqqjqY1t+PtefKD8NVJi
         NfYtjRWJJaWxbEF7inpPvQQ0A5oKKtztAhv+jTua/i1jrc7uL4Bp3rLwRKD8u2WF37rH
         zsPSX+16KvgbIOavYAiWrgDajYKO8Ll0HUVFhN/iJ4tH56HtTRV4NdcMxE+xnPkDVU1u
         9Pzg==
X-Gm-Message-State: AOAM530GmuzbjyaxfDX3R5W2ycTPqx5ENZUCBZTuWFruNyi8OdVfnq5n
        nPu9mMf52hg2vMr+BYWap8EMohv50NvO/f+pPQk=
X-Google-Smtp-Source: ABdhPJwjWcun9DmBgXoxCpYswxoygWwO660hz1l3ojEXGPDha454r1PDh1I/nufSz82GV13WdgYZ3g==
X-Received: by 2002:a65:6207:: with SMTP id d7mr21629630pgv.92.1613510551328;
        Tue, 16 Feb 2021 13:22:31 -0800 (PST)
Received: from [192.168.72.184] (157-131-244-194.fiber.dynamic.sonic.net. [157.131.244.194])
        by smtp.gmail.com with ESMTPSA id b18sm23024720pfi.173.2021.02.16.13.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 13:22:30 -0800 (PST)
Message-ID: <1613510437.3853.20.camel@chimera>
Subject: Re: [PATCH 1/4] add generic builtin command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, xe-linux-external@cisco.com,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Walker <danielwa@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20210216184247.Horde.If3nEUb5zLh4eU_4qXZCAw1@messagerie.c-s.fr>
References: <20190319232448.45964-2-danielwa@cisco.com>
         <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
         <20190320232328.3bijcxek2yg43a25@zorba>
         <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
         <20190321151308.yt6uc3mxgppm5zko@zorba>
         <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
         <1613417521.3853.5.camel@chimera>
         <20210216184247.Horde.If3nEUb5zLh4eU_4qXZCAw1@messagerie.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 16 Feb 2021 13:20:37 -0800
Mime-Version: 1.0
X-Mailer: Evolution 3.10.4-0ubuntu2 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 18:42 +0100, Christophe Leroy wrote:
> I'd suggest also to find the good arguments to convince us that this  
> series has a real added value, not just "cisco use it in its kernels  
> so it is good".

Well, IIRC, this series was endorsed by the device tree maintainers as
the preferred alternative to this:

https://lore.kernel.org/linux-devicetree/1565020400-25679-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us/T/#u

The now-defunct patchwork.linux-mips.org link in that thread pointed to:

https://lore.kernel.org/linux-mips/1510796793.16864.25.camel@chimera/T/#u

When running modern kernels from ancient vendor bootloaders, it is
sometimes necessary to pick and choose bits and pieces of the info they
pass without taking it verbatim.

