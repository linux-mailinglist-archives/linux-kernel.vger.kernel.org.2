Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F269349E99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZBVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCZBVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3E2761A2D;
        Fri, 26 Mar 2021 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616721703;
        bh=as9lfFgV4XuY3YAN83h5LS2PkkRJHNNBOryPGMahbwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3d6uiA4lOaJ3SjD2+BHhJnfl/ISiKpY88UwFM0Q2GVjLumusLC9TlN7iiTuoVZmA
         ums5J+cRcsFKuQk1jFcNcc8eAIxURe6A3Tvyee5jxrhYybIiHYBJGo/MFgHpaVBAup
         lSTyK/Gmtp7zHF15Kra2BmOz7Gc6VCtg1SCLA9p2FjKynlnt1O6WLk5K9Je5LChD0u
         aCRl24UcevvXalfNL/s/FRk/6HVUFgoq0GlVAMrD9d6KeuqvE0tHT6e4e/Zqjr+MIJ
         HAIIomqQPzpEX68j2PwoDv6f8OrJ5WkmPhJ4eoZ4GR2cvdqULMO2Cf6GYnIc/wN3HP
         hQw+hcfh0O0dA==
Date:   Thu, 25 Mar 2021 18:21:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: allow to change discard policy based on cached
 discard cmds
Message-ID: <YF03JuWi9bYL11e6@google.com>
References: <1615886958-717-1-git-send-email-stummala@codeaurora.org>
 <3c453b72-892f-7044-2edd-224b82202608@huawei.com>
 <20210326011756.GE8562@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326011756.GE8562@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26, Sahitya Tummala wrote:
> Hi Jaegeuk,
> 
> This latest v3 patch needs to be updated in f2fs tree.
> The f2fs tree currently points to older version of patch.
> 
> Please make a note of it.

Ha, need more coffee. Thanks for pointing it out. :)

> 
> Thanks,
> Sahitya.
> 
> On Tue, Mar 16, 2021 at 07:08:58PM +0800, Chao Yu wrote:
> > On 2021/3/16 17:29, Sahitya Tummala wrote:
> > >With the default DPOLICY_BG discard thread is ioaware, which prevents
> > >the discard thread from issuing the discard commands. On low RAM setups,
> > >it is observed that these discard commands in the cache are consuming
> > >high memory. This patch aims to relax the memory pressure on the system
> > >due to f2fs pending discard cmds by changing the policy to DPOLICY_FORCE
> > >based on the nm_i->ram_thresh configured.
> > >
> > >Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > 
> > Thanks,
> 
> -- 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
