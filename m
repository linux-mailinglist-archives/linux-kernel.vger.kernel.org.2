Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF73FF99E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhICEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:40:52 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:37199 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhICEkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:40:51 -0400
Date:   Fri, 03 Sep 2021 04:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630643988;
        bh=truw8BJZrdELtT65gz6fieFBGdARQ7KGnKSO9u0dCtk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=FVO1pxpUfZn0XqXggBQp4TokXkhMemIvcI9j1goMitgIoZrsY+KgqnIBW+2beYKcZ
         Zg5iJ7QkDwXryf665O0LobrJZesYIG3SIGPPFM5TT3l3zcXr2XsT37V2RB1+1MHZ+o
         jW0NMj2/akAVyiXR1pO94SShSNiXQq7Bb78cUn08=
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7v file/swap crypto package
Message-ID: <PQplWSwNm79Lk3NFH1VY9N9KAzVUf5MPJ9JyTZ5FE-oqsUB7ZKQzBi4feLDgmWSZMLz8iEbt8JgdBaPfe8eyZ-mOy07SnR6Z1lYBo-llPKI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.14 kernels

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7v.tar.bz2
    md5sum 7fcc61e4b37f62aff5f3bd53d87b6fbd

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7v.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

