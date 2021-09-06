Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0940173D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhIFHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhIFHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:41:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:40:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j13so8246139edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL5J+gSNutoi0Pq/uomWnaoEPs1pB+cuD1QhhYtiTCo=;
        b=BG31e0qN4YISK1734gaiUTzWuVQOxF5cY/Wv4j0DbwFi9buxEzwWmCZ62kai33yfcZ
         E4PJsIJoFA3pfY4uposkraXEdA/Uk1diAJ/Pvlh24laol7+KPKzUjs0fHYIzpAWVV8Pp
         bzg+GPgmw+7loyzxQJZdbjPg5er8OgWv1jwVnL/MiiMC9g7UxZFqmYK5DiaHKqgDK/dW
         /dUh7iyoyiWWaMRNsCttNyyu/qwG/h+zfCgi4IcNLKkymhyKKRXebhMfMWYfzANSz+RG
         sBj74gAZvN32nFNbO4Msgrqy1+RxXh3Eusg6IdZmSEZ3rs/LMPGE+QiE3zwaZZCqgbxS
         VIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL5J+gSNutoi0Pq/uomWnaoEPs1pB+cuD1QhhYtiTCo=;
        b=J/gGYhvphlDMGRXl+cbbL+BwRng80Ign09G3og33ISLVbA+ISWkNC4WaQ8oQzrXGl+
         yPGcPidHEFK4wAIinJCJmAh7iqhPVhbzjLX6QFra2fY8OHwIiYPmU2cmysv9q1BQ7XRj
         KcwEgMQa9wVUMqsKa5UqW0YY+pL+chjYQfXv5pOTlLOACGSjoTRSXNUQH82y385xVadk
         YYBjGi5WDPMb+kJT38kVvwHcJjKQAx3fr5RR2BC+HfS8QZH2bSodl0e7CUeRLooeXNkp
         s5ctd/Q4VCs0ZUgpGtY8hCD8gJekCxZ1kGzLeCy5D6AeFskK67EFrD4Rbl9WIN9Kf4Pd
         u6yg==
X-Gm-Message-State: AOAM531X9KzoVuPnSJtavsszdOesprfOH8jLHA5dIZ2CiXfNMh5fbPzZ
        w1m/6ImaGUpfepi8Dk7Z74pp4aeAEpK3k2lEaKY7VA==
X-Google-Smtp-Source: ABdhPJzF3d2u9FRcwDxgjT1qXwQsqXXf5z4QJF8uF9GyuCXwuaj7A4o1Ez5DJPmr6NQb7X9uY3XLVp7XDxFPNewNiqw=
X-Received: by 2002:aa7:dc50:: with SMTP id g16mr11971779edu.182.1630914045592;
 Mon, 06 Sep 2021 00:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com>
In-Reply-To: <YTTbD+BKRpd0g4hq@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Sep 2021 13:10:34 +0530
Message-ID: <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
Subject: Re: kernel/kexec_file.o: failed: Cannot find symbol for section 10: .text.unlikely.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sept 2021 at 20:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> > Following build errors noticed while building stable rc Linux 5.13.14
> > with gcc-11 for powerpc architecture.

<trim>
> Is this a regression?  Has this compiler ever been able to build this
> arch like this?

Yes. It is a regression with gcc-11.

stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED

- Naresh
