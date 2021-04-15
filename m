Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6124360481
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhDOIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhDOIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:39:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64966C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:38:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so18712628wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FNwALlxwzocopn/d194FfhrN/a/el0rTE18i45yvvJk=;
        b=SXEMRPO2kYZAuE1b0FmXDIzOJQ9EZCMKj8qpru1CIZkUMoiIK7d3mIFPyJ77CtJDEz
         /j/G0KSVwBw0qtbNcXvjBtSbX+6D3SR23dYtSAiZoxhQc+N4FW+eK9NDUvSflDv1i6Lp
         R1Cl5v2TGgsUCBO4cRETJwll7qhRBLuUgRaAu89CVLcuEnX2JzF8ohvj6UzO5wUCY+Kn
         wekV6ZxuTCnCHkjwZmNl82YHok2dlanIicGF9HH71w/ZuCNxCYMI42LFyP0ggvv0jmf6
         5Dp0/XdEY7z6gbjmuzYHDIOLBNymuF8zMpq0+ASxg7MGYn+THkFv8asa1xMAWNvAffba
         u+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FNwALlxwzocopn/d194FfhrN/a/el0rTE18i45yvvJk=;
        b=V5tItV3Om2kBkvj11IIffgoTq/aFWVd8CBZl5k9cON7QlUrV68vacmBLI4rg46IUPc
         VUkIygPkJ7TFEhEhSMAoYNLjvP8Y56pJhCaSGaP0M7GoJNhM3zk+XoniLyCys2wTqoKv
         LiJv8z2h3kxMz/gzeKQlMLDzgqjm2kDln483GnepcA1XW+lKuau1GXjASiMO6hrSEtZN
         +1YTXYG7axU0J6MudQn6baCyHFz9m4Sv6f7Buuy5/inCWUXJunJ95i17x+VS33MB2Dum
         eNixvt9KV0cseT4iZDolFco0GxNXLmElWLg6WXI+IwF9Kt36D9m3uzNfkOeZSsHwbkCr
         UJ0A==
X-Gm-Message-State: AOAM5337trz7iz3L2D7Ww3hcl4uAoYI6dUAZ8SRSDi8FmeEthPGcUJmz
        1/qYtKNOvKEBYTORZSxYQ08=
X-Google-Smtp-Source: ABdhPJw7HvS/3A53Z/DCPvk73sL2uNGOFXh3SnPCFUQ1tKHCN3cpZjWVze3HPyybtj9ndPYSIkDCXA==
X-Received: by 2002:a5d:66cf:: with SMTP id k15mr2259143wrw.404.1618475918186;
        Thu, 15 Apr 2021 01:38:38 -0700 (PDT)
Received: from agape.jhs ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id q20sm7465639wmq.2.2021.04.15.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:38:37 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:38:35 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 15/57] staging: rtl8723bs: core: rtw_security: Demote
 non-conformant kernel-doc header
Message-ID: <20210415083834.GB1431@agape.jhs>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-16-lee.jones@linaro.org>
 <20210415080928.GA1431@agape.jhs>
 <20210415083134.GT4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415083134.GT4869@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:31:34AM +0100, Lee Jones wrote:
> On Thu, 15 Apr 2021, Fabio Aiuto wrote:
> 
> > On Wed, Apr 14, 2021 at 07:10:47PM +0100, Lee Jones wrote:
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  from drivers/staging/rtl8188eu/core/rtw_security.c:10:
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'p1k' not described in 'phase1'
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'tk' not described in 'phase1'
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'ta' not described in 'phase1'
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'rc4key' not described in 'phase2'
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'tk' not described in 'phase2'
> > >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'p1k' not described in 'phase2'
> > >  drivers/staging/rtl8723bs/core/rtw_security.c:1937: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-staging@lists.linux.dev
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> > > index 9587d89a6b24e..60b724729900e 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> > > @@ -1921,7 +1921,7 @@ const u8 rcons[] = {
> > >  	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
> > >  };
> > >  
> > > -/**
> > > +/*
> > >   * Expand the cipher key into the encryption key schedule.
> > >   *
> > >   * @return	the number of rounds for the given cipher key size.
> > 
> > Hi,
> > 
> > did you mean 'demote' in subject line?
> 
> I did.  Did I spell it incorrectly?
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

that's good, sorry for noise.

thank you,

fabio
