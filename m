Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCD3CED97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385822AbhGSTKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385193AbhGSSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:50:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5FC0613E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:21:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so27913164ljm.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvseTVwISQQYVhM74Otk0kHaj1gV421l1SCA3Nj6+8A=;
        b=bG065vqODgODNuvvz8mm0qHyJG6bF2CQmrIx298YPsPIfm1XQziVg1hw4cyEeNraRs
         As5mkoiZv9EFfjI3rygNALG/BoZwX1W+bpEUGC32eW7jeK+OzXHmykLB8a8dTBNQlzHs
         hWbkQvF2brbeFqyBxVGR9lMGFE15eZqGdyFsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvseTVwISQQYVhM74Otk0kHaj1gV421l1SCA3Nj6+8A=;
        b=bVeEwJFZ2NGgBtmnt07dc/d9g4R8/30/73letp30wuBv7R9JAbdkWpz4WZp907IdSa
         1ceInJUczZNOvsYs/yvm+zri/Yg0XkjCIgQpINn8e/PJRSOUv7pZHj6VyQbBQvlNM88v
         6W2Ljv+O75j/R+FkhRjDZeiqx9TPGImiMPZBcymXAF57TXUHFEMVjc7CeEmRfrRiSXRh
         L2nTsaG5h4EgLFpxRvn+oYNa/QkFbrrl37YHGQwmBnaCwZN/TWYheWesuPdl7YZKnuwu
         54wfzY/2e0RxaBfPYDvL7X0/PESf6/0D3OhffU4XAeVclGm6DYoJCdU2iyjV+d1GMijr
         9gkg==
X-Gm-Message-State: AOAM532sKWWMpWx8RfE9KjFPA0qGSUmTqqjRHHHysesYQds27I6B3ED/
        kYbmcDOYMXBEnVw27Yahj7Dn61FQr0CmShDS
X-Google-Smtp-Source: ABdhPJzBqE9YPiSjfIUuhRwebMkow/YEYsvtPD91H086nfo0KdBFCsT0a2twe7oS0mFAEtrPNc7sPQ==
X-Received: by 2002:a2e:a22b:: with SMTP id i11mr9360896ljm.57.1626722992785;
        Mon, 19 Jul 2021 12:29:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f8sm701958lfe.141.2021.07.19.12.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:29:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m16so325007lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:29:51 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr18798424lfk.40.1626722990987;
 Mon, 19 Jul 2021 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com> <20210718223932.2703330-6-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-6-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:29:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
Message-ID: <CAHk-=wh3p41a-=7FFf36sYBQP750ys6CKi0S7JNiCSatY5-7og@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] iov_iter: Introduce ITER_FLAG_FAST_ONLY flag
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 3:40 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new ITER_FLAG_FAST_ONLY flag

I think the code is fine, but I think it might be best to call this
"ITER_FLAG_NOIO" or something like that.

The "FAST_ONLY" name makes sense in the context of
"get_user_pages_fast()" where we have that "fast" naming (and the long
history too). But I don't think it makes much sense as a name in the
context of iov_iter.

                   Linus
