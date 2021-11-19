Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F1456FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhKSNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:39:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:36:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so31115386edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/7acFNBdyxV/87Oh/1ES50ggSz7v1Xh7gO8AgC3eUAo=;
        b=MwoiA9ZpZU6WobBoroswDXi+F3hS2NS42GJXD6QPAAEFECvvJyEYpOoXTHmIu/owTM
         bBCGuMhGSSHrXutFFjiVQ2dluGV1zODDDrs5yFtO1VWcVu1RG9amnFH/xJPQEYet/bmO
         gsod+7JTsJZIYUei/y24koS6uhJkvSnoierQu8RLb7tACuV7aowV9fsxMNNp9LprdUfB
         dSVeRHnpaIQ/kzCTwzScs1IrJWvMR2+v8C2yHsZSLgapc4ZdbbcwJL6CuXOuFMcMcx4A
         7IEiOPn2xngUM9ewCAXzphQDrmxOVpq50glRJhL2weFTN2WI0TJcPHgfmFSBHnp8ZGpB
         8LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/7acFNBdyxV/87Oh/1ES50ggSz7v1Xh7gO8AgC3eUAo=;
        b=JLs0qLuWlth69w5PAun4jnsTS158fhlyaPKQwepsyDj9WXCZoHA+JDBNERLCeGJxeb
         pkRMA4yBHqqVlLIWaLxfOxo///e0F6Z7P1e8mvYQ9hkPe7NNWhsK5zJZIBFsugMVj4M2
         lJgZAKVZkoCU8v5QtJWedHrwPhnMAsaScqMDT01eGBHBwUnUMMbRet9jZ5H6YbG1CDwR
         axxL24Av3SSirCAbAyQw1JZSKy+vwTe2z5bU1BHHk1VqNNN3aWi5S3OY9wXQyEaEbsbw
         p+7VOCweYo5qesKXx/0+ReZkJamFpftjmLaA+g/jRMk3R9IwtuWeGis25/IHeectoUzW
         oZFQ==
X-Gm-Message-State: AOAM533gvdvuyTB8lYAqcBQs/YyZhWiLCc/CJCR87vQbVxPS4DlEky7Z
        aaAMq/A0tGy1UuEcHsztI1w=
X-Google-Smtp-Source: ABdhPJzUnVDC1MGnsRrwYsbezA3m4+eqD80B+bE8epgxwxwdw6buL0uluuiv2xldp1D/DtXNbXdZKw==
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr8129880ejn.38.1637329006341;
        Fri, 19 Nov 2021 05:36:46 -0800 (PST)
Received: from alb3rt0-VirtualBox ([151.22.100.250])
        by smtp.gmail.com with ESMTPSA id w5sm1644883edc.58.2021.11.19.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:36:45 -0800 (PST)
Date:   Fri, 19 Nov 2021 14:36:44 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211119133644.GB2519@alb3rt0-VirtualBox>
References: <20211118202718.GA152832@t470p>
 <YZdGaAVSVM8/4ZB2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZdGaAVSVM8/4ZB2@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver-core$ ./scripts/get_maintainer.pl drivers/staging/vt6655/device.h
Forest Bond <forest@alittletooquiet.net> (odd fixer:STAGING - VIA VT665X DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM)
Alberto Merciai <alb3rt0.m3rciai@gmail.com> (commit_signer:2/2=100%,authored:2/2=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Regards,
Alberto

On Fri, Nov 19, 2021 at 07:38:32AM +0100, Greg KH wrote:
> On Thu, Nov 18, 2021 at 09:27:18PM +0100, Alberto Merciai wrote:
> > Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
> > Indicator) into linux kernel coding style equivalent
> > variable "current_rssi".
> > 
> > Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> > ---
> > 
> > v2
> > - correct mailing list
> 
> No, you did not use the correct mailing list.
> 
> What is the output of scripts/get_maintainer.pl on your patch?
> 
> thanks,
> 
> greg k-h
