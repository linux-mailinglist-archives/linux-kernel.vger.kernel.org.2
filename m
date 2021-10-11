Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55200428599
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhJKDdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhJKDdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633923110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DopLGzlmOB4HEdCaVkJ/RsYex88mvAawbRk2bHl6QL4=;
        b=YmObTnzmo8y5a9+HdqeMVJeqXB3tpBszqPkEd6WXj1Mx1EMrWYYfjhcMM7bmZ9EPhJfZ84
        IlkR0YinnJYTY7ttLzXbl8hDSIDyystEkEeDpKobE0BW2bbImGw1bXJ0nZeZfjKQ01T+g+
        boFijDgyXhnqFr5V2o4Jk7N/vD0T1U0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-zUqRE3QrPDWbAg2M-ZGVfQ-1; Sun, 10 Oct 2021 23:31:47 -0400
X-MC-Unique: zUqRE3QrPDWbAg2M-ZGVfQ-1
Received: by mail-lf1-f72.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so11586762lfv.18
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DopLGzlmOB4HEdCaVkJ/RsYex88mvAawbRk2bHl6QL4=;
        b=sGFGjP0oi6Znym5cOnCLa76OBkFc4ShAokaEmpQ+aQ4nvR4FCupekTCw43IR1A8Rks
         G1cJHgWBT62SM8ne+38cWPjQKJTC54L390mZD+ur+PbAT4mmVm1x6HNiZBa74zxCsXl4
         QgcM4HA1OljGShXo594w/iGe2ASyxawUIjEn/5pUpricJKpHqpjqoCLPYq388SYgd6L0
         tuBz0xcPiPKXx54e0zX11ORKAEtDGu53EpsvdoEypHjipcYtkFiUf39kdv+DfkYnh2vA
         xD2ssX2U4gMM93B5Ggs3PHXEVNxPW3Ur47Cva09uo30EKcVIrEmIKvoBpbp1Bk8RVSAn
         y0pw==
X-Gm-Message-State: AOAM531V6gvC8YWTwcneAmXrNtY4K9YJoZaH6Do6B7Aabh+p08smTAmT
        Ct2Gf6bjtWMIZlBOnBRj5d2frxuXXGZXfoia95PDaRKTlhIOE8woniByLhkGwax+vWVoy7n4AbZ
        lmvP+1srcDQFf+q7Kc+11I7ZnUfrwLxDlitIYy98v
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr25388727lfg.498.1633923106298;
        Sun, 10 Oct 2021 20:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYohr1FlcKG2NxgTdHVVMnCKaJn7rrf94S26N3UdjJfTh6R3wipgXYVNmB+4t0jp2WQTKZQ5h1Rb1nHWApW0c=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr25388719lfg.498.1633923106150;
 Sun, 10 Oct 2021 20:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211006202904.30241-1-rdunlap@infradead.org>
In-Reply-To: <20211006202904.30241-1-rdunlap@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Oct 2021 11:31:35 +0800
Message-ID: <CACGkMEvTdhD3GJfKJgb1pGSuxDNRPSFDFN12-zwAmB6=7E1OXw@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: fix documentation underline warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Xie Yongji <xieyongji@bytedance.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 4:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a VDUSE documentation build warning:
>
> Documentation/userspace-api/vduse.rst:21: WARNING: Title underline too short.
>
> Fixes: 7bc7f61897b6 ("Documentation: Add documentation for VDUSE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  Documentation/userspace-api/vduse.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-515-rc4.orig/Documentation/userspace-api/vduse.rst
> +++ lnx-515-rc4/Documentation/userspace-api/vduse.rst
> @@ -18,7 +18,7 @@ types can be added after the security is
>  is clarified or fixed in the future.
>
>  Create/Destroy VDUSE devices
> -------------------------
> +----------------------------
>
>  VDUSE devices are created as follows:
>
>

