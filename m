Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4754A45E6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhKZEVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhKZETh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:19:37 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62484C061374
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:28:27 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id bu11so6178685qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zr3d/aeNuGTjaNJ+1aJnFkBFofM1DRigQeVICXWqE6g=;
        b=OzTJTq9YHKP64dY6YrTPjoqOBUWOm/oisRpF14mfcrvjy6crxMmwS89KpQq+FChsr2
         3RKixEEsRmery0WVQ1xkE3GFuCivB53c8Yf24Z42SmLkarz2eiteZ555i8t0GgfgnHcE
         K7ZBOsbWSo0+DMDiB6apvVTlIfl2Xijq4MvMsmbFtbV74Xeftk9XAvoblr28nhBrdUfV
         0lbjUNsxyt1r2PwHegKTbLWPSth2R6qVRyz3nEMs+YUpBjp38o/OyFLn9T7ZXuxoYo7c
         X0wq3/lx4jk4Nn7YKEaG1IPVkvWbqKPQWq9MBFEc9n9rgnHmInGCkq2kzEalfY2XjcLp
         AExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Zr3d/aeNuGTjaNJ+1aJnFkBFofM1DRigQeVICXWqE6g=;
        b=4aQWN0cqIvKhTFjoY68IjbNL2mU7ZA3Apijhn12FAGmK2OIbEyK4EIDMmV5c0l8Oyq
         BxT4tryLsDBkzHskvaEuJ27zP4/4Ls/a4uFIV5VsfP67MgRGnCdnKejWxrFmKzzLdinV
         BqVjog2p4csFQhdkB+W/nPlQHBd5E6KqVuDd4J0ub1QXbOieKNAUAZ2t6m4DAc54PSz2
         YI+SYRcoVh8srlvO4u9I3eajvr0Z7DOCYTAyv9v6yzs5KpXQ5+mB59sgqNeGUpXjBJ8w
         MDYzNPRX5Tx4lVjUp3a5wwTeKy7RdFSrYJmClRtUQWl75ujkYyNj4UdkGE8kNfSO2rZz
         ysrA==
X-Gm-Message-State: AOAM533JiicVdjr9LisiYoCqYcG5SxzuCOLIsQ9nD7dx4Xu9v0CXmh27
        9i1Qs0x7R0M04GbCTBybIw==
X-Google-Smtp-Source: ABdhPJwID8LSyzVXzGskQl33Uphq5vpudnGLG2zNElXr7p0Z7xq5IDI5wV8Nr6kEH/C1/oglGYVfuQ==
X-Received: by 2002:a05:6214:230a:: with SMTP id gc10mr10237101qvb.115.1637897306404;
        Thu, 25 Nov 2021 19:28:26 -0800 (PST)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id d5sm2725466qte.27.2021.11.25.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 19:28:25 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:adf8:b831:eb9b:b451])
        by serve.minyard.net (Postfix) with ESMTPSA id DD7771800B8;
        Fri, 26 Nov 2021 03:28:24 +0000 (UTC)
Date:   Thu, 25 Nov 2021 21:28:23 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     andrew.manley@sealingtech.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: fix oob access due to uninit smi_msg type
Message-ID: <20211126032823.GX15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211124210323.1950976-1-kuba@kernel.org>
 <20211125142140.GV15676@minyard.net>
 <20211125070543.7d3225af@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070543.7d3225af@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 07:05:43AM -0800, Jakub Kicinski wrote:
> On Thu, 25 Nov 2021 08:21:40 -0600 Corey Minyard wrote:
> > On Wed, Nov 24, 2021 at 01:03:23PM -0800, Jakub Kicinski wrote:
> > > We're hitting OOB accesses in handle_ipmb_direct_rcv_rsp() (memcpy of
> > > size -1) after user space generates a message. Looks like the message
> > > is incorrectly assumed to be of the new IPMB type, because type is never
> > > set and message is allocated with kmalloc() not kzalloc().
> > > 
> > > Fixes: 059747c245f0 ("ipmi: Add support for IPMB direct messages")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > This is correct, and in my queue.  Thanks for the fix.
> 
> Where is your queue, BTW? I see not T entry in MAINTAINERS and nothing
> of note in the github tree from which you send PRs.

It's at github.com:cminyard/linux-ipmi.git for-next

I hadn't pushed it up yet, I wanted to do some testing.  I just pushed
it.

-corey

