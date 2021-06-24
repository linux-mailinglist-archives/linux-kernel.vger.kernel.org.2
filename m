Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD03B26F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFXFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:47:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49901 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhFXFrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:47:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25F4F580525;
        Thu, 24 Jun 2021 01:45:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 24 Jun 2021 01:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CBS7hSLICZXM6xNmqLN8vp4vAc6
        qkJNTU1liSdDxBZg=; b=bKjT21TpU4AIvWnW0VnaABYqN/C1UnTl8Wy7jSRtCYO
        zSM50shZ8lT5iSeRMAx3uqFqlnkSkJCxKIUtr1M4RPxmzZLuEYcKYq16ouXNB4+M
        eORd8nY7Z2tHHJlJR6BhBf4WgWC1ZDSVZ2ft65f9igQqW4XZBOzZL0W+MWyeWgic
        SkO/6eOHqULJ/Lcxtr1wpqbly5FTkU+CLq3+SbwJkKSCF1PhAVqNPwzELYd94BRn
        OQ7TFyrmpC7mtzLVa9byxEXQRHz3NaIcZ8wmQMplmcnb3NLCXX7SZxzj9TEOSDai
        WNnZdiQ/xN6Y7ozGk5h9oOhVfOn2U/wl0SUk2vkLOnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CBS7hS
        LICZXM6xNmqLN8vp4vAc6qkJNTU1liSdDxBZg=; b=ZuvozmI97VGeeLxlmd+Xsa
        +tMksSlu4R0hIQshF0yRiykpnis2aZipGfz4gXRt1DZ39KZHwyXxqHCHZgn22kCt
        Ue/EFXsCquv1kCT7f/GiUzUlRIREhVSPnpmKuXfjBocR/lE4vSOuaDkXm1b5bsib
        tFEVSdkdlgasITuRA7HX1RM4TdhReRgQmNE44Oo/avFjGEk9pVFg/0zA9K/2t6BB
        7S8qQOceMqDRi9vMx3EP2kiJUyu0WiOjOxnoKzloJMJLzmfClAj5ye8QVp5IPl5e
        0wx23gpQjKFXWe5onmIbhDHodydeYIw9n8ok2kd9XhKUEpcgxfHXBCB83S+fKd6w
        ==
X-ME-Sender: <xms:2xvUYKcrPEPw8bLWZCNPdy1F9xnSlGCqh7QeYOoTrskvJhAzS3KTWQ>
    <xme:2xvUYEO8wAfnTUXGqO3-a6X_6bNleHSpwa1LUiKF3hfh11iAmoqpePO2hSfavPmbA
    dbJe3gc8GvVJA>
X-ME-Received: <xmr:2xvUYLiyWBX3Edgm-FpWIdpcFNRvc6fVSQn6blxFTy0plaqKFLQ6pX6gEICTTNW6w_X-wNX2tG_s5I_CXPm4CPv-uu4dxiky>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:2xvUYH_U2F1UuAc4cZFKTWQU7xQPKhFWfDIdnkuIBD0al7tKtl8spQ>
    <xmx:2xvUYGtYlAfKPt_bVkW9wVYzpLK9I3rZFUIO2ZcGAzSOnCeQjpoPag>
    <xmx:2xvUYOFjJE8jpK4KaOyBPpUClFXXNkg-hVKQUt-fPNyfu-EV3F9sjg>
    <xmx:3BvUYH8LJlEWaWjBKK3Z-YJYwhcueHlLIwBmIGObfv1fDRwDkoo1Gg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 01:44:58 -0400 (EDT)
Date:   Thu, 24 Jun 2021 07:44:55 +0200
From:   Greg KH <greg@kroah.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 3/7] perf/x86/intel/uncore: Create a symlink for an
 uncore PMU
Message-ID: <YNQb18U+iRbCYlWi@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624497729-158864-4-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 06:22:05PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The platform specific support for Sapphire Rapids will apply a
> meaningful name for each uncore PMU. The script which works well with
> the old name may not work anymore because of the name change. To avoid
> the issue, a symlink should be created from the new name to the old
> name.

What script needs a specific name?

And where in Documentation/ABI/ are you documenting this change and new
symlink?

greg k-h
