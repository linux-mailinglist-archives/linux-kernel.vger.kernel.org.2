Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6643CA093
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGOOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhGOOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:24:35 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:21:42 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D8687B35AC9;
        Thu, 15 Jul 2021 16:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626358901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlgiOkZHXNEIEfSaNUhKVoHJLJHo0vEdnYWGRcJTLVg=;
        b=atQl93tNGGkJYXUalUq6dTShLQ02fCz+2Uz1rMv8IgGbVFofErY+X5nMClLN1Ak2PztfIu
        p5sdaqx5L+xSCGGx63OwdmG0o4VpU8CSvnkxdB1U+XE2uNOJAWzgUZwaCV9vHq9LqBuiI3
        TU5E0lilVrBCarvau3atvWe37ot+oQ0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date:   Thu, 15 Jul 2021 16:21:39 +0200
Message-ID: <18913178.CfhFyDH87r@natalenko.name>
In-Reply-To: <YPBD8z+yqC0ShjrZ@kroah.com>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPBD8z+yqC0ShjrZ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 15. =C4=8Dervence 2021 16:19:31 CEST Greg Kroah-Hartman wro=
te:
> Can you run 'git bisect' to find the offending patch?

Of course, as soon as I reproduce this reliably.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


