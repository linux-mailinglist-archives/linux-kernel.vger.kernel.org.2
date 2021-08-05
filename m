Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EA53E1A91
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhHERkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhHERkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:40:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530A3C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:39:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so10644902pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJru5ZDdfo3OsMr7JwiDXcZi7jogvDxDa1GYS35xUbk=;
        b=m2EGBRm8Rqi+BfXOMMYhmsG3yGBPwwDfgWavRM29H0wBr/zlBio0IfCWNSvYTDuiHW
         0oyQN0tRT1CJSo0nCm2sWqzq/8UxMKkg1ac4WCNBZTL21/o8NCqmksd5MFuHx14HI2Ra
         sTE7BLzjN812BY5VgP5sHxUGi8gedh4JJ7wbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJru5ZDdfo3OsMr7JwiDXcZi7jogvDxDa1GYS35xUbk=;
        b=ZokTZR6MnlYFAjKJS5UlZ5AN/kNbjYx09In3ZZRI1neM96AZ+dsssyezDsZOUDKHaX
         dDyEozrEgg/+nJd4aYxCVblT0ImM4nblnUif4ebWyZnOuc5RZK3uXp6WhDLbavN7mrsN
         QGrY8gzUdy0nyhwikAh02lBc1z6tNF9+MQhCg1HOIUrrcmpc18IVi+WO8zVz9etk28X9
         ZUisGPC7T9LmyIzkpSq9ffMs6VlIS9kwp5JnJU7dDa/j0TQi7OZU9Yer6rJm157Itw78
         W/EACYTVI0LM7n9jDXOBgJfoBlD0g5sokuPRrbcdzoE6HwoZEEtDv+DSG+3r7eloBIq1
         EkVw==
X-Gm-Message-State: AOAM5304JaiSTJ12cDQmfPsjronuzEv+Nsrc/KZMR77YK9ZX3P1cdNli
        LZHJR5s5X0agBQn3S1mcQweTuSDeF21olVNYJnAxjg==
X-Google-Smtp-Source: ABdhPJyjJ0q3qYxxZiIvgojFVnsQqIiH/SwwPxtBFFad2j6bNGquDjnugA5USCKDfAtHfa0sPgPywwIPTQ9nyPFayTA=
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr5835173pjr.199.1628185193587;
 Thu, 05 Aug 2021 10:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOf5uwnZvJWhwf=h8nx=MmZz4BOyaq_BTr8vyDcGHqnBO7jK1Q@mail.gmail.com>
 <20210805172300.GR26252@sirena.org.uk>
In-Reply-To: <20210805172300.GR26252@sirena.org.uk>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 5 Aug 2021 19:39:42 +0200
Message-ID: <CAOf5uw=BZ98KGskd-C4NyHQozi7kpca4ZCQE9c8wxkg-W0Aewg@mail.gmail.com>
Subject: Re: RFC power domain vs generic supply regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Thu, Aug 5, 2021 at 7:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 08, 2021 at 08:01:20AM +0200, Michael Nazzareno Trimarchi wrote:
>
> > I'm trying to understand how to deal with devices that do not provide
> > a supply handle connection using the device tree, or if there is a
> > generic way
> > to connect to a regulator. The pinctrl has a generic binding inside
> > dd.c that allow to mux pinout during probing or it allows to define a
> > power domain,
> > According to the code I read the power domain can be only connected to
> > the SoC power domain but in general a generic power domain can be
> > connected
> > to any source aka a regulator. For example and spi-nor can be powered
> > but a gpio regulator or any kind of supply connection and bunch of
> > devices
> > can just need a supply if they are probed or binded runtime. Can
> > someone give me feedback on this topic?
>
> I'm having a really hard time parsing the issue you're trying to solve
> here.  Power domains and regulators are different things, power domains
> represent blocks with a SoC which have some kind of power control which
> may involve a combination of things, the drivers for the devices within
> those domains generally just do runtime PM and then let the driver core
> figure out what's going on with them.  Regulators are for things with
> physical supplies that can be seen in the schematic for the board, in
> general anything that uses a regulator should explicitly say so in its
> binding - supporting some sort of generic mapping isn't great since it
> means that we don't have any control over which regulator is which and
> that makes it hard to add control of the regulators later.  Power
> domanis may possibly have regulators among the resources they use but
> that would just be a normal device binding for the power domain.  All of
> this is orthogonal to when drivers for devices get loaded, that can
> happen at any point while the system is running and doesn't really
> affect how the relationships are described.

So in short you said that if I have a device that has no definition of
supply in his
documentation, this device needs to support the supply in his binding
and make to sense
to create something like:

generic-supply = <&regulator_device>;

and let dd to pick them up

Michael




-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
