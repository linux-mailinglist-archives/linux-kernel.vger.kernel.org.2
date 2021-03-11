Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E95337987
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCKQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:36:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:36:38 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u20so2956654lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPZvfHb+Si345+eLdtp+jqoQGBHvb7ncg4YKmkA+66M=;
        b=ZLRE+NNfiFUlgsLsqThPInd/fkJoau43SsDb1VjHe8HyIpwRcRvbYgYMe816XwTWGt
         c8xc98NLjPQeVdPhwmptbgJr3kcqK3bz8W9J+CL11A1igC1hjHB8vJzRja79PyGO884M
         auLw+6gt9LlTrKO/oswUCzxfTUR4uMEw9P2kHYViuAEz6cflssQTF69bqAKPOA7cj4RL
         SkDfNsMhv6ewu14K88kjHDEEmgWwdQ5+emSCcWVlHwPcIzMgrqRZi5SGxUaaS63lKqMI
         Gy1IPWqgYbu9a28p//xRh9Cl9adytNWX3q7J8NRlMe3CTnaAuBNYPHJ6Q6lmNau4KY1v
         BsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPZvfHb+Si345+eLdtp+jqoQGBHvb7ncg4YKmkA+66M=;
        b=jIVrdcvJ8kRCggxKbcFLrZXqKBWrxcqyHVsTyBug8iJ+U+K7y+BzUzdcwBzkvgI1Xy
         7Qd9bgDAq1D5CULkpEHyVEfSn/K8l3+mG3f+hNlwgKC9AHDtclZJmMGeSrZ3UyKQTZ93
         msTZyXWWixHWc+e3WIF7aUdwvjjWTiFOV/ZL2cPU9H9dMpXwp0vMYttXs3TMhqJNupu8
         PAX7NiQVEaHxZjI3W7pd5Ol54EcAak+LcnhsX/YjKfu6l0LwNCYlGRQl0rAqvMFk24UO
         o7sLbh2X6eifWhC5KvU1lyaW8mwIY6/7qXTJ2O7dNN2UodtNFFmU9qe+MY271suYMN1C
         Abog==
X-Gm-Message-State: AOAM531+TWVkz7ES0HH5GDzcjkK+O8PnUFCEN9hxke9AEDO9NkCH9I+r
        80tCFOKek6YXlIK+w87Gk7OSj9sIjFFFi4mtdYM=
X-Google-Smtp-Source: ABdhPJx0cbnzSZmTMT5sCkrs9DzzYM1gHaoFP/gpXRg/cqqijUTClvi5vIlfuq5tLasKwacsa0J+55TfM0nUhlJ9UUk=
X-Received: by 2002:a2e:8590:: with SMTP id b16mr5273379lji.53.1615480596716;
 Thu, 11 Mar 2021 08:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20210308090329.17507-1-heiko.thiery@gmail.com>
 <CAEyMn7bCdzFTWpXBQ8jP-drw_ykXRUhawHMZqXHsHgy-3oD6LA@mail.gmail.com> <CAEyMn7bZy0vWbrmEuEb3HAGPWitai=uBiZS_-yvD8UzcCN+aTQ@mail.gmail.com>
In-Reply-To: <CAEyMn7bZy0vWbrmEuEb3HAGPWitai=uBiZS_-yvD8UzcCN+aTQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 11 Mar 2021 13:36:25 -0300
Message-ID: <CAOMZO5AjV+YHMxGRhOJPafh4by=0u=BSAVynQc+NS_yPMLcSAg@mail.gmail.com>
Subject: Re: [PATCH] arm64: configs: Enable PCIe support for imx8mq boards
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Mar 11, 2021 at 1:13 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> > > Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> > > imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra. This increases the image
> > > by 64k.
> >
> > The growth of 64k is not right.

Please resend this patch without mentioning the image growth size.
