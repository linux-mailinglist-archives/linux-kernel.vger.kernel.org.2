Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26FB324F55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhBYLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:41:46 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51701 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232616AbhBYLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:41:43 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 729E9EC1;
        Thu, 25 Feb 2021 06:40:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Feb 2021 06:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kxxVIGD5z7OcPn4Jkx9tSRN0Waf
        8199Uq/w5oSJ2mXI=; b=GsLnkeKAbBpLPcxtYXHBFmSZxazwIm/lpmrrxpED9PE
        mDPEL/1M4XLCCj8W8omAiahdigaWFQkN/kYO+jRlOfQ0Nem1HaWYQTyj/Pm8zvQT
        MjNeuHfpPawHEfe4pQTEb12bbp9xYSzpOZyUMsjZVWIIB3VUY0YzaQ3SvbSUAveL
        areDKZQs0Cx6eyQJoMKkzT2hvX7OmPUF6Pd2v4bpdVkKDV+sUtV+5Tj1yesNJwCu
        hffcZcCtpdbRBNSgD8D1yOVy9pFVAtdXZncQ0UAN63dKRMlHLfxsig7WUlfyM5t7
        8EZ/U/63Ua2OS1ko/T0pp5MhujePej1pVdAIKk/A0+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kxxVIG
        D5z7OcPn4Jkx9tSRN0Waf8199Uq/w5oSJ2mXI=; b=Ju6FrBpeF09eIOl5CTuQF9
        YvghX5b7ejOIhq8Hv8uRMFhiPZxLIKR03seK+pnnztG6M81z2E1Zvmtbf5ycbYpq
        CmQa06184XOT0Kv4NgJbteDw4aU9Ez5M0wM8+lhMatcZJUS2qxQBpRTBfd4n4fsB
        qBY1bwpQYfK9eRigXUFXZ38UdY3BzVDr3p+tzaHO89ycUItiEe4QMBJE5bvi7Ro2
        eChbGVg7LAnaQUM+331eIQ/zUzB6p+y+J7cFqgQVYwJyK6RjgideKGcPZ+unpMgT
        VQDJgpB3NsiIDBlRmEE9QMXZal7GijJ89GmX8mJRceUR3RrI+chjZBeYYHCUlGjg
        ==
X-ME-Sender: <xms:tIw3YNf8Zz3TEpBgBgl2ptQt3RdrMXXjLfRcVrnRuS-LzC7AGTUp5w>
    <xme:tIw3YLPtmWIw1bOvA2MPreAFShW0WG5-NUoY0QFsruXT1hZTqMtxHmgmU5PgXFCy7
    74Cf9csfgMpKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeelgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:tIw3YGhffZkQDneu9QnWpaFUzTj5zmyL-ycN6gVlnt1JV3yFKoXBGA>
    <xmx:tIw3YG973Ga7qkbOr8etxDVXUGPGN42qKMiCCDBbY8XiF5dAkDlGIg>
    <xmx:tIw3YJsMXisIP42v8OolyGidpBTYn1jBqfQ0ubZpD0c9zGqP1bEzTQ>
    <xmx:tYw3YKXldxan8FYaXjDOnSC69OEuXuIwKqfvkbvyC0BgpLBnk0F5Hg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id D283224005A;
        Thu, 25 Feb 2021 06:40:35 -0500 (EST)
Date:   Thu, 25 Feb 2021 12:40:33 +0100
From:   Greg KH <greg@kroah.com>
To:     "Lan Zheng (lanzheng)" <lanzheng@cisco.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] Kernel Config to make randomize_va_space
 read-only.
Message-ID: <YDeMsX6sScUk9D+F@kroah.com>
References: <FA94F19F-2AB2-4983-8CEC-D89287D91E20@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA94F19F-2AB2-4983-8CEC-D89287D91E20@cisco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:42:28AM +0000, Lan Zheng (lanzheng) wrote:
> From ba2ec52f170a8e69d6c44238bb578f9518a7e3b7 Mon Sep 17 00:00:00 2001
> From: lanzheng <lanzheng@cisco.com>
> Date: Tue, 23 Feb 2021 22:49:34 -0500

Why is this here?

> Subject: [PATCH] This patch adds a kernel build config knob that disallows
>  changes to the sysctl variable randomize_va_space.It makes harder for
>  attacker to disable ASLR and reduces security risks.

I think you need to read the documentation for how to write a good
changelog text.

>  
> Signed-off-by: lanzheng <lanzheng@cisco.com>
> Reviewed-by: Yongkui Han <yonhan@cisco.com>
> Tested-by: Nirmala Arumugam <niarumug@cisco.com>
> ---
>  kernel/sysctl.c  | 4 ++++
>  security/Kconfig | 8 ++++++++
>  2 files changed, 12 insertions(+)
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c9fbdd848138..2aa9bc8044c7 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2426,7 +2426,11 @@ static struct ctl_table kern_table[] = {
>                 .procname       = "randomize_va_space",
>                 .data           = &randomize_va_space,
>                 .maxlen         = sizeof(int),
> +#if defined(CONFIG_RANDOMIZE_VA_SPACE_READONLY)
> +               .mode           = 0444,
> +#else
>                 .mode           = 0644,
> +#endif
>                 .proc_handler   = proc_dointvec,
>         },
>  #endif
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..18b9dff4648c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -7,6 +7,14 @@ menu "Security options"
>  
>  source "security/keys/Kconfig"
>  
> +config RANDOMIZE_VA_SPACE_READONLY
> +       bool "Disallow change of randomize_va_space"
> +       default y

This should only be "default y" if you can not boot here without this
option.

But why is this even needed to be an option at all?  What is causing
this to be turned off?  Can't you keep this from being changed by root
through other means today?

thanks,

greg k-h
