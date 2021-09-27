Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052B6419567
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhI0Nvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234600AbhI0Nvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E3061002;
        Mon, 27 Sep 2021 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750595;
        bh=3FXA4AbMQLH4lWQwUmUJ+RG4GsZVOfi+yc3uPA1d0IQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jmUYX6phnM1nq9XWqNJwgdc1w/H/83d0XbGoKhQbr1FeN85ErJyatsF5lXr/U9Pwr
         2iXUqAo/CzgBqBSZ606WL8uBTckQD/hRu36UvNZKhyief5S8H3rgzFfu+RAZHW0+ME
         sHudVWq5TwaqrdPBDDctZswFMJBt1UFhCZwNWBWVASfzbYAdcvTLpEtJcAwxjfvP0N
         7fitLURaoQ8yG/e70hgMfGCZUSGkQAxEvOOpP2drMEc1UAq4L0QjHZ9N476t3Uo3TB
         QugK1jFgag664hloQltsoV47gDkDBh6B31w3k7eRt1b+JIFJUYysya1Cqv57pVYEry
         Ui/2G/RABRd2A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUr0z-000AjR-Hy; Mon, 27 Sep 2021 15:49:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] scripts: get_abi.pl: some additional fixes and doc update
Date:   Mon, 27 Sep 2021 15:49:48 +0200
Message-Id: <cover.1632750315.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This small series address a couple of issues I noticed while testing it
on an arm64 board (HiKey970). Those are addressed on patches 1
and 2.

Patch 2 is the real fix: it prevents creating aliases for nodes that
are ignored (specially for /sys/firmware, where there's no documentation
for the files created there under Documentation/ABI - nor it makes
sense to have it).

Patch 1 prevents similar cases, as it will produce an error if a
symlink is pointing to an entry that was not added at the internal
representation of the sysfs.

Patch 3 just update a few things at the documentation inside the
script.

Mauro Carvalho Chehab (3):
  scripts: get_abi.pl: produce an error if the ref tree is broken
  scripts: get_abi.pl: fix parse logic for DT firmware
  scripts: get_abi.pl: update its documentation

 scripts/get_abi.pl | 70 +++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 25 deletions(-)

-- 
2.31.1


