Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F107C3592A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhDIDKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhDIDKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:10:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB56C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:10:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g15so3304176pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iY6PDGzEpDlFZ5JABIVINiXcyV7OXe1c5LxQqA7OAHw=;
        b=IzYYpV9dHKjHQvb/c/mppIoj7Wg5xm7bLRt5obXAc+hZaC1pBsAxOJPEg74gi23Ere
         4oLU87qukCBDi4mkJIl37V6ct2ZcoP29U53r7Wj7kVecXnl/p/TLfQIIaqdYxMM59c/m
         kP5t4PhTjmHoMViKVliKCsYwTPPD01EjTYGOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iY6PDGzEpDlFZ5JABIVINiXcyV7OXe1c5LxQqA7OAHw=;
        b=skNAStcnzMWU5/0EawfDhZ4vE03DGYImR8lhhU+4Jkp4EZlxxPWaWzJ0x7dN+xqr7n
         P+NsSXlowywRrpDIsHvBMO5Kbjh5tXld4/Nb4/wUhbTJC8GFICdOGGSW/H1gSABV5jP7
         t2moMArCixP+zA6nskj/OlyE3n6nBGrjjLgHxDkEGDEd6cqseqhopsm1yM9K81zSNPDs
         vx096zq1Ts2511dlEHk4Eh166ElyXHOvHIdb2n/hdtPPViPkj6P7xY3mQ89bRwROfv23
         e3QXsFfo5CtLJwd3+OgZNa0lQPFxAizR3cNu4OH8i2qK+6dfOYMvVO1VY6sT4JkyE4xP
         htnA==
X-Gm-Message-State: AOAM5311UM9vB3hiFbgfxiCItdnBuil2XQn2I51PpxZNIl/miHgRHtz4
        oHy1jpTdBNOaWiMpj2aXtMRihw==
X-Google-Smtp-Source: ABdhPJx/DSDGdnbMIOkt4rPA2fB7bv1H2RrcmVv5V6WEDPg0VVHm/QRB/6pSWedUGA/ZcEljLEdHTA==
X-Received: by 2002:aa7:8498:0:b029:1f6:8a25:7ade with SMTP id u24-20020aa784980000b02901f68a257ademr10530825pfn.76.1617937810322;
        Thu, 08 Apr 2021 20:10:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm632353pjz.46.2021.04.08.20.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:10:09 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:10:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 12/20] kbuild: m68k: use common install script
Message-ID: <202104082010.0DE93225@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-13-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-13-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:11AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for m68k, all that
> is needed is to add it to the list of arches that do not put the version
> number in the installed file name.
> 
> With that we can remove the m68k-only version of the install script.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
