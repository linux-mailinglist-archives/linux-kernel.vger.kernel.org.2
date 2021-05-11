Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0837A676
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEKMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbhEKMWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:22:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 044496187E;
        Tue, 11 May 2021 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620735661;
        bh=QrsUuDyGFvDNr+nehd7xg+P4MR9X+Ma7TQmOhrbi3Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSqX6BNtkBi/GquZJMM/o39GiMwbjVSbpFoZ/iW68jSUzVaWJtxJj4NjRIJgyydFg
         jbKJcWSUTA7mDBsAS0ZuqJquBiuUe/tx8NgStUar3t2jNFUeitdSzwS38YVbPuYJMp
         j01ugTrqEMgDn+xEL9hjSRIAFVtS0wX9P7D1R1Ug20b9E0QGXTzkGN68r/ixtFot1/
         BEQX7ayvKGMs/RF6DDW/z9FjzO3IGJbh+Zb/dhXdFAYwQt+6d0oCIYPhfSHfQy86qH
         +82Ar5DVP1UGhbdJJsEQ33DQCcpFfuKVIHZvX0D6VzoJe0Lj7wd6Z+jENifRIDUZVc
         FcKFOxGqSp+gg==
Date:   Tue, 11 May 2021 17:50:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH] soundwire: dmi-quirks: remove duplicate
 initialization
Message-ID: <YJp2qYH1IQxDjgNA@vkoul-mobl.Dlink>
References: <20210511025035.25233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511025035.25233-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 10:50, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> cppcheck warning:
> 
> drivers/soundwire/dmi-quirks.c:85:12: style: Redundant initialization
> for 'map'. The initialized value is overwritten before it is
> read. [redundantInitialization]
>   for (map = dmi_id->driver_data; map->adr; map++) {
>            ^
> drivers/soundwire/dmi-quirks.c:83:25: note: map is initialized
>   struct adr_remap *map = dmi_id->driver_data;
>                         ^
> drivers/soundwire/dmi-quirks.c:85:12: note: map is overwritten
>   for (map = dmi_id->driver_data; map->adr; map++) {
>            ^

Applied, thanks

-- 
~Vinod
