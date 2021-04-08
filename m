Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83A357EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhDHJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDHJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:11:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E3C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:10:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u17so1804795ejk.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cebnpBVTUp19RdwzFmR6GsyPKlfHDikB45ydVihbfs=;
        b=jvhOcjxhOgsQBBS5Km0GfSfMVbsV6jIYjlZ6C5yGROvR3tO8to08j1y84xEmcnk4MI
         7Q6MEHoqhNpc03e3cecctIRQLxUj3flh9oPoTZHW9iiEuqD4KZMgm61wgX740iEX+V+Q
         cdT1Dx86BAe0DoKs47BGfaffGkO7UtGCAWcksJQvgDQud/+5YbiM5AVYiT5SN7KJfJGW
         brVqQfCTJ1QYHxu/t3ZLfPlxZaB9gZP99g6NMsNTZ81HaU+C/JP44biQMe19tLQAvKR/
         vW4x3VKnyBUR1TE91zI1N6aXFuldV5gvqlxq2/6qHZ0mM8XeqoulDd4Ojeb3VzWXldLX
         rQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cebnpBVTUp19RdwzFmR6GsyPKlfHDikB45ydVihbfs=;
        b=iXXsJofde7xQ6Bm6JSPUdoeRLxVHVb3sqfPRYJyFnJKdXlgDTpyApk1pwGYMdRD+xn
         Q+aTFbFTYDcqWb/ZKaTjY2vIzwbQ82x4/PIi6TXxbK7Q2Ks7J+o3KXECO8J7D4gy+l2U
         AQTDf2dhKSrQVM+n4+LLTSx7132uE0KbE/xIfFngU0Qz8Fb9I8ZT9DpTZmTuTDEjav18
         UEftZG+sbZ6AWvAJNV1rRvUkR27rD4Jy21zoDzknO5hizVsDbB2zYgFvqs9rywUkhyjZ
         KcVBrDa6E3kitjdaIcLLy+gY51zQ3zwlnyB8wI9LccTAhMwoDO9EPXIqB+vI17q9jJaG
         fMHg==
X-Gm-Message-State: AOAM533BdHR58FsMZMjrW0u1zxRSugxSjk3WYJ9gaQg/yNSnhsVlpTbR
        zIRY8TdfLBtmqIOcRh85Hl8=
X-Google-Smtp-Source: ABdhPJwHqQHnKNFTgZV41DrGxvAlj6PDZXkDg4PDdv9LE+rxVn5DqEFzTynEkSBUo7kEgwOZS0t9PQ==
X-Received: by 2002:a17:906:688e:: with SMTP id n14mr9011306ejr.439.1617873055302;
        Thu, 08 Apr 2021 02:10:55 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id o17sm5644526ejm.13.2021.04.08.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:10:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove camelcase in several files
Date:   Thu, 08 Apr 2021 11:10:53 +0200
Message-ID: <8385147.KfrnKTb6Rc@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104081053200.5197@hadrien>
References: <20210408080714.29481-1-fmdefrancesco@gmail.com> <2284292.R3b5UFg5HO@localhost.localdomain> <alpine.DEB.2.22.394.2104081053200.5197@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 8, 2021 10:54:09 AM CEST Julia Lawall wrote:
> On Thu, 8 Apr 2021, Fabio M. De Francesco wrote:
> > On Thursday, April 8, 2021 10:36:32 AM CEST Greg KH wrote:
> > > On Thu, Apr 08, 2021 at 10:07:14AM +0200, Fabio M. De Francesco 
wrote:
> > > > Remove camelcase in a symbol that is used by several files.
> > > 
> > > What symbol?
> > 
> > I'm not sure I understand what you are asking. You mean
> > that I have to specify the name of the variable that I changed?
> > Or you mean that I shouldn't use the term "symbol" but write
> > "variable", "function", "macro", and so on?
> 
> He wants the name of the symbol.  Each changed line includes lots of
> symbols, so it is a significant effort to scan the patch to see what
> symbol is being changed.
> 
> julia
> 

Thank you for clarifying this topic,

Fabio

> > > > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > > > 
> > > >  	u8 LpsIdleCount;
> > > >  	u8 power_mgnt;
> > > >  	u8 org_power_mgnt;
> > > > 
> > > > -	u8 bFwCurrentInPSMode;
> > > > +	u8 b_fw_current_in_ps_mode;
> > > 
> > > The "b" here means "byte" so you can drop the "b_" as that means
> > > nothing, we do not use this type of notation in the kernel as the
> > > compiler can check it for us.
> > 
> > OK, I didn't know what the 'b' meant in this context. I'll drop it.
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group. To unsubscribe from this group and
> > stop receiving emails from it, send an email to
> > outreachy-kernel+unsubscribe@googlegroups.com. To view this discussion
> > on the web visit
> > https://groups.google.com/d/msgid/outreachy-kernel/2284292.R3b5UFg5HO%
> > 40localhost.localdomain.




