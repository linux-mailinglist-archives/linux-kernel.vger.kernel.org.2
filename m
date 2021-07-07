Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDF3BE7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhGGMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:19:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC9C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 05:16:25 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id r24so1452498vsg.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcULV9nFUzJ6VE4UOSE6+AO7aub6Ej+zIlilMsA1Uis=;
        b=jhUlZlyOD7w3n/+E4dx3TqrzUR0gh7Gi2lLi1ZJgCOFLelfm06OZnPqnyXdpEU9NuD
         RyR7xOjqgd+Xm6tGjgNZkEBR4pWBL1M509HC8XlSvOGwsF9iV2tm1v1ZFA6MnElGb3Yg
         nbM3fNb6DCzJ4rmfNdCvUH8fv1tywDE3liKeSCuBrvsXf0B3QrNK5gqaOISZjvIc4Ibq
         feJn4sTSLmasqt3VrAExj+c0evPocqAiY0VS/sUQgspvkatuWSPqhcF1h0OETSz7ZlUN
         VCGLiyEthb4+ZL3oGmV2RCTiEFuKuzN/g/VYphdZCQmdWfSvyn5X2vVc1W3yktKL89Ee
         l46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcULV9nFUzJ6VE4UOSE6+AO7aub6Ej+zIlilMsA1Uis=;
        b=VGURCTj0e+vIfXuJMoHphhVlTk81zd+Rx/5TRdLFymxU8eRIlvqqVpaRQFBHJWZiI0
         VOMYVnAO9hN9Shh9MFT5bCufrICekqcp2iMZzPAcFupPsx3ZKCec39R8cQd6Ox57eMCy
         Fp3fy6ReV54bibbkiZNbjyfYeTePRdmHvaWdxZoG/MZyUe6yvqezvYe8zfH6t3kZjyLI
         N+KIuagY0CFBkusOrAf+mOpzWDwB4lKb1xP9LCvfDcvwq/XEIBIz89XAu8jhViHRkI+x
         0jWozFK7e8tN/ZGSqTBpTX4Pp8E/f0ferYDBUCHmoy6/K6h7pEpEYUGtRA+JXSFG9DU7
         19FA==
X-Gm-Message-State: AOAM530nqjkgZxl/sXPT4cds9qxfRW7LV0HKrX2fpZCSE7Q8AtDa7MLY
        7HuAZ6MjUizuoiqruqwW3UojYu3PmC6XZs/XBAkE8A==
X-Google-Smtp-Source: ABdhPJy77x2tBcGCq8Q6oAL1MVSmzYjseWE26iYZOCxrnUe0k68kKvnyjRMHnfAvxsJ34cbTsj2yxmC8WZ9xWQKK9Ck=
X-Received: by 2002:a67:8783:: with SMTP id j125mr20525975vsd.42.1625660184210;
 Wed, 07 Jul 2021 05:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com> <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
In-Reply-To: <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Jul 2021 14:15:47 +0200
Message-ID: <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>
> Thanks, I understand what you mean.
>
> I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
> drivers/mmc/host folder, and found that in some SD/MMC host controller
> driver codes such as alcor.c, cavium.c, ...etc, there are also
> behaviors for monitoring the request in their driver. What's the
> difference between theirs and ours?

Those checks are there to allow the HWs to be supported properly.

>
> And if the code that monitors the requstes does not belong the driver,
> where should I implement the code and how to add some functions only
> for GL9763e in that place, in your opinion?

Honestly, I am not sure what suits your use case best.

So far we have used runtime PM with a default auto suspend timeout, in
combination with dev PM Qos. In other words, run as fast as possible
to complete the requests in the queue then go back to idle and enter a
low power state. Clearly, that seems not to be sufficient for your use
case, sorry.

Kind regards
Uffe
