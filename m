Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9053E3F33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 07:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhHIFIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 01:08:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHIFIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 01:08:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BFFF31B;
        Sun,  8 Aug 2021 22:08:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E97B53F718;
        Sun,  8 Aug 2021 22:08:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kernel test robot <lkp@intel.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] firmware: arm_scmi: fix boolconv.cocci warnings
Date:   Mon,  9 Aug 2021 06:08:14 +0100
Message-Id: <162848564301.232921.17556433266830316474.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807173127.GA43248@a24dbc127934>
References: <202108080108.k5pHZ040-lkp@intel.com> <20210807173127.GA43248@a24dbc127934>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2021 01:31:27 +0800, kernel test robot wrote:
> drivers/firmware/arm_scmi/virtio.c:225:40-45: WARNING: conversion to bool not needed here
> 
>  Remove unneeded conversion to bool
> 
> Semantic patch information:
>  Relational and logical operators evaluate to bool,
>  explicit conversion is overly verbose and unneeded.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: fix boolconv.cocci warnings
      https://git.kernel.org/sudeep.holla/c/d4fda7ec1d

--
Regards,
Sudeep

