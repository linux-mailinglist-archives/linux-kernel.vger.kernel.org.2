Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA33EB9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhHMQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHMQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:11:07 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kI1wTCee778iDYy1Ii/vo2V61SYMdoix9gOYtNQpsn4=; b=hUYcoAamCAyzyQ1qkruDkdfLbY
        /FQslO8xIbwv6cR7765Em9WB8VqCa0y2uKTFdhkXIEWjk/raQ/OuzDwVX5L7hg0R8lLwi/48Y3ygO
        efSrjzqqpO1bpPVN7ptgYE+96cEUirFafVz3Ic1vB3mpCC8zOEq01pP60Xc2ByyBAqSVItwNbNyVF
        5vIvoWs8b706wy+1KHkFQOwMsa4Li6x2YmHBemwfTg1M8SORZjclGFABxbjKh9fFzxr8anonFsgjw
        GTOAt9N2JzxZRNX1umTpwsy6CUwp4MAuTiKYm2QRwPpab0Bj6SAHJ64Nd2IwC60uf8JtC5YSVva6u
        u2rmJTFQ==;
Received: from [2a01:79c:cebf:7fb0::17] (port=37626)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1mEZlW-0002MD-C8; Fri, 13 Aug 2021 18:10:38 +0200
Subject: Re: BISECTED: i915 0000:00:02.0: Device initialization failed (-19)
From:   Harald Arnesen <harald@skogtun.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <22257665-f87d-17a6-e67b-5db7688d9c01@skogtun.org>
Message-ID: <3439662b-9d37-0dad-4fb0-ecb2fe353526@skogtun.org>
Date:   Fri, 13 Aug 2021 18:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <22257665-f87d-17a6-e67b-5db7688d9c01@skogtun.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Arnesen [13.08.2021 13:10]:

> Kernel 5.14-rc4 and -rc5 give the following message on boot:
> 
> [    2.533418] i915 0000:00:02.0: Device initialization failed (-19)
> [    2.533472] i915 0000:00:02.0: Please file a bug on drm/i915; see
> https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
> for details.
> 
> And when I suspend the machine, the screen stays dark when resuming.

Seems to have been fixed in HEAD - a bit strange, since the commit still
reverts cleanly.
-- 
Hilsen Harald
