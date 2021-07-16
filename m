Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671C93CB21D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhGPF4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhGPF43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:56:29 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C62C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 22:53:34 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2AF0BB37293;
        Fri, 16 Jul 2021 07:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626414811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tld40cpEkGCNsmVNqC9ejnCY9hMvScB5LN5M3UpSOec=;
        b=NcYFQaS95iwX4RFWyB1v+WBBTnfwwBGtEj4uv6HRuluQnEjny4JbKehbhlsBUnLiB//Zkf
        vHU1h2JsFU4FZ3iXqR+I4fxnIrnWLqJ9IGoBjG7dZDrhM4hBaLWCEehKb4F/VKcjlvIIae
        r9kwMgMzBzTGcpqhOWraBJBan88gTz4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date:   Fri, 16 Jul 2021 07:53:28 +0200
Message-ID: <81322754.HEIg0oD171@natalenko.name>
In-Reply-To: <YPDr8ucoDCE4NBSe@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPDr8ucoDCE4NBSe@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=C3=A1tek 16. =C4=8Dervence 2021 4:16:18 CEST Ming Lei wrote:
> >  850     if (WARN_ON_ONCE(n !=3D segments)) {
>=20
> What is 'n' and 'segments'?

So, I used this change to check that:

```
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66973bb56305..0a64f2f77daf 100644
=2D-- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -847,7 +847,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *=
ns,=20
struct request *req,
 		n++;
 	}
=20
=2D	if (WARN_ON_ONCE(n !=3D segments)) {
+	if (unlikely(n !=3D segments)) {
+		pr_warn("nvme_setup_discard: n !=3D segments (%u !=3D %u)\n", n,=20
segments);
 		if (virt_to_page(range) =3D=3D ns->ctrl->discard_page)
 			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
 		else

```

and the result is:

```
nvme_setup_discard: n !=3D segments (3 !=3D 2)
nvme_setup_discard: n !=3D segments (12 !=3D 11)
```

(those are from different boots)

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


