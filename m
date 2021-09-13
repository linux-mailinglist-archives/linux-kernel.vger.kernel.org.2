Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3EB409F50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbhIMVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhIMVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:44:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28228C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:43:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so16865017wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OmKpkwcJ/YE9wWezjvSXq5deQ9qPVPHvzIJumJjTABo=;
        b=VJ5kK3gn4RfmIRlT7llJRz9GJuTGJVhpZHQG8Q9opCOZXKl6Vp2CZR/w7NeFB4sego
         1jY001DRuIAB5lEf+qUB8vrnKMiK5TRMRDHkorLyPwUi487CtgxBTByIDitg2zCllPxz
         XffGizxWw3C1Hwx6Iz1mbRdYR3Pq9/Qd8daxvijBKGGf0ikAN8AFu+WmF1E6vK227hBY
         IdC1a/thVUsbQf/DkNJJK72mcdoeE5JQOFz3eVIz+6Oj5UQjUSg7aBWFow9vZLvaovgr
         IxATxJCuz5Pk745ioCzmRIZKF8+DLqlmYlv7gRBhZ0mNl5p//sNnaaOr3053+S6YMPyY
         ZIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OmKpkwcJ/YE9wWezjvSXq5deQ9qPVPHvzIJumJjTABo=;
        b=uE1awcS2AMv3CXliBkNwc7febHnOaBfoM2Fm7PszZbNKNq7HgO+Z7mDlnIsrRO5zZc
         AFwmwGXTJ9mrOJicJX22KXSgIriuTJelN//+RxqymbbtxsgJqzYpMBIY2eGWRokC0Cmq
         GBexCIVXWaa169dMbU4Jo3ws105O6UNy5QOAAe14EoFq3GMxLyoibubR8ZuUzQqnsiGK
         T6ebyHEG/ivVzDm3GZEgeWOv+xNKZr1x+aD450kBmr2/xsygO5toVMc/Tg09Q0YmRth5
         0Vxq3prclHCUi4VAPLJJcaWq4vcVV9o22Lw6ivzkhR84qxj+b3RdHJxTboJspU9mdKHi
         M7DA==
X-Gm-Message-State: AOAM532ULvV0BUdl17sqS5xJJZUb7FCJBoHjEyOOGXVjfhidKwQOOrIM
        QnrEA4foXPKsA5ZpDnKxAYI=
X-Google-Smtp-Source: ABdhPJwhheyzgkqdjCX+sH1wHgX7BoKIO1IfHrtLv9BwRFZK7RXmIHgtkQwKelqGxZHg0IL4MOK0GA==
X-Received: by 2002:a05:6000:18c2:: with SMTP id w2mr14816879wrq.282.1631569408749;
        Mon, 13 Sep 2021 14:43:28 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id 129sm7833393wmz.26.2021.09.13.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 14:43:28 -0700 (PDT)
Message-ID: <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Sep 2021 23:43:27 +0200
In-Reply-To: <20210726165124.GJ4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-7-nikita.shubin@maquefel.me>
         <20210726165124.GJ4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Mon, 2021-07-26 at 17:51 +0100, Mark Brown wrote:
> On Mon, Jul 26, 2021 at 04:59:54PM +0300, Nikita Shubin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > 
> > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > to Common Clock Framework, otherwise the following is visible:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

would you take the patch to a tree of yours, please?

-- 
Alexander Sverdlin.


