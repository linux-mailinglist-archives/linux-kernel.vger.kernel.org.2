Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBB43D1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhJ0TsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:48:01 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7004 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhJ0TsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635363935; x=1666899935;
  h=to:from:subject:cc:message-id:date:mime-version:
   content-transfer-encoding;
  bh=8F3k1myEFyDZ4xK0OAeLazf0kTGtaGTx6VEGZMJ02jw=;
  b=uY7fpYuyJKXzCDDyKObEs4ReujipC6E0Zsm5wDfPvr4EbWah6fnhSDRY
   9ZcvC2/QdpG2BKzBahGnNCeYUoLLzvKyv4wQ067hZxbLvqpfACG+S5ezK
   5nmOSZnSPTXTYH0lCKnOWn3wMDktiROv7ECE2Vwc2I39iv6geBpUJcF6H
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 12:45:34 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:45:34 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 12:45:33 -0700
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Subject: Arm64 defconfig-debug
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <4aee8e37-b1f0-bd1c-9bf8-842c6cdc557e@quicinc.com>
Date:   Wed, 27 Oct 2021 15:45:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, some general debugging features like kmemleak, KASAN, lockdep,
UBSAN etc help fix many bugs like a microscope. On the other hand, those
features are scatter around and mixed up with more situational debugging
options making them difficult to consume properly.

Since I have been deal with those options on a daily basis for the last
a few years and accumulated the knowledge of their pros and cons, I am
thinking about to create an initial defconfig-debug available inside the
tree, so that it could amplify the general debugging/testing efforts for
arm64 across the broad.

The downside is that this might open a gate for other people to push yet
another subject-specific defconfig, but I don't see anything as
important as general debugging/testing at the moment. Then, there are
two defconfig need to be modified for some common changes, but I think
that is quite trivial to do. We could even create a simple script to
sync if that is not overkill.
