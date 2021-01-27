Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5369306844
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhA0XrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhA0XpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:45:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:44:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id r4so2066636pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Mxms3zmarGgtqLSA2knr9DFUQbJNpMaXiC1Rwt/vXfQ=;
        b=Rk78kGbTRTMsJht7TyBKfA+4NY6T9q1+B9xyRJPxErypmxzfFg1Nv607eX/zhWOilm
         xIF2iZKJNNs0OizLmf5xQchxGNztXdG+MejWZt4vq9jUdoGE3p13+Ow2gj+UnyxxLMZh
         820dcly26qnDHkf+TMfpinOCa5mKEnv3EoTWeuKmPOAvBVp5douEF2TFDaFVJX8O7Aqa
         LcCdL+M1mXHI1pP2L6BrJGNIOAtJvb/1syYMNQ758u8UN2y9var1hizA1oYqPNmZo61S
         0CFz4y8J5l+Bepx+5SfQ3rwd+HCH5CXiUK0kK8LHvswJ70Tr3B7u0ognkccOZsO5ruRp
         /QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Mxms3zmarGgtqLSA2knr9DFUQbJNpMaXiC1Rwt/vXfQ=;
        b=Vq+1XSgC4t7WzRjNI5X0kY1UDV8yzn9dqRfjwuMjfMwjpG/rkeei1AiqhhFyuGhdnY
         Zv25LUAaApFGAgmnCpQlrGGwhJ2kPmQcnNWg3kQLyWxW6z5jyfqrtxnmlxFurODGFi6s
         JGBC5DoWCAUrNV5eUwIROv7UjtWmNiJBuAcfbZ+0DgcW76uB1rSRYhyWIQlxGuUeNyaX
         4W/fJxLbz+Fdj7toQvKFnW+L0llRyOZb0vwwle4HxuzazlBMQA4bpkIexpKIM5iiBbhB
         BuVnPs1TDT64G2X+ofgqr5+a356Fc2ylYLam65A7Jjg37uI3Ysmsta2jksk7sAaK1/jE
         HMhQ==
X-Gm-Message-State: AOAM530FT6nHFoq1icmYuMkVHeJigc9EXZXM3MUY5RO2tit8kfHObDZD
        N4Wbsgncx72DFmSxwh+2yJo=
X-Google-Smtp-Source: ABdhPJy973JY/GinSGJtf5a+0PiKQqWLhevqbbKoXQxFTvmud+BGNyTfcj6DSK6CkRQf8lc4vFUuNw==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr8190388pjb.97.1611791061723;
        Wed, 27 Jan 2021 15:44:21 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id r14sm3828769pgi.27.2021.01.27.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:44:21 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:44:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
To:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Robin Murphy <robin.murphy@arm.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
        <20210126045404.2492588-3-npiggin@gmail.com>
        <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local> <20210127071059.GA21133@lst.de>
In-Reply-To: <20210127071059.GA21133@lst.de>
MIME-Version: 1.0
Message-Id: <1611790740.civn6atbwp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christoph Hellwig's message of January 27, 2021 5:10 pm:
> On Tue, Jan 26, 2021 at 05:08:46PM -0500, Konrad Rzeszutek Wilk wrote:
>> On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
>> > vunmap will remove ptes.
>>=20
>> Should there be some ASSERT after the vunmap to make sure that is the
>> case?=20
>=20
> Not really.  removing the PTEs is the whole point of vunmap.  Everything
> else is just house keeping.

Agree. I did double check this and wrote a quick test to check ptes were=20
there before the vunmap and cleared after, just to make sure I didn't=20
make a silly mistake with the patch. But in general drivers should be=20
able to trust code behind the API call will do the right thing. Such=20
assertions should go in the vunmap() implementation as appropriate.

Thanks,
Nick
