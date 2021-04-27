Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87136C639
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhD0Mnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhD0Mno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:43:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34CAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:43:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so1008676wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQtkoa8nt/6X+kphKb37Kf/4r12w9grvZXTPGm25gY0=;
        b=GOuWS3W4d4Llb3YmmZ+x62c0Cszu7i5TSOpZas6ntQe3DIfQMGsa+eyzOtpl6sPHzj
         KJpoZoasVZhuqGST3LyyWSKG9jok9FrAQoCHKcpmIWwpVmlYK2wf5quJCxid7dmjIdC0
         PFqos0XJPhnpY5kpziLDRy5E1Uy8ryGdERORZQJ3VQDsKoxar242uMHeDM0iFKP4wv6k
         1qIAlDQi5Wq3PTpr7hmSmoPW1zZWHw0uPZgDxbAk9P41/t8mp070in6oirEHE9ZnN1SM
         k6Fvyid31YwhsamnjK/9x/U0GjVBYOQshY4VmnvrXvsegCqQZ2DobLIypwd/AkqLneHZ
         D4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQtkoa8nt/6X+kphKb37Kf/4r12w9grvZXTPGm25gY0=;
        b=X23w4/2pTJ2vvsa56dpEVYYewsh0LORpDaDbv/IbkrBANjdoIouT8NM5q/7p74p0H/
         191ItmN45KZo/+VYIXwqhczvbt57un0eiuME7qrziMNc+/yW6aaggEUf2DzpGMfX47ni
         WWOZUhtBhW11s8v2WebHoQ4Fy7zANdiTH3PdxL6KEExbI9rvAW517FWTDhbERqIBt7x1
         bbzLtq9falAgWxnqx0aXXFxhIFqa2IcI3p+CloasuxEFbepe/ep9qFToff6i6/rwWO6m
         VhAxRUfQ1RGldTiPTqx0h7eKQAJVNCp0SwuKLSKCzu1yOq5bS0O0xZiiu8VFI1vEE3lq
         yMow==
X-Gm-Message-State: AOAM530VwQLyqqsM+ArclvVqkTq0LSiAUuQ/PEfqM5VyEMRi8q/OQvJs
        Cak8pp9JKTpPe5d7SzVj1fc=
X-Google-Smtp-Source: ABdhPJyBcGBVAC+T03DaBKMkroUTCDux2+Ph7KSA7cPWHpewt1h4cGHMxshP2AZvO/MhUhUpwxC8qg==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr4057682wmh.174.1619527379642;
        Tue, 27 Apr 2021 05:42:59 -0700 (PDT)
Received: from agape.jhs ([5.171.81.92])
        by smtp.gmail.com with ESMTPSA id c15sm4009645wrr.3.2021.04.27.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:42:59 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:42:56 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/50] staging: rtl8723bs: remove all remaining debug
 macros in rtw_debug.h
Message-ID: <20210427124255.GB1399@agape.jhs>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
 <YIfwL3s5hdRTCNrm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIfwL3s5hdRTCNrm@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:06:23PM +0200, Greg KH wrote:
> On Sat, Apr 24, 2021 at 11:01:43AM +0200, Fabio Aiuto wrote:
> > This patchset removes all remaining debug macros in rtw_debug.h
> > 
> > DBG_871X_SEL macro is replaced with netdev_dbg() for it does
> > a raw printk call which is not best recommended for a driver.
> > 
> > @@
> > expression sel;
> > expression list args;
> > identifier padapter;
> > identifier func;
> > @@
> > 
> > func(..., struct adapter *padapter, ...) {
> >         <...
> > -       DBG_871X_SEL(sel, args);
> > +       netdev_dbg(padapter->pnetdev, args);
> >         ...>
> > 
> > unused _DBG_871X_LEVEL macro declaration is removed.
> > 
> > Beautified register dump in core/rtw_debug.c 
> > 
> > Some code cleaning is done and all other private component tracing
> > macros are removed.
> 
> Nice work, thanks for doing all of this!  Now queued up for 5.14-rc1.
> 
> greg k-h

thank you all for helping me,

fabio
