Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058CF3DF320
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhHCQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhHCQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:47:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E9C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 09:47:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id go31so37235929ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iY25rrglPS3Gh3oKWqjb0WQdwyn/C+G4a9t9iTacLA=;
        b=Rp1AHBn7mqvNUKwaNWCL5eeJRNv4Sj8iOJlnae2g/K2ya99iCDc2o8g3rV7yCAIPsP
         cLAX6nPbpaN5RNpAWr18gpUvpaWUEEiOMny7eME1xouUWAWDFJRMcNCFR5+tJlH1SQSb
         hshXkxWsXF/D2EQkVSU2LTkEzmCypIlZmzq8JkqR2fHd1+qcAVvmhdwXsZcBMt4yMW91
         IdU/HXVTyNfPEmKoJYxtz482h4IrsOz5313q/DY+gVsfZXuR8ae4+ZJxNacfBlRWwlN1
         GIKkczkk9RV60dZjUvQgQpBai7whjJv5tqTny5p8JAr5p1o49GZGNY8l97OcXyFGzcbk
         qYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iY25rrglPS3Gh3oKWqjb0WQdwyn/C+G4a9t9iTacLA=;
        b=O7lYEBOzAhNe06ZbGEOpp38wqwT0j+FVeTiAfmMhRoxecKTpKzsJtnSjptNdvX9UGH
         Y9ft88ijugbe141mbBRmgukg8hiWLd4Hp3aP9+pHDv3bplkUTIkonXfmx8L8B7u+JAlM
         QKfB1l1A37OwmB3cFpHAozxYW7qsatRcnX4L6FoFfPRKqa4Qsvi/OnWgW0SOcoGb+lgu
         tzxa0KH3O2IwHXuZR0Zkyku59lfi4mPAjcB9mh+xvSdMv7ABwS0fDEmzke1lgSiHJx06
         huoIQNg7DiUC+TNnDoOMMes5Qp9xSw8aRRLEv29NW84GXBT1+cKGWKLNn37G4MbenypI
         D5bQ==
X-Gm-Message-State: AOAM530W1GX+lUfluK24NnKWhwNIus/LZSI9IUbs9qIXNhRh73bY4Ztn
        oEWRPgxlunqTFuyo6Cm2pZGYdkBkgUhZOd9wuo0k
X-Google-Smtp-Source: ABdhPJyeizlYtaT4m3WQejwy/YbdzzVZLtADNLtj71rZ3bIkcfPCEneSHNfWGUOmCbGIw0lOIuiQaYVVmXT3+5FbtTA=
X-Received: by 2002:a17:906:5fc7:: with SMTP id k7mr21088425ejv.377.1628009255659;
 Tue, 03 Aug 2021 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
In-Reply-To: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
From:   Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date:   Wed, 4 Aug 2021 01:46:58 +0900
Message-ID: <CANgtXuPjD0rW-A=gMNUd7mdF1Bynz+QQmDHLy7vh9UODd8NtbA@mail.gmail.com>
Subject: Re: KernelCI Hackfest #2 - Sept 6-10 2021
To:     kernelci@groups.io, guillaume.tucker@collabora.com
Cc:     kernelci-members <kernelci-members@groups.io>,
        automated-testing@lists.yoctoproject.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Summer Wang <wangsummer@google.com>,
        linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
        kunit-dev@googlegroups.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 2, 2021 at 6:00 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> The first KernelCI hackfest[1] early June was successful in getting
> a number of kernel developers to work alongside the core KernelCI
> team.  Test coverage was increased in particular with kselftest,
> LTP, KUnit and a new test suite for libcamera.  We're now improving
> documentation and tooling to make it easier for anyone to get
> started.  Find out more about KernelCI on https://kernelci.org.
>
> The second hackfest is scheduled for the 6th-10th September.  It
> should be a good opportunity to start discussing and working on
> upstream kernel testing topics ahead of the Linux Plumbers
> Conference[2].
>
> Here's the project board where anyone can already add some ideas:
>
>   https://github.com/orgs/kernelci/projects/5

I cannot add topics to the project board.

Thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================
