Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF364471F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 07:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhKGG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 01:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhKGG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 01:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636268100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJxY26/cYBZ6YUnCJ38vkDeluB/MLpmcQCfkiskEl8U=;
        b=WKGb1tspU0fD5JGzlhMTifxN3ew2ccyq/luidTxGRdlUQuRCrde4g7j+yjgKYAK/QFU7k7
        lJjjqgVPr5Bg55N1agTELvxRizZmUM7jpR2YIhit6MG3x0/Me1pFm4ZR+i4eV6KIqXgmK/
        Ib0ebZmVbOdaBKC29yjB12D6THvUGZQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-xQnrBajJNYitkYX4mZ-ipw-1; Sun, 07 Nov 2021 01:54:59 -0500
X-MC-Unique: xQnrBajJNYitkYX4mZ-ipw-1
Received: by mail-ed1-f70.google.com with SMTP id s6-20020a056402520600b003e2dea4f9b4so9276883edd.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 23:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJxY26/cYBZ6YUnCJ38vkDeluB/MLpmcQCfkiskEl8U=;
        b=FDfL3G+NaIV9MLuNiMA1rtqdX3Qs0/KRICA+Mo+v2EfCJbmDbjFu2++tkCSAXMjCT+
         JqFXR9d4rpGg7IzA/DxL8VI4XfraNG4LMXqF/SSBvL4KVFmySjIaA7Trw1i736+i1leQ
         WorhxWptoje3aRzbmn9UEsJ3ex1bCmKenyDdjguGNGgmfX4GOwhd8PFTvYlF2SlYaCbP
         aAPE0fkhgy3adUTX+olCBS2J3WECoOt4xM6nqZplSYBG7z+XfgBmIj2tYpvJUVzyGnrL
         Zv7ieEF8nK0Tooymj0Za5kUfPfZHxZrAf5EZW54AN2u4bnlpHMa7L3k/3DekGcJLbDwS
         gLCw==
X-Gm-Message-State: AOAM530aCTvWPiklzvwzyAOhnBJeM61zwcZ3PRw0C40PwW1Pc58WmSGj
        slByzPXRhzppo5WRBghUtjMMW6ngvL4S9oEY+dsdLavN5UWXDNfAt2MZr1qLbi0LPqxW7W4zuBm
        J0IUUR7h/DCkZ8F6T6OVguDd7fw8dumPjvfmJ0/zI
X-Received: by 2002:a50:fc85:: with SMTP id f5mr7946858edq.8.1636268098388;
        Sat, 06 Nov 2021 23:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3JeyTAUUv8o0kc/nibngzlpFKOPtDfmfYLQzSCyA3aUKsNaviwN7rWxMuORlT5E2rClYGMWlmOJlUubTyk38=
X-Received: by 2002:a50:fc85:: with SMTP id f5mr7946829edq.8.1636268098241;
 Sat, 06 Nov 2021 23:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com>
 <YXZU/3/YmRGFrOXK@infradead.org> <CA+YCwKn1VA8=NSa=bdhP99jfpokYGHBvqVSKvZmdndQOz6UUPA@mail.gmail.com>
 <20211102060424.GA27015@lst.de>
In-Reply-To: <20211102060424.GA27015@lst.de>
From:   Wei Fu <wefu@redhat.com>
Date:   Sun, 7 Nov 2021 14:54:47 +0800
Message-ID: <CA+YCwKk8Fa4ifaoQR=nHGXM2AHx9S8Ofow8H5dZ0bmjL49t=rw@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/2] riscv: add RISC-V Svpbmt extension supports
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, guoren@kernel.org,
        christoph.muellner@vrull.eu,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Liu Shaohua <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Great thanks for your review.

On Tue, Nov 2, 2021 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 25, 2021 at 10:49:11PM +0800, Wei Fu wrote:
> > > > +                                             >> _PAGE_PFN_SHIFT);
> > >
> > > >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> > > >  {
> > > > -     return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> > > > +     return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
> > > >  }
> > >
> > > The "(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT" expression begs
> > > for readable and well-documented helper.
> >
> > How about these:
> > #define _chg_of_pmd(pmd)  (pmd_val(pmd) & _PAGE_CHG_MASK)
> > #define _chg_of_pud(pud)  (pud_val(pud) & _PAGE_CHG_MASK)
>
> I'd use inline functions instead of macros if possible, but otherwise
> yes.

Great thanks for your suggestion,  I will change this to inline :-)


>
> > How about :
> >
> > extern unsigned long  _svpbmt_mask
> > extern unsigned long _svpbmt_mt_pma
> > extern unsigned long _svpbmt_mt_nc
> > extern unsigned long _svpbmt_mt_io
> >
> > #define _PAGE_MT_MASK              _svpbmt_mask
> > #define _PAGE_MT_PMA        _svpbmt_mt_pma
> > #define _PAGE_MT_NC          _svpbmt_mt_nc
> > #define _PAGE_MT_IO           _svpbmt_mt_io
>
> Looks much better.
Thanks , will do this way

>

