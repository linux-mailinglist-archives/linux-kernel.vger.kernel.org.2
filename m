Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52A43A6E28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhFNSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbhFNSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:24:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB8C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:22:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p184so16741533yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJ8KAixbNZbEW4J105zNZlUGEcS0JFau0ZPs/5NCl1k=;
        b=tPLx0iWstMqcLP2aJ/stobRUD+nTXb3rzMEURAJ1x/CK0oRLxqwel/scAADgp++gld
         rZC1OZD5yPrhy/VUl9XOtacaGQvQF8sEoCtxKUQ9yaRxPEC1yQ/zdC86Q6CLgo+qD8x0
         USXmE3suR9vCPBkFLvAkGnTcj2sk1XUFzCmHeU7+nycxissn9TkJaoInfqiAb9H1k+rW
         QdfZx5rn+7dcjHYMSCQ9QjIi8pQa2a1/UP0RqTqZ1+5+MLqx0XCY+n6zp4c7raTIVDlp
         pVuaxZVVmN/YDU5Hsk0KYaviubzj4ebLg9la++XK5edeP1C6w29t8nykUtjvTH1bhmG3
         G8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJ8KAixbNZbEW4J105zNZlUGEcS0JFau0ZPs/5NCl1k=;
        b=PUmzu5nM6xzryKfFzTNB6vIzWgC4iHO8XUU9t1GSjDMZXnItMQ+zX0YhBz7zesEfPq
         DAhTURI4zfltEw+SA+CfQfroJEDVHBcPJAmwMYxvhK3aP5OPISHtfKG25yg5KS8A4th8
         vBqJd7IjM4RxcMCJXAQm3XvyKjtYgoY8oBAxvuIr04lLic8OVaf2ZOWJOqqtQU4hxAA/
         qYM4mnVyk5L9bvja8El9U4f36gG5YJPLlxqI7mun7fPywiyNvNrvHL/cynnYYLFIRjxm
         4SnjTzPnhcQuYPWtUvh3OFnDWkf7HV+tomdrAVGBxMj/iL4jxn/aUW8B8kDdFX9H1Eda
         aBxQ==
X-Gm-Message-State: AOAM530/k9aubCLOrKlcjdMZ78VHvohNY4L6aPOi+/H7xONGbgBwjI/g
        o15JHFys1/prINcaXQzB6p3QPwqYMz48/StTzJfpaA==
X-Google-Smtp-Source: ABdhPJw75UOpwMo1TQmH5VOWBLtE5ZAnlQKVQP8IAJnfRx4MPnlJsR0DzLZU5Zfizg4Rw7OaQ6hX5lCKRUe3WE6CkJg=
X-Received: by 2002:a25:1b0b:: with SMTP id b11mr27373062ybb.302.1623694935711;
 Mon, 14 Jun 2021 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210409140806.31824-1-srinivas.neeli@xilinx.com>
 <20210409140806.31824-2-srinivas.neeli@xilinx.com> <CAHp75Vddd6ygr4mJ9Z+SuGZmfLcgDLWLZaxby2XE2mX8War-qQ@mail.gmail.com>
 <CAMpxmJW=HWf_NxGpfBkX=utgOTs4+6RtypxnKGtpuYnX=t8rGQ@mail.gmail.com>
 <DM6PR02MB5386CADF5A10EF28A640AD76AF4E9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <CAMpxmJV_CtFQpZvr_H0g3DvPMQZwqa-9z2FVxCLX=tF9Ytkj7Q@mail.gmail.com> <DM6PR02MB5386A84774C2430F4BDED84BAF319@DM6PR02MB5386.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB5386A84774C2430F4BDED84BAF319@DM6PR02MB5386.namprd02.prod.outlook.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 14 Jun 2021 20:22:05 +0200
Message-ID: <CAMpxmJW4DaePgVq43zOHQ4OzD8cx2EeWb2hktpwJ1S_JNeAw-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: zynq: use module_platform_driver to simplify
 the code
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:39 PM Srinivas Neeli <sneeli@xilinx.com> wrote:
>
> >
> > Andy: How about we give it a try then? If anyone yells, we'll just revert it.
>
> Could you please apply this series to gpio for-next branch if there are no issues .
>

Applied, thanks!

Bart
