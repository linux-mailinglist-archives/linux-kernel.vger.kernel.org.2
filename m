Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF8378E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhEJNQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351916AbhEJNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:13:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:12:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s8so16588903wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=arkEZloYG/8s7EHZSL/Wo17Slx2pmQjhiuq/ITnE6NE=;
        b=Ec/orbdIinVbI1WenpM55TD0ERq7ei93XnOyFkk+yOo2iizBZeYu3EfjzaxZReH17E
         RA2InuW7itLvWTg52rcpfbUseDR2W+muBlwqP0hjuY+SQdqcBP/VejmF7/4FoMdBjFcq
         285A1AbY0WNfvKuJ2rKSP9VUzc6iwikVxcjAzm9ejwQCq1YgZnqJGruhzxjUKWlRqY4M
         z2FgiHJdnWuEECfcLVI9OHMRIgH8vvr8kiMySX8YQM+obTPE+GYmCfKSd5YKFssTcztu
         E8nH9pnlGIWRb85K9LYZCh+fTtxR/nj7qigcodEbH5NbW4q4kQ0w/BpVxdXQs/ClMpVp
         Qmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arkEZloYG/8s7EHZSL/Wo17Slx2pmQjhiuq/ITnE6NE=;
        b=j32MLXy/Jt/OeC5Kgj0/PA1PXI96KmcA7gwXz46eWsG3DUszNz06wP922KHRC0+blY
         0TXz+NOXrjpqpHyZkr3Cmd/5cdpyWOvygS9KswMw/t/G4NslPcVdvYqXAr2YlZVQrR0T
         gMCHJkAz6LnhWBumNlGfHA/khNt0cB8t5NFNWZnAzPHf0auKDW78pxW4IuI6wAjAeXd3
         iVycykxCMQxIhazImZlgzZQ0SqnDIOZVtWa3ZiOYAPqBqIeMmmaxvsWwz6Fk721ZwXlb
         NYkb7Sh1vAtiyYHCa1xE2WwkrMSd+9MtM7Ygp0DPd7RzJWEhzhreEfQWTDE7ToJOSFCb
         Hyeg==
X-Gm-Message-State: AOAM5328BQxv43sEKCNLtXEhvswi9VcDVRB0iSWzY1ir83UJ+KDNBiOk
        Ne9leXjf2QTN2gkzCVpVbFs=
X-Google-Smtp-Source: ABdhPJwRM4BuJSt5TLHHWLjs9qW0+A1lQUtZ8+Vez53b40PqcA/VfNSa+hDfZYbwGyQlUUG1+KC34Q==
X-Received: by 2002:adf:de02:: with SMTP id b2mr14664098wrm.420.1620652336970;
        Mon, 10 May 2021 06:12:16 -0700 (PDT)
Received: from agape.jhs ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id c14sm23248959wrt.77.2021.05.10.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:12:16 -0700 (PDT)
Date:   Mon, 10 May 2021 15:12:14 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8723bs: move comments to silence 'line
 too long' warning
Message-ID: <20210510131213.GA4434@agape.jhs>
References: <cover.1620650484.git.fabioaiuto83@gmail.com>
 <cdb37302e4d7618141997229c59467f9d196eccc.1620650484.git.fabioaiuto83@gmail.com>
 <20210510130019.GT1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510130019.GT1955@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:00:19PM +0300, Dan Carpenter wrote:
> On Mon, May 10, 2021 at 02:46:19PM +0200, Fabio Aiuto wrote:
> > move comments to fix the following post commit hook
> > checkpatch warnings:
> > 
> > WARNING: line length of 110 exceeds 100 columns
> > 115: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:510:
> > +					*((__le32 *)crc)
> >  = ~crc32_le(~0, payload, length);/* modified by Amy*/
> 
> Please delete the Amy comments.  :P

ok, will fix and submit a v2 :)

> 
> regards,
> dan carpenter
> 

thank you,

fabio
