Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D874334B11D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCZVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:14:11 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:53517 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:13:37 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 753b7a91;
        Fri, 26 Mar 2021 22:13:35 +0100 (CET)
Date:   Fri, 26 Mar 2021 22:13:35 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     sven@svenpeter.dev, robh@kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, marcan@marcan.st, maz@kernel.org,
        mohamed.mediouni@caramail.com, stan@corellium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
        (message from Arnd Bergmann on Fri, 26 Mar 2021 21:03:32 +0100)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl> <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
 <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com> <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl> <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
Message-ID: <c1bcda5b25b1f37d@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@kernel.org>
> Date: Fri, 26 Mar 2021 21:03:32 +0100
> 
> On Fri, Mar 26, 2021 at 6:28 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> > I haven't figured out how the bypass stuff really works.  Corellium
> > added support for it in their codebase when they added support for
> > Thunderbolt, and some of the DARTs that seem to be related to
> > Thunderbolt do indeed have a "bypass" property.  But it is unclear to
> > me how the different puzzle pieces fit together for Thunderbolt.
> 
> As a general observation, bypass mode for Thunderbolt is what enabled
> the http://thunderclap.io/ attack. This is extremely useful for debugging
> a running kernel from another machine, but it's also something that
> should never be done in a production kernel.

No kidding!  I was surprised to see the bypass support on the
Thunderbolt-related nodes.
