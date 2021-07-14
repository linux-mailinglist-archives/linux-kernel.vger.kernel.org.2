Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FDA3C93FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGNWsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGNWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:48:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:45:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn5so5399590ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZY1MuucrPtSmSp30OAQiYqQAOnsQCoU9oTNEDnDA2c=;
        b=kR7bqFDg5swVOvJGwGKJAKZpmRG8WEVb7WX8p8aUJH2GLKjUGvyXzOPI67BUGEhaR+
         kEhqtVlVnFgNIpjMym1ZBneUelCELU/v43djuxMRgQ32Z3SxwdZ0YsvKR/NPXIR5j/yL
         pBQvn+1zBRt6Qk/mWx8T9NSEZ5IxZNo9KWMkwPBnmw1+4qrk1iuUhMG8sBxara0JAAXh
         QQYN4kbyi6XvD+XycCHZCRjJJfXi3WKSdSPmgHVrIh6YjVNqQk8jHNuzmO47bgnSLBu9
         vCSveCyyMLYLU/b2W00xx41wPNQ3e7a7IE++nBE2EpOeemD8xG8saX0TTM6NAv6o4sSy
         6f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZY1MuucrPtSmSp30OAQiYqQAOnsQCoU9oTNEDnDA2c=;
        b=PC33sRCJnWMgDAted0f99eLZpD9GpsXBcfyRrSS0RrqKML3oHlEGemktq/8RbW32kb
         NfqrvBmn788b0Pk3R0Mnny4nia9o5v2K0vL4wiKnECumSOWACX8CKFRirv4XMH8djnYT
         lNzxb+8d+8RmItrGpoEFYP8m1bpY+yUb3qSmr930/U3tsX9+0MeVDY8bqo0jPd/nLxaR
         8wt2WOSxUqi1IuDxrm9Wt1CRDH7U10ygfK0MATSBn4afCnS94Wrf8G/FaOksgPHtH647
         vZLELLsUCXn64ItYKU2zbZKiSq4jS74UJ3RPofjv25TTirX5NgesIQhSF0p2D60+tIQK
         rLxg==
X-Gm-Message-State: AOAM533B6NXLjYON40ab8yXGEWPOfzLR+juxbipsJHX61xp43dMuhejQ
        F8Ehsimir1gkBCwo8t0xZ2yr6qsKl59IjYcrNCPyhA==
X-Google-Smtp-Source: ABdhPJzQQmKwrYEowCzDGnEbtSR4Nzl53qXWclJ23SGLzmPTEsbmXHiK8oAw3gtNqbTVm8GJLWF635Cnsj2CYWkuYhI=
X-Received: by 2002:a05:651c:308:: with SMTP id a8mr140735ljp.337.1626302745344;
 Wed, 14 Jul 2021 15:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210714073501.133736-1-haiyue.wang@intel.com>
In-Reply-To: <20210714073501.133736-1-haiyue.wang@intel.com>
From:   Catherine Sullivan <csully@google.com>
Date:   Wed, 14 Jul 2021 15:45:09 -0700
Message-ID: <CAH_-1qzu_X26sUehY9721+yG3xYVw_0eiPGb=0X4p0m7Jv+ddg@mail.gmail.com>
Subject: Re: [PATCH v1] gve: fix the wrong AdminQ buffer overflow check
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     netdev@vger.kernel.org, Sagi Shahar <sagis@google.com>,
        Jon Olson <jonolson@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Awogbemila <awogbemila@google.com>,
        Yangchun Fu <yangchun@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Bailey Forrest <bcf@google.com>, Kuo Zhao <kuozhao@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 12:58 AM Haiyue Wang <haiyue.wang@intel.com> wrote:
>
> The 'tail' pointer is also free-running count, so it needs to be masked
> as 'adminq_prod_cnt' does, to become an index value of AdminQ buffer.
>
> Fixes: 5cdad90de62c ("gve: Batch AQ commands for creating and destroying queues.")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>

Reviewed-by: Catherine Sullivan <csully@google.com>

> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 5bb56b454541..f089d33dd48e 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -322,7 +322,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
>         tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
>
>         // Check if next command will overflow the buffer.
> -       if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) == tail) {
> +       if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) ==
> +           (tail & priv->adminq_mask)) {
>                 int err;
>
>                 // Flush existing commands to make room.
> @@ -332,7 +333,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
>
>                 // Retry.
>                 tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
> -               if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) == tail) {
> +               if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) ==
> +                   (tail & priv->adminq_mask)) {
>                         // This should never happen. We just flushed the
>                         // command queue so there should be enough space.
>                         return -ENOMEM;
> --
> 2.32.0
>

Thanks!
