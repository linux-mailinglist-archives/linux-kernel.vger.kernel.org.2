Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070A13F48A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhHWK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbhHWK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:28:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C3C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:27:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so8446828pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1SJ1j2u1zvDC10cTU9j4nGc60DJc7SjggYjuomF1P4=;
        b=fe73TA8282cYRCk0e+Pfu/M0nN0GMD/jwNgJv416OP2s8C74tb5+Wy5PqTnxtJp1ug
         QC4jaAArkJ+KNc6VH30DDBUAKxKp2vRyNCUVKpf/cAf0U5V+iR38nhfia5xwZtDGRTEb
         m8naQt0HYR9yqeTWdMDvRozmxA+y+w8IrNwBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1SJ1j2u1zvDC10cTU9j4nGc60DJc7SjggYjuomF1P4=;
        b=bcKcU1UvI2lsvdJspvyXIJZGJrcAFw6XmWIycOMoZ6Wb32jnOg59smUopUtbCLpGi4
         muY8slMxEgkbROYqFw4vQFyrA09i2RF0i0NIiP9QsIXa7vycdu4Uy2s8jjP1fUSUszyg
         hUJrO/V3yQb0F9iPLiSD91Iff+wH7wv23CN+17CHNhLr0NytDC5r6EOE6007JKb/8/Yu
         ibJQzInXm6aEHqWnwL3jH3hSyx1Cr9oDpBniETen1VvLo8kjx0OA5YFYCETSrxxY/w3U
         7Sg5gnaXyNUsMAO3ZYpCI20CHcALC78dIGmPiBkRuBx4uzlXigz5rxZ6L3reCj9OKqHP
         +51A==
X-Gm-Message-State: AOAM532KqDuC4Xi9mYSCNvaAAQEJanibLnR9elgNnLiXrg4yYi18jXLt
        /7DtY8/mEx3AstE3AEsl2Kq+OA==
X-Google-Smtp-Source: ABdhPJwGot65ffHC35kFdykEdYNu4KrX9pN0ji5TehtyrAktvb3VwfUnZWUSeP+H3orX70FaNQ72Sg==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr19593581pjr.213.1629714477648;
        Mon, 23 Aug 2021 03:27:57 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8821:8b2f:2912:f9e4])
        by smtp.gmail.com with ESMTPSA id s5sm18777794pgp.81.2021.08.23.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:27:57 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:27:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YSN4JhGObeaY7Sae@google.com>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
 <20210727070517.443167-9-senozhatsky@chromium.org>
 <7e172194-9519-fd1f-6261-c40108a5d722@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e172194-9519-fd1f-6261-c40108a5d722@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 10:33), Hans Verkuil wrote:
> >  	struct dma_buf_attachment	*db_attach;
> >  
> >  	struct vb2_buffer		*vb;
> > +	bool				coherent_mem;
> 
> I think that this as well should be renamed to non_coherent_mem.
> 

Done.
