Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C534FAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhCaHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhCaHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:43:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC2C061574;
        Wed, 31 Mar 2021 00:43:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x14so18472714qki.10;
        Wed, 31 Mar 2021 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fLwNldZAVcEFbnzafL88z8nyPvcygnyy6SA/tbSgoQ=;
        b=cffktVa3X1Rg1vbLm4GZOPnYL7vaTyFmVPSCvCZFWM9vpiTgK2VHTmJ8VVvJxRlwaM
         VWVVDlAJfY7QTeouHs2PlTtl6cVGrSx28JMZDz9Y63rTAskFRcSYm3QNtzhJ+g5P6Vth
         c4JGC0JckCBhjSqoZ4Sn5q1midRjhQhPPh7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fLwNldZAVcEFbnzafL88z8nyPvcygnyy6SA/tbSgoQ=;
        b=AcbdmNUcVHDo3AKMn8VjiWZOND16sQh0OisGEnjAWYTrrWnMekUeo8M0CubrnNKDTg
         mhyAxSifn4zmsAle33wYNgircgVB/o8EAf+cqD/i4USf/1QT/3dF02UIM98jOJXzexhD
         RhmhPGiG9fMiJljW17BwMnAQRVJJOxVgt5bTMpD0fL/YZsWq61hUMrqXCuPShKuht9jm
         rtOjxtKoir00emIiM1skGoE3zHzeimiKXepT/xPmNbofj9rhGcBz7WpN9f+DefI1iqH0
         7Btun6aNh1IFHat9adQov4rAZKEQgtYnYHMhnKDYevvb+N0SocDacyHBIdXF/CqYRt78
         rdGw==
X-Gm-Message-State: AOAM532tfBViMYPsOIs0wLxnayKUOJhpsSDARl9blD3Fj4/Nso4fwj16
        6w3a/WLZxKSwsez/b1upMYn3dWUI10TB+PtM11A=
X-Google-Smtp-Source: ABdhPJx0+wo2BnZkBPanhIURXpEVT9uMJNN95cUQIWK7OTUuooxK0Kdh+cOK8Nk7AwARUp8eroSraEjIGYAXCzOJXG0=
X-Received: by 2002:a05:620a:1410:: with SMTP id d16mr1878260qkj.465.1617176632868;
 Wed, 31 Mar 2021 00:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210330002338.335-1-zev@bewilderbeest.net> <20210330002338.335-4-zev@bewilderbeest.net>
 <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
In-Reply-To: <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 07:43:40 +0000
Message-ID: <CACPK8XfU_az1WpOFjtVbEbqO46sv4eWbjSGwbzua4niQZ3pUQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 at 07:41, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 30 Mar 2021 at 00:25, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> > mini-ITX board that we hope can provide a decent platform for OpenBMC
> > development.
> >
> > This initial device-tree provides the necessary configuration for
> > basic BMC functionality such as host power control, serial console and
> > KVM support, and POST code snooping.
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

> > +&vuart {
> > +       status = "okay";
> > +       aspeed,sirq-active-high;
>
> We don't have support for this yet, but I'll leave it in and you will
> need to send a follow up if the property changes.

Oh, I missed that this was part of your series to add support for that
property. Please keep the device tree out of the series when you
re-send the vuart patches. They go through different trees, so it's
easier if you send them separately in this case.
