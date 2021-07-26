Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543403D5202
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 05:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGZDTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhGZDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:19:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408CC061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 20:59:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so12413538pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qVPBFQfkoOTPpfgMDmNOI+3X8ZThG2kSzEdO/wqW9+c=;
        b=alM+LxGH7qHW9x9N7zhsCk8NElJ2wRQAP/5f/SDVrC+tO7ArwcAhPFuIOMrm4gxFKR
         WyYVrMg4S256yZZ17BpidOc6Am+vSnGjT32lE1fTYZheWmAb7iOzymoDHu7aRNuwCq9I
         Xe3DG2ctfTtDb8ZWSGB+FQ6XXhJiuae5a37ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qVPBFQfkoOTPpfgMDmNOI+3X8ZThG2kSzEdO/wqW9+c=;
        b=dn0H3Ya0UyDyAOy/YOKQAhMvL7TgsQdAdezS8CWPmj2nGTD0paIz2rNVrqfSdaKfTr
         ubjqw8cjF8HzOXhtne7iNBGY3JO0iA9PW72QTI64+LwQDAtTxOHXH4kzHWRwsCSnBzOP
         ggzLIvPR+ebjMlHmRCMTbB7zwf3/cze7qi8ru0v6RVyqCgYcpWr61oNoNEiDFTEoPkpq
         KIos8QoFH10bAjHaml3UKx4S7PH+Txj6JgFuiw/6xUtZ6wy0NcCvNdMgB5YJwmcZhr0A
         pavwC3iFZFvsCMoftAixxp6ydGl4qtJmIf7A+LItuAWFwHy8JuYsuheVFV5HvbxJw0j/
         V7vg==
X-Gm-Message-State: AOAM530HPNGqelzLCW28tMvhd0KODoF3v+h4o3gqH4r2LQCeO/sMIhr4
        fWgkwgdEupgNDZRJv86ShkZToQ==
X-Google-Smtp-Source: ABdhPJyBXvKTfbQKNMacfCffeSJ2AZsms1CzkeIUcBE53GMuFpW+A10Jsx3/5dUpSGM7eSTsvo1AyA==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id b10-20020a056a000a8ab029030ca10b3e3fmr15705921pfl.40.1627271970392;
        Sun, 25 Jul 2021 20:59:30 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d699:4331:827:4150])
        by smtp.gmail.com with ESMTPSA id 26sm11408304pgx.72.2021.07.25.20.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:59:29 -0700 (PDT)
Date:   Mon, 26 Jul 2021 12:59:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCHv3 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YP4zHRh+jHJGbNHz@google.com>
References: <20210709092027.1050834-1-senozhatsky@chromium.org>
 <20210709092027.1050834-9-senozhatsky@chromium.org>
 <3c80786a-7422-3736-7261-8605260eb99f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c80786a-7422-3736-7261-8605260eb99f@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/22 19:26), Dafna Hirschfeld wrote:
> Also, the 'cookie' cb returns buf->dma_addr which is not initialized for
> the noncontiguous api. So it is not clear how drivers should use the new api.
> Many drivers call vb2_dma_contig_plane_dma_addr which returns the cookie.

Hmm, that's a good find. Is ->dma_addr the same as what we have in
sgt.sgl->dma_address for non-contig?
