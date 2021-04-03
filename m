Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC86353303
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhDCHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhDCHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:48:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47750C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:48:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x16so6413901wrn.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4lpY5m1izQotM0ewusQVcTKKtwLD9dtbUV/NQkwNeL4=;
        b=YmYRAcqnkO5URm9rIbRF+SV1xi0/eoxRjqqneyoNVgV7Gmqr/2qwfPTnbP4l4S/nu+
         rV4qh+xZZM9YH8PVD7Nnt9sVvN4/d1ZT8mG8dIx/y542opZkLvgQCyAWiG7Usoet5KXc
         GJrgk/oLlSBijwiBse1Ppn7i0Y3rAbFcXrA0XgJd48fe3u2+2vPCtSCbdz+9GtRsIdKI
         64BAjzZTVTt/5SEZK/EsfxdKfA+kSMYDdoIKde4qwTeGAf6Ovi/7GVT++8Jn2jO96j4g
         BnzL8Ny0PRGQC1thiEMfSOwjyG1CC947Tu5YaUzu+jfVjm5rwhuPCiQOPY8S7TGFqgRC
         3pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4lpY5m1izQotM0ewusQVcTKKtwLD9dtbUV/NQkwNeL4=;
        b=eCMVa6VnVN3GKEXUoSs1G86foAMBQ536Y2zuPcyIDxW/YE7eBb5a0ky6VeDbC1/9f/
         bpUCD5oc2cFugzvDQ20NU6j7BZWAsRcp7d9Bojedbe5iL74wpY6WEe6aHZlxH6hYgwZ5
         eVxwOius2G1qQZ44v+YwB469lLOl6Fu/aY4gmmuZ4nO0cltT+ULFZe97sZ8Moby/Aycx
         vGxfYkmg7aLnCl65G67FDzS2yxoqo6rLDlK4t78F8c1vCw64BlxfWJmUcrxVBPTsTUwq
         nQWovm6vJ6T50J0Eryo/wXr58G523Xl0V8euk/j5DGwM+Vpd/aS30t9AW8T4j2m1GZq7
         6F6w==
X-Gm-Message-State: AOAM530ay8cmY1r+eiNDxtkzrNNqQX5LNGutMbGkBSVS8cvdCmBZPKic
        AqiMN45ntwkHw76x3sd9xCafk0EsY84=
X-Google-Smtp-Source: ABdhPJwiAwsa7XwNFRUPdxjlgRcmq0VvwRYZuAb7wTIB0ElsuLkkNLyDzJOBbhc04/bVhe4jYL6WMA==
X-Received: by 2002:adf:e4c7:: with SMTP id v7mr19128293wrm.245.1617436089480;
        Sat, 03 Apr 2021 00:48:09 -0700 (PDT)
Received: from agape.jhs ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id e23sm1042092wmk.15.2021.04.03.00.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:48:09 -0700 (PDT)
Date:   Sat, 3 Apr 2021 09:48:06 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_xmit.c
Message-ID: <20210403074805.GB1563@agape.jhs>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
 <34b6f0b80cd3913722b258e9554dbc77268fb2bf.1617384172.git.fabioaiuto83@gmail.com>
 <YGgb2Mtzyp79elQ6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGgb2Mtzyp79elQ6@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 09:40:08AM +0200, Greg KH wrote:
> On Fri, Apr 02, 2021 at 07:29:43PM +0200, Fabio Aiuto wrote:
> > remove all RT_TRACE logs
> > 
> 
> I don't mean to be a pain, but this changelog text needs some work.
> 
> This says _what_ it does, but not _why_ you are doing this.  The kernel
> documentation has a section on how to write a good changelog text, you
> might want to look at that.

you are right, I spent time writing the cover, but not the changelog which
will remain in kernel history

> 
> For this type of series, this could be as simple as:
> 	Remove all of the RT_TRACE_LOGs in the rtx_xmit.c file as they
> 	currently do nothing as they require the code to be modified by
> 	hand in order to be turned on.  This obviously has not happened
> 	since the code was merged, so just remove them as they are
> 	unused.
> 
> 
> Or something like that.
> 
> Most of the time, writing the changelog can take more work than the
> actual code change itself, but it's important as we need to know what is
> happening both for the reviewers, as well as people in the future who
> might have to look back and try to understand the reason for specific
> changes.
> 
> Can you fix up this series based on this and resend?
> 
> thanks,
> 
> greg k-h

Thank you Greg, I will do and resend it.

fabio
