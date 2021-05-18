Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FCC38829E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352704AbhERWNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhERWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:13:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB32C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:11:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e11so13210854ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpCc4UzYh76XAJkhalJP9Pe3fpzW0B1Arhd6b/09lBY=;
        b=nJrpDvWxJJKOpXoQPYONh3Yn30C/i1X04Io/Nq153E8Rqb/jpwAkT8+uk+qCkxJFsy
         J6iDuACx9m9MZSPAtVadmMmxRlPKZCFVyM2Rn5RYXpcPodjz59G+R53BuLMbXFAWfvPu
         /wtgDHKeRRnL5TtuUdWzTOLm5Qsak+9UmFKqX3ILEvAjBqNZDAWHULBNIw79/M67fR25
         +n6d3jv9F6UpH5oW+CAcRy9oVrAVZ/d2X0yoo9Lwxv/hC3kxdeGTHhpYa0lb8GthS3K3
         4JEH5t42VNJF4EzM93ENvBjB19NO4ttw+r1wm+L2NTAOgGrwcuRQ8bFP0JF/wpukV7Hn
         7OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpCc4UzYh76XAJkhalJP9Pe3fpzW0B1Arhd6b/09lBY=;
        b=ce8KqkBYvOrJ90hUBLI+VHm93miQtewzUCTtyqBFpqFBBxy3UV+VrjQUCVXsNwYtq7
         6lCce3mtWXJREtoP8ri3swuG84IjrX9gUFG+zhQ5lw0BgnEocTqzZ21oXZ90ntpvR3W8
         eFxO9Eau36xIwQeST2v9p6c7WM6BwSH9/f4oWeWRLWO603cYVAMG6klIKvfKVG1FvS3i
         Z9FfbVcWxgWLYOUnSq2a7VoADsH05SNv7+gu494iZ/o/Rp+IoqHmmso5ME1cpN+gP9La
         AlBiRmNnGXA5B8t3q/Oj/g+F1eWE8VDpHolC57ooYkOIuNZdS0xauuz7V7kUF0miM2yp
         beGA==
X-Gm-Message-State: AOAM531XBJB5J9RhGoOFD8apl92cCZCdGRyGXDZfHBzfj2u8+GOEC1/M
        366utnPD709qIiJm9ALB3WkgTVwZCfTuFvG5XDdzDg==
X-Google-Smtp-Source: ABdhPJzLctTgHuPP+2M9Xf48IbRYzzVeN/XJLgmyamF0RPfhgoakVwyjMTSXV4w9PJw+vN+NOCckQxeskqODSJXUsFI=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr5704735lji.273.1621375912057;
 Tue, 18 May 2021 15:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liydV-0004rQ-Ed@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1liydV-0004rQ-Ed@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:11:41 +0200
Message-ID: <CACRpkdY6COKVmzmYE3PvRTuAtBMnJnGUdnhRZHc_-OJXoqZb2w@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: use a temporary variable to hold maximum vmalloc size
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> We calculate the maximum size of the vmalloc space twice in
> early_vmalloc(). Use a temporary variable to hold this value.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
