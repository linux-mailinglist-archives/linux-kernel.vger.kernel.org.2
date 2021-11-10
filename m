Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921C144CAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhKJUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhKJUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:37:22 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:34:34 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c12so3338181qtd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pLMo7yji4oTRxu0asWqEVTwXX803tqx41OgUyq4EXU=;
        b=lxPv6rW1PqMzBhAzITif8LRyGNRr2rch8gSEPDAw/zg78VVvDrPt9E/E2uPaPoM/aK
         KQZoh/BbUmWxoiSYjHllurBcaBsdrD/x12AMvtUEdfjaNq4nKuS6y4x9b8LCMshjus0z
         jnhu/KZi1x26xyNO2P6+lTrBOdacA7/kH+jvMC0EozkPRkjXQSu1taj3r8eeKWoGEKlA
         gIjmV9Y9BsekIG6GJdXa+LUiX/0xBl5uhXovNmfZbO0dJzB4FbCmVAgQu41DsPqolV0b
         UvPz5jH0HGnGbnpEj9AAYn/IbVC3uxwoB9mOmtWjx/chZGQkfnx2c+PL2QiXPqVrA5wW
         s8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pLMo7yji4oTRxu0asWqEVTwXX803tqx41OgUyq4EXU=;
        b=R5V38vqQ6AKWIrfzBBa+SoqmhA/07flsdGR8ukr8PQaTi58Od5PgUxY/x2tWSMTh3W
         OjGTHwcpq46r/w0qvefF9J8kAP6j035ARQ3QLzZnYBBIQThxA3Qm/Z50/N1lkcbv9/md
         kwss2VxgLWHx5rmPaqLmDArQDDXKOyKcdyMFXxYeRRWsPryJlCVvIT9h/R+NLtbZpQUk
         6z4OaA5p/oJP7yswdavgSu2W4wjnH6El04lZItQyFaOs1q6xFAV1rCHZtn/B2Knloja0
         Bx792AvcIbY6pG330RhJOGvDqjHfY97EaTTmpbwR8wa630LejAcVI/ohoWapouUMU21a
         AR5A==
X-Gm-Message-State: AOAM532W/AdHFKFg47FLBfmSMh0qmF6a/E5oZwzj0DKIbEk+qR70vTIA
        KjJ0PtScDoJfcSJs95MclysGGA==
X-Google-Smtp-Source: ABdhPJw28ba0kyPFwpYXq5FsysZIz91rbsDRgNMw/eM3LOf18dXMnho+w2vzKfF3u6KPAITbUXCLXA==
X-Received: by 2002:ac8:5812:: with SMTP id g18mr1977474qtg.392.1636576473463;
        Wed, 10 Nov 2021 12:34:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u8sm506287qkp.21.2021.11.10.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:34:32 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:34:32 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make 1-bit bit-fields unsigned int
Message-ID: <YYws2G9kgER/zeeg@localhost.localdomain>
References: <20211110192008.311901-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110192008.311901-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:20:08PM +0000, Colin Ian King wrote:
> The bitfields have_csum and io_error are currently signed which is
> not recommended as the representation is an implementation defined
> behaviour. Fix this by making the bit-fields unsigned ints.
> 
> Fixes: 2c36395430b0 ("btrfs: scrub: remove the anonymous structure from scrub_page")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
