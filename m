Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D852402CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhIGQ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhIGQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:26:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2393C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:25:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l18so17437478lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tg0EHKkItjWDiEA+fsZ1a2tx5JVSC+kcRVqQGEHCSHA=;
        b=j/bw1IZaL0/LtUVfO364susiJxdEyFn4BQ2MkKinL+gubHKsIQTF8Yp1iCaSWK5xrv
         vjp+mjTy7Ph+Bf/klgDHvUE8Mdrz80RNnpzhTWQOXB7Gwtr/GckvNwIQTpWcoHevFHUw
         wSmIEp0fuCo1jL92GszSd4ydlUkFov2EsJjsV92bomUw0LRHxicPWrcu+nrGIh3lunGL
         LxA+rwZuDaCYBTkRyhSYproUKZvUuaiIXpMyvmd/mBptanvn05wFM826WZwX9pj7ZQQa
         V1p07gWh6orm+/m7kyA33xKh6OsNilvWPcY/yY9D6UZHswyFtV2ER+pvai8fpS2/pyva
         906A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tg0EHKkItjWDiEA+fsZ1a2tx5JVSC+kcRVqQGEHCSHA=;
        b=bT3ArUUwgNN0EEdZl3w1JPXeKiBYKHHWGBS9ZBQ6e2nkloYqZP8Haq/biPsjKoAxBl
         Dxy4ESsCZ3AvgObIY+LEj0HrKmV3hblX9GoRDY55P9Vbi5z1YvS7A5ZtYqBHhFpsBJe/
         WuM2rhTy4t0i/OAPHbM4h0FhMgmyrWThPcOsDUiI/fonkgG6SlNoPlNZQOJB9vG0NJps
         F1U2Q5yUjQ9Zafs4OIPCuMyX3awXtwCVDJzpaHO1gvIdV2jA07xS/bmxp4b2mDs5Pp8V
         B3br3g25z5nhPMCNwtcSuVmmH3Egm4VsG0cjitBh5UUpCR90ywjrk7hCg24Y8X7G9AE6
         7opA==
X-Gm-Message-State: AOAM533NrGr9sEsUAR+liBGJCI0HnsTAEDp0aZ30TxEuTskgbqddD7UY
        eJWf4N1G9ny3oIlwqZiFzHCi7omip4sGzQ==
X-Google-Smtp-Source: ABdhPJx6Oc/Qs3swNhEPu+sVGZpxDFpHPcBUKJZxHPw8vmoR+DtOCDmWjKBZbVo8hfckSOg6TyqImg==
X-Received: by 2002:a2e:350e:: with SMTP id z14mr15475520ljz.183.1631031922358;
        Tue, 07 Sep 2021 09:25:22 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id e15sm1466391ljn.25.2021.09.07.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:25:21 -0700 (PDT)
Date:   Tue, 7 Sep 2021 19:25:20 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Joe Perches <joe@perches.com>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/ntfs3: Use consistent spacing around '+'
Message-ID: <20210907162520.pi6djmu32iajayme@kari-VirtualBox>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
 <20210831181505.1074767-3-kari.argillander@gmail.com>
 <1d303f4553e67abee4f0c4cdc32231813a4bcb3f.camel@perches.com>
 <20210902081020.g5hclc45zjng3ll2@kari-VirtualBox>
 <bb8fff4c-ae09-cab0-cd71-c34b872c9211@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb8fff4c-ae09-cab0-cd71-c34b872c9211@paragon-software.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 07:23:13PM +0300, Konstantin Komarov wrote:
> 
> 
> On 02.09.2021 11:10, Kari Argillander wrote:
> > On Wed, Sep 01, 2021 at 09:22:19PM -0700, Joe Perches wrote:
> >> On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> >>> Use consistent spacing around '+' for better code reading. Checkpatch
> >>> will also be happy.
> >>
> >> I think you should remove the + instead
> > 
> > Konstantin can you look this as this was introduce by you just couple
> > days ago? 
> > 
> >>
> >>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> >> []
> >>> @@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
> >>>  		attr->res.flags = RESIDENT_FLAG_INDEXED;
> >>>  
> >>>
> >>>  		/* is_attr_indexed(attr)) == true */
> >>> -		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
> >>> +		le16_add_cpu(&ni->mi.mrec->hard_links, + 1);
> >>
> >> 		le16_add_cpu(&ni->mi.mrec->hard_links, 1);
> >>
> >>
> 
> Hi, Kari, Joe!
> Yes, '+' can be removed, it was added for better visibility,
> but it's subjective. 
> After checking code - it's the only place with '+1', so let's remove it.

Already done in v2 [1].

[1]: lore.kernel.org/ntfs3/20210907083441.3212-1-kari.argillander@gmail.com
