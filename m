Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE244BEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhKJKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhKJKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:33:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D408C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v20so2609213plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H97nPqB7O+Ha49bdQqeIeu5pMRHp/3DE9p9icaUgqM=;
        b=PUuEyw9XBots469I4b/mSNfuAjfpd7qQMzH59EqV6M8zrGuW5q/CfOy/XJM/r7hsaF
         ndro4ZRi2k2UFXbYR7Y2TD+wsPKHpZaqWMHSaQC5u0vRq/R4W4M75LnQ6wwHqTSRhgjA
         gNhSq0Dc8jWZWpqCIgVAsX8h+/O3mbrRqDeGIUv2lwZ2U3bRdIAyjPOH7bVnTrFrFM5/
         FjN72YqxEMlv/SAj8JL4+P+sZFmb9ZhnqE0y/Dg5uFA/hcBKG1196tdQW2bAJXYHe/fz
         wZWqGkamOre8skZ1KLmAgmEvyTB8aiEzTVhVd5dmXMR4WSLYYi9i0jUTIq125egaczwZ
         gM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H97nPqB7O+Ha49bdQqeIeu5pMRHp/3DE9p9icaUgqM=;
        b=YuHw7nREDcIr02cPtU6COoPwISbh/ytmdZA0Bfy/zKKMBFZTdHp0ChJQuywXOYq0dW
         hEPXZqBS9m6ebgjrMnH5OBjbvS9TNZ8GFQP4TxUk4STFMhr7t/Yn+bWwmRTvkkJI1+0q
         MVSDoFEMPmOChRnrynVChlnJ8KIOwdsZKvwKGk/zjrEwdBbja5Ea+HHhBbxCCKvf26+f
         o7u3Fv//VUpXhrH6kQm6g+6c5MDzUdMqXhHRzsgmOjZZO2/p+UfsXfl2OpX3TTOQ/m23
         V3pRNuu8/rrui5e621BhaOkbtdmj3FEiZRLc6vpm+l64itEtwXxOsTZFGbCV8zJzXWa1
         Z1Pg==
X-Gm-Message-State: AOAM530NdDf7A1M22ErUx2Ho1tgW7stVAa4e5RhwCxFwfV71GmaBhXA/
        WEnRdM15bOG153j7foFPf0TNVHeM+oIMYh/M4wV5Pw==
X-Google-Smtp-Source: ABdhPJz1qeQBdRPNXYe0xOwKF+EIkcWuZ9iABV9TtnSScZMDJCzYb6hg0DTj4FGiTtJpUHr1yfmX7QThpigva/yBGZE=
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr15543616pjb.30.1636540217454;
 Wed, 10 Nov 2021 02:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20211109125030.26299-1-yunfei.dong@mediatek.com> <20211109125030.26299-5-yunfei.dong@mediatek.com>
In-Reply-To: <20211109125030.26299-5-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 10 Nov 2021 18:30:06 +0800
Message-ID: <CA+Px+wU6iwjisS1_Mdxdt6eb4pjLQp_Z16bA_ewEhCe80worKw@mail.gmail.com>
Subject: Re: [PATCH v9, 04/19] media: mtk-vcodec: Build decoder pm file as module
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

On Tue, Nov 09, 2021 at 08:50:15PM +0800, Yunfei Dong wrote:
> Need to build decoder pm file as module for main device
> and subdev use the same pm interface.

Why does it need to be a module?  Could you provide more explanation
in the commit message?  For example, any compile errors under some
circumstances?
