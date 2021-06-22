Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE93AFB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFVEFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFVEFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:05:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6ADC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:03:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h4so4458223pgp.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCU0yJ9k9lkuiH4BXOzJ8l7LNMuqUv70T9bND/kl8Tc=;
        b=2IRIENBoxAqdiYLU9/rOfm8louoM9XJGUrNr4bDU2GLRrypkgatHI8hkFkeTbyRLbG
         GT8Nb16qpHMXS+sHckMEspeY/jRj+8I0oJ+xQDQY5gwUOxmGciFsHz3INa2KoN5DLghx
         887kkP0AQGfaUA7l3YlEg0I4iq//vGSCtuiTAZpnAOyBu3j7nNkuE0F3ZHhE1m/ZRszu
         YsdAHz3Cv5q0n9L2hHkLVzqTOCsD3GXOzpOyjxV34rQc12+D55Tva5Rpcj3R7b7qcXn5
         Y1pc9qLwY7Lt6RKJIVyCzGTtxHovj1ReEzkFjNi5lnJ9NA39zpgHg7q+s9topcsVBFe9
         rOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCU0yJ9k9lkuiH4BXOzJ8l7LNMuqUv70T9bND/kl8Tc=;
        b=iZqhhmgXuLJEGsERvyASSKuXf30ZnQQSN91RySYcuCiQgYYoyqWQABe2fp6st3RSLH
         cjX5nkx28N5pfYhAojzkQgyuUVFwwzhs1kivjK9mcfZkHmAHm+sHToAqz2/DK0Qqsd7v
         R0rqPAnt2EXvqyH85dFkDAAltETYdfB0ZIdZGzs+YDmeXXcy7OOSKHed+zLIA7atYdbF
         c5IACK+p4ZLZ8x4GQ92XWSdfhmkQy25n4Xs4ygcGJEDJKZ5QoU3BITy4jLe+FxXVyeKy
         g2SbyacS1ychXO5hpTcZDhiKWI3BDa/AjCR6cCSOm3SUMwU+1+QuBxX8bn6mnBhVdm78
         7PDQ==
X-Gm-Message-State: AOAM532FAqUpk6On2UCa98yBToexmgVzzsfPL8spW9YPSXYujluV/Cyc
        aE3VH/pAg1Vqysb7N1tb/+CVhQ==
X-Google-Smtp-Source: ABdhPJyKj/BVU5tSTB/YxCiCQydfHrVE81rBbCx40oGNuZ57J9fDCnwKUCuoM0Jyxaso51VahEdMJw==
X-Received: by 2002:a05:6a00:1515:b029:2f1:d29:2a44 with SMTP id q21-20020a056a001515b02902f10d292a44mr1605587pfu.51.1624334584489;
        Mon, 21 Jun 2021 21:03:04 -0700 (PDT)
Received: from ?IPv6:240b:10:c9a0:ca00:5192:32ad:e5be:23cd? ([240b:10:c9a0:ca00:5192:32ad:e5be:23cd])
        by smtp.gmail.com with ESMTPSA id x20sm16719962pfh.112.2021.06.21.21.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 21:03:03 -0700 (PDT)
Subject: Re: [PATH 0/4] [RFC] Support virtual DRM
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
References: <20210621062742.26073-1-etom@igel.co.jp>
 <9853d0a9-6053-db64-9c79-40b7e0689eec@suse.de>
From:   Esaki Tomohito <etom@igel.co.jp>
Message-ID: <85593f2f-5aa9-6023-ecba-c5275a468b71@igel.co.jp>
Date:   Tue, 22 Jun 2021 13:02:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9853d0a9-6053-db64-9c79-40b7e0689eec@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas
Thank you for reply.

On 2021/06/21 16:10, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.06.21 um 08:27 schrieb Tomohito Esaki:
>> Virtual DRM splits the overlay planes of a display controller into
>> multiple
>> virtual devices to allow each plane to be accessed by each process.
>>
>> This makes it possible to overlay images output from multiple
>> processes on a
>> display. For example, one process displays the camera image without
>> compositor
>> while another process overlays the UI.
> 
> I briefly looked over your patches. I didn't understand how this is
> different to the functionality of a compositor? Shouldn't this be solved
> in userspace?

I think when latency is important (e.g., AR, VR, for displaying camera
images in IVI systems), there may be use cases where the compositor
cannot be used.
Normally, when the image is passed through the compositor, it is
displayed after 2 VSYNC at most, because the compositor combines the
image with VSYNC synchronization. On the other hand, if we use vDRM, the
image will be displayed at the next VSYNC, so it will be displayed after
1 VSYNC at most.

Also, since the compositor is a single point of failure, we may not want
to make it dependent on it.

Best regards
Tomohito Esaki
