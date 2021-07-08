Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6343BF7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGHKHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhGHKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:07:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:05:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a6so7532621ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4fhY/yLoZMmhCqnp0rYwJfbvJ3m+VsDi3PuO02Dh10=;
        b=UYLH/VW8SI7ZogoX7fR4NWP4DRGl1d62SfimYKsYGCETDopjoL/y+RsptFQTSoByGW
         q+sENfaHQCddz+goHWQTbvBYRlZpPNGTD+hwSbScS+9stYayGZQXolfj/woo+NmCRBFa
         jGhhZ2GepPegJFGXuvZ83xSc31slF8PwiWyq/CFpd9Wkx+YE6ESZv0Bd/Zg2Bn1QN4L3
         XlwQ5Gw1bepr7GNdQBbKm28jDLcSJf11PX8aOk5pdKA+hC4hLLRMYbVPpSJHXz2ar6DR
         UDOSQX01Z+z/FHqmL6RR7vDsF7HIoczBZVtLjl/NWXDfF8VnYSiP+1906qUiWuzmA55S
         3mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4fhY/yLoZMmhCqnp0rYwJfbvJ3m+VsDi3PuO02Dh10=;
        b=Bz3VQg2WQBSua+29TXPpgNGNN0n6QUKDNLc+u/Kqv7ZGygmhhIo3ZJ9BFBUZLmShvU
         bofB67a8yFVuVZoV/BEwGCihnaHan0+Y4IaJtKYNJlnFLs2k5Sf/0JKrkHwNITx4aKil
         rOsCMVWMB9x6ImOfUNQolTBL9YUaw8a4iCng86RrgbTG7LugOE4FH9WJNuv4AvBjXP2A
         JOOoLy5o1uDaxjbX6IZiiEsYDtvnep68tz+BmJDD/2AKp1Vms39hSkmOHHd2IOyyDsnp
         wFPbgZKAXO3SoHmagEPu2fharMYHhpQC+P+Pw8FcxfaBowCCzwu0/aaYktycj/Bn2gi8
         HQWg==
X-Gm-Message-State: AOAM533NQUziLziRJJ92QV7i9pKXwQ+9Z4LMt5wtKa8UXxQETbOZHttv
        kldZ0sdQgIWMCdxlAzrK8SXbEt/1f25c2YVm9hZ7iQ==
X-Google-Smtp-Source: ABdhPJxdKSoYDqcwBIX1WQ4+fbUqa84UqW8rvefJuvTTO1vwGh4lLoujDgkp/mZyijH1oUQhvQsnJcYa+CxvYJZElwI=
X-Received: by 2002:a02:9402:: with SMTP id a2mr26130879jai.110.1625738705769;
 Thu, 08 Jul 2021 03:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210707062157.21176-1-yunfei.dong@mediatek.com> <20210707062157.21176-5-yunfei.dong@mediatek.com>
In-Reply-To: <20210707062157.21176-5-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 8 Jul 2021 18:04:54 +0800
Message-ID: <CA+Px+wWQREny2KSjDfgdnMvk8GKKqr+QvRdSR8YXc1i73wbJSQ@mail.gmail.com>
Subject: Re: [PATCH v1, 04/14] dt-bindings: media: mtk-vcodec: Separate video
 encoder and decoder dt-bindings
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
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:22 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>  .../media/mediatek-vcodec-decoder.txt         | 169 ++++++++++++++++++
>  .../media/mediatek-vcodec-encoder.txt         |  73 ++++++++
>  2 files changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-vcodec-decoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-vcodec-encoder.txt
The patch is weird.  Its title says "separate" but the changes are all
creating new content.

Would expect the patch to remove content from some files (e.g.
Documentation/devicetree/bindings/media/mediatek-vcodec.txt) and
separate into 2 files.

Also would expect the patch is a refactor which shouldn't introduce
any new things.
