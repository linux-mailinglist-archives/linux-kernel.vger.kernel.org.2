Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE732A3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577771AbhCBJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbhCBJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:36:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D089C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:34:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so1639516wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ctpf3N3oDpgBndNDk+TSs6KZCcVMinHpJA2vMeVtE58=;
        b=V4uX6k9BjgbdmpKHpeIwCRyKWJP9FJkuGFdl2giwGThVoCtDooBgYlVL3qWwRoBHDE
         tipyIHpWQ5+EvZ3rVxgSHK33tT3CIP+OKSXGeobFuCG3vbYLKAn0vHJWu78sIx91d2xo
         VOHdn51DfTBNSDumgRnpTdT6yDBtbsSu5lVgHPOF16FXPhCGnkrpejhDF2KGL8P9LBhZ
         SsNj8Wdx9xJa16XW4qGIRhW0OzV4riXECS+vJzFsNVu+mGlEN8o7e2qLZ8Cyi0P2lT4w
         psGRVa+5gJ/aRLTDDijjmexGXGyLKAhSN710s/QV3vdyYBDEHCd85JP2UTBT8yoGcxBO
         ifbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ctpf3N3oDpgBndNDk+TSs6KZCcVMinHpJA2vMeVtE58=;
        b=L9oozO1NkdAX8Ls7lzo+y2z3WplhlcDv2smyN1ES1EjBf6t6CZl5CYqiQhQ388c/Cu
         lIVtq4K9xOg17cIkySDKwRlM60p2b80ztZJOelz1ij0MdUR86K93slEHDAhyTbZ7FI6t
         L+tjpi15qMnrsJApl7paxwNUQ5u9xSXk+U7uZxkXu+YkvRF/nVj7Grao+x1rjkHDuZqS
         a1KPeZ7BQsouxVBUR/L+ZOrqeRIOJO7II1lJtaODR3boE9zop+SqQ0vTbmK9RRhhBvnO
         RtjoYVVHbT71rvAjoGJr5eGcoY46UuELwXHCEW3NtIzkMt2/biUf1/lAV/NE/CD9AO6Q
         wO0A==
X-Gm-Message-State: AOAM533HIhYrOwE0aymOBIzHBoAsnqiFzEonuyjUx+9UVVcwlfkiIpoG
        kGAkinWuy5BD0p6YTc/0wklmiM1cIjIFIg==
X-Google-Smtp-Source: ABdhPJyATDWSry1taZeeauVnwgBhue9XbxxBGNdOcknqPfLRhpgZd/ieHnl3Df7VmUekUbw7YzV00g==
X-Received: by 2002:a1c:4382:: with SMTP id q124mr3160464wma.16.1614677693881;
        Tue, 02 Mar 2021 01:34:53 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id v1sm1900693wmj.31.2021.03.02.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:34:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:34:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: gateworks-gsc: Constify static struct
 attribute_group
Message-ID: <20210302093451.GC2690909@dell>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
 <20210131133644.8834-2-rikard.falkeborn@gmail.com>
 <20210301095645.GG641347@dell>
 <YD1Ymbdxv0GCZchQ@rikard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YD1Ymbdxv0GCZchQ@rikard>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Rikard Falkeborn wrote:

> On Mon, Mar 01, 2021 at 09:56:45AM +0000, Lee Jones wrote:
> > On Sun, 31 Jan 2021, Rikard Falkeborn wrote:
> > 
> > > The only usage of attr_group is to pass its address to
> > > sysfs_create_group() and sysfs_remove_group(), both which takes pointers
> > > to const attribute_group structs. Make it const to allow the compiler to
> > > put it in read-only memory.
> > > 
> > > Done with the help of coccinelle.
> > > 
> > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > ---
> > >  drivers/mfd/gateworks-gsc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > These patches do not seem to be on LKML.
> > 
> > Do you know if they were rejected for some reason?
> > 
> 
> I did not recieve any bounce or rejection emails. I have a vague memory
> that I saw someone mentioning in another mail that there was some
> problems with LKML and that patches were lost, but I can't find it now,
> and I'm not sure if it was around the same time as these patches were
> sent.
> 
> Should I resend the series?

Please submit a [RESEND].

If it fails again, I'll apply the patches manually.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
