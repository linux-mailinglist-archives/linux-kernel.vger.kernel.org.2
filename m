Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5D3B5571
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhF0WIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhF0WIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:08:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FAC061766;
        Sun, 27 Jun 2021 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b9tp+JdGeJfN/iWAAVHlO9/qdJRqaDOdraHTaeXVj5w=; b=OtZNB5uKW+Qg08MO8irtX6ZaDa
        8xWDfA8z9lufCgddsb4FWbsUKOnGIEndYNavhGRGmCE8ARnfXkNOrkijRp7K4M2CYDhiRMp89ax+9
        8imU0eVXrBCP/6ir6+0XRlVR5op2aAfQHvwyDfZdF/Yvem+fz4+ENdaJMAJayE5p2A/ff3Xs3hlkb
        OGrQvMl44vhyBpdJR8AWG1kzhJGHh7NSO6v2gGIRkaVHU8yQSrf+zATMwipr0mSFY175haL6/rsQj
        quWzjEQbs7QRPnb3lKhsZmql9gU5V3HgBvk4BgNkJAJRKw4FAxabHUCnEIyb4P+w9+vUvciNeuBLZ
        Tx4eGnQA==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxcuP-006CHh-DY; Sun, 27 Jun 2021 22:05:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
Date:   Sun, 27 Jun 2021 15:05:41 -0700
Message-Id: <20210627220544.8757-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few build warnings and one kconfig warning on SUPERH.

v2: add a previously-sent Kconfig patch
    add a few more Cc's

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

[PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
[PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
[PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings

 arch/sh/Kconfig.debug             |    1 
 arch/sh/include/asm/sfp-machine.h |    8 +++++
 arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
 3 files changed, 31 insertions(+), 22 deletions(-)
