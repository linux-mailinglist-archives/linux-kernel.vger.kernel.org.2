Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B03512FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDAKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDAKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:04:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0934C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 03:04:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ce10so2013794ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OCvNknNouVcT+J3VJsfOETcTV0+YmRxhcYvHLVChqKc=;
        b=XBE4cC1UNniT+xkqPdJRM7QYfO182EBTnhzzd6w9FiaXPLl7l+YkokWnm+RKYuoms8
         4WmrDRNvqDhTAnNV9yppCl7ZeggFQuGd1T9J284BoPWJ5GBE8i5jQsEPHoVcjnQO1isr
         jEXfNztj15bZvgYX77exj828UPQy/YdhtXj7tKzBhzZMM0PRwRFIOPyavY7i7tpjfZBc
         zisug5RLWNYJP7Msdgu60euWT15cZzlbYRwIk2T696cFUWjwtyaxpjKrau3tIREXzVYS
         XlZ9tnb7+wg9fTd2XyRaQBPMVSapkNNmiVP9UH8D/xVQ9fmeESsTSgoIwe7KUewNS1bG
         bf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OCvNknNouVcT+J3VJsfOETcTV0+YmRxhcYvHLVChqKc=;
        b=TLIKrQxGDopzMI+Y0Hfmljk0znkLTqdsnbPfphX5TcfYXC4NpUPNAGf4fbrMuwZtHE
         M6yhoed6bhXRBtPBU1o426bbWz6tJL3Pihc1mxhwVqzqC5QVwj761ZFxrTu/f5OwIfo7
         +v/FPVZ+cmBQAqv5QsG1vaUJs0R1NnSwug0lswZ+hDe2c1bB/mBLWZf0cyTu5XO+SuGm
         o77PPZfYPV1R9+tzzuod/yehVBjc4JTMwujGWOE4dRStKu93uJx5mXd1XSosvmYeRboW
         H/lBOsgpjtEmrslwGtssqDXDT4QtK4+eNnJSHTRVBbL7T3saqL/IgU7fRkMXQKPl8jb7
         c3Gw==
X-Gm-Message-State: AOAM533fep75x2UCe/Ji0bA4tAn8/1w1w4r7oN6bAt3ZvvQt69t4D9El
        A6to2F57gqNdkQcsT9gaugRN6Oxm3KE=
X-Google-Smtp-Source: ABdhPJzSV13oS0rfd6pUKeJfUfFWjxsfwYB/9uqQBxAwpzTAKkmZZIkehx0q/1kUDRqwka5sp4ZEEw==
X-Received: by 2002:a17:907:2d9f:: with SMTP id gt31mr8125991ejc.233.1617271442653;
        Thu, 01 Apr 2021 03:04:02 -0700 (PDT)
Received: from agape.jhs ([5.171.72.75])
        by smtp.gmail.com with ESMTPSA id l10sm3327014edr.87.2021.04.01.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 03:04:02 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:03:59 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210401100359.GA32563@agape.jhs>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
 <20210401095017.GR2065@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401095017.GR2065@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:50:18PM +0300, Dan Carpenter wrote:
> On Thu, Apr 01, 2021 at 11:20:38AM +0200, Fabio Aiuto wrote:
> > @@ -677,9 +663,8 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
> >  	u8 res = _SUCCESS;
> >  
> >  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> > -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> > +		;
> >  	else
> > -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> >  
> >  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> 
> This is a bug.  Smatch has a check for this which hopefully would have
> detected it (I haven't tested).
> 
> There are some more similar issues below as well.  So generally the rule
> is don't adjust the indenting if it's not related to your patch.  In
> some cases you have been fixing the indenting but it should be done in
> a separate patch.  But the other rule is that if your patch introduces
> a checkpatch warning then you need to fix it in the same patch.  In
> this block the whole if statement should be removed.  But also if you
> have something like:
> 
> 	if (foo) {
> 		RT_TRACE(blha blah blah);
> 		return;
> 	}
> 
> Then checkpatch will complain that the the curly braces are not
> required.  (Checkpatch might not complain for your patch but it will
> complain when we re-run it with the -f option over the whole file).  So
> you should update this to:
> 
> 	if (foo)
> 		return;
> 
> That's all considered part of deleting the RT_TRACE().  Also if there
> are empty curly braces then delete those in the same patch.
> 
> I have looked over patches 1-7 and those seem basically fine.  I'm not
> going to review any further into this patchset because you're going to
> have to redo them and I will be reviewing the v2 set later anyway.  So
> just look it over yourself and check for any similar issues.
> 
> regards,
> dan carpenter
> 

thank you Dan, I had a lot of trouble thinking what was best,
and sure I will install smatch on my box :-D

fabio
