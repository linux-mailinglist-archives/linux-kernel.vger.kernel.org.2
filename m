Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC353F9B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbhH0PS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhH0PS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:18:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:17:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i3so4116161wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Mvy+Kbt7FAmEXf5iwc1sFwbqDbGbF7nehIGohDWrG0=;
        b=CPUBlUiWu6BJlUaFoHuakqhLmrV9VcgXzW1bdjPLtSDZoKKCDDJP0DH2HlI1FyBc7u
         KYBg6AvQ5KKL8Geflv01OJOlCVGuGRMH9n9Ecb31E60MydDc9xPMRl54O58P7Okm0zFk
         1vk1cW8B+jmcGTjYMXarcaQ/IGGJQCrSfjJGNqMnqu7NJUR4h3jxUwQoHt8TAjhxjVfJ
         KkPDstdPZSlVaapplBGYO/IPsBrAB+olVFAueyQXeLVL7sIUmJudc9oJOt8jAlPjb3RQ
         bUhtzsgdJ/6bmatU82pAjyTl838tmcR4j6RGOGwB4klDAkH8iBAAQCqiOxdwtWG8FLBC
         BGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Mvy+Kbt7FAmEXf5iwc1sFwbqDbGbF7nehIGohDWrG0=;
        b=TWCnyYfQvjhIefSkGITmF3pczcWf2CCHv8IgqFNIcaQwA1Lc6hokJLt4ZrRVLqu/qj
         By3Hy1d6VBFWofsTwAh4hXHdW5qwUEW5fkzKqez5HLcFXxspq0cF1OcX5tqef8MdeChl
         QEQJalrOT2EyBjmv87DW2lOWVeVlmYT+CxJYiz/YQahd+VEGS3e2kPzaEL5NANEgHRdM
         aQkc1xzjLwhshF9BvUCdxq2dsYPJBn5C1jN6RrBVHHfIXVbc7juCAJorrgIbSmXYV9Q8
         fnwOQsGRFOG3Nitwd5KwfYOTBDw3LBL18vkjl7ZRGIn4jiQsWvhBTR6iCp4SPIxEsi6r
         w1MA==
X-Gm-Message-State: AOAM531BwUOG9MTJ7HCwFHKA6+7CWr9zR1VzYqp2H+sdA9akIRHc+o0o
        ifEFv7t5RiKNtlCRspaqCMY=
X-Google-Smtp-Source: ABdhPJxL4AYwJNhnzlaVxDWG97HQPWd13eHcTNDpgZmUZxaxBQKuXLHDIrd8kfh3kgR3U7uBQlCwCg==
X-Received: by 2002:a05:600c:4e8a:: with SMTP id f10mr9568594wmq.84.1630077457076;
        Fri, 27 Aug 2021 08:17:37 -0700 (PDT)
Received: from agape.jhs ([5.171.72.80])
        by smtp.gmail.com with ESMTPSA id r4sm5074422wmq.10.2021.08.27.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:17:36 -0700 (PDT)
Date:   Fri, 27 Aug 2021 17:17:34 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
Message-ID: <20210827151733.GA1426@agape.jhs>
References: <20210827100813.18610-1-fmdefrancesco@gmail.com>
 <a6265f77-cc21-878e-4980-272202fa5415@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6265f77-cc21-878e-4980-272202fa5415@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,

On Fri, Aug 27, 2021 at 10:00:16AM -0500, Larry Finger wrote:
> On 8/27/21 5:08 AM, Fabio M. De Francesco wrote:
> > +* Switch to use LIB80211.
> > +* Switch to use MAC80211.
> 
> You totally ignored my comment of yesterday!!!!! The driver will be
> converted to use CFG80211 - not eirher of those you quote, unless you are
> planning to convert to use mac80211. I am not.

I think Fabio took inspiration from other staging rtl* TODO files,
(i.e. rtl8723bs which already supports cfg80211) where those items
are listed and it's not related with the work you are donig
with cfg80211.  

> 
> Larry
> 

thank you,

fabio
