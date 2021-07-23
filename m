Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478603D3A31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGWLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhGWLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:47:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB578C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:27:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q2so1485532ljq.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8Jqnzlzkq3lWaeMD/UpiQD1J4FvoYfIZ2HIOcLayRLM=;
        b=CPuZavrOIGmtaqLW0Bp26ptlVzuIGzB17hEgt6QzhstQQTb/jdWJi16joMbwnwq/dw
         ptrjY4WEbqcvTFvEQ3hNt0m2YjyQBwawPfn56WPc6futN83voblY78BkA4kyNsfo8vfp
         tm6iEy+2LFZHPJi+0bhRVp67wZ20fJB/JXBiG35GEL5TkEjEbjPB8TeC8zkHkpWOjmUa
         P+V+nc8VoiJvgy4hDEBtnMCXC1v28dhp03n9N8azN31rZh1DdmIG+GtE2HzWUD8Shl+3
         IAMZd4SSnv7lFLvv91g4vVr8v11WyRntX/4oLUYDKQM+/VxhkynGPFuSt+/scXedxfUQ
         a+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8Jqnzlzkq3lWaeMD/UpiQD1J4FvoYfIZ2HIOcLayRLM=;
        b=WjjLrKH/kKJ2L+4yaIfa9Myh8Ba1mmzMRKrh+ENqDk7Ufj301LuBLvOiXiZuiDa3T8
         LvYrQbW8MOX1ZmgDTIukgrYo5JMbx8PFL1oCEU98vNlrf/7N6R/d3La+xPyf6HJUHTTE
         O3qE8XAmsEuROHpkE8tytfPa+llgzxjCTO54kWkRZ4nZImgbQDj+B5+Ept/6MClN0bi2
         CHyPU0SkAWDgW/GHC7EfXQB3V/1WcOMXHrirXJm11t9vrYlyagrrv5+SX0Z8ysWw2hTZ
         TTEw6CvWcdHa3mT/1l96njo6zFl1wG0cIdwII4irhblaWVBdRk6r9boKT2cV+fehNu54
         J9/Q==
X-Gm-Message-State: AOAM532hXgv6TL4cgeWMpxLmw6fSy9tjsm0/z4byE4Gh8g6E5oPkfoYZ
        aIFu2FLSuYWzkA3VSNN4ItBiji0p5qk=
X-Google-Smtp-Source: ABdhPJzUGFU+PYyCLLEhPzrKZlHgQSfn07U3R7rSIvhES03nBccLzrImkTpluXJwmzrAvt8ZOQwfVQ==
X-Received: by 2002:a2e:9a09:: with SMTP id o9mr3127214lji.473.1627043272016;
        Fri, 23 Jul 2021 05:27:52 -0700 (PDT)
Received: from ideapad ([188.170.79.182])
        by smtp.gmail.com with ESMTPSA id j3sm1504544lfe.133.2021.07.23.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:27:51 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:27:49 +0300
From:   Artem Baxtiarov <baxtiarovartem@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: comedi: drivers: ni_routing: ni_device_routes:
 pci-6070e.c Lindented
Message-ID: <20210723122749.GA41336@ideapad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found "Lindent" item in drivers/comedi/TODO.
I used scripts/Lindent to indent
drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c

Signed-off-by: Artem Baxtiarov <baxtiarovartem@gmail.com>
---
 .../ni_routing/ni_device_routes/pci-6070e.c   | 1227 +++++++++--------
 1 file changed, 621 insertions(+), 606 deletions(-)

diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
index 7d3064c92643..4d3d9534a550 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
@@ -29,610 +29,625 @@
 
 struct ni_device_routes ni_pci_6070e_device_routes = {
 	.device = "pci-6070e",
-	.routes = (struct ni_route_set[]){
-		{
-			.dest = NI_PFI(0),
-			.src = (int[]){
-				NI_AI_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(1),
-			.src = (int[]){
-				NI_AI_ReferenceTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(2),
-			.src = (int[]){
-				NI_AI_ConvertClock,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(3),
-			.src = (int[]){
-				NI_CtrSource(1),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(4),
-			.src = (int[]){
-				NI_CtrGate(1),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(5),
-			.src = (int[]){
-				NI_AO_SampleClock,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(6),
-			.src = (int[]){
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(7),
-			.src = (int[]){
-				NI_AI_SampleClock,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(8),
-			.src = (int[]){
-				NI_CtrSource(0),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_PFI(9),
-			.src = (int[]){
-				NI_CtrGate(0),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(0),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(1),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(2),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(3),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(4),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(5),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(6),
-			.src = (int[]){
-				NI_CtrSource(0),
-				NI_CtrGate(0),
-				NI_CtrInternalOutput(0),
-				NI_CtrOut(0),
-				NI_AI_SampleClock,
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AI_ConvertClock,
-				NI_AO_SampleClock,
-				NI_AO_StartTrigger,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = TRIGGER_LINE(7),
-			.src = (int[]){
-				NI_20MHzTimebase,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrSource(0),
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				TRIGGER_LINE(7),
-				NI_MasterTimebase,
-				NI_20MHzTimebase,
-				NI_100kHzTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrSource(1),
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				TRIGGER_LINE(7),
-				NI_MasterTimebase,
-				NI_20MHzTimebase,
-				NI_100kHzTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrGate(0),
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(1),
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrGate(1),
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(0),
-				NI_AI_StartTrigger,
-				NI_AI_ReferenceTrigger,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrOut(0),
-			.src = (int[]){
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(0),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_CtrOut(1),
-			.src = (int[]){
-				NI_CtrInternalOutput(1),
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_SampleClock,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(0),
-				NI_AI_SampleClockTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_SampleClockTimebase,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				TRIGGER_LINE(7),
-				NI_MasterTimebase,
-				NI_20MHzTimebase,
-				NI_100kHzTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_StartTrigger,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(0),
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_ReferenceTrigger,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_ConvertClock,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(0),
-				NI_AI_ConvertClockTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_ConvertClockTimebase,
-			.src = (int[]){
-				TRIGGER_LINE(7),
-				NI_AI_SampleClockTimebase,
-				NI_MasterTimebase,
-				NI_20MHzTimebase,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_PauseTrigger,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AI_HoldComplete,
-			.src = (int[]){
-				NI_AI_HoldCompleteEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AO_SampleClock,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_CtrInternalOutput(1),
-				NI_AO_SampleClockTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AO_SampleClockTimebase,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				TRIGGER_LINE(7),
-				NI_MasterTimebase,
-				NI_20MHzTimebase,
-				NI_100kHzTimebase,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AO_StartTrigger,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_AI_StartTrigger,
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_AO_PauseTrigger,
-			.src = (int[]){
-				NI_PFI(0),
-				NI_PFI(1),
-				NI_PFI(2),
-				NI_PFI(3),
-				NI_PFI(4),
-				NI_PFI(5),
-				NI_PFI(6),
-				NI_PFI(7),
-				NI_PFI(8),
-				NI_PFI(9),
-				TRIGGER_LINE(0),
-				TRIGGER_LINE(1),
-				TRIGGER_LINE(2),
-				TRIGGER_LINE(3),
-				TRIGGER_LINE(4),
-				TRIGGER_LINE(5),
-				TRIGGER_LINE(6),
-				NI_AnalogComparisonEvent,
-				0, /* Termination */
-			}
-		},
-		{
-			.dest = NI_MasterTimebase,
-			.src = (int[]){
-				TRIGGER_LINE(7),
-				NI_20MHzTimebase,
-				0, /* Termination */
-			}
-		},
-		{ /* Termination of list */
-			.dest = 0,
-		},
-	},
+	.routes = (struct ni_route_set[]) {
+					{
+					    .dest = NI_PFI(0),
+					    .src = (int[]) {
+							    NI_AI_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(1),
+					    .src = (int[]) {
+							    NI_AI_ReferenceTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(2),
+					    .src = (int[]) {
+							    NI_AI_ConvertClock,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(3),
+					    .src = (int[]) {
+							    NI_CtrSource(1),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(4),
+					    .src = (int[]) {
+							    NI_CtrGate(1),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(5),
+					    .src = (int[]) {
+							    NI_AO_SampleClock,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(6),
+					    .src = (int[]) {
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(7),
+					    .src = (int[]) {
+							    NI_AI_SampleClock,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(8),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_PFI(9),
+					    .src = (int[]) {
+							    NI_CtrGate(0),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(0),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(1),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(2),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(3),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(4),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(5),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(6),
+					    .src = (int[]) {
+							    NI_CtrSource(0),
+							    NI_CtrGate(0),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_CtrOut(0),
+							    NI_AI_SampleClock,
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AI_ConvertClock,
+							    NI_AO_SampleClock,
+							    NI_AO_StartTrigger,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = TRIGGER_LINE(7),
+					    .src = (int[]) {
+							    NI_20MHzTimebase,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrSource(0),
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    TRIGGER_LINE(7),
+							    NI_MasterTimebase,
+							    NI_20MHzTimebase,
+							    NI_100kHzTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrSource(1),
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    TRIGGER_LINE(7),
+							    NI_MasterTimebase,
+							    NI_20MHzTimebase,
+							    NI_100kHzTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrGate(0),
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (1),
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrGate(1),
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_AI_StartTrigger,
+							    NI_AI_ReferenceTrigger,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrOut(0),
+					    .src = (int[]) {
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (0),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_CtrOut(1),
+					    .src = (int[]) {
+							    NI_CtrInternalOutput
+							    (1),
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_SampleClock,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_AI_SampleClockTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_SampleClockTimebase,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    TRIGGER_LINE(7),
+							    NI_MasterTimebase,
+							    NI_20MHzTimebase,
+							    NI_100kHzTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_StartTrigger,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_ReferenceTrigger,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_ConvertClock,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (0),
+							    NI_AI_ConvertClockTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_ConvertClockTimebase,
+					    .src = (int[]) {
+							    TRIGGER_LINE(7),
+							    NI_AI_SampleClockTimebase,
+							    NI_MasterTimebase,
+							    NI_20MHzTimebase,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_PauseTrigger,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AI_HoldComplete,
+					    .src = (int[]) {
+							    NI_AI_HoldCompleteEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AO_SampleClock,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_CtrInternalOutput
+							    (1),
+							    NI_AO_SampleClockTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AO_SampleClockTimebase,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    TRIGGER_LINE(7),
+							    NI_MasterTimebase,
+							    NI_20MHzTimebase,
+							    NI_100kHzTimebase,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AO_StartTrigger,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_AI_StartTrigger,
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_AO_PauseTrigger,
+					    .src = (int[]) {
+							    NI_PFI(0),
+							    NI_PFI(1),
+							    NI_PFI(2),
+							    NI_PFI(3),
+							    NI_PFI(4),
+							    NI_PFI(5),
+							    NI_PFI(6),
+							    NI_PFI(7),
+							    NI_PFI(8),
+							    NI_PFI(9),
+							    TRIGGER_LINE(0),
+							    TRIGGER_LINE(1),
+							    TRIGGER_LINE(2),
+							    TRIGGER_LINE(3),
+							    TRIGGER_LINE(4),
+							    TRIGGER_LINE(5),
+							    TRIGGER_LINE(6),
+							    NI_AnalogComparisonEvent,
+							    0,	/* Termination */
+							}
+					    },
+					{
+					    .dest = NI_MasterTimebase,
+					    .src = (int[]) {
+							    TRIGGER_LINE(7),
+							    NI_20MHzTimebase,
+							    0,	/* Termination */
+							}
+					    },
+					{	/* Termination of list */
+					    .dest = 0,
+					    },
+					    },
 };
-- 
2.25.1

