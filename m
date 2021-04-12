Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6635BAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhDLHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhDLHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:38:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:37:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6297888wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HIQ9nS2DnwZgvR48t9GVmzUOt4mImx9+3jm/clQDwpY=;
        b=cWpYm91kNjsIFJodtiZmsOpVNs3il+ZXETTnXX8FYTbNjt/YnEDz7l8TGVlqci8noK
         kiYpaX84LNH9skbYeNm0eE4EUUTX9zw3O/rw1+qUoReok79wn3Mcv4D0ufyiHY8/nLeQ
         OegF6lPT4+buI/vCT6lkfoT2MBb5/atv2wAH0udUTCCdq8Dgw2W31t7SJyLYwv3zdffC
         I8/RvEPPyc/6MLm8e5mw7eimkWoLQDFw3Pc2Witwk1eb0PUs0dLkVTC/ZQ1PPm/4mqiF
         mxEAm7SGvNzXs/HFqf3MCRrf0eznlYMwv4JVKxmjhfozh01iYlI6L82AIoMWejUOXYOf
         u8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HIQ9nS2DnwZgvR48t9GVmzUOt4mImx9+3jm/clQDwpY=;
        b=BCqgITflLh9edNAL1VMGE0nyw42ElIFmHlWqoYqKq8UgC1JQnbqWoOhIRN3yDJ3FdI
         fTmQIyMryZfgKud+/YD9+G41/Cnib70dQf37jhewSjyNiTjiT0GZUoxGSslw35X0HWtS
         vaUobyGghEd1biLmC5uF6QvL2974YCFyVWrVMB7SyhgqIXZZKAakIxuyB+PxoE59KcEz
         glqcbi17kYYf9G9icTkv8mbLXvo2oo7mlv5QTwup6vu4C8+5tht7U12jpTHYskcMyQ6B
         I4jovjQCvk5oRdEEwzqnrGLBIZ9Ydp3BmX42QRr+PbGOm7dFSBrosyKBPnd9egsRP9zf
         gB0Q==
X-Gm-Message-State: AOAM531AFivHCRree24aDLrPGtt7o5QNMCUW3LtiMxVDS1YL2rwoZk/3
        zAEiqNz+lMAChLb3OvxFb2SAeA==
X-Google-Smtp-Source: ABdhPJwjS/qzIbhP6Zi3YtFpCzdnzG3pyEYGlKEP/6TmD6q9pko48oi0coPJ+NgMiMrgN0VAVE6f+A==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr2482976wmi.178.1618213076201;
        Mon, 12 Apr 2021 00:37:56 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id o5sm13676490wmc.44.2021.04.12.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:37:55 -0700 (PDT)
Date:   Mon, 12 Apr 2021 08:37:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 00/18] Rid W=1 warnings from GFS2
Message-ID: <20210412073754.GA4869@dell>
References: <20210326091151.311647-1-lee.jones@linaro.org>
 <20210406091126.GT2916463@dell>
 <468723920.4255981.1617709446972.JavaMail.zimbra@redhat.com>
 <20210406115434.GU2916463@dell>
 <CAHc6FU4bH91pWgFMytuvhgkr9YJs_VdggZdjEC6EwQJ-9Jj+3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU4bH91pWgFMytuvhgkr9YJs_VdggZdjEC6EwQJ-9Jj+3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2021, Andreas Gruenbacher wrote:

> Hi Lee,
> 
> On Tue, Apr 6, 2021 at 1:54 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > These have been on the list for a couple of weeks now.
> 
> thanks for your fixes, I've gone through them now. I've fixed up some
> comments instead of "demoting" them to make the patch somewhat less
> destructive, and I found a few more minor issues along the way. Those
> changes are now all in the following commit:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=c551f66c5dfef

You squashed all of the changes across all of the files into
one-big-patch (tm)?  I haven't seen anyone do that for years.
Hopefully none of it needs reverting or bisecting!

Anyway, thanks for merging.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
