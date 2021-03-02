Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89F32A196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbhCBGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835225AbhCBEvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 23:51:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B6AC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 20:42:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id jx13so1089091pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 20:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xF+Ezsij9zQCVu5h7a22TZ4ku00IR7pz2OTflYnhmwU=;
        b=hQcoTJylr8uj/s8ZCFM1eS7eB8f4ZOS9Hop2JUukAqc04z884Dgo5/IRAlLiTMFYVu
         617uAiBaM2J7NKgCe3I6g1oMA9n+Ci1ER2vkXuXiBeseeUXNaJfD5wpKvu1UFa+OY0+T
         6DN9VLnCO63T+VjC2NZQp5LDYg/Dr0qoZWy7db1T3SBCG9yLBLCRyRfn0zW9KKOMAYaN
         1lb43IqfwyLg71GU68SegFm/D4WUjqEBJ4ncO8HtmmSfuv5tsUm/XxjOHHVTrluH1W4S
         ZAYQR3riq7RBRYavQ7DtzZYVS+fRxKbVZc0ZAWq+cExWaCnnSNYzNsKoo9McM+u2xWu7
         xk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xF+Ezsij9zQCVu5h7a22TZ4ku00IR7pz2OTflYnhmwU=;
        b=NRLYbUJ52+vsvkFGLSslVzjhJu5WmBdjBCkk5Y9TY3t+w5lc4DYJIfGGY78GufH63+
         qWQo7CibdxJ6Me2RnBl5m2KEc8IkyNNKh2pT6ruklKT/frW7a2Vo9DciIMcXyZ1OzkJK
         FNz30sEwSXq/iTsO16z55hVfuw3nl+yhRA6hTehAXOTjRoKERatHjXTm3VpMHJns1kI8
         pDmFJlXJ3JauSeO4F83EUrYvQcAl3cj/92DZ+DnSWgoycFXWtIIKYxobw3FM+abbEwiI
         pgcjrnUGUbWlZMRXdChj9wKZIvpIgMsvl93d+MRpMHZAdSXYPQLociYymjo57+6XKb5Q
         yC/Q==
X-Gm-Message-State: AOAM5314dRhwDCxFpk/KihY8gvjPErpfJKItE4xN8mDglIVqayoFP12e
        iTMQt7YZ2FITZpwg9gNK+yDtXQ==
X-Google-Smtp-Source: ABdhPJya7uA12iC0Raf6kjv1P0Uf/2aB9kBbZzyLJ0JzMUoKW88aHclbV1V3VWkzCBNmepcUFSHDBw==
X-Received: by 2002:a17:902:7c83:b029:e2:b157:e25c with SMTP id y3-20020a1709027c83b02900e2b157e25cmr18870886pll.32.1614660136885;
        Mon, 01 Mar 2021 20:42:16 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id z8sm1204224pjd.0.2021.03.01.20.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 20:42:16 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:12:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, wsa@kernel.org,
        jasowang@redhat.com, wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210302044214.gnnce5ptwehrsnpc@vireshk-i7>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-21, 14:41, Jie Deng wrote:
> +static int virtio_i2c_send_reqs(struct virtqueue *vq,
> +				struct virtio_i2c_req *reqs,
> +				struct i2c_msg *msgs, int nr)
> +{
> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	int i, outcnt, incnt, err = 0;
> +	u8 *buf;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (!msgs[i].len)
> +			break;
> +
> +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);

And this won't work for 10 bit addressing right? Don't we support that
in kernel ?

From Spec:

\begin{tabular}{ |l||l|l|l|l|l|l|l|l|l|l|l|l|l|l|l|l| }
\hline
Bits           & 15 & 14 & 13 & 12 & 11 & 10 & 9  & 8  & 7  & 6  & 5  & 4  & 3  & 2  & 1  & 0 \\
\hline
7-bit address  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 0 \\
\hline
10-bit address & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 1  & 1  & 1  & 1  & 0  & A9 & A8 & 0 \\
\hline
\end{tabular}

-- 
viresh
