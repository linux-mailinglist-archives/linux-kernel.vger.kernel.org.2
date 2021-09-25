Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2968418054
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhIYIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhIYIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:30:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A137C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:28:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e15so50855339lfr.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPQ0e1sBk7kajuJ/jfztGoDU0h13BVzJE1bpOha/uZg=;
        b=XrIpcrDT3PUkAOjrYGgsSssVFI6UB1LxqchNr3AVY2It8X4VqfkvA4ZOCbTyx0kKwr
         qHsfjCLk3BgadYAse3oSnd4uMkEQK3vlTuFWPy64F3H2xCzhzHT7leBqpPKo4BNqlv6c
         z6rXhF0HgRgbAFn+VDzBNslML5CISLkLw58TYEY4VEVErM42XnuodBakokeMXfwe9Lxm
         9pXaz6BS66RtASAi7UxpqLwrphtuM8C1OUUTGOBRRuu4mORU/ZImMW1efjGCwIMg0E82
         hYE7vjz3/Klu6fhF/c+xa4ge50UpNQ42NdMfr+PMOYOQSc9EdN6HrQkqB3IpdNrUu/9K
         /2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPQ0e1sBk7kajuJ/jfztGoDU0h13BVzJE1bpOha/uZg=;
        b=XUqs4EAgj9Al/HIaAeYM3WuJd//wUJwnvv5rsmcqvQt6AtoQeMNAynM8sjc/JjhnRk
         vBoiLnEO2nhDeK4FoNQ9zpNPtjYXJzg4RGxbwhoXb5KIUMZQR9USC2fuDo7HH/bClS57
         iohitF1CaDNwUok2ApisTSIllMrFWFqDK9aKrnON+o1ookOfCt8qiMNgw4ZOG7uf9FRJ
         DZ+Mbs7pk2Znp5esAzfZLOz9jmZxMmH9nVUw87aRvkLBT5CUATlRFCB3LQbtEyeAD8Tg
         HU/ZPyaUz6laejNazAvIn+7J2au8S07bpaNtVmwvl1weH1zm2zEvKUKmDx9gE9aneUfn
         lazQ==
X-Gm-Message-State: AOAM532NRWHvQ5n4v7tUpkXWxo7zur3vYAQLBwUgrvmnEMxbe77kV0ES
        WEXiOvpmAQ1bkC+FO6kvzkIPqWYUQE8=
X-Google-Smtp-Source: ABdhPJzekEDXVG0soVO3gbpKBOGoUMxl2ChX4Ox/dPioMBIa/BasyHZthjZXPE5RCokeKlc8g8N8Rg==
X-Received: by 2002:a05:651c:1790:: with SMTP id bn16mr15464823ljb.457.1632558505637;
        Sat, 25 Sep 2021 01:28:25 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t13sm977107lff.279.2021.09.25.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 01:28:24 -0700 (PDT)
Date:   Sat, 25 Sep 2021 11:28:23 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     sfr@canb.auug.org.au, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question about ntfs3 git pull request
Message-ID: <20210925082823.fo2wm62xlcexhwvi@kari-VirtualBox>
References: <89481e37-6723-6dd5-3549-85d1aa9fccbe@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89481e37-6723-6dd5-3549-85d1aa9fccbe@paragon-software.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 07:47:09PM +0300, Konstantin Komarov wrote:
> Hello, Stephen, Linus!
> 
> I have a question about next git pull request.
> 
> After first ntfs3 pull request [1] was accepted
> there are some new commits, that I want to send for rc5 probably
> (need more tests + some time in linux-next).

Imo you can send PR before rc5. No need to send head if you do not want.
Some of the patches has already been in linux-next almoust 3 weeks. Also
other people might want to test what we have done. Of course they are in
linux-next but many folks test Linus rc's so we want there patches also.
If we do massive commit dump to rc5 it is quite close already release
date and other people do not get testing time so much.

  Argillander

> I've noticed, that I missed step
> "If your upstream-bound branch has emptied entirely into the mainline
> during the merge window, you can pull it forward with a command like"
> from Kernel Maintainer Handbook [2].
> 
> Right now my github repo still based on 5.14-rc7.
> Do I need to update it with git merge up to 5.15-rcX?
> Or will it be ok to send git pull request as is and
> back merge master only when 5.15 will release?
> 
> 
> [1]: https://lore.kernel.org/linux-fsdevel/aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com/T/#u
> [2]: https://www.kernel.org/doc/html/latest/maintainer/rebasing-and-merging.html#finally
