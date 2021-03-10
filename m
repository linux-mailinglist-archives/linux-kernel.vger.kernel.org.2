Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC6333693
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCJHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCJHq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:46:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F54AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:46:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so6767091pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YtSOPZCf9Da269ZEPcGrsyfquqgeGyegkCV8/Htilvk=;
        b=R5gEY8VaX1kw0BYeYWpOh2pvYK1+99hrZLVbBXAd3RwBgFjYc1B57PG7nhkaYE0mLc
         SXm6a1/sZRJ3lPzuMVqkrY91FHDPAe9Jscu5lh0y5zZmfoNOf7VeB8S4X77/Gr9e1ujv
         wuL7xpQ/EtRPPpp/f3fxRXxIVUJhTNkZFIIqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtSOPZCf9Da269ZEPcGrsyfquqgeGyegkCV8/Htilvk=;
        b=U6+0ons9W1LcdQDexdmp/KVQ25BBGFPTQvpA7VnfN8S3k62AouMtoDBOIpmkmc0qC1
         VDHtAWY+jsIWKI6wo5yqBEKlQ4YRNsM4na3sZ4vodbYGRZejBepMr4O28N47D2QG5ZXZ
         pT4K8m4Pj+qHlKbPX+2JOSHvaDOQeKNgZBWjnLKaiqTGqaBRrpeXxuMntWG52Dsh4HRz
         ZyvUkwjN5OSYIV+9+CTjRXngknCQ/wPqBFa5nzkAEIrDzhN1xs1/ztgAs8ld/YSEs3t8
         M9nke926UHbQFxre/aPOUO7OEU5amxSDQJ6o+dcOEo9CyGjrCrlZi1IMG93AR16Uqhdl
         HkNg==
X-Gm-Message-State: AOAM530vuOG6dn+IUrvXU4+iTnAMURBVlTUY9EMtV3jC4gEQQaylJY7b
        S4Ki071ZVQQZs+Fb7zb/eOk51Q==
X-Google-Smtp-Source: ABdhPJwEa8CkSLK2/AJuxaIcUqDxCJOy2d+vmOQXrdTz9u3hdWTy0ok3NvdeQBqSoRxViggpDTF0wQ==
X-Received: by 2002:a17:90a:8:: with SMTP id 8mr2313414pja.6.1615362387840;
        Tue, 09 Mar 2021 23:46:27 -0800 (PST)
Received: from google.com ([2409:10:2e40:5100:30c3:e7ed:8b0a:7f01])
        by smtp.gmail.com with ESMTPSA id n9sm1793181pjq.38.2021.03.09.23.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 23:46:27 -0800 (PST)
Date:   Wed, 10 Mar 2021 16:46:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2: Fix integer overrun in vb2_mmap
Message-ID: <YEh5TmP/fbHeZc2G@google.com>
References: <20210310074028.1042475-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310074028.1042475-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/10 08:40), Ricardo Ribalda wrote:
> 
> The plane_length is an unsigned integer. So, if we have a size of
> 0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.
> 
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: stable@vger.kernel.org
> Fixes: 7f8414594e47 ("[media] media: videobuf2: fix the length check for mmap")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>


FWIF,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
