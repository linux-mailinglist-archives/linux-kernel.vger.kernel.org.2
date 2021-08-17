Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E343EF646
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhHQXoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhHQXog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:44:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03405C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:44:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k5so603044lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3j1SnTSxict+VDmN2SRVNw1Xmv8Hy4JvKVdqBN6uBo0=;
        b=NG/jghkhJpEgwnQnkzgt2yuwB0qhJAlty1tnJa43RXFyyWV/fz5OM0UCdl4jhIoqRi
         pIGlFhUzAJbgBulWMyizhKq9uWBPwO1h7lTLuniEn9E9Q+b022fUbglKje23Px42xSQW
         R86Hc5ReE7lIW+mS4zNadBuPGU7Ruiy/ZRSCjtr7knp7mnAcJRu/Wb7TzUNvdb8d/qpg
         J+TgfI6FZ1+6bKVyaDrcD3bDPozRKcHH6PMMDviqNb8YaMIsC1LebNevAQRylqnfh1Tt
         KyuJK3b2TsUSTtLonzp39heEBRicTvtd41calPboJVvsgSNtfyqSeQolnCsLvPC06gYe
         xL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3j1SnTSxict+VDmN2SRVNw1Xmv8Hy4JvKVdqBN6uBo0=;
        b=fgDg/YJ01MRQTJwCsIg4pid4HVCg3ZvOSXhGltvDlyS2sb5NK3XK0PZuCMElpV/Wwa
         2VqaXf4io/au79JMLS44lbVP3/9faL6XmHXos1OiL8zuyXC02w2Lie9rStqcOo7clQMk
         j4F1f7XZ1mspMlf31OQOTWrhw1pHaNdQ6uy8ygTwWAKE7M0Sbo4frl0kg9fJ64G7NB1k
         MdH/EAasKa18JngFhuu6vbDk91tktQdF+SnlpBCXmdnpE/jov2wmNHzUVHDt1EDCD7Lt
         qu9KS3oN592qrBVMgEaIc4OmahkWxrtyUdlRfW8fAxD0l/0XqXyhlPCmWfhzvPKQN2HI
         hkdg==
X-Gm-Message-State: AOAM530sfDGuvyUwnJ/sQfAG7v/qAqUO2FOyONLzthljjb2ytAfSTS2p
        YqEOlSXm8XNmBfF9QWkEkx0=
X-Google-Smtp-Source: ABdhPJzF9HskUlBrPFo2TedVAHjtnq6nbs2ZCjdrt6HoohJpRNdVNWhzMqfEi4URBvgvu4rEzAPNCg==
X-Received: by 2002:a05:6512:3b3:: with SMTP id v19mr4263954lfp.10.1629243841303;
        Tue, 17 Aug 2021 16:44:01 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z10sm321574lfg.271.2021.08.17.16.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 16:44:00 -0700 (PDT)
Date:   Wed, 18 Aug 2021 02:43:59 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Use kcalloc/kmalloc_array over
 kzalloc/kmalloc
Message-ID: <20210817234359.o3cotsqpy2cg67pu@kari-VirtualBox>
References: <20210817193815.307182-1-kari.argillander@gmail.com>
 <20210817193815.307182-4-kari.argillander@gmail.com>
 <ef1d002a0720ace0ed8dd79c2ac3c600@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1d002a0720ace0ed8dd79c2ac3c600@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:12:08PM -0700, Joe Perches wrote:
> On 2021-08-17 12:38, Kari Argillander wrote:
> > Use kcalloc/kmalloc_array over kzalloc/kmalloc when we allocate array.
> > Checkpatch found these after we did not use our own defined allocation
> > wrappers.
> []
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> []
> > @@ -900,7 +900,7 @@ static ssize_t ntfs_compress_write(struct kiocb
> > *iocb, struct iov_iter *from)
> >  		return -EOPNOTSUPP;
> >  	}
> > 
> > -	pages = kmalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
> > +	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);
> 
> This is not an exact transformation.
> This allocates zeroed memory.
> Use kmalloc_array here instead.

Yeah. Thank you so much. I actually use kmalloc_array, but mistakes were
made and this was result. Thank you for reviewing.

