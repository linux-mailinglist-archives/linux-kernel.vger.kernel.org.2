Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF63249C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhBYEdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBYEdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:33:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:32:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u12so2542602pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksjOCtJ0nuu5aqjShvr266w7TXx5g4TaGEaQoeTbXfo=;
        b=ip4GM9wxAb9xv375Nqpbu1+mSvZw2nCzmYBxVyqCJXSx0HEbk1bCThuCIXdwzIJlB3
         PsOnD71/w9p7LkOKrskeYQCM5m1n8IXa7n5erFZ2HwdhNCv/DZZVoC59GwvYHKyLoq0P
         NvJltsXOGhy1FXlpbwVQrUGVWx6xzKB6PqCyS9IK6XGm7eWPotUMQafT7R0aZKw8JXzA
         wuBz0cxWznshnnNuEGj1zwuqREAkQC56RNzxMm11M0685r80nx0Rr7noxzFKXXvVX8m4
         wQYg+pXz9B0lPmt7ARZUQDewhrkXshAzHIeruNTAgXJIApUCixVLrYJaH7ba23B+Zk0m
         b8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksjOCtJ0nuu5aqjShvr266w7TXx5g4TaGEaQoeTbXfo=;
        b=qa1w0m9JZT93sWJnQ5GQBb7Rb3bxzvAzCBaufwFxyv7lWrz1cn0z2KBSbTnJCc+Zca
         yql/CUBOuxbBOLLjM9xCiKa1Zly4zIhcS8m6NS+88CPadv4UcnpVKlq8MpCqBZ8I8E0p
         574E/GGk5gSnDRAr5q5uWwhINiI+uIjAUPe3cq5Hhj6UEFhaQebvbHpV8o1V5XHW/Ezb
         jFd/e2tOAPzl3unYkQvbNNTJ3UYnUteGEqJwhxWWFkavrf6LrjLeUtcgPfAblXet9WGG
         aJu2ZSosR7Fyfe9Y6k1vZhCnyu9iOC3H5fAhsuxSCI5vaz8RjgMPPosFS9UMWeXfVfio
         WwFQ==
X-Gm-Message-State: AOAM533Q9Z0+YqpkOd2zvmrsRiKV8CqfwCpu7pxh80sudp76zrmvcnra
        G2aQDjRFZegcxbcYFAoBmZM=
X-Google-Smtp-Source: ABdhPJyPwVMcqUaFUrEW3dUmCarbud+mGcEnTBHX8+oDBeJeF3sugARwq0y2DK88gTOvxadtZ9wh4w==
X-Received: by 2002:a17:90a:7e0a:: with SMTP id i10mr1354443pjl.152.1614227577882;
        Wed, 24 Feb 2021 20:32:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:552:720f:2933:5745])
        by smtp.gmail.com with ESMTPSA id z16sm3978894pgj.51.2021.02.24.20.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 20:32:56 -0800 (PST)
Date:   Wed, 24 Feb 2021 20:32:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chris Ye <lzye@google.com>
Cc:     Chris Ye <linzhao.ye@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] Input: Add "Share" button to Microsoft Xbox One
 controller.
Message-ID: <YDcoduCkBjC8EM3F@google.com>
References: <20210225040032.684590-1-lzye@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225040032.684590-1-lzye@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Feb 25, 2021 at 04:00:32AM +0000, Chris Ye wrote:
> Add "Share" button input capability and input event mapping for
> Microsoft Xbox One controller.
> Fixed Microsoft Xbox One controller share button not working under USB
> connection.
> 
> Signed-off-by: Chris Ye <lzye@google.com>
> ---
>  drivers/input/joystick/xpad.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 9f0d07dcbf06..08c3e93ccb2f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -368,6 +368,14 @@ static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
>  	-1
>  };
>  
> +static const signed short xpad_xboxone_btn[] = {
> +	/* buttons for xbox one controller */
> +	BTN_TL, BTN_TR,		/* Button LB/RB */
> +	BTN_MODE,		/* The big X button */
> +	KEY_RECORD,		/* The share button */

If I understand this correctly, not all Xbox One controllers have this
new key. Is it possible to determine if it is present and only set
capability for controllers that actually have it?

Also, I am unsure if KEY_RECORD is the best keycode for this. It might,
but does your controller supports bluetooth? What HID usage code does it
send for this key?

Thanks.

-- 
Dmitry
