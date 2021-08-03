Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A953DE820
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHCIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhHCIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:16:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA4C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:15:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o5so35135213ejy.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKpGLThUAKZDHBxGPyyiTIsZv8h3dQEtwjqNS0LfTfY=;
        b=Jykv0bXk9ykz+FwAMHQ94SbW1/Boq78aX+mtIOgYAUjHD3kwsEPGCbCtrmjzvmQiwg
         ntPoCunb06r859nLxzeRzsaeiQqFuF6+7YXVL9wfFARtVmyvXAHmIs+IbJPBUegWnTtG
         YkBYJJ1VgOnMb3McBASPEsO+OhO7gDxoo8IAq1MrKVJoXWCj1ZOGNqigR+6BoapTScoN
         IeSE9aKXX8vMr5dmUWIlOclDgI9vuVYUUfwkTMA3F578j3G27aWSVa/39NoRaIHlo8VR
         x2FbWinzknLPhccnr9zUuY4F3aY2qhT14+oM2JchuSfAtsHDUnd3fh60jsFyV6/lF9Wl
         6q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKpGLThUAKZDHBxGPyyiTIsZv8h3dQEtwjqNS0LfTfY=;
        b=CYS8BxLuHgSV+IymNhQdJ2cXEViSXaiZ6dFo8F+8MdH3SZX+dJ0Ukqx6EnOqDVX/If
         kDXUhXrSM2K1z4GdwnpN7p3RWofsZ06jEdomszy5Ubi8q0jEWpcLMzuN8U3D5O0LvRUs
         Ljr2HldPTOjOBfhbb3lRVihULl0VFkfalYTIkf9oMPYEi9vEmoWxWSYYCCK4lpcweQD+
         kvmEhe1859J32H2QepUW6LJ68Paos5xGabx2FemQHWxpfXT8kMsw6pTvAJ1yChLbVPw1
         YVtKzX4LjGPqgttEy62I8Gqnbl9lSRk2+RMh3QuF9tNwr9O5Ld+gUvhBTKmHDw9SL8g+
         j4cw==
X-Gm-Message-State: AOAM530TJZ0ev9CoGRFxNJaV17sSrLXyY56skX4ZGdNAPXqo0AT+72Nf
        +H3VgGt89tUgrGTbzCZc22o=
X-Google-Smtp-Source: ABdhPJy0DAU6dtMQD9LujJfzucK0gBpu1BRKcDooUtCQkwtILARc3qp9pIHE6/3Qx+r3cy7x3mqIyQ==
X-Received: by 2002:a17:906:5ac5:: with SMTP id x5mr16771566ejs.271.1627978557934;
        Tue, 03 Aug 2021 01:15:57 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id n16sm7677590edt.31.2021.08.03.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 01:15:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Tue, 03 Aug 2021 10:15:56 +0200
Message-ID: <2671423.i2fK0j4CO3@localhost.localdomain>
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
Dear Greg, Dan,

I just read another message where Greg K-H decided to revert this patch, 
probably also according to the review by Dan C..

In doing so, the sparse warnings of different base types in assignments and 
some endian bugs will appear anew and I think that these problem should be 
addressed in some other way.

I'll try to find some other solutions that result to be more correct and in 
line with Linux conventions. But, before doing the work I need to better 
understand what went wrong the first time. So, please, devote some time to 
respond to my questions...

> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 46 ++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > b/drivers/staging/r8188eu/core/rtw_br_ext.c index 
e00302137a60..31ca2e548555 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -71,7 +71,7 @@ static inline int __nat25_add_pppoe_tag(struct sk_buff 
*skb, struct
> > pppoe_tag *t> 
> >  	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
> >  	int data_len;
> > 
> > -	data_len = tag->tag_len + TAG_HDR_LEN;
> > +	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
> > 
> >  	if (skb_tailroom(skb) < data_len) {
> >  	
> >  		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
> >  		return -1;
> > 
> > @@ -134,42 +134,68 @@ static inline void 
__nat25_generate_ipv4_network_addr(unsigned
> > char *networkAddr> 
> >  }
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

Here I've been misled by something else. I agree that f1 should be four bytes.
 
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

I'm not sure to understand. Please, elaborate a bit. Do you mean that there's 
no need to use be32_to_cpu(*ipxNetAddr) and that we can use ipxNetAddr as-is 
(it is a __be32) as the second parameter of memcpy(), even though the 
networkAddr+1 is the address of an array of unsigned char? Is this that you 
tried to explain to me?

However, there's a huge error in passing the second parameter to memcpy(): it 
should be &addr.f1. Or better, let's make addr to be __be32 and then pass 
&addr (so there's no more need of that union). Do you agree?

> >  	memcpy(networkAddr+5, ipxNodeAddr, 6);
> >  
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

According to my understanding I need to wipe all the bits of addr.f0 before 
reusing it in the next assignment. Don't I have to?

If we agree on this, I'd like to explain why I use the xor of itself... I know 
that `addr.f0 = 0;` is more easily readable. But I've always thought that a 
direct assignment of a specific value (0, in this case) should indicate that 
one wants to use that 0 for something that needs that specific number.

For example, in `for(i = 0; i < len; i++)` to indicate that we want to loop 
starting from 0; or in `res = some_func(); if( !res ) return _FAIL;`, and so 
on. In this cases I want to make it clear that 0 has a precise and special 
meaning.

Differently, when one simply wants a variable wiped out of any content, just 
before re-using it for a subsequent "real" assignment, I prefer to xor(ing) 
that variable with itself.

Does it make sense to you?

> > +	addr.f0 = be16_to_cpu(*ipxSocketAddr);
> 
> I'm so puzzled.
>

Again like the assignment above, *ipxSocketAddr is of type __be16 and the 
destination of memcpy() is an array of unsigned char(s). I think I could just 
have a __be16 variable and pass the address of it to memcpy.

Do you agree with the solution above? (Probably I was so distracted that I 
didn't see I should have passed a pointer as the second parameter of 
memcpy()).
 
> > +	memcpy(networkAddr+5, addr.f1, 2);
> 
> This patch is really weird so I'm done reviewing it.
> 
> regards,
> dan carpenter

I'm going to wait a bit for your reply to this message. If I don't receive any 
response I'll wait for the revert and make a new patch and see what happens.
Or, I could fix the patch, if Greg does not revert 56febcc2595e.

Patiently waiting... :-)

Thanks,

Fabio



