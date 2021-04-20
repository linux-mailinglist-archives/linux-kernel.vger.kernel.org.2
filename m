Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E56B3651D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhDTFaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 01:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhDTFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 01:30:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB714C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:29:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v7so10192790qkj.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=CD5KgC7jtIRxFp9L5EX0XqWGl1RUghQJwWPnq/cGmzA=;
        b=JCafrJcSXX4Mn66ZWw8U8ND0HHkGqhAmFRiw8OMyTHMosRl8XNVwao/iHwNS7jMLX1
         /N7bbezhvWpt+Iqas9/VOpTAJrx4FkJp16RYUuY7uI6+ufT58hn2Lkk2gei8Or6L8eOS
         pPm3UWa12JX9fTiXDsRAF82Qrq92UEv3Qi6zkHFgExT0gNh+CmoNr3fpsvKM5pCD8REE
         xmVPf2zAPQetho4L8Gz6N/1cXKukAoxpvXHCTPuBnDDst5T8fNKgPTTbQTasdckAOFur
         lfTbDyKvTK+fqPslxjcFuGjRG7OC8RIU6BlXRrkQ99635WyW5KLZYWjN4b9OGUCv1KJf
         raWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=CD5KgC7jtIRxFp9L5EX0XqWGl1RUghQJwWPnq/cGmzA=;
        b=o8pmbkmKPLAxm9i4z/COO39ZNyoJl3r1i7CunF9GKozNw4z2NjuNVOLw+DeoybK7uq
         EoCnjp1w1TLAANxMCNFbrReBB3YniHus8RLErCrB/1xGH1ySE1zfDUFNdEmuPtepP1Ep
         ltI4HfHEpvtv+a0kOXfhiCEc4v9W3I1qwCu75pTkvTt8Lvpc8IsATQScpaQZK2IAB3oy
         C98CtKDFfZBysyaeGmMUR1W81PVkBGC0BOpunGfQ7TJWsFH4J8L1vSSZnxNksgA5C+UT
         NPbehQeYWCy0cw+fRhGKEUhfuW1IvOarQS8L5LkXvp0QWF7PiKLNcUIC61b2zPsFlb6o
         mTqQ==
X-Gm-Message-State: AOAM531YIWRlIq1Pyr9icuh1ZwzOVNo0tKZzef7FbVA8ygQ7dgtRZAq3
        xZgX/UmHJfqF5ykjmGxH+H8=
X-Google-Smtp-Source: ABdhPJwZS2BpuCSdCWdDvSF5KnO6hp7JbxTakxD8Xsi7lNH9Uo+5o2UZGcERr3xdBBoefGdvXPZw9w==
X-Received: by 2002:a37:a206:: with SMTP id l6mr15817573qke.5.1618896581783;
        Mon, 19 Apr 2021 22:29:41 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id v3sm5539052qkb.124.2021.04.19.22.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 22:29:41 -0700 (PDT)
Message-ID: <2977fdf112bce230ca6739c0a7f9f1f55bd2f693.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/pseries/iommu: Fix window size for direct
 mapping with pmem
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Apr 2021 02:29:38 -0300
In-Reply-To: <58b28a98-37aa-055f-5dec-d8c0005c9519@ozlabs.ru>
References: <20210420045404.438735-1-leobras.c@gmail.com>
         <58b28a98-37aa-055f-5dec-d8c0005c9519@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-20 at 15:18 +1000, Alexey Kardashevskiy wrote:
> 
> On 20/04/2021 14:54, Leonardo Bras wrote:
> > As of today, if the DDW is big enough to fit (1 << MAX_PHYSMEM_BITS) it's
> > possible to use direct DMA mapping even with pmem region.
> > 
> > But, if that happens, the window size (len) is set to
> > (MAX_PHYSMEM_BITS - page_shift) instead of MAX_PHYSMEM_BITS, causing a
> > pagesize times smaller DDW to be created, being insufficient for correct
> > usage.
> > 
> > Fix this so the correct window size is used in this case.
> 
> Good find indeed.
> 
> afaict this does not create a huge problem though as 
> query.largest_available_block is always smaller than (MAX_PHYSMEM_BITS - 
> page_shift) where it matters (phyp).
> 
> 
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 

Thanks for reviewing!

Leonardo Bras

