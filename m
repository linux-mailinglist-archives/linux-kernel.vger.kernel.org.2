Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA04452DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhKPJ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhKPJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:27:11 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA2C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:24:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id o14so16868779plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owaydA/9dfzXygkoQ9b5wC+OlGrAMOC9LEkh/lAzv5I=;
        b=QMKycX4ZEQaoqQ026VxDUHwe+VqargI4Q56Ls7vof5Ssrt3G/nOSh2dyyoY6Cw02WF
         iFzhEy4rRt7z1+q0UupwntE3f0SNtv/+2FFKLmpIe9QX6rPKknymUxkADWNvKQ7UfQoc
         1I+c/UYXvuoyS+f9aI27LrnNpGTn7VKPJ8jKnYU2ns2Bw6y6Flc8J9w3nG/EkE/0nBxQ
         1+dMPFwBSyZHN3e+ZgOKTxa/qv2dqzO5wdeh7W8mVlHoAVUajMA1qeQ5HmOsWq9+NqOU
         iYO/LWu6lF15XzeRug5Q37kFz1sFMP942j6nzvnuqZqElH7Gy8dqO6Rusxak5WLORwOX
         nZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owaydA/9dfzXygkoQ9b5wC+OlGrAMOC9LEkh/lAzv5I=;
        b=Pj/OOtNVYQslQCW1e80PbTO9KtYB6B/6uHld/0ew5IBmr9FfTpheS4yV9w0NgjfYye
         D7Jp/AUPJkrNlsuZsRb99j5CVxQmxCPhPe3mLkY29ouA9+BuisVEMU33uYpvm0oziTiy
         KVtd7NTycVD5Y64o8GKhzrD/3VL6B5t8Rnu02zPOgIaWtJKA9I9BlNWOpa6SYfFPacSp
         EAahAzVXzyNURcg82BmYNwTiiXjYjGLQXX7VRLYefgWFRxuWudEIMbL3BsDr1Oh/pxqy
         dRluQTpAVeWJlgk56CjkAlmYfK7M5AYKvcNuLRzzsFHJnRLdhjom8lnwdBWxeyQJwnYk
         B1TQ==
X-Gm-Message-State: AOAM530WALWabYp3jmhzVDyLOPjKeGyV0JhI5b1fg4arNqAOqGhuk/zt
        lEt11prCU2GLdJDRruRX7xaQ/w==
X-Google-Smtp-Source: ABdhPJw4Q0VPOvcNLCMaHO78tfO9Z0o0vrEmI1ogL6v9qranzZOGcmxPrHs+6HbKgj/geyrRdmBzNA==
X-Received: by 2002:a17:90a:9907:: with SMTP id b7mr71543402pjp.137.1637054646807;
        Tue, 16 Nov 2021 01:24:06 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:f590:685a:7893:90be])
        by smtp.gmail.com with ESMTPSA id d2sm12436413pfu.203.2021.11.16.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:24:06 -0800 (PST)
Date:   Tue, 16 Nov 2021 17:24:01 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v10, 11/19] media: mtk-vcodec: Generalize power and clock
 on/off interfaces
Message-ID: <YZN4se+Ihm2H20GG@google.com>
References: <20211111041500.17363-1-yunfei.dong@mediatek.com>
 <20211111041500.17363-12-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111041500.17363-12-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:14:52PM +0800, Yunfei Dong wrote:
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
[...]
> +void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
>  {
[...]
> +
> +	if (dev->subdev_dev[hw_idx])
> +		return dev->subdev_dev[hw_idx];
> +
> +	node = dev->subdev_node[hw_idx];
> +	if (!node) {
> +		mtk_v4l2_err("Get lat node fail:%d", hw_idx);
> +		return NULL;
> +	}
> +
> +	hw_pdev = of_find_device_by_node(node);
> +	of_node_put(node);

Raised the question in [v10,06/19] media: mtk-vcodec: Manage multi hardware information[1], is the reference count borrowed from mtk_vcodec_subdev_device_check?  If so, it needs comments for documentation.

[1]: https://patchwork.linuxtv.org/project/linux-media/patch/20211111041500.17363-7-yunfei.dong@mediatek.com/
