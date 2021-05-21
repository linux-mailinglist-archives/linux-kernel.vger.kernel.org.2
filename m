Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3823838C84E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhEUNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhEUNi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A0C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s7so4068566iov.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTl2sSUU/s7VqJED6BBjvvTTnkniEWQTs02ROUyY35U=;
        b=BYahTz/2unNRZyj5oIDnvi41zYnBfRj4coQDpobKujlEc0wBN8as9PE6id1T2r+OqO
         wo2+h6DS9JZ7IVtET7EEOeegtmZg8t1Yuh/rlkvxZldK0mwLkcUm4wuwk72iDgsOXqk9
         GF9LHuhDFpj6idVeDTo90zSCNGKHnQqZyyKDHUf44aCSR7QLP+uSAgXR0acL9juPHiEj
         RuHzOHrgt56iIgbWmcn8s5CNaazEs8aR1+DQqm5/PdZTDV1OQ4piS8vSJbHdP7eZZjvy
         sX/Ov4UDny+2bXWvn0azbM2fGG9Ox/UXnMRXmqPTDSTmEAMVaVIW/BE3dR59DG39Ggwz
         rPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTl2sSUU/s7VqJED6BBjvvTTnkniEWQTs02ROUyY35U=;
        b=kzN0l43V6QFcpbsMxfigeK7pW6CLTbPfShIfbhr0xjhENJFfvpyOP0YIXOja+Sfc73
         8Bb13umVmcOD5Wmwsk+SaDAPw0uFUz29YmBHO/AinNdQb4OM2HDrkJce/yxpNEM479eB
         BSfqEH11QlVx4yKkDGPjk7gGVpqLzgDtxsZWR7LDnK2IMQL8XBa0apz0H8Z6fAdGMw8a
         jiFFJSFpnQnsLy0pXaQdJFu5SLPzYgo4/ceFgb0lI4AU/r9iJZOcBR8CElGiPC/vCKbY
         IFsbgOWtsfz7zF6A4fLHdZ7s/BWpfGQsJ+am3T50i8rnvebXjJTfGa+RlK9o3KZRBx31
         2h/A==
X-Gm-Message-State: AOAM531RKcBcxTCM35TZ+v1UfUhstevqAPpaboPS6ieCD7VADJQ/5RCK
        QSGRdXANMqK/r5hsN1pUFbUUXpNSGdNRvrAtCK54Gg==
X-Google-Smtp-Source: ABdhPJxteMqua21cI5k0SroJrGXwA1Ap+kuKB8k2NuAdu4F7fPSRrlrKGWsEOEctuuLB9dPBwaK0FXXFxOv9zkrQwy0=
X-Received: by 2002:a6b:e00a:: with SMTP id z10mr12609020iog.109.1621604252650;
 Fri, 21 May 2021 06:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-6-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-6-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:21 +0800
Message-ID: <CA+Px+wUaA9o+Aom4weuTH4TDpCfFpxv0YHDArCJswEs6QmCw0A@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] media: mtk-vcodec: venc: support START and STOP commands
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> [hsinyi: fix double-free issue if flush buffer was not dequeued by the
> time streamoff is called]
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Per guideline[1]:
> Notably, the last Signed-off-by: must always be that of the developer submitting the patch.

In the case, should you provide another signed-off at the last line?

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
