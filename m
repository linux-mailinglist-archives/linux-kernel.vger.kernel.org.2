Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8463F3DF890
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhHCXhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhHCXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:37:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7244C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:37:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p38so1440987lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+ZNRa3Fa7h6xK5W8Rh5SLUVbfrCG4CmAex8urzhGHo=;
        b=DGhOqDh7ZHU68L9oe7ltGFRmRvzBUWzziBWLrJwtwjB1WrikZ4jU2QxL4etFa42zVc
         zsCdXuxSqBZI78Cfc1luYoLpnzALBilDVjIrPaR0RcPwSI5VBKI31MM+0YF8re6UxHW1
         wA9i43iW/lPNsLonXunis2oU9egE11WDkZpg4L+lDaDmdV5DV2KnV3AicVMto13vuF2V
         PN+ah700y8hWNtas/txn5TPJazGb3WONNSEtY78rN2lrjz1ePRJ+XphoBR9+rqDIbWM3
         aj+Vte51PQJ4XueZywdjPXkSUJox++YZ9lWs1m7T03bzn1lcczQqFV55vc9Nkee7IXVS
         GKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+ZNRa3Fa7h6xK5W8Rh5SLUVbfrCG4CmAex8urzhGHo=;
        b=e3w3umv8ycuh/5EOAL6gpe4RRtdC9+whrjwUSJuubqko9YfGOaqrVhqhdh3HfI4kLM
         sIVAffUD50EJgIpDJWfhuZcb28JIWhmJP916p2etdgZsfUE47yy2c7Pg9StoxGtulG2+
         pv9V92D8yB/X9z2PbE2X3FdPY/eSuj2Nu7QwB2U8U6jW9Br70O1xmtiyG9apoLUq3PuI
         lwVqOEvFOZ8/JyLZg8vOvppw2JJ4zFyJ3LN6CtlKSFjqqehpLFWtpJGUTS9XkMWQlKKO
         YgIb1+ddVAigmMLKnMqyoQ4urErvNG2BdkedeMjEChaOssEoNwEHyjMJjORoj/ui0YGf
         5Plg==
X-Gm-Message-State: AOAM533K/BKuaDnvNwfZ7A11RGNmyG332dTBHkg46ppPZhBYD9/tdyt7
        +UyTy+4LxuL42SKmwZpUVN1jQzDp3N3WUayTeJjF1A==
X-Google-Smtp-Source: ABdhPJzQXkQ8WPty1lbHlAl81pgRiJlAVJ9e63EcOkNUkNslRN6/62k1r9Y7LZMKzP7bOoo9e0kwHP8ZqKK+8FFomFk=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr17211434lff.465.1628033826208;
 Tue, 03 Aug 2021 16:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210803081728.2085286-1-arnd@kernel.org>
In-Reply-To: <20210803081728.2085286-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 01:36:54 +0200
Message-ID: <CACRpkdZ2UVZbHdJSx3Of0=VOgrJeFgrsyrU8AfnyR_dv4hmcMQ@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx/qmgr: fix invalid __iomem access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khc@pm.waw.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:17 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Sparse reports a compile time warning when dereferencing an
> __iomem pointer:
>
> drivers/soc/ixp4xx/ixp4xx-qmgr.c:149:37: warning: dereference of noderef expression
> drivers/soc/ixp4xx/ixp4xx-qmgr.c:153:40: warning: dereference of noderef expression
> drivers/soc/ixp4xx/ixp4xx-qmgr.c:154:40: warning: dereference of noderef expression
> drivers/soc/ixp4xx/ixp4xx-qmgr.c:174:38: warning: dereference of noderef expression
> drivers/soc/ixp4xx/ixp4xx-qmgr.c:174:44: warning: dereference of noderef expression
>
> Use __raw_readl() here for consistency with the rest of the file.
> This should really get converted to some proper accessor, as the
> __raw functions are not meant to be used in drivers, but the driver
> has used these since the start, so for the moment, let's only fix
> the warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: d4c9e9fc9751 ("IXP42x: Add QMgr support for IXP425 rev. A0 processors.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
