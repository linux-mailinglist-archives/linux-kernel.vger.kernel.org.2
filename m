Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17B370690
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhEAJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 05:18:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589AC06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 02:18:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d4so432086wru.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=cxHTQEn4CMsRRZJNaIEpfxdSAuaxYGXto5pLQbQufGE=;
        b=vRHw82Kea5MncNLB92TKVEk058YJGRACCYsueHhoVPboSQJwaQrPGnbUyEa7ySlQgG
         GbchnOKmlRV98YaL89NPDkKGerG9SvfgvSLBSb7a5uq65evQTYQW0HC97lbFxVAXLqgM
         LoGfGbN85f9/NcTBk4buae24uzmTNGS7xHOSJZeVnreYaxgOcodpipFAqY05kKfVHjk3
         9v+aH4dPiorXt+R6hFgda8ZkanxdgYjDBGzHn+zQ8dk0mjIzIVzck0IAumOjIP+8g07D
         w0nhKmQjkfSc8U1iOuuVh0R+UWcqMF/vuN0XwUnEc8oMOJ9U7MeY/WBIu8TGAjplbRy1
         hwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=cxHTQEn4CMsRRZJNaIEpfxdSAuaxYGXto5pLQbQufGE=;
        b=bAkwMBTxTPcyRO97vqjluSBCoXznawBeMoDSaRqHbTh6M9SsIJeDzX6IZDmLQ/FzGP
         y+si/OvFjiYvB0oCUHpJit6tepduhIbHqCNqnuGLYSPk4jRPHnoOUKSDm/+NtSAPfv6C
         BPq1U2sGmcy9JqYdfrIG8yYzh2fiQRQEnk9qTUSVqAvH/m/FJ5SCrNQux15hww8rnVmk
         ICgpxjOJo9Af3O/U2B8kkcaBtIPrLD+3d+KFVA+CP8XNiCQnIqShonNS29+KQHz+eZay
         iOILt3UX5wU8Uq+Z2YtLovvGnUxsYB/aSt4Bu6y+p/hibGz2BvyF0QJrGDn+b0Kc9Ps9
         s2Ug==
X-Gm-Message-State: AOAM53253jgwx/wO+zfc79p2B80uEb+Q8bOwPbrHtzB5w4fWqEk6GT2b
        EFZ/4xbkLnIktykLYGb8G2ZPcQ==
X-Google-Smtp-Source: ABdhPJyx+Zk3GjYruvL28LxuKpwgcHeMfokdODi8yIgFZ9W9ZAy/D0ULBvGdKXqhAL+0/HVpORKHTQ==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr13092536wrq.102.1619860686837;
        Sat, 01 May 2021 02:18:06 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g11sm4898095wri.59.2021.05.01.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 02:18:06 -0700 (PDT)
Date:   Sat, 1 May 2021 10:18:04 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo
 memory correctly
Message-ID: <YI0czH0auvWlU8bA@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412073837.1686-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry to be pushy (I know everyone is busy) but I've had no feedback on
this patch yet:
https://lore.kernel.org/linux-ext4/20210412073837.1686-1-phil@philpotter.co.uk/T/#u

Could I please ask for it to be reviewed? Many thanks.

Regards,
Phil Potter
