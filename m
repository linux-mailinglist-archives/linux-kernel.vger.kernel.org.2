Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B644BE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKJKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:32:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC55C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:29:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u17so2584091plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSFvUJLaZR+mAVPFBcPx1oudAViqkL4IwyGNB8LdK80=;
        b=eZ9Whpt501+2K7l26U4wtjldeo6V0MKg+IPh8nJFxzg+klzAvlhvUlX5uL9FGT/dEK
         ojkFp0NnQHczMBoADFUXVAU/qQyUOXo+5+KLWMv8gABEsMPWVDyurFkliVDOH9YEvoc9
         4QebnxuMUulAfKSS2P7FsdGLV2EGOTowxGCKkcDVKp76t0Hu0boOwos3GlvDg48jOxzC
         cbtKSl55U8seclKFJsrrZiKepcOuv2XvwmCmExMnFSekL4Ejhh0VN6fddzdRVLdxzJJC
         zEScDfB9Uwz7QGYIXR5l60zIehXlOZNSan/aU1SZpgLVK3zo/GK1e31s8jAjTxx449DX
         1XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSFvUJLaZR+mAVPFBcPx1oudAViqkL4IwyGNB8LdK80=;
        b=VM6lj+EbP3AcPNJ+qN7n8/VuWlrNT3L+avVfhd2GFCe46/a89UXiPu/hWdaZsXXrxW
         IsVbrRy1PcGcQ454EQAjLcc/qFd7VFNZavorRx/0bU9ZBIZA+3X1m80xqLr6qbZZ4/+a
         l0LhBIBpZq/j5/OCSq3QU7tj9BaznUW4s3GFhaIERSybuTjVNq9w7cTrW8i7MkhTS92B
         SP6Qc5WsCLeoDkkl1zzQWNHvQ8+AElHLa+cXNTbU3a0FVmgVQAvzrTmSEePPT4JBndzp
         SRv1KIRF/0ttEbP2A2lKs/ceG5DvxW3r8Jo9/Gb30cedVzXzbtP1wJ/pVGkXXwbRWXSn
         0CBQ==
X-Gm-Message-State: AOAM533/NbzA2R3k9JT+F+iGcGdNGYZrHUTWjjCGN/+cHE+5aD1f2vZ8
        8eb6ccoKq1FTJnmpLMC5TVIFnrjBki2dlKTV63+XNQ==
X-Google-Smtp-Source: ABdhPJx+7Gq0bm/h5nRmAWFRad83G/chU5WO/BoJHnti7WjK4AP/ZWkCcRzV6CRZ8T8FumyHzs27HMxGy7nk1YEJlzM=
X-Received: by 2002:a17:902:7289:b0:142:805f:e2c with SMTP id
 d9-20020a170902728900b00142805f0e2cmr14239605pll.42.1636540196956; Wed, 10
 Nov 2021 02:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20211109125030.26299-1-yunfei.dong@mediatek.com> <20211109125030.26299-3-yunfei.dong@mediatek.com>
In-Reply-To: <20211109125030.26299-3-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 10 Nov 2021 18:29:45 +0800
Message-ID: <CA+Px+wWNg060xNcBSnu696OHPcp5Mqy=ovbAW_dtBTnoVXLMmg@mail.gmail.com>
Subject: Re: [PATCH v9, 02/19] media: mtk-vcodec: Align vcodec wake up
 interrupt interface
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 08:50:13PM +0800, Yunfei Dong wrote:
> Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

s/B/b/, the suggested tag name is "Reviewed-by"[1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
