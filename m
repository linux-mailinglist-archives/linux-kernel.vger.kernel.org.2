Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525A23907FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhEYRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhEYRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:43:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1E5161400;
        Tue, 25 May 2021 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621964519;
        bh=dOArAgu7ZC4cRYJFEGVi56ncg4H0XnoVUko1P1dIZn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kAdF+LoXT11CuF1cPHOzYW1U0M8ChNl0RIvW5F5tmBSOJ/0Zz8FrZQSY6J4Q3diHR
         hgaUMXW5ejvQia/hozy3hbbyrkdpjOfs3heLX61ZG8H3VgKM4ZUWsPaqrxgsivkbpC
         6e6Or3oQ7/Zou9F6iMQLY2jf0rhRSOXI5O305K8jE+mEtE3w8/MOJ0tcPAzqD8ChRS
         D6vMfBOwJbwv4fLGvUUg3EaCwLf7WZYHYzWIw4Ng8kA/DlBVwEh7FzaB54gSSPIqUE
         PjOAwu+HvnsXgIcT+ihHqaCnXtTsekgnFWoNtoJKV7+QtNtOg8wDOmj+yIKibJkCMl
         xsWK3rPRNcNhQ==
Received: by mail-ed1-f44.google.com with SMTP id r11so37180912edt.13;
        Tue, 25 May 2021 10:41:58 -0700 (PDT)
X-Gm-Message-State: AOAM531lzpVPgtm1hl6Hmo9i2Ly9YuwuwEYWX6lI8R/QW2XwbF1duUOz
        rEuURmWQRXGB4a/lga33oCW4IOULXgx4zstBAw==
X-Google-Smtp-Source: ABdhPJzLJeb1QNBqzEiRLC8bN1RXJUTLRhZ4rPY1kCOuA7jctny5RqRboDeLgsBZKUAq1VQNAVUj3UzKlSCwkNqwaVg=
X-Received: by 2002:a05:6402:c7:: with SMTP id i7mr33618826edu.194.1621964517456;
 Tue, 25 May 2021 10:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210524182745.22923-1-sven@svenpeter.dev>
In-Reply-To: <20210524182745.22923-1-sven@svenpeter.dev>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 25 May 2021 12:41:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
Message-ID: <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 clock gate driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     devicetree@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 1:28 PM Sven Peter <sven@svenpeter.dev> wrote:
>
>
> Hi,
>
> This series adds support for the clock gates present in Apple's SoCs such as
> the M1.
>
> These SoCs have various clock gates for their peripherals usually located in
> one or two MMIO regions. Each clock gate is a single 32 bit register which
> contains bits for the requested and the actual mode. The mode is represented by
> four bits. We however only care about "everything enabled" (0b1111) and
> "everything disabled" (0b000) for now. The other modes are probably different
> low-power states which don't even seem to be used by MacOS. The actual power
> management is located in a different region (and probably handled by a separate
> processor on the M1).
>
> Additionally, these clocks have a topology that is usually specified in Apple's
> Device Tree. As far as I can tell most Linux drivers seem to encode this topology
> directly in the source code though. Despite this, we would still like to encode
> the topology in the device tree itself:

We only define leaf clocks primarily. There's some exceptions such as
if PLLs are a separate h/w block. The reason for this is because
typical SoCs have 100s of just leaf clocks. If we tried to model
everything, it would never be complete nor correct. Actually, we did
try that at first.

> Apple seems to only change HW blocks when they have a very good reason and even
> then they seem to keep the changes minimal. This specific clock gate MMIO block
> has already been used in the Apple A7 released in 2013. The only differences
> since then are the available clocks (which can be identified by a simple offset)
> and their topology.

Clock gates are easy. What about muxes, dividers, etc.?

> It's likely that Apple will still use this block in future SoCs as well. By
> encoding the clock gate topology inside the device tree as well we can use a
> single driver and only need updates to the device tree once they are released.
> This might allow end users to already run their favorite distribution by just
> updating the bootloader with a new device tree instead of having to wait until
> the new topology is integrated into their distro kernel.
>
> Additionally, the driver itself can be kept very simple and not much code needs
> to be duplicated and then updated for each new SoC between various consumers of
> these device tree nodes (Linux, u-boot, and OpenBSD for now).
>
>
> This series therefore creates a single device tree node for each clock gate.
> This unfortunately maps a whole page out of which only a single register will
> be used for each node.
>
> The other alternative I considered was to create a syscon/simple-mfd node
> and have the clock nodes as children. The gates would then use a regmap which
> would only require a single entry in the pagetable for all clocks. I decided
> against this option since the clock gate MMIO region actually isn't a
> multi-function device.

I would do a single node per mmio region with the register offset (or
offset / 4) being the clock id. This can still support new SoCs easily
if you have a fallback compatible. If you want/need to get all the
clocks, just walk the DT 'clocks' properties and extract all the IDs.

Rob
