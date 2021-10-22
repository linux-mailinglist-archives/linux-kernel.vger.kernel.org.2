Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756774379E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhJVPae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:30:34 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48379 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233413AbhJVPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:30:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0BF8F581028;
        Fri, 22 Oct 2021 11:28:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Oct 2021 11:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        bryanbrattlof.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=jm5
        35Za6sh/ySynJN8Vk1XMpgk0ttaD5Sc5KIyeAwPQ=; b=a1omWhWo1sT+IDYU/jO
        GIv46zn8YU0s8oXLnjvMUip+LvFzqdW33UxAatwl+dYIu8lb7MinkPzLC6Khpzu1
        0IpABxSavnxgH1H3gDTdmUS9FZzTTlZx6TBgP7MvmnqfHC04vb1HQ6PUw8GMkqFE
        cq6kVIDgOZaNnd0htE+6djFeOyr8VrIOs8tqp7q7aPm1j/nmyn5NbbV+25YNmnIh
        VL0gzT3ZnGJXMOzq5iTE6NHmUEfZaidPCYR4+rHb74PJaCZVEBhc2OSL9HVHQ4ra
        Cx1nHJpEsjavaC6ucASUUx7ZM2sJnZH4FuN0zZFGynVbxeT2h5BGg6jNpTqjycoJ
        fHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jm535Z
        a6sh/ySynJN8Vk1XMpgk0ttaD5Sc5KIyeAwPQ=; b=ByjeSmQaP2WWIcTbfk0Xm2
        ELXFLDT78IgM0kXEwNJ8KNoD6m8D7nKHpO+cUChwVVh781ZwuYjSrGgkgEyuzsJz
        XRBJ0HUP3lOobx6cTMB7ZrWa6Mobe0/8ZKsMoclkPJvawB+XGNM/ASALZFuHiWFG
        JZa2HLTtDVOEwyU+cFKHvYOnPqlatrzy0Du4HWZBjPiqgl6jnUwZJ8f5WxedQWob
        +poguGtVbORsFdUCdklGE7FjaL9Ek90S+T3KhxVz9r3y3pdLsIgUGtJOIO0HOd03
        8nCkTOYzHLpdIGKYKGRp9x8eIPbhzouoIfUXLEJli3BIPf4r3TDsysoUkSyjYsuQ
        ==
X-ME-Sender: <xms:jthyYUUwPxzGRJX81yXjAr9CfM_MnQq4pZVcTWroL-qHMGX8TZ8WQw>
    <xme:jthyYYmn12kw47e9Y_mNTbjYN5GZeuKgKtoL4a2ku7b7yPWRMuFPZVZIgkdewIKeD
    7WX_WWB8t-ypu9dCSk>
X-ME-Received: <xmr:jthyYYbDAwntvrH0hREK817orT-S6Vas21-YsLGvTNefAxGzEKcC1QYRMQBoOKiOpwFbejI5ltEt2xG8Pgns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeeurhihrghn
    uceurhgrthhtlhhofhcuoehhvghllhhosegsrhihrghnsghrrghtthhlohhfrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevtdelgfefjeduvddvgfefhfeggfdvheejhfdvhfegudev
    gfeitddtjeffkeejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehhvghllhhosegsrhihrghnsghrrghtthhlohhfrdgtohhm
X-ME-Proxy: <xmx:jthyYTUQsPD6uzA0loqM2LzbjhfBe-fSrM14Pss67JwAFiCeSNtKGg>
    <xmx:jthyYelIpswmJ0ezXSJpLhIWLbXmNFlWcTxYRoCeYAXos_3pXWLa0g>
    <xmx:jthyYYf9AE5t7baleMY6akL_hZagsLmF-2heWaKzTC2UYEBZe00RQQ>
    <xmx:jthyYUmpqvIuccOr1x_ctufQNX53llFjsU7PLRk2oBcYs2Hq_GDRk8H4HNo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Oct 2021 11:28:13 -0400 (EDT)
Received: (nullmailer pid 3724631 invoked by uid 1000);
        Fri, 22 Oct 2021 15:28:12 -0000
Date:   Fri, 22 Oct 2021 11:28:12 -0400
From:   Bryan Brattlof <hello@bryanbrattlof.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: Re: [PATCH v3 1/4] staging: rtl8723bs: core: Remove true and false
 comparison
Message-ID: <20211022152812.yv4nicwpzmwggn25@h510>
References: <cover.1634906059.git.kushalkothari285@gmail.com>
 <7d5df4b8aacd961d0de367cbd73a8b75272652a8.1634906059.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d5df4b8aacd961d0de367cbd73a8b75272652a8.1634906059.git.kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kushal,

On this day, October 22, 2021, thus sayeth Kushal Kothari:
> Remove comparison to true and false in if statement.
> Issue found with checkpatch.pl.
> CHECK: Using comparison to true is error prone
> CHECK: Using comparison to false is error prone
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> 
> Changes in v3: Enclose the version number inside the square bracket.
> Changes in v2: Unnecessary parantheses handled in *v2 staging: rtl8723bs: core: Remove unnecessary parentheses*

You may want to move these version notes below the cutoff so they won't 
be included in the body of your commit message. 

> ---

[here]

>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 2624e994513f..acd4e8b1fad5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -371,7 +371,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)

~Bryan
