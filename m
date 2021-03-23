Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B89345F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCWN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhCWNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:25:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:25:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b7so27098132ejv.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r5MzpqQZUTIbvYW/LPuJYOpz6l5B2Fb8dCOYT8Y2sg=;
        b=f2JK0HdS9o3MqDof967k0R7irtW3xhOyegr0pKgz9Hpkykg4oSxUdp0jNixS6eGEpr
         htBUqvoiCcc0/Qur6LNxMwBwQ53Y1bKctioa4TXjRlCjTTK15/HOjoxrFw/0urILPqPy
         BD/NAGPVq/Y4hH+87+ar4jfSgwsKprImHRAFfoe6tZlOVevHdEGgqH34j6DHcbRONW3B
         2YvBHyXWwW7Iy0eniOQLCXSpZa2zjphK9jwWC5c2yYQ5DYShL5Ppu1V9J9pivdawVOOT
         7gsL9ItE2jAYnWc/82Pep5hBUXLPak+0k74IBj7f944eX88nTOGKhXeFfW/XtZLW8Qnw
         54cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r5MzpqQZUTIbvYW/LPuJYOpz6l5B2Fb8dCOYT8Y2sg=;
        b=EHLgdkPUViy0s6X+lasvBLqebOoRIn1VuKfjSA3mAQA4TNR1sf9ICbYpv/5xb/Sho6
         aDhgEBRCUbJiH9nuYpzfCFOXZ9agmL5ATPqZZkuFDsIYSdVPHqPrbh/md2PkfxKbO3pq
         vdOlprndmNPndSgZosnwXkBmrm3mclgcfVvV+5X2q0Psqz/FgMv/u6QlvvNZEemRVngk
         PRTGYjq5fxavJa4vigWDYlWlqADaW5HWKunQbpCvXa2u+11wxSxSLwc7sXAWZrnruBrh
         XEZxuQmktOmKUDYjorwxdfvlwMava+zZsup8sFr+zfgKsLPvpAD/2lga9hWhN4Y/VjM5
         D5sQ==
X-Gm-Message-State: AOAM531buk67D57urAZsEGOlQzihTgGggnd9/6FQsgWiIu2Dn/j141O5
        4FSx0k3vTQ+27E7tXZtKm6A=
X-Google-Smtp-Source: ABdhPJziMRsVy7F/9xEITfdmiFRzOzAOEnCYUKPnWhSL+BrmWlTjCaq7uSAUbYiEiwXVTG05rSgkxg==
X-Received: by 2002:a17:906:32d1:: with SMTP id k17mr4985190ejk.94.1616505955471;
        Tue, 23 Mar 2021 06:25:55 -0700 (PDT)
Received: from agape.jhs ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id v15sm12864318edw.28.2021.03.23.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:25:55 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:25:52 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com, apw@canonical.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] staging: rtl8723bs: moved function prototypes out
 of core/rtw_efuse.c
Message-ID: <20210323132551.GK2026@agape.jhs>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <c46e7d7a686988bb6aaea9bc24b15188136e0aed.1616422773.git.fabioaiuto83@gmail.com>
 <20210322192927.GH1717@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322192927.GH1717@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:29:27PM +0300, Dan Carpenter wrote:
> On Mon, Mar 22, 2021 at 03:31:40PM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch issues:
> > 
> > WARNING: externs should be avoided in .c files
> > 35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
> > +bool
> > 
> > moved two function prototypes in include/rtw_efuse.h
> 
> Can't you just make these functions static instead?
> 
> regards,
> dan carpenter
> 

Hi Dan,

sorry for my recent spamming, I forgot to cc you in my
patchset v2 submit.

Thank you,

fabio
