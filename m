Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03831E665
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhBRGnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhBRGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:30:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2CEC0613D6;
        Wed, 17 Feb 2021 22:29:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w18so605967pfu.9;
        Wed, 17 Feb 2021 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHtGxWfPAIZEvBnGmWjlN6rdZWQnYSnX/GzqtFWIJg0=;
        b=TOewui0lXbhSkNw7mI+ljNrV0hf31Mu/TsPD3Fa99a3Vr6Wnm9DSIF/fn+PxPmZ2lm
         tCnpqmbQxbbYKPyZ2OPqkaj6iPF5hyQ8q2gKRvD3mQhYO7RH1mLUtxn0q/rU7DEZh/Tk
         8UXeYOMrr6MU7miSrQLfrsEcrdOWVSbATP8L3D3gyfXYo7wZnYkAhxBTipoRQKbDk3C9
         GWgh7s/u/U+rg2KvPgji7XIDuKTEWX5JjU/XkNK/F9/9u/QFi4SWv15o96VYRaiH1GLh
         PnbZTKe0NUeT9DyLjPVv8Z0CAbWHpNI0B+WwpKg6cj6gGW/F5oeygzONeFkGEguL2F2M
         n/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHtGxWfPAIZEvBnGmWjlN6rdZWQnYSnX/GzqtFWIJg0=;
        b=QfhDWJzizPCkxYIcxA3Faznt1rnLp0c2VRHwUnfNpqoCphzVSL3uszUDW67jO2d9S6
         +bJFmUUYeZ0hxO2TEX9pVOAoQbJD14iTYxoBrPhG/m/GnxhjCwJnbTTXNajyQfx80jUx
         fksBbLboY1mTXaFB279A+TbUDxNsmX3AU/GEdJYaM1QOhvsWgLffMyBGFIJPmNAXKr3K
         Mba6n5C36JBErS0iLfwYa2AZn7gRuNXdUvqP/aGeedyxmBptBbh3MRFmpalPRs/IkOtN
         jsV4Ndkc+40qFuzE5MmEXqaL+DyWZDiyvw7vyRoJBXR2IFRFNMPSwuf8bNfWUQS73KUk
         3Vtg==
X-Gm-Message-State: AOAM5327N6NMEeT/tBywc48TYyqpMoan+f5LcP70Kvm84bBbm2d51xx9
        n8C8HeU5T8H8LOpcdRvsdjHRsFVsdSxC6A==
X-Google-Smtp-Source: ABdhPJz8GKaArYRWqmtdtU85HLb1nnRXNt3gTtJ3OrKL0M5imqMeyfTUhg3Lq3SEzz53Npy/tWIGpA==
X-Received: by 2002:a63:547:: with SMTP id 68mr2736959pgf.196.1613629786117;
        Wed, 17 Feb 2021 22:29:46 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l144sm4436954pfd.104.2021.02.17.22.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Feb 2021 22:29:45 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:30:39 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Timur Tabi <timur@kernel.org>, kernel-janitors@vger.kernel.org,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: fsl: drop unneeded snd_soc_dai_set_drvdata
Message-ID: <20210218063038.GB13668@Asurada-Nvidia>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
 <20210213101907.1318496-5-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213101907.1318496-5-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 11:19:07AM +0100, Julia Lawall wrote:
> snd_soc_dai_set_drvdata is not needed when the set data comes from
> snd_soc_dai_get_drvdata or dev_get_drvdata.  The problem was fixed
> usingthe following semantic patch: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,y,e;
> @@
> 	x = dev_get_drvdata(y->dev)
> 	... when != x = e
> -	snd_soc_dai_set_drvdata(y,x);
> 
> @@
> expression x,y,e;
> @@
> 	x = snd_soc_dai_get_drvdata(y)
> 	... when != x = e
> -	snd_soc_dai_set_drvdata(y,x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
