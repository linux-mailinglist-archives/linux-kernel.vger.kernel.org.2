Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14823F6F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhHYGAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232442AbhHYGAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629871174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZq8ux83RWRAGT7dU7S94nIBykQroT633MHGxDAPovQ=;
        b=a91Zf2iAt/CNyQpw44Nx1QIWEk5odZ5GYQ1s8jK5JMmka94/yqBsfRvuIZ9yW7HmgWp+Xa
        rhBt4bvyjLBxRVK4cC2vrUTGocWCksRpeQqhq4zWj8g87U/YojRHNtyDA5cYOsKxu/4ttU
        CfUFo7EOEWNrRRYSeMg555TuWs/e2Gc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-flwWYNxcPIqeqd6Y9fJcqw-1; Wed, 25 Aug 2021 01:59:32 -0400
X-MC-Unique: flwWYNxcPIqeqd6Y9fJcqw-1
Received: by mail-yb1-f197.google.com with SMTP id e137-20020a25698f000000b0059b84c50006so3977599ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZq8ux83RWRAGT7dU7S94nIBykQroT633MHGxDAPovQ=;
        b=rdamfgYKLUTBr/jKDdJ7gbMxh9vHUvx9kNlzVrpwODO5IlXbj5+GodsHzopg2Yz2zp
         LOmNZKGX4xcZH+bchmO3yJ4v7aIFweZ9kNGJWDPVmfsyvFZgX0mXWn/x4R7PeF3icQcl
         UvNdYQKGqvgcj6PbQt5FlJJA41q+5J6PtAXQw0B0Opfm+NjSugSKzo9Aqk0mo424h5u9
         LSN/fFS+rrafT7BByEto0JeQr9x+j5ieHatI5pFl18EeySlqotR7G5kpc31YtVH2J1zC
         ShdWxV5kouiFdFKpY2/a+pI0u31rzqat3C4goEsps8aB1BJQuptYgFzRu3/DKu1JkXBl
         MOxg==
X-Gm-Message-State: AOAM5331dHR6gCSYKA/X9YJOwSWB1cN1u4vula+73O5AIJUK8rX4t7DQ
        Odueuxg507fCzNEGxrcYjIf/ICLYFaagMPz467bH1bhk1jvY8CF9gpGnMHeZ/91UPCxOnh5aR1e
        rpdCVC9pPooPzhMHiq12DS+2PHEcxlXWdPqa3r3+c
X-Received: by 2002:a25:cb11:: with SMTP id b17mr17075074ybg.438.1629871172167;
        Tue, 24 Aug 2021 22:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU6u2ecWhLicWmFg6FwEcsOJ/sHApqkz1nmY/9nb65gcMxPrdb8Dmgi6eXH0NLTjyMcu4XKdYt5m2iVC1FVJ0=
X-Received: by 2002:a25:cb11:: with SMTP id b17mr17075057ybg.438.1629871171995;
 Tue, 24 Aug 2021 22:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com>
 <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
 <20210819090510.GA12194@lst.de> <yt9dr1eph96a.fsf@linux.ibm.com>
 <20210819135308.GB3395@lst.de> <CAHj4cs-S7sTEMZ=zSreW5_PgQQVxvf-4netHy-paPR2kfY=-hQ@mail.gmail.com>
 <20210824072340.GA25108@lst.de>
In-Reply-To: <20210824072340.GA25108@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 25 Aug 2021 13:59:19 +0800
Message-ID: <CAHj4cs_Q=sL640Yb7C3=r-d4zfAPsfYT+xY5iGxd6vbyHczb2Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in wb_timer_fn
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 3:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Aug 21, 2021 at 03:48:01PM +0800, Yi Zhang wrote:
> > I also met similar issue with blktests, I tried to apply the patchset
> > but with no luck to apply them, any suggestions to fix it.
>
> Please just retests the latest for-5.15/block or for-next branch in
> Jens' tree.
>
Yeah, the issue was fixed with for-5.15/block

-- 
Best Regards,
  Yi Zhang

