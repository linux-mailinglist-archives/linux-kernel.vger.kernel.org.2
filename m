Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA5341530
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhCSF4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhCSF4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:56:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:56:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l123so5132845pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ui3LySULBuKiojtRllsmRcBVTY67VAwtMudpXnLR7XU=;
        b=d8gSPdiwbvxkbSj9YilRP/8ejWX1TLftSijJ7kGUHZCyOE1tzSIMTGldk/IcwZyB2V
         nwm3wgItJG0Igj0Z+SfB7WCRV19tTWJZTCJAylr4swBKpaYe6yI4LECm5anqkhQOzCGy
         ikyQCwfCO5+1m5YmaJFzJhO+LRBzkVvZi9Q/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ui3LySULBuKiojtRllsmRcBVTY67VAwtMudpXnLR7XU=;
        b=ZvcELRyQhGVU425smKmC+KI02auqg0KiSA+Rg0vxj9sPJa2gDaq0vcC05vp0YbRFH7
         BKTH4ssDtH7n8eDZWLD22UAaO2gVXQ4YyhYvhTSmNZsiPkHK2mAP+9+wj355oYXlzGmV
         tN97LmYhTGfDeg5lxuMWkH9guJ4h1PM5wc1jZ4Z+V0xJ3np+oanzn5L0fxfWkQqHMXAD
         MnbcW5jve0F0bTT/1rtmc94wAxXbaIv4XRltSMEVkGAznui8PCdOlYYL5PWYQdmaVWBy
         WisvmvqC/b3mROAlcokXhEKTwsDtS790BrnBN80X9/MIz71gMSyXBoiy9h/+Kbs/jDkH
         F1uA==
X-Gm-Message-State: AOAM5314aAjcynS59kKa4E+fpNsu6oM0V0EqqtYGz2qs0r3zijHCZgD5
        cr7iBWB9y8KQ7lX+zDeeB4C5ng==
X-Google-Smtp-Source: ABdhPJxuf90j/C6EY2q2cEayhoVSeTP0uFLIFOlTlnjJEb/Ut6mKtFJkasHTKBu6UQexhwKX6wC+Ng==
X-Received: by 2002:a63:1021:: with SMTP id f33mr10040150pgl.409.1616133386909;
        Thu, 18 Mar 2021 22:56:26 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id t19sm3411930pfg.38.2021.03.18.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:56:26 -0700 (PDT)
Date:   Fri, 19 Mar 2021 14:56:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv3 6/6] MAINTAINERS: update Senozhatsky email address
Message-ID: <YFQ9BnHxJU9p4Nl3@google.com>
References: <20210319055342.127308-1-senozhatsky@chromium.org>
 <20210319055342.127308-7-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319055342.127308-7-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/19 14:53), Sergey Senozhatsky wrote:
> 
> I don't check my @gmail.com addresses often enough these days.
> 

Please ignore this one. It's a different story and does not belong
to this series.

	-ss
