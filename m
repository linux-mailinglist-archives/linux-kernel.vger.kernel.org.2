Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59EB36D5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhD1K0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbhD1K0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:26:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB26C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:25:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so62468522wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bwu2rvkvN7gIZgfFitfEHTzbFUX5cjTsDc1ntVZl3eQ=;
        b=PHZeQvSpD9gY/jZeF+Zw2eXX30t8tvzRaZFemI+co9ssuQJ5VmkKic+in5tGy1voiI
         +JbG2h+dGoZ/G7jodqkrWRnDvqMHa+gVEgnr4zHczTntfWyOoWVoXaxQcHqXpiK2yXjl
         bkhPD5asbliuzx3DkFvnuveaTuLwFkNVRijOUe8uTOsvWAizVeIoXmThi2TrC3YVMc7p
         20iUBDZKOaklWfdjYQI1TquVFSrnj8YFJvZwGlQPSh3rmsqoU0DQGOYUCqKey8oVkujI
         zDpM/DGNrIlmm0i4MBPcsp16t4/kmCEMcJMHglWv4NzCh/y3+uPg0kqcwq6iidzS3XZ5
         Yc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bwu2rvkvN7gIZgfFitfEHTzbFUX5cjTsDc1ntVZl3eQ=;
        b=ksNSkWbDF3kFoffloBEOTzHLbvkPMlkRpr71m0xjp5Lf0wReYHfv9tLw1ILAOu7FHq
         7CSCAcKMvqBAZuxjpZaponWYGziak+AcBgSgbX1s1V7ntBDst349yi4/qGRAqYKULn68
         DnyPhA+aN0rL+jQ6r4g/HY9Zmd7eWxvTBME62SZmMGLkgYt4n1LGyR0IJaxBrkEpp7MK
         oRlGzKn8Y94g7Ql9cW5xPt1Nbob0d/JyaoMpVJlu9990R7xVzs0P90GwKiILsCKUXN1Z
         yfLH2XQzlYsRlxw2eoqa61xuFX29wTJpfugTvN6du87axYuFFfd9GuvawDUekM4ZenaM
         lrYw==
X-Gm-Message-State: AOAM533dy6MCe81wWmFhlymimO9hAOqqWBmIzEGfiEJP2ZvL/RFl8y5K
        WvqU5BtCj+HB1Zy6Tma9UFU=
X-Google-Smtp-Source: ABdhPJyg7JPa6ZNYGm2DugdINct82FO1jCIP+1ZhYmTKZMahiNC6lNjGXCn7YoYbQE30oSy2QINbiA==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr20283167wrw.108.1619605537794;
        Wed, 28 Apr 2021 03:25:37 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id a9sm3381689wmj.1.2021.04.28.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 03:25:37 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:25:35 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: DMA mapping fill dma_address to 0
Message-ID: <YIk4H82yrx+Yzp/U@Red>
References: <YIkf4yqt14dGPoyr@Red>
 <6ce3614e-af79-2a36-de83-6cbb4d9fe9a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ce3614e-af79-2a36-de83-6cbb4d9fe9a4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 28, 2021 at 11:06:10AM +0100, Robin Murphy a écrit :
> On 2021-04-28 09:42, Corentin Labbe wrote:
> > Hello
> > 
> > I work on the crypto offloader driver of cortina/gemini SL3516 SoC.
> > I test it by filling a LUKS2 partition.
> > I got a reproductible problem when handling skcipher requests.
> > I use dma_map_sg() and when iterating other the result, sg_dma_address(sg) return 0.
> > But sg_dma_len(sg) is still correct (4096 in my case).
> > 
> > Below is a simplified view of my code:
> > nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
> > (nr_sgs = 1 in my case)
> > sg = areq->src;
> > if (!sg_dma_address(sg))
> > 	FAIL
> 
> What is this check supposed to be for in the first place? 0 is a valid 
> DMA address, because it's also a valid physical address, and I recall 
> RAM at PA 0 on Hikey 960 flushing out some bugs in the past when we 
> tried to use 0 for DMA_MAPPING_ERROR. All the Gemini DTs appear to show 
> RAM starting at PA 0 too, so I'd have to guess that it's simply the case 
> that your DMA buffer happened to end up using that particular page.
> 
> Robin.
> 

Yes, 0 is a valid DMA address.
I just find it by going further and printing mem_map value and testing it against sg_page() return.

So my original problem was not related to this.
Sorry for the noise.
Thanks
