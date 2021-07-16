Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB23CBCFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGPT7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:59:31 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:43927 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:59:28 -0400
Received: by mail-pj1-f41.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso1480431pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WD1BB+4u4UOIUk2edt7NFesq6yeysoarV2Cv8CeX26k=;
        b=Sxmr8pLyv7GGupiiMYSiCT2NX/4yaKI2DM9HRn8dO5kUXFip2eKTBEE38H8uUjCC00
         vDChXtFWoGzVeVNLHb22xKouEz0LyQeNFkWPIaESnwp0xpA4/eSeydBjj2+RnPHDZ7tI
         5CReW0+LGe8OY+YHwLwhhQj4wZlKss2ezOUzGjvnFvExE2rUbpMa0YNj4+7b3JNT14Ma
         eB8L35WLdIy6yRzzoWIJus6lZMp77hCHXnKxzqlzxPinp3FBeTQKO6Z4J3CGUl1PnZgX
         Kpo7ylDpyqkTGEBTPH1EWCfgSJoHcl6qdaTfHHuw9Dtx1ZH6qV07aLsLP8aU4q+URLn9
         +fyQ==
X-Gm-Message-State: AOAM531Lwa67TJl8rnOZ9SENL8aqsFnDU24Ul4rJH3EG/DP5IsKKPPTz
        j1YdQJcr5kkayrHhd4HLXvY=
X-Google-Smtp-Source: ABdhPJyGJ9TmSWd2M3ZNxg+j+qK1/H+ond1F06AQmxEWFelSh8cXIbwmXyjTUSrA3NPGtzwCOJ19+Q==
X-Received: by 2002:a17:902:a415:b029:129:5342:eab7 with SMTP id p21-20020a170902a415b02901295342eab7mr9078657plq.26.1626465391987;
        Fri, 16 Jul 2021 12:56:31 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id b21sm10939680pfo.64.2021.07.16.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:56:30 -0700 (PDT)
Date:   Fri, 16 Jul 2021 12:56:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ming Lei <ming.lei@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] firmware: fix use-after-free in _request_firmware()
Message-ID: <20210716195628.a2pz73hdudrsf7vu@garbanzo>
References: <20210713024942.2881-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713024942.2881-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 10:49:42AM +0800, Zhen Lei wrote:
> 		CPU0			CPU1
> __device_uncache_fw_images():		assign_fw():
> 					fw_cache_piggyback_on_request()
> 					<----- P0
> 	spin_lock(&fwc->name_lock);
> 	...
> 	list_del(&fce->list);
> 	spin_unlock(&fwc->name_lock);
> 
> 	uncache_firmware(fce->name);
> 					<----- P1
> 					kref_get(&fw_priv->ref);
> 
> If CPU1 is interrupted at position P0, the new 'fce' has been added to the
> list fwc->fw_names by the fw_cache_piggyback_on_request(). In this case,
> CPU0 executes __device_uncache_fw_images() and will be able to see it when
> it traverses list fwc->fw_names. Before CPU1 executes kref_get() at P1, if
> CPU0 further executes uncache_firmware(), the count of fw_priv->ref may
> decrease to 0, causing fw_priv to be released in advance.
> 
> Move kref_get() to the lock protection range of fwc->name_lock to fix it.
> 
> Fixes: ac39b3ea73aa ("firmware loader: let caching firmware piggyback on loading firmware")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Good catch! Can you resend a v2 patch describing how this race is rather
difficult to run into given it likely involves looping modprobe / rmod on a
driver while doing the suspend / resume cycle? I can't see how else to
trigger this. Additionally if you can describe in the patch how you
found this, (code inspection, a robot code system which looks for UAF?)
it would be good for the commit log.

Having a possible impact described in the commit log is useful for folks
who may want to put effort into backporting this for for older kernels
in case it does not apply as-is.

 Luis
