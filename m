Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17D398A41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFBNRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:17:51 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33712 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:17:46 -0400
Received: by mail-qk1-f178.google.com with SMTP id k4so2307477qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/8jRDJEPAWYvJMeFDiVIKYJU+NRE6xxYTSVBMepLU8=;
        b=T2fmrZwH55p33YDzQ1EPonHZ/p1O0XEZgKav9ZDURPo/qc/4XG9QnWW6hJFlu1+bNW
         xSuvan7KDBk4Z+gMhFBdl4v/L+o+M/tN1Pdg48nY15PMddDFhXV6M2B8Xonu1LOPJKY3
         ityoTcHZUa2UThirxXDBOggMaDfSfif23LGQbAYjUddpkDMzwRKUquXKHyV0qo98wovu
         66we5D0vZ7ITK3NdzedMIOeqGXE0NczVr47RRjsgmDY7QehoeST5j6c22SCJYlUtJEGO
         iGkepR/Pi20BEpZplfan5TRADIxEoe7VXzG1g30oh9l/HZGhigHi7rARQRh5NgYZkFvQ
         388Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/8jRDJEPAWYvJMeFDiVIKYJU+NRE6xxYTSVBMepLU8=;
        b=pjmeHxk5kRbmNI9Q2lVelUwhA4S/DHAHQrNdPInilXpc/gl6+C9oJattdNBRthEZ0g
         c8IlYxb0QrRbFxSMxDhNcI7zLrQGVTvUdYjEJ6Il5IgSm7zSu94y2ReDRJXehOMf+P9H
         0jk/3qgn/EeHwMzPj8q1fZBiH1zvXL+aXmalCpgg1TlE0WPtnj0SXRfN6dUxwX0CMtTu
         /LxCCWk0LZGwwJIcGXd7QwgHrVFQ9Qg2aCOQHwO+JYWdZbCMCQPDVMxJ2pVc5qKymacz
         HKViZjuTy4uLkyhepYFgE8YmGq/le1wYzl/so7v3ZThWAVb7lDx6KnUMwITQCLB220Op
         hT7A==
X-Gm-Message-State: AOAM5317j03IuSBMU6xfZ7AB6oJuiIH/q3uCpujIB0wQZqNv/9+CL4Nw
        wh5St3ewliPttdVe4F9wILo9TfRxvA0q4d1Xxp4b1Q==
X-Google-Smtp-Source: ABdhPJyLyWJcTlWzh/33QlGuFDWysrE24cjYsylOlPy+WIL481XIUfTbQthdJ2Ps54YV04HI5wd2MtQlRgz7bEDvefs=
X-Received: by 2002:a37:8f86:: with SMTP id r128mr27443957qkd.486.1622639686759;
 Wed, 02 Jun 2021 06:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
 <20210519221224.2868496-2-dmitry.baryshkov@linaro.org> <20210520115724.GA3962@sirena.org.uk>
In-Reply-To: <20210520115724.GA3962@sirena.org.uk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Jun 2021 16:14:35 +0300
Message-ID: <CAA8EJprEQcP3hzqSsq8jzoCzf0gvbWdnQtCEGBO5S3WJNUkYEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: core: always use enable_delay when
 enabling regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 14:58, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, May 20, 2021 at 01:12:24AM +0300, Dmitry Baryshkov wrote:
> > Some regulators (e.g. fixed) do not have .enable callback per se, but
> > use supply regulator and enable_delay. Do not return early from
> > _regulator_do_enable in such cases, so that enable_delay is properly
> > handled.
>
> This doesn't seem like the right fix - if we didn't actually do anything
> then we don't need to add a delay.  We should only be doing this if some
> parent regulator changed state.

I have implemented this, but then it becomes too fragile. If the
parent gets enabled for whatever reason just few us ago, the whole
delay would be skipped.

-- 
With best wishes
Dmitry
