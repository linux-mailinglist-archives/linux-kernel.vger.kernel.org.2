Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B031C4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 02:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBPBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 20:03:54 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:41168 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:03:53 -0500
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 11G0eQLB026948; Tue, 16 Feb 2021 09:40:26 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11G0c7HS023835; Tue, 16 Feb 2021 09:38:07 +0900
X-Iguazu-Qid: 2wGrHHn4N1wDhKjghu
X-Iguazu-QSIG: v=2; s=0; t=1613435887; q=2wGrHHn4N1wDhKjghu; m=VBLFBYW3yOe5Oln0JdKcOgQ7YysjBo4WQ8PZae68pIQ=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id 11G0c52A020582;
        Tue, 16 Feb 2021 09:38:06 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11G0c5Jm005603;
        Tue, 16 Feb 2021 09:38:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11G0c4rO026406;
        Tue, 16 Feb 2021 09:38:05 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Feb 2021 09:37:54 +0900
X-TSB-HOP: ON
Message-Id: <1613435875-6846-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yoshio Furuyama<ytc-mb-yfuruyama7@kioxia.com> # This line is ignored.
From: Yoshio Furuyama<ytc-mb-yfuruyama7@kioxia.com>
Subject: 
In-Reply-To: 

