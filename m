Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50CF3AA8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhFQBij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhFQBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:38:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:36:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 131so6502248ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DdalLyZlBTBXHIWH1visTtmvg926dUYs77hPwyHRCtw=;
        b=yrXKHg4vzHZFodN/LDRp6qfTdwYKJBCO+H82Ho/nwE3yaeZGoKaBMEkHFqFjU65j2T
         laujFBLakXqYvJpmFikQ81KIbPKC22lTkBUIdqtTOVI0y7LOXOiL0pusFBap4ZjeaSTE
         QRESjd4Ira0qLOm84R4SEzOf/2EiVre9yFhldd7BPmlrlFNYd/KHhx4bQB/tlJvKf14Q
         n0LCIHbn0lS/qY316oThRD2srsnE4knakM1W12rV/Own1oK85eMU1CQro+CbXJSt/DDO
         H4Z9v2Rx9wMwXkQe/wPQfs89TCHmMhu6jbAU23iDP0GlK6iOTE8Ny54oHtV+LGnnttVN
         56oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DdalLyZlBTBXHIWH1visTtmvg926dUYs77hPwyHRCtw=;
        b=US5c+g2d6yMdrbxJraqiVqKVSyPjSNa6G+6UdkRDlL/9OD7rnEDBL1JZTaASUICTz2
         LwACNqwGGjbeq2RIhd3HGcyDwhBDb1AiaTfp5BCTvUOQRLZeroEja9pkfhGuKAt34mQ9
         cOEALoFgJsBgaywA/ay3SVX+WL6UVz+bKfeauA/ie00Qkiuyt4IMk0YuMBZBtHOv04Yg
         GWAteq7JdwSGIliqx7sjYRndifg5LQ5nUsTAfexSn8a0j5kG6yjlxZVoovgUkM6j5FKc
         VH4zqazV92RukvfXFUji0GoE1p/XvolDoJAb02FWZEi2ASir1JrPx1fBd50UESBr3hkZ
         FuFg==
X-Gm-Message-State: AOAM5335PYQKBZ7iRqAMFbjrcjxvdt+VV87ttL6p3+kGjZmHOYRGZ3jP
        BZ6Up1NMpT6JYVMF+V8AIYWv6w==
X-Google-Smtp-Source: ABdhPJzFIQQYCOqkl8w4GMt/J7LdBJyrfP63YWpJGFdO+JZQGLZafjEQYvfobFMVek1oJ2CJa5EXiQ==
X-Received: by 2002:a2e:881a:: with SMTP id x26mr2401311ljh.161.1623893789404;
        Wed, 16 Jun 2021 18:36:29 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y22sm412153lfh.154.2021.06.16.18.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 18:36:28 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:35:52 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, soc@kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] memory: Tegra for v5.14, part two
Message-ID: <20210617003552.GA7462@lx2k>
References: <20210614195200.21657-1-krzysztof.kozlowski@canonical.com>
 <20210615154155.GE11724@lx2k>
 <f4f3762d-7036-15fd-2f05-fcd617634aef@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f3762d-7036-15fd-2f05-fcd617634aef@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:20:59AM +0200, Krzysztof Kozlowski wrote:
> On 15/06/2021 17:41, Olof Johansson wrote:
> > Hi,
> > 
> > 
> > On Mon, Jun 14, 2021 at 09:52:00PM +0200, Krzysztof Kozlowski wrote:
> >> Hi Arnd and Olof,
> >>
> >> Tegra got quite big rework this cycle.  The last piece comes from Thierry,
> >> however it depends on one patch in Will's tree.  Since the last Thierry's
> >> patches depend both on that one patch and other memory controller drivers
> >> changes, they are here.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > So, this pull request is a bit weird. It contains a lot more than what the
> > email indicates:
> > 
> >> The following changes since commit 393d66fd2cacba3e6aa95d7bb38790bfb7b1cc3a:
> >>
> >>   memory: tegra: Implement SID override programming (2021-06-03 21:50:43 +0200)
> > 
> > This seems to be a patch in the middle of the new material in your branch, not
> > the start of what we already have in our tree.
> > 
> > As a result, the diffstat when we merge looks completely different. While
> > I generally trust you to not try to squeeze in material under the radar, it's
> > also unfortunately making it hard to double-check that you didn't accidentally
> > bring in something you didn't mean to.
> > 
> > So, before I merge this.. can you confirm, or even better generate a full pull
> > request summary/diffstat/pull request email that shows the full new material?
> 
> There should be nothing hidden and I created this pull request on top of
> my previous Tegra one:
> "[GIT PULL] memory: Tegra memory controller for v5.14"
> https://lore.kernel.org/lkml/20210607084910.21024-1-krzysztof.kozlowski@canonical.com/
> 
> I had impression you pulled that in, but now I don't see the such branch
> in the soc tree. Maybe that's the answer - the earlier material was never in?

Ah, based on the discussion and the generation of a new stable branch that is
shared, I interpreted it as you spinning the whole branch/pull request again,
and indeed I never pulled in the base contents.

That explains the difference here.

(I also want to be clear that I wasn't accusing you of trying to hide material,
but that it came across as a mistake and/or miscommunication, which indeed it
was)

> Anyway, before is the full diffstat of that branch so:
> tags/memory-controller-drv-tegra-5.14 + tags/memory-controller-drv-tegra-5.14-2
> 
> However I think it is still good to pull
> tags/memory-controller-drv-tegra-5.14 first, so the tag-message won't
> get lost. That tag-message was also explaining why there is a pull from
> Thierry (with clock and regulator).
> The second pull does not mention earlier material.

Cool, sounds good. Merging.


-Olof

