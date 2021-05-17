Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B0383962
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbhEQQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244768AbhEQPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6487F610A2;
        Mon, 17 May 2021 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621264384;
        bh=W5xkZsukITwxD2vyq79yAHhInfmLtEQuAjuviEfY5Gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJQmSbUHURNv1p453cVx1E+CiI67NzqNDt5EQVhK0jwX2D4kJhMgTyUdWRO+YOwQI
         yaORaFDJh4XkfzmcgS2naqPTjXGDFq3MZiB3+jLg9fzb2CWC5YMga98J8bmtPynkjN
         Vgf5NJeLR+L+mhS4kWK5tCEQk2tBjfduCc+BZmCKH2k9oYyyErNYe+HE626ey8YIIy
         SvE4Gn78abXd3w/CPbc8cDS3TloZX156Ifmxxpv6ZlwWCo/4N0jStnSTjlhMB3ctKy
         wNa9B1wCU8XIthaxJDrgpCdDLPEoVkFY+1FSWcvyxNT8VBsVkYAIUo4QmSYlSFo+LZ
         JOjovBjkqgkCA==
Received: by mail-ed1-f54.google.com with SMTP id di13so7363173edb.2;
        Mon, 17 May 2021 08:13:04 -0700 (PDT)
X-Gm-Message-State: AOAM531yx8U/Gg/LP1wX6QowW4JFYIyGFS2CK8EOxFEyzpv6Iq/s5ZVN
        jHQOCKIC50LZX8jh/1FBYTAlpj0GNeIA6hTGIA==
X-Google-Smtp-Source: ABdhPJzlXPKQhfjtV7b7SxTeY0v65tOCReL5EfTzNb8MxkY9dfVx8RFPbEhGN+/BM+4NxfE1ePCtAV3Swas4r/nkUOA=
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr579637edu.165.1621264382986;
 Mon, 17 May 2021 08:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210424110608.15748-3-michael@walle.cc> <20210510104411.11267-1-miquel.raynal@bootlin.com>
In-Reply-To: <20210510104411.11267-1-miquel.raynal@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 May 2021 10:12:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK3Wym+ERaQ0np-v8HM39TyNUTAwbhKHPasOPx5xnMNsQ@mail.gmail.com>
Message-ID: <CAL_JsqK3Wym+ERaQ0np-v8HM39TyNUTAwbhKHPasOPx5xnMNsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mtd: add YAML schema for the generic
 MTD bindings
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Walle <michael@walle.cc>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 5:44 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> On Sat, 2021-04-24 at 11:06:05 UTC, Michael Walle wrote:
> > Convert MTD's common.txt to mtd.yaml.
> >
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

This is causing a warning in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-mux.example.dt.yaml:
spi-flash@0: $nodename:0: 'spi-flash@0' does not match '^flash(@.*)?$'
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

Rob
