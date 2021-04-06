Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09716355A87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhDFRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347040AbhDFRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:39:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:38:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a6so9108348wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LRkA7A4+2n4k7i2ixOSSZ3znMP0QX+wQLdR7DfRjhA4=;
        b=cWz+miqnhqx/Ck7FRhOF76+uDk/6t4kvmlCpJ7P/vpwfM25ZMrbrOkAEmRhxHtp0Po
         APG2q9P/EySG7Z1CI4PxSQh99EjP8vFk5ftAm00TJfjnOzMXHdfO4dOKBsovHQ12njGX
         vWBMJY8X4GLLvIUQguC1HAODvLdT/B08+Vcw0DK94rQCAOn1aHGAZf/yX0gm8w8O6rPR
         Eg0+gGFhfCfYmr9NpRSaheHamnT8SsXOzRyFDGDsS5E5VbdGesuHakA7IIb9VkPkObpK
         goawhpAnryfKwifB4bTfdBEEeuDcg1gWBd8RNgrIf/eJ/es6okpLdRYh3o0aSpfdFiD4
         f9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LRkA7A4+2n4k7i2ixOSSZ3znMP0QX+wQLdR7DfRjhA4=;
        b=DgF2MLS87GlcmcJwkG/pkvzCgyDhkz5SWwRaMQYxOO/l++jnbQie08PwdQSqIlclMh
         Y2DzEQoKHo9jWfTRhZGpKqyI3gosdvokBqzlwK/3DZBdJjRu6AMdFjC6UJ2JwS+q4gNx
         NDYD0X1w9uORpCfmpiJZOtOioaTDlveV+HSNfn8sOh6m+piHOsxaMWBuMYglYm3GPprh
         IxMM0H01C303HzO1CC0OzQPdH9achaQ1+yOtZt0aylYa4GGb/tUo4ImplYiv8kociRdH
         ZoFVzsfdVba41qgzLzzzThYtYmygqt5h4PzXqZBSHrBIFi+Mz9WMfAvVaAy/9kwxS/W2
         HZmA==
X-Gm-Message-State: AOAM532q5Uq6m5mgQVYkEhewGcGx9Ufnqt1u6rB+JVLTgO2w/Ai+0OUP
        cDpy+aUacaAKmbFqw1u3N1UIpA==
X-Google-Smtp-Source: ABdhPJy7/7LQloWrTrcFc+xvD2e/I8oWqFa9LQ4TOUkUFJEFfLNSfTWGyNnaD8fymwtmPjYc/XvVsg==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr23948518wrr.350.1617730736878;
        Tue, 06 Apr 2021 10:38:56 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k7sm23810170wrd.24.2021.04.06.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 10:38:56 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:38:54 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] net: tun: set tun->dev->addr_len during TUNSETLINK
 processing
Message-ID: <YGycrv60GeQezQ3Y@equinox>
References: <20210405113555.9419-1-phil@philpotter.co.uk>
 <ba1f5946-d1ef-ee4f-4ce1-15af2b324181@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba1f5946-d1ef-ee4f-4ce1-15af2b324181@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:26:29PM +0200, Eric Dumazet wrote:
> 
> 
> On 4/5/21 1:35 PM, Phillip Potter wrote:
> > When changing type with TUNSETLINK ioctl command, set tun->dev->addr_len
> > to match the appropriate type, using new tun_get_addr_len utility function
> > which returns appropriate address length for given type. Fixes a
> > KMSAN-found uninit-value bug reported by syzbot at:
> > https://syzkaller.appspot.com/bug?id=0766d38c656abeace60621896d705743aeefed51
> > 
> > Reported-by: syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> 
> Please give credits to people who helped.
> 
> You could have :
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> 
> Or
> Diagnosed-by: Eric Dumazet <edumazet@google.com>
> 
> Or at least CCed me :/
> 

Dear Eric,

Please accept my apology for this oversight. It certainly wasn't
intentional on my part, and entirely down to inexperience. I will send
the patch again with Diagnosed-by.

Regards,
Phil
