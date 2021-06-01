Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9B397AED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhFAUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:03:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:10251 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622577709; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C8QSpFf6Pec3jGQhJwe3uwwnXdY8JTA7ElfUB0hQf/eWZAH1RL3GggnKt+tHnQ+zZO
    3JoyYl7kBi0cQgYOctj3+EQ0tOoSfU4gu8zPlz9FIjy9wFVQV+vvmQCGhiDVFyygm9pR
    CITjyuElL0t+bcNMG2s4KifFYEZ99ErnOZR3Hv3j/LXxfs2MpeZf508dCZa40n6e7VC6
    5+1LWrcUAR8XPUPfevC+6LeIR2wdOAxOxWgHGjtwFYXDEx3qeN2CUFNJD1UNUVIHZWmy
    lLhU+WlMDUabTA0docW5m/DQ/CKAF1pyXCh5iZSo7tAKKasNtY/5uM/jl3cYSOZaTJmd
    ygbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577709;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cQHszmLzV3x18OhfM6yRmge7ED76c1TKIGdNHSzSs6c=;
    b=soRRqwD05nyuGy3Fonixq1BrxOqB0fkHlP5FHMBYKTptVV3q5szksELmZFKZ1JrvoY
    VyaOE+6hY1b7W2aF3TPTCexmHjowC7/p5Jxv7YU2gIVw3zcd2kWgW7TkMZqrqqVZWmT7
    Slhsf7fGOHogx3JMyorcvVcnqkv8ZIjNLoavwBzIzaLsFWueArGLwd/woTuuTEWwdbdt
    aYsp7FqM2/mxc6hc5e8puuAFrk8R5FwyTpolc9FDDv168xhmzjyW5TMWAylarrzM9Q/+
    2lSTLEUlkn8eyVgn+hd/vqqgYQWbnpiv43OnjSzUQcCcLg8w3F+0ZdElTqiIHPFwS/OE
    S/GA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577709;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cQHszmLzV3x18OhfM6yRmge7ED76c1TKIGdNHSzSs6c=;
    b=K08xPBSO5lqFnfJZWzBBzk7UmipR1FgyusuALPhTYdQ3GpGuCLjEHnAlOXL4Uv8Ijv
    8rSycAnz2WpGavS0bcpxGm0pG1y2LCqE9nVmGIaPgAHOO1I2sZBWjF61C0cc+VD7IAnI
    DtjMWrVd1o5hXzQzT9LjSWluxBXHr3O5eSoaWm89odGDaWHgHWmGo9jWQ4cDKZvamWpR
    +W7nyRsb1vyFaL/UELkkIEtjodTkNA6709G+XNhvpE+Oyblt4+GwM/PQUh9utGM9FbAc
    86XUY7reUa2szqG6/wawHb9o4VXBffbz85MazVlTbyUemOSkUIiymgvRvMDg6yprW4aO
    L3ZA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6Na3kD"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x51K1mWmz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 22:01:48 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 0/3] extcon: sm5502: Add support for SM5504
Date:   Tue,  1 Jun 2021 22:00:04 +0200
Message-Id: <20210601200007.218802-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for SM5504 to the existing extcon-sm5502
driver. SM5502 and SM5504 are fairly similar so support for SM5504 can
be added with a few simple if statements in the code.

I also put a few cleanup patches in front and convert the device tree
bindings to DT schema.

I tested this patch series on both SM5502 (Samsung Galaxy A5 2015)
and SM5504 (Samsung Galaxy S4 Mini Value Edition) and it seems to work
just fine for both.

---
Changes in v3:
  - Drop patch 1-4 (already applied)
  - Avoid if (type == TYPE_SM5504) everywhere in the code, instead
    introduce a struct sm5502_type that encodes chip-specific information.

v2: https://lore.kernel.org/lkml/20210531133438.3511-1-stephan@gerhold.net/
Changes in v2: Fix compile warning in last patch
v1: https://lore.kernel.org/lkml/20210520112334.129556-1-stephan@gerhold.net/

Stephan Gerhold (3):
  dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
  extcon: sm5502: Refactor driver to use chip-specific struct
  extcon: sm5502: Add support for SM5504

 .../extcon/siliconmitus,sm5502-muic.yaml      |   6 +-
 drivers/extcon/Kconfig                        |   2 +-
 drivers/extcon/extcon-sm5502.c                | 196 +++++++++++++++---
 drivers/extcon/extcon-sm5502.h                |  82 +++++++-
 4 files changed, 248 insertions(+), 38 deletions(-)

-- 
2.31.1

