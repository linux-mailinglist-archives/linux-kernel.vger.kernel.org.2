Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15943FEA70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbhIBILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhIBILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:11:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EECC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 01:10:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id g14so2001716ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V/B729z3GfSMViBmOQRhXkJF2dE/VetTFeIPDS8xMAk=;
        b=nNPOBa2NHrXxrWPG+s0D+7SVdwsvGrsKzmFU5+siTSZKuhNKVgeBsbXJ25MRNQ5lFX
         v7ZnL5ysq4EL2BK8xL6W3Ms1VPyCw8lFkboiIbfthjAtlj3fB641+lJgOHnzgPhHAw/L
         2xPYEPhpFg2uYmqFm9BjfMdhnvwNSZNddpIpf/bYTRA7VVol3LP0OHSU2//iaeuL2TW0
         PbOf6QaLJWfPbKN+QNDrHE0oFH8DI9VsyOlosjoSCbkfcMT+7xcuE0kZcSIfplhwJlA3
         3KEIiCk4qBjD6sjCoCDqwqmdKq/fVyzf7ALtHZHextITZu7tWjjsZn7qVnZNj0K8p4/N
         B0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V/B729z3GfSMViBmOQRhXkJF2dE/VetTFeIPDS8xMAk=;
        b=unMpdyhQVn8YHS7oUiXgtyNzrv1i+HKnZ2Fv0VXLaMw8UUPo8nStwWJn+FEaT/Koq1
         uj16ohGfaegL2tNB3JV3ap8XFM06HIs9xC2LmPqI7QFHFGDXZx1tYkcXJoG7wkjMfWYG
         P/fNeQKgh26fuZMkJnSpdU4Rp+dADBXk5uywBp+hpqENKSRD29OqCoAdkiKoxByp1VMl
         UAGiJogWVxPMMyM8f7r7p8HRWQMF6+OH4f3s518Cw4xdBN0n10ZOA8DyhiE1sjT/MwUE
         ELMPXkkAkoqrzejtHh3UhAZSE7e0wOjDKCrecjSfAjdVY+dXbC8SoN6xabs49/LUiRuS
         zYIw==
X-Gm-Message-State: AOAM530u9PrXyUgG1BZFQI4gmX3Xz9xcomxkcCmk5ppI+SDVxtFprrHg
        8PwEex4AqpIfYl3R3LYVNHojzuQ0dnc=
X-Google-Smtp-Source: ABdhPJzKza2FO+ecYPOslUvddsKLjCd1AwSysOHdd4EMHMIUb5M3xUmeynHwXIRYWSceACX1LcrXtg==
X-Received: by 2002:a2e:509:: with SMTP id 9mr1459438ljf.453.1630570222948;
        Thu, 02 Sep 2021 01:10:22 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id p3sm125511lfa.228.2021.09.02.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:10:22 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:10:20 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Joe Perches <joe@perches.com>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/ntfs3: Use consistent spacing around '+'
Message-ID: <20210902081020.g5hclc45zjng3ll2@kari-VirtualBox>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
 <20210831181505.1074767-3-kari.argillander@gmail.com>
 <1d303f4553e67abee4f0c4cdc32231813a4bcb3f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d303f4553e67abee4f0c4cdc32231813a4bcb3f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:22:19PM -0700, Joe Perches wrote:
> On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> > Use consistent spacing around '+' for better code reading. Checkpatch
> > will also be happy.
> 
> I think you should remove the + instead

Konstantin can you look this as this was introduce by you just couple
days ago? 

> 
> > diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> []
> > @@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
> >  		attr->res.flags = RESIDENT_FLAG_INDEXED;
> >  
> > 
> >  		/* is_attr_indexed(attr)) == true */
> > -		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
> > +		le16_add_cpu(&ni->mi.mrec->hard_links, + 1);
> 
> 		le16_add_cpu(&ni->mi.mrec->hard_links, 1);
> 
> 
