Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80F3D5A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhGZM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhGZM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:27:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:07:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b9so10161529wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWr2xaZ+/s0B/nDH3uxkXrf081KOB9cbVhCDh1cSAls=;
        b=to0PFCRlG/g/CAC6UKSyYEmjKXWUDeaHhxaU7AtWzlpZ+oCQ2f0vtFK4ZqA04Q2v6J
         HOibiiYM7JhuKm0f7vz+7TQOx1+mi1thcLSrAhJWgrmIfwchAs41AwEUGy247PnylcFN
         T1ed0DEKZ5eIoQMU5cOp6+S32Ddl7aqPbTUg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWr2xaZ+/s0B/nDH3uxkXrf081KOB9cbVhCDh1cSAls=;
        b=tt+uomshMZChygh5tnGPahc4Ek4tIEOOPowpXMG+qpnEktIs8KW/73hQI6PYMWtAir
         Nvn2JnUyIr07pWkQTzPJCz+2xkHELlHVl2Eou2HX+523w6Yk1sKqeph4x/gwaA2mrCZN
         zBMUNvIeSCp7SSz71PF5cKPMoBOxOR4bssq2dWJi50lJko+HGOa4Bzo0zbTeryGBFFWw
         deZFFuCF4NpQjGK+zn5VE86i9XyGJjGY94/ofccR/vq4LvJ6a2ZL0qZZ4SpHK1PzRVYR
         spAXSiMFKFyRITsF1eIWJoEaf2mwQo2VJBrmbU7uPQrVXsbnEqYr+2O6MZ+/pRRZV0Xs
         ZqvA==
X-Gm-Message-State: AOAM5322i0sNg/mcPVblkR4X8caZMVu/FSTo0Gp6hYOepBnJk2qnIoiG
        7mm4rNoruUCBam7+Mv95EPOC6w==
X-Google-Smtp-Source: ABdhPJwku8imMHDFJdm8e6/mh6gcHfvL62yh2cT7OhoMCGj1L24ew01O3NdYf984RD/DmaJLKU8D9g==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr126762wrt.34.1627304860786;
        Mon, 26 Jul 2021 06:07:40 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d571])
        by smtp.gmail.com with ESMTPSA id f15sm13269050wmj.15.2021.07.26.06.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:07:40 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:07:39 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the printk tree
Message-ID: <YP6zm4QGcOCiTLxy@chrisdown.name>
References: <20210720162423.75f61ce0@canb.auug.org.au>
 <YPa/D8tSyk7dw1/l@chrisdown.name>
 <YPbABBSTkN+xNY0w@chrisdown.name>
 <87o8aqt7qn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87o8aqt7qn.fsf@meer.lwn.net>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet writes:
>The problem is that you moved printk(), but left the associated
>kerneldoc comment tied to _printk(), which isn't what you really want to
>document.  The fix should look something like the attached.

Ah, I see. Thank you for your help!
