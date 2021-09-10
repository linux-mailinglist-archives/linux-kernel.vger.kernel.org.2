Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCA40681A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhIJIBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIJIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:01:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C75C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:00:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q26so1345109wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2EzhBx0PMRhfQS+NCG8vRKNuqi8wvz9u9B7rxHri58Y=;
        b=E0DfoaGEIzIETU2U9nlDTMsDxsk6mxe6rJGuVJvcSjalHiPPxlhxmcFUiyW65bm5Hs
         Xr9DNGZQ/xUU2CN3mHBLPdD7JcOwJLwTI8E4Jqe7sC1H72ZmIqicOyKA+GQ7TKz8UsN8
         Gyqczex7Ki2C7QjEFHeUWmr2H67qtKv5dUso2KIbqYitIvtMkcUHcihkC+sBIkeHXx3b
         3sHou5sK9QUi12XYqGEMjbY36NmZsZ4EbU5Kbm9h6abXCIJisybZvfZZCU01LTEldJi3
         NfqhIExPj4wJpl9pUWvV6jL4tcq8HEm5NP/cOlhlSTrg+POAX66HWhSpMwFNDxsUUfXB
         itTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2EzhBx0PMRhfQS+NCG8vRKNuqi8wvz9u9B7rxHri58Y=;
        b=UKSZFjfVGh0UPKkLCDS0Chndai78ptwZN/9xD0OxlPh28/3FQiFWLbOowhTZFHJR8y
         u3yYZbM9Ec5qqIPmZcm09afsSSUdNtin9L61qn6+CAf75RD8+4DmnyTFe3vzxz5eF91D
         XxhOCfTIUQcrkKWuovfts41gB390cK5jtrYewxiapGz2nzXkMcpQelZhy6sk/cAGvuWj
         YvxPyvj2ckNGdhZeRotW44/4YoHu1/IZjdsfeaH2bU+AGbZPVUI6YlnWMAdcMvCQrgmp
         EadVFqxRn9Mdwu/ThZ0xlvdivcWmm0WP680N3Y8HMtepHVJcyM9ZzXkiNN8tJCTgd937
         KrFA==
X-Gm-Message-State: AOAM531kh+VUw3iyDjIdD3PVeunxp41mwuAxcGH9yoWmXq/q37VV9SCP
        Z7kz5DDDUUL/H9Zhud1kIn70pA==
X-Google-Smtp-Source: ABdhPJzGKyhjbB05EoODWX7RadvRd0lWPb0a6qFzw7tW2w8J8Ob027f0aDUlDoU6kIz9G64ctbqnPQ==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr8345599wro.42.1631260798922;
        Fri, 10 Sep 2021 00:59:58 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id i5sm3288201wmq.17.2021.09.10.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 00:59:58 -0700 (PDT)
Date:   Fri, 10 Sep 2021 08:59:56 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Lukas Prediger <lumip@lumip.de>, axboe@kernel.dk,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTsQfBwSPkZasDff@equinox>
References: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
 <20210909180553.8299-1-lumip@lumip.de>
 <10f60086-2be0-d26d-dfa6-fe128772a409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f60086-2be0-d26d-dfa6-fe128772a409@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:25:35PM -0700, Randy Dunlap wrote:
> I have no problem with Jens's suggestion.  It would look more like this:
> 
> +{
> +	__s64	last_media_change;	/* Timestamp of the last detected media
> +					 * change in ms. May be set by caller, updated
> +					 * upon successful return of ioctl.
> +					 */
> +	__u64	media_flags;		/* various <struct> flags */
> 
> #define MEDIA_CHANGED			0x1 /* Set to 1 by ioctl if last detected media */
> /* other bits of media_flags available for future use */
> 
> 
> and not having __u64 has_changed;
> which is overkill for a flag.
> 
> -- 
> ~Randy
> 

Yeah I like this, good idea. Thanks.

Regards,
Phil
