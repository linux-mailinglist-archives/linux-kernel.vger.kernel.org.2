Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE173BA43D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGBTMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGBTMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:12:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:10:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t15so10287029wry.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pwYoD+B5XKnwLTcyRy1LIQVYYLjlHZQVZ1+ImYP0NLo=;
        b=CBPShXOPYqgpGQgdz+9TSJbQ7w7OW39b+MhptbzOrbq2ZLvKvP01ki62Xz/PxR2cvS
         LS1FeTnMTyMQe4nC+mlvUkS2en6XCKlTg9TiD1F5JO5LX41qnzRK+fqPUputfAyTPIxg
         rBY9Gp4alPxUxkU4blLQpNUzVhp4KaS6W7uOVcLE95wfQeYh/8EZsKQcY8Vm79HzMjLU
         wjd8V8mzTBM6jn5ePIMdx5xyMIgogMmIRIYIqJPE8/5s900thDLnIMvA4mB0O0oSmvo0
         QGvCVrVktni6LZhHDRhhPfEiP13R/2ry+Zp1fTshrltm5gSHnoTKFVPMKK977y9slVV9
         vYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pwYoD+B5XKnwLTcyRy1LIQVYYLjlHZQVZ1+ImYP0NLo=;
        b=rxNPLnddg/DiLJRvYVqte77UFwAv1MWcS5JwdeSD7M6gnKQfx/gDrU5nyqE2e/zrV6
         9y2QkEiHEBkJAcvYcBGMiDXNsfaiTE9QxSpedsAJb7/1KioaAEdbdwtzeHvyQCaOFqXc
         w4tBnAyCn6QIVA7l+AgqXo22gZV3iBhK/DT5BC2gM1SiUmKeGMijzI6Qu6rG7o8kzapZ
         2ACqQ/YS7bsCedasoL6D1Zs/fwn9ByfpH8mctCNLAW531NV1JACjxMkpSGyOCIySjZ/r
         KJj0Lk5UCmaUgpYdDDUIYZyiW9YA5vP+wTPXbrrkjP8OnxbdBarW7TgErtis0vIOJNvd
         VYsQ==
X-Gm-Message-State: AOAM533VCQeoWF7XKoRGPimc69WhLQzMqDxUFh7LboylqDlVT2aCgTUO
        FptmsYa3aCX+g9GuW21aoNjU/g==
X-Google-Smtp-Source: ABdhPJw2z1kS4JD1LLZBKCqieRZzq9InEf52wN2TIEnY7/TnJvGFtkcpfdh4euHle6tf2agiFjvKcg==
X-Received: by 2002:adf:a355:: with SMTP id d21mr1234792wrb.65.1625253014887;
        Fri, 02 Jul 2021 12:10:14 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h21sm3760283wmq.38.2021.07.02.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:10:14 -0700 (PDT)
Date:   Fri, 2 Jul 2021 20:10:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Yunus Bas <Y.Bas@phytec.de>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <20210702191012.mecgw577ggkabxr6@maple.lan>
References: <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
 <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
 <YN9cl1/7k/UlllSq@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YN9cl1/7k/UlllSq@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 07:36:07PM +0100, Lee Jones wrote:
> On Fri, 02 Jul 2021, Daniel Thompson wrote:
> 
> > On Thu, Jul 01, 2021 at 03:34:43PM +0000, Yunus Bas wrote:
> > > Am Mittwoch, dem 30.06.2021 um 13:33 +0100 schrieb Lee Jones:
> > > > On Wed, 30 Jun 2021, Daniel Thompson wrote:
> > > > 
> > > > > On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> > > > > > Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > > > > > Imagine only required parts of the MFD is connected to the
> > > > > > designed
> > > > > > system and unrequired parts are not. In that case, fully
> > > > > > describing the
> > > > > > MFD in the devicetree wouldn't represent the system at all.
> > > > > 
> > > > > To describe hardware that is present but unused we would normally
> > > > > use
> > > > > status = "disabled".
> > > > > 
> > > > > So if, for example, your board cannot use the RTC for some reason
> > > > > (perhaps the board has no 32KHz oscillator?) then the DA9062 still
> > > > > contains the hardware but it is useless. Such hardware could be
> > > > > described as:
> > > > > 
> > > > > da9062_rtc: rtc {
> > > > >     compatible = "dlg,da9062-rtc";
> > > > >     status = "disabled";
> > > > > }
> > > > > 
> > > > > Is this sufficient to suppress the warnings when the hardware is
> > > > > not fully described?
> > <snip>
> > > > 
> > > > Right.  This is a potential solution.
> > > 
> > > @Daniel, you hit the nail on the head :). Thank you for that.
> > > 
> > > This solution would indeed surpress the warnings, but what is the
> > > benefit of this? We would define never used device nodes just to
> > > satisfy the driver.
> > 
> > I would say that doing so resolves an awkward ambiguity of
> > interpretation w.r.t. the bindings.
> > 
> > 1. The MFD device compatible "dlg,da9062" tells the OS that we
> >    have an DA9062. An DA9062 contains six functions and this can be
> >    inferred *entirely* from the MFD compatible string. We do not
> >    need any subnodes to tell us that a DA9062 contains an RTC. The OS
> >    can (and in this case, does) already know that there is an RTC
> >    because we have a DA9062 (and a datasheet).
> > 
> > 2. The default behaviour when a node has no status field is to
> >    assume that is is *enabled*.
> > 
> > Based on #1 and #2 above then assuming that a DT that omits the
> > sub-nodes actually means "disable the RTC" is risky. #2 might
> > actually make it more natural to assume that the device is present and
> > functional because there is no status field to tell MFD *not* to
> > initialize it.
> 
> Exactly.  Nicely put.
> 
> > That leaves us in a situation where there is no way to correctly guess
> > the authors intent when sub-nodes are omitted from the DT.
> 
> > Given this is something of a corner case and the documentation is
> > ambiguous then a warning of the author does not clearly resolve the
> > ambiguity seems reasonable.
> 
> I'm having trouble parsing this part.

That's quite reasonable because was is written is nonsense!
Perhaps s/warning of the author/warning if the author/ will help
but there are still too many words to say something very simple.
The whole last paragraph could simply say:

  The bindings documentation is ambiguous so is it reasonable
  for the OS to issue a warning when the devicetree author does
  not clearly resolve the ambiguity.

This is still a long sentence but at least it is no longer a
complicated one!


Daniel.
