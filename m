Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08603DF6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHCVbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHCVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:31:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C86C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 14:30:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso693447pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeHhmx+FAz/5ouf0YpyrntAjVgK2gKrqpbN/zAg27HE=;
        b=fjSe3F2qrx1TGv5VEip+qYQzXXAGpknJOMPC3/OL7SJzuJJ5m9raRYwXMzbsbpy6WU
         6Y82sSlRr/1MjOAywL1Df5E0jEJ4vsvbk5Jc8eWui3ptGuXdTvHpcpsq6Z+XvGacRX+z
         Uq8pHEUbT8L+VgoTethbQdvpOcTsv3wywPlzWGVEdu6IyVtM9v4ZyGRvrKOzMPA4M66b
         H6Oi/PUf9bg7xNpbzJoExDBMkaZmvgfb/QcL5bQpwt/S6XgiQ3z9TAkEpimG9Dkev4fJ
         4W70IDkgHZAn+gjcdIS/VJGH8hbe0ybdaVRoYGTei0NI1rxmswA+CSr7TfgSXXakli15
         hicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeHhmx+FAz/5ouf0YpyrntAjVgK2gKrqpbN/zAg27HE=;
        b=NMWdqIx3t+uJTHr9GRNmBohWI4MoUh2MZZ0Z4BhT/5Od2oVQMJDbSm3v6t0OI0Z+S8
         4+d2QqEVDYJ6D4RFkbXA3nXOeVBuj+S1+13oViIw4UGzWwue03Jh2RWkL3uaIRyd53Eu
         w2YuW3A8whneg4Ql0Og8ydsrC/Lrw8FjZFxEvVf4WpULhRuWfuz1pm+TSHQs6jusRcuv
         kRYT2y+SHrlEdl5Hm3QPUZitIsM7TT6x4lb+7bwLD3SzNYU5LjOh8i5HLINWeuUFwN88
         nznKT3HeWEiZ7QDUMmR0CuZjWWznNkspMyLVZrCdl/gfpxkjM3CjKWJY/XzRyR4EA727
         Fz1A==
X-Gm-Message-State: AOAM533pY3Cy4jO9EhdHD/3rZ66n3pYib2+aEtiZAUdg16ygpWRutS4Y
        VwcDl94Rqrw7AGifCDql8Gcqi8bOAh8FOPbAybg=
X-Google-Smtp-Source: ABdhPJwUumMyiRgGkQhoH/+dzwb09iRz4uQvExPjkmZOh1S6u60WHH3jt9qplIIrsO4LKBUBJJWf6wJeepB9TUn++I4=
X-Received: by 2002:a17:90a:3801:: with SMTP id w1mr6263004pjb.57.1628026254591;
 Tue, 03 Aug 2021 14:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-17-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-17-bigeasy@linutronix.de>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Tue, 3 Aug 2021 16:30:43 -0500
Message-ID: <CAPp3RGqH-PqA7=yGs9L3_HoC77juHFKuvMgrO7EOV51aAN=ybA@mail.gmail.com>
Subject: Re: [PATCH 16/38] sgi-xpc: Replace deprecated CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Robin Holt <robinmholt@gmail.com
