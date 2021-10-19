Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8F433C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhJSQhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhJSQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:37:51 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE7C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:35:38 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id l39so10635135vkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcpunpJfD02BVk7gvPKYSvVCpndtXyJiwVOsvlKcqZI=;
        b=BdQ2OzL6SWeWZ9lnMcxZWN5DaQ/d8jf2h45OJs9cH+GlYlrjJIzPQv/DepQEx0AVuv
         GWiTPlZoXqr7Cy5NtlV+3wWBgyR+jVTfzAaFvSmKS8dWGevDt7UhY+6L0iEorvlsoL5J
         1P+ObMZy40jiLfXR1cMZS5RKUUsOUcevGJNt1CczAFeX2ABB7TVvmfrByhRVJQYdP4ww
         po/itndSylNqIpsco0VtIYqycpaCG0ykS21mfQb1sIzwGhUMUin7+QPSc4XvP2qjOvuF
         drZXawwJ2H2xmZBU7yxOYB+Z1GROv1vQOl0WCCjGw20ACo8d0nKaUqK1TGVhF0EKUnXu
         Mfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcpunpJfD02BVk7gvPKYSvVCpndtXyJiwVOsvlKcqZI=;
        b=39S37wpcS9JlHaC9EolsdzmAy1tfS+5KNokWqvIg+sBZjluDSyw84HwPk0N/YNUf6+
         nD5coG7Zn/QeLEF3wGTMgYPJhtz+tftpB1hP+Ib1x7g6Cd3feZ7kgq9u4wniCkBunI/6
         mbNWIKPFbnAY+aAuiNvstDiAJMT/65Cop797Cl13nRN+vQUKkAY62ugIXYA3Xo5iGkNJ
         lSb34cG3IIH21ZMNzPYj8/TFn7rOKlRJL571OOJ805FlFhi38ljVCIIHKFPtb1zfNywV
         aL4ClDZzFnV9QCbZe+GCXShkJMAdJlh2r2GnriJMflzBwmSHy/zUg9N0gQDdfpo+e9z9
         0NOw==
X-Gm-Message-State: AOAM531K4QBkch3suYEfNubKOvZ/X9iEFbYes5Ve7fZfYIvnaSu8+0T0
        tIo35lw61zXDCuIM/wG96y/gNUyae534FzEn7eSYq+6fcYb8rVHl
X-Google-Smtp-Source: ABdhPJxiZkNnPp8L2tDYceQO0IZ4U2Vv1yzsBlHqRJNbQZbT3vX8Ww0HOFEE3jsk6TcubludTT/ovXMLWY9QcgDhjJM=
X-Received: by 2002:a1f:f241:: with SMTP id q62mr13676041vkh.12.1634661338139;
 Tue, 19 Oct 2021 09:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211019131724.3109-1-semen.protsenko@linaro.org>
 <20211019131724.3109-3-semen.protsenko@linaro.org> <6dbd4812-bac3-55dc-108e-c322e8a493de@canonical.com>
 <6ce55971-bee5-1bc9-c3a2-28e6ede37401@canonical.com>
In-Reply-To: <6ce55971-bee5-1bc9-c3a2-28e6ede37401@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 19 Oct 2021 19:35:26 +0300
Message-ID: <CAPLW+4mE09AOSco+X9qE=1sjXvNVkOxtJqur+HoBJExxiw0J=g@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: s3c: Add time range
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 19:22, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 19/10/2021 18:17, Krzysztof Kozlowski wrote:
> > On 19/10/2021 15:17, Sam Protsenko wrote:
> >> This RTC driver only accepts dates from 2000 to 2099 year. It starts
> >> counting from 2000 to avoid Y2K problem,
> >
> > 1. Where is the minimum (2000) year set in the RTC driver?
>
> Ah, indeed. I found it now in the driver.
>
> >
> >> and S3C RTC only supports 100
> >
> > On some of the devices 100, on some 1000, therefore, no. This does not
> > look correct.
>
> That part of sentence is still incorrect, but change itself makes sense.
> Driver does not support <2000.
>

Driver itself does not allow setting year >= 2100:

<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>
    if (year < 0 || year >= 100) {
        dev_err(dev, "rtc only supports 100 years\n");
        return -EINVAL;
    }
<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>

Devices might allow it, so the commit message phrasing is incorrect
and should be replaced, yes. But the code should be correct. Should I
send v2 with fixed commit message?

> Best regards,
> Krzysztof
