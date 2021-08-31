Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15103FC93E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhHaOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhHaOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:01:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22047C0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:00:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u14so38842243ejf.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vRGPL2VV0o0ofi1MfhnuV5PKCRKMFsjdi8ZYFs81Rbo=;
        b=TFUmVVnvAGbEyOtfIM5WS0pGceGbjylSZdrAYoM4kkWEqFDQ6PCg1u/t88NaO8M5ej
         m5hQkCSJQR886X1TdmNECS4DM/nPNz6TOY0aA9sfVE9T0Nxww1tVbd/+xmckkUzaGWH7
         2GjMY260nBKw8WpBPnQe7oyLeLd1260wjhi095cfN0X/dFzxiz7WtJEAfYOj9ZL2gKB4
         s4873MuRPe7EQAwv1eLcV9y93F1wXbozwKeYsWsBIyE7O4ESJTrspA5eUQBBONuY4WTj
         ohyVkdwAKjkN4ce7FtDpv/fFP+KdtGcAWPVnkm+QRj0ya7P7q6od9rz0Nu05m/71haaY
         McyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vRGPL2VV0o0ofi1MfhnuV5PKCRKMFsjdi8ZYFs81Rbo=;
        b=GkrZv64zwd05WEo5pfoKHomEPsne1MpGizLirkZH2FyGVaxTuufXRhuBk0faN9UFOM
         KzZsvFWaVL3rH0dFIdeh2T+gOhy04KH6+0k3QAFR+x1JVIuMUUnqp5dGR4lUBRxBFWUZ
         k7uYdKGLUZk/p2S7tCgx5SxpbxAJ5nbrS1o1tKSx7u2zHc+i9kEp9iJPdnfJum3HhYLp
         oHSufDn5uxiw3CuqRlH2ORwbtOUnuxMZISCzp1Av/FpYJKRu7W0dimN32/YtWdxAGVIw
         n6xCmaknILAXGcG47vYtkHyBBQdPqR/jS8Q4uhG7YLCtM57tZ5ao9uJwNkIc/Oa1VjWd
         ymuQ==
X-Gm-Message-State: AOAM531tb23QMxpKElBxnGDGsRN4ixI0HlQcVKzarT6UY4aGFEhj+ptQ
        oOSVVkwUNB6Tiybc89nGtsY=
X-Google-Smtp-Source: ABdhPJwaiCI5jhXKCGrECvcCcBYeMyn6JYflAyIN8g+vpECD4nNbTdOPiaHImxWgEUF7dcChGGVpow==
X-Received: by 2002:a17:907:2492:: with SMTP id zg18mr30707319ejb.233.1630418407083;
        Tue, 31 Aug 2021 07:00:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id g9sm8321266ejo.60.2021.08.31.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:00:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Krish Jain <krishjain02939@gmail.com>,
        Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Declare the file_operations struct as const
Date:   Tue, 31 Aug 2021 16:00:05 +0200
Message-ID: <13366651.n50aozgL3V@localhost.localdomain>
In-Reply-To: <20210831133533.6aayzjghdakrhy56@h510>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com> <20210831133533.6aayzjghdakrhy56@h510>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 31, 2021 3:35:51 PM CEST Bryan Brattlof wrote:
> On this day, August 31, 2021, thus sayeth Krish Jain:
> > Hi, could someone help with this? Still stuck. Maybe someone else has
> > some insight into this issue too? Or Greg or Bryan.
> >
> > Thanks

> [...]

> If anyone else wants to jump in here, feel free.
> ~Bryan

Hi Bryan,

No, I don't want to jump in here because you already did everything that 
would be conceivable to do.

I just want to *really* thank you for the hard work you got involved and that 
you carried out with one of the highest levels of professionalism (and 
patience :)) very few of us could ever equal (not I, for sure).

I thank you also not for the technical hints you gave to Krish, instead for 
your your choice "to not rob [you] Krish the opportunity to learn".

Actually I was tempted to write something like "first do this, than that, and 
finally run this tool". But I was able to desist, by learning from you how 
people should be helped for real.

Most of us here should learn by your attitude.

Thanks again, seriously.

Regards,

Fabio



