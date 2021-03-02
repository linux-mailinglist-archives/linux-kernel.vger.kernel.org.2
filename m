Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D632A09B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576171AbhCBEZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhCBAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:51:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D75C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 16:50:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u12so768961pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSk/i7LihPUCGvs0fe8j5KOh0UoL+rVl096m60ttlfI=;
        b=XcA2HeHkdlRJhBBTrj95utHG/mHngOp+0KZEukC07mMXUy1NTaTpH1oVvUXY/feiFp
         kmqmqMQHNLIQcFJ/aMFPauBtzCnXp3NjkuPrGqM7VbKCWSHY/kuvPubri/cBp35Ft7gt
         UdFO2dFzA0LsYdhdehgjoJyQsS/UCbhsbSD/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSk/i7LihPUCGvs0fe8j5KOh0UoL+rVl096m60ttlfI=;
        b=m2z6PIpCLrxutAfSsx0zZAJeclQhe1XVzNa9wN7KcNbSNJ99karUKraU/gYn1k1vEi
         SrBPYnmGf2qedv+M8MltvuPr/BzozCLrKpHG6yjVIAgeU0KCQmArNdLRtujg3LEkUHkE
         SEo5oPMJzlEm03yZohUhDW/AHd8WvzNGxEeqoaBK46+UWLoI2sabglKXzlt4BHtXRS0m
         103D6AMCGoEiEJH8Z5Q60XNdUZJSgP+kDt9nBfJXrKRBInMArTqxvZ5v9SczcsXMKKMW
         LZrLkSALQTIODCjErifuD5QmZFvNKtvvxBIiVx7oEXdY8yuXNVTTP/ATdhDa37hegi8N
         ytFg==
X-Gm-Message-State: AOAM53077z5pBVH/jcra6hoIoCCCe2Hl2S/GL6/lfqvH2y3iOfNxNpI8
        DzAZEtLai9njzb/isLjUfeJZvA==
X-Google-Smtp-Source: ABdhPJwwVmHCJgEiK88Fg3jmUL0H8okuGLr9qBFQuj3J242W2G6ogapRiPORMcapjE+IPvQVN09t6Q==
X-Received: by 2002:a17:902:bb97:b029:e3:99a6:741d with SMTP id m23-20020a170902bb97b02900e399a6741dmr18022555pls.48.1614646235564;
        Mon, 01 Mar 2021 16:50:35 -0800 (PST)
Received: from google.com ([2409:10:2e40:5100:d5d7:1a61:2cdf:273c])
        by smtp.gmail.com with ESMTPSA id j26sm18155895pfa.35.2021.03.01.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 16:50:35 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:50:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v4l-compliance: re-introduce NON_COHERENT and cache
 hints tests
Message-ID: <YD2L1sbDikrTt9Qx@google.com>
References: <20210302004624.31294-1-senozhatsky@chromium.org>
 <20210302004922.32052-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302004922.32052-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/02 09:49), Sergey Senozhatsky wrote:
> This returns back non-coherent (previously known as NON_COHERENT)
							^^^
							NON_CONSISTENT...

> memory flag and buffer cache management hints testing (for VB2_MEMORY_MMAP
> buffers).
