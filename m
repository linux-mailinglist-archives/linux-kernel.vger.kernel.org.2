Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE49361910
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhDPFDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhDPFDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:03:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2BBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:02:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s7so25278263wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z6eB0W81XFyjhtb4Bf1cascTOP66PwUzd+KSO3OAPso=;
        b=M7znf+z5L8F5150UJ2PJNv3YCHDwVq7jrjCcGJYFxwCpYas++PnjVt5F4054GK9SfQ
         fkz1Sp/CH/gPE14oLF/T78EnUgwN5XZyX9BDb9Cza+bBl/+L2bab8CJe0cEtHrmxqTCg
         VtXa8A73sPd80VV8KcuCgrBdYn9QtWeEBT/WTQujgbv89ovYpgOuKMBU1HzJqQJad1Wj
         mCbz8SmgSBwbyGg7rvzzm573yqC91FHiXdtnH09BMI9jC5KlOFwQigPM+/ndtDxpgGIW
         +OB5k8dOYakXyomIRX2jB7DvKeZ0EM1gHdtDLWAmm8jmfbGocB+grc40hy6kWtJeSw6Y
         1tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6eB0W81XFyjhtb4Bf1cascTOP66PwUzd+KSO3OAPso=;
        b=pFS4ndDV7peic2cMdBrii83tQ4qy3CFuoT3xPec39o6fue+3WoNAFp4LEILxCf7vIu
         pu8DhwwLlz+cabcMQXH2h333rROb/htccg+W9eQToTWHw0riTkFV7TbCzgIfoQV7IxIu
         g+lIiCUYTUL705MbMS/3I+POoHbg/E73cbPdx4t0aJiqwJ+KTjLY/p3fJiBJNFeCK70/
         bztvUoczAPdQWDUHS5aYGXL/tEp5TfcrwakOGzFZ6Mn3nuwAQx0gh+uXBlAdBrTyapoJ
         HbcktQBhyFj+3u7ShoY2s8LVbGERxalCiVWOZcz06zy+S5jafItoehPJysbtjFIqK8ty
         9Vlw==
X-Gm-Message-State: AOAM531jiQnj52xZA3yzsMjl0qx0PPE4F2IfQbng/7sleo0xWJOK1vZc
        kyFYGbLAQyflSGgq19x0mkvt
X-Google-Smtp-Source: ABdhPJyyOqMuoHOuA3UGgm5JCyuMO8waqJKElBjb3ciZTuPo/c2lm3jN+lhMx/bZsCjum3sE3cGHXg==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr6891723wrm.15.1618549357251;
        Thu, 15 Apr 2021 22:02:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:9d22:ab98:31ab:7a9d])
        by smtp.gmail.com with ESMTPSA id n9sm6470561wmo.27.2021.04.15.22.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 22:02:36 -0700 (PDT)
Date:   Fri, 16 Apr 2021 06:02:33 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>, ojeda@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YHkaaTQ2KQML2iqt@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com>
 <YHkRvhIeO2794f7v@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHkRvhIeO2794f7v@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:25:34AM +0000, Al Viro wrote:

> > Are you stating [what you perceive as] a fact or just venting? If the former,
> > would you mind enlightening us with some evidence?
> 
> How about "not everyone uses a browser as a part of their workflow"?

The documentation is available in markdown alongside the code. You don't need a
browser to see it. I, for one, use neovim and a rust LSP, so I can see the
documentation by pressing shift+k.

> I realize that it might sound ridiculous for folks who spent a while
> around Mozilla, but it's really true and kernel community actually
> has quite a few of such freaks.

I haven't spent any time around Mozilla myself (not that there's anything wrong
with it), so I can't really comment on this.

> And as one of those freaks I can tell
> you where exactly I would like you to go and what I would like you to do
> with implicit suggestions to start a browser when I need to read some
> in-tree documentation.

I could be mistaken but you seem angry. Perhaps it wouldn't be a bad idea to
read your own code of conduct, I don't think you need a browser for that either.
