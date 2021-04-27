Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E897336C8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhD0PhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhD0PhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:37:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA49C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:36:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so2350874wry.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mABIv3gd/NpHdrpmttxF54ygOPuU/Wv57a+n+n7FXNY=;
        b=hIXwNke0zOA5Q8eB31F103zrewrScLbYhba27ETmVZi6jOIo5gSbCSap9Dpc9szAGZ
         WZsRmn9TeOJWhveY2qSB4YBI96VJRBNhdwZNTynMlY2h/UShi31X/Djzl64CjpT8kqmw
         LwjJOORQdIUP1QQ+YyXJSUpvj40Zwp9xZ8k5RrdAgMUOAJc4n5K7e0+Wzl5XKTIoUjHp
         qbFo3auiDYo8+0ZGQMmxfWnu3N86UFnzctifx+69FCsLlAgEEIKgbs4GCiACP0mwXOYQ
         GHFT9Bnr7/IltSTJW9sQbjYJiMA1MHfpWon701xwm2i2Uz/qG84XtXBQ0v5G2O3AjbsH
         OQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mABIv3gd/NpHdrpmttxF54ygOPuU/Wv57a+n+n7FXNY=;
        b=oqg/loXqbZFDfA9L8TBnmMznKT3UdHKvXYuHNr/VZg30luKpMJFP6ZyB/Ilp+k3IPb
         AHWooK44EuaWSn8MfuMgJYu2K7PPVuXFhBw0A20BY32h6cn67R+FkUjN8cjoIP2BwV+D
         dk3zSINNE7pqWDBvoiypPUIb14r9O2UA5vEcFmCqu01mz++Cb/jQeHYJRhg6cKc5V1yD
         pS736IOvIQ6bRmY8iIfIorXF0ir/7ZVKfn9zAA2xfaUUTZw4+e3Hy0mX0CpKTMAYPTZj
         IIDvPh5w8aki0zZkDQfIf8JOxs+fg7u7+VnME/UGOCzb3SbVUNi4UY2bajVhd3n0DR8Q
         Vd/g==
X-Gm-Message-State: AOAM533MUUFUN0JO592C4uT1Go8ljLShiA472piGNGNcPtAql+lYQnZ1
        YsB15nmSpBOmRigFfMVjw6vbVIM4PFQ=
X-Google-Smtp-Source: ABdhPJwoa1qrZEgIvf5laSvhxM0+p4oOQDTf0dCQo+/2pooQaXgCF1briXUgFlRrwkTzwJpQyN5dcg==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr10201659wrc.208.1619537789238;
        Tue, 27 Apr 2021 08:36:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l13sm3119408wmj.3.2021.04.27.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 08:36:28 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:36:27 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIgvezyA3pC51uvj@Red>
References: <YIf2w1navFNeYjMS@Red>
 <YIf35EzfSY7qavWw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIf35EzfSY7qavWw@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Apr 27, 2021 at 01:39:16PM +0200, Greg KH a écrit :
> On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
> > But the dma-api directory does show up in debugfs, but lot of other directory exists in it.
> 
> Does it show up properly in 5.12?
> 

No (Tested on a qemu x86_64)
