Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568113DDAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhHBO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHBO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:26:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A9C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:26:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so17105513edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXkv8U6JEJ9uH4cM8zikMXs3OixCFv3bMO79Qh9hRvk=;
        b=KZ+utS5C56NNXbltvwIEGLsCy0bGdgb3Ze6cNxcMKLIFalGqlOxdbk7q8BKU1tgysO
         2Hk/NPPCVzGHmUgOud1TiKHpvmH6oOVVCgNGq9+R5H/IEC6jSXxlz0Mqwhwye/T0guOD
         YwUBVmOQwZNx3YaGLWC7QZSth8BEUT6Q7vSKaoJkeGsWxsDH5bB9HTvZpPpijrurPnuH
         2zoLr+Lp+w1aKByskUV7ttaPx3qN3bhns6fT1McK15/zlhtfUCc1c8bSKQQhL4hKFfJv
         Ef8A/UtqRSznVez7EVYoVzSsP5Ls9VNdEj0EzMWYL6xrY+gdLqY+PKO2l0i+5ZztOxJi
         kdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXkv8U6JEJ9uH4cM8zikMXs3OixCFv3bMO79Qh9hRvk=;
        b=kXg8Qt15HNpMBCM8YgJQDIfOQ8i5gPYCaBeKZIBuUl9PMy+kPERX5TfU/1PNuw6v/R
         VmyZbvwzpr9hOEvkQN+/RIKF6Y7wMRyq9nh5THSM86RKqx37txfnA4xyZXoMz7uigHvc
         Aw8o0dzoLih9dctFbuFyDqOm6F28P5NIQHV1VDgh0C8W02ZUvhUA06hGvXLt8W4rFegF
         3PV5G5qje+dR6q3ZTBx7ys2z6FLVV8jsF7XyMMdkDZh3jvxu7+j0VQ9Zs9Zo7m6Emwop
         ksm14GRQsnT9McjEwp5VC6swrpSsuJPKDHBRDGuS/Uaiuy4NCdo/pQFCSWvwPc9kJXPA
         x2Xw==
X-Gm-Message-State: AOAM530NBg9Ib0d8hzCbw+P05WG7Z88KKDVypMYWpANhAZr6KzTpnrmJ
        hFVya4ZDgh6UQcjyzMRYqBI=
X-Google-Smtp-Source: ABdhPJzmbuhQhMHrqCMoAEhIfIYYvo4WYLMCu+/FTRVKU/TnGd+skwQn76xwKPZQdOp7z+rGc0rSoA==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr19858730edb.363.1627914394853;
        Mon, 02 Aug 2021 07:26:34 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id de19sm6252267edb.6.2021.08.02.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 07:26:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Mon, 02 Aug 2021 16:26:33 +0200
Message-ID: <2081658.ULrIQvW0dQ@localhost.localdomain>
In-Reply-To: <20210802140505.GZ1931@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com> <20210802140505.GZ1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2021 4:05:05 PM CEST Dan Carpenter wrote:
> On Fri, Jul 30, 2021 at 08:14:52PM +0200, Fabio M. De Francesco wrote:
> > Fix sparse warnings of different base types in assignments
> > and in passing function parameters.
> 
> This patch fixes some endian bugs but it's not mentioned at all in the
> commit message.  Did you send to the correct patch?
> 

Too late to change the commit message: Greg K-H has already taken this patch 
as-is (please see commit  56febcc2595e).

> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 46 ++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > b/drivers/staging/r8188eu/core/rtw_br_ext.c index 
e00302137a60..31ca2e548555 100644
> >
> > [...]
> >
> >  static inline void __nat25_generate_ipx_network_addr_with_node(unsigned 
char
> >  *networkAddr,> 
> > -				unsigned int *ipxNetAddr, 
unsigned char *ipxNodeAddr)
> > +				__be32 *ipxNetAddr, unsigned char 
*ipxNodeAddr)
> > 
> >  {
> > 
> > +	union {
> > +                unsigned int f0;
> > +                unsigned char f1[IPX_NODE_LEN];
> 
> What is going on here??  Why is f1 six bytes?
> 

Please look at the third parameter of the latest memcpy() in this function.

> > +        } addr;
> > +
> > 
> >  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
> >  	
> >  	networkAddr[0] = NAT25_IPX;
> > 
> > -	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
> > +	addr.f0 = be32_to_cpu(*ipxNetAddr);
> > +	memcpy(networkAddr+1, addr.f1, 4);
> 
> What's the point of a union?  memcpy() doesn't care about endian
> anotations.
> 
> >  	memcpy(networkAddr+5, ipxNodeAddr, 6);
			                     ^^^^^

I'm talking about this memcpy().

> >  }
> >  
> >  static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned 
char
> >  *networkAddr,> 
> > -				unsigned int *ipxNetAddr, 
unsigned short *ipxSocketAddr)
> > +				__be32 *ipxNetAddr, __be16 
*ipxSocketAddr)
> > 
> >  {
> > 
> > +	union {
> > +		unsigned int f0;
> > +		unsigned char f1[4];
> > +	} addr;
> > +
> > 
> >  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
> >  	
> >  	networkAddr[0] = NAT25_IPX;
> > 
> > -	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
> > -	memcpy(networkAddr+5, (unsigned char *)ipxSocketAddr, 2);
> > +	addr.f0 = be32_to_cpu(*ipxNetAddr);
> > +	memcpy(networkAddr+1, addr.f1, 4);
> > +	addr.f0 ^= addr.f0;
> 
> What on earth????

I can't see any problem in xor(ing) a field with itself. Perhaps I read too 
much Assembly code :-) . However, am I missing something? 

> > +	addr.f0 = be16_to_cpu(*ipxSocketAddr);
> 
> I'm so puzzled.
> 
> > +	memcpy(networkAddr+5, addr.f1, 2);
> 
> This patch is really weird so I'm done reviewing it.

I'm sorry that you don't like this patch, but Greg already had the last word 
on it.

> regards,
> dan carpenter

Regards,

Fabio



