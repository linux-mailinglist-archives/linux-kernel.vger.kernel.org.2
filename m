Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5E3CBB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGPRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhGPRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5558B61400
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626457648;
        bh=NOjt5NjMa661VMkNCr4Q9Q1BYM1Sz/4T+eB71oGR1zY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EjAJD26kRH404deCuMRSDKWl+VCMsdEWOKNyoY1giUsSHmPyd3Abi4WPzJks+SIF5
         ixU2IqTQhlClSzB/0B8wjCmR1H/8F7O915NoF8nd6OclmXe3jiHB/XX9kFbTKF7VDi
         uOv9ZLTkryJz2QCfa83YW2soC2BWSWrxTWNDlVWFRXnaFT7DCyhW519qfk8vhy3VQK
         zNC5S98zjZAXp2izgjPH15PfzB6KutUWF+6WoCg6oE9CvSlfMgrGbGU/Nv4wZ2mauy
         rugTbhMHVD/ZunNblmj/DkxjSzNpA5K3E2isqv4/Qtt1xGylEESmKFfmVuER8byhBO
         /5BdzqF8ULSTQ==
Received: by mail-ej1-f54.google.com with SMTP id c17so16309350ejk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:47:28 -0700 (PDT)
X-Gm-Message-State: AOAM532tNMugrGqzOstj4crALfbWVmlw+jh02uhF7vMtuvkyncqQub4L
        bzK8FRhEVcpHe6XLsp/0nIGsp4al7gqO7R7hdg==
X-Google-Smtp-Source: ABdhPJwfIraRxl7lJ9oGZxXg7qn+UIhGE2SLXBe/Q0mxS7GtZlLiFpS5gOX4YT5EKeWzr0D2QFcTruKjVXt8+/Zl8oI=
X-Received: by 2002:a17:906:5fc1:: with SMTP id k1mr12803109ejv.360.1626457646957;
 Fri, 16 Jul 2021 10:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210715173750.10852-1-jason-jh.lin@mediatek.com> <20210715173750.10852-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20210715173750.10852-2-jason-jh.lin@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Jul 2021 11:47:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYtTHdkMrXGv5autnuym1sr+Gqxu5UQxY9LvtOuuKAgA@mail.gmail.com>
Message-ID: <CAL_JsqLYtTHdkMrXGv5autnuym1sr+Gqxu5UQxY9LvtOuuKAgA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] dt-bindings: mediatek: display: change txt to
 yaml file
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, nancy.lin@mediatek.com, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:43 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> Change mediatek,dislpay.txt to mediatek,display.yaml.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../display/mediatek/mediatek,disp.txt        | 219 ---------
>  .../display/mediatek/mediatek,disp.yaml       | 434 ++++++++++++++++++
>  2 files changed, 434 insertions(+), 219 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp.yaml

Please resend to DT list so that automated checks run and it's in my
review queue.

This is going to need to be split into a schema per block.

Rob
