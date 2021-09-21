Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAA413C39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhIUVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:18:59 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33462 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhIUVS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:18:58 -0400
Received: by mail-ot1-f44.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso528739otu.0;
        Tue, 21 Sep 2021 14:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Lsr93at0cWmNYp0eGkUmreJYYzq8CpkZ94/2p7LeqY=;
        b=WsbU476SmyUL2kcDqOvnuRL7ENEnWQYYWM+G19KIDx49WtFprUS33Lzbj/oLE3faBQ
         LsaUdcDl1QdRTPV5N6GZmstRHrgAwlRaF8oludraTgTdx2GIVzENeE9DDd4PMArl9s0n
         E1zCft7xN4Ec2VTqlmpEC3OaYxHUPzRi50jXWkoGDo+mAQIyTUpudXU8ZZPHLC3zB+m/
         DTcpCi8iscWdJZTH7cM6HFqhkoFMF+SGvCQ/WunCs9dDCaDMgnCn8AJ8Rj+roJ4mSb3f
         aXH4D/ysCbxLKvOg5m90HTl8YrYF6V5QQ7dlQ4KJ2p8Sufl4Kg5VZPBRiQA3kCm6PT6F
         Sa0A==
X-Gm-Message-State: AOAM533koy9BDcYW4KEJBlp79eUCjzhWsA1BKkrJDcotCH3BI3L3KKCv
        +JwLgZpVwKtjIqPuYhhujg==
X-Google-Smtp-Source: ABdhPJwy9BH8rHjOx9Hn6xfioTu4ZfqPtlbLcr1Im/zzNbEh4d6wfDqVY6NT1n3SFuKzlx9+BZLs0Q==
X-Received: by 2002:a9d:72c5:: with SMTP id d5mr28207200otk.212.1632259048920;
        Tue, 21 Sep 2021 14:17:28 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id k5sm39542oik.38.2021.09.21.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:17:28 -0700 (PDT)
Received: (nullmailer pid 3339518 invoked by uid 1000);
        Tue, 21 Sep 2021 21:17:27 -0000
Date:   Tue, 21 Sep 2021 16:17:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: mstar: Add the Wireless Tag
 IDO-SBC2D06-V1B-22W
Message-ID: <YUpL54S16HXK/xkU@robh.at.kernel.org>
References: <20210914184141.32700-1-romain.perier@gmail.com>
 <20210914184141.32700-4-romain.perier@gmail.com>
 <CAFr9PXmfhkrJHwp-wVTKakQsg71AmcOz6Cc=rh+=R+8L_SHb8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXmfhkrJHwp-wVTKakQsg71AmcOz6Cc=rh+=R+8L_SHb8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 07:09:34PM +0900, Daniel Palmer wrote:
> Hi Romain,
> 
> On Wed, 15 Sept 2021 at 03:42, Romain Perier <romain.perier@gmail.com> wrote:
> > 1. http://linux-chenxing.org/infinity2/ido-sbc2d06
> > 2. http://www.wireless-tag.com/portfolio/ido-som2d01
> 
> I think these should be Link: xxxx. I can fix this up if/when I put it
> into the mstar dt for 5.16 branch though.

Not really. 'Link' is for the link to this patch in lore and sometimes 
to a discussion leading to the patch.

Rob
