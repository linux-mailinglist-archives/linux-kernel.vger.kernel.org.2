Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC1443DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhKCHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhKCHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:40:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E3CC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:38:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 71so1175325wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=66uu6pMFwaoqtLUfKJfHxB8EI3iZ+Lon+COm99nenUY=;
        b=HqJqilX/JQilM9KQgkgb6Bnwml/foCLiItRrTReaWcfjqBrlTDnshb6i6dlzTYL7lh
         /t+dJVYNUu9ncUNo0g36PLv/a8EpQUBuaDSBLBBe8n7YrnE1r3icMXcHHXQFF+9M/0Nh
         dtnOxBbsePavMlxkkRHudD4ouuPvLohjQvchhR0JV/fshrhsAB+I9TofAJdPuZhJZxLp
         SJYzg895+76IsWC18Plfk2hqqk+RJ9iymFf7dS7JWxkG60vva4hKrM2UjZ20YlYfGt5o
         KPFIYHIS+A1TpZXcuMRbBkPgYwz+J2n2gQjXileDnlwRKH6HB3BYAeuH+fnFAdHDKy3S
         nQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=66uu6pMFwaoqtLUfKJfHxB8EI3iZ+Lon+COm99nenUY=;
        b=uqIYCrRp2NJFXL4qJkA9Ybrfdwc93MgYBh1fw7CXu/9BO7/mOpZoNUh7C2byaXKyaD
         MUPNoiWWmxamJDH0JLwaQk03cXERJB8htFrFKM1ma29vFyAZH9BwgFV0f8vYcxgn+SO1
         sPSb0H8orUVURiM20A/1UIOEt4PeO/4J/Z9axE/iSbZe/pQmQP6RHLh3XRIYPgnpMyDN
         8qPy49IhwAJNwwIv/zJrtx7+G0NxjxMz6ADYBnRHzMNLGLkE2n2kM/ZDOfAKjm5WRLuA
         0gDREGo5+c8MQvlXnIxKr/l1mu5e5TX6jFtWZeuHv10qJsMCVjFYdSJTaaE47v2tA95C
         oP+A==
X-Gm-Message-State: AOAM532oMQnEnbTofXFas9pv9LLOqWJYkRfl5/9rPVNOjlDTTWQ9dElf
        ZtiiPP4p023V7eFgCKAww1R8pQ==
X-Google-Smtp-Source: ABdhPJwpt5FRcgqWxnYtyGA/+iVpKBGh0lFBovYyOVnD0FcaaHzWWVyRsxSvVsU9OVYbHtuLoIFQaw==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr13231252wme.158.1635925092007;
        Wed, 03 Nov 2021 00:38:12 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id l4sm1126960wrv.94.2021.11.03.00.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:38:11 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:38:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, asml.silence@gmail.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        syzbot+b0003676644cf0d6acc4@syzkaller.appspotmail.com
Subject: Re: [PATCH v5.10.y 1/1] Revert "io_uring: reinforce cancel on flush
 during exit"
Message-ID: <YYI8YjbE5xTSLLn4@google.com>
References: <20211102154930.2282421-1-lee.jones@linaro.org>
 <YYFfIk2CQaFI0Zdg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYFfIk2CQaFI0Zdg@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Greg KH wrote:

> On Tue, Nov 02, 2021 at 03:49:30PM +0000, Lee Jones wrote:
> > This reverts commit 88dbd085a51ec78c83dde79ad63bca8aa4272a9d.
> > 
> > Causes the following Syzkaller reported issue:
> > 
> > LINK: https://syzkaller.appspot.com/bug?extid=b0003676644cf0d6acc4
> 
> "Link:"?

Sure.

> > Reported-by: syzbot+b0003676644cf0d6acc4@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Why does the patch here cause this error?  Is it due to the backport
> being different than what went into Linus's tree, or something else?

The patch is the same.

I need to do some more testing, but I assume it *was* also broken in
Mainline until the whole section was rewritten.  Unfortunately, the
patch which does that does not apply to v5.10.y.  Again, I can look
into this, but I'm not quite sure how far the rabbit hole goes.

> The original commit did fix a real issue, what should we do now to
> resolve that issue in 5.10.y instead?

Ideally I'd like the original author and/or the domain experts to have
a look and chime in here.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
