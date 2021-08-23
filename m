Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968423F48A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhHWK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhHWK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:29:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251CDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:28:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq3so11615589pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilKjy382tEqa7gStpBRz59Gr6MRunEshTjEeiH1h2JA=;
        b=Nf9y0HaDZZTMBiU3gKfNU1c8lX/eVkGiVZtSy/+Z7QdeLAz8ZEw6+m3aSB2Q70T+8d
         NWhQv9c94DaK58O13+01OKgVouHiRX8y1aMCYomnvkVYOGtCfRl3cbeWKHxBRE1qp7zB
         jE23PmQzrvCySaZ62ujHBand3wNsZQzdAJi+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilKjy382tEqa7gStpBRz59Gr6MRunEshTjEeiH1h2JA=;
        b=CFQKmiQjDlaToPQQpEnwgL3TiaCFXgjCZogFhcFEYNG1o7bkCMydhaJIErL9ctt9yX
         CUYCOCstdz3D4y6lNHM5eHvLvYLhttGhTDE37QWaWe0CNFiMVadx4erUuMYlPpQAKcJN
         oLj3l5JWNtrSkKHVVoMquvxKOlA7SUShFMn23H6q5HApDZvBKzRNL4WfRO9pe/HtP0B2
         6peSrO8GltTQcH7V+BhQcazbS+ql36ICMvdDOdqEs5tTS+2UsosdYXXvSrUhF92FEnbG
         TT4P/bik1IarJjQzhSVMh5LPBAL8DwKHNAjJ+LMYvAcF7cJO5ME9aNKz9dk4dFtQ8lpx
         UAUA==
X-Gm-Message-State: AOAM532BIUX15DEjQf10EsocnImHdbHRC6pKjNocF9QTjq0RzDLjXgCH
        5RhASgu6GtwmaKO82Y8I4XMWrg==
X-Google-Smtp-Source: ABdhPJzReVtwd7Yt+cXXy5xtZ6aXZ+ZHjspUFa/ZcLYCB9GL/ljwsw0yWGII3+QOh3jIWf0ZciDm4w==
X-Received: by 2002:a17:90b:2348:: with SMTP id ms8mr19205896pjb.121.1629714533737;
        Mon, 23 Aug 2021 03:28:53 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8821:8b2f:2912:f9e4])
        by smtp.gmail.com with ESMTPSA id m9sm6793814pfk.61.2021.08.23.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:28:53 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:28:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YSN4YJZwsSo4JwCu@google.com>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
 <20210727070517.443167-9-senozhatsky@chromium.org>
 <7e172194-9519-fd1f-6261-c40108a5d722@xs4all.nl>
 <9e5b1d16-bfb8-dc89-beda-94a641be793d@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5b1d16-bfb8-dc89-beda-94a641be793d@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 10:39), Hans Verkuil wrote:
> >> +
> >> +	/*
> >> +	 * For requests that need kernel mapping (DMA_ATTR_NO_KERNEL_MAPPING
> >> +	 * bit is cleared) we perform dma_vmap_noncontiguous() in vb2_dc_vadd().
> 
> Typo: vb2_dc_vadd -> vb2_dc_vaddr

Done.
