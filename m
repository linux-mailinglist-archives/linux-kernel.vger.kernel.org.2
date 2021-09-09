Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED41F4059AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhIIOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232557AbhIIOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631199037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9JDbGLr6dkNUoEd0zlqfw7GomTfOIulFrb+2DtUYJA=;
        b=TK2t5IbPYZj/gw6KLztcMFceqfxMxjg53VpI+ZiHpHPPiiZwLxODHLE6m+GJbw7VhbHh4P
        oq0jYSUEZaHtFf1V4FtzL/d4QbRsxVWCl+LvZi1KUkt1NhAIWXqQoHQk/8bAifnKgjarqn
        +e1g95TSHpzS0XxVSzPRwCd6lVb2Y8I=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-n_6373_XMze3i20qtu_BsA-1; Thu, 09 Sep 2021 10:48:50 -0400
X-MC-Unique: n_6373_XMze3i20qtu_BsA-1
Received: by mail-io1-f71.google.com with SMTP id s22-20020a5e98160000b02905afde383110so2090638ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9JDbGLr6dkNUoEd0zlqfw7GomTfOIulFrb+2DtUYJA=;
        b=N69eJdo1GAInUH7mkcS/Q0LtK0JlWUCpmtuIiAs2OP1N2s3ZV/MJgfwH2hbxGC3Zhr
         H/4oiyHJ57YC/nnMrhSRLX47X5JPFJps64ogrOPvSgZ2Hz2BUTBY0pUjaEzXfG8ePMC8
         4Y0Vum42IQ1gA+lR3Jz1WDNJuWBtrkiFOLRCWZce2aZCP6g8DbFcfGzxbcrHEmiuzxA3
         FOSrQ1L6JGZ7UL2f9d/A9XNZjgxgODPGz/iaaccWrXvtB7SUflyqgkA6WqTAWhOX5I4u
         jns+4yUOhzUyGH95p4RBfBQ3vCZgglTnQWK6wkLoaB8BKX77M6qmo4DUYhrAa2FBW2uI
         av0Q==
X-Gm-Message-State: AOAM531AZTps/HwikJs75W9gzIpJ0b5ov8x15sVo2o7EjNyUx+SD/qXz
        Xfr4Y2xl71m70UdCZfmO2hjkw1dZ+GHCTxTw+RAgwG2eGVarIqiACcRslVr5vzgfqfabh/qo5Ma
        zZPLTes5nIYOxIbPP4ZcasrW8EUfJsA1BFk5uKqqS
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr2975590ioa.136.1631198929421;
        Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG1bHzR6MK4Ss51+mBC39dYSC8m50NMcEX5BeZwpBtCi4rKCrXEQfCjjQYKDJ4jPW6l0G3Uz+rBGHTewBW09Y=
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr2975576ioa.136.1631198929227;
 Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210909092846.18217-1-ihuguet@redhat.com> <5233eedf-42a7-f938-67cd-e7acc5f3bbce@gmail.com>
In-Reply-To: <5233eedf-42a7-f938-67cd-e7acc5f3bbce@gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 9 Sep 2021 16:48:38 +0200
Message-ID: <CACT4ouf64jvpjUcmfJ=hc0SjrSGYx4QFL0j6sEitMWi-kjp47A@mail.gmail.com>
Subject: Re: [PATCH net 0/2] sfc: fallback for lack of xdp tx queues
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     habetsm.xilinx@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:39 PM Edward Cree <ecree.xilinx@gmail.com> wrote:
> Patches LGTM, thanks for working on this.
>
> However, I would like to grumble a bit about process: firstly I would
>  have thought this was more net-next than net material.

I intended to send it for net-next, but by mistake I tagged it as net.
Sorry, my fault.

> Secondly and more importantly, I would really have liked to have had
>  more than 72 minutes to review this before it was applied.  Dave, I
>  realise you never sleep, but the rest of us occasionally have to :P

I go to sleep now too, or at least rest a bit  :-P
--=20
=C3=8D=C3=B1igo Huguet

