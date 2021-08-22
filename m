Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6832F3F418E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhHVUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:44:21 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:59085 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhHVUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:44:20 -0400
Date:   Sun, 22 Aug 2021 20:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629664986;
        bh=Z00a/14XZVAcDNHQN5zQ4VLFtLawh/2LW/bA1LZ9MMw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=BbbW7SyGll7cSK5KvnapcUyreXsnZWID314XP4VthouLzSR/gV1UskgvzRP0r/syo
         dFKG0mbRYyOlKn9iGh1DMmDlja2yteCVkw+T4ZoGh6mbOgmF51SvyU/DyrZfaz28XU
         b2l3EAj0+up0qht8y0hAdZvaIWA6vl+RoO4a1lB6Pqs5qXoj5JNDWhsaBVuDcDN3WF
         bPchy0BhcuugbhYSU4WCpXpJktFHLOuepwRVyMUHZO4eZaulGtU/fqn3fQShytIXQd
         gMedJ+4XHrWdkPoUPQcHN4g3brUtubvunFM5MMbiOw2n6uOWM/x5XCYNZI6W4g9j4K
         +jhIO7y117I+w==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2 0/5] staging: rtl8723bs: remove unused functions
Message-ID: <20210822204212.2832397-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Remove build warnings I introduced in the previous version.

***

There is a lot of un-used code and un-needed abstractions leftover
in this driver from when (I assume) it could be compiled on more than
one kernel.

This series removes dead code and is one small step toward
refactoring how this driver interacts with the SDIO subsystem.

Bryan Brattlof (5):
  staging: rtl8723bs: remove sdio_write_mem()
  staging: rtl8723bs: remove sdio_writeN()
  staging: rtl8723bs: remove sdio_read_mem() and sdio_readN()
  staging: rtl8723bs: remove unused definitions from rtw_io.h
  staging: rtl8723bs: remove _read_port from _io_ops structure

 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 116 ---------------------
 drivers/staging/rtl8723bs/include/rtw_io.h |  96 -----------------
 2 files changed, 212 deletions(-)

--
2.30.2


