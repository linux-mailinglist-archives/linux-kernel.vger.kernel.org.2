Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48B3B93D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhGAP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhGAP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:26:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522AC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 08:23:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n25so8968302edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U8l3UJ00DYREIgfMYEIV38usOd6cfglDWNE3/CPQAi4=;
        b=lKxu0Alt2UFIJsZh1Hp+rwuwy0C7TLdSxNL3e+ysOhnJQTzv3Kxxa2IvQD+NRerLcy
         eUdr/lqrX5Q+cp6mxy/QaHorDRQWa2+LUq8TtaJkSZY1W4s2anXdhQsVX6RH0qwU2/ow
         qES/RgK+RMPQXzHMCcDsTLAREk+/bK0hw6uFuxExhtUL0EIar+7OIgDANIO5zfL5YlUZ
         jQIZBweYuT/j/NQnGMkRUj0Zb6/8Ir7U1vk+QwH4BoK9ccLKaT/S2c8ri6jTuLCsNNRW
         bMVN9BJB6X3OjIuDN4I4kNF4Vz8FEUFIP6xiKvmYZ8crkHgPYEj9YHmAN9GiYHvbcnVm
         94Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8l3UJ00DYREIgfMYEIV38usOd6cfglDWNE3/CPQAi4=;
        b=Gb0YrOxOZS5ZaZw8injUDcpKj9YmttVWRZCthJUHmZa0g++SiXX0rSLUEUl4ZOUGNX
         vvWSSLSAFYTeOEoOPtAdvEJPUvqqY9HyY5N+OeWMM6/b/SbuRknoPefHrtVo0ntLcFc0
         htCEtHeEpwOreHY99ezp4ZRoGiSkdhNLZTchFQnM0HkZxRtnU301/lVVT9TJFPY+1NdR
         of7NFMxVGO2NA2UyFMgnc5D7FDGnFeJvNpMC8ltaOtbUYipuxy4MmKBD0WHTXUMuYm6A
         cMKXrPveBr+B+wot5OYZhF2q+cJejIn2peyupvh2gmbWfOFs3/q1EvLFiL7tn2lvVFYg
         kCnA==
X-Gm-Message-State: AOAM530UOJhUa+5qKMN8ylrYsEJ7WMcIcXRC3XQzncq8l/8yMYv+jTpQ
        DdITA9IjigaBmgHudQys9dg=
X-Google-Smtp-Source: ABdhPJzgXTm35YtDnk1Us2icqpU2MUxp1PmvFuU7uKJ7/8zaPGmt8LzprGFzmnj6oVyaXTMctrSWZw==
X-Received: by 2002:a05:6402:4408:: with SMTP id y8mr487282eda.55.1625153020035;
        Thu, 01 Jul 2021 08:23:40 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.pool80181.interbusiness.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id x2sm80342edv.61.2021.07.01.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 08:23:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Thu, 01 Jul 2021 17:23:38 +0200
Message-ID: <2058378.BL2Rai63ie@linux.local>
In-Reply-To: <2fac9d8813374e95bcc04134a0f40f45@AcuMS.aculab.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com> <2fac9d8813374e95bcc04134a0f40f45@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 1, 2021 4:52:08 PM CEST David Laight wrote:
> From: Fabio M. De Francesco
> 
> > Sent: 01 July 2021 14:38
> > 
> > Use crc32_le in place of the custom getcrc32. This change makes GCC
> > to warn about incorrect castings to the restricted type __le32, but
> > they can be safely ignored because crc32_le calculates bitwise
> > little-endian Ethernet AUTODIN II CRC32.
> 
> ...
> 
> > -					*((__le32 *)crc) = 
getcrc32(payload, length);/* modified by Amy*/
> > +					*((__le32 *)crc) = 
~crc32_le(~0, payload, length);
> 
> Haven't we been round this before?
>
No, I don't think so. At least, not you and I.

Unfortunately, I don't get paid to read every conversation sent to the Linux 
related mailing lists.

However, since you pointed out that somewhere, in an unspecified time, this 
topic had already been discussed I've just found an email of yours: https://
lore.kernel.org/lkml/bdc0c31a7d28426995d229eb9014cd2b@AcuMS.aculab.com/

I think that there you are talking of something else.

Perhaps, in the same thread there's an email from Al Viro that seems to be 
more pertinent: https://lore.kernel.org/lkml/YMz0DH0+v39xsCYU@zeniv-ca.linux.org.uk/

In particular, Al Viro writes "[...] Either make crc __le32 (and turn 
assignment into crc = cpu_to_le32(...)), or
make that *(__le32 *)crc = ...".

> You need to get rid of these crappy casts.

So, what am I missing?

Thanks,

Fabio
>
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 
1PT, UK
> Registration No: 1397386 (Wales)




