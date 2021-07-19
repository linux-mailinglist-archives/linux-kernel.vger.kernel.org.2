Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C13CCBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhGSAYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhGSAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:24:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC10C061762;
        Sun, 18 Jul 2021 17:21:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c9so11825183qte.6;
        Sun, 18 Jul 2021 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQlb32Xcquwq5O+moyXyr2cv7lcEnQc7zGUkRIGd6qw=;
        b=XjSJFoqHF0w+1N19d1VBtut4ASDUGdWnCcgVzyOcOyCyAanXzijpNIjLnjhGUlgNQw
         OgrEC/BETKGVv+TtHupXHvabK276D3kPZN1ycV8WW0Ulj4IfXYsPtPjV4btws7bgUBQF
         j2/RygvPCJ5lhFpqdtvwO5eb/a3pnfCZOp+tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQlb32Xcquwq5O+moyXyr2cv7lcEnQc7zGUkRIGd6qw=;
        b=i09esLiBGU/T5rGLI4TZ+OP1OIMj5Bq3h7kTQ1k7Qr9iBXMQOooGeprUmPzG31P9EF
         Jf1BDkteWH3yk4U0MPicYuqgtl+J7xNom4LJf2TcuThTYpCNHGBqtLo6BG64o1IsSQ9z
         ALve2qqwL9sRm2RACsyuUqhkD4Ii9VERPWp9JPbHYdklrYAx1XlamB6vrPNoDcuuUuHa
         tFUHl9jWT1K4cZ4TMoTmoUxzCzd2s9pBed/Lgy86hn/AyyNZGzihQoVMxvV+tT19XftX
         LNDdQmGTNQMSGlpbqEtQJ2514bwiKvnUKBu9uzc2JA24Gnr9EYmvu8gfO1VLp5sPfvjx
         37iw==
X-Gm-Message-State: AOAM533WhWtWb+LB2Y+/3on3HSU33Pmn9Sl1Sd8m6sJ31VYHriGUecJf
        3oq0I3B7Wtlc/Gjo6juymn19mS7JegfoHSDNCyE=
X-Google-Smtp-Source: ABdhPJy5BjlQeNvPbsdNVhod51JfFEBvP1NOYo9hOCh8Hus/j5w8WhmKY/FRufZ1Eem2lbZkDxk71TMaz/9zC6gebsE=
X-Received: by 2002:ac8:514d:: with SMTP id h13mr19795975qtn.176.1626654091899;
 Sun, 18 Jul 2021 17:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Jul 2021 00:21:20 +0000
Message-ID: <CACPK8Xdgp50KbVvhSbhrwUiTB6MJ5PoBzV9n18ubZAAOprOGiw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Enable ADC for wedge100 BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 00:17, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series enables ADC for Facebook Wedge100 BMC platform.
>
> Patch #1 enables ADC in Facebook AST2400 common dtsi because ADC is used
> on all the Facebook AST2400 Network BMC platforms.
>
> Patch #2 removes the redundant ADC entry from Wedge40 dts.
>
> Patch #3 removes the redundant ADC entry from Galaxy100 dts.
>
> Patch #4 enables the ADC voltage sensoring channels in Wedge100 dts.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks Tao, I will apply these for v5.15.
