Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74293FE30D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbhIATcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbhIATcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:32:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA2C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 12:31:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so1422934lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhceOkZW/Lw79AULcxOwhUdsCICxdzvZ661/jsJbbQs=;
        b=ADe55B0ktqUUkzvIT1RzXepW8sk7HHlHGxmQB292D+H+GdV7yQH6JpWbwKEgi6k04C
         1I0RSEkL6IDfktI8iowp8q3DjUY7mybAGnROqzOMFvNxKg2dbBqgRlCfLQnroqnKIsr0
         jnsWzK2YcI3B7IUhK7F7CwRABmnnYLoj2FD4G2W+fZ3YeD2UF79+hHWAp/viAx/WEw4K
         ohlq58Og6aWaLSfkN2RaJsPVEq6KqWLg4aI2E9c2S1LqCABZnqs04K4w+pivlcQFYKQq
         76ghks6yH4v3rmBdZkZCdoVJq3mq7Ub4Ur4fJglY+CddBJh4O4DeZBm5pOr9wW4/exdR
         ijZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhceOkZW/Lw79AULcxOwhUdsCICxdzvZ661/jsJbbQs=;
        b=HaPM7F/An8urjbUi/mqlYrQiO9k8c2nIx6erFZ2x7227kf8x7F66EjGgthiutQyeB4
         tSS9xwz/KxXcDCyOutZyseBByECukQ3rMAQ0lWZg1R6wgT03VJcnQ48DtaisMVh0R88y
         b/jzVOZaX4NWJYuG3lOBLyVpy9Aj6YJJzrGkHqQYiZ5/d++fyxaU4fFyHRNbgz4qAvAk
         KBFzUZwT30LUuKOWV0JkFtRZY0jlnsvrMb6fzdQlCxyY+iLFjoFC9Ev9d0BdoP21CcqZ
         kDeSOgQBddHXvBmgyXMRGYHtVwBLuPHEdH/02rEhjN8nAo7eTz59lYt22X02gXyp2ASz
         BZ+A==
X-Gm-Message-State: AOAM532s0EhEvd3H2fSps2MTJkCA7dkLHMkH40lzokHP/TsSBmGvN6UW
        P8gojh3v1at4qF9Z+7tfrXFtiWdqBQowYzyv31FuqA==
X-Google-Smtp-Source: ABdhPJyCbbpcIqH9pWpTHrFhlzCzND3oDcxn/8oKC7RMCOisPoPm3ujZA6d59OL5bAfD11tOwx0Hd0z4fvXXvhGq8Cw=
X-Received: by 2002:a19:c350:: with SMTP id t77mr725925lff.7.1630524703051;
 Wed, 01 Sep 2021 12:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630498020.git.mchehab+huawei@kernel.org> <b1ea71426ecf21bbfd598a6bf7951d884fcc5e1a.1630498020.git.mchehab+huawei@kernel.org>
In-Reply-To: <b1ea71426ecf21bbfd598a6bf7951d884fcc5e1a.1630498020.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 1 Sep 2021 12:31:31 -0700
Message-ID: <CALAqxLW6MeZFLT2eGyu+oipBfF=L-zLoGq-wS_N5SJbKkVUGPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: hisilicon: Add usb mux hub for hikey960
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 5:23 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> From: John Stultz <john.stultz@linaro.org>
>

My apologies for not writing a proper patch description & s-o-b on the
commit you pulled this from!
I had split it out from an earlier patch that was sent upstream and
didn't get to cleaning it up.

> Add dt bindings for Kirin 960 USB HUB. Such board comes with an
> integrated USB HUB provided via a Microchip USB5734 4-port high-speed
> hub controller.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Feel free to add:
  Signed-off-by: John Stultz <john.stultz@linaro.org>
to the patch.

Thanks for continuing to push this upstream!
-john
