Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA26E376418
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhEGKxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhEGKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:53:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0297C061763
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 03:51:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 124so12158889lff.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F33BGz4iH8dPjpEmF0N7tnuxayq0qldcPL97YnVagyw=;
        b=RW/8+dN/lpgFSZ0df5MNc6Ki5DdxPUebMDu4kK08MUuv4ZBMgn5O8CE/YrnA80N/8s
         45V4fPucN7eRvI+L50Th5xeDl+tyFXdyOnolupEH5Dm3j6KN2E0T/YbhCbFmf3ggqnJc
         uFkGqxpYaDIbIvmOmaUzIDHY/QVK0BX/qEbFIr3KtWFSt4JTzpdyOKSRFozudL1LIxhv
         wDULJGZVK9BEkc3y5wVQawO6Dl1IN1sxHz8xk8YjrplLAkzhkUig4p2M79yY8OZNz54X
         OrSffwbh4RRupTQnpWIAc65q2iK2wIxfXIV45cV7/OW/VgvqrZ0GxYp+tJ+srqSg6UDA
         tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F33BGz4iH8dPjpEmF0N7tnuxayq0qldcPL97YnVagyw=;
        b=jbJZTCbNWZk7AdRSjEZMnRGKj7gemydUrfytl4Lkcf8Rb6bWa2ngHpfhKVFmwBjwMQ
         Ax9iIhjf+X1hA6D7z9LYmc9bofkhV4dd+UeVSRUZMaaNaRJqgOoxqV2AI6rz3L4r2FRQ
         8jiOmZC3U82nBwIA6f0GHg/tLCn6CaadUndxL67KvcyFNPTvUHHH++nXJTTBHZfNzFN3
         4kqHhCvoSQh71crdwRD4sNNp9Pl3xORlYQQqlaxVaNokmB4gJHQOaXYJN9u9uhOKIryW
         GWYtLGjVrEWUV7dqUli90wnhcafInIFxuridyhMm7hZI4sYpS8qDpSH0ByLSpPmQ7xnj
         yWYA==
X-Gm-Message-State: AOAM533/g+ZA6QxsNtNraLPsBuFSTcZDPFMgJJiNZbf9p6UY1Yyne3V1
        +V/0kWniMA2XAUvO8QTrFQ6QyUmO4nETCzNTciTH9A==
X-Google-Smtp-Source: ABdhPJzx7ls/vpMj3eUwiEfOSMkqTyuxko9P8MpdbiNR+6cpzIryOVSHbQTMGPND9R4/vV0DqWX1U8fhYfBfJ4XpTqg=
X-Received: by 2002:a19:a418:: with SMTP id q24mr5846648lfc.649.1620384709817;
 Fri, 07 May 2021 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210503185228.1518131-1-clabbe@baylibre.com> <20210506203435.GA1432800@bjorn-Precision-5520>
In-Reply-To: <20210506203435.GA1432800@bjorn-Precision-5520>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 May 2021 12:51:39 +0200
Message-ID: <CACRpkdbQvvcyrXP9fFwvppDRiJOxxESRVkodqSKc7CoO3Bm00Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 10:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> I think it's nicer when content changes are in a separate patch from
> format conversion patches.  Otherwise it's really hard to see the
> content changes in the patch.
>
> Maybe a preliminary patch could fix whatever is actually broken?
>
> Rob suggested a bunch of things that could be dropped.  Maybe those
> could be removed in a second preliminary patch before the conversion?
> Or maybe the removals are only possible *because* of the conversion?
> I'm not a yaml expert.

A bit of taste is involved. The old .txt bindings are for processing
by human brain power. Those lack regular syntax and strictness
because brains are designed for evolved natural languages.

The YAML on the other hand is a chomsky type-3 strict regular
language and the .yaml file (and includes) defines this strict regular
grammar and as such admits less mistakes. The upside is that
it enforces some order.

In the process of moving to YAML we often discover a slew of
mistakes and the initiative often comes with the ambition to add
or modernize something.

In this case I wouldn't care with stepwise fixing because the
platform is modernized by a handful of people who all know
what is going on, so there is noone to confuse other than the
subsystem maintainer and the result will end up in the same
kernel release anyway.

Yours,
Linus Walleij
