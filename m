Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F036C52C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhD0LfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0LfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:35:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:34:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n127so19806088wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=z9C6sQ611y/zGRe/UW7/e4zr9l8XoO00RXrJcagkHXI=;
        b=ADceqTv77JagwuFR5s9XYfyWOZzLEa1itzG63x+/awj4LHL6EimuX3bNg/jqkU679E
         mKYqV/UOts733gmwYFpMRjNgmhi2N/F64p3P3rqX/Uh5do7cQ7vlossntalvaozE7NGz
         kf/KxYbXgYme8cHq/udvl2WQPFNraJMgMh5PWGdoZ2XI/Lb1WUhJVPFqjXfS8Ex1etJR
         vnz6sdSPEJYuc+LL2v0LHFIgtyGkM3GysbI39aqeENl2J24DoRvo1T/0CK25s4cqrKdC
         f7wIbcrSWQ8GvgsAEhmJ9tc7sjf5CdBnZgX8IDpB5GZNfz+WJ536dSma3F9vkDZXxIA6
         LA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=z9C6sQ611y/zGRe/UW7/e4zr9l8XoO00RXrJcagkHXI=;
        b=VHL9RD2aaOJ7JZYAt21/ylQ/shVUqSZGmQRikUf6Uog76yBtQqlnqz7CWCj3a21Bz5
         +wxMtsQAGzi46BQ172CdYzXh8qf1cgbvcODWmjfCBe474AlbBjkbFGLMt68K0QxhGLmU
         NJfsrBt/07RPrJuFZl/4HS6UUDRVna7yytJ4ELWqb2HWskTj7DyII1Mu2RpOa/AwCd7q
         25vFUoiBywtZ6nYGPmvV8iCAsdNB8/bxbTw09rl8SERDxm2x7y76aVR7GA/y7cwjUbG+
         S5NhUJsgylfNRgJ6RpL7ParxFFiaHGefW20eS3e38xvgQorhjHUvpsxUcplXttPXts2C
         q+zA==
X-Gm-Message-State: AOAM532gbeNetubTt1LdMMEdx31qN8a7LE5d7FMfe0Sy08yFdZMBRgyh
        TX/1ND6lsW70355ARNrDxT0=
X-Google-Smtp-Source: ABdhPJxx8bbd49gBf2BOW+mAj9jkSpFMqNRJrMWmqgLw490R5M0aOVJ384sGI0gsYJgtbMJNzHybmw==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr3883978wma.21.1619523269928;
        Tue, 27 Apr 2021 04:34:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id k10sm2989203wmf.0.2021.04.27.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:34:29 -0700 (PDT)
Date:   Tue, 27 Apr 2021 13:34:27 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIf2w1navFNeYjMS@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
But the dma-api directory does show up in debugfs, but lot of other directory exists in it.

After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).

Regards
