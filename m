Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243BA3C9D78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbhGOLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbhGOLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:10:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFBC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:07:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d2so7305016wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jdYwECk9furkh7KTSGCqufIb1FYGTuZUpaNXiuZiY34=;
        b=kiHiErv9a3uauPXHpRI8CSrnoJdVyXl1oedxILs0eaAn0EpMPztBinOM08zsmzNpIm
         lo+w4jaz1ywCEGo6M88nrJtK+neap6d8xwmtxbelLX3qHVRKUwNgBBv4xfDuTpHPjjPV
         aG/KPw+tmx0C0GLIUosSKkzhx211f+mK9ZEi390ZjhooPPGKY1xdE9RQQaOL6U8Ut/f0
         3EBG/M28s5IyD+Puh2gTZQX3JBONLXJc6jYGVRs40a/HPxXM2q3qwIx/yvpSnR7vMeyK
         WSWnfTXyjyXRXk1lDV7Q8WIYYnZdeaxxIWZjVxi4XYUbdRrZ9j4O/AZvu8ZnbHczaVkN
         HP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jdYwECk9furkh7KTSGCqufIb1FYGTuZUpaNXiuZiY34=;
        b=jIrtG8ilSTv90gDNIvpxH9vYyFJN7pAp6RjMUi6qG+7i7S81Fv+FWm35MYWnIo+jX1
         XN2pxvsK5Bv9LvWF3bSGocWdSpq8YiXxv4nc5IiwZ/8dkGHk/uJyqBs3lso/0ACTbZEZ
         lJ30ce3TwIEpxNx8N5u8za31Rx176kc76i5yKgAJnhFBvL34IrY6M88pkEVtjtcL1c3A
         j44Q10xtTMr7FkzihZclmNRfbBFVEDpFGwRS4BEHklRkowK0lDa6g1N9GbYKdMoqIVtE
         LVA2irWcj+crJJ/S5BPvGJQi0Tdu0jwglDQxh/oT+KC2B8DbAsk5T19Rk53yAEXGTFva
         ksmg==
X-Gm-Message-State: AOAM532b/tVHEqBQjvTY7rov+0O4uLfRzUCdDHvOb2H2zJgH8urCF3my
        o9VFVYkQyhhCOEAUz3U+YnUZTQ==
X-Google-Smtp-Source: ABdhPJwPOnYA05PxM9Ze6qn2v3mYFlXBEvHSAoHc82BK2drzF1umfX5qFL53y4rzX8C8pSyZxQ1OgQ==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr4614409wrw.27.1626347226995;
        Thu, 15 Jul 2021 04:07:06 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id z11sm5969559wru.65.2021.07.15.04.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 04:07:06 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:07:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] dt-bindings: mfd: syscon: add Rockchip
 RK3036/RK3228 qos compatibles
Message-ID: <YPAW2FglO/4Lhs+i@google.com>
References: <20210525152225.154302-1-knaerzche@gmail.com>
 <20210527154455.358869-2-knaerzche@gmail.com>
 <20210601154651.GE2159518@dell>
 <3527273.z0yIoBN5P9@diego>
 <78b492b8-55c4-dfbd-cda6-f78c4b8557b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78b492b8-55c4-dfbd-cda6-f78c4b8557b0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021, Alex Bee wrote:

> Hi Lee, Heiko,
> 
> Am 11.07.21 um 13:55 schrieb Heiko Stübner:
> > Hi Lee,
> > 
> > Am Dienstag, 1. Juni 2021, 17:46:51 CEST schrieb Lee Jones:
> > > On Thu, 27 May 2021, Alex Bee wrote:
> > > 
> > > > Document Rockchip RK3036/RK3228 qos compatibles
> > > > 
> > > > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > > 
> > > >   Changes in v2:
> > > >   - collect Reviewed tag
> > > > 
> > > >   Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > Applied, thanks.
> > not sure if I'm missing something, but this patch wasn't part of your 5.14?
> > And I also don't see it in your for-mfd-next branch. Did it get lost somewhere?

Hmm... looks like it was dropped some how.  Apologies for that.

> I can't find this patch in neihter the mentioned trees nor in 5.14-rc1.
> 
> Lee, could you queue it for rc2, please?

Unfortunately, that's not how it works.

Only bug fixes are allowed for inclusion into the rcs.

I'll re-queue for v5.15 though.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
