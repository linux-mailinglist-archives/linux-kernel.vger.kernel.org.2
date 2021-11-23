Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279F6459BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKWFgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhKWFgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:36:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5532BC061574;
        Mon, 22 Nov 2021 21:32:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y26so87780958lfa.11;
        Mon, 22 Nov 2021 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTPYim6P0NhgC+Gnow4uqgkTn1zcac3+SOJ9CSgZULI=;
        b=MjQLcGYkCVHU+lu8PI8OvJEXpVkLsuR0Vyv+JW6Yr5eICchovppqK1RDUZ3aFNNSYm
         rpcvJiyZnop2bgEiYZm0d5QSD9X6ovRLED25pUihpFKam7rIEQJtJV9tETVEH5MGjbTs
         802qAi8JJwUSR2FQAtKxiGRjGKoppxwjTGfeKlybzv0P+rrOtwkri03xXRY/1c6ErIUH
         X3sUDTxv8l+mkpED3WLp182sU2Ch3QgJGrQAFti5hfLEzxyN2PmWrf6UmRz5Gh5RnYiB
         Eu2l4SbqE/lO+L4mhh+toKYg0ynrkIlqGEKkQkgKDPbn0CABPnEWlutc3QiD4cELAI/A
         BMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTPYim6P0NhgC+Gnow4uqgkTn1zcac3+SOJ9CSgZULI=;
        b=jJ/aw3BGR81GHSiIccSSkhwATVPug0e7ij9u2uPIace6EKdr238+5HPunaHx8jEeP6
         0F44do8D8EGUciHm9Nvp2UnAd7/Fb0q5DZYLRQrVBotN2gotxDf3+k3N9pc82q7Da9fy
         DwPf0fgQ+sIFZWEkm+P38UubOzBLgsAgWO1xjIav9lC1MqE1LwQQS4AkGmQz4ig/hE+S
         OZ3EnNPGiq9b9GX9I5fwqnEu8Fatz8AoxePcPC+VoE8rfGijfnM75K+JVGyAEhFVqfUL
         CpQ6a6BmBLtmIekxpE/BQqjCT46E9dBQQHVUf7mPDmGizdxqB9gIvJkFgg/PfqWG7kJp
         sHSw==
X-Gm-Message-State: AOAM532/gQNiBUBOI3M4FmePmJhG1rwyaDs2DeNVQBNpwzxj5oCB1WAD
        jvKyZk4iA/XNPOxJu1kz25T+1nAipTnW48cnYVY2VQ8c+Es=
X-Google-Smtp-Source: ABdhPJybAHd7boiQOLkT0ZFUfqm/bGtyU/6Esk/krGD9uX6gVaKmW3FI5ariOaV1NumaV0uq98ro5x2AQ0HdRfDIjd8=
X-Received: by 2002:a05:6512:a81:: with SMTP id m1mr2011631lfu.306.1637645576194;
 Mon, 22 Nov 2021 21:32:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+h2OgBMP8Mm+dNPuNEq=DhWdc7Y+dJEvrXz9kAUD7O2GQ@mail.gmail.com>
 <CAH8yC8nEhcAs5hE=utcUEKZ8kohOx2TWhUsbue1sdZo23uiBHw@mail.gmail.com>
In-Reply-To: <CAH8yC8nEhcAs5hE=utcUEKZ8kohOx2TWhUsbue1sdZo23uiBHw@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 23 Nov 2021 11:02:45 +0530
Message-ID: <CAHhAz+hopmWpr6Whe_=92UrdrrANaQKFmVZjcx6p+=2tWouFuw@mail.gmail.com>
Subject: Re: x86, nmi: IOCK error
To:     noloader@gmail.com
Cc:     linux-x86_64@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:44 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 11:03 PM Muni Sekhar <munisekharrms@gmail.com> wrote:
> >
> > The following message is seen on the console "NMI: IOCK error (debug
> > interrupt?) for reason 60 on CPU 0.", what does it mean?
>
> Red Hat has a good article on the subject at
> https://access.redhat.com/solutions/42261.
NMI: IOCK error (debug interrupt?) for reason 60 on CPU 0.
NMI: IOCK error (debug interrupt?) for reason 70 on CPU 0.
What's the difference between reason 60 & reason 70? I was not able to
find it in the above mentioned link.

>
> Jeff



-- 
Thanks,
Sekhar
