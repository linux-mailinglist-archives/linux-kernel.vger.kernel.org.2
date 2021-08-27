Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63273F9481
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhH0Gri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhH0Grh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:47:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:46:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u14so11574896ejf.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=udzHFNPd++YD0eVLDswSdAc73k4r2+aTjGa5bpUcLHY=;
        b=OKk3RmDtR1XuUdmnk9L+oWVj0snzZyozr8kxLQUb2TM8pLa32ggU/Rl9dUAHarIlau
         OjdTpBgAru88ElxFS9hRdjGuKbqLG0NFJ5FXouaMYS+suhEwElTRAFRWsgpYJCTRgbWu
         7+HaxtjVYlLS3bODm7oPAs/+kvgd04A994M7UZjlrHjCBWGn6MmBb6UdRDng71WWNGCr
         LT1mKenqbWstNC0upgqiTByuX9HQyRAZF/U/ZFTVhNOB9YH1ByWL4mXG2w/bFoxmROvO
         FFjalVQilk2U1F5upHSC1Q5T45CUsS4GE/ROw9FVMI/j765AupUQ2au5bx8jwi3XdEE/
         AKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udzHFNPd++YD0eVLDswSdAc73k4r2+aTjGa5bpUcLHY=;
        b=bJWAqkqL3Pct1GbHdoP4X5necmCwma6edwBoAcTdMJHleYzfGKy0beolLQbLVGA5WK
         4pyzMENspPQ0Ve94XTvtr71TXyW8AZjaw15Kef9HXAI2A8y6TNKg6WGkNcIVq4QoblXQ
         yUJJDF5AO1HM9fRyuajRItmpb2Q1briEEAjM+DIUE7UmMGXNYGN0lZD/8Rj7o4ZSN8Fy
         vPJ1CMhifrZq97eT47bLTv19SQeIIbi+RsSI662nyOhYR22dIIMlA7MTRDYk7IpQZcbF
         E3FtmrH1JkARRyL9c/EueD/QBulWxpH+MRZ411vuO82yV2FH1YlDvZZCZeKpdpUE7PkY
         Y3Yg==
X-Gm-Message-State: AOAM533T/KxFhV2j046Y1hTx32Sz1+2vst4Be+XEUMWy3uM1vwvrwBPI
        A92NjGj5P6bT1c9Fw67Wyts=
X-Google-Smtp-Source: ABdhPJxZTriywfP9b2pKZqjIM3uJmmIr8wC7uaiJFoG1V2pr7GF/m615HWUAUveP6D1x/sGGznbUJw==
X-Received: by 2002:a17:906:584b:: with SMTP id h11mr8497974ejs.209.1630046807722;
        Thu, 26 Aug 2021 23:46:47 -0700 (PDT)
Received: from agape.jhs ([5.171.72.0])
        by smtp.gmail.com with ESMTPSA id l19sm2802849edb.86.2021.08.26.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 23:46:47 -0700 (PDT)
Date:   Fri, 27 Aug 2021 08:46:44 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wenlong Zhang <yixiaonn@gmail.com>, gregkh@linuxfoundation.org,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, cyruscyliu@gmail.com, yajin@vm-kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210827064644.GA1408@agape.jhs>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
 <20210826172618.GB1423@agape.jhs>
 <20210826181648.GC1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826181648.GC1931@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:16:48PM +0300, Dan Carpenter wrote:
> On Thu, Aug 26, 2021 at 07:26:19PM +0200, Fabio Aiuto wrote:
> > today the patch which removes wext handlers has been accepted
> > (commit 174ac41a7aafb31041cba3fe54ccd89b9daeef5d)
> > in staging-testing so maybe rtw_wx_set_scan is going to disappear.
> > 
> 
> From a process perspective, in staging we don't track things that might
> happen in the future.  We look at each patch in the order that they
> arrive and either apply them or reject them.

Wenlong's patch will be applied on top of staging-testing first,
and it won't apply due to wext-removal patch.

> 
> And from a practical perspective this patch might be something that
> people want to backport so it would be nice to apply it.
> 
> regards,
> dan carpenter

thank you,

fabio
