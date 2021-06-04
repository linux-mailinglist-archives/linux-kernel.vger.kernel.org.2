Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659DB39B7C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFDLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhFDLVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622805576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEMgaoLeL6tcvz8xfcXaMYclNBrnP/Gg/ldLfLwkX5k=;
        b=Hdi2lYqniitO/wNDcjiebH8TIqYFhm8G13AzDnis+z1bClmp+TneQdExIntVIPge9aNCi1
        bINwVhG5RS33QhQQFMFZp/rsMImcwmnZN9r7+2Q9ZFe0y5jmLWLhu4tk0n29evgtYiknfb
        lbg8rfYgEzhepLces0hGSbSSZUb5ths=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-3AVXvfl9NSe24Yf2VXUuqQ-1; Fri, 04 Jun 2021 07:19:35 -0400
X-MC-Unique: 3AVXvfl9NSe24Yf2VXUuqQ-1
Received: by mail-il1-f198.google.com with SMTP id d7-20020a056e020c07b02901d77a47ab82so6163663ile.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wEMgaoLeL6tcvz8xfcXaMYclNBrnP/Gg/ldLfLwkX5k=;
        b=amr+HKXpHptyxEzQz6buRvOqo08wMaEMqvG9MLfHkD5jGUJ1Jep7ur+/e06S7xFcNP
         72EY1shwCda4T+ng3zJyJfVN6io/exOo0DWUt127gU0AWXvztmMkrrncawdyRlyXEhDv
         RQysy/zYCMP125/rgsPU+/GloH82b52vZKugRfa4e+IUoEQojIhDFe2pJJtK72gyN4X6
         n+cnybFIhG8LUjJLhW+WUuSKohacPgYbyDfpwyrM849dFSxzJjE69ES3OF2esj+0Ss7T
         KqykYYrZXUm/Mrp2c/uv/T/XOcnVsK4I5mXFMEnm6c3BjKte7qgbkyzK66JorWVwYu/f
         Hulg==
X-Gm-Message-State: AOAM532scXvnw8RKG41vhtIfetU36uYYd0x9mG2E/m42+oPMurpe8d44
        CdAJaLSvXeWA5tOLTFgVPr8XzeHsA7SpSrdC3C3j0NhcaR4QCdcGhyEUzJiSu9m+E+EO71Kn1SN
        9k/FrK4xxRNgZ13ToLrnMgrUI8H13UqsbN5fZGC6G
X-Received: by 2002:a92:ce45:: with SMTP id a5mr1296344ilr.173.1622805574646;
        Fri, 04 Jun 2021 04:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSCuGCc+ls84G/wdEtzgp1+rIGRW2rppNSQVthsvLpqCJlAFDBGigeXmp/uivXjtB2Q55nDCYfmjLBE/qVVxY=
X-Received: by 2002:a92:ce45:: with SMTP id a5mr1296324ilr.173.1622805574448;
 Fri, 04 Jun 2021 04:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210603063430.6613-1-ihuguet@redhat.com> <20210603074419.2930-1-hdanton@sina.com>
 <CACT4oudUd2YuV=GFhz1asvwX8h_mGtqzjZygBD26Tj98cxfCpw@mail.gmail.com> <20210604031450.3039-1-hdanton@sina.com>
In-Reply-To: <20210604031450.3039-1-hdanton@sina.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 4 Jun 2021 13:19:23 +0200
Message-ID: <CACT4ouccprqnx_Dt4dk8SvFrdW9OmnyRxC9KAM7q6n7925umHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net:cxgb3: replace tasklets with works
To:     Hillf Danton <hdanton@sina.com>
Cc:     rajur@chelsio.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 5:15 AM Hillf Danton <hdanton@sina.com> wrote:
> Good material to be shoehorned into commit message though without sheding
> any light first on the reasons why CTRL is so special its work wont bothe=
r
> being canceled.

Not sure what you mean. If it's that CTRL work isn't being cancelled,
but OFLD is being cancelled twice, thanks for pointing it. I'm sending
a new patch.

> How long? Long enough for the kworker to become a CPU hog?
> What is it in your opinion to cut the chance for that risk?

I don't think so, not by its own, but the maybe yes the sum of many
tasks in softirq context (it will depend on what else is being
executed in the system). As far as I know, moving work from softirq to
threads to reduce latencies is seen as a good thing, unless it's
really necessary.
--=20
=C3=8D=C3=B1igo Huguet

