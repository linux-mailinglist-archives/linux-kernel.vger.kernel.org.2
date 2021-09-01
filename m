Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D83FDD48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbhIANZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhIANZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:25:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 06:24:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq28so6363741lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QemmkFCPO2XG2CVrKSAGiBckmZ349ANW8qbai2Np90w=;
        b=SZpMER4hKSqMQ6aYsX4MQM1Rgw6YufSMtrsBxKsTySz+4wTNo2lCSC5JOMo58bZTRp
         3W4Pb3FBCVeiYGO3d7sDNnx2Kksvt75iN9CEmMmlqGJbiJ1hU2VwTXM8aHTF1nsBfWZ9
         nqE9AOkDO2lMurOBG9Mi5sEPM7ZsSnwZ60hBzCYIA7iVKJNcEm2W/KFPv3Zr2zRRUoXO
         1YvmMb4yF5VCnQqdKG++EYAGc3JokgF9akCL37M9zWpj2IPZ+1uE4mTLpCy30LRARbnY
         JuXkq54GdvFr2kz2jUl40SDgBjq+w26SpRpzp6mjG14MI2eXBVTvCWzfXe1HzypUpcKv
         KnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QemmkFCPO2XG2CVrKSAGiBckmZ349ANW8qbai2Np90w=;
        b=AQ13GXsYVxD8CEOBt5XycgyIvHre0XKJOyRK+dwleAs8lRMiEJ1MmGjyprkVPQjz0V
         zGpAUpAboUDoZIm5IU/B7VswZYYXNGa21aCmMRA22IEJWA3FKgg4XITZ0f4N9j7G9lZv
         3/t1AcA/QJA2GoZw+iso/cmW+j7ZNLwsLDx28QTjZFI5t1Uz3HB1cH9KomIUvRiA8/Wm
         8egevOgN+vXx2tWdbCvdYztJgoCViNsIb0RHNbZHs/Dak3Qv1hgFFyk4d+PAS2Mse957
         SOEyOHcKqBsu9cDZno/+Y9bu3Mo5ZXYFKisurcIbbU4nUksnRqFrUxjIe2lDxawdbAi8
         c0Uw==
X-Gm-Message-State: AOAM533TG2c5sL/0YI6GOfsW09gbZ6OduDU+5VzEv8Xvnn3fXjHegUZo
        0WehvuVfma2a3iAYKPfeEy5LLbOTWz4=
X-Google-Smtp-Source: ABdhPJw8kxMfoCdm6f55Xe/Dr9DRmQLIbBhJiWXx91a/912clcMF5Q/aJkx6UVdYSC3BAojmGlHq/Q==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr2877227lfv.409.1630502690740;
        Wed, 01 Sep 2021 06:24:50 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id x74sm312309lff.179.2021.09.01.06.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:24:50 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:24:48 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs/ntfs3: Use kmalloc_array over kmalloc with
 multiply
Message-ID: <20210901132448.mgkkyvqszc7lsnwy@kari-VirtualBox>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
 <20210831181505.1074767-2-kari.argillander@gmail.com>
 <5197939870d1867dd2131a8fdff8842b777c6016.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5197939870d1867dd2131a8fdff8842b777c6016.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 07:40:58PM -0700, Joe Perches wrote:
> On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> > If we do not use kmalloc_array we get checkpatch warning. It is also
> > little safer if something goes wrong with coding.
> []
> > diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> []
> > @@ -707,7 +707,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
> >  		u16 *ptr;
> >  		int new_slots = ALIGN(2 * nslots, 8);
> >  
> > 
> > -		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);
> > +		ptr = kmalloc_array(new_slots, sizeof(u16), GFP_NOFS);
> >  		if (ptr)
> >  			memcpy(ptr, offs, sizeof(u16) * max_idx);
> 
> This multiplication could also overflow.
> 
> Maybe use krealloc?

Seems to fit lot better here. But as I was watching this it seems that
we do not even need to resize this array. It is quite costly operation
compared to what entry compare cost.

We just need to compare it and if entry diff > 0 then we start entry
table again from zero without need resize array. It may be that we do
not even need to allocate memory. We can probably survive with stack,
but let's think that later.

This can also speed up search a lot. It is quite odd that we always fill
whole table and will not never check if we are over. Worst case is very
very bad. With this change this will be more like jump search but I
think it will be good in this case because we won't need memory allocation.

Thanks Joe.

