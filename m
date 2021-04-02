Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A434353091
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhDBU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:59:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3FC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:59:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so9008137lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTdEm2tpb1uFMpqXMMBZZX3zgE1KSNm/HS5Ntx5Zxhs=;
        b=jT10piQv4Sh2pj3eu+JNADHkOwG5q9YXESwNjx4AaDVxm8KGuShQB8/i8kin6B+mdj
         khMsiz1l3L/UoOWGetKh712BAxyEDx06mi5jRIAzOpgTENIwZID3XNI2MD/Bro0NHhqw
         dmYl5RzzWLrLVTvkGRBupahzxYZ2gYLyV4sIUuNNHs+Jiqjt2HO9YUsJ2zB58gNtxunj
         qnt25IGJV6m8+/xdLopSM4+yTkkoj4zzqdGSkavHiwnLd6o7gBcVhi1ZemXK36MFeRzl
         Exv4vBaXjofktB/qzEmLPsbt59TZvh9KgfCPqcERGUqu92OTtPkLDZT8ZpX84DpCltf9
         ypMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTdEm2tpb1uFMpqXMMBZZX3zgE1KSNm/HS5Ntx5Zxhs=;
        b=JTnPdAwdz/9DztZzvQOafM9QRcl4EDEnPEvaVV28ls1yFbUt3qfp7e54fY/5Ush2B0
         BewxbhWRweh8Sb9wQFbA96cJgdhSfBxmlbqRzslvuKcdjWLVWo2NGgxfucS7DXqxl+ZQ
         AjADGoTq5YsMVYxecnkAcJnNPRdHtYLQRcZloSuHtO+3iwc2vxLChhibcTOKVwPpZx7S
         nocQkKYDKiS62oHGPJ9/t2kGvXZ4M3yt7LUhB+OSXBa85DR5VDVePcNK4Ark6pu9+7ib
         yyvVsB61VDs7ADBLktKsHHB4z5vvt3xfM4Kgud7B5nWPftMLUOsep+HR5GPIvrpXkicY
         wZCQ==
X-Gm-Message-State: AOAM531cketsNggS6ZM+EtJ26DWER9aYBQCxFCJrzFUW6QVPbp5AO+CB
        IMsw+noIu/i3iaJ8tvOfXaI=
X-Google-Smtp-Source: ABdhPJwKyY99g/9nIZ2NYEC+XxlyS+8i9/ZQIBiTJFOiWqaIWBHj9BXzwfnWJuPSwFf3oyIyxWInDw==
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr10219250lfb.38.1617397140700;
        Fri, 02 Apr 2021 13:59:00 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id g3sm955374lfb.94.2021.04.02.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:59:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 2 Apr 2021 22:58:58 +0200
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-next 5/5] mm/vmalloc: remove an empty line
Message-ID: <20210402205858.GA20418@pc638.lan>
References: <20210402202237.20334-1-urezki@gmail.com>
 <20210402202237.20334-5-urezki@gmail.com>
 <CAFqt6zbszFZKpbOg7A5L_keqUwsXMNCxa91+S7sCUij70u8pDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbszFZKpbOg7A5L_keqUwsXMNCxa91+S7sCUij70u8pDw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Apr 3, 2021 at 1:53 AM Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> How about merging it with patch [4/5] ?
> 
I had in mind such concern. Yes we can do a squashing with [4/5].
If there are other comments i will rework whole series if not we
can ask Andrew to merge it.

Thank you.

--
Vlad Rezki
