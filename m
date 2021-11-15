Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9734504A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhKOMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:46:16 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:26552 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhKOMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:45:57 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFBu7JO030566;
        Mon, 15 Nov 2021 06:42:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TbN+T5UbW/pTZkZG+D5XfPYWd0dn7t2lMCwb7Cp5rjk=;
 b=hUq6LzPoRIb7mIw5aTUt6/FzmVTc6U1ltCNPAdXwz1D/TQz9QytVAfADDHtgCirwHmAW
 qTFBGWazzZbQSXNYDXvKFXxzZ/fMuLXEzdL3gquzvEidoW+A2MjD029Za78f9OsNxTih
 ErscuKc8st63gdnFxHKPZVLUHF8j9+O4L5/YTr6lS7c+eOFhqlA2sgN0bEUeV+Ae7LsT
 3SSREYkNV/htiMLu+air3tOpBjXqT3pthve0wOEn4S0tDJcjKeQ4cfIJUiJvz9lo7sNc
 XNL87Iw1go2D+rkLq2J4nGLHKzii4S3dpqdoQg5MsZvnofd6WInSa8gX+QfxF3On4DpN Lw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgrgk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Nov 2021 06:42:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 12:42:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 15 Nov 2021 12:42:53 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E7F7811DC;
        Mon, 15 Nov 2021 12:42:52 +0000 (UTC)
Date:   Mon, 15 Nov 2021 12:42:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: cs_dsp: tidy includes in cs_dsp.c and cs_dsp.h
Message-ID: <20211115124252.GB18506@ediswmail.ad.cirrus.com>
References: <20211115120215.56824-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211115120215.56824-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: hmLB5-5mIBc3XMAvWS7Suut0HITb8a46
X-Proofpoint-GUID: hmLB5-5mIBc3XMAvWS7Suut0HITb8a46
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 12:02:15PM +0000, Simon Trimmer wrote:
> This patch removes unused included header files and moves others into
> cs_dsp.h to ensure that types referenced in the header file are properly
> described to prevent compiler warnings.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
