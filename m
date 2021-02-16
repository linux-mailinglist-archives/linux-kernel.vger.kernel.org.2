Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D531C7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBPJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhBPJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:21:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B4264DE0;
        Tue, 16 Feb 2021 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613467272;
        bh=U4osS8wZTMUrGl9xKZvhX0IFnXwXNpHmG5H+9aLkdPA=;
        h=Date:From:To:Cc:Subject:From;
        b=Irl0jWyGRfU1T68vw/CG5DVzqZWHxOI4++thINnZ+XfZhhcl601spLwNPnQ1bRfYM
         hFBj31i3jwG6qW88PIcetJe4vlthyD3s7HR3YjjsCUXeIGQ0Y9Bg0WmJnNhKDm8QEr
         zK955kGuNGXQIl2DUhthIf6A1RYVNeNu6OxFO5nDU8XekMH8IROLMWkrQnSuBMNhrB
         cOYr5M3q75oCAnc1sKkFNujQpceLemhNVYNrRv7wcVQ6DU6W7GzzpMLOoHpfNzPAlB
         m/WfomTzEqOTyUU/qzQf59oK71hJITRbmZRBAhxwSRPN5Ajhb8UXuSq90yriy7PwZA
         S/xviH27uycJw==
Date:   Tue, 16 Feb 2021 10:20:47 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.12
Message-ID: <20210216092047.GA27288@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few bits for auxdisplay. Please pull.

Cheers,
Miguel

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12

for you to fetch changes up to b45616445a6e346daf8a173a0c51413aec067ebb:

  auxdisplay: Fix duplicate CHARLCD config symbol (2021-01-25 22:14:19 +0100)

----------------------------------------------------------------
A set of auxdisplay fixes and improvements from Geert Uytterhoeven.

Includes one from Robin van der Gracht that got lost a long time ago.
----------------------------------------------------------------
Geert Uytterhoeven (4):
      dt-bindings: auxdisplay: ht16k33: Fix default-brightness-level range
      dt-bindings: auxdisplay: ht16k33: Convert to json-schema
      auxdisplay: ht16k33: Fix refresh rate handling
      auxdisplay: Fix duplicate CHARLCD config symbol

Robin van der Gracht (1):
      dt-bindings: auxdisplay: ht16k33: Keyscan function should be optional

 .../bindings/auxdisplay/holtek,ht16k33.yaml        | 77 ++++++++++++++++++++++
 .../devicetree/bindings/display/ht16k33.txt        | 40 -----------
 MAINTAINERS                                        |  2 +-
 drivers/auxdisplay/Kconfig                         |  3 -
 drivers/auxdisplay/ht16k33.c                       | 17 ++---
 5 files changed, 85 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/ht16k33.txt
