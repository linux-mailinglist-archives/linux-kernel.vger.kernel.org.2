Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7584944BE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKJKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:05:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE1C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:02:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so1497568wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PJfOfJwP9FO0gjK5pRKT1w04yhBQfeCFLsV/CYmduys=;
        b=HVlST2bNoUX4fWyrGpkG5+PGiDTide2Flgg3aIJ0LPA8QXJmYvP3KldIPfyFasNbgy
         MJSOlLpy/iflSIohIuqn5Q0Nt8bOZ/K8aV24u4yoQeZ+B+gcgdEAiKX9HZj4vmHfsOis
         2TOPW7xkiyzgzvbqOdUwYXMDZhl133a4NpMVl0VwmXNIrYCtG7Xj1oFY0SyrZBx3VGOV
         NPySUjHbFqB0I/Uh2F456AvWNDF4VbkP1MRXkZ4Ams0ctYndwwSMOHQ/5c6brwjDKwcz
         cXAPVlodxr575Yc5bBTvz2OjKbgHS1Uxb+bKArrxsMnTPaag9z7c0IhjddkgT668yOra
         aM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PJfOfJwP9FO0gjK5pRKT1w04yhBQfeCFLsV/CYmduys=;
        b=DhzY4kkw5MMtEOhkIkvGsLFqvPxrJfXZFPKiOPWJdeTMHKl990cHD4Jga8rgLXcDiu
         IHJrkr0OXd2/oaGWX3iG/cPeV6b2Tv8HjpEjjS1W0DJW5SoMenUgylMga2tdMKTwTkEy
         rFK6wjK0e97TEsv5Pv4OYaiLkS3JLnuOdnEmrzpzCZYLMrq0ksOVtRb4gtpKWCUoQqFZ
         k7ANhX89e3fdo6ROikFGKQbYuCcaYyo3t3x2yy29auLnUI39z6+xgIKQiLNlQAqdAZHH
         vdRfTmXi1GfbW9Ktgdt2RFMsHZc11YkUJSHxRBqIVjhRsX1NY1TlhG+xbXN6BTU63xdL
         NtgA==
X-Gm-Message-State: AOAM531E8V38qlenASkLy687jZAUULdgACTu60kdS8XTx6Wlnl5K5RQy
        U9AmFujihhYjmqql4YvlHZ/WbA==
X-Google-Smtp-Source: ABdhPJxX6nhMwuNfQPrg2Jgohde5J8x/wd6KzwIe7S54neKBvo7VfD82LkU5Rot1KP//LK21LmRUeA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr15264387wma.33.1636538571589;
        Wed, 10 Nov 2021 02:02:51 -0800 (PST)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id m125sm5154104wmm.39.2021.11.10.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 02:02:51 -0800 (PST)
Date:   Wed, 10 Nov 2021 10:02:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Johan Hovold <johan@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.9 1/2] net: hso: register netdev later to avoid a race
 condition
Message-ID: <YYuYyROE7FKrQgIF@google.com>
References: <20211109093959.173885-1-lee.jones@linaro.org>
 <YYuCE9EoMu+4zsiF@kroah.com>
 <YYuXq3wOdmWc+8lo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYuXq3wOdmWc+8lo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021, Lee Jones wrote:

> On Wed, 10 Nov 2021, Greg KH wrote:
> 
> > On Tue, Nov 09, 2021 at 09:39:58AM +0000, Lee Jones wrote:
> > > From: Andreas Kemnade <andreas@kemnade.info>
> > > 
> > > [ Upstream commit 4c761daf8bb9a2cbda9facf53ea85d9061f4281e ]
> > 
> > You already sent this for inclusion:
> > 	https://lore.kernel.org/r/YYU1KqvnZLyPbFcb@google.com
> > 
> > Why send it again?
> 
> The real question is; why didn't I sent patch 2 at the same time!

Also, why didn't it go away when I rebased prior to sending this?

> > confused,
> 
> I feel ya! ;)

The plot thickens! 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
