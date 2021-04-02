Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD2352B76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhDBO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhDBO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:27:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46AC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:27:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x26so3742136pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T3DVNLHJQeSHfhXNKz9gWp+Tv1DR+kLOwzGQWhc+nWA=;
        b=P7PnM9/F2Rzjf71XMFNGpkG+o4amPJ9qgD+JRcXsUoz805jFetgua3n/+Fqp6EggUt
         VRLWl6TP2Wqr+yiujTkrQVaeDNyU9PVkvxtWRQNmecAoMARtvVOE2cmr33ke26IMPQoC
         ONeD+8CXvvl5IQkINWc8dBBxsSpsNY+JsmW4gbxCIhDrVmkwoNmeyQ6HNoHqe50Add9y
         etKmbMJVsYI/8KKCoH12VcRrwrBGbWzZuN7Z1PzZO1qY1D0J9dXWYSiJpWwCXfrPgDBr
         MMYbeWXhev1YdG+Meukulm71mxAMMi9TLWgKLsrcegnKrxsA5tfTZevKmAYt9Gm+hRnH
         s5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3DVNLHJQeSHfhXNKz9gWp+Tv1DR+kLOwzGQWhc+nWA=;
        b=NewUlqw4Sde382T88fKHz656pMaV+0vP5dI81n7LXW/kxoj5tSu57e2QupBA4iIESN
         AhaPS1ciFqBFhcssg0eTNUjqGCXTJmMP6/WSKk+SM+ccx5Fgr3N2KFuAU/8MxuC33DTV
         FEQ7x0xDXWDhhBHbl3PeKpUklRSASjdxibVzVqniAHB/sbujGjrX1cV0olF0MKww3jTT
         61E5jiqlfvKbIaSw/DwWAmrIrf2goSuliIHV+zvhazUzUNS/xI/QSCfCz68udDBJ/4ai
         OudB0JVM1DGSm2rYQXvqjWagepGcl35cUicA8hnmD1n1sLbKGXEkRaa4788eClCJqux7
         whFA==
X-Gm-Message-State: AOAM530pdHqM/CGRdm/kwqnEiyEBJJc7X+Chlo3so6GjLJkAH1bY1RWr
        ztbZGfqG5ZAFbv9lflwx5lwa
X-Google-Smtp-Source: ABdhPJyg2TA0SpbCUUf/oOc4ML06NB7wRTSDPCziI9Y/12+4l5psy1DKY3L9m8r9PO487eIRbvnaGw==
X-Received: by 2002:a63:d7:: with SMTP id 206mr12092114pga.30.1617373655350;
        Fri, 02 Apr 2021 07:27:35 -0700 (PDT)
Received: from work ([103.77.37.174])
        by smtp.gmail.com with ESMTPSA id w4sm8187408pjk.55.2021.04.02.07.27.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Apr 2021 07:27:34 -0700 (PDT)
Date:   Fri, 2 Apr 2021 19:57:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v10 3/4] mtd: rawnand: Add support for secure regions in
 NAND memory
Message-ID: <20210402142730.GA10498@work>
References: <20210401151955.143817-1-manivannan.sadhasivam@linaro.org>
 <20210401151955.143817-4-manivannan.sadhasivam@linaro.org>
 <20210401175421.65db63bf@collabora.com>
 <20210401161622.GH14052@work>
 <20210402105154.0a2a3af5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402105154.0a2a3af5@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 10:51:54AM +0200, Boris Brezillon wrote:
> On Thu, 1 Apr 2021 21:46:22 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Thu, Apr 01, 2021 at 05:54:21PM +0200, Boris Brezillon wrote:
> > > On Thu,  1 Apr 2021 20:49:54 +0530
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >   
> > > > @@ -565,6 +608,11 @@ static int nand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
> > > >  
> > > >  	if (!chip->bbt)
> > > >  		return 0;
> > > > +
> > > > +	/* Check if the region is secured */
> > > > +	if (nand_region_is_secured(chip, ofs, 0))
> > > > +		return -EIO;  
> > > 
> > > That would is still wrong, you should never pass a 0 size to
> > > nand_region_is_secured().
> > >   
> > 
> > Size doesn't matter here, that's why I passed 0. Maybe 1 would be
> > appropriate?
> 
> You're checking if a block is reserved, so I think passing the
> eraseblock size would make more sense, but I actually don't understand
> why you need to check if the region is secure here (looks like
> nand_block_isreserved() does not access the flash).
> 

Ah yes indeed, brain fade...

Thanks,
Mani
