Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6232410B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhBXPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:38:51 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:48936 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbhBXPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:00:12 -0500
Date:   Wed, 24 Feb 2021 14:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1614178654;
        bh=9f9GIuhf2hS61SeaImYhYv8s0/Hi503HzYX0LoKMyzE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=gLhepiYNxOpbxWldO8/g/bTQYYsDrkJvDPzY1naS0cXNXmvVRl1GMbzQrdMmih7hu
         JVwi1ElCZsLzqjVjyYHRrfQZruyREAWvUWrhPohOPdjqChdNGq6LUDTgvC7EENNr6N
         cIUdXP6rpqHNjyWkcd22voF7lV0WR8tEJ78YCy4Y=
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7t file/swap crypto package
Message-ID: <ps5Cel96vhDqLDwRW9Lou3Hh8Y7jt6TdiKM7AeGsKYfXv7dwl-zuEtuUu2g67S9hJIcwrQD_xm6Du2SqCIdHrpTLNiZb9yCgo9dpu3FESEs=@protonmail.com>
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
- Worked around kernel interface changes on 5.11 kernels

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7t.tar.bz2
    md5sum 974a0705207d97772b8c1388c43aee58

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7t.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

