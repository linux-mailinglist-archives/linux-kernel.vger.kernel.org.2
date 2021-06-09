Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A53A1199
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhFIKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234736AbhFIKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3O034lC9XVT1tHLr7bzKUshMkaUGECTxo1+ipe8YQ0I=;
        b=b5QxBd/6a3YhM0SSaYuZpa6ZymdSO5p/j5igxt2XnPdtgEkInK9Yt4zrkjo79OFPSHt6k9
        7DEjXg3CgAQd6jaTr/BgnD78wKaIbOWMMrF4n7bO0R13vklwE/7Dxhxh8N3C8c02XfpTWi
        xVS0BgPG3bN4Jr2iB0MsC+4+rqcMpmw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-l-DOUjXzOtGUZBNKxVrnDA-1; Wed, 09 Jun 2021 06:51:43 -0400
X-MC-Unique: l-DOUjXzOtGUZBNKxVrnDA-1
Received: by mail-wr1-f71.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so10522324wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O034lC9XVT1tHLr7bzKUshMkaUGECTxo1+ipe8YQ0I=;
        b=KkSkO3Q1sOadB5icRPe/QbIUodCD4DFqk+NCQOE2LUkTKHcrbt2LytDhguFB7uU/aC
         2YkWwp0phRg/b8tm48M3JF4h8PoZjE591zw0V/CfzDWA7JFAEU3aopDOEcw1t4KkQNEc
         SNCnf0G/lEawSHSNSIbHKZwdiOQLfITj8hr2huDIXivaYzRt9JMJSkRW8ecJrSynvRGS
         Le8MqWeFcI8aTEvIsBuJ0DoCi/OevHxpbzEJNMP83JQFS2Ok+CEFzjtKCDUPaQF9uBN9
         K/FbP87Z21ZlDN8s6EhjDoR7PbUI/9RlQKsq/eF2MbawIFJwGpV/GBXECQDg3syq9AYY
         1t8Q==
X-Gm-Message-State: AOAM533k6InHysrCSrsaRjxT6u9HqsRuOer+bHLSc1okgKKP/yc8B70B
        5fOi/fCUnqa2oXkisuHlnLKg98CuHjzpYtxIq9+X+kdK/OMGx38FfHoPbUfQ5mbrky7won1h1B0
        hcduKtDbO8EztTvgzlied4yhJ7NSRbaI49nbz34HF
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr28687488wrs.361.1623235902149;
        Wed, 09 Jun 2021 03:51:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFUVH4RJ8l7mW7Wdi2mAODQQWJJNufTytgE5ne0NwBsUZTSEThQDObeBpv3G+IgXE8n9iyWpYuvMruDn6AcCA=
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr28687476wrs.361.1623235901974;
 Wed, 09 Jun 2021 03:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210608031244.2822705-1-libaokun1@huawei.com>
In-Reply-To: <20210608031244.2822705-1-libaokun1@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Jun 2021 12:51:30 +0200
Message-ID: <CAHc6FU7yT48KaRrQt-1jn=8Cwvu9XUjfQNJC0es5cUN91Y_D=A@mail.gmail.com>
Subject: Re: [PATCH -next] gfs2: Use list_move_tail instead of list_del/list_add_tail
To:     Baokun Li <libaokun1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        cluster-devel <cluster-devel@redhat.com>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 5:23 AM Baokun Li <libaokun1@huawei.com> wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().

Thanks, I'll add that to for-next.

Andreas

