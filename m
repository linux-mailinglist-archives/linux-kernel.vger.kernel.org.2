Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4141E361
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhI3VcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhI3VcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:32:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF5C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:30:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba1so27281080edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z38Pff8rNHkpmHHsiE/EcUCBdc5ews9xWggX89bh2PM=;
        b=jBAvtPK6du6rAgKGQHZ8yVhlGXtowsq1cPeEiyZLMNjDSNjApE6daz9tsuvoJam2RR
         V5kqHkXN4gxDevQpociV+DaBSPpayl9qtBwZx3M51jbBSHiUM9/i0d9MzaeVBIN/DaES
         xh/MaYZ/8tVeYIqhgeSWJdhOpE2vX9Yd74wZ4I+H99fYsedRii1WmATbxokDAzGUsV60
         lw2NRN/VvGjRYuAM/ZFTp58iBWzehRpFr5YjLax05QN7U44row8IqCk3NpHeYb4RTyMk
         f1lbjNFKxldJ8wpolsk4cKIHqCAOMVcyYZrbv5NrDP8sRbkZNr+/Ko69qhApcZj7IS/y
         YAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z38Pff8rNHkpmHHsiE/EcUCBdc5ews9xWggX89bh2PM=;
        b=idGc8oUN0FKByV8smjac+Qkl6D4SPJj34xxFOgR94RDEI5qoVKfiThE3F7CO64N2R0
         Q6mowNqmN6ersF9+z/WbrS+Blr7DIUll7KJAGJwUpfw4wWWXaLk/wxD+e459kmlDHlAg
         Zdo7mqSQ2Y5P7xGClGxcVRxiaL6NJz5ewnEAmUkeeGMg2/W3oBlU+MGJwU5Ln4/mM/f6
         gFm1iyNt+egy6MeQy/sXbiWd92VN0qABaR9ZvdBYm3CkUri2ckxz95az41n5HkIFm6GH
         bm4423fa6lwtGis77seFniUbOQDopFhdWwElZQtUKw2Akg6REyFLypd/MMUGTNfdmdz7
         u5+Q==
X-Gm-Message-State: AOAM532T+ZqB88H/DaXu9jHGPxx58AtrDmsx3NUz6PyhW4vi9ymkhkxc
        +44UxUi5BOmeqikyvjmJvE4=
X-Google-Smtp-Source: ABdhPJyIs9IWzjK743hlXZoMFHInBnLRvDmLCWyajvYtiX/RZyuArU0Ujf4/VWAO+ti3AC/Ken4gfA==
X-Received: by 2002:a17:906:ff51:: with SMTP id zo17mr1800990ejb.193.1633037438506;
        Thu, 30 Sep 2021 14:30:38 -0700 (PDT)
Received: from tom-desktop (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id cb7sm2109271edb.49.2021.09.30.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:30:37 -0700 (PDT)
Date:   Thu, 30 Sep 2021 23:30:35 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Message-ID: <20210930213035.GA45822@tom-desktop>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-3-tomm.merciai@gmail.com>
 <YVHirHixyOIgvqKB@kroah.com>
 <20210927214624.GB6953@tom-desktop>
 <YVKdJdTxlNJ55zCy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVKdJdTxlNJ55zCy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:42:13AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 27, 2021 at 11:46:24PM +0200, Tommaso Merciai wrote:
> > On Mon, Sep 27, 2021 at 05:26:36PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Sep 26, 2021 at 06:25:19PM +0200, Tommaso Merciai wrote:
> > > > Replace camel case variable ldBmThreshold with snake case
> > > > variable ld_bm_threshold.
> > > 
> > > Same here, what exactly does this name mean and why did you pick it?
> > >
> >   You are right the same here. What do you think about "bm_threshold"?
> 
> What does "bm" stand for?

  Got it. In the current variable name "l_" is for long (hungarian
  notation), "dBm" is decibel milliwatts, signal strenght.
  A good solution could be "dbm_threshold"?

  thanks.
  tommaso

> thanks,
> 
> greg k-h
