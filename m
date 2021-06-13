Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEF3A5784
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFMKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhFMKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:15:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:12:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so11082638wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=poSIzJOmYFsQ4+lMLGI1TzSYcT8ndRNu2aW08GsOEmg=;
        b=eJK9XnG56Rcdl91zFA3xcLmFAGahzWuLJ9hFMKNf7Ykju+KZ2KD+9pOrgndB3sKmpu
         gvyDWBo+oak7scKKrku1d6weq5OeuVHtLiqrGKhCdJzzfCV8KWPNYJKznnPgcAi5QAq7
         wuFClqfBYOM0WA2d7UeEzjMsUe94b8nGRaUc66rJQUA0TZ+8FKDBhbv4h2Y2SQaNod+r
         PeJBTxVmzT7ULhlUFGCnxWBmFs+EBeU8LWpXaNv0cNeKOjayQbEdsPSwJhJbOHZNyUA2
         qyJsPbWBntBztm9aeH+WYvR+71jGcPawxeSrQlnBb/p0BXoF4ko1yDFjPp2PXmQKL/1i
         IEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=poSIzJOmYFsQ4+lMLGI1TzSYcT8ndRNu2aW08GsOEmg=;
        b=RE4mzgt4fKvinoe+6fAIweOYG2pVsMu/W325g31EbCevWvbq5oy7i+BTfB46yzTpf6
         BaYX6OJ3beqmCl/TWspSKETm+6iN/qvDsHLU9p/hB/feEoEQkNJpi2OWa7BEmDXZ3puR
         iqpA1IA6Hr6njIxiu7CoRIGrEyYLjTR4uLL3zMygP/0XL6cCXl88V012N9r7SzgqVPUn
         Bvcix53Wio6m+KganNJD3KBoDQ/ChVXbVlR5B2SwMlZOZvUhiBXOc0k54AzZSyjtV3F9
         R7Nc6eXgqlQP/tkkJ6XmXhUvcrlNIfu+6Rv4PmGbuIFAJglOMhAZdlI8qKTWSXeHz0/5
         i6gw==
X-Gm-Message-State: AOAM533+wIzvsX7SdrlBje94oEdZgNq/ALCVwLi2RVsZz6+uB+VdHBMA
        BjZUfIpl8BNo+dh9AkyiD9Y15+bAmR4wltw2
X-Google-Smtp-Source: ABdhPJx7mq7S8KCq6B1aZsYM+PwFA47iO6pX9GzMKaP6KZjoeOLZDNeXUsmZY+J40X7v3gCFe7e1Hw==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr27657098wmd.140.1623579171245;
        Sun, 13 Jun 2021 03:12:51 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id h6sm13280633wrt.20.2021.06.13.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 03:12:50 -0700 (PDT)
Date:   Sun, 13 Jun 2021 11:12:48 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux@roeck-us.net, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_sta_mgt.c
Message-ID: <YMXaIJWYMX3726Jp@KernelVM>
References: <20210612232831.1325-1-phil@philpotter.co.uk>
 <2580565feae3e407d297b9eaa1ac6c4988c77076.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2580565feae3e407d297b9eaa1ac6c4988c77076.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 05:22:33PM -0700, Joe Perches wrote:
> On Sun, 2021-06-13 at 00:28 +0100, Phillip Potter wrote:
> > Convert both calls to the DBG_88E macro in core/rtw_sta_mgt.c into
> > netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> > debug messages can be controlled more precisely by just using debugfs.
> > It is important to keep these messages still, as they are displayable
> > via a kernel module parameter when using DBG_88E.
> []
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> []
> > @@ -113,17 +113,20 @@ u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
> >  inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
> >  {
> >  	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
> > +	struct net_device *pnetdev = stapriv->padapter->pnetdev;
> >  
> > 
> >  	if (!stainfo_offset_valid(offset))
> > -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> > +		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!", offset);
> 
> better to add terminating newlines to the formats.
> 
> 
Dear Joe,

Thank you for your feedback. I will republish my two patches with this
change.

Regards,
Phil
