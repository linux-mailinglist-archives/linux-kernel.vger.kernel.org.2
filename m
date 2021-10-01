Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D841F261
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355264AbhJAQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhJAQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:45:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC82C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:43:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q81so9762445qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZkHivh3bEbZLhMTq7Ut+NDmzS9gwp+oTkR/9YPzzJdY=;
        b=qgS6vyKL6kLFNLZNWng76Wz1ZCgI5yCPY1ptM5FkCkkzeKR9bCcYZrmKYSyLG6zXnS
         5A6XyBlZo2yhX1Rwh6ZWvX3ETOVpFxY3G1i4IGuC/VXfO3XD2pIeyubl7Mc1PSNPBKpf
         RoS6nDFT5/q2zTAod+VGZM1N+docYgtPmtd6mlTBSsi5TNX4EVmMHzcGQS/jS7zrAA/J
         vwestgWBaoTJIwneEQMOv8NQQrrJZ3aosIAC69Hy6zmR6rCgeOUCpxEA849NBuL/yE0p
         XZrKmoAtu3QDNYRqKWAZQib+wTT48yfeQZyBur79kF+z77EKBZD/KBxkyH/T93wEg3py
         MuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZkHivh3bEbZLhMTq7Ut+NDmzS9gwp+oTkR/9YPzzJdY=;
        b=cCM5o7t2wQRIUlGS9kXBFZ8kCGvtz1RiHQSf1/6/1u5gFbxwt9ZiRTeYj/dgmWnbVK
         IP9bnJP1TDx8OYC1/2SPqSqN9dSf87sWHt1tVuGClHGSezqJFeVVnnSMWYa6l5JP5AhZ
         QF4U5r8qnykLkFsRFNMPPQIWDqiE2RSvREsODksOe//TOrOYaXLbwU8uEh7ptVKAJidV
         0J8jZuMjTQkShUSMVyXbDkq5JcrUnU5nSm0lt4LlCsBoFaCXHzOKfP+aN7llr3tqWsFN
         Xt2nIYc4p4+55Eodaxu2dCTCbkX9G3bGvXE4Qk4ZivpvQRMXeAueU+1V1mazu7hHmiHp
         QEMg==
X-Gm-Message-State: AOAM5328dsG/uU8VNjVQpYOToqwffSnozeeItJokey3XpnA5PseyZUP1
        NpMNt3c+TQYVC6XiTPDg6TNbdQ==
X-Google-Smtp-Source: ABdhPJx9jAT1FbSD62wMql0yoUa1KdOwj8mED7wKfNAaarrNlESlHbQmkdDPUmEyIS3rHawgOy42OQ==
X-Received: by 2002:a37:9f88:: with SMTP id i130mr10230773qke.478.1633106638551;
        Fri, 01 Oct 2021 09:43:58 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id z19sm3544192qts.96.2021.10.01.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 09:43:57 -0700 (PDT)
Date:   Fri, 1 Oct 2021 12:43:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     =?utf-8?B?6KejIOWSj+aihQ==?= <yongmeixie@hotmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOnZt?=
 =?utf-8?Q?scan=3A_fix_extra_adjustmen?= =?utf-8?Q?t?= for lruvec's
 nonresident_age in case of reactivation
Message-ID: <YVc6zOy51aaRgw2y@cmpxchg.org>
References: <TYCP286MB1108D012DA436CA72029ACA7C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
 <YUnwsyE87TViMNMz@cmpxchg.org>
 <TYYP286MB11150330E283CC23CB16E40CC5A29@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYP286MB11150330E283CC23CB16E40CC5A29@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:27:24PM +0000, 解 咏梅 wrote:
> But now, move_pages_to_lru didn't increase nonresident age for active rotation.
> Back toinactive age, VM ONLY care about the pages left inactive lru, AKA activation and reclaiming.
> Anyway reactivation is rare case, so whatever it contributes to nonresident age or not is ok to me.
> 
> But I am interested the logic how to guess the pages will be referenced again in the future.
> If active reactivation does matter to nonresident age. why not active rotation? But, currently it doesn't.

Can you point me to the code you're referring to? Looking at
move_pages_to_lru(), any pages with PageActive() set count toward the
non-resident age. That means activations from the inactive list, as
well as rotations on the active list, increase the nonresident age.

As to your question which one is right: the original workingset patch
was wrong not to count activations and reactivations. If we see a page
referenced in memory, it means it's hotter than the page that's not
refaulting -> nonresident age increses.

So the code as it is now looks correct to me.

Thanks
