Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1CE3D4ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhGYQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhGYQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:10:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F7C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 09:50:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y34so10949043lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fP46kBmK7l501R1YlgJJGYbTTZbaO0NIkZ1qjp4LZ60=;
        b=SiPYq8BshaNp69OC9ySKBMA2IxqQDhtF/RXGRJeUBiB8DO+97ZjH9oULVf8h+kDJ6h
         oaGed8aMkjAmd/1pTV6PwGJCgRW9UXlaM0hnG7LTstlJtHaNNt3V0jnUtuVJ06mA7Ymg
         o803uHXDNoUWnPu1b+ZyfKPugux0T5/RT5H48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP46kBmK7l501R1YlgJJGYbTTZbaO0NIkZ1qjp4LZ60=;
        b=ckP44QKNFNDTTclp/zeZPsRs8LiegJb5+uxWNfIAmdnSXxkg8gqgyAd1zOmn6bmDkR
         Df0aOkSh8hR+JD7qT9OTKjKsOmvptOq32fkD9KfRB0oB3vasuG3l0xaPToVFLJckNTie
         52qZp06hf7p0cMdO/VAKl3fxbFcZ61yt0Lks/0MJaSBEi+Nj3FX9G3rdTp2Zn1OYe+eG
         hk7L3CrJnp0ik6JK3gHjk/Duq51blUteYZ3PLtMk5c/w5qD5BJp7HLNxUBIy3jC/vEWL
         P8c6BNlatj3xf/O5zDZRmd/y62AvlolrD8uXx4i1l2xVG3dPLV8Mh5gl/4+Db9/m1fbi
         dXtA==
X-Gm-Message-State: AOAM532CWlbw3Zfh42ptTBBl4aC87ZiorFQNswtEEXhKFaSKO+A2vAio
        rtv2N6t0SFKN5onN1WinLbhJKt0jDPOIzzxc
X-Google-Smtp-Source: ABdhPJxkm3pvLNhUVWmM2v3O95ZRSZKsCZWnO8BUwFSD/c7qyI7PVGI2ABzunEsN5Sns27p4O7q72w==
X-Received: by 2002:a05:6512:54e:: with SMTP id h14mr10112641lfl.511.1627231846307;
        Sun, 25 Jul 2021 09:50:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z28sm3042032lfu.230.2021.07.25.09.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 09:50:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id r23so5083187lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 09:50:45 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr9389230ljj.411.1627231845716;
 Sun, 25 Jul 2021 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <YPz+qQ6dbZVDbMwu@infradead.org>
In-Reply-To: <YPz+qQ6dbZVDbMwu@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jul 2021 09:50:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
Message-ID: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> dma-mapping fix for Lonux 5.14

We're calling it "Lonux" now?

>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
>     (Roman Skakun)

I've pulled this, but my reaction is that we've tried to avoid this in
the past. Why is Xen using vmalloc'ed addresses and passing those in
to the dma mapping routines?

It *smells* to me like a Xen-swiotlb bug, and it would have been
better to try to fix it there. Was that just too painful?

                  Lonus
