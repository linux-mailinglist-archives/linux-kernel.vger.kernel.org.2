Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626A145796A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhKSXSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:18:46 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43195 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhKSXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637363742; x=1668899742;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EOeE/8u2GgZp5oSglVkU0d1h/BBJ7rE0E0fhZsedy1Q=;
  b=DuNxh7xv6uAmdXZZJbVqkgHdC3ySGAH+Q6bu0CcqJ6mb3mk91UnygqSX
   O02ZyUjY8oAFvDBKO8lFyUI78KliBh9wtXxT6SblL4crw5QQVqvj4KANP
   fsxfwFsbxSTyCh0j7QLIYLMLIOYDI5P/0Vf2kqwFXJc0fmPKnn9xO83vq
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 19 Nov 2021 15:15:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 15:15:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 15:15:40 -0800
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 15:15:40 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <gregkh@linuxfoundation.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <dmitry.baryshkov@linaro.org>,
        <akhilpo@codeaurora.org>
Subject: mailmap: add and update email addresses
Date:   Fri, 19 Nov 2021 15:15:25 -0800
Message-ID: <1637363725-17732-1-git-send-email-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and also update the email addresses to prepare for
the transition to the new ones.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 .mailmap | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6e84911..92f4cd7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -10,10 +10,12 @@
 # Please keep this list dictionary sorted.
 #
 Aaron Durbin <adurbin@google.com>
+Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Adrian Bunk <bunk@stusta.de>
+Akhil P Oommen <quic_akhilpo@quicinc.com> <akhilpo@codeaurora.org>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
@@ -162,6 +164,7 @@ Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jens Axboe <axboe@suse.de>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
+Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
 Jiri Slaby <jirislaby@kernel.org> <jirislaby@gmail.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@novell.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.com>
@@ -181,6 +184,7 @@ Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
+Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
 Kay Sievers <kay.sievers@vrfy.org>
 Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>
 Kees Cook <keescook@chromium.org> <keescook@google.com>
@@ -192,9 +196,11 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
+Krishna Manikandan <quic_mkrishn@quicinc.com> <mkrishn@codeaurora.org>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
@@ -300,6 +306,7 @@ Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
 Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
+Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
@@ -314,6 +321,7 @@ Rui Saraiva <rmps@joel.ist.utl.pt>
 Sachin P Sant <ssant@in.ibm.com>
 Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sam Ravnborg <sam@mars.ravnborg.org>
+Sankeerth Billakanti <quic_sbillaka@quicinc.com> <sbillaka@codeaurora.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Santosh Shilimkar <ssantosh@kernel.org>
 Sarangdhar Joshi <spjoshi@codeaurora.org>
-- 
2.7.4

