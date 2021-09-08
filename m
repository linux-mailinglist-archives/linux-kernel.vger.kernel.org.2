Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F654038B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351384AbhIHL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbhIHL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:28:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720AC061575;
        Wed,  8 Sep 2021 04:27:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m4so2886575ljq.8;
        Wed, 08 Sep 2021 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zArPnbgBGxH5qbqpeK2J30GwRdILfZEvn45KQmNxalo=;
        b=UMfQnx4bcQZd5SvTOkMpm6L/1WKlh7Eork9Id05e5fk/8402XhpLqn/zQMTVXqAB6I
         HkFbGZwgYdA6BQ/mbAhqEe/4NOEe7e++lsWUE2NQpo3+zwvSSHmXvScg865STNrCrp+G
         zvpXoSMGxXiB9sjQXVL//9Xvunon1w700gEDOaO9YUOsYeP2t7+simHTn2emLSnfDlJu
         W8yPjGOIVO4hAIUbTfaDgjPgzJaVIlPVGp94GGVLeMoxPL+JgcpZwL52x8r9lBfixozQ
         FiZVcPHKK2D9tynhO3/izirk4gJ+wOQXeKSkw9KD2kRE5asdq4VFLI4eETuAAGxEzmFU
         cwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zArPnbgBGxH5qbqpeK2J30GwRdILfZEvn45KQmNxalo=;
        b=W1Z8OAuI73yWAdEeIEZJ6MOMDtozhLpgxxMFhsSPEFTyih8swed5qNN/gN4eQQwoSr
         fWyDqAeOmwCGI+9/fj2k8xRRS3pnt8PXEjtk+HhEk3V+kKkRKzIWGO/NhgBwSpgd91Xc
         Ngy17sAPShtQzRzN68Aaztg/JcA/q47bsx0/RchHUe9KhBdQ8KEmZV+Q57k9dtfgbp/A
         N9yd392JjkKVTRhH3tzBLYfspp1WH5yJ8KFOOpyRfeJPfInqpc4/ohQ7Xj8VtU8mdhCg
         eiQAsIAPMpUYZ9sUb1eUh3Ix/ePAzWiad9Uq4MNrkD52QhuJwZVjloCY7T9lhibFg3ul
         s7xg==
X-Gm-Message-State: AOAM532aqS5cC81AuPI9mAkDBBBB4IRGrPAEQa26n///o/0yvmADPRQk
        rk40acZX1xW5rHZi5JM4wPo=
X-Google-Smtp-Source: ABdhPJy8Hv43+g0NY1Pmxc4LeynlznWNToK9X9xFqmpQtYjskjVO7X1CS7pVbBBfoRlxdo+/v3iHfA==
X-Received: by 2002:a05:651c:154b:: with SMTP id y11mr2243226ljp.480.1631100430110;
        Wed, 08 Sep 2021 04:27:10 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id a23sm204070ljb.95.2021.09.08.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:27:09 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 188BR67i015807;
        Wed, 8 Sep 2021 14:27:07 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 188BR4Rh015806;
        Wed, 8 Sep 2021 14:27:04 +0300
Date:   Wed, 8 Sep 2021 14:27:04 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "osk@google.com" <osk@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: Re: VUART compatibility (was: Re: [PATCH v2 0/3] arm: aspeed: Add
 UART routing support)
Message-ID: <20210908112703.GC23326@home.paul.comp>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210908094248.GZ23326@home.paul.comp>
 <HK0PR06MB3779180F75DB8BD872F8A78391D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <20210908105245.GB23326@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908105245.GB23326@home.paul.comp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 01:52:45PM +0300, Paul Fertser wrote:
> In this case do we have some way to make it an obvious error to enable
> both SUART1 and VUART in DTS? If they're conflicting surely there
> should be a way to express that?

I have to add this idea is obviously silly as we have sysfs nodes to
specify both LPC I/O address and interrupt number for VUART and
arbitrary numbers are allowed (so it can conflict with any of the
SUART port) so there should be probably some runtime checking in VUART
driver to prevent that?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
