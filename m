Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AB444684
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhKCREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhKCRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:04:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B83C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:01:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 71so2507911wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4lIhYLX16E5dGAMp8p9rDyFi1F2gTM+Q1Uh/Pl4rLPY=;
        b=EaMKlGiCKGFYXlmVwztOTXSiL2HK7f05V2JPHBSDWT3027cIjatnLYxTIeXi99waqF
         WI5CZsIgUtqMzRMn+MCMUVayjB0PZO/5w9rTyg/aB2FD+7/u2wipTNO1uKoTOtwcm29V
         /MBOV6wocnSta4b76G23XaMj5wK2G4oE86QeeAHTd9cBXIQTXPr9ht1fV8w3IHwQOyns
         XkK4BMUMkvChwanmCaSuyDQ5O3x4GVeHppLxIvTwEka+kRtSnYQVnoihhNtL348rl3wA
         HGadB+Vd2gAwQMJJ0AzhAFeZThsRJW7/VELGAninhkI3hR9mcMYUgTR55y0huByLh+ZJ
         BuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4lIhYLX16E5dGAMp8p9rDyFi1F2gTM+Q1Uh/Pl4rLPY=;
        b=DmXxpuuDOWHGXCjNgDXRnCdaDs6xNnVmMoLSQe/OV+XWXbtXRwIF+h0C/X9mAqi0AC
         gR3G8wmNalKEhcrOhjOEYmFYNf+nqH2r6pyw/sWGefciHuIlAeVgOYJWbLsFsEkc2Gu9
         PaTrB6+GDFfs1gfdV/ulP7mnUPAO6Seafj/fgXdKmL+9gOBdsXF05xj2ynavysCadcZL
         2R08JrM6CtiRetMdzW2HP1Cxai9I+DfvtTSVYrotZGBhCE5WG5fHcO0eF/llQg6bvAP5
         JYHO/7vNAKpmIFmZm30IjBGxt3cHn11IFTGnlktLZiALFZAzNeP0YOKuSHUnn5PZFJSe
         BNpw==
X-Gm-Message-State: AOAM532lDhlxquplKPbWOt1i0culSqkiLqCpLVKbQNi8dXXQSNrLAdsD
        LGWasMTIvm1+g5EgT68SiPF1XA==
X-Google-Smtp-Source: ABdhPJzWDmxu6si35aJclXAhUjcBNkg1SJiEjJ8BjEAzBYVwwyPTExaj5FFOMQK5ecqvYP64K1g+Dg==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr7503442wma.129.1635958884853;
        Wed, 03 Nov 2021 10:01:24 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id p13sm6639467wmi.0.2021.11.03.10.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:01:24 -0700 (PDT)
Date:   Wed, 3 Nov 2021 17:01:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     syzbot <syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com>
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in iov_iter_revert
Message-ID: <YYLAYvFU+9cnu+4H@google.com>
References: <6f7d4c1d-f923-3ab1-c525-45316b973c72@gmail.com>
 <00000000000047f3b805c962affb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00000000000047f3b805c962affb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Pavel,

> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         bff2c168 io_uring: don't retry with truncated iter
> git tree:       https://github.com/isilence/linux.git truncate
> kernel config:  https://syzkaller.appspot.com/x/.config?x=730106bfb5bf8ace
> dashboard link: https://syzkaller.appspot.com/bug?extid=9671693590ef5aad8953
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Note: testing is done by a robot and is best-effort only.

As you can see in the 'dashboard link' above this bug also affects
android-5-10 which is currently based on v5.10.75.

I see that the back-port of this patch failed in v5.10.y:

  https://lore.kernel.org/stable/163152589512611@kroah.com/

And after solving the build-error by back-porting both:

  2112ff5ce0c11 iov_iter: track truncated size
  89c2b3b749182 io_uring: reexpand under-reexpanded iters

I now see execution tripping the WARN() in iov_iter_revert():

  if (WARN_ON(unroll > MAX_RW_COUNT))
      return

Am I missing any additional patches required to fix stable/v5.10.y?

Any help would be gratefully received.

Kind regards,
Lee

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
