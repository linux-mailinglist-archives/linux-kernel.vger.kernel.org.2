Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65751313EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhBHTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:20:13 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43055 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbhBHR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:59:30 -0500
Received: by mail-ot1-f42.google.com with SMTP id l23so3348929otn.10;
        Mon, 08 Feb 2021 09:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lScv50d1ZyqagwO0c9BMwWMnexfOHV/tP4Lgw63kKHw=;
        b=NtVGc0seVH58dsycl89DOE32awTKybGHAgq0XeMsL6JjsVgGVmag/ZOeDXwnTTzUTV
         CQFDH7WD9WbG+X/loq1cMw+GQauiSeGG5HAI537J/V8bQLK+CGCQCiBr9+J10OZcmLyA
         NImIaorLQYqpCEGNa8x4N6z4VM8+ZowJ5QZC+2kJxrS1/RxMpw1niloLe1GOKWpiWqSw
         nC8Yj8+yH5YQ5w6gPu9HAERLGtyuzmoWKA2IFJT4Pt/konC6M+DqrdougDX/9FO96TWt
         66q3x0D6zObIdqqsgCVi6UqRpWGG3LVUEYVVfCCvxzFAhRxaH1j3OojAleVYz1KC4gsh
         i/iw==
X-Gm-Message-State: AOAM533kxJo1FkWV3cUfZ8XNUD8WIUNq3TJdwJS7zRUoTmSY05y9dE4j
        dDigsF/p4q/WSI8HF2laBA==
X-Google-Smtp-Source: ABdhPJzqRSrYc4T8fAFx8cdWWHXtMy9OBexjy9vulNRDba6D0v0R4U+Q3TIwsWMEc78NEdWT8dc9FA==
X-Received: by 2002:a05:6830:22d7:: with SMTP id q23mr5443543otc.71.1612807129548;
        Mon, 08 Feb 2021 09:58:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u73sm3668919oie.30.2021.02.08.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:58:48 -0800 (PST)
Received: (nullmailer pid 1618899 invoked by uid 1000);
        Mon, 08 Feb 2021 17:58:47 -0000
Date:   Mon, 8 Feb 2021 11:58:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210208175847.GB1567700@robh.at.kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <20210208121325.owjjd7nfbdanszny@kozik-lap>
 <CAK8P3a0yBC3dui6vcz+NByWD-3LqRj-2MF89jpjb_k8r5xmNRA@mail.gmail.com>
 <f98dc238-6742-455e-3f76-e86ae4c0c838@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98dc238-6742-455e-3f76-e86ae4c0c838@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:12:52PM +0900, Hector Martin wrote:
> On 08/02/2021 21.40, Arnd Bergmann wrote:
> > On Mon, Feb 8, 2021 at 1:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > 
> > > On Mon, Feb 08, 2021 at 08:56:53PM +0900, Hector Martin 'marcan' wrote:
> > > > On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > > > > apple
> > > > > 
> > > > > Don't make things different for this one platform (comparing to all
> > > > > other platforms). Apple is not that special. :)
> > > > 
> > > > AAPL is the old vendor prefix used in the PowerPC era. I'm happy to use
> > > > `apple`, as long as we're OK with having two different prefixes for the same
> > > > vendor, one for PPC and one for ARM64. I've seen opinions go both ways on
> > > > this one :)
> > > 
> > > Thanks for explanation. I propose to choose just "apple". Sticking to
> > > old vendor name is not a requirement - we have few vendor prefixes which
> > > were marked as deprecated because we switched to a better one.
> > 
> > We've gone back and forth on this a few times already. My current
> > preference would also be to go with "apple", not because it's somehow
> > nicer or clearer but because it avoids the namespace conflict with
> > what the Apple firmware uses:

It's only AAPL,phandle and AAPL,unit-string (equivalent to unit-address) 
AFAICT which are really internal format details. So it's really 'apple' 
that could conflct, but I can't see that mattering.

> Ack, I'll use 'apple' for v2.

3 votes for 'apple'. You all get to pick the color of this shed.

> Amusingly, Apple actually use 'apple,firestorm' and 'apple,icestorm' for the
> CPUs in their devicetrees for these machines, so those will end up identical
> :) (they don't use apple-related prefixes for any other compatible strings
> at all, it's a mess). But we don't care about what their ADTs (Apple DTs) do
> in Linux anyway, the bootloader abstracts all that out and we'll be dealing
> with mantaining proper DTs ourselves.
> 
> > > Makes sense. In such case it's indeed your work. Since you introduce it,
> > > the DTSes are usually licensed with (GPL-2.0+ OR MIT).
> > 
> > Indeed, we do want other OSs to use our dts files, so the general
> > preference is to have a permissive license, unless you have a strong
> > reason yourself to require GPL-only.
> 
> Thanks for pointing this out; this was actually unintentional. I based it
> off of an old dts I'd written ages ago and forgot to revisit the license. I
> even have it marked GPL-2.0+ in the copy in our bootloader repo, which is
> otherwise supposed to be MIT for original code...

I'll also highlight there's a DT only tree[1] available to import DT 
related parts to other projects. It's generated from the kernel tree. 
Probably an overkill to copying at this point though.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
