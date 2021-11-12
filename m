Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C733144DFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 02:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhKLBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 20:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhKLBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:37:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E63C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:34:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id o14so7189986plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0YHU5BFJe1UeJmMP6VYLEudXKn26+NeOxTqKcy9fme8=;
        b=LrFnSWp7l4vvRFWqk06cZtwB/ugRwVOpRXHG+uL+eIa85OD3cC5UgUaQ/gbX+IQUgd
         N5j7X456rIqpp28T9y0cSOfeC5OOs1vsm4r9GxHHABLjSIlcZkBpqAEKnOO0fD2iRfU3
         Zi7bZij5unADfaSDgQct4cGhDgHCNsqiDS2Jnh6WDjYPDBrGOBSbCyYVcFc6PhQ/JFZ4
         RoD5uK51PLaQOhc0Udq2fvkh+ZrSztIibqX3r8mcDuuHX0s0A9BR2TySEAW1QbHRSZVy
         WZMSLHskRaYFOr1+ijUTRrVxc80eRJlnLanayATyJyudWGMIa1gLqjepUMCjqT1kxXiZ
         c1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0YHU5BFJe1UeJmMP6VYLEudXKn26+NeOxTqKcy9fme8=;
        b=e86OIJ51V4CbR1j5rrBFKla/Kncwbglpj3h0Abo/viXOTg2waNZ+u7BbGh3BCGyFKQ
         PMyo9uYJR3IVCMzfzWM/gv0qfauQziefj0E8kqgSHk5CUCUxvec9JUCR1MLO7MMqxjSG
         AbGD3E48Y1dpHp5pCCajzcZVdrvXr6FXvkKnEHtspwPD0SnIT3KSrkjRGiDlxKSLoiPA
         ZWn0P384h6ivwXb5p1pb8uAfwZiYWDXnhpIo5Rzrd9S4HMNie903o9MPym2eiBIB/wet
         JFAPpCogzMZAhhpBtrJxI54MIAFALiOs5o3KzhwyS7nmvbP4KJs6gsZrw9OeDdKhca6h
         oNCg==
X-Gm-Message-State: AOAM532RiNWYHbo1vecO1q82iXtKq3AU4lewCl7qtvHmued+V+DWYPlp
        US9x4sxYo3vA28Gvq/xyVI1uNA==
X-Google-Smtp-Source: ABdhPJwCqDn0a2JCQcf42AQVYBrgJG7/UP8bVjVF7dmyhdh/1aO7xtYDLnN93T7YEfSgDiy+x3pAbQ==
X-Received: by 2002:a17:90a:670e:: with SMTP id n14mr13311383pjj.144.1636680856755;
        Thu, 11 Nov 2021 17:34:16 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:3f91:373b:ba9b:471e])
        by smtp.gmail.com with ESMTPSA id nn4sm3367102pjb.38.2021.11.11.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:34:16 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:34:13 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com, acourbot@chromium.org,
        yunfei.dong@mediatek.com, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: mtk-vcodec: Fix an error handling path in
 'asid_allocator_init()'
Message-ID: <YY3ElQfeZr4DpObV@google.com>
References: <86d3e2db237bc35eb55bd46ef07fa13a39bcdff8.1636636541.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d3e2db237bc35eb55bd46ef07fa13a39bcdff8.1636636541.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 02:17:51PM +0100, Christophe JAILLET wrote:
> In case of error the 'media_device_init()' call is not balanced by a
> corresponding 'media_device_cleanup()' call.
> 
> Add it, when needed, as already done in the remove function.
> 
> Fixes: 118add98f80e ("media: mtk-vcodec: vdec: add media device if using stateless api")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The commit title looks incorrect: "asid_allocator_init".

Except that,
Acked-by: Tzung-Bi Shih <tzungbi@google.com>
