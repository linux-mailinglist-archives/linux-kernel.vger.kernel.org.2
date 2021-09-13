Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFC4096D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbhIMPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbhIMPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:13:50 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F7C0C7017
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:03:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s32so8128685qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEvIyYeLDXUpTcJZWMj983nbdS1DgqFIWLgNvEi4/Kc=;
        b=UBFJb/UNvdtTIVCvaiSXEdqImCOifx2UsDbPJuKsWTYonXF9HcLGUZQpwlWpd+7Ah2
         LbjHtrrJg6a3J/R57I6PCgelupBiAhdh/JpCa31goTnJMpfL2+kE5rf73AP7w2x/KFwH
         lgy5G1OARWI5FY3AhcpvUpoSg58EALyljbwxgI+weoQOylI3a6qU5fnvQzSscdZ7ziPS
         9tE3acRsny/FIP0kFA0yJ3G5wg2p1OIeF+jufoAYCIsI3iGfGP1kN/lmBrlPC8qdy9DU
         CaFmTTWKf/xb3P9MijywkcnPoO/gLMAVIG5zTXYDBhiDQpCIgsHACL54WyeeTrlNyxrQ
         E5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEvIyYeLDXUpTcJZWMj983nbdS1DgqFIWLgNvEi4/Kc=;
        b=e0vMYQMQJ2Nvt4wbcNu6+gAHYJaAVcG83izEr43IHYZKY0PyihNHIcGegNmelh1kUo
         w+5JkFy/s0ZSRmc8bzA4N7qwHD3nN6JP6JvTip+Al/+zMId1ZP7AQRYS7VkIq4iwtfIY
         CEubTGCqFp8cWMGPBrsuVWOge+6W/gZYI96+lDYc7bmlRxbitw4eaKJ0bjAuMedSaA3n
         Ap3uO3OE0bpSPh3u3QHWNW459qXH6NDKsBsHVULASPPbKwsYJagzr9gbhYC8HjhZLvkb
         oVWHmj+XpkvI9nAk33gV8mG+3qSzATzEiHeytlG1K+lzlEKn33LxzhQ10kEwvqec0c3x
         BimA==
X-Gm-Message-State: AOAM531k7MQdwdCyIRuEvluvDpjIoAFPIwWKzzu9pROZTGz2A0gYn89p
        UA3EG0bUHXpKNI0SNvDOQ8369Q==
X-Google-Smtp-Source: ABdhPJwFd7EsMjZS09jyOS0QyiyESxT3hnj2v4ushFACgvIZP/sy5MgREfrUl8X2Mx5iMEb9dSRjVg==
X-Received: by 2002:ac8:5f86:: with SMTP id j6mr9320639qta.11.1631541784302;
        Mon, 13 Sep 2021 07:03:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b15sm5219812qka.107.2021.09.13.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:03:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mPmY2-00GTN6-Sz; Mon, 13 Sep 2021 11:03:02 -0300
Date:   Mon, 13 Sep 2021 11:03:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor check
Message-ID: <20210913140302.GE3544071@ziepe.ca>
References: <20210913120521.18572-1-fe@dev.tdt.de>
 <20210913130210.GD3544071@ziepe.ca>
 <690f5a5f846c4ef966713b4970d07737@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690f5a5f846c4ef966713b4970d07737@dev.tdt.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 03:46:48PM +0200, Florian Eckert wrote:
> Hello Jason,
> 
> > > The device works than as expected.
> > > 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > v2:
> > > * use variable type instead of le32_to_cpus function call
> > >  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > And if you do this it need to be made sparse clean/etc
> 
> Sorry for the stupid question, but what exactly do you mean?

There is a tool called sparse that checks the endia notations and
verfies correctness

It will complain if you do

__le32 x

x = le32tocpu(x)

you neeed another variable to store the cpu version

Jason 
