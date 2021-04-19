Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6F3638F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhDSBCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhDSBCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:02:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986AEC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 18:02:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id h13so15710019qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=RXam8/yrKFBoz2nKLPMW+gAL4t/Dm8FLDbdkvQGBxIs=;
        b=H6S169QP79gGhsQKKA2kKXR+4q+a+T0r3ZkwWZ/s+14xnmPs5QDOFVz4mD+J+qqpyf
         /Bgugt+pTV0U1sQghwysF/aGYIzHJf/47HLCo/H5j52pbR+qPQP32lEkc6lblm/PRfkY
         TrlNUyyzRwv3tjOW6CVfsBqRUWD4PpYySlLnpAASTqhBjiVGWDvw0yuPTRJwnjK86J9w
         Sxp4D0M8JJQi901u3BMMhyux/Fb+z7ShsIstoFg908XPswgo45+y3tRalrqGznLSaEAd
         gCwOK7GPWZgsMbpu6KLZojWlysgEpkO+xe/lhkLauO4ZlQ8w6akiF1DBAHPakaaI25RC
         k/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=RXam8/yrKFBoz2nKLPMW+gAL4t/Dm8FLDbdkvQGBxIs=;
        b=mYQ+5Peozv3/VCVM/6x4lI1N2g8xm8LWeD110T+sD3SmJMu+O4mFxYS6Q0A5vxFKj0
         G0Z1v2lMdxTckKIfC+2dIeia/kme57Wy0R1CQchSKNkja4BOdgUIL0a/HagnZHLWK8Ex
         9+dLftx4jsYPoKgghQZwYLr0fFgUTkeltUtursTD8DjsgXaLByLPWS3OlUGZeBTYZgrO
         sWE46QJSGjZUlGD+olpNNK+1lgc2gqdHW0+k6nvD79XghQY/S6b6sWwQuujoBmlALz8p
         pwh36ro60zRTxoP+iWeNC4w/EGSfnJv0yYXmtEPjjiNfzXeTq4KMpIyKjEykvDOz/i7z
         fpbg==
X-Gm-Message-State: AOAM532noYnc3ew0CA1OGH3RZBrQoDn6ErHo8hTirah7VvQwHg6uz9VU
        HaJSRIVSKyFka9RWtGzT4yDFRg==
X-Google-Smtp-Source: ABdhPJy0Kau8aXbq90XTNnBOjhUdqhQzEs89RasWQd28uDmQRXyvdq30ubbRcFkERw/LLHo9M3Q+pg==
X-Received: by 2002:a37:e30c:: with SMTP id y12mr9437334qki.244.1618794134634;
        Sun, 18 Apr 2021 18:02:14 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id f8sm676599qkh.83.2021.04.18.18.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 18:02:14 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Felix Fietkau <nbd@nbd.name>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mediatek/mtk_ppe_offload.c - suspicious code?
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1618794132_13593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 18 Apr 2021 21:02:12 -0400
Message-ID: <526789.1618794132@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1618794132_13593P
Content-Type: text/plain; charset=us-ascii

While doing some code auditing for -Woverride_init, I spotted some questionable code

commit 502e84e2382d92654a2ecbc52cdbdb5a11cdcec7
Author: Felix Fietkau <nbd@nbd.name>
Date:   Wed Mar 24 02:30:54 2021 +0100

    net: ethernet: mtk_eth_soc: add flow offloading support

In drivers/net/ethernet/mediatek/mtk_ppe_offload.c:

+static const struct rhashtable_params mtk_flow_ht_params = {
+       .head_offset = offsetof(struct mtk_flow_entry, node),
+       .head_offset = offsetof(struct mtk_flow_entry, cookie),
+       .key_len = sizeof(unsigned long),
+       .automatic_shrinking = true,
+};

What's intended for head_offset here?

Christoph:  This was the only actual questionable code caught by override-init
across allmodconfig builds of arm, arm64, and x86_64. The other 218 warnings
not already silenced by Makefile twiddling of CFLAGS are all legitimate. I
admit not being sure what that means for its use in W=1 builds in general.


--==_Exmh_1618794132_13593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYHzWlAdmEQWDXROgAQKBMRAArsoGj4sOoT0DAvTbdQb1ePhTUDMRptuS
rjlchzSFgPmnVRcZA7uHfMclr06Sv4Z7x3YUi1B9EoVpCJ7636ZVvYH4C1moc6bc
u6bwTdsS1BfpbDy7UJB3J+81f6TvsajnNMaTVvJKyX83zoCw64gkozaoaKRTlLfo
bC2WoqTVqSyfSKWx4k3dC22A6U5FnFhmxulr3FAhbd6gg50LqWn4zA8lpILIpAMW
XIRZMHPDqCQ4HLck6lRj4Toj1KUYKA6c9nWr31zHCd+yBwDGB479jNc578gSHYL9
OJ4z7Kb/S/fIMilkNrjo36qqmiW5XS/vW55GDSpq0yhLzlSdwrQbhd33x/+y9w11
GgLRSSSL5W7JDpGaUcOJkV9j5vAVG6AB+3j60RdzR9rDF59L/jnCp++lilrcsW3a
A9iyYczjbT3s0DwZmwC1NTk3L/Sq0T27wAKgojgacJ1eNGVRZy/njR2tFfwTqord
j/5MDKBdB7oNzuvmVuJG4+m//ModL/oPC9vx8nZJgZiS4JpfIwHXDlZdPwZlR8lC
SAl5LHU+5GD4EN4ZjoCn2Ocl0veShZoKYr9TQXXWPg3W5uKCoFioWqO+wIeL0mop
5nu6OAf1KvGq3KmP/dqBA9GElv3GaUkf75kRoK8gED6rLjP+kqcThndQzGFQOo7E
GK82Pd1kWTM=
=YBHY
-----END PGP SIGNATURE-----

--==_Exmh_1618794132_13593P--
