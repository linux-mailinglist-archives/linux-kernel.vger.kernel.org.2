Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B503F9BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbhH0Pkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhH0Pkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:40:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5ABC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:39:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c4so4165446plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncSvdn48KwHrQzYtexzGkXlloweM6fpLnKP3mFqE2B8=;
        b=ZAMkIey41zgYylKJDDWIsk6u0/nHXLyn+DgPQvjEzKV/STttKZSR6WL2vI8pTX61xt
         ISq0/8nLupj1xC/8EEqLrPIPMZ5hxD0lxCF5hFnZZ7/1ymgY07h2fbQknsJZ+4yvgLyL
         NSnDwsm37KvzXDaJK8fCCtODrWWedFSnH78hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncSvdn48KwHrQzYtexzGkXlloweM6fpLnKP3mFqE2B8=;
        b=Gn7+qsOYFXPzehB4T/cuWgo4jT8QnwB8qXTXsy9vkpS9J+vMxVc/4gXE2pFLtldZBN
         yQAgbfjuas9QdDfsxMgaU81Mr5/a0TcpoDkonFyrO+0g19Typmy1/z26hAmHGwdMflC0
         q2g5tMMNdAefCiHvFxMOR+y+sIQbKtKFLPlhox6TEQ5YOXsilucp9/0IH+XBiAltvmg0
         4V/GUDUhSPvqc9IkoW07OM6D8yK9vLOwEYq4zHWza7oZKfj/WOm5VgQPdRKN46hUCoZc
         11Ox5AzvvkLBIHVUc2DKqPxkKZileQ+IOQa5Wj24SOMGb1QJb9EB/P5Tjg/SprFMBrcO
         1GEg==
X-Gm-Message-State: AOAM5323QxsHWR5Fc9Ik0vAIvLNM5caIhhkflEvjeZptUPatIa2/axem
        7f6/r9FAmjxYj+9hNGdoExBhGg==
X-Google-Smtp-Source: ABdhPJzPu7aaMkSWPZA8phlPxNkUScTOuzkkNeN4thlRBsFhGmSGEigch3otJ94lot5HVvmS3MSkcg==
X-Received: by 2002:a17:90b:1bc8:: with SMTP id oa8mr11096998pjb.25.1630078781831;
        Fri, 27 Aug 2021 08:39:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm6532402pfn.134.2021.08.27.08.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:39:41 -0700 (PDT)
Date:   Fri, 27 Aug 2021 08:39:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/5] stddef: Add flexible array union helper
Message-ID: <202108270838.10695297AD@keescook>
References: <20210826050458.1540622-1-keescook@chromium.org>
 <20210826050458.1540622-1-keescook@chromium.org>
 <20210827092532.908506-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827092532.908506-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:25:32PM +0900, Vincent Mailhol wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Many places in the kernel want to use a flexible array in a union. This
> > is especially common when wanting several different typed trailing
> > flexible arrays. Since GCC and Clang don't (on the surface) allow this,
> > such structs have traditionally used combinations of zero-element arrays
> > instead. This is usually in the form:
> > 
> > struct thing {
> > 	...
> > 	struct type1 foo[0];
> > 	struct type2 bar[];
> > };
> 
> At first read, I found the description confusing (and even thought
> that there was a copy/paste issue). The subject and the first sentence
> is about "flexible arrays in a *union*". Then suddenly, the topic
> shifts to *structs*.
> 
> After reading at the code, it is clear that this work for both:
>   - unions with a flexible array.
>   - structures with different typed trailing flexible arrays.
> 
> The subject and the description could be updated to clarify that this
> macro can be used for both unions and structs.
> 
> N.B. this comment only applies to the commit message, the kerneldoc
> part is clear.

Yeah, I see now how this doesn't read well. I've rewritten this to
describe the problem better. Thanks! I will send a v3.

-Kees

> 
> > This causes problems with size checks against such zero-element arrays
> > (for example with -Warray-bounds and -Wzero-length-bounds), so they must
> > all be converted to "real" flexible arrays, avoiding warnings like this:
> > 
> > fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
> > fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
> >   209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
> >       |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
> > In file included from fs/hpfs/hpfs_fn.h:26,
> >                  from fs/hpfs/anode.c:10:
> > fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
> >   412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
> >       |                                ^~~~~~~~
> > 
> > drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
> > drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
> >   360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
> >       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
> >                  from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
> > drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
> >   231 |   u8 raw_msg[0];
> >       |      ^~~~~~~
> > 
> > Introduce DECLARE_FLEX_ARRAY() in support of flexible arrays in unions.
> 
> ... and structures.
> 
> > It is entirely possible to have a flexible array in a union:
> 
> It is entirely possible to have one or several flexible arrays in a
> structure or a union:
> 
> > it just has to
> > be in a struct. And since it cannot be alone in a struct, such a struct
> > must have at least 1 other named member but that member can be zero sized.
> > 
> > As with struct_group(), this is needed in UAPI headers as well, so
> > implement the core there, with non-UAPI wrapper.
> > 
> > Additionally update kernel-doc to understand its existence.
> > 
> > https://github.com/KSPP/linux/issues/137
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/stddef.h      | 13 +++++++++++++
> >  include/uapi/linux/stddef.h | 16 ++++++++++++++++
> >  scripts/kernel-doc          |  2 ++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > index 8b103a53b000..ca507bd5f808 100644
> > --- a/include/linux/stddef.h
> > +++ b/include/linux/stddef.h
> > @@ -84,4 +84,17 @@ enum {
> >  #define struct_group_tagged(TAG, NAME, MEMBERS...) \
> >  	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
> >  
> > +/**
> > + * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> > + *
> > + * @TYPE: The type of each flexible array element
> > + * @NAME: The name of the flexible array member
> > + *
> > + * In order to have a flexible array member in a union or alone in a
> > + * struct, it needs to be wrapped in an anonymous struct with at least 1
> > + * named member, but that member can be empty.
> > + */
> > +#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
> > +	__DECLARE_FLEX_ARRAY(TYPE, NAME)
> > +
> >  #endif
> > diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> > index 610204f7c275..3021ea25a284 100644
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -25,3 +25,19 @@
> >  		struct { MEMBERS } ATTRS; \
> >  		struct TAG { MEMBERS } ATTRS NAME; \
> >  	}
> > +
> > +/**
> > + * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> > + *
> > + * @TYPE: The type of each flexible array element
> > + * @NAME: The name of the flexible array member
> > + *
> > + * In order to have a flexible array member in a union or alone in a
> > + * struct, it needs to be wrapped in an anonymous struct with at least 1
> > + * named member, but that member can be empty.
> > + */
> > +#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> > +	struct { \
> > +		struct { } __empty_ ## NAME; \
> > +		TYPE NAME[]; \
> > +	}
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index d9715efbe0b7..65088b512d14 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1263,6 +1263,8 @@ sub dump_struct($$) {
> >  	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
> >  	# replace DECLARE_KFIFO_PTR
> >  	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
> > +	# replace DECLARE_FLEX_ARRAY
> > +	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
> >  	my $declaration = $members;
> >  
> >  	# Split nested struct/union elements as newer ones
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
