Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18B73F9C36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbhH0QN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:13:57 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57635 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhH0QN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:13:56 -0400
Date:   Fri, 27 Aug 2021 16:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630080784;
        bh=Lshhf2wix+TxcMlgLTVzKe5GRvuCLhfvNPWrDPH+j6w=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ap3Qekq1J8OsN2B7QSBf+UNHH+EOc5CRJHY5Nv5KM9Vajvjw03Rh80TaRF/Oyu3Ag
         GrLFEyuKQg3vgEZU0hxc67C+5TqCKGtcvvKszBmI8NatFWeKdWXp7MXoWh4M7PcgcA
         wuJApGK6cazcfWvAcOo599r8JEL70JK52Hf5wnAq/BpTGaP4cFjG90u8E/+OJF5g3D
         Je2qvb4bq5X/O5KstFrOrf/b7OJzoU2ytfEmDNpGhFQ3hj2r0qshA1hhN/MYENK5dO
         akTeObbi/OOCfoiz2rlBsIoCjQfefnRbMPdDWGDewPreFONMySajdabQcVvAFjtU2q
         mQq8mmFn/I70Q==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 0/5] staging: rtl8723bs: remove unused functions
Message-ID: <cover.1630080164.git.hello@bryanbrattlof.com>
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

Changes in v3:
 - Fix issue causing some emails to drop their In-Reply-To: header.

 (For the curious: NullMailer & my email provider where conspiring)

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


