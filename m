Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB93E03EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhHDPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHDPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:12:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CD1C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:12:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qk33so4205060ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vo9KH/MhVz7kXBD6l2im9RgAeC2wAwSck49Hn8SWjc=;
        b=PaVIRT7vozP4R+oBv6QR8L8XGHClC2ZebRx/A1tLBc8n5ru4ZdjlSxGDK2J3+cTFcY
         bxZ8OaNKlomp7AU/hnwR3Ee7RkZ3MAoW++Q/HvyDMTArIeZaVz1Ou6zDlLfu1RzQGA+1
         KQuCygKrdaCRdZrlo1l6XBAsclWm3mWdxrZ9scXcYvK6ixhhSsnmQZ51iEOqj3kRwg36
         FWFONcAT2PJWaCnv/KjSgQWImdNksnwPMDcTLy4Ie3aBxN6ZRS2SEVooaIyIvfQs5t1c
         karWD8Xz/sSllhTNua8aU8b2e0VrW6ggfpdcPMNcUvAfZSsAx5GQf2H3fk3T8V4nBcKL
         UNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vo9KH/MhVz7kXBD6l2im9RgAeC2wAwSck49Hn8SWjc=;
        b=H9XoIU7A/RX23RznYkkT6oyQA6oDr8/dpPCaBkJ5jyxXFHEKS8LXDkU7BYmO/ULShU
         1IXg414OhY4QJo+XdxedkbsFckDAUxH0NWbmJ+kYH06GyWXkTD6HZBbYvTaQZj5f/hZ8
         I38k05fiOfIqIPYuWVt1MVzNubwkRhGB67fTZjSXGafIvXJEDppgK54UoJYBHSG4sf2S
         BqXh+2CiexS281mp0ictn3KZ6O1nA8EKi4YlKmnkmahUCRDxLv/H6gVEoCh6vmjEwKr0
         v8cE4W8EDKLvERalQX+uURlo6x777Zjb7ueO0Illt3rc5N4ktUPQf23LcHDqLepD68F+
         T5Sw==
X-Gm-Message-State: AOAM533EfPV7kVC5yiLrmTnwoiL+hcHK7GjIaS/cCHI9nd6YbPq07Xx6
        Y62ilV9DhdDnVmhlae3Bmms=
X-Google-Smtp-Source: ABdhPJyjy5+mIOt6o4mj0inLDL55SGhwPIqkE0njS3o7l1bM/Kc/Zsgvt1x8uJFT9jmMszzaDj/8DQ==
X-Received: by 2002:a17:906:9450:: with SMTP id z16mr26100237ejx.52.1628089932827;
        Wed, 04 Aug 2021 08:12:12 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id r27sm1064548edb.66.2021.08.04.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:12:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
Date:   Wed, 04 Aug 2021 17:12:11 +0200
Message-ID: <5755579.ylQvOfxgKt@localhost.localdomain>
In-Reply-To: <20210804130136.GJ1931@kadam>
References: <20210802005517.12815-1-fmdefrancesco@gmail.com> <20210804130136.GJ1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2021 3:01:36 PM CEST Dan Carpenter wrote:
> On Mon, Aug 02, 2021 at 02:55:17AM +0200, Fabio M. De Francesco wrote:
> > Remove rtw_mfree_all_stainfo() and the only line of code that calls
> > it. This function simply takes a spinlock and iterates over a list
> > with no purpose. That iteration has no side effects.
> 
> I mean, it's pretty clearly supposed to free all the items on the list.
> 
Sorry, I'm not sure to understand what you required:
since rtw_mfree_all_stainfo() is supposed to free all the nodes on the list, 
should a better patch *really* delete those items (instead than simply get rid 
of the function itself)? 

Thanks,

Fabio
> 
> regards,
> dan carpenter




