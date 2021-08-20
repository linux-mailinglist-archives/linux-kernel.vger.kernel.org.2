Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C83F2B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhHTLlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHTLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:41:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE2C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:40:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so8343811pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kv+uYOUebeBGrutf+Glgrn6wPl2zWoyRwYDrWhWzND0=;
        b=YvZKK0honxkmUypRJxXgIEA3vW9ooEUcvV5EhtLM+oPN6dh4hLxJru933RwDobP92S
         vOH/E10r276+8cK8Cl5cs6HpoPzc3uZ8G78lgQvwIBWGfAISgmGpDf1p4wns/T7CUlmY
         TEXxvAjj/6xEGunHqr5+aTvAyLoVCvP6ln2ynREwE+mOnRG6oyvtz1oPMimZvT3kEHX7
         hS8ip0DwkZjE5YHSvCt9x2/IipWsWvZ4hOLFhhKfOyxqBaNHgMCIR5KaHqJm6hnKMpLT
         7FdJ0Z60BLDIMYkM4dpA4456HjW1x08cz1gs8F3Sb6va4hMVVwa391g0Zdt6mVkfLw25
         PTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kv+uYOUebeBGrutf+Glgrn6wPl2zWoyRwYDrWhWzND0=;
        b=L2FZVr7l2vpfafD1zdS6qiwf+zfy0/QJQjG61fbO5gG4T5mpTPXuQCcZAgqijpyCzs
         Z8sfgmcplHTB8DMfvMJ+8k3niV9Uw5ns/kGB5zd+ptd3EpoyqDp5BCSlD5EI5Gf54QJr
         yLMnnfM/cN1za0ucGSCvX9SYB460Qf3uXD++8tvYVKqakOf5NB0TEw5YwIYgO/jSjdPU
         3QPv0FG1Ybws9JXe3ntga40/L72FXC+pblrJov/9rzh6x/yYnAl7Pij1ULK163gMAldx
         i7VGdZDFscFXoQpK9Uw8Av9uWxSb7DgzJOa54u57VjNJeUFYywwrdF1IrzmAEhQs2DH3
         Ri4g==
X-Gm-Message-State: AOAM532W//iQDEp33z9cvcUl2JU724qZprjyGkY4318uGCPZtDTCb7rl
        Ih0UvMHG7Fp4VFjplGFRn9NiieTptqE=
X-Google-Smtp-Source: ABdhPJw85YyKvZg9Cy8gpPMOeLunrJEWZnNbToai5pXkfo30LtxTC+0pM+a8Xqv1ZdFNz1MVWPdDBg==
X-Received: by 2002:a63:f749:: with SMTP id f9mr18479135pgk.77.1629459628772;
        Fri, 20 Aug 2021 04:40:28 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id c9sm7848008pgq.58.2021.08.20.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:40:28 -0700 (PDT)
Date:   Fri, 20 Aug 2021 17:10:26 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210820114026.p7yurpf2zzp3tu34@xps.yggdrasil>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
 <YR6SlQFV0HRov/fC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6SlQFV0HRov/fC@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/19 07:19PM, Greg Kroah-Hartman wrote:
> On Thu, Aug 19, 2021 at 01:47:54PM +0530, Aakash Hemadri wrote:
> > Fix sparse warning:
> > > rtw_br_ext.c:836:54: warning: cast to restricted __be32
> > 
> > Unnecessary double cast, remove them.
> > 
> > Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > index 404fa8904e47..6a0462ce6230 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
> >  				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> >  					struct dhcpMessage *dhcph =
> >  						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> > -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> > +					u32 cookie = dhcph->cookie;
> 
> Wait, what?  The cookie was in big endian format, and now you just
> ignore it?  Why is this ok?  This breaks the code, have you tested this?

Ah, I assumed clearing a sparse warning was enough to make sure my
change was correct. My understanding of endianness is incorrect.
Will redo this.

Thanks,
Aakash Hemadri
