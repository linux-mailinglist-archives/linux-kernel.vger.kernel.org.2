Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAB342EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCTSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCTSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:23:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2762C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:23:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so9409202qto.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KflZSVgTpS2+TKlQgrI+ww945lAEKaRYx8nlRL+soGg=;
        b=tTIq+O4G530xK6ecJauGIXGr/uWGjSUteuw3ZnlDSp8BZ93adlNxjYX1ZMqbu7loqL
         EaJ65ok2gqStezEWE4//s6gM3QEGhZ8sZLDo603+lLyL9As566T+WVxNiM8PJI06Ljg1
         OhVsf+cP7klts/C2Zb89v/62Yp6+YiZ8uu0BGzYowZkWMxnvrnS4zJlpAyT4jmE7h4L+
         OL4t40RLsqyKPqKove+n7TaqcMOaKcXNO8LjkFMwjIXbHp/DvHAUv8zGCWRgS8C/MD5i
         w57zwWmw+ZKggAVtwaBW7ahQcggxFuUYU07nDvznf9nwJXkiDOQfLuaNM7/UUqSUVkiZ
         QgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=KflZSVgTpS2+TKlQgrI+ww945lAEKaRYx8nlRL+soGg=;
        b=hEaSrWVtLK06K27p9qW0nVLSXsiytKtnsxXeHcCHZ8FWgeUvnktfT1Gw1u/zSyKKAL
         ZEEk7NNk7cCJXErY+vWBMcUN6g1fH94m8H/phtYjKVMXli2S1jM6ZaiE2Tg2x0gTgdJf
         gu4ouNXd4WFF4lVJHEDeoervhZt1p2SQ10Fcpt2Frn5flUIYUyg3bSN9/hHjyMCRLusy
         V4/NrMhS9L3z7oGeUt/TSIOFNSDflOcqBlMRhkBY/x2Xc5/vdR0f82pItqcdNFvQn8ig
         p92W/KmTNpZdKeb+Unbc4oyLdbVDFXHrjk5pqonOFLcqlwf+JR/XFeuwNpCiOQzD5bdY
         szbQ==
X-Gm-Message-State: AOAM530osGZVnxINuXXlJuzOMoIcKUKOl29uBe4+48Un3yjrRLZATyG4
        /YAbPbsFfrlOyWBkkFmxDNR7bHnsFfX/pw==
X-Google-Smtp-Source: ABdhPJxxapBs5KqU6tjjNqkX0ImgvHsHFZVUo4VZ5xtf47YPI44gbYs3hxpQmOQGXHG46uTNagpE5Q==
X-Received: by 2002:ac8:4783:: with SMTP id k3mr3927830qtq.231.1616264611664;
        Sat, 20 Mar 2021 11:23:31 -0700 (PDT)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id j15sm6076361qtr.34.2021.03.20.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:23:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 20 Mar 2021 14:23:30 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Switch to new kerneldoc syntax for named
 variable macro argument
Message-ID: <YFY9ou51WGqA7/Lg@slm.duckdns.org>
References: <20210303191639.3108237-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303191639.3108237-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:16:38PM +0100, Jonathan Neuschäfer wrote:
> The syntax without dots is available since commit 43756e347f21
> ("scripts/kernel-doc: Add support for named variable macro arguments").
> 
> The same HTML output is produced with and without this patch.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: Tejun Heo <tj@kernel.org>

Can you re-send with trivial@kernel.org cc'd?

Thanks.

-- 
tejun
