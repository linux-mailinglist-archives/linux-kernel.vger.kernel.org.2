Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621D359D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhDILmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDILmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:42:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B6C061760;
        Fri,  9 Apr 2021 04:42:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k128so2756006wmk.4;
        Fri, 09 Apr 2021 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5+pjzHfePdkc4rtRN/TOnz51urUM/UQ0GOzVCwaFA0=;
        b=unziX4wdDag2c1dvpdPDY18YWmm7+w3iEw0aEe1mfWmeg+GAdFsq+UUd88Lkk6IU9L
         xqhIt58qE+bHOCfCK/3+S2U2kFxffNRanLV/TkyAB270FWkFP5E7CTDRiTMayJvV/R6P
         dK33s7Ftdqxqy9yRKFs52pBPF0ArDKqO1v3FfRh4UbcxmxtcwhFbgZqVmKvQYCWNXzcr
         PGqsg61tbGwy0Ldf1MVqshWKTFlIRdRGC62NB4eQVZhoFOmMsA+qX1EAFsgQ7uR0zKoN
         H2wdIA7ckGo29LbNRf1+m61+t0jJAlsEcxVyUrPMcSTKnyD2iLhToqZ8y1vqoR8ENovK
         b3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5+pjzHfePdkc4rtRN/TOnz51urUM/UQ0GOzVCwaFA0=;
        b=s0qzLfuoMZfCIdZIw+6cxtF8FmF79R7oNOsi25ITJyCkSv391c9W6bglsaayZubX1/
         XEi+RBLFBQpDcxkEo4fWdNj+FlzS/RaIco/Qms1cRfj29vJvqPDkzUxzwky1vQHL4bp7
         H2j4Q+2QB9AI9STy+Rmhoj3XdagpLAdKfijj6tgG1MS0MSQADCNcBiG2omM06Uj9P0fZ
         tLuerB8YNIgdcOf4PYZ6a9TCk2LsDsLkQnwGEM7WBgWQM4BeGFO0+48nEjLoSacc0cxn
         oClTNhMJAgO6hOD0VBnQZ/xG72WkHnW6wBEITzH9dxjHkAglYW4s9fpnkKE+0jogCXFh
         XwOA==
X-Gm-Message-State: AOAM532vw2sxdgXIWrf+tpAl7giZgpStJ9uk2vIok6x2s99P+YANO6oy
        6M0v7UVFUXMUWUO86H+W2pTkGoIp+/kqzA==
X-Google-Smtp-Source: ABdhPJwmdAyg9Fb1luYslkM5DiD4Uk0tt40oDvZh1cRvcM9dxHhY9t/F6CW6g164NdDbUUhueFVqRQ==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr6569549wmi.186.1617968521597;
        Fri, 09 Apr 2021 04:42:01 -0700 (PDT)
Received: from test-VirtualBox ([87.116.165.76])
        by smtp.gmail.com with ESMTPSA id d133sm3604331wmf.9.2021.04.09.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:42:01 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:41:59 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix wrong function output
Message-ID: <20210409114159.GA3122@test-VirtualBox>
References: <20210408234527.GA6893@test-VirtualBox>
 <YG/1MyfOrHgCi5sr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG/1MyfOrHgCi5sr@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:33:23AM +0200, Greg KH wrote:
> On Fri, Apr 09, 2021 at 01:45:27AM +0200, Sergei Krainov wrote:
> > Function r8712_find_network() were returning wlan_network even if it
> > didn't match required address. This happened due to not checking if
> > list end was reached and returning last processed wlan_network.
> > 
> > Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
> > ---
> >  drivers/staging/rtl8712/rtl871x_mlme.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> What commit does this "fix"?  Or has this bug been there always?
> 
> thanks,
> 
> greg k-h

This commit fixes the bug mentioned. 

And this commit is based on staging-next and has nothing to do
with my previous patches, for which I'm sorry, I was wrong.

Thanks a lot for review and your time,

Sergei
