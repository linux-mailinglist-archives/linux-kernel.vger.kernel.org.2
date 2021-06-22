Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60923B0C96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhFVSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhFVSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:11:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7AC0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u11so20456975ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqKyH/P85UNiqEHVhnOTWzjeuNjUUBapCv+LJwl/SMM=;
        b=Pc4u8ARWhKyeoTp1QuUkXBYBsNhLhb50XcDTJAb7BeD9eYAsVHsqvKwGuLk7Y7WXFh
         sGUzQo5XOG6b7IDfEgtSX4i/xqSSe/y0aDwXDka1ZbLzPxspVFyZB3D6fQnjL8/sEFzR
         UsXtmOmXBwWLZpOf2Kui9wetdxlAxOLjK9fnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqKyH/P85UNiqEHVhnOTWzjeuNjUUBapCv+LJwl/SMM=;
        b=PO4JhgrBW0bUVIibjBtLz46o+n8ePa4+E8wXDcMa0w/SLpRKD0w1ClbzRXZLVTx7dH
         UneOT+O9/pbTVEWI1965qNo04JcAFo5lJmD8yZtafgW+KeEhYNCw5ByYpCL3LqDNqfw1
         sF+hmjxyjfNA8v/RwFakAliwLLhzxXcgjkfRTzbjtTB8JF/dxVQoMvoDz7dyl7F0iKMM
         YrlnZjEF0+zN+CDct61xqy8b8pJpMTdbf21FJ6iZTIx0cpj7RFYdmGfRFMpqXz7YwDLi
         UJXE3Lrs5SAW3dhE66UWGiabJ7fDsbc1INOW2KH/7WvkP8M586fVNrHtGNlB0uXyeHn3
         ZJ1w==
X-Gm-Message-State: AOAM5338SS5W4svEAf4ckKRrXIGkD58OzGSRdfo7Iw740wXF+/yt6di4
        L4pKOAnDTUs6d3dro0KmkHVNT9HQUFIYXj26dms=
X-Google-Smtp-Source: ABdhPJxPMDRIdmYFMFo7c2dsNAaqBj3XIFT2dm6scinVA2b710PC5+ckrRfpk9hTkv+/exA30bYgsA==
X-Received: by 2002:a05:651c:169b:: with SMTP id bd27mr4248688ljb.219.1624385294539;
        Tue, 22 Jun 2021 11:08:14 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bn23sm9430ljb.48.2021.06.22.11.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:08:13 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k10so4323818lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:12 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3746251lfc.201.1624385292112;
 Tue, 22 Jun 2021 11:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
In-Reply-To: <YNImEkqizzuStW72@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:07:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Message-ID: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Huh?  Last I checked, the fault_in_readable actually read a byte from
> the page.  It has to wait for the read to complete before that can
> happen.

Yeah, we don't have any kind of async fault-in model.

I'm not sure how that would even look. I don't think it would
necessarily be *impossible* (special marker in the exception table to
let the fault code know that this is a "prepare" fault), but it would
be pretty challenging.

            Linus
