Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D086E3A57A0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhFMK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:28:00 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:44185 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFMK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:27:59 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d10 with ME
        id GaRw2500M21Fzsu03aRwab; Sun, 13 Jun 2021 12:25:57 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jun 2021 12:25:57 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] scsi: mptsas: switch from 'pci_' to 'dma_' API
Date:   Sun, 13 Jun 2021 12:25:53 +0200
Message-Id: <cover.1623579808.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to convert this file to the dma_ API, 2 steps are proposed.

The first one is purely mechanical. All the updated memory allocations can
use GFP_KERNEL because of 'mpt_config()' calls. This function can sleep so
it sounds like a reasonable assumption to use GFP_KERNEL.

The 2nd patch is slighly more subtle. It is sent separatly to ease review.

Christophe JAILLET (2):
  scsi: mptsas: switch from 'pci_' to 'dma_' API
  scsi: mptsas: switch from 'pci_' to 'dma_' API in
    'mptsas_exp_repmanufacture_info()'

 drivers/message/fusion/mptsas.c | 138 ++++++++++++++++----------------
 1 file changed, 70 insertions(+), 68 deletions(-)

-- 
2.30.2

