Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886E4330E96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHMnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCHMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:42:51 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF91C06174A;
        Mon,  8 Mar 2021 04:42:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 2so15889441ljr.5;
        Mon, 08 Mar 2021 04:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76ddE+8cbPtUkDVYon6UBU5B401mQDob7OOEc8vXh1I=;
        b=C3Wqg2NrLknqa+1NPIk7kXMkaDqdgVDi/OUlwJUV9MDtoRtEyA99KdeAzQfs1/4jcg
         yz3Mi92Odji1y3IiURNKpiBH99hgWFlhMz5/oAOA7z18HvfirvE7v/zDHbJ9fIFbxStd
         YtNDAD395hDx6Deccp9VvO2YQ38B4YUB0WAeZZzlSWv2W+3KhF7O6hCKVyVOAb7TMSHG
         ib5uj7BXmEgsJbCXCcNbER/YejqRc6T8RuTffSDXsn+1lp1XQaoIOEXrup6sfSTNN16F
         wflH/jB3otq71unwznNUecFlzUG4pF8lo0oIN87zt3gNLqdusjW+bI9cScCvt6aX+aZy
         OQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76ddE+8cbPtUkDVYon6UBU5B401mQDob7OOEc8vXh1I=;
        b=Of+HvWeKjPws7ZAbau6uBulWo//NyVdZJ98V1k6sy8WSnLqQtakMvNvAw+mT3Y+ZSr
         ut58UTsJoXZd0Yx9RA2FoNwjoU1Ac0xKUOQeOXiexI9KlMG5T5571o0c8d0prupdOSr6
         vSwl93+smhvlER6vaJtk9visg4ffQraU7IFzFVbsPotv8xxi1AIU0nRIFdaBAXVzL3M3
         wizt5+n1nTBHOLPnyvj9arK0RUFU4PYi1E913hooKuItLK7SGKCJQutTdTrDqNCY935I
         5zFdYGlx2meuzE15jnZc75MjF2pT05NLNvqi9BVynjjZsckXeEzhIlEMFPOMjsDrSBn3
         MKhg==
X-Gm-Message-State: AOAM530JZIuczWgOSRw4giePFmgL2hY4y1y1GXkJ5hb2eHUB7FTylpt7
        w0EaA7ReEufgDMvnlqBRvZg+x56Sue3kbmn8+CI=
X-Google-Smtp-Source: ABdhPJztGmn4KqEP6K8B8gkXMyidtT19fts+kq8Tp6ZFZ78qtC+JITRKxSg1o0EFb29fgreO80WwhbPvmrfrpefaFn8=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr14004204ljj.116.1615207369938;
 Mon, 08 Mar 2021 04:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20210308123958.254116-1-adrien.grassein@gmail.com> <20210308123958.254116-2-adrien.grassein@gmail.com>
In-Reply-To: <20210308123958.254116-2-adrien.grassein@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 8 Mar 2021 09:42:38 -0300
Message-ID: <CAOMZO5AnLBawY9UwVa8nqdBPicyfp47_0CG38p82DRdOEYAO6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

On Mon, Mar 8, 2021 at 9:40 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> Add the description for espi support.

Nit: In the subject and commit log, it should be ecspi2 instead of espi.

With that fixed:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
