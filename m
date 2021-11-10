Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAC44BEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKJKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhKJKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:32:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A834C0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c4so2289960pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtnO7Bm6moxapJOpDmqW3UadGBsmBZSmf1oZQVTs5BY=;
        b=P3Zjx0Hyq+32RzMf/e+0TH7R6bZPDc1VQVGRm6mJklPXjJ3E2y7zll3a/h5hwzInd2
         d63C9cHfkm618jGYGz2nEbxTURHcRncu7AQy7kda908zmtTJmYdpod2M+GxzBQkOgAaW
         3pyJW9FPadAoWPwK/fx0Dc1zYve3/+A99znjsQy0RNF26CBDA/mW1FQOyXjer+8hdQVg
         KHPaswheEtKBH09v60AmcUAH3/2TMbbowGDQYdmswgZ4HnwD6jwN7jpBmhO36SZb2VhP
         uAzn+IF5SvZbDi5vO8caloxssl1Sqt0FspfoohNqFJyd62Cg6vs5JINLSu6arcJ/cviJ
         L0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtnO7Bm6moxapJOpDmqW3UadGBsmBZSmf1oZQVTs5BY=;
        b=TqqUQX5IVjsAcRGgmOmY4cyi1ySQRB0kKwDCY4UuIX91ELxqVvSvTrMn0LejW0l67t
         GBs+V4VXLlW5ht45ANbzAnu7ySmEmQ6lg4dMvYDOuUHDCS5X93HG/OyhYO0r+Fn6NPGY
         qYq90IlYPwwrjrPcjM1rOonyouALe9b4rKf/35bL5BgYiGcvb4ktcn+TxaN+WwC6A4/w
         BYLzSOsgnce95mPpsAziquWa64ucRmcFl5volyZOjCSi1tJ/qj1f5Pz64xBCCVr17VNx
         Fwz471ETGgnRXXdSEY7JFSg5lErPsfPGno+JLlAIvcHzgNb1FQ1pS0Ka3O+h4p6eN1N6
         HN8g==
X-Gm-Message-State: AOAM531Odvb7QpnlxcB9EZ+LLBXRnfwjzvud8QiFwaAzLPPiVvGG+voi
        PjPTGJl+wIb2cFm7v9yIDIxZxYLADqCkAXo/7Vj/2A==
X-Google-Smtp-Source: ABdhPJybXxLo5OYv4x3FX2EtYjPECd+qMB38G5dsYqeB2wevijTEozvPGP7GKTPKRoWDFUr1d6wpqdx/mT+1NE8lE1U=
X-Received: by 2002:a63:9518:: with SMTP id p24mr11113932pgd.80.1636540205425;
 Wed, 10 Nov 2021 02:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20211109125030.26299-1-yunfei.dong@mediatek.com> <20211109125030.26299-4-yunfei.dong@mediatek.com>
In-Reply-To: <20211109125030.26299-4-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 10 Nov 2021 18:29:54 +0800
Message-ID: <CA+Px+wXw96jDAbtuJ-Mt5MnY9D4xPX-6wGZq5U_hwhrg+5UNPA@mail.gmail.com>
Subject: Re: [PATCH v9, 03/19] media: mtk-vcodec: Refactor vcodec pm interface
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 08:50:14PM +0800, Yunfei Dong wrote:
> Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

s/B/b/, the suggested tag name is "Reviewed-by"[1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
