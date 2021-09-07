Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43629402F90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbhIGUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIGUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:23:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B781C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:22:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 18so70430pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CxCMEYyqxYhUep/PGhniz/NR1HyvaMZkXLfT9plZYY=;
        b=TI81/bTYUPnQjLNMtHShEh+7mJSp/liZIO4XsBqWUYEDxe/b8aFoqbmN28zw9n+RSB
         nR9oPZJ/96tfNDl7Te1YSlpy0vEjsWuoEdwkzA9/ytL5Ups9l50xT32EmUVLgDxI9Lqx
         tvHfvWtu4gtrGYVjrQ556bKoCSKYIfycivnYRlt6c+W5LWJa8BvXASZJSLB81MTidMFN
         6xU/5pq21yhDhtf9WfPlhK0Bd+7rLO5+RUzA+ege7tc6ODWdqmTiMh7SmiLIH6uEqSNj
         N8fnPHxyt0XJn/m11J/+GpfoVDFVYvcudZCOsAK6FxK6P0ie8Bm5C4QMHoerIcceKjIB
         egjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CxCMEYyqxYhUep/PGhniz/NR1HyvaMZkXLfT9plZYY=;
        b=GP/0irTFrHwn7auGq9IWVeFMEcuILQ/Xa+QjhSkc0DNLktkreOtcLrHhP+fBb3aME8
         3UZW8rUcTg4FuIHf9ngAQpwIBEN/yxx1CS9LSdEHK2UA/EMdTPjbjACpujppCb9Dgez3
         Oh9agWLBDfMXf7rcNiV1U70WQf3RX6j0flP9KJbL/shPRP9Uzdkf2d0MP9lnD6/LhUQD
         m1EdA2enTf+lXYANhatYsbm3MXJFPjqf3CkZ6VGR7hzBaYWgsn3q3xxsHYDLZh+y5zBr
         WwhHxQ6IBENMQchhX1WQyf0LIr/3tYq7sVWP8fgJBM0VQ2SbeSLymhSThmltBnuCvsqX
         Ilcw==
X-Gm-Message-State: AOAM533T722c7GnhY1ms5oNr2yPDze3dy3Wxfq2h7CZ8UWCNq7x2NqxU
        TWAsWcjYuScpizBLw+Z5ezI=
X-Google-Smtp-Source: ABdhPJyXV0VNZLiosob3oHA48HQekHvxqf5RKSonLNk7niuQU/3c6oMimgnjZEV8tVf/8bEiIRgb+w==
X-Received: by 2002:a63:b147:: with SMTP id g7mr125530pgp.478.1631046143779;
        Tue, 07 Sep 2021 13:22:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:3584])
        by smtp.gmail.com with ESMTPSA id d5sm11944406pfd.142.2021.09.07.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 13:22:23 -0700 (PDT)
Date:   Tue, 7 Sep 2021 13:22:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: Re: [patch V2 05/20] x86/extable: Rework the exception table
 mechanics
Message-ID: <20210907202220.bwhjfdipdqndkm5s@ast-mbp.dhcp.thefacebook.com>
References: <20210907195004.046859074@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907195004.046859074@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 09:56:20PM +0200, Thomas Gleixner wrote:
> The exception table entries contain the instruction address, the fixup
> address and the handler address. All addresses are relative. Storing the
> handler address has a few downsides:
> 
>  1) Most handlers need to be exported
>  
>  2) Handlers can be defined everywhere and there is no overview about the
>     handler types
> 
>  3) MCE needs to check the handler type to decide whether an in kernel #MC
>     can be recovered. The functionality of the handler itself is not in any
>     way special, but for these checks there need to be separate functions
>     which in the worst case have to be exported.
> 
>     Some of these 'recoverable' exception fixups are pretty obscure and
>     just reuse some other handler to spare code. That obfuscates e.g. the
>     #MC safe copy functions. Cleaning that up would require more handlers
>     and exports
> 
> Rework the exception fixup mechanics by storing a fixup type number instead
> of the handler address and invoke the proper handler for each fixup
> type. Also teach the extable sort to leave the type field alone.
> 
> This makes most handlers static except for special cases like the MCE
> MSR fixup and the BPF fixup. This allows to add more types for cleaning up
> the obscure places without adding more handler code and exports.
> 
> There is a marginal code size reduction for a production config and it
> removes _eight_ exported symbols.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

bpf bits look good to me.
Acked-by: Alexei Starovoitov <ast@kernel.org>
