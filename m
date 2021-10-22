Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D184378E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhJVOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbhJVOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:18:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FB3161373;
        Fri, 22 Oct 2021 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634912201;
        bh=I+VXfPjoibNjIgn+qnRCFrsghnS2om1ehTAMQ/z8VZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AKXxsoiDFiAPsC8TKx8rmbdjFViHoVHUiMXptW6F8/PcfomMTRqqBk7WlmD4H7aV7
         lCUchvHlXBMJ3p55TysGCSIi7R+UfAPq/GEu8GLPJGDwOGDrMX5s1yJ0M+sDEIWehn
         jFORLuKq/z3co/j5mfsfMmMYzYxUleel8CLBGuipxKpiGiO80l9t7NEx0/GeCSQCyd
         gID3Oy3/QTAqdFpzppwPTgOd7Wzg3dRQD+QByDvZ5UuiHX1hFepO+pcc4/dYjP/F0x
         QPt1ckj9nm0rW+Bu9qWLoDEIag6dn5Oa6xoF7XvuAexQp1nRZKO0vbZYiTCqduLky6
         SAFhe4B+iwepA==
Received: by mail-ed1-f41.google.com with SMTP id g10so2192443edj.1;
        Fri, 22 Oct 2021 07:16:41 -0700 (PDT)
X-Gm-Message-State: AOAM5305Zpe61gV+NRLkykY/QXDHrx2no8wiHBkOcyF56BSauNvUh/76
        tHQDOrYN24Dj5iR8LtQAnu5JnPvFIDRNYkZQiA==
X-Google-Smtp-Source: ABdhPJxEy9Te8GeD+1Msa4yBTOezWnyqGiwHRtT5L7oFuNgjRAvA05EQWETuGADJ5MorxmiVbdE734tH9dP2RFnYhIo=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr15150817ejx.363.1634912197965;
 Fri, 22 Oct 2021 07:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211009104518.45596-1-david@ixit.cz> <YW86yrhJBTunU121@robh.at.kernel.org>
 <GXW81R.AUXV3AJ9VUDL@ixit.cz>
In-Reply-To: <GXW81R.AUXV3AJ9VUDL@ixit.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Oct 2021 09:16:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKD-3-VkFT5fAKrD0jFWWmBFTQHWQKSv4JrfZ515GVP_Q@mail.gmail.com>
Message-ID: <CAL_JsqKD-3-VkFT5fAKrD0jFWWmBFTQHWQKSv4JrfZ515GVP_Q@mail.gmail.com>
Subject: Re: [PATCH] WIP: dt-bindings: arm: firmware: tlm,trusted-foundations:
 Convert txt bindings to yaml
To:     David Heidelberg <david@ixit.cz>
Cc:     Stephen Warren <swarren@nvidia.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~okias/devicetree@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 5:26 PM David Heidelberg <david@ixit.cz> wrote:
>
>
>
>
> On Tue, Oct 19 2021 at 16:38:18 -0500, Rob Herring <robh@kernel.org>
> wrote:
> > On Sat, Oct 09, 2021 at 12:45:18PM +0200, David Heidelberg wrote:
> >>  Convert Trusted Foundation binding to the YAML syntax.
> >
> > Looks fine. Why WIP?
> >
>
> Can you drop the WIP prefix I forgot or should I resend?

Please resend.

Rob
