Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1773FF748
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347735AbhIBWkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347662AbhIBWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:40:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 15:39:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m9so5368199wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pOGARM/3r7XhtT2OObL4KaH9wnbE2NcOM9J9iRB5eis=;
        b=FwYCZty4w/TCOCpGUI8c/SCwnPqjh3Y4iLQWlMI1m6uGOMdMdpWTPErBDQ9cgMRVfj
         YwXFnJNbGVMBSCFp1o7WD3hMRmNXloGem1fo1C1s6AjtE2JoSHm0J06rEczF7C9QymXh
         LPL+dSDkccUeqcqynbdvudFcUDlTIv/X8LGiO5cmefbxheHmqQlB8fheJahONBwkUlMV
         M1wM90yhdFKglSznIktvg/HWpKvnXolSWd1orJoHLEsRZ/bleFY3kynjhYpWwkL8XzXD
         ck2CoJp4Zg7HMyViM42n7MQuGXZg2XraEf3wVkifiBcrZSRloQ1nuUmteHYNMZt7DAm7
         WXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pOGARM/3r7XhtT2OObL4KaH9wnbE2NcOM9J9iRB5eis=;
        b=V4BAHbYurly4/By1vXoT9MAw16wTp6jg7S7BBRTJcxq6DYhypu4b4wOfM95L1iM9PA
         9TVA8XhEiGkFe7CU5tBkJQiD2nTyhBSVeMzo4AJFBDEQBHPCndtvfgUdttRN0t2zhiQ7
         aCef/epuCDiC+fNpzzQtAgOA3v5br3bxSN7+Cdi3c/SNYFYOtmCSFSGipgpmS1RbESgA
         X8umtrKIgGi3SJlb78xJpKwgidmDcKZURfbnYy0/v7h2P9LehB1ibd0DHq8xO7QypTz/
         sfw+02lNppAd7kdB93oI2AmX7ouBmec/o63xa3aipT+0VQ5ozBYpqWOisgwy0rfNH+1r
         zPoA==
X-Gm-Message-State: AOAM532rPN5APDOyJJ9143TaHeI6CgnhkgZ9iMOqJ0xKr3gBCLECqLAB
        TJZNOlU2YGvAia/C9nJKzQWnBg==
X-Google-Smtp-Source: ABdhPJxHOgQgkjjLjAXVnGzV819Eo+ydxq+5mNHrjVJ6JUH4M8hU0JPSh205P8Vq/YXFtzm31fWOYA==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr541268wre.344.1630622392132;
        Thu, 02 Sep 2021 15:39:52 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l187sm2670605wml.39.2021.09.02.15.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 15:39:51 -0700 (PDT)
Date:   Thu, 2 Sep 2021 23:39:49 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging / IIO driver changes for 5.15-rc1
Message-ID: <YTFStUtOAFTazKSi@equinox>
References: <YS+LXqoDGk0CqU1Q@kroah.com>
 <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
 <YS/pzJCV8MiwOPRB@equinox>
 <CAHk-=whzVVzA5Ng0BUZOvhxEjQiopjwWM5KQDhh6-dWKbD_=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzVVzA5Ng0BUZOvhxEjQiopjwWM5KQDhh6-dWKbD_=vA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:28:02PM -0700, Linus Torvalds wrote:
> On Wed, Sep 1, 2021 at 2:00 PM Phillip Potter <phil@philpotter.co.uk> wrote:
> >
> > I left this code in when I wrote ae7471cae00a ("staging: r8188eu: remove
> > rtw_ioctl function") with the intention of modifying and reconnecting,
> > once the changes to struct net_device_ops made their way into the
> > staging tree.
> 
> Oh, ok. That explains why the dead code existed.
> 
> Yeah, I guess y9ou can resurrect it now with the new siocdevprivate model.
> 
> I actually ended up doing that first as part of the merge, until I
> noticed that the code wasn't connected in the staging tree at all and
> then decided to undo my merge and just remove the dead code.
> 
>             Linus

Dear Linus,

Many thanks, I'll get that done. Have a great Friday/weekend.

Regards,
Phil
