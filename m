Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A463D255B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhGVNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhGVNdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02759613AE;
        Thu, 22 Jul 2021 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626963260;
        bh=h9bt+2ABEwbCJSPYIOdamsWRy7Ya4biD/RS9Mrg+ThA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+k9lvOj8/tIhhVZxZjWNi85TGPheT0wf4+cGKHGDQAb34O1JCu3o8oamx+y4HL6o
         XaVstbjEumdqXmg2wfldglQibzJG337VQ3qpRfFEKIOf1RnCuAA0+4oK/bGW4mH906
         oefHSWy18njvPGRK7YjDgJlH8mYMouk8nfvvX2BDP5yr6MZCFTGZCtG4YMhW2e1/uR
         Dt4WfHs8l0XpC3fr6K/fcIByUdVp67EXnfUUtKRB4fL+HDCxer8xOu/JYYebGEiwAy
         1u4FQ/OfVh9JF+kmP0FWn2PYkxYornAZ6lkritSHYanbBHKJ6e0rASuQpQOG9j9n9S
         T1I3/IIS207yA==
Date:   Thu, 22 Jul 2021 19:44:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add ull suffix for SoundWire _ADR
 values
Message-ID: <YPl9ONsFv+3NeSfd@matsya>
References: <20210714013027.17022-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714013027.17022-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 09:30, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Sparse throws the following type of warnings:
> 
> drivers/soundwire/dmi-quirks.c:25:17: error: constant
> 0x000010025D070100 is so big it is long
> 
> Let's add the 'ull' suffix to make this go away and find real issues.

Applied, thanks

-- 
~Vinod
