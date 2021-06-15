Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3773A8278
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFOOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFOORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA1C0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g18so49375361edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jCJCtm9vYJmak15ODFJRZn1EfBIeulB+qvoTw8v2gPU=;
        b=A/FWT4pLZP6CT2SEt5mkBTge/L1IiQHPLJ4lcVCKbLulBhnyx8zUwTrbgioMPloz4t
         EDPcFHd+tlHV2hbXrFKztwyfPenRrqomKYlx496O1G/ZYWYPkg91Chx7A/nRZIqadhxp
         midySr7Hr/YP3rl5XGkymYpJL5ovuFfsvNlRq/bZfsZZpUG0eNEXbsck2aChCBxzb2jQ
         f7tae05HYYZlOvkgGh3h87RBbaGczFIbx6daPChN5e13QmyAT5aVasOgSl4ayPPpz3Cf
         a4ThsJSzteqkucgkUV5HcBhQwnCg+HCh1x9SbICBq+KhZteOqwCaYjPlMDJ+wrGZaHbh
         c+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jCJCtm9vYJmak15ODFJRZn1EfBIeulB+qvoTw8v2gPU=;
        b=Uhv3HBzH+6q4wcLRoF2hmm39FD0eVRxna+COMrz8Iqk2ty2rBlzla3GC7g8n5G2A+N
         4NG7UGpjbidtq+q416QtOJQmRFT3YWem/sPfFqM6Am4zKCHUJjAwDDb1FfBXLGXdN//O
         8NtxcHsed+dpaheGd0k2EPzZAVqI5QSMrhS7IWDYrGAytzL2SC9mdriCx+k7zsUFriI3
         QNhhsLebehxpuhjDojPh3UFud35UcaoEGUAZ4xvNULNiiXwLdqbPPVTzd13g2rm/IVVZ
         64XmiiWaqChuRE13azioiZucyb1aWyIpUt0jYXBKfyc+micNU5dUjK/rHwAm8hDtpRfT
         S0fA==
X-Gm-Message-State: AOAM532PTN3AgElVVtiU5kJfMkCmaHBzz/5V+FfTzJBVRvPGkCDMmy9j
        pJUQ2tf7QhzcET+0BCJ5f3Y=
X-Google-Smtp-Source: ABdhPJzonSW7N1yhegZXrr8lGbqbqcR45c1IvG5abGOxqd5UZeIUoZXQYW+MARuJ/BDwv6dHwHJZ3w==
X-Received: by 2002:aa7:c354:: with SMTP id j20mr23408526edr.294.1623766445136;
        Tue, 15 Jun 2021 07:14:05 -0700 (PDT)
Received: from agape.jhs ([5.171.72.178])
        by smtp.gmail.com with ESMTPSA id c14sm10102498ejm.4.2021.06.15.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:14:04 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:14:02 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] staging: rtl8723bs: remove include/autoconf.h header
 file from tree
Message-ID: <20210615141401.GA1413@agape.jhs>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
 <9317fa8fd41da4668a41775207b5e6dad33e7447.1623756906.git.fabioaiuto83@gmail.com>
 <YMip+8CWBFAI40tf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMip+8CWBFAI40tf@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:24:11PM +0200, Greg KH wrote:
> On Tue, Jun 15, 2021 at 01:45:37PM +0200, Fabio Aiuto wrote:
> > remove include/autoconf.h header file from tree.
> > It just contains a compiler configuration check
> > which is not needed.
> 
> It also still contains the LPS_RPWM_WAIT_MS define :(
> 

Sorry Greg, I will be more careful next time,

thank you,

fabio
