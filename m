Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84C13F7160
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhHYJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbhHYJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:02:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE1C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:01:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c12so42397177ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=siiAMXMnOcYcUixi7P4UWut0ajuzZ/rlLvDcwhpsVN8=;
        b=T6W/S409kDF6euOFXYcn3jMOb11oSOhlNLY4877KSMn90D4JXqi9GCL4JEFrpU0Gh9
         UmistuDMNEXqklFJEN7XFS+/7vVT2m1EQlXJkPMDbgS76rmr2TiUCAkTaE0gWmc7/Y1e
         FXngZdcIy+PgEPmaCEgXs/LBcrUkHr2vFb3X2Qo+UdekMtBmzD8t01otcFUcJFr9FRVv
         UVrSb2Q3Q8cRhMg8kWlKT85lAT55+R73G1KxtExfEzkR+2e6f07W3hn1BoSgVPHUGLpa
         pJZdlSS01UEaw9JKcNg25zPk0DqulAYHiOBgURq1wiYJd69NCjKRWlFAxU3fmtFWqpUt
         8jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=siiAMXMnOcYcUixi7P4UWut0ajuzZ/rlLvDcwhpsVN8=;
        b=gfv1mbISJw+CWVjGzFTIrWGYEv+FPuYfIavjO+S++hk6L+iZxkWqpFEi96UzAugMuF
         TFy9MR4j9rYsurJBj1qXkv8Y9QAKxZtfXJIkBZJmuftM8STV2l6Bmx0+EDisceP1OqUN
         M3AeQ584WF1TCe5r4l2kSbX299dFUPJ71JB4tvHldIq3UU3wKGjdhDdA0s4wNywnnjG9
         3ww1Cn8K1mGhQ92lGLEUxNdG/rR1rj777LDVjmzQi4Or6TvGdt5APtXK+gqKKtrWkkKL
         TGp4vZBbksL53KkBlL43pxd0lGiOBBNe92BLwO41K3XPAg7xMbtrzwimhETY1++OGBdu
         5YcQ==
X-Gm-Message-State: AOAM530SVOK2jeijpM5NsPSlM3JIlpo4q965AQrhT/v0QPaI2Oh4b4k4
        iOwbzGkxKY+Czzr5qhWA/H8=
X-Google-Smtp-Source: ABdhPJwL6f9fMVll4vj4mAOF4Emm4RvgSlHl+++4R7LihmHN5mJX2b85jvac0GP219gpveQWOwnWEg==
X-Received: by 2002:a05:651c:1af:: with SMTP id c15mr12593575ljn.194.1629882075304;
        Wed, 25 Aug 2021 02:01:15 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d6sm2005094lfi.57.2021.08.25.02.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 02:01:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com>
 <20210825035311.8910-2-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <d1b3c63a-1dcb-72c1-451b-dcca5ea9b128@gmail.com>
Date:   Wed, 25 Aug 2021 12:01:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825035311.8910-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 6:53 AM, Fabio M. De Francesco wrote:
> Replace usb_control_msg() with the new usb_control_msg_recv() and
> usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> Remove no more needed variables. Move out of an if-else block
> some code that it is no more dependent on status < 0. Remove
> redundant code depending on status > 0 or status == len.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>


I cannot review the second one, since it's not applicable on top of 
staging-next :)




With regards,
Pavel Skripkin
